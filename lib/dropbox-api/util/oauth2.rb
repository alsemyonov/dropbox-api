module Dropbox
  module API
    module OAuth2
      class << self
        def consumer(endpoint)
          if !Dropbox::API::Config.app_key or !Dropbox::API::Config.app_secret
            raise Dropbox::API::Error::Config.new("app_key or app_secret not provided")
          end
          require 'oauth2'
          ::OAuth2::Client.new(Dropbox::API::Config.app_key, Dropbox::API::Config.app_secret,
                               :site => Dropbox::API::Config.endpoints[endpoint],
                               :token_url => Dropbox::API::Config.prefix + "/oauth2/token",
                               :authorize_url => Dropbox::API::Config.prefix + "/oauth2/authorize")
        end

        def access_token(consumer, options = {})
          ::OAuth2::AccessToken.new(consumer, options.delete(:token), options)
        end
      end
    end
  end
end

