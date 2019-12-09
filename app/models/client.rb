class Client < ApplicationRecord
    validates :name, :cpf, :email, presence: {message: 'O campo deve ser preenchido'}
    validates :cpf, :email, uniqueness: {message: 'O valor já esta em uso'}
    validate :verifying_cpf

    has_many :rental

    def verifying_cpf

      cpf = self.cpf.delete('.-')

      if !cpf.match?(/\A-?\d+\Z/)
        self.errors.add(:cpf, 'CPF não deve conter letras, apenas numeros')
      else
        if cpf.size != 11
          self.errors.add(:cpf, 'Tamanho do CPF invalido, ele deve ter 11 algarismos')
        else
          array_of_char = cpf.chars
          array_of_char = array_of_char.map {|position| position.to_i}
          
          first_verifying_digit = 0
          number = 10
          
          for count in 0..8
            first_verifying_digit += array_of_char[count] * number
            number = number.pred                      
          end
        
          first_verifying_digit = ((first_verifying_digit*10) % 11)
          if first_verifying_digit == 10
            first_verifying_digit=0
          end
        
          second_verifying_digit = 0
          number = 11
        
          for count in 0..9
            second_verifying_digit += array_of_char[count].to_i * number
            number = number.pred                  
          end
        
          second_verifying_digit = ((second_verifying_digit*10) % 11)
          if second_verifying_digit == 10
            second_verifying_digit=0
          end
          
          if first_verifying_digit != array_of_char[9].to_i && second_verifying_digit != array_of_char[10].to_i
            self.errors.add(:cpf, 'CPF é invalido')
          end
        end
      end
    end

end
