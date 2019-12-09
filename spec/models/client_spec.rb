require 'rails_helper'

describe Client do
  describe '.describe' do
    it 'must return name with document' do
      client = Client.new(name: 'Fulano', cpf: '116.106.750-70', email: 'fulano@client.com')

      expect(client.description).to eq 'Fulano - 116.106.750-70'
    end
  end
end