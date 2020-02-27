class DockerHelp
  def psn
    "docker ps --format '{{.Names}}'"
  end
end