class Dashboard::IndexView < ApplicationView
  def initialize(current_user:, total_tasks:, total_lists:, completed_tasks:, pending_tasks:, collaborating_lists:, recent_tasks:)
    @current_user = current_user
    @total_tasks = total_tasks
    @total_lists = total_lists
    @completed_tasks = completed_tasks
    @pending_tasks = pending_tasks
    @collaborating_lists = collaborating_lists
    @recent_tasks = recent_tasks
    super()
  end

  def view_template
    div(class: "flex flex-col w-full max-w-7xl mx-auto gap-6 p-6 sm:p-10") do
      h1(class: "text-2xl sm:text-3xl font-bold text-gray-800 text-center") { greeting }
      p(class: "text-md text-gray-500 mt-2 font-bold text-center") { "You are logged in as #{current_user.email}" }

      div(class: "h-1 w-1/3 mx-auto bg-gradient-to-r from-indigo-200 via-purple-200 to-pink-200 rounded") {}

      div(class: "grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mt-4") do
        recent_activity_card
        stat_card("Total Tasks", @total_tasks)
        stat_card("My Lists", @total_lists)
        stat_card("Completed Tasks", @completed_tasks)
        stat_card("Pending Tasks", @pending_tasks)
        stat_card("Collaborating in", "#{@collaborating_lists} Lists")
      end
    end
  end

  private

  attr_reader :current_user, :recent_tasks

  def greeting
    hour = Time.zone.now.hour
    case hour
    when 5..11 then "Good Morning ☀️"
    when 12..17 then "Good Afternoon 🌤️"
    when 18..21 then "Good Evening 🌇"
    else "Welcome Back 🌙"
    end
  end

  def stat_card(title, value)
    div(class: "bg-white border border-gray-200 rounded-lg p-4 shadow-sm hover:shadow-md hover:cursor-pointer transition flex flex-col justify-center items-center text-center min-h-[110px]") do
      span(class: "text-md text-gray-500") { title }
      div(class: "text-3xl font-bold text-gray-800 mt-1") { value.to_s }
    end
  end

  def recent_activity_card
    div(class: "bg-white border border-gray-200 rounded-lg p-4 shadow-sm hover:shadow-md transition col-span-1") do
      h2(class: "text-lg font-semibold text-gray-700 mb-2") { "Recent Activity" }
      if recent_tasks.any?
        ul(class: "space-y-2 text-sm text-gray-600") do
          recent_tasks.each do |task|
            li(class: "flex flex-col") do
              span(class: "font-medium text-gray-800 truncate") { task.title }
              span(class: "text-xs text-gray-500") {
                "Updated #{time_ago_in_words(task.updated_at)} ago in #{task.title}"
              }
            end
          end
        end
      else
        p(class: "text-sm text-gray-400") { "No recent activity." }
      end
    end
  end
end