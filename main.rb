# Exercise 6

class LaunchDiscussionWorkflow

  def initialize(discussion)
    @discussion = discussion
  end

  # Expects @participants array to be filled with User objects
  def run
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

end

class Participants 

  def initialize(participants_email_string, participants)
    @participants_email_string = participants_email_string
    @participants = participants
    participants = []
  end
  
  def generate_participant_users_from_email_string
    return if @participants_email_string.blank?
    @participants_email_string.split.uniq.map do |email_address|
      User.create(email: email_address.downcase, password: Devise.friendly_token)
    end
  end
  # ...
end


discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
participants = "fake1@example.com\nfake2@example.com\nfake3@example.com"

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
workflow.generate_participant_users_from_email_string
workflow.run