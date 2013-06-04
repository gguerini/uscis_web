class StatusUpdateWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(application_id)
    app = Application.find(application_id)
    app.update_current_step
  end
end
