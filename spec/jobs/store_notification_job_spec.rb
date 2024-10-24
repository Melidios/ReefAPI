require 'rails_helper'

RSpec.describe StoreNotificationJob, type: :job do
  let(:store) { create(:store, name: 'New Store') }

  before do
    ActiveJob::Base.queue_adapter = :test
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe '#perform_later' do
    it 'queues the job' do
      expect {
        StoreNotificationJob.perform_later(store)
      }.to have_enqueued_job(StoreNotificationJob).with(store)
    end

    it 'is in the default queue' do
      StoreNotificationJob.perform_later(store)
      expect(enqueued_jobs.last[:queue]).to eq('default')
    end
  end

  describe '#perform' do
    it 'executes the job and performs the notification logic' do
       expect {
        StoreNotificationJob.perform_now(store)
      }.to output("A new store 'New Store' has been added.\n").to_stdout
    end
  end
end
