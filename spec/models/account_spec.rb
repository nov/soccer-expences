require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#role' do
    let(:account) { create(:account) }
    subject { account.role }

    context 'default' do
      it { should == :pending }
    end

    context 'when approved' do
      before { account.approve! }
      it { should == :viewer }
    end

    context 'when adminized' do
      before { account.adminize! }
      it { should == :admin }
    end
  end
end
