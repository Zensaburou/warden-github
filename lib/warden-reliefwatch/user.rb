module Warden
  module Reliefwatch
    module Oauth
      class User < Struct.new(:attribs, :token)
        def full_name
          attribs['user']['full_name']
        end

        def email
          attribs['user']['email']
        end
      end
    end
  end
end
