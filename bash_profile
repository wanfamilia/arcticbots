[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
eval "$(rbenv init -)"
export PATH=~/.rbenv/shims:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export DYLD_LIBRARY_PATH=/usr/local/oracle
export PATH=$PATH:$DYLD_LIBRARY_PATH
export OCI_DIR=/usr/local/oracle
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export ORACLE_HOME=/usr/local/oracle/
export SQLPATH=/usr/local/oracle
export NLS_LANG=American_America.UTF8
export TNS_ADMIN=~/software/oracle/tnsadmin/
alias ls='ls -GF'
alias duke='script/duke.sh'
alias velm='~/bin/velm.rb'
alias gup='git fetch origin master:master && git merge master'
alias duker='script/duke.rb'
alias gfom='git fetch origin master:master'
alias rebash='source ~/.bash_profile'
alias pushstaging='git push staging HEAD:master'
alias pushprod='git push prod master'
alias restoredb='pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d ledcor_development data/staging.dump'
alias hmig='heroku run rake db:migrate -r '
alias hweb='heroku ps:restart -r '
alias hcon='heroku run rails c -r '
alias hbak='heroku pgbackups:capture -r '
alias hreseed='heroku run bundle exec rake db:drop db:create db:schema:load db:seed -r '
alias hlog='heroku logs -n 1000 -r '
alias glog='git log --pretty=oneline'
alias restoreddev='pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d ledcor_development data/staging.dump'
function __velme() { eval $(velm display $*);}
alias vel='__velme'
function __resdev() { pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d $*_development data/staging.dump;}
alias resdev='__resdev'
alias grm='git branch --merged master | grep -v "master" | grep -v "\*" | xargs -n 1 git branch -d'
alias goruby='cd ~/.rbenv/plugins/ruby-build'
alias bers='bundle exec rspec'
alias brco='~/bin/rubow.rb --branch && date'
alias bera='bundle exec rake'
alias berc='source .powenv && bundle exec rails c'
alias bedm='bera db:migrate'
alias bert='RAILS_ENV=test bundle exec rake db:reset'
alias bedr='bera db:rollback'
alias atbshell='ssh root@199.19.214.216 -i /Users/richardwan/.ssh/server_albatross'
alias atbshellstage='~/bin/cx ssh -s ATB-SPS 199.19.214.216' 
alias atbshellprod='ssh root@atb-spp.rnp.io -i ~/.ssh/server_tarantula'
alias atbshelldemo='ssh root@sps.rnp.io -i ~/.ssh/server_puma'
function cssh() { ~/bin/cx ssh -s "$*" web; }



. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
