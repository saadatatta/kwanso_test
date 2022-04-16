module Helpers
    module Authentication
      def sign_up(user)
        post '/api/auth.json',
             params: { email: user[:email],
                       password: user[:password],
                       password_confirmation: user[:password] },
             as: :json
      end
  
      def auth_tokens_for_user(user)
        post '/api/auth/sign_in.json',
             params: { email: user[:email], password: user[:password] },
             as: :json
        response.headers.slice('client', 'access-token', 'uid')
      end
    end
end