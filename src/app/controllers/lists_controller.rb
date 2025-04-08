class ListsController < ApplicationController
  load_and_authorize_resource

  def new
    @list = List.new

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "lists_container",
          Lists::NewListComponent.new(list: @list, current_user:)
        )
      end

      format.html do
        render Lists::NewListComponent.new(list: @list, current_user:), layout: false
      end
    end
  end

  def create
    @list = current_user.owned_lists.new(list_params)
    authorize! :create, @list

    if @list.save
      lists = current_user.available_lists.order(updated_at: :desc)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "lists_view",
            Dashboard::ListsView.new(lists:, params:)
          )
        end
        format.html { redirect_to lists_path }
      end
    else
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def edit
    render Lists::EditableListComponent.new(list: @list), layout: false
  end

  def show
    render Lists::ListComponent.new(list: @list), layout: false
  end

  def update
    if @list.update(list_params)
      Rails.logger.info("List #{@list.id} updated successfully.")
    else
      Rails.logger.warn("Failed to update List #{@list.id}.")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          view_context.dom_id(@list),
          Lists::ListComponent.new(list: @list)
        )
      end

      format.html { redirect_back fallback_location: user_lists_path }
    end
  end

  def destroy
    if @list.destroy
      Rails.logger.info("List #{@list.id} destroyed successfully.")
    else
      Rails.logger.warn("Failed to destroy List #{@list.id}.")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(view_context.dom_id(@list))
      end

      format.html { redirect_back fallback_location: user_lists_path, notice: "List deleted successfully." }
    end
  end

  def share
    @list = List.find(params[:id])
    authorize! :update, @list

    render Lists::ShareFormComponent.new(list: @list), layout: false
  end

  def share_submit
    @list = List.find(params[:id])
    authorize! :update, @list

    email = params[:email].to_s.strip.downcase
    user = User.find_by(email:)
    @share_error = if email.blank?
                     "Email cannot be blank."
                   elsif user.nil?
                     "User is not registered, you can only share lists with other registered users."
                   elsif user == current_user
                     "You cannot share the list with yourself."
                   elsif @list.shared_with?(user)
                     "List already shared with #{user.email}."
                   end

    @list.list_shares.create!(user:) if @share_error.nil?

    render turbo_stream: turbo_stream.replace(
      "share_form_#{@list.id}",
      Lists::ShareFormComponent.new(list: @list, error: @share_error)
    )
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end
