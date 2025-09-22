class PendingInvitationsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
      Invitation.expired.delete_all
  end
end
