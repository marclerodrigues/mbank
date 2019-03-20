module Transfers
  class Create
    attr_accessor :errors

    def self.perform(options = {})
      new(options).perform
    end

    def initialize(options = {})
      @params = options.fetch(:params)
      @amount = @params[:amount].to_i
      @errors = []
    end

    def perform
      if valid?
        ActiveRecord::Base.transaction do
          debit_from_source_account!
          credit_destination_account!
          create_transfer!
        end
      else
        @errors = transfer_validation.errors
        false
      end
    end

    private

    attr_reader :params, :amount

    def valid?
      transfer_validation.perform
    end

    def debit_from_source_account!
      source_account.update_attributes!(balance: source_account.balance - amount)
    end

    def credit_destination_account!
      destination_account.update_attributes!(balance: destination_account.balance + amount)
    end

    def create_transfer!
      Transfer.create!(transfer_params)
    end

    def source_account
      @_source_account ||= Account.find_by_access_token_and_id(params[:access_token], params[:source_account_id])
    end

    def destination_account
      @_destination_account ||= Account.find_by(id: params[:destination_account_id])
    end

    def transfer_validation
      @_transfer_valitdation ||=::Transfers::Validation.new(transfer_params)
    end

    def transfer_params
      {
        source_account: source_account,
        destination_account: destination_account,
        amount: params[:amount].to_i
      }
    end
  end
end
