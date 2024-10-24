class StoreNotificationJob < ApplicationJob
  queue_as :default

  def perform(store)
    puts "A new store '#{store.name}' has been added."
  end
end
