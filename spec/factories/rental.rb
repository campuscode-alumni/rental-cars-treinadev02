FactoryBot.define do
    factory :rental do
        start_date {'2019-12-01'}
        end_date {'2019-12-07'}
        client_id {Client.create(name: 'Siclano',
                                 cpf: '111.111.111-11',
                                 email: 'siclano@client.com').id}
        car_category_id {CarCategory.create(name: 'Carro pequeno',
                                            daily_rate: '90', 
                                            car_insurance: '35',
                                            third_party_insurance: '29').id}
        reservation_code {'AAA1111'}
        subsidiary_id { Subsidiary.create( name:'Unidade SP', 
                                           cnpj: '000.000.000-00', 
                                           address: 'Av. teste')}
    end
  end