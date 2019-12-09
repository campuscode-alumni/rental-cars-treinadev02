require 'rails_helper'

describe Client do
  describe '.description' do
    it 'must return name with document' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')

      expect(client.description).to eq 'Fulano Sicrano - 743.341.870-99'
    end
  end
end
