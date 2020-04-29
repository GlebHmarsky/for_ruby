require 'erb'
def hello_erb(chel)
  temp = ERB.new "Hello <%= chel %>"
  temp.result(binding)
end

def hello(chel)
  puts "Hello #{chel}"
end

def invite_erb(name,autor,what,text)
  template = "Hello <%= name %>
  приглашаем на <%= what%>
   <%=text %> 
   С уважением, <%=autor %>"
   renderer = ERB.new(template)
   renderer.result(binding)
end

def buy_tovar(name,price,kat)
  template = "<% if kat == :dress %>
  Ну купи платье
  Название: <%=name%>
  Цена сия чуда: <%=price%>
  <% elsif kat == :tools %>
    Ну купи штучки
    Название: <%=name%>
    Цена чуда-юда: <%=price%>
    <% end %>"
  renderer = ERB.new(template)
  renderer.result(binding)
end


# puts hello_erb("Petr")
# hello("Журик")

# puts invite_erb("кожанный человек","белый пушистый","Гачисходка","Будет весело")

puts buy_tovar("Mango",9999,:tools)