local HOME = os.getenv 'HOME'
hs.pathwatcher.new(HOME .. '/.hammerspoon/', hs.reload):start()

--chooser = hs.chooser.new(function(choosen)
--    hs.alert('hi', tostring(choosen))
--end)
--chooser:show()
--

local clickerTimer = nil
hs.hotkey.bind('cmd ctrl alt', 'c', function()
    if clickerTimer and clickerTimer:running() then
        hs.alert('stopping')
        clickerTimer:stop()
        clickerTimer = nil
        return
    end
    hs.alert('starting')
    clickerTimer = hs.timer.new(0.001, function()
        hs.eventtap.leftClick(hs.mouse.getAbsolutePosition(), 10)
    end)
    clickerTimer:start()
end)

hs.pathwatcher.new(HOME .. '/Downloads/', function(files)
    for _, filename in ipairs(files) do repeat
        local stat = hs.fs.attributes(filename)
        if not stat or stat.size <= 0 then
            break
        end
        if filename:match '/legendas_tv' then
            hs.notify.show('New subtitle', filename, '')
            local lsfiles, xfile
            if filename:match '%.rar$' then
                lsfiles = '/usr/local/bin/unrar lb "' .. filename .. '"'
                xfile = '/usr/local/bin/unrar e %q n %q ad ~/Torrent/'
            elseif filename:match '%.zip$' then
            end
            local files = {}
            for f in io.popen(lsfiles):lines() do
                files[f:lower():match'([^/]+)$'] = f
            end
            for k, v in pairs(files) do print(k, v) end
            local found = false
            for f in io.popen('ls -1 ~/Torrent/'):lines() do
                local srt = f:sub(1, -5) .. '.srt'
                if files[srt:lower()] then
                    found = true
                    os.execute(string.format(xfile, filename, files[srt:lower()]))
                    os.execute(string.format('rm %q', filename))
                    hs.notify.show('Subtitle found', filename, srt)
                end
            end
            if not found then
                hs.alert('no matching video<>subtitle found')
            end
        end
    until true end
end):start()

--- Opens Chrome on my js profile in incognito mode
--
-- Note the `-n` switch to instruct `open` to always open a new app. Otherwise
-- Chrome will only focus the last active window
--
-- If there is a URL in the clipboard, open with that URL
hs.hotkey.bind('cmd ctrl alt', 'j', function()
    local clipboard = hs.pasteboard.readURL() or {url = hs.pasteboard.readString() or ''}
    local url = clipboard.url
    if url:match'^https?://' then
        url = string.format(' %q', url)
    else
        print(url)
        url = ''
    end
    os.execute('open -n -a "Google Chrome" --args --profile-directory="Profile 1" --incognito' .. url)
end)

hs.hotkey.bind('cmd ctrl alt', 'v', function()
    hs.eventtap.keyStrokes(hs.pasteboard.readString())
end)
