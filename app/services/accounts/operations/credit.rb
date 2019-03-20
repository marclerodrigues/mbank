module Accounts
  module Operations
    class Credit < ::Accounts::Operations::Base
      attr_reader :amount

      def post_initialize(options)
        @amount = options.fetch(:amount)
      end

      def perform!
        account.update_attributes!(balance: balance)
      end

      private

      def balance
        account.balance + amount.to_i
      end
    end
  end
end
