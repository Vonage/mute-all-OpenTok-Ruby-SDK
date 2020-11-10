module OpenTok
    #  A class for working with OpenTok force mute.
    class ForceMute
      # @private
      def initialize(client)
        @client = client
      end
  
      # Force a client to mute audio from an OpenTok session.
      #
      # A client must be actively connected to the OpenTok session for you to mute.
      #
      # @param [String] session_id The session ID of the OpenTok session.
      # @param [String] stream_id The stream ID of the client in the session.
      #
      # @raise [ArgumentError] The stream_id or session_id is invalid.
      # @raise [OpenTokAuthenticationError] You are not authorized to mute the connection. Check your authentication credentials.
      # @raise [OpenTokMuteError] Can't execute mute function.
      #
      def forceMute(session_id, stream_id )
        raise ArgumentError, "session_id not provided" if session_id.to_s.empty?
        raise ArgumentError, "stream_id not provided" if stream_id.to_s.empty?
        response = @client.forceMute(session_id, stream_id)
        (200..300).include? response.code
      end
      
      # Force all client of OpenTok session to mute audio.
      #
      # A client must be actively connected to the OpenTok session for you to mute.
      #
      # @param [String] session_id The session ID of the OpenTok session.
      # @param [String] excluded_steam_ids The stream IDs of the client in the session to exclude from mute.
      #
      # @raise [ArgumentError] The session_id is invalid.
      # @raise [OpenTokAuthenticationError] You are not authorized to mute the connection. Check your authentication credentials.
      # @raise [OpenTokMuteError] Can't execute mute function.
      #
      def forceMuteAll(session_id, excluded_steam_ids=nil)
        raise ArgumentError, "session_id not provided" if session_id.to_s.empty?
        response = @client.forceMuteAll(session_id, excluded_steam_ids)
        (200..300).include? response.code
      end
    end
  end