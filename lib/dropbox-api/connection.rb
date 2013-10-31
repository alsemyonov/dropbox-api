require "dropbox-api/connection/requests"

module Dropbox
  module API

    class Connection

      include Dropbox::API::Connection::Requests

      attr_accessor :consumers
      attr_accessor :tokens

      def initialize(options = {})
        oauth = if options.delete(:oauth) { :oauth1 } == :oauth1
                  require 'dropbox-api/util/oauth'
                  Dropbox::API::OAuth
                else
                  require 'dropbox-api/util/oauth2'
                  Dropbox::API::OAuth2
                end
        @options   = options
        @consumers = {}
        @tokens    = {}
        Dropbox::API::Config.endpoints.each do |endpoint, url|
          @consumers[endpoint] = oauth.consumer(endpoint)
          @tokens[endpoint]    = oauth.access_token(@consumers[endpoint], options)
        end
      end

      def consumer(endpoint = :main)
        @consumers[endpoint]
      end

      def token(endpoint = :main)
        @tokens[endpoint]
      end

    end

  end
end
