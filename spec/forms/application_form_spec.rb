require 'rails_helper'

RSpec.describe ApplicationForm, type: :form do
  describe '.validate_models' do
    class TestModel
      include ActiveModel::Model
      validate { errors.add(:child_attribute_name, 'is invalid') }
    end

    class TestForm < ApplicationForm
      validates_models :test_model

      private

      def test_model
        @test_model = TestModel.new
      end
    end

    it 'should make the form object invalid if the child models are invalid' do
      test_form = TestForm.new

      expect(test_form).to be_invalid
    end

    it "should add the child errors to the form object's errors" do
      test_form = TestForm.new

      test_form.validate

      expect(test_form.errors[:child_attribute_name]).to include 'is invalid'
    end
  end
end
