require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:transfers).dependent(:nullify) }
    it { is_expected.to have_many(:received_transfers).dependent(:nullify).class_name('Transfer') }
  end
end
