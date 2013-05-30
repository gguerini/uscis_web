scheduler = Rufus::Scheduler.start_new

scheduler.every("1h") do
   Application.update_all_statuses
end
