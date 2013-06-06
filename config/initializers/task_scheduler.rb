scheduler = Rufus::Scheduler.start_new

scheduler.every("8h") do
   Application.update_all_statuses
end
