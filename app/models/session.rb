class Session < ApplicationRecord
  @opentok = OpenTok::OpenTok.new(ENV['OPENTOK_API_KEY'], ENV['OPENTOK_API_SECRET'])

  class << self
    def create_or_load_session_id
      if Session.any?
        last_session = Session.last
        if last_session && last_session.expired == false
          @session_id = last_session.session_id
          @session_id
        elsif (last_session && last_session.expired == true) || !last_session
          @session_id = create_new_session
        else
          raise 'Something went wrong with the session creation!'
        end
      else
        @session_id = create_new_session
      end
    end

    def create_new_session
      session = @opentok.create_session
      record = Session.new
      record.session_id = session.session_id
      record.save
      @session_id = session.session_id
      @session_id
    end

    def create_token(user_name, moderator_name, session_id)
      @token = user_name == moderator_name ? @opentok.generate_token(session_id, { role: :moderator }) : @opentok.generate_token(session_id)
    end
  end
end
