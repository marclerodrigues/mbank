class Account < ApplicationRecord
  belongs_to :user

  has_many :transfers, dependent: :nullify, foreign_key: :source_account_id
  has_many :received_transfers, dependent: :nullify, foreign_key: :destination_account_id, class_name: 'Transfer'

  def self.find_by_access_token_and_id(access_token, id)
    joins(:user).where(users: { access_token: access_token }).find_by(id: id)
  end
end
