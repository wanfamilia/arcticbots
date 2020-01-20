class Dock
  def ps
     'docker ps --format "{{.Names}}\t{{.Status}}\t{{.Ports}}"'
  end
  
  def bash(container)
    "docker exec -it #{container} bash"
  end
  
  def up(container)
    "docker-compose up -d #{container}"
  end
  
  def down
    'docker-compose down'
  end
  
  def to_s
    ps
  end
end