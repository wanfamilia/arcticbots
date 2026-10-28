local sound = hs.sound.getByFile(os.getenv("HOME") .. "/bin/smb3_stagestart.wav")
local appShortNames = {
    ["Google Chrome"] = "chrome",
    ["Discord"] = "discord",
    ["Messages"] = "messages",
    ["Slack"] = "slack",
}

local heart = function(shortName)
    if not shortName then return end
    local command = string.format('~/bin/heartbeat.sh %s', shortName)
    print(command)
    hs.execute(command, true)
end

watcher = hs.application.watcher.new(function(appName, eventType, app)
    if eventType == hs.application.watcher.activated then
        print(appName)
        heart(appShortNames[appName])
    end
end)

watcher:start()

unlockWatcher = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.screensDidUnlock then
        sound:play()

        heart('unlock')
    end
end)

unlockWatcher:start()
