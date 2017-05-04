settings = {"connections"=>{
  "default"=>{"url"=>"redis://#{Rails.application.config.redis_host}:6379/0"},
  "db1"		 =>{"url"=>"redis://#{Rails.application.config.redis_host}:6379/1"},
  "db2"		 =>{"url"=>"redis://#{Rails.application.config.redis_host}:6379/2"},
  }}

RedisBrowser.configure(settings)
