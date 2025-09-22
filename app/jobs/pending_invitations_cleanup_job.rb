class PendingInvitationsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if Invitation.username.nil?
      Invitation.expired.delete_all
    end
  end
end
