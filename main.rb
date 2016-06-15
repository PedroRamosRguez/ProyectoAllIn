require "./clases/vernam.rb"
require "./clases/vigenere.rb"
require "./clases/rc4.rb"
require "./clases/spritz.rb"
require "./clases/A5.rb"
require "./clases/rijndael.rb"
require "./clases/diffie-hellman.rb"
require "./clases/rsa.rb"
require "./clases/fiat-shamir.rb"

puts "\n\t PROYECTO ALL IN  SEGURIDAD EN SISTEMAS INFORMÁTICOS.APLICACION CON TODOS LOS ALGORITMOS CRIPTOGRÁFICOS PRINCIPALES DE LA ASIGNATURA"
puts "\n\t ALUMNO: PEDRO MANUEL RAMOS RODRÍGUEZ. 3º GRADO INFORMÁTICA TECNOLOGÍA DE LA INFORMACIÓN\n\n"
option=0
while(option!=10)
  puts "\n ==================================================================
        ELIGE EL ALGORITMO A UTILIZAR
        \n ==================================================================
        1. CIFRADO VERNAM.
        2. CIFRADO VIGENERE.
        3. CIFRADO RC4.
        4. CIFRADO SPRITZ.
        5. CIFRADO A5/1.
        6. CIFRADO RIJNDAEL (AES 128)
        7. DIFFIE-HELLMAN
        8. RSA
        9. FIAT SHAMIR
        10. SALIR
    \n =================================================================="
  puts "\n Introduce opcion:"
  opcion=gets.chomp
  option=opcion.to_i
  case option
    when 1
      #cifrado vernam
      print "Introduce la cadena a cifrar: "
      cadena=gets.chomp
      encriptado=Vernam.new(cadena)
      cad_binaria=encriptado.binario()
      puts "\n -> Mensaje original en binario: #{cad_binaria}"
      random=encriptado.aletorio(cad_binaria)
      puts "\n -> Clave aleatoria generada: #{random}"
      a_xor=encriptado.op_xor(cad_binaria,random)
      puts "\n -> Mensaje cifrado en binario: #{a_xor}"
      cad_cifrada=encriptado.cifrar_bin(a_xor)
      cifrada=cad_cifrada.force_encoding('iso-8859-1').encode('utf-8')
      puts "\n -> Clave cifrada: #{cifrada}"
      cad_descifrada=encriptado.descifra(cifrada,random)
      puts  "\n ->Mensaje Descifrado: #{cad_descifrada}"

    when 2
      #cifrado vigenere
      system("clear")
      print "Introduce la cadena a cifrar: "
      cadena=gets.chomp
      print "\n Introduce una clave: "
      clave=gets.chomp
      encriptado=Vigenere.new(cadena,clave)
      comprueba=encriptado.comprueba
      if(comprueba==0)
        cad_cifrada=encriptado.cifrar
      else
        puts"\n ERROR, DETECTADO CARACTER NO VALIDO"
      end

      #descifrado
      print "Introduce la cadena a descifrar: "
      cadena=gets.chomp
      print "\n Introduce una clave: "
      clave=gets.chomp
      encriptado=Vigenere.new(cadena,clave)
      comprueba=encriptado.comprueba
      if(comprueba==0)
        cadena_descifrada=encriptado.descifrar
      else
        puts"\n ERROR, DETECTADO CARACTER NO VALIDO"
      end

    when 3
      #cifrado
      print "Introduce el mensaje a cifrar: "
      mensaje=gets.chomp
      print "Introduce la clave: "
      clave=gets.chomp
      rc4=Rc4.new(mensaje,clave)
      rc4.binario()
      rc4.intercambio
      cad_cifrada=rc4.cifrar()
      puts "cadena cifrada:#{cad_cifrada}"

    when 4
      print "Introduce el mensaje a cifrar: "
      mensaje=gets.chomp
      print "Introduce la clave: "
      clave=gets.chomp
      spritz=Spritz.new(mensaje,clave)
      spritz.binario()
      spritz.intercambio
      cad_cifrada=spritz.cifrar()
      puts "cadena cifrada:#{cad_cifrada}"

    when 5
      puts "\n MENSAJE CREADO ALEATORIAMENTE SEGUN EL TAMAÑO QUE SE INTRODUZCA:"
      tamanio=gets.chomp.to_i
      mensaje=""
      tamanio.times do
        aleatorio= rand(0..1)
        mensaje<< aleatorio.to_s
      end
      a5=A5.new(mensaje)
      i=0
      while(i<mensaje.length)
        a5.salida
        a5.xor
        a5.mayoria
        a5.movimiento
        i+=1
      end
      cad_cifrada=a5.cifrado
      puts "cadena cifrada: #{cad_cifrada}"


    when 6
      puts "introduce mensaje EN DECIMAL SEPARADO DE ESPACIOS: "
      mensaje=gets.chomp
      puts "introduce clave: "
      clave=gets.chomp
      aes=Rijndael.new(clave,mensaje)
      aes.hexadecimal()
      round=aes.roundkey()
      puts "ROUNDKEY: #{round}"
      aes.mostrarsubclave(0)
      for i in 0...9
        sub=aes.subbytes()
        puts "SUBBYTES: #{sub}"
        row=aes.shiftrow()
        puts "SHIFTROW: #{row}"
        mix=aes.mixcolumn()
        puts "MIXCOLUMN: #{mix}"
        aes.expansionclave(i)
        round=aes.addroundkey()
        puts "ROUNDKEY: #{round}"
        aes.mostrarsubclave(i)
      end
      aes.subbytes()
      aes.shiftrow()
      aes.expansionclave(9)
      aes.addroundkey()
      aes.mostrarsubclave(9)
      cad_cifrada=aes.textocifrado()
      puts "cadena cifrada: #{cad_cifrada}"

     when 7
       puts "introduce secreto A: "
       secreto1=gets.chomp
       puts "introduce secreto B: "
       secreto2=gets.chomp
       puts "numero primo: "
       n_primo=gets.chomp.to_i
       puts "introduce numero Alfa: "
       n_alfa=gets.chomp.to_i
       diffie_hellman=Diffie.new(secreto1,secreto2,n_primo,n_alfa)
        #metodo para generar y_a
       y_a=diffie_hellman.exponenciacion(n_alfa,secreto1,n_primo)
       puts "\n Y_a= #{y_a}"
          #metodo para generar y_b
       y_b=diffie_hellman.exponenciacion(n_alfa,secreto2,n_primo)
       puts "\n Y_b= #{y_b}"
        #metodos para generar la clave (que debe ser igual)
       k_a=diffie_hellman.exponenciacion(y_b,secreto1,n_primo)
       k_b=diffie_hellman.exponenciacion(y_a,secreto2,n_primo)
       if k_a==k_b
         clave=k_a
         puts "\n CLAVE= #{clave}"
       end

    when 8
      puts "introduce mensaje a cifrar: "
      mensaje=gets.chomp
      puts "introduce p: "
      p=gets.chomp.to_i
      puts "introduce q:"
      q=gets.chomp.to_i
      puts "introduce d: "
      d=gets.chomp.to_i
      rsa=Rsa.new(mensaje,p,q,d)
      n_primo1=rsa.lehman_peralta(p)
      n_primo2=rsa.lehman_peralta(q)
      phi=(p-1)*(q-1)
      n=p*q
      n_primo3=rsa.euclides_extendido(d,phi)
      if (n_primo1== true && n_primo2== true && n_primo3==true)
        puts "LOS NUMEROS SON PRIMOS"

        j=rsa.obtenerj(n)
        rsa.codif_numerica()
        claves,mensajes=[],[]
#incializacion del vector de claves para luego realizar el algoritmo de exponenciacion rapida
        for i in 0...rsa.n_cifrado.length
          claves[i],mensajes[i]=0
        end
        for i in 0...rsa.n_cifrado.length
          claves[i]=rsa.exponenciacion(rsa.n_cifrado[i],rsa.inverso,n)
        end

#para el descifrado seria pasando las claves
        for i in 0...rsa.n_cifrado.length
          mensajes[i]=rsa.exponenciacion(claves[i],d,n)
        end
        #print mensajesn=p*q
        j=rsa.obtenerj(n)
        rsa.codif_numerica()
        claves,mensajes=[],[]
#incializacion del vector de claves para luego realizar el algoritmo de exponenciacion rapida
        for i in 0...rsa.n_cifrado.length
          claves[i],mensajes[i]=0
        end
        for i in 0...rsa.n_cifrado.length
          claves[i]=rsa.exponenciacion(rsa.n_cifrado[i],rsa.inverso,n)
        end
        print "\n Mensaje cifrado:#{claves}"
#para el descifrado seria pasando las claves
        for i in 0...rsa.n_cifrado.length
          mensajes[i]=rsa.exponenciacion(claves[i],d,n)
        end
        print "\n Mensaje descifrado:#{mensajes}"
      else
        puts "LOS NUMEROS DEBEN SER PRIMOS Y NO ES ASI."
      end



    when 9
      s,x=0,0
      puts "introduce p: "
      p=gets.chomp.to_i
      puts "introduce q:"
      q=gets.chomp.to_i
      fiatshamir=Fiat_shamir.new(p,q,s)
      n_primo1=fiatshamir.lehman_peralta(p)
      n_primo2=fiatshamir.lehman_peralta(q)
      if (n_primo1== true && n_primo2== true )
        puts "LOS NUMEROS SON P RIMOS"
        n=p*q
        puts "introduce s: "
        s=gets.chomp.to_i
        while s>n
          puts "introduce s: "
          s=gets.chomp.to_i
        end
        puts "NUMERO DE ITERACIONES: "
        i=gets.chomp.to_i
        puts "n=#{n} S= #{s}"
        n_primo3=fiatshamir.euclides_extendido(n,s)
        if(n_primo3==true)
          v=0

          v=fiatshamir.exponenciacion(s,2,n)
          puts "v= #{v}"
          contador,valido=0,0
          while(contador<i || valido==1)

            puts "introduce valor x: "
            x=gets.chomp().to_i
            a=fiatshamir.exponenciacion(x,2,n)
            puts "a= #{a}"
            puts "introduce un valor e: "
            e=gets.chomp().to_i
            if e==0
              y=fiatshamir.exponenciacion(x,1,n)
              #puts "y= #{y}"
            elsif e==1
              y=fiatshamir.exponenciacion(x*s,1,n)
              #puts "y= #{y}"

            end
            #verificacion
            if e==0
              #puts "FASE DE VERIFICACION"
              #y=fiatshamir.exponenciacion(a,1,n)
              validacion=fiatshamir.exponenciacion(a,1,n)
              #puts "Validacion=#{validacion}"
              puts "Y= #{y}"
              if(y**2%n==validacion)
                puts "#{y}^2 mod #{n} = #{validacion}mod #{n}"
                puts "iteracion valida..."
              else
                puts "iteracion no valida...."
                valido=1
              end
            elsif e==1
              #puts "FASE DE VERIFICACION"
              validacion=fiatshamir.exponenciacion(a*v,1,n)
              #puts "V=#{validacion}"
              puts "Y= #{y}"
              if(y**2%n==validacion)

                puts "#{y}^2 mod #{n} = #{validacion}mod #{n}"
                puts "iteracion valida..."
              else
                puts "iteracion no valida..."
                valido=1
              end
            end
            contador+=1
          end
        else
          puts "S no es coprimo con N"
        end
      else
        puts "LOS NUMEROS DEBEN SER PRIMOS Y NO ES ASI."
      end
    when 10
      break;
    else
      puts "\n OPCION INCORRECTA, INTRODUZCA UNA OPCION ENTRE 1-2"
  end
end