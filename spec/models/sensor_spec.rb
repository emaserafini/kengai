require 'rails_helper'

RSpec.describe Sensor, type: :model do
  describe 'on save' do
    subject! { create :temperature }

    context 'when value attribute changes' do
      it 'updates value_updated_at attribute with current time' do
        Timecop.freeze Time.local(1990) do
          expect { subject.update_attributes value: 30 }.to change { subject.value_updated_at }.to Time.local(1990)
        end
      end
    end

    context 'when value attribute does not changes' do
      it 'does not updates value_updated_at' do
        subject.scale = 'C'
        expect { subject.save }.not_to change { subject.value_updated_at }
      end
    end
  end
end
