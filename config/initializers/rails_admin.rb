module RailsAdmin
  module Config
    module Actions

      class JobPerform < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root      do  true  end
        register_instance_option :visible?  do  authorized?  end
        register_instance_option :link_icon do 'fa fa-tasks'  end
        register_instance_option :http_methods do [:get, :post] end
        register_instance_option :controller do
          proc do
            if request.post?
              # Parameters: {..."job_perform"=>{"job_name"=>"SidekiqDefaultJob"}, "commit"=>"Submit"}
              job_class = params['job_perform']['job_class']
              job_class.constantize.perform_later
              flash[:notice] = "Queued #{job_class}"
              redirect_to dashboard_path
            end
          end
        end
      end

      class Bgimport < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :collection do  true  end
        register_instance_option :only do [User] end
        register_instance_option :link_icon do 'fa fa-upload' end
        register_instance_option :http_methods do [:get, :post] end
        register_instance_option :controller do
          proc do
            if request.get?
              # just show the page
            elsif request.post?
              record_type = params[:model_name]
              ImportJob.perform_now(params[:file], record_type)
              flash[:success] = "imporing #{record_type} records"
              redirect_to back_or_index
            end
          end
        end
      end

    end
  end
end


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    # =>
    job_perform
    bgimport
  end
end
