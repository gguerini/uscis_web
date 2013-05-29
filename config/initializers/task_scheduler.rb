scheduler = Rufus::Scheduler.start_new

scheduler.every("1m") do
   Application.update_all_statuses
end
