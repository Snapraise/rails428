module RailsAdmin
  module Config
    module Actions

      class SqsJobPerform < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root      do  true  end
        register_instance_option :visible?  do  authorized?  end
        register_instance_option :link_icon do 'fa fa-tasks'  end
        register_instance_option :controller do
          proc do
            SqsJob.perform_later
            flash[:notice] = "SqsJob"
            redirect_to dashboard_path
          end
        end
      end

      class SidekiqJobPerform < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root      do  true  end
        register_instance_option :visible?  do  authorized?  end
        register_instance_option :link_icon do 'fa fa-tasks'  end
        register_instance_option :controller do
          proc do
            SidekiqJob.perform_later
            flash[:notice] = "SidekiqJob"
            redirect_to dashboard_path
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
    sqs_job_perform
    sidekiq_job_perform
  end
end
