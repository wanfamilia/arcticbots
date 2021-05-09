#!/usr/bin/env ruby

require_relative 'poro/git_help'
require_relative 'poro/docker_help'
require_relative 'poro/swagger'

class Webpage
  def initialize(url)
    @url = url
  end

  def open
    "open '#{@url}'"
  end

  def clip
    "echo -n '#{@url}' | pbcopy"
  end

  def to_s
    open
  end
end

class Velm
  # :2,$s/^pick/squash/g
  def execute(args)
    cmds = shell_command args
    [cmds].flatten.each do |cmd|
      puts cmd
      unless @display
        output = `#{cmd.to_s}`
        puts trunc(output, 1024) unless @display
      end
    end
    puts "\nCompleted at: #{Time.now}" unless @display
  end

  def gh
    GitHelp.new
  end
  
  def dh
    DockerHelp.new
  end

  def display
    @display = true
    self
  end
  
  def sw
    Swagger.new
  end
  
  def awsh(ip)
    require_relative 'poro/remote_shell'
    RemoteShell.new.shell(ip)
  end

  def verbose
    @verbose = true
    self
  end
  
  def trunc(output, len)
    return output if (output.length < len) || @verbose
    "#{output[0..len]} .... TRUNCATED at #{len}"
  end

  def evaluate(source, value)
    # source.send symbol
    return source.call value if source.respond_to? :call
    method = source.method value
    return method.call if method.arity == 0
    method.to_proc.curry
  end

  def hello(text)
    "echo hello: #{text}"
  end

  def zero
    "echo zero: #{$0}"
  end

  def shell_command(args)
    args.inject(self) { |a, v| evaluate a, v }
  end
  def open_url(url)
    "open '#{url}'"
  end

  def arctic(filename)
    require_relative 'poro/parse_arctic'
    ParseArctic.new.filter_file filename
  end

  def parc
    require_relative 'poro/parse_arctic'
    ParseArctic.new
  end
  
  def swagger
    display

    require 'net/http'
    require 'uri'
    require 'json'
    
    phrases = [
    ]
    tokens = [
    ]   
    host = 'changeme'
    results = phrases.map do |phrase|
      tokens.map do |token|
        uri = URI.parse("http://#{host}/search?phrase=#{phrase}&autocorrect=assetids&fields=caption")
        request = Net::HTTP::Get.new(uri)
        request["Accept"] = "application/json"
        request["Gi-Security-Token"] = token
        request["Gi-User-Profile-Token"] = profile_token
        
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        body = JSON.parse(response.body)
        body['ErrorCode'] || body['TotalNumberOfResults'] 
      end.join ", "
    end.join "\n"
  end

  def tty
    display
    STDIN.tty?.to_s
  end
  
  def dock
    require_relative 'poro/dock'
    Dock.new
  end

  def arc
    display
    puts ParseArctic.new.demo.to_s
  end

  def newruby
    ['(cd ~/.rbenv/plugins/ruby-build && git pull)', 'rbenv install']
  end
  
  def location
    display 
    __dir__
  end

  def push
    ["cd #{__dir__} && git add -u && git commit -m velmsync && git push"]
  end
  
  def deploy
    push << 'ssh docker@wanforall.org git -C repos/sandbox pull'
  end
  
  def sand
    'ssh docker@wanforall.org git -C repos/sandbox pull'
  end

  def pull
    ['cd ~/bin && git pull']
  end
end

Velm.new.execute ARGV