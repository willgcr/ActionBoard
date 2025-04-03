class TestJob < ApplicationJob
  queue_as :actionboard_default

  def perform
    puts("test job!")
  end
end
