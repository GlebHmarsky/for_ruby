# frozen_string_literal: true

# Routes for the cool vacancies of this application
class App
  # path :list, '/list'
  path :vacancie_new, '/list/vacancies/new'
  path Vacancie do |vacancie, action|
    if action
      "/list/vacancies/#{vacancie.id}/#{action}"
    else
      "/list/vacancies/#{vacancie.id}"
    end
  end

  hash_branch('vacancies') do |r|
    append_view_subdir('vacancie')
    set_layout_options(template: '../views/layout')
    # r.on do
      r.on 'vacancies' do
        r.on Integer do |vacancie_id|
          @vacancie = opts[:vacancies].vacancie_by_id(vacancie_id)
          pp @vacancie
          next if @vacancie.nil?
          
          r.is do
            view('vacancie')
          end

          r.on 'edit' do
            r.get do
              @parameters = @vacancie.to_h
              view('vacancie/vacancie_edit')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(VacancieFormSchema.call(r.params))
              if @parameters.success?
                @params = {}
                @params[:errors] = InputValidators.check_age(@parameters)
                if @params[:errors].empty?
                  opts[:vacancies].update_vacancie(@vacancie.id, @parameters)
                  r.redirect(path(@vacancie))
                else
                  view('vacancie/vacancie_edit')
                end
              else
                view('vacancie/vacancie_edit')
              end
            end
          end

          r.on 'delete' do
            r.get do
              @parameters = {}
              view('vacancie/vacancie_delete')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(VacancieDeleteSchema.call(r.params))
              if @parameters.success?
                opts[:vacancies].delete_vacancie(@vacancie.id)
                r.redirect(list_path)
              else
                view('vacancie/vacancie_delete')
              end
            end
          end
        end
        r.on 'new' do
          r.get do
            @parameters = {}
            view('vacancie/vacancie_new')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(VacancieFormSchema.call(r.params))
            if @parameters.success?
              @params = {}
              @params[:errors] = InputValidators.check_age(@parameters)
              if @params[:errors].empty?
                vacancie = opts[:vacancies].add_vacancie(@parameters)
                r.redirect(path(vacancie))
              else
                view('vacancie/vacancie_new')
              end
            else
              view('vacancie/vacancie_new')
            end
          end
        end
      end
    # end
  end
end
