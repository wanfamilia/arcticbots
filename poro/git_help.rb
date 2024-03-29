class GitHelp
  def prune
    'git branch --merged master | grep -vE "^\s+master$" | grep -v "\*" | xargs -n 1 git branch -d'
  end

  def prunemain
    'git branch --merged main | grep -vE "^\s+main$" | grep -v "\*" | xargs -n 1 git branch -d'
  end

  def clean_medium
    'git branch | grep -vE "^\s+master$" | grep -v "\*" | xargs -n 1 git branch -d'
  end

  def purge
    'git branch | grep -vE "^\s+master$" | grep -vE "^\s+main$" | grep -v "\*" | xargs -n 1 git branch -D'
  end

  def getmain
    'git pull && git fetch origin main:main'
  end

  def pullf
    'git reset --hard @{upstream}'
  end

  def vult
    # vulture ip
    'ssh docker@155.138.220.71'
  end
  
  def fia
    "git fi -a `git rev-parse --abbrev-ref HEAD`"
  end
  
  def fir
    "git fi -r `git rev-parse --abbrev-ref HEAD`"
  end

  def reflog
    'git reflog --pretty=format:"%an %h %s"'
  end

  def rubob
    '~/bin/rubow.rb --branch'
  end

  def masterbase
    'git merge-base HEAD master'
  end

  def resetbase
    'git reset `git merge-base HEAD master`'
  end

  # sets the title on a mac
  def title(title)
    %Q{echo -n -e "\033]0;#{title}\007"}
  end

  def ruboa
    '~/bin/rubow.rb --branch -a'
  end

  def config
    require 'yaml'
    @config ||= YAML::load_file('.idea/servers.yml')
  end

  def value(key)
    config.dig(*key.split('.'))
  end

  def app
    value 'app.name'
  end

  def branch
    value 'app.branch'
  end

  def env
    @env ||= 'staging'
  end

  def shell
    "cx ssh -s #{app} -e #{env} #{server}"
  end

  def download(remote_path)
    "cx download --stack #{app} -e #{env} --server #{server} #{remote_path}"
  end

  def prod
    @env = 'production'
    self
  end

  def server
    config['servers'][env]
  end

  def foo(key)
    "echo foo #{value(key)}"
  end
end
