class RailsHelp
  def migrate
    'RAILS_ENV=test bundle exec rake db:migrate'
  end

  def reset
    'RAILS_ENV=test bundle exec rake db:reset'
  end

  def cred(env)
    "EDITOR=vim rails credentials:edit --environment #{env}"
  end

  def rollback
    'RAILS_ENV=test bundle exec rake db:rollback'
  end
end