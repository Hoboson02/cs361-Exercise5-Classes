@Test
def test_participants_properly_fills
  participants_email_string = "test@email.com\test2@email.com"
  participants = Participants.new(participants_email_string)
  participants.generate_participant_users_from_email_string

end
