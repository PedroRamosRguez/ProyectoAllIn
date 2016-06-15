class A5
  attr_accessor :s1,:s2,:s3,:s1_2,:s2_2,:s3_2,:a,:b,:c,:z,:op_xor1,:op_xor2,:op_xor3,:f_mayoria,:z
  def initialize(men)#,sem1,sem2,sem3)
    #def initialize
    #Creación de los vectores de las diferentes semillas recibidas por teclado.
    sem1="1001000100011010001"
    sem2="0101100111100010011010"
    sem3="10111100110111100001111"
    @mensaje=men.split(//)
    @s1=sem1.split(//)
    @s2=sem2.split(//)
    @s3=sem3.split(//)
    @a,@b,@c=0,0,0
    @z=[]     #vector donde se guardará la salida de las operaciones xor del bit más identificativo.
    #diferentes operaciones xor en los diferentes vectores
    @op_xor1=0
    @op_xor2=0
    @op_xor3=0
    @f_mayoria=0
    @z=[]
    puts "\n vectores al inicio"
    #puts "\n============================================================================="
    p @s1
    p @s2
    p @s3
    p @mensaje
    #puts "\n============================================================================="
  end
  #metodo que realizara la operacion xor de los bits más significativos para producir la secuencia cifrante
  def salida
    @a,@b,@c=@s1[10].to_i(2),@s2[11].to_i(2),@s3[12].to_i(2)
    t_x=(@s1[0].to_i(2)^@s2[0].to_i(2)^@s3[0].to_i(2)).to_s(2)
    puts "\n salida= #{t_x}"
    @z << t_x.to_i
  end
  #metodo que realiza la xor entre los diferentes bits de la funcion dada.
  def xor
    x1,x1_2,x1_3,x1_4=s1[0],s1[1],s1[2],s1[5] #posiciones del vector1 donde se realizara la xor.
    x2,x2_1=s2[0],s2[1]                       #posiciones del vector2 donde se realizará la xor.
    x3,x3_1,x3_2,x3_3=s3[0],s3[1],s3[2],s3[15]     #posiciones del vector3 donde se realizara la xor.
    @op_xor1=(x1.to_i(2)^x1_2.to_i(2)^x1_3.to_i(2)^x1_4.to_i(2)).to_s(2)
    @op_xor2=(x2.to_i(2)^x2_1.to_i(2)).to_s(2)
    @op_xor3=(x3.to_i(2)^x3_1.to_i(2)^x3_2.to_i(2)^x3_3.to_i(2)).to_s(2)
    #print "\n opxor1= #{@op_xor1}"
    #print "\n opxor2= #{@op_xor2}"
    #print "\n opxor3= #{@op_xor3}"
  end

  #metodo que calcula la funcion mayoria para realizar posteriormente el movimiento de los vectores que coincidan con ese valor obtenido
  def mayoria
    @a,@b,@c=@s1[10].to_i(2),@s2[12].to_i(2),@s3[12].to_i(2)
    f1=@a*@b
    f2=@a*@c
    f3=@b*@c
    @f_mayoria=f1^f2^f3
    print "\n mayoria= #{@f_mayoria}\n"
  end
  #metodo para comparar si se mueve o no un vector
  def movimiento


    if (@a.to_i==@f_mayoria) && (@b.to_i==@f_mayoria) && (@c.to_i==@f_mayoria)
      print "\n se mueven los tres."
      @s1 << @op_xor1
      @s1.shift    #elimina la primera posicion del vector
      @s2 << @op_xor2
      @s2.shift    #elimina la primera posicion del vector
      @s3 << @op_xor3
      @s3.shift    #elimina la primera posicion del vector
    elsif (@a.to_i==@f_mayoria) && (@b.to_i==@f_mayoria)
      print "\n se mueven 1 y 2."
      @s1 << @op_xor1
      @s1.shift    #elimina la primera posicion del vector
      @s2 << @op_xor2
      @s2.shift    #elimina la primera posicion del vector
    elsif (@a.to_i==@f_mayoria) && (@c.to_i==@f_mayoria)
      print "\n se mueven 1 y 3."
      @s1 << @op_xor1
      @s1.shift    #elimina la primera posicion del vector
      @s3 << @op_xor3
      @s3.shift   #elimina la primera posicion del vector
    elsif (@b==@f_mayoria) && (@c==@f_mayoria)
     #print "\n se mueven 2 y 3."
      @s2 << @op_xor2
      @s2.shift    #elimina la primera posicion del vector
      @s3 << @op_xor3
      @s3.shift    #elimina la primera posicion del vector
    else
      puts "\n ninguno se mueve."
    end
=begin
    puts "\n vectores al final"
    puts "\n============================================================================="
    p @s1
    p @s2
    p @s3
    puts "\n============================================================================="
=end
  end
  #metodo que realiza el cifrado
  def cifrado
    i=0
    t_z=[]
    t_xor=0
    while i< @z.length
      #print "\n MENSAJE ORIGINAL: #{@mensaje[i].to_i(2)}"
      #print "\n SECUENCIA CIFRANTE: #{@z[i]}"
      t_xor=(@mensaje[i].to_i^ @z[i].to_i).to_s(2)
      #print "\n SECUENCIA  CIFRADA: #{t_xor}"
      t_z << t_xor
      i+=1
    end
    t_z
  end
end








