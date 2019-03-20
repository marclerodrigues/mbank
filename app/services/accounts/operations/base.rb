module Accounts
  module Operations
    class Base
      attr_reader :account

      def self.perform!(options = {})
        new(options).perform!
      end

      def initialize(options = {})
        @account = options.fetch(:account)
        post_initialize(options)
      end

      def post_initialize(options); end

      def perform!
        raise NotImplementedError
      end
    end
  end
end
