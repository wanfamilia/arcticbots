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

  def reflog
    'git reflog --pretty=format:"%an %h %s"'
  end

  def rubob
    '~/bin/rubow.rb --branch'
  end

  def ruboa
    '~/bin/rubow.rb --branch -a'
  end
end
