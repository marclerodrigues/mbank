class BalanceController < ApplicationController
  def show
    account = Account.find_by(id: params[:id])

    if account
      render json: { success: true, balance: account.balance }
    else
      render json: { success: false, error: 'Account not found' }, status: :not_found
    end
  end
end
