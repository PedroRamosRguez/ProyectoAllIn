class Rsa
  attr_accessor :mensaje,:p,:q,:d, :inverso, :n_cifrado
  def initialize(mensaje,p,q,d)
    @mensaje=mensaje.delete(' ').upcase.split(//)
    @p=p
    @q=q
    @d=d
    @primo=true
    @inverso=0
    #tamaño del bloque en el que se divide el mensaje
    @longitud=0
    @alfabeto=('A'..'Z').to_a
    @n_cifrado=[]
  end
  #metodo que realiza el test de lehman peralta para calcular si dos numeros son primos.
  def lehman_peralta(numero)
    num=numero
    n_aleatorios=[]
    t_primo=[]
    i=1
    exponente=(num-1)/2
    contador=0      #contador para contar si todos los modulos son = a 1 y rechazar que sea primo
    while i<num
      n_aleatorios[i]=rand(1..num-1)
      #puts "aleatorio creado: #{n_aleatorios[i]}"
      i+=1
    end
    for j in 1...num
      t_primo[j]=(n_aleatorios[j]**exponente)%num
      #condicion para que de -1 en caso de que de la operacion con el modulo un numero (num-1).Ej 6%7
      if(t_primo[j]>1)
        t_primo[j]=t_primo[j]-num
      end
    end

    #puts "t_primo=#{t_primo}"

    for j in 1...t_primo.length
      #puts "t_primo[j]=#{t_primo[j]}"
      if(t_primo[j]==1)
        contador+=1
      elsif t_primo[j]!=1 && t_primo[j]!=-1
        @primo=false
      end
    end
    if contador==t_primo.length-1
      @primo=false
    end
    @primo
  end

  #algoritmo de mcd de euclides extendido.

  def euclides_extendido(a,b)
    #condicion para comprobar si el numero b es mayor que a si es asi se hace un swap
    x,z=[],[]
    t_primo=false
    if(b>a)
      x[1],x[2]=b,a
    else
      x[1],x[2]=a,b
    end
    z[0],z[1]=0,1
    i=1
    r=x[1]%x[2]
    #puts "resto al comienzo: #{r}"
    if r==0
      t_primo=false
    else
      while(r>0)
        #puts "#{"="*30}"
        #puts "ITERACION #{i}"
        #puts "x[i-1]=#{x[i-1]}"
        #puts "x[i]=#{x[i]}"
        #puts "z[i-1]=#{z[i-1]}"
        #puts "z[i]=#{z[i]}"
        if(i>=2)
          #puts "entre..."
          z[i]=(-1*((x[i-1]/x[i]).to_i))*z[i-1]+z[i-2]
          x[i+1]=x[i-1]%x[i]
          #puts "z[i]=#{z[i]}"
          #puts "x[i+1]=#{x[i+1]}"
        end
        r=x[i+1]
        mcd=x[i]
        if(mcd==1)
          t_primo=true
          #en caso de que el inverso de negativo, se suma al numero mayor que se paso a la función.
          if(z[i-1]<0)
            @inverso=z[i-1]+x[1]
          else
            @inverso=z[i-1]
          end
        end
        i+=1
        #puts "#{"="*30}"
      end

    end
    puts "MCD: #{mcd}"
    puts "INVERSO: #{@inverso}"
    t_primo
  end
  def obtenerj(n)
    j,x=1,26
    while x<n
      #puts "==============="
      #puts "j= #{j}"
      #puts "x= #{x}"
      x=@alfabeto.length**j
      #puts "x= #{x}"
      j+=1
      #puts "==============="
    end
    #la j que se devuelve es j-1 pero como al final del bucle se aumente se le resta otro.
    @longitud=j-2
    j-2
  end
  def codif_numerica()
    t_mensaje=@mensaje
    #puts "t_mensaje= #{t_mensaje}"
    t_codificacion=""
    t_vector=[]
    t_contador,x,j=0,0,0
    exponente=(@longitud-t_contador)-1
    #Se inicializa el vector todo a 0.
    while j < (@mensaje.length/@longitud).to_i
      t_vector[j]=0
      j+=1
    end

    for i in 0..t_mensaje.length-1
      #puts "==============="
      #condicion para que si contador es mayor a la longitud se resetee.
      if(t_contador>=@longitud)
        t_contador=0
        exponente=(@longitud-t_contador)-1
        x+=1
      end
      #puts "#{@alfabeto.index(t_mensaje[i])}"
      valorcaracter= @alfabeto.index(t_mensaje[i])
      #puts "valor=#{valorcaracter}"
      t_vector[x]+=(valorcaracter)*(26**exponente)
      #puts "t_vector[x]=#{t_vector[x]}"
      t_contador+=1
      #al exponente se resta 1 (ya que va de mayor a menor exponente)
      exponente=exponente-1
      #puts "==============="
    end
    #puts "#{t_vector}"
    @n_cifrado=t_vector
  end

  def exponenciacion(a,b,c)
    contador=0      #contador utilizado para mostrar las claves que se generan.
    t_k=b.to_i      #un temporal con el valor del exponente para ir reduciendolo.
    x=1             #variable donde se guardara el resultado final
    base=a.to_i        #una variaable auxiliar que guarda el valor de la base recibida por parametro
    while(t_k>0)&&(base>1)
      if(t_k%2==0)
        base=(base*base)%c.to_i
        t_k=t_k/2
      else
        x=(x*base)%c.to_i
        t_k=t_k-1
      end

      #puts "\n valor en i_#{contador}:#{x} "

      contador+=1
    end
    x
  end
end