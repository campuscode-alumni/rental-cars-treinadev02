FactoryBot.define do
    factory :user do
        email {'teste@teste.com.br'}
        password {'123teste'}
        role {:admin}
        subsidiary {Subsidiary.new(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000') }
    end
  end