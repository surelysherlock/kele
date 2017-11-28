require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email,password)
    @email = email
    @password = password
    @post_response = Kele.post("/sessions", body: {email: email, password: password}).parsed_response["auth_token"]
  end
end