require 'spec_helper'

describe Target do

  describe "validations" do
    it "accepts 10 digit numbers" do
      subject.should have_valid(:phone_number)
        .when('1234567890', '0987654321')
      subject.should_not have_valid(:phone_number)
        .when('123456789', '', nil)
    end
  end

  describe "#phone_number=" do
     let(:target) { Target.new }

     it "strips any non-numerals off of the phone number" do
       target.phone_number ='a(518)334-66b56c'

       expect(target.phone_number).to eq('5183346656')
     end
  end
end
