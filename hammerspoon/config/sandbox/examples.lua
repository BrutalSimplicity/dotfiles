hyper = { "cmd", "alt", "ctrl" }
function display(table, metatables)
    if metatables then
        print(hs.inspect(table, {
            metatables = metatables
        }))
    else
        print(hs.inspect(table))
    end
end

function getWindowInfo(win)
    local obj = {}
    local app = win:application()
    local appWindows = app:allWindows()
    local openedWindows = {}
    for _, appWin in pairs(appWindows) do
        table.insert(openedWindows, {
            id = appWin:id(),
            title = appWin:title(),
            tabCount = appWin:tabCount()
        })
    end
    table.insert(obj, {
        id = win:id(),
        title = win:title(),
        tabCount = win:tabCount(),
        application = {
            name = app:name(),
            title = app:title(),
            bundleId = app:bundleID(),
            openedWindows = openedWindows
        }
    })
    return obj
end

-- example:alert using hotkey to display an alert
hs.alert.show("Hello, World!")

-- example:notification using hotkey to display notification
hs.notify.new({ title = "Hammerspoon", informativeText = "Hello, World!" }):send()

-- example:screens
print(hs.inspect(hs.screen.allScreens()))
print(hs.inspect(hs.screen.mainScreen()))
print(hs.inspect(hs.screen.primaryScreen()))

-- example:spaces
print(hs.inspect(hs.spaces.allSpaces()))
display(hs.spaces.activeSpaces())

-- example:execute
output, status, typ, rc = hs.execute("env", true)
display({
    output = output,
    status = status,
    type = typ,
    rc = rc
})

-- example:create-space
hs.execute("yabai -m space --create", true)
hs.spaces.addSpaceToScreen(nil, true)

-- example:find-app
app = hs.application.find("alfred")
display(app, true)
display({
    title = app:title(),
    name = app:name(),
    path = app:path(),
    bundleId = app:bundleID(),
    pid = app:pid(),
})

-- example:running-apps
apps = hs.application.runningApplications()
info = {}
for _, app in pairs(apps) do
    table.insert(info, {
        title = app:title(),
        name = app:name(),
        path = app:path(),
        bundleId = app:bundleID(),
        pid = app:pid(),
    })
end
display(info)

-- example:all-windows
windows = hs.window.allWindows()
info = {}
for _, win in pairs(windows) do
    table.insert(info, getWindowInfo(win))
end
display(info)

-- example:window-filters
wf = hs.window.filter
filter = wf.new():setDefaultFilter({})
windows = filter:getWindows(wf.sortByFocusedLast)
info = {}
for _, win in pairs(windows) do
    table.insert(info, getWindowInfo(win))
end
display(info)

-- example:browser-windows
local f = hs.window.filter.new():setAppFilter("com.brave.Browser", { visible = true })
local windows = f:getWindows()
local newinfo = {}
for _, win in pairs(windows) do
    table.insert(newinfo, getWindowInfo(win))
end
display(newinfo)

-- example:yabai-query
local arguments = hs.fnutils.concat({ "/opt/homebrew/bin/yabai", "-m", "query" }, { "--windows" })
local cmd = table.concat(arguments, " ")
local output, status, typ, rc = hs.execute(cmd, true)
display({
    ouptput = output,
    status = status,
    typ = typ,
    rc = rc
})
display(hs.json.decode(output))

-- example:modal
local hyper = { "cmd", "alt", "ctrl" }
local modal = hs.hotkey.modal.new()
local opts = {
    ui = {
        fontFamily = 'FiraCode Nerd Font',
        prefixSeparator = '>',
        keySeparator = '|',
        bindingSeparator = '->',
        modifierMappings = {
            command = '⌘',
            control = '⌃',
            option = '⌥',
            shift = '⇧',
            escape = '󱊷',
            tab = '',
        }
        header = {
            itemSeparator = '/',
            fontSize = '10',
        }
    },
    escapeMapping = {
        keys = {
            "escape",
            "q"
        },
        desc = "close",
    },
    gotoParentMapping = {
        keys = { "backspace" },
        desc = "Go up one level",
    },
    globalMappings = {
    },
    mappings = {
        {
            keys = {

            },
            ui = {

            },
            mappings = {
                {
                    keys = "a",
                    desc = "Auto",
                    callback = function()
                    end
                },
                {
                    keys = "s",
                    desc = "Stack",
                    callback = function()
                    end
                },
                {
                    keys = "f",
                    desc = "Float",
                    callback = function()
                    end
                },
            },
        },
        {
            key = "s",
            desc = "Spaces",
            pin = true,
            mappings = {
                {
                    key = "n",
                    desc = "New",
                    callback = function()
                    end
                },
                {
                    key = "f",
                    desc = "Focus"
                },
            },
        },
        {
            key = "w",
            desc = "Windows",
            mappings = {
                {
                    key = "w",
                    desc = ""
                }
            },
        },
    },
}
local styled = hs.styledtext
local styled = hs.styledtext
local regularFont = styled.convertFont('FiraCode Nerd Font', false)
local boldFont = styled.convertFont('FiraCode Nerd Font', true)
local s1 = styled.new('󰨞  0 FiraCode White', {
    font = regularFont,
    color = {
        white = 1.0,
        alpha = 1.0,
    }
})
local s2 = styled.new('󰨞  0 FiraCode Red Bold', {
    font = boldFont,
    color = {
        red = 1.0,
        alpha = 1.0,
    },
})
local s3 = styled.new('󰨞  0 FiraCode Green Bold 10 Pt', {
    font = {
        name = regularFont.name,
        size = 10,
        paragraphStyle = {
            -- alignment = "center",
        }
    },
    color = hs.drawing.color.ansiTerminalColors.fgGreen,
})
local s4 = styled.new('󰨞  0 FiraCode Blue 14 Pt', {
    font = {
        name = regularFont.name,
        size = 14,
    },
    color = hs.drawing.color.x11.cornflowerblue
})
local textobjects = {
    s1,
    s2,
    s3,
    s4
}
local text = nil
for _, o in pairs(textobjects) do
    if text == nil then
        text = o
    else
        text = text .. hs.styledtext('\n') .. o
    end
end
hs.alert.closeAll()
hs.alert(text, {
    strokeWidth = 0,
    strokeColor = { white = 0, alpha = 0 },
    radius = 40,
    padding = 20,
    atScreenEdge = 2,
}, true)
-- local formatKeyDisplay = function(opts, key)
--     opts.ui.separator
-- end
-- local createHeader = function(opts)

-- end
-- local header = createHeader(opts)

-- example:markdown
local markdown = [[
# Title

Paragraph

## Header Two

- Item One
- Item Two
- Item Three

**Bold**

*Italic*
]]
local html = hs.doc.markdown.convert(markdown)
print(html)
local text = hs.styledtext.getStyledTextFromData(html)
local styledtext = text:asTable()
for _, attr in pairs(styledtext) do
    if type(attr) == 'table' then
        attr = attr.attributes
        attr.color = {
            white = 1.0,
            alpha = 0.75
        }
        if string.find(attr.font.name, '[bB]old') then
            attr.font.name = hs.styledtext.convertFont('FiraCode Nerd Font', true)['name']
        elseif string.find(attr.font.name, '[iI]talic') then
            attr.font.name = hs.styledtext.convertFont('FiraCode Nerd Font', hs.styledtext.fontTraits.italicFont)
            ['name']
        else
            attr.font.name = hs.styledtext.convertFont('FiraCode Nerd Font', false)['name']
        end
    end
end
display(styledtext)
text = hs.styledtext.new(styledtext)
hs.alert.closeAll()
hs.alert(text, {
    atScreenEdge = 0,
    strokeWidth = 0,
    strokeColor = { white = 0, alpha = 0 },
    fillColor = {
        white = 0,
        alpha = 0.50,
    }
}, 5)

-- example:chooser
local choices = {
    {
        ["text"] = "First Choice",
        ["subText"] = "This is the subtext of the first choice",
        ["uuid"] = "0001",
        image = hs.image.imageFromName("NSStatusAvailable"),
    },
    {
        ["text"] = "Second Option",
        ["subText"] = "I wonder what I should type here?",
        ["uuid"] = "Bbbb"
    },
    {
        ["text"] = hs.styledtext.new("Third Possibility", { font = { size = 18 }, color = hs.drawing.color
        .definedCollections.hammerspoon.green }),
        ["subText"] = "What a lot of choosing there is going on here!",
        ["uuid"] = "III3"
    },
}
chooser = hs.chooser.new(function(item)
    if item == nil then
        hs.alert("Chooser closed")
    else
        hs.alert("Item selected: \n" .. hs.inspect(item))
    end
end)
chooser:choices(choices)
-- set light background
-- chooser:bgDark(false)
-- detach toolbar
-- chooser:attachedToolbar()

-- attach toolbar
-- if toolbar ~= nil then
--     toolbar:delete()
--     toolbar = nil
-- end
-- toolbar = hs.webview.toolbar.new("myConsole", {
--     { id = "select1", selectable = true, image = hs.image.imageFromName("NSStatusAvailable") },
--     { id = "NSToolbarSpaceItem" },
--     { id = "select2", selectable = true, image = hs.image.imageFromName("NSStatusUnavailable") },
--     { id = "notShown", default = false, image = hs.image.imageFromName("NSBonjour") },
--     { id = "NSToolbarFlexibleSpaceItem" },
--     { id = "navGroup", label = "Navigation", groupMembers = { "navLeft", "navRight" }},
--     { id = "navLeft", image = hs.image.imageFromName("NSGoLeftTemplate"), allowedAlone = false },
--     { id = "navRight", image = hs.image.imageFromName("NSGoRightTemplate"), allowedAlone = false },
--     { id = "NSToolbarFlexibleSpaceItem" },
--     { id = "cust", label = "customize", fn = function(t, w, i) t:customizePanel() end, image = hs.image.imageFromName("NSAdvanced") }
-- }):canCustomize(true)
--   :autosaves(true)
--   :selectedItem("select2")
--   :setCallback(function(...)
--                     print("a", inspect(table.pack(...)))
--                end)
-- chooser:attachedToolbar(toolbar)
chooser:show()

-- example:shellscript

-- don't use for long-running commands as this will block the main HS thread
-- local output, status, typ, rc hs.execute("AWS_PROFILE=protagona-main aws sso login", true)
-- display({
--     output = output,
--     status = status,
--     type = typ,
--     rc = rc
-- })
local doneCallback = function(exitCode, stdout, stderr)
    display({
        exitCode = exitCode,
    })
end
local streamingCallback = function(task, stdout, stderr)
    print("[STDOUT] " .. stdout)
    print("[STDERR] " .. stderr)
    return true
end
local task = hs.task.new("/opt/homebrew/bin/aws", doneCallback, streamingCallback,
    { "sso", "login", "--debug", "--profile", "protagona-main" })
if task:start() == false then
    hs.alert("failed to start task")
end

-- It is highly discouraged to block. In practice, the streaming callback can be used to receive
-- output from the command and push to an appropriate destination
task:waitUntilExit()

