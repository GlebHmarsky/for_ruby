require 'roda'
require 'uri'
require 'yaml'

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect '/hello'
    end
    @greeting = "<meta charset = 'UTF-8'>"
    r.on 'get' do
      r.on 'rng' do
        random = rand(100..5000)
        @greeting = '<meta charset = "UTF-8">Случайное число ' << String(random)
      end

      r.get 'sop', 'rng' do
        return 'Vi boba ksta' if r.params.size != 2

        begin
          num1 = Integer(r.params['min'])
          num2 = Integer(r.params['max'])
        rescue StandardError
          return "Vi opat' biba"
        end
        return 'Da ti zaebal uzhe' if num1 >= num2

        @greeting << "Super случяйное число: #{rand(num1..num2)}"
      end
    end

    r.get 'worker','id' do
      # response['Content-Type'] = 'application/json'
      data = YAML.load(File.read('doc.yaml'))
      people = data["people"]
      begin
      id = Integer(r.params["id"])
      rescue
        return {
          "status": "error",
          "message": "Идентификатор сотрудника — целое число."
        }
      end
      if people.size <= id
        return "U suka, net takogo"
      end
      person = people[id]
      @greeting << "<!DOCTYPE>#{person["name"]} #{person["patronymic"]} #{person["surname"]} \nmilo: #{person["email"]}\n <img src = \"#{person["avatar"]}\">"
      

    end

    r.get 'cool', 'hello', String, String do |name, surname|
      @greeting << "Здравствуйте #{URI.unescape(name)} #{URI.unescape(surname)}"
    end

    r.get 'calc', 'min', String, String do |num_one, num_two|
      begin
        num1 = Integer(num_one)
        num2 = Integer(num_two)
      rescue StandardError
        return 'Vi biba ksta'
      end
      "<meta charset = 'UTF-8'>Мнимум #{[num1, num2].min}"
    end
    r.get 'calc', 'multiply', String, String do |num_one, num_two|
      begin
        num1 = Float(num_one)
        num2 = Float(num_two)
      rescue StandardError
        return 'Vi biba ksta'
      end
      "<meta charset = 'UTF-8'>Умножение #{num1 * num2}"
    end

    # /hello branch
    r.on 'hello' do
      # Set variable for all routes in /hello branch
      @greeting = '<meta charset = "UTF-8">Здравствуйте'
    end

    r.on 'a' do           # /a branch
      r.on 'b' do         # /a/b branch
        r.is 'c' do       # /a/b/c request
          r.get do
            'Request from a/b/c'
          end # GET  /a/b/c request
          r.post {} # POST /a/b/c request
        end
        r.get 'd' do
          "Request from 'd'"
        end # GET  /a/b/d request
        r.post 'e' do end # POST /a/b/e request
      end
    end

    # GET /post/2011/02/16/hello
    r.get 'post', Integer, Integer, Integer, String do |year, month, day, slug|
      "#{year}-#{month}-#{day} #{slug}" #=> "2011-02-16 hello"
    end

    # /search?q=barbaz
    r.get 'search' do
      "Searched for #{r.params['q']}" #=> "Searched for barbaz"
    end
  end
end
