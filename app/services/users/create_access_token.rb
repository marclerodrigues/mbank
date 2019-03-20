require 'jwt'

module Users
  class CreateAccessToken
    def self.perform(options = {})
      new(options).perform
    end

    def initialize(options = {})
      @user = options.fetch(:user)
    end

    def perform
      user.update_attributes!(access_token: access_token)
    end

    private

    attr_reader :user

    def access_token
      JWT.encode(payload, nil, 'none')
    end

    def payload
      {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
    end
  end
end
