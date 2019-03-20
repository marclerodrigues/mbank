class Account < ApplicationRecord
  belongs_to :user

  has_many :transfers, dependent: :nullify, foreign_key: :source_account_id
  has_many :received_transfers, dependent: :nullify, foreign_key: :destination_account_id, class_name: 'Transfer'
end
