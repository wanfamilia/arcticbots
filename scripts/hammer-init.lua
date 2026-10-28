local appShortNames = {
    ["Google Chrome"] = "chrome",
    ["Discord"] = "discord",
    ["Messages"] = "messages",
    ["Slack"] = "slack",
}

watcher = hs.application.watcher.new(function(appName, eventType, app)
  if eventType == hs.application.watcher.activated then
    print(appName)
    local shortName = appShortNames[appName]

    if shortName then
        local command = string.format( "/bin/bash ~/bin/heartbeat.sh '%s'", shortName)
    hs.execute(command, true)
    end
  end
end)

watcher:start()

unlockWatcher = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.screensDidUnlock then
        hs.execute("/bin/bash ~/bin/heartbeat.sh unlock", true)
    end
end)

unlockWatcher:start()
