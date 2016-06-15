class Vigenere

  attr_accessor :clave,:mensaje,:alfabeto,:compara,:cifrado

  def initialize(cad1,cad2)
    @mensaje=cad1.delete(' ').upcase.split(//)
    @clave=cad2.upcase.split('')
    @cifrado=[]
    @alfabeto=('A'..'Z').to_a
    @compara=0          #variable que se usara para comprobar si es valido o no el mensaje recibido
  end
  #metodo para comprobar que el mensaje recibido es correcto
  def comprueba
    regexp=/[A-Z]/      #expresion regular que solo acepta el alfabeto en mayuscula
    @mensaje.each  do |i|
      if !regexp.match(i.to_s)
        @compara=1
      end
    end
    @compara
  end

  #metodo para cifrar el mensaje
  def cifrar
    t_contador=0            #temporal para crear bloques del mismo tamaño de la clave.
    t_cadena=""               #cadena que se utilizará para crear el mensje cifrado.
    for i in 0..@mensaje.length-1
      #condición para volver a leer desde el comienzo la clave en caso de que se hayan leido todos los caracteres.
      if(t_contador>=@clave.length)
        t_cadena << " "
        t_contador=0
      end
      valorcaracter= @alfabeto.index(@mensaje[i])                                     #coincidencia en el alfabeto del caracter detectado en la iesima posicion del mensaje
      valorclave=@alfabeto.index(@clave[t_contador%@clave.length])                    #coincidencia en el alfabeto del caracter detectado en la iseima posicion de la clave
      valorencriptado = (valorcaracter + valorclave)                                  #suma la posicion detectada de la clave con la del caracter iesimo
      #condicion para que en caso de que la suma sea mayor al alfabeto se resta el resultado con la longitud del alfabeto.
      if(valorencriptado >= @alfabeto.length)
        x=@alfabeto[valorencriptado-@alfabeto.length]
      else
        x=@alfabeto[valorencriptado]
      end
      @cifrado.push(x)
      t_contador+=1
      t_cadena << @mensaje[i]
    end
    puts "\n TEXTO CIFRADO: #{@cifrado.join('')}"
    @cifrado.join('')
  end
  #descifrado
  def descifrar
    t_contador=0            #temporal para crear bloques del mismo tamaño de la clave.
    t_cadena=""               #cadena que se utilizará para crear el mensje cifrado.
    for i in 0..@mensaje.length-1
      #condición para volver a leer desde el comienzo la clave

      if(t_contador>=@clave.length)
        t_cadena << " "
        t_contador=0
      end
      valorcaracter= @alfabeto.index(@mensaje[i])
      valorclave=@alfabeto.index(@clave[t_contador%@clave.length])
      valorencriptado = (valorcaracter - valorclave)
      if(valorencriptado < 0)
        x=@alfabeto[valorencriptado+@alfabeto.length]
      else
        x=@alfabeto[valorencriptado]
      end
      @cifrado.push(x)
      t_contador+=1
      t_cadena << @mensaje[i]
      #puts"->#{t_cadena}"
    end

    puts "\n TEXTO CIFRADO: #{@cifrado.join('')}"
    @cifrado.join('')
  end
end