class Rijndael
  attr_accessor :mensaje,:clave,:m,:k,:m_mensaje,:m_clave,:m_addround,:m_final,:texto_cifrado
  def initialize(clave,mensaje)
    @mensaje=mensaje.split(' ')
    @clave=clave.split(' ')
    @m=[]
    @k=[]
    @m_mensaje=[]
    @m_clave=[]
    @m_addround=[]
    @m_final=[]
    @texto_cifrado=""
    puts "\n MENSAJE EN BLOQUE: #{@mensaje}"
    puts "\n CLAVE EN BLOQUE: #{@clave}"
  end
  #metodo que pasa a hexadecimal el mensaje y clave recibidos por teclado.
  def hexadecimal
    while k.size < @clave.size
      @clave.each do |i|
        #expresion regular que controla si lo que recibe es un caracter numerico o no numerico.
        regex= i.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
        if regex==false
          t_k=i.split("")
          t_k.each do |j|
            k << j.unpack('U')[0].to_s(16)
          end
        else
          @k << sprintf("%02X", i)
        end
      end
    end
    #pasar a hexadecimal el mensaje
    @mensaje.each do |i|
      #expresion regular que controla si lo que recibe es un caracter numerico o no numerico. Y realizar la conversión de una manera u otra.
      regex= i.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
      if regex==false
        t_m=i.split("")
        t_m.each do |j|
          m << j.unpack('U')[0].to_s(16)
        end
      else
        @m << sprintf("%02X", i)
      end
    end
    puts "\n BLOQUE HEXADECIMAL DEL MENSAJE:#{@m}"
    puts "\n BLOQUE HEXADECIMAL DE LA CLAVE:#{@k}"
  end
  #metodo que crea la matriz 4x4 del mensaje.
  def matriz_mensaje
    @m_mensaje=Array.new(4){Array.new(4,'')}
    i,j,contador=0,0,0
    @m.each do |x|
      if(contador==4)
        contador=0
        i=0
        j+=1
      end
      @m_mensaje[i][j] = x
      #p a[i][j]
      i+=1
      contador+=1
    end
    @m_mensaje

  end
  #Metodo que crea la matriz 4x4 para la clave obtenida.
  def matriz_clave
    @m_clave=Array.new(4){Array.new()}
    i,j,contador=0,0,0
    @k.each do |x|
      if(contador==4)
        contador=0
        i=0
        j+=1
      end
      @m_clave[i][j] = x
      i+=1
      contador+=1
    end
    @m_clave
  end
  #metodo que crea las matrices para el mensaje y la clave y realiza el posterior xor entre las dos matrices.
  def roundkey
    #creacion de las matrices 4x4 para el mensaje y la clave
    m_m=self.matriz_mensaje
    c_m=self.matriz_clave
    @m_addround=Array.new(4){Array.new(4,0)}
    i,j,contador=0,0,0
    puts "\n #{m_m}"
    puts "\n #{c_m}"
    x=(m_m[i][j].to_i(16)^c_m[i][j].to_i(16)).to_s(16)

    while contador < 16
      if(j==4)
        j=0
        i+=1
      end
      x=(m_m[i][j].to_i(16)^c_m[i][j].to_i(16)).to_s(16).rjust(m_m[i][j].length,'0')
      @m_addround[i][j]=x
      j+=1
      contador+=1
    end
    #puts "\n MATRIZ ADD ROUND KEY RESULTANTE: #{@m_addround}"
    @m_addround
  end
  #metodo que realiza la transformación subbytes utilizando la caja S
  def subbytes
    t_v=[]
    i,j,contador=0,0,0
    @m_addround.each do |x|
      x.each do |y|
        z=get_sbox(y.to_i(16))
        t_v[i] = z.to_s(16).rjust(y.length,'0')
        i+=1
      end
    end
    i=0
    while(contador<16)
      if(j==4)
        j=0
        i+=1
      end
      @m_addround[i][j]=t_v[contador]
      contador+=1
      j+=1
    end
    #puts "\n MATRIZ RESULTANTE DE REALIZAR SUBBYTES: #{@m_addround}"
    @m_addround
  end
  #metodo que obtiene el elemento en la caja s
  def get_sbox(byte)
    sbox =
        # 0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
        [0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76, #0
         0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0, #1
         0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15, #2
         0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75, #3
         0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84, #4
         0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf, #5
         0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8, #6
         0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2, #7
         0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73, #8
         0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb, #9
         0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79, #A
         0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08, #B
         0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a, #C
         0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e, #D
         0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf, #E
         0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16] #F
    sbox[byte]
  end
  #matriz de constante de ronda.
  Rcon =  [[0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80,0x1b,0x36,0x6c,0xd8,0xab,0x4d],
           [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
           [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00],
           [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]]
  #metodo que realiza el shiftrow o cambio de las filas.
  def shiftrow
    #mover la fila 1
    #puts "\n ANTES DE SHIFTROW: #{@m_addround}"
    @m_addround[1][0],@m_addround[1][1],@m_addround[1][2],@m_addround[1][3]=@m_addround[1][1],@m_addround[1][2],@m_addround[1][3],@m_addround[1][0]
    @m_addround[2][0],@m_addround[2][1],@m_addround[2][2],@m_addround[2][3]=@m_addround[2][2],@m_addround[2][3],@m_addround[2][0],@m_addround[2][1]
    @m_addround[3][0],@m_addround[3][1],@m_addround[3][2],@m_addround[3][3]=@m_addround[3][3],@m_addround[3][0],@m_addround[3][1],@m_addround[3][2]
    #puts "\n DESPUES DE SHIFTROW: #{@m_addround}"
    @m_addround
  end
  #Metodo que realiza las operaciones de Galoi.
  def galoi(valor)
    valor= valor << 1
    h=valor & 0x100
    if (h== 0x100)
      valor^= 0x11b
    end
    valor
  end
  #metodo que realiza la operación mixcolumn
  def mixcolumn()
    for i in 0...4 do
      col0=( (galoi(@m_addround[0][i].to_i(16)))^(galoi(@m_addround[1][i].to_i(16))^(@m_addround[1][i].to_i(16)))^(@m_addround[2][i].to_i(16))^(@m_addround[3][i].to_i(16)))
      col1=((@m_addround[0][i].hex.to_s(2).rjust(8,'0').to_i(2))^(galoi(@m_addround[1][i].hex.to_s(2).rjust(8,'0').to_i(2)))^(galoi(@m_addround[2][i].hex.to_s(2).rjust(8,'0').to_i(2))^(@m_addround[2][i].hex.to_s(2).rjust(8,'0').to_i(2)))^(@m_addround[3][i].hex.to_s(2).rjust(8,'0').to_i(2)))
      col2=((@m_addround[0][i].hex.to_s(2).rjust(8,'0').to_i(2))^(@m_addround[1][i].hex.to_s(2).rjust(8,'0').to_i(2))^(galoi(@m_addround[2][i].hex.to_s(2).rjust(8,'0').to_i(2)))^(galoi(@m_addround[3][i].hex.to_s(2).rjust(8,'0').to_i(2))^(@m_addround[3][i].hex.to_s(2).rjust(8,'0').to_i(2))))
      col3=((galoi(@m_addround[0][i].hex.to_s(2).rjust(8,'0').to_i(2))^(@m_addround[0][i].hex.to_s(2).rjust(8,'0').to_i(2)))^(@m_addround[1][i].hex.to_s(2).rjust(8,'0').to_i(2))^(@m_addround[2][i].hex.to_s(2).rjust(8,'0').to_i(2))^(galoi(@m_addround[3][i].hex.to_s(2).rjust(8,'0').to_i(2))))
      @m_addround[0][i]=col0.to_s(16).rjust(2,'0')
      @m_addround[1][i]=col1.to_s(16).rjust(2,'0')
      @m_addround[2][i]=col2.to_s(16).rjust(2,'0')
      @m_addround[3][i]=col3.to_s(16).rjust(2,'0')
    end
    #puts"\n MATRIZ RESULTANTES AL REALIZAR MIXCOLUMN: #{@m_addround}"
    @m_addround
  end
  #metodo que crea la expancison de claves.

  def expansionclave(iteracion)
    t_mclave=@m_clave
    aux=Array.new(4){Array.new(4)}
    #operacion del rotword (rotando la ultima columna de la matriz de las claves)
    aux[0][3],aux[1][3],aux[2][3],aux[3][3]=t_mclave[1][3],t_mclave[2][3],t_mclave[3][3],t_mclave[0][3]

    #relleno la matriz completa con los demas elementos de la matrz de la clave
    for i in 0...4
      for j in 0...3
        aux[i][j]=t_mclave[i][j]
      end
    end
    #se busca en la sbox los valores de la matriz
    aux[0][3],aux[1][3],aux[2][3],aux[3][3]=get_sbox(aux[0][3].to_i(16)).to_s(16).rjust(2,'0'),get_sbox(aux[1][3].to_i(16)).to_s(16).rjust(2,'0'),get_sbox(aux[2][3].to_i(16)).to_s(16).rjust(2,'0'),get_sbox(aux[3][3].to_i(16)).to_s(16).rjust(2,'0')
    #se realiza la operación de principal de la epansion de claves
    aux[0][0]=(@m_clave[0][0].to_i(16)^aux[0][3].to_i(16)^Rcon[0][iteracion]).to_s(16).rjust(2,'0')
    aux[1][0]=(@m_clave[1][0].to_i(16)^aux[1][3].to_i(16)^Rcon[1][iteracion]).to_s(16).rjust(2,'0')
    aux[2][0]=(@m_clave[2][0].to_i(16)^aux[2][3].to_i(16)^Rcon[2][iteracion]).to_s(16).rjust(2,'0')
    aux[3][0]=(@m_clave[3][0].to_i(16)^aux[3][3].to_i(16)^Rcon[3][iteracion]).to_s(16).rjust(2,'0')
    for i in 0...4
      for j in 1...4
        aux[i][j]=(@m_clave[i][j].to_i(16)^aux[i][j-1].to_i(16)).to_s(16).rjust(2,'0')
      end
    end

    @m_clave=aux
  end
  def addroundkey
    temporal=Array.new(4){Array.new(4)}
    for i in 0...4
      for j in 0...4
        temporal[i][j]=(@m_addround[i][j].to_i(16)^@m_clave[i][j].to_i(16)).to_s(16).rjust(2,'0')
      end

    end

    @m_addround=temporal

  end
  def mostrarsubclave(ronda)
    clave=""
    estado=""
    for i in 0...4
      for j in 0...4
        clave << @m_clave[j][i]

      end
    end
    for i in 0...4
      for j in 0...4
        estado << @m_addround[j][i]
      end
    end
    if ronda==0
      puts "\n ========================================================"
      puts "\n\t RONDA 0"
      puts "SUBCLAVE: #{clave}"
      puts "ESTADO = #{estado}"
      puts "\n ========================================================"
    else
      puts "\n ========================================================"
      puts "\n\t RONDA #{ronda+1}"
      puts "SUBCLAVE RONDA #{ronda+1}: #{clave}"
      puts "ESTADO EN LA RONDA #{ronda+1}= #{estado}"
      puts "\n ========================================================"
    end
    if ronda==9
      @texto_cifrado=estado
    end
  end
  def textocifrado()
    @texto_cifrado
  end
end






















