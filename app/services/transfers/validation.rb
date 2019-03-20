module Transfers
  class Validation
    attr_accessor :errors

    def self.perform(options = {})
      new(options).perform
    end

    def initialize(options = {})
      @source_account = options.fetch(:source_account)
      @destination_account = options.fetch(:destination_account)
      @amount = options.fetch(:amount)
      @errors = []
    end

    def perform
      valid_transfer?
    end

    private

    attr_reader :source_account, :destination_account, :amount

    def valid_transfer?
      user_authorized? && available_balance? && destination_account_exists?
    end

    def user_authorized?
      return true if source_account

      add_error_message('Account not found')
    end

    def available_balance?
      return true if source_account.balance >= amount

      add_error_message('Insuficient funds')
    end

    def destination_account_exists?
      return true if destination_account

      add_error_message('Destination account not found')
    end

    def add_error_message(message)
      errors << message
      false
    end
  end
end
