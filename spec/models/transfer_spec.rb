require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:source_account).class_name('Account') }
    it { is_expected.to belong_to(:destination_account).class_name('Account') }
  end
end
