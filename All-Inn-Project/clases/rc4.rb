class Rc4
  attr_accessor :a,:s,:k,:m,:t,:xor,:mensaje,:clave
  def initialize(mensaje,clave)
    @clave=clave.split(' ')
    @mensaje=mensaje.split(' ')
    @s=[]                  #vector para guardar los enteros en binarios
    @k=[]      #vector usado para meter los caracteres de la clave.
    @m=[]      #vector para guardar el emnsaje en binario
    @a=(0..255).to_a      #vector de numeros enteros
    @t=0
    @xor=0
  end
  #metodo que crea los vectores de bytes.
  def binario()
    #crea el array de 0-255 en bytes

    @a.each do |i|
      @s << sprintf("%08b", i)
    end
    #bucle para crear el vector de la clave hasta 255 posiciones

    while k.size < 256
      @clave.each do |i|
        regex= i.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
        if regex==false
          t_k=i.split("")
          t_k.each do |j|
            k << j.unpack("B*").first
          end
        else
          @k << sprintf("%08b", i)
        end
      end
    end
    #crea un vector del tamaño del mensaje  en bytes.
    @mensaje.each do |i|
      #expresion regular para controlar si lo que se detecta es un caracer o numero para realizar diferentes conversiones.
      regex= i.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
      if regex==false
        t_m=i.split("")
        t_m.each do |j|
          m << j.unpack("B*").first
        end
      else
        @m << sprintf("%08b", i)
      end
    end
  end
  #metodo que desordena el array s(el que contiene los numeros desde 0-255 en binario)
  def intercambio
    j=0
    for i in 0..255
      j = (j + @k[i % @k.length].to_i(2) + s[i].to_i(2)) % 256;
      @s[i],@s[j]=@s[j],@s[i]                         #realiza el intercambio
    end
  end

  def cifrar
    i,f=0,0
    t_xor=[]
    longitud=@m.length     # esto deberia ser el texxto (pero en este caso no tengo texto...)
    #puts "\n -> s desordenado : #{@s}"
    while i <longitud
      i=(i+1)%256
      f=(f+s[i].to_i(2))%256 #se usa un temporal de f para recoger el valor anterior guardado.

      @s[i],@s[f]=@s[f],@s[i]
      @t=(@s[i].to_i(2)+@s[f].to_i(2))%256
      puts "\n#{'='*(a.size/2)}\n\n"
      puts "\n byte #{i} de secuencia cifrante: #{@s[t]}= #{@s[t].to_i(2)}"
      puts "\n byte #{i} de texto original: #{@m[i-1]}= #{@m[i-1].to_i(2)}"      #seria el caracter iesimo del mensaje
      @xor=(@m[i-1].to_i(2)^@s[t].to_i(2)).to_s(2).rjust(8,'0')
      puts "\n byte #{i} de texto cifrado #{@xor}= #{@xor.to_i(2)}"
      t_xor << @xor.to_i(2)
      puts "\n#{'='*(a.size/2)}\n\n"
    end
    t_xor
  end

end