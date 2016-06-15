require "./clases/vernam.rb"
require "./clases/vigenere.rb"
require "./clases/rc4.rb"
require "./clases/spritz.rb"
require "./clases/A5.rb"
require "./clases/rijndael.rb"
require "./clases/diffie-hellman.rb"
require "./clases/rsa.rb"
require "./clases/fiat-shamir.rb"
#metodo para crear el mensaje en el algoritmo de cifrado A5


$t_cad,$t_cad2,$t_key1,$t_key2,$t_cad_cifrada,$t_cad_descifrada="","","","","",""
#variables utilizadas para rsa

class Mensaje
  attr_accessor :mens
  def initialize()
    @mens=""
  end
  def crea_mensaje(x)
    tamanio=x.to_i
    tamanio.times do
     aleatorio= rand(0..1)
    @mens<< aleatorio.to_s
    end
    @mens
  end
end
#clase para crear los vectores uilizados en el algoritmo de rsa
class Vectores
  def initialize()
    @claves,@mensajes=[],[]
  end
end
Shoes.app title: 'ALL IN PROJECT',:position=>"center", height: 600 do
  background lightgreen..lightskyblue, :angle => 30
  border("#BE8",
         strokewidth: 3)
  #background('img/fondo.jpg')
  @list = ["VERNAM","VIGENERE","RC4","SPRITZ","A5/1","RIJNDAEL (AES128)","DIFFIE-HELLMAN","RSA","FIAT-SHAMIR"]
  @result = []
  stack do
    title "ELIGE EL ALGORITMO A UTILIZAR", font: "sans", size: 15,:margin =>[125,25,10,25]

    @list.map! do |name|

      flow { @c = radio; para name, width: 500, font: "sans", size: 10 ,stroke: red}
      [@c, name]
    end
    flow do
      button "Ok" do
        selected = @list.map{|c, n| n if c.checked?}.compact
        @result[0].text = "ALGORITMO SELECCIONADO #{selected}"

        #===================================================================================
        #VENTANA PARA CIFRADO VERNAM
        #===================================================================================
        if(selected[0].upcase=="VERNAM")
          window :height => 800,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack  :margin=> ["25%",0,"25%",0] do
              title "\nCIFRADO VERNAM\n"
              para  "introduce la cadena"
              @cadena=edit_line
              button "ok" do
                encriptado=Vernam.new(@cadena.text)
                cad_binaria=encriptado.binario()
                alert cad_binaria
                random=encriptado.aletorio(cad_binaria)
                alert random
                a_xor=encriptado.op_xor(cad_binaria,random)
                alert a_xor
                cad_cifrada=encriptado.cifrar_bin(a_xor)
                alert cad_cifrada
                cifrada=cad_cifrada.force_encoding('iso-8859-1').encode('utf-8')
                alert cifrada.text
                t_cad,t_cad_cifrada=@cadena.text,cifrada.text
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{@cadena.text}\n cadena en binario: #{cad_binaria}\n
                    Aleatorio genereado:#{random} Cadena cifrada: #{cifrada}\n"
              end
            end
            stack :margin=> ["25%",0,"25%",0] do
              title "DESCRIFRADO DE CADENAS.\n"
              button "ok" do
                cad_descifrada=encriptado.descifra(cifrada,random)
                alert cad_descifrada
                alert "RESULTADOS DEL DESCIFRADO: \n cadena entrada: #{cifrada}\n aleatorio de entrada: #{random}\n
                      Cadena descifrada: #{cad_descifrada}\n"
              end
            end
            stack :margin=> ["25%",0,"25%",0]do
              button "MOSTRAR TODOS LOS RESULTADOS" do
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{@cadena.text}\n cadena en binario: #{cad_binaria}\n
                                                            Aleatorio genereado:#{random} Cadena cifrada: #{cifrada}\n
                       RESULTADOS DEL DESCIFRADO: \n cadena entrada: #{cifrada}\n aleatorio de entrada: #{random}\n
                      Cadena descifrada: #{cad_descifrada}\n"
              end
              button ("Atrás") {close}
            end
          end
        end

        #===================================================================================
        #VENTANA PARA CIFRADO VIGENERE
        #===================================================================================
        if(selected[0].upcase=="VIGENERE")
          window :height => 800, :position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\nCIFRADO VIGENERE"
              para "PARA INTRODUCIR LOS DATOS, INSTRODUCIRLOS COMO TEXTO"
              para  "introduce la cadena"
              @cadena=edit_line
              para "introduce la clave"
              @key=edit_line

              button "ok" do
                #alert "entre..."
                encriptado=Vigenere.new(@cadena.text,@key.text)
                #alert encriptado.mensaje
                comprueba=encriptado.comprueba
                if(comprueba==0)
                  cad_cifrada=encriptado.cifrar
                  #alert cad_cifrada
                else
                  alert "CARACTER NO VALIDO"
                  #puts"\n ERROR, DETECTADO CARACTER NO VALIDO"
                end
                t_cad,t_ke1,t_cad_cifrada=@cadena.text,@key.text,cad_cifrada

                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{@cadena.text}\n key entrada: #{@key.text}\n Mensaje cifrado: #{cad_cifrada}"
              end
             end
            stack :margin=> ["25%",0,"25%",0] do
              title "DESCRIFRADO DE CADENAS."
              para  "introduce la cadena"
              @cadena2=edit_line
              para "introduce la clave"
              @key2=edit_line
              button "ok" do
                #alert "entre..."
                encriptado2=Vigenere.new(@cadena2.text,@key2.text)
                #alert encriptado2.mensaje
                comprueba=encriptado2.comprueba
                if(comprueba==0)
                  cad_descifrada=encriptado2.descifrar
                else
                  alert "CARACTER NO VALIDO"
                  #puts"\n ERROR, DETECTADO CARACTER NO VALIDO"
                end
                t_cad2,t_key2,t_cad_descifrada=@cadena2.text,@key2.text,cad_descifrada
                alert "RESULTADOS DEL DESCIFRADO: \n cadena entrada: #{@cadena2.text}\n key entrada: #{@key2.text}\n Mensaje cifrado: #{cad_descifrada}"
              end
            end
            stack :margin=> ["25%",0,"25%",0] do
              button "MOSTRAR TODOS LOS RESULTADOS" do
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{t_cad}\n key entrada: #{t_key1}\n Mensaje cifrado: #{t_cad_cifrada}
                      \nRESULTADOS DEL DESCIFRADO: \n cadena entrada: #{t_cad2}\n key entrada: #{t_key2}\n Mensaje cifrado: #{t_cad_descifrada}"
              end
              button ("Atrás") {close}
            end
          end
        end

        #===================================================================================
        #VENTANA PARA CIFRADO RC4
        #===================================================================================
        if(selected[0].upcase=="RC4")
          window :height => 600,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\nCIFRADO RC4"
              para "LOS DATOS SE INSERTAR NUMÉRICOS SEGUIDOS DE COMAS:EJEMPLO MENSAJE: 1,34 Y CLAVE: 2,5"
              para  "introduce la cadena"
              @cadena=edit_line
              para "introduce la clave"
              @key=edit_line
              button "ok" do
                rc4=Rc4.new(@cadena.text,@key.text)
                rc4.binario()
                rc4.intercambio
                cad_cifrada=rc4.cifrar()
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{@cadena.text}\n key entrada: #{@key.text}\n Mensaje cifrado: #{cad_cifrada}"
              end
              button ("Atrás") {close}
            end
          end
        end

        #===================================================================================
        #VENTANA PARA CIFRADO SPRITZ
        #===================================================================================
        if(selected[0].upcase=="SPRITZ")
          window :height => 600,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\nCIFRADO SPRITZ"
              para "LOS DATOS SE INSERTAR NUMÉRICOS SEGUIDOS DE COMAS:EJEMPLO MENSAJE: 1,34 Y CLAVE: 2,5"
              para  "introduce la cadena"
              @cadena=edit_line
              para "introduce la clave"
              @key=edit_line
              button "ok" do
                spritz=Spritz.new(@cadena.text,@key.text)
                spritz.binario()
                spritz.intercambio
                cad_cifrada=spritz.cifrar()
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{@cadena.text}\n key entrada: #{@key.text}\n Mensaje cifrado: #{cad_cifrada}"
              end
              button ("Atrás") {close}
            end
          end
        end

        #===================================================================================
        #VENTANA PARA CIFRADO A5
        #===================================================================================
        if(selected[0].upcase=="A5/1")
          window :height => 600,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\nCIFRADO A5/1"
              para "MENSAJE CREADO ALEATORIAMENTE SEGUN EL TAMAÑO QUE SE INTRODUZCA"
              para  "introduce tamaño cadena"
              @tamanio=edit_line
              @m2=Mensaje.new()
              i=0
              button "ok" do
                mensaje=@m2.crea_mensaje(@tamanio.text)
                a5=A5.new(mensaje)
                while(i<mensaje.length)
                  a5.salida
                  a5.xor
                  a5.mayoria
                  a5.movimiento
                  i+=1
                end
                cad_cifrada=a5.cifrado
                alert "RESULTADOS DEL CIFRADO: \n cadena entrada: #{mensaje}\n  Mensaje cifrado: #{cad_cifrada}"
              end
              button ("Atrás") {close}
            end
          end
        end

        #===================================================================================
        #VENTANA PARA CIFRADO AES
        #===================================================================================
        if (selected[0].upcase=="RIJNDAEL (AES128)")
          window :height => 600,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\n CIFRADO RIJNDAEL (AES 128 BITS)"
              para "introduce mensaje EN DECIMAL SEPARADO DE ESPACIOS:"
              @cadena=edit_line
              para "introduce la clave"
              @key=edit_line
              button "ok" do
                aes=Rijndael.new(@cadena.text,@key.text)

                aes.hexadecimal()
                round=aes.roundkey()
                #puts "ROUNDKEY: #{round}"
                aes.mostrarsubclave(0)
                for i in 0...9
                  sub=aes.subbytes()
                  row=aes.shiftrow()
                  mix=aes.mixcolumn()
                  aes.expansionclave(i)
                  aes.mostrarsubclave(i)
                end
                aes.subbytes()
                aes.shiftrow()
                aes.expansionclave(9)
                aes.addroundkey()
                aes.mostrarsubclave(9)
                cad_cifrada=aes.textocifrado()
                alert "RESULTADOS DEL CIFRADO \n Mensaje cifrado: #{cad_cifrada}"
              end
            end
            button ("Atrás") {close}
          end
        end

        #===================================================================================
        #VENTANA PARA ALGORITMO DE DIFFIE-HELLMAN
        #===================================================================================
        if (selected[0].upcase=="DIFFIE-HELLMAN")
          window :height => 800,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\n ALGORITMO DIFFIE-HELLMAN "
              para "Introduce secreto A"
              @secreto1=edit_line
              para "Introduce secreto B"
              @secreto2=edit_line
              para "Introduce número primo"
              @n_primo=edit_line
              para "Introduce número Alfa"
              @n_alfa=edit_line
              button "ok" do
                diffie_hellman=Diffie.new(@secreto1.text,@secreto2.text,@n_primo.text,@n_alfa.text)
                #metodo para generar y_a
                y_a=diffie_hellman.exponenciacion(@n_alfa.text,@secreto1.text,@n_primo.text)
                alert y_a
                #metodo para generar y_b
                y_b=diffie_hellman.exponenciacion(@n_alfa.text,@secreto2.text,@n_primo.text)
                alert y_b
                #metodos para generar la clave (que debe ser igual)
                k_a=diffie_hellman.exponenciacion(y_b,@secreto1.text,@n_primo.text)
                k_b=diffie_hellman.exponenciacion(y_a,@secreto2.text,@n_primo.text)
                alert k_b
                alert k_b
                if k_a==k_b
                  alert "entro..."
                  clave=k_a
                  alert clave

                end
                alert "RESULTADOS DEL ALGORITMO \n Y_a: #{y_a}\n Y_b: #{y_b}\n Clave: #{clave}"
              end
            end
            button ("Atrás") {close}
           end
        end

        #===================================================================================
        #VENTANA PARA ALGORITMO DE RSA
        #===================================================================================


        if (selected[0].upcase=="RSA")
          window :height => 800,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\n ALGORITMO RSA "
              para "Introduce Mensaje a cifrar"
              @mensaje=edit_line
              para "Introduce P"
              @p=edit_line
              para "Introduce Q"
              @q=edit_line
              para "Introduce D"
              @d=edit_line
              button "ok" do
                rsa=Rsa.new(@mensaje.text,@p.text,@q.text,@d.text)
                n_primo1=rsa.lehman_peralta(@p.text)
                n_primo2=rsa.lehman_peralta(@q.text)
                phi=rsa.fi
                n=rsa.n
                n_primo3=rsa.euclides_extendido(@d.text,phi)
                if (n_primo1== true && n_primo2== true && n_primo3==true)
                  j=rsa.obtenerj(n)
                  t_codif=rsa.codif_numerica
                  claves=[]
                  mensaje=[]
                  #incializacion del vector de claves para luego realizar el algoritmo de exponenciacion rapida
                  for i in 0...t_codif.length
                    claves[i],mensaje[i]=0
                  end
                  inverso=rsa.inverso
                  for i in 0...t_codif.length
                    claves[i]=rsa.exponenciacion(t_codif[i],inverso,n)
                  end
                  m_cifrado=[]
                  claves.each do |i|
                    m_cifrado << i.to_s
                  end
                  #para el descifrado seria pasando las claves
                  for i in 0...t_codif.length
                    mensaje[i]=rsa.exponenciacion(claves[i],@d.text,n)
                  end
                  m_descifrado=[]
                  mensaje.each do |i|
                    m_descifrado << i.to_s
                  end
                  alert "RESULTADOS DEL ALGORITMO \n Mensaje cifrado: #{m_cifrado}\n Mensaje descifrado: #{m_descifrado}"
                else
                  alert "LOS NUMEROS P,Q Y D DEBEN SER PRIMOS"
                end
              end
            end
            button ("Atrás") {close}
          end
        end

        #===================================================================================
        #VENTANA PARA ALGORITMO DE FIAT-SHAMIR
        #===================================================================================
        if (selected[0].upcase=="FIAT-SHAMIR")
          window :height => 800,:position=>"center" do
            background lightgreen..lightskyblue, :angle => 30
            border("#BE8",
                   strokewidth: 3)
            stack :margin=> ["25%",0,"25%",0] do
              title "\n ALGORITMO FIAT-SHAMIR "
              s,x=0,0
              para "Introduce P"
              @p=edit_line
              para "Introduce Q"
              @q=edit_line
              button "ok" do
                fiatshamir=Fiat_shamir.new(@p.text,@q.text,s)
                n_primo1=fiatshamir.lehman_peralta(@p.text)
                n_primo2=fiatshamir.lehman_peralta(@q.text)
                if (n_primo1== true && n_primo2== true )
                  #alert "P Y Q SON PRIMOS"
                  phi=fiatshamir.fi
                  n=fiatshamir.n
                  para "Introduce S"
                  @s=edit_line
                  #while @s.text >n
                   # puts "introduce s: "
                    #s=gets.chomp.to_i
                  #end
                  para "Número de iteraciones"
                  @iteraciones=edit_line
                  button "ok" do
                    #alert "N= #{n}, S= #{@s.text}"
                    n_primo3=fiatshamir.euclides_extendido(n,@s.text)
                    if(n_primo3==true)
                      v=0
                      v=fiatshamir.exponenciacion(@s.text,2,n)
                      #alert "v= #{v}"
                      contador=0
                      valido=0
                      t_i=fiatshamir.entero(@iteraciones.text)
                      #alert t_i
                      while(contador<t_i || valido==1)
                        para "valor de X"
                        @x=edit_line
                        a=fiatshamir.exponenciacion(@x.text,2,n)
                        #alert "a=#{a}"
                        para "valor de E"
                        @e=edit_line
                        button "ok" do
                          if @e.text=="0"
                            y=fiatshamir.exponenciacion(@x.text,1,n)
                            puts "y= #{y}"
                          elsif @e.text=="1"
                            xs=fiatshamir.xs(@x.text,@s.text)
                            alert "xs=#{xs}"
                            y=fiatshamir.exponenciacion(xs,1,n)
                            alert "y=#{y}"
                          end
                          #verificacion
                          if @e.text=="0"
                            #puts "FASE DE VERIFICACION"
                            alert "verificacion..."
                            #y=fiatshamir.exponenciacion(a,1,n)
                            validacion=fiatshamir.exponenciacion(a,1,n)
                            #puts "Validacion=#{validacion}"
                            #alert "y=#{y}"
                            t_cuadrado=fiatshamir.cuadrado(y)
                            t_modulo=fiatshamir.modulo(t_cuadrado,n)
                            alert "tcuadrado=#{t_cuadrado},tmoduiulo=#{t_modulo}, validacion= #{validacion}"
                            if(t_modulo==validacion)
                              #puts "#{y}^2 mod #{n} = #{validacion}mod #{n}"
                              #puts "iteracion valida..."
                              alert "iteracion valida"
                              alert "RESULTADOS DEL ALGORITMO \n N= #{n}\n V= #{v}\n Y= #{y}\n "
                            else
                              alert "iteracion no valida"
                              valido=1

                            end
                          elsif @e.text=="1"
                            #puts "FASE DE VERIFICACION"
                            alert "verificacion..."
                            t_producto=fiatshamir.exponenciacion(a,v)
                            validacion=fiatshamir.exponenciacion(t_producto,1,n)
                            #puts "V=#{validacion}"
                            alert "tproducto=#{t_producto}, validacion= #{validacion}"
                            t_cuadrado=fiatshamir.cuadrado(y)
                            t_modulo=fiatshamir.modulo(t_cuadrado,n)
                            alert "tproducto=#{t_producto},tmoduiulo=#{t_modulo}, validacion= #{validacion}"
                            if(t_modulo==validacion)
                              alert "iteracion valida"
                              alert "RESULTADOS DEL ALGORITMO \n N= #{n}\n V= #{v}\n Y= #{y}\n "
                            else

                              alert "iteracion no valida"
                              valido=1
                            end
                          end
                        end
                        contador+=1
                      end
                    else
                      alert "S no es coprimo con N"
                    end

                  end

                else
                  alert "LOS NUMEROS DEBEN SER PRIMOS Y NO ES ASI."
                end

              end
            end
            button ("Atrás") {close}
          end
        end
      end
      button("Salir") {exit}
    end
    @result << para('', :stroke => forestgreen)
  end
  stack :margin=> "0.1" do
    title("All In Project",
          align:  "center",
          font:   "Trebuchet MS",
          stroke: "#1E7997")
    para "Pedro Manuel Ramos Rodríguez\nAsignatura: Seguridad Sistemas Informáticos\nItenerario 5 Tecnologías de la Información\nGrado de Ingrniería Informática ULL"
  end
end