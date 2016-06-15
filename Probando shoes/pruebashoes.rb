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
Shoes.app title: 'Selecteer vakantie', height: 600 do
  background lightgreen..lightskyblue, :angle => 30
  @list = ["VERNAM","VIGENERE","RC4","SPRITZ","A5/1","RIJNDAEL (AES128)","DIFFIE-HELLMAN","RSA","FIAT-SHAMIR"]
  @result = []
  stack do
    para "ELIGE EL ALGORITMO A UTILIZAR.", font: "sans", size: 10

    @list.map! do |name|
      flow { @c = radio; para name, width: 500, font: "sans", size: 10 }
      [@c, name]
    end
    flow do
      button "Ok" do
        selected = @list.map{|c, n| n if c.checked?}.compact
        @result[0].text = "ALGORITMO SELECCIONADO #{selected}"
=begin
        #===================================================================================
        #VENTANA PARA CIFRADO VERNAM
        #===================================================================================
        if(selected[0].upcase=="VERNAM")
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
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
            stack :margin=> "0.1"do
              title "DESCRIFRADO DE CADENAS.\n"
              button "ok" do
                cad_descifrada=encriptado.descifra(cifrada,random)
                alert cad_descifrada
                alert "RESULTADOS DEL DESCIFRADO: \n cadena entrada: #{cifrada}\n aleatorio de entrada: #{random}\n
                      Cadena descifrada: #{cad_descifrada}\n"
              end
            end
            stack :margin=> "10%"do
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
=end

        #===================================================================================
        #VENTANA PARA CIFRADO VIGENERE
        #===================================================================================
        if(selected[0].upcase=="VIGENERE")
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
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
            stack :margin=> "0.1"do
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
            stack :margin=> [0,10,0,0] do
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
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
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
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
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
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
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
=begin
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
=end
        #===================================================================================
        #VENTANA PARA CIFRADO AES
        #===================================================================================
        if (selected[0].upcase=="RIJNDAEL (AES128)")
          window :height => 1200, :width => 1024 do
            stack :margin=> "0.1"do
              title "\nCIFRADO RIJNDAEL (AES 128 BITS)"
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
                  #puts "SUBBYTES: #{sub}"
                  row=aes.shiftrow()
                  #puts "SHIFTROW: #{row}"
                  mix=aes.mixcolumn()
                  #puts "MIXCOLUMN: #{mix}"
                  aes.expansionclave(i)
                  #round=aes.addroundkey()
                  #puts "ROUNDKEY: #{round}"
                  aes.mostrarsubclave(i)
                end
                aes.subbytes()
                aes.shiftrow()
                aes.expansionclave(9)
                aes.addroundkey()
                aes.mostrarsubclave(9)
                cad_cifrada=aes.textocifrado()
                alert "RESULTADOS DEL CIFRADO: Mensaje cifrado: #{cad_cifrada}"
              end
            end
          end
        end

      end
      button("End") {exit}
    end
    @result << para('', :stroke => forestgreen)
  end
end