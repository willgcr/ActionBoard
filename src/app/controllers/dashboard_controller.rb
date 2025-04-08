class DashboardController < ApplicationController
  def index
    user = current_user
    accessible_lists = user.available_lists
    tasks = user.all_accessible_tasks

    recent_tasks = accessible_lists.order(updated_at: :desc).limit(3)

    render Dashboard::IndexView.new(
      current_user: user,
      total_tasks: tasks.count,
      total_lists: user.owned_lists.count,
      completed_tasks: tasks.completed.count,
      pending_tasks: tasks.pending.count,
      collaborating_lists: user.shared_lists.count,
      recent_tasks: recent_tasks
    )
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
