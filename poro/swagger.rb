
class Swagger
  def secret(key)
    require 'yaml'
    YAML::load_file(File.join(__dir__, '../secret.yml'))[key.to_s]
  end
  
  def data
    @data ||= secret(:swagger) 
  end

  def query
    host = data[data['env']]
    params = data['params'].gsub(':', '=')
    uri = File.join(host, "search?#{params}") 
  end
  
  def headers
    result = ["'Accept: application/json'"] + %w(Security User-Profile).map{|x| "'GI-#{x}-Token: #{data[x.downcase]}'"}
    result.map{|x| "--header #{x}"}.join ' '
  end
  
  def to_s
    "curl -X GET #{headers} '#{query}'"
  end    
end