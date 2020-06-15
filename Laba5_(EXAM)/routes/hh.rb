# frozen_string_literal: true

# Routes for the cool seekers of this application
class App
  path :list, '/list'
  path :seeker_new, '/list/seekers/new'
  path :vacancie_new, '/list/vacancies/new'
  path :unique_posts, '/list/unique_posts'
  path :age_statistics, '/list/age_statistics'
  path Seeker do |seeker, action|
    if action
      "/list/seekers/#{seeker.id}/#{action}"
    else
      "/list/seekers/#{seeker.id}"
    end
  end
  path Vacancie do |vacancie, action|
    if action
      "/list/vacancies/#{vacancie.id}/#{action}"
    else
      "/list/vacancies/#{vacancie.id}"
    end
  end

  hash_branch('list') do |r|
    set_layout_options(template: '../views/layout')

    # Весь список
    r.is do
      @seekers = opts[:seekers].all_seekers
      @vacancies = opts[:vacancies].all_vacancies
      view('list')
    end

    r.on 'unique_posts' do
      @list_unique_posts = opts[:vacancies].unique_posts
      r.is do
        view('unique_posts')
      end
      r.on Integer do |post_id|
        @selected_post_id = post_id
        view('unique_posts')
      end
    end

    r.on 'age_statistics' do
      r.is do
        @params = InputValidators.check_input_age(r.params['age'])
        pp @params
        if @params[:errors].empty? && @params[:age]
          @statistic_from_vacancies = opts[:vacancies].age_statistics(@params[:age])
          @statistic_from_seekers = opts[:seekers].age_statistics(@params[:age])
        end
        view('age_statistics')
      end
    end

    r.on 'seekers' do
      r.on Integer do |seeker_id|
        @seeker = opts[:seekers].seeker_by_id(seeker_id)
        next if @seeker.nil?

        r.is do
          view('seeker/seeker')
        end
        r.on 'edit' do
          r.get do
            @parameters = @seeker.to_h
            view('seeker/seeker_edit')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(SeekerFormSchema.call(r.params))
            if @parameters.success?
              opts[:seekers].update_seeker(@seeker.id, @parameters)
              r.redirect(path(@seeker))
            else
              view('seeker/seeker_edit')
            end
          end
        end

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('seeker/seeker_delete')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(SeekerDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:seekers].delete_seeker(@seeker.id)
              r.redirect(list_path)
            else
              view('seeker/seeker_delete')
            end
          end
        end
        r.on "job" do
          @job_list = opts[:vacancies].job_list(@seeker)
          view("seeker/job_list")
        end
      end
      r.on 'new' do
        r.get do
          @parameters = {}
          view('seeker/seeker_new')
        end
        r.post do
          @parameters = DryResultFormeWrapper.new(SeekerFormSchema.call(r.params))
          if @parameters.success?
            seeker = opts[:seekers].add_seeker(@parameters)
            r.redirect(path(seeker))
          else
            view('seeker/seeker_new')
          end
        end
      end
    end

    # *******************************************************************

    # ТУТ НАЧАЛИСЬ ВАКАНСИЙ!!!!

    # *******************************************************************
    
    r.on 'vacancies' do
      r.on Integer do |vacancie_id|
        @vacancie = opts[:vacancies].vacancie_by_id(vacancie_id)
        next if @vacancie.nil?

        r.is do
          view('vacancie/vacancie')
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
  end
end
