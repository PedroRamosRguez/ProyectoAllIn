=begin
class MyClass
  def initialize(app,text)
    @app = app
    text.para"te sobreescribi"
  end
  def draw
    @app.oval :top => 100, :left => 100, :radius => 30
  end
end

Shoes.app {
  @texto="hola"
  myclass = MyClass.new(self,@texto) # passing in the app here
  myclass.draw
}

class Post
  def self.print_author(shoes,text)
    shoes.para "The author of all posts is Jimmy"
    puts text
  end
end

Shoes.app do

    #para "Enter your name"
    @entrada=edit_line
    @para.text=@entrada.text
    @boton= button "OK"
  @push.click {
    Post.print_author(self,@entrada)
  }

end
=end
class Post
  attr_accessor :text2
  def initialize()
    @text2=""
    @text1=""
  end
  def print_author(text);
    puts text
    para text
  end
  def print2_author(text);
  @text2= text
    @text2
    para @text2
  end
end
class Post2
  attr_accessor :text2
  def initialize(x)
    @text2=x
  end
  def print_author(text);
  puts text
  end
  def print2_author(text);
  @text2= text
  @text2
  end
end
Shoes.app :height => 1024, :width => 768 do


  stack :width => "100%",:height => "10%", :margin => 10 do
    background blue
    title "PRUEBONA DEL PROGRAMA"
  end







  stack :width => "70%", :height => "25%",:margin => 10 do
      #background pink
    stack :margin => 15 do
      para"HOLA ESTO ES
      LA PARTE DEL MEDIO "
    end
      stack :margin => 15 do
        para"introduce cadena "
      end
      stack :margin => 10 do
        @pepe=edit_line
        @pepe2=Post2.new(@pepe.text)

        alert ("pepe2=#{@pepe2.text2}")
        #probando=@pepe2.print2_author(@pepe.text)
        #alert ("probando=#{probando}")
        button "ok" do
          hola=@pepe.text
          alert "hola soy la variable hola: #{hola}"
          hola2=@pepe2.print2_author(@pepe.text)
          alert hola2

        end

      end
  end
    stack :width => "30%", :height => "90%",:margin => 10 do
      background white
      @algoritmos= list_box :items => ["Vernam","Vigenere","rijndael","A5/1", "RSA", "DIffie-Hellman","Fiat-Shamir"],:margin => [10,10,10,10]
      stack :margin => 15 do
        para"PRUEBA DEL LADO
        DERECHOOOO "
      end
    end

=begin
  stack :margin => 15 do
    para"introduce cadena "
  end
  stack :margin => 10 do


   @pepe=edit_line
   @boton=button 'OK?'
   @boton.click do
      Post.print_author(@pepe.text)
   end
  end
=end
end