class Diffie
  attr_accessor :mensaje1,:mensaje2,:n_primo,:n_alfa,:m1,:m2,:y_a,:y_b,:k
  def initialize(men1,men2,primo,alfa)
    @mensaje1=men1
    @mensaje2=men2
    @n_primo=primo
    @n_alfa=alfa
    @y_a=0
    @y_b=0
    @k=0
  end
#Metodo para obtener primero las y_a e y_b y posteriormente para obtener las diferentes K.
#Los paramatros pasados son: a=alfa(base),b=mensaje secreto(exponente) y c=numero primo introducido(numero por el que se realiza el modulo).
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
#metodo que se utilizara par la modificación (permitir comunicacion con mas de dos individuos)
  def modificacion(a,b,c)

  end



end