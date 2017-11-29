require 'httparty'
require 'json'
require_relative "roadmap"

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email,password)
    @email = email
    @password = password
    @post_response = Kele.post("/sessions", body: {email: email, password: password}).parsed_response["auth_token"]
  end

  def get_me
    response = JSON.parse(Kele.get("/users/me", headers: { "authorization" => @post_response}).body)
  end

  def get_mentor_availability(mentor_id)
    response = JSON.parse(Kele.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @post_response}).body)
  end

  def get_messages
    response = JSON.parse(Kele.get("/message_threads", headers: { "authorization" => @post_response}).body)
  end

  def create_message(recipient_id, message)
    response = Kele.post("/messages", headers: { "authorization" => @post_response} , body: { "sender" => @email, "recipient_id" => recipient_id, "stripped-text" => message})
  end

  def create_submission(checkpoint_id, enrollment_id)
    post_response = Kele.post("/checkpoint_submissions", headers: { "authorization" => @post_response}, body: { "enrollment_id" => enrollment_id, "checkpoint_id" => checkpoint_id})
  end

  def update_submission(checkpoint_id, checkpoint_submission_id, enrollment_id)
    post_response = Kele.put("/checkpoint_submissions/#{checkpoint_submission_id}", headers: { "authorization" => @post_response}, body: { "enrollment_id" => enrollment_id, "checkpoint_id" => checkpoint_id, "id" => checkpoint_submission_id })
  end
end