require 'spec_helper'

describe Permiso do
  before(:all) do
    @user = {:role => 'admin'}
    @booking = { 'ref_anixe' => '6666', 'status' => 'book_confirmed' }
  end

  class AbilityTest
    include Permiso::Ability

    def initialize(booking)
      @booking = booking

      role :admin do
        can :cancel
        can :create
      end

      rule :cancel do
        @booking['status'] == 'book_confirmed'
      end
    end

  end

  it 'should allow, when role is defined' do
    ability = AbilityTest.new(@booking)
    ability.can?(:admin, :cancel).should be_true
    ability.can?(:admin, :create).should be_true
  end

  it 'should NOT allow, when role is NOT defined' do
    ability = AbilityTest.new(@booking)
    ability.can?(:anybody, :cancel).should be_false
  end

end
