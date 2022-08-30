class RailsHelp
  def migrate
    'RAILS_ENV=test bundle exec rake db:migrate'
  end

  def reset
    'RAILS_ENV=test bundle exec rake db:reset'
  end

  def rollback
    'RAILS_ENV=test bundle exec rake db:rollback'
  end
end