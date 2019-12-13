class Teste

	def valida(cpf)
 		cpf = cpf.delete('.-')

	puts cpf

      if !cpf.match?(/\A-?\d+\Z/)
        self.errors.add(:cpf, 'CPF não deve conter letras, apenas numeros')
      else
        if cpf.size != 11
          puts 'Tamanho do CPF invalido, ele deve ter 11 algarismos'
        else
          array_of_char = cpf.chars
          array_of_char = array_of_char.map {|position| position.to_i}
          
          first_verifying_digit = 0
          number = 10
          
          for count in 0..8
            first_verifying_digit += array_of_char[count] * number
            number = number.pred                      

		puts "#{first_verifying_digit} += #{array_of_char[count] } * #{number}"
          end
        
          first_verifying_digit = ((first_verifying_digit*10) % 11)
          if first_verifying_digit == 10
            first_verifying_digit=0
          end

		puts first_verifying_digit
        
          second_verifying_digit = 0
          number = 11
        
          for count in 0..9
            second_verifying_digit += array_of_char[count].to_i * number
            number = number.pred                  

		puts "#{second_verifying_digit} += #{array_of_char[count] } * #{number}"
          end
        
          second_verifying_digit = ((second_verifying_digit*10) % 11)
          if second_verifying_digit == 10
            first_verifying_digit=0
          end

		puts second_verifying_digit
          
          if first_verifying_digit != array_of_char[9].to_i && second_verifying_digit != array_of_char[10].to_i
            puts 'CPF não é valido'
          end
        end
      end
	end

end

teste = Teste.new()
teste.valida("11610675070")

