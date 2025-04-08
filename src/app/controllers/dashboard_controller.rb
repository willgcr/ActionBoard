class DashboardController < ApplicationController
  def index
    render Dashboard::IndexView.new
  end

  def lists
    lists = List.accessible_by(current_ability).order(updated_at: :desc)

    case params[:filter]
      when "owned"
        lists = current_user.owned_lists
      when "shared"
        lists = current_user.shared_lists
      else
        lists = current_user.available_lists
    end

    lists = lists.order(updated_at: :desc)
    render Dashboard::ListsView.new(lists:, params:)
  end

  def tasks
    tasks = Task.includes(:list).accessible_by(current_ability).order(updated_at: :desc)

    case params[:status]
      when "pending"
        tasks = tasks.where(completed: false)
      when "completed"
        tasks = tasks.where(completed: true)
    end

    render Dashboard::TasksView.new(tasks:, params:)
  end
end
