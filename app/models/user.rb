class User < ApplicationRecord
  with_options presence: true do
    validates :first_name, :last_name, :email
  end
end
