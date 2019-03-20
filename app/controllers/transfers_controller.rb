class TransfersController < ApplicationController
  def create
    transfer = ::Transfers::Create.new(params: transfer_params)

    if transfer.perform
      render json: { success: true }
    else
      render json: { success: false, errors: transfer.errors }, status: :unprocessable_entity
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:source_account_id, :destination_account_id, :amount, :access_token)
  end
end
