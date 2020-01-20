class RemoteShell
  def secret(key)
    require 'yaml'
    YAML::load_file(File.join(__dir__, '../secret.yml'))[key.to_s]
  end
  
  def shell(ip)
    require 'ostruct'
    aws = OpenStruct.new secret(:aws)
    "ssh -i #{aws.pem} #{aws.user}@#{ip}"
  end

  def to_s
    secret :greeting
  end
end