module Roadmap
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def get_roadmap(roadmap_id)
    response = JSON.parse(Kele.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @post_response}).body)
  end

  def get_checkpoint(checkpoint_id)
    response = Kele.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @post_response})
  end
end