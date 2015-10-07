require 'sinatra'

module Example
  class App < Sinatra::Base
    enable  :sessions
    enable  :raise_errors
    disable :show_exceptions

    use Warden::Manager do |manager|
      manager.default_strategies :reliefwatch
      manager.failure_app = BadAuthentication

      manager[:reliefwatch_client_id]    = ENV['RELIEFWATCH_CLIENT_ID']     || 'fd6df6f74658a9202d401aaba38223a7f79e7572926ce845e5268f5171e5b2d5'
      manager[:reliefwatch_secret]       = ENV['RELIEFWATCH_CLIENT_SECRET'] || 'afee0e20322e5d73dff82f29baf5989afd3422557056129aad29d974e56df677'

      manager[:reliefwatch_scopes]       = 'public'
      manager[:reliefwatch_oauth_domain] = ENV['RELIEFWATCH_OAUTH_DOMAIN'] || 'http://localhost:3000'
      manager[:reliefwatch_callback_url] = '/auth/reliefwatch/callback'
    end

    helpers do
      def ensure_authenticated
        unless env['warden'].authenticate!
          throw(:warden)
        end
      end

      def user
        env['warden'].user
      end
    end

    get '/' do
      ensure_authenticated
      "Hello There, #{user.to_json}!"
    end

    get '/redirect_to' do
      ensure_authenticated
      "Hello There, #{user.name}! return_to is working!"
    end

    get '/auth/reliefwatch/callback' do
      ensure_authenticated
      redirect '/'
    end

    get '/logout' do
      env['warden'].logout
      "Peace!"
    end
  end

  class BadAuthentication < Sinatra::Base
    get '/unauthenticated' do
      status 403
      "Unable to authenticate, sorry bud."
    end
  end

  def self.app
    @app ||= Rack::Builder.new do
      run App
    end
  end
end
