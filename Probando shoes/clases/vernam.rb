
class Vernam
  attr_accessor :clave,:c_aleatorio,:clave_bin,:xor,:clave_bin,:c_cifrada

  #metodo que convierte a binario la cadena recibida
  def initialize(cad)
    @clave=cad
    @c_aleatorio=""
    @clave_bin=""
    @xor=""
    @c_cifrada=""
    @c_descifrada=""
  end
  #metodo que pasa la cadena original a binario
  def binario()
    t_cadena=""
    #unpack lo que hace es transformar la cadena a ascii y directamente pasarlo a binario
    t_cadena= @clave.unpack("B*")
    #cadena donde se guardara el numero binario cifrado
    a_cadena=""
    t_cadena.each do |i|
      a_cadena<< i
    end
    @clave_bin=a_cadena
    @clave_bin
  end

  #metodo que crea una clave aleatorio
  def aletorio(cad)
    #cadena donde se guardara el numero binario aleatorio creado
    t_aleatorio=""
    cad.length.times do
      aleatorio= rand(0..1)
      t_aleatorio<< aleatorio.to_s
    end
    @c_aleatorio=t_aleatorio
    @c_aleatorio
  end

  #metodo que dadas dos clases realiza un xor.
  def op_xor(cad1,cad2)
    t_xor=(cad1.to_i(2)^cad2.to_i(2)).to_s(2)
    #la operacion xor obvia los ceros a la izquierda esta condicion pone el numero de 0 que obvia en la operacion.
    if (t_xor.length<cad1.length)||(t_xor.length<cad2.length)
      a_t_xor=""
      #variable que calcula la diferencia de longitud para añadir 0 a la izquierda posteriormente
      diferencia=cad1.length-t_xor.length
      (0..diferencia)
      a_t_xor << "0"
      a_t_xor << t_xor
      @xor=a_t_xor
      @xor
    else
      @xor=t_xor
      @xor
    end
  end
  #metodo que cifra la cadena en binario
  def cifrar_bin(cad)
    a_cifrar=cad.to_s
    t_cifrar=[a_cifrar].pack("B*")
    @c_cifrada=t_cifrar
    @c_cifrada
  end

  #metodo que recibe una cadena cifrada y la descifra
  def descifra(cad1,cad2)
    #puts "\n ->Mensaje cifrado: #{cad1}"
    #recibe un utf-8 se pasa a 8859-1 porque en utf-8 se mostraba en 8 bits de mas
    convert = cad1.encode("ISO-8859-1")
    @clave=convert
    a_cad=self.binario()
    #puts "\n ->Mensaje cifrado en binario: #{a_cad}"
    #puts "\n -> Longitud del mensaje binario #{a_cad.length}"
    #puts "\n -> Clave aleatoria recibida: #{cad2}"
    #puts "\n #{a_cad.length}, #{cad2.length}"
    msgbin_original=self.op_xor(a_cad,cad2)
    #puts "\n ->Mensaje original en binario: #{msgbin_original.to_s}"
    descifre=""
    #traduce el mensaje binario a caracteres
    msgbin_original.scan(/.{1,8}/).map do |character|
      descifre<< character.to_i(2).chr
      @c_descifrada=descifre
    end
    @c_descifrada
  end
end