class GitHelp
  def clean_soft
    'git branch --merged master | grep -vE "^\s+master$" | grep -v "\*" | xargs -n 1 git branch -d'
  end

  def clean_medium
    'git branch | grep -vE "^\s+master$" | grep -v "\*" | xargs -n 1 git branch -d'
  end

  def purge
    'git branch | grep -vE "^\s+master$" | grep -v "\*" | xargs -n 1 git branch -D'
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

  def title(title)
    %Q{echo -n -e "\033]0;#{title}\007"}
  end

  def ruboa
    '~/bin/rubow.rb --branch -a'
  end
end
