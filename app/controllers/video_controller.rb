require 'opentok'

class VideoController < ApplicationController
  before_action :set_opentok_vars

  def landing
  end

  def index
  end

  def screenshare
  end

  def name
    @name = name_params[:name]
    if name_params[:password] == ENV['PARTY_PASSWORD']
      redirect_to party_url(name: @name)
    else
      redirect_to('/', flash: { error: 'Incorrect password' })
    end
  end

  def chat
  end

  def set_opentok_vars
    @api_key = ENV['OPENTOK_API_KEY']
    @api_secret = ENV['OPENTOK_API_SECRET']
    @session_id = Session.create_or_load_session_id
    @moderator_name = ENV['MODERATOR_NAME']
    @name ||= params[:name]
    @token = Session.create_token(@name, @moderator_name, @session_id)
  end

  private

  def name_params
    params.permit(:name, :password, :authenticity_token, :commit)
  end
end
