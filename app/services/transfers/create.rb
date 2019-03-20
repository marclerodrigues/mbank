module Transfers
  class Create
    delegate :errors, to: :transfer_validation

    def self.perform(options = {})
      new(options).perform
    end

    def initialize(options = {})
      @params = options.fetch(:params)
      @amount = @params[:amount].to_i
    end

    def perform
      if valid?
        ActiveRecord::Base.transaction do
          ::Accounts::Operations::Debit.perform!(account: source_account, amount: amount)
          ::Accounts::Operations::Credit.perform!(account: destination_account, amount: amount)
          ::Transfer.create!(transfer_params)
        end
      else
        false
      end
    end

    private

    attr_reader :params, :amount

    def valid?
      transfer_validation.perform
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
