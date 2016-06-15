class Fiat_shamir
  attr_accessor :p,:q,:s
  def initialize(p,q,s)
    @p,@q,@s,@primo=p,q,s,true
  end
  def fi
    t_phi=(@p.to_i-1)*(@q.to_i-1)
    t_phi
  end
  def n
    t_n=@p.to_i*q.to_i
    t_n
  end
  def xs(x,s)
    t_xs=x.to_i*s.to_i
    t_xs
  end
  def entero(x)
    t_entero=x.to_i
    t_entero
  end
  def producto(a,v)
    t_producto=a.to_i*v.to_i
    t_producto
  end
  def cuadrado(y)
    t_cuadrado=y.to_i**2
    t_cuadrado
  end
  def modulo(y,n)
    t_modulo=y.to_i%n.to_i
    t_modulo
  end
  #metodo que realiza el test de lehman peralta para calcular si dos numeros son coprimos.
  def lehman_peralta(numero)
    num=numero.to_i
    n_aleatorios,t_primo,i,exponente,contador=[],[],1,(num-1)/2,0
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
  #metodo que realiza el algoritmo de euclides extendido
  def euclides_extendido(a,b)

    x,z=[],[]
    t_primo=false
    #condicion para comprobar si el numero b es mayor que a si es asi se hace un swap
    if(b.to_i>a.to_i)
      x[1],x[2]=b.to_i,a.to_i
    else
      x[1],x[2]=a.to_i,b.to_i
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
        if(i>=2)
          #puts "entre..."
          z[i]=(-1*((x[i-1]/x[i]).to_i))*z[i-1]+z[i-2]
          x[i+1]=x[i-1]%x[i]
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
    #puts "MCD: #{mcd}"
    t_primo
  end
  #algoritmo de exponenciacion rápida
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
    #puts x
    x
  end
end