-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
--require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local cal = require("utils/cal")
local lain = require("lain")
local posix = require("posix")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/theme.lua")
for s = 1, screen.count() do
    gears.wallpaper.maximized(beautiful.wallpaper[s], s, true)
end

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper[s], s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
  names  = { "Main", "Browsers", "IMs", "Dev", "VMs", "Others"},
  layout = { layouts[1], layouts[8], layouts[2], layouts[2], layouts[1], layouts[1]
}}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
local systemctl = "systemctl "

local icon_path = "/usr/share/icons/oxygen/16x16/actions/"

local lock_prg = "bash /media/data/workspace/private/scripts/slock_with_monitor_off"

myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

browsersmenu = {
   { "&firefox", "firefox", "/usr/share/icons/hicolor/16x16/apps/firefox.png"},
   { "&midori", "midori", "/usr/share/icons/hicolor/16x16/apps/midori.png"}
}

-- if icons are missing, no entry will be displayed...
logoffmenu = {
  { "&lock", lock_prg, icon_path.."system-lock-screen.png" },
  { "s&witch user", "dm-tool switch-to-greeter", icon_path.."system-switch-user.png" },
  { "&suspend", lock_prg.." '"..systemctl.."suspend'", icon_path.."system-suspend.png"},
  { "&hibernate", lock_prg.." '"..systemctl.."hibernate'",
    icon_path.."system-suspend-hibernate.png"},
  { "&restart", systemctl.."reboot", icon_path.."system-reboot.png"},
  { "shut&down", systemctl.."poweroff", icon_path.."system-shutdown.png"}
}

mymainmenu = awful.menu.new({ items = { { "&awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "&browsers", browsersmenu,
                                          "/usr/share/icons/gnome/16x16/apps/web-browser.png"},
                                        { "open &terminal", terminal,
                                          "/usr/share/icons/gnome/16x16/apps/utilities-terminal.png" },
                                        { "&logoff", logoffmenu,
                                          "/usr/share/icons/gnome/16x16/actions/system-log-out.png"}
                                      }
                           })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
markup = lain.util.markup
mytextclock = awful.widget.textclock()
cal.register(mytextclock, "<b><u>%s</u></b>")

-- Weather:
local weather_tooltip
local weather_info = {}
update_weather_field = function(set_key, weather_now, get_key1, get_key2)
  local value = weather_now[get_key1][get_key2]
  if not value then
    value = "N/A"
  end
  weather_info[set_key] = value
end

myweather = lain.widgets.weather({
  city_id = 6432801,
  timeout = 1200,
  settings = function()
    update_weather_field("temp", weather_now, "main", "temp")
    update_weather_field("humidity", weather_now, "main", "humidity")
    update_weather_field("pressure", weather_now, "main", "pressure")
    update_weather_field("wind_speed", weather_now, "wind", "speed")
    update_weather_field("wind_deg", weather_now, "wind", "deg")
    update_weather_field("wind_gust", weather_now, "wind", "gust")
    weather_info["description"] = tostring(weather_now["weather"][1]["description"]:lower())
    units = tostring(weather_now["main"]["temp"])
    widget:set_markup(markup("#e0da37", units .. "°C "))
  end
})

if not weather_tooltip then
  weather_tooltip = awful.tooltip({})
  function weather_tooltip:update()
    if not weather_info["temp"] then
      return
    end

    local text = "Temperature: " .. weather_info["temp"] .. "°C \n"
    .. "Description: " .. weather_info["description"] .. "\n"
    .. "Wind: " .. weather_info["wind_speed"] .. " m/s, " .. weather_info["wind_deg"]
    .. "°, " .. weather_info["wind_gust"] .. " m/s" .. "\n"
    .. "Humidity: " .. weather_info["humidity"] .. "%\n"
    .. "Pressure: " .. weather_info["pressure"] .. " hPa"

    weather_tooltip:set_markup(markup("#e0da37", text))
  end
  weather_tooltip:update()
end
weather_tooltip:add_to_object(myweather.icon)

myweather.icon:connect_signal("mouse::enter", weather_tooltip.update)

-- cpu
mycpuusage = lain.widgets.cpu({
  settings = function()
    widget:set_markup(markup("#0a47f8", string.format("%02d", cpu_now.usage) .. "% "))
  end
})

-- memory
mymem = lain.widgets.mem({
  timeout = 3,
  settings = function()
    widget:set_markup(markup("#12cf09", mem_now.used .. "M "))
  end
})

-- battery
local battery_tooltip
local battery_info
baticon = wibox.widget.imagebox(beautiful.widget_battery)
mybattery = lain.widgets.bat({
  battery = "BAT1",
  settings = function()
    battery_info = bat_now
    if bat_now.perc == "N/A" then
      bat_now.perc = "AC"
      baticon:set_image(beautiful.widget_ac)
    elseif tostring(bat_now.perc) <= "5" then
      baticon:set_image(beautiful.widget_battery_empty)
    elseif tostring(bat_now.perc) <= "15" then
      baticon:set_image(beautiful.widget_battery_low)
    else
      baticon:set_image(beautiful.widget_battery)
    end
    widget:set_markup(markup("#ff8b0f", " ϟ " .. bat_now.perc .. "% "))
  end
})

if not battery_tooltip then
  battery_tooltip = awful.tooltip({})
  function battery_tooltip:update()
    if not battery_info["time"] then
      return
    end

    local text = "Status: " .. battery_info["status"] .. "\n"
    .. "Percentage: " .. battery_info["perc"] .. "%\n"
    .. "Time: " .. battery_info["time"] .. "\n"
    .. "Watt: " .. battery_info["watt"] .. "\n"

    battery_tooltip:set_markup(markup("#ff8b0f", text))
  end
  battery_tooltip:update()
end
battery_tooltip:add_to_object(mybattery)

mybattery:connect_signal("mouse::enter", battery_tooltip.update)

-- volume
volumewidget = lain.widgets.alsa({
  timeout = 60,
  settings = function()
    if volume_now.status == "off" then
      volume_now.level = volume_now.level .. "M"
    end
    widget:set_markup(lain.util.markup("#7493d2", volume_now.level .. "% "))
  end
})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(volumewidget)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(myweather)
    right_layout:add(myweather.icon)
    right_layout:add(mycpuusage)
    right_layout:add(mymem)
    right_layout:add(baticon)
    right_layout:add(mybattery)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.04)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Custom
    --awful.key({ modkey            }, "e" ,     function () awful.util.spawn('thunar') end),
    awful.key({ modkey            }, "e" ,     function () awful.util.spawn('pcmanfm') end),
    awful.key({ "Control", "Mod1" }, "s" ,
      function () awful.util.spawn('/media/data/Documents/scripts/putMonitor2Sleep.sh') end),
    awful.key({ "Control", "Mod1" }, "l" ,     function () awful.util.spawn(lock_prg) end),
    awful.key({ "Control", "Mod1" }, "d" ,     function () awful.util.spawn('pkill xscreensaver') end),

    -- Volume control:
    awful.key({ }, "XF86AudioRaiseVolume", function ()
      awful.util.spawn("amixer -q sset Master 4%+ && sleep 1s;")
      volumewidget.update()
    end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
      awful.util.spawn("amixer -q sset Master 4%- && sleep 1s")
      volumewidget.update()
    end),
    awful.key({ }, "XF86AudioMute", function ()
      awful.util.spawn("amixer -D pulse set Master '1+' toggle && sleep 1s")
      volumewidget.update()
    end),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight +9") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -7") end),
    -- chrome
    awful.key({ modkey, "Control" }, "c",     function () awful.util.spawn('google-chrome --disk-cache-size=128000000') end),
    -- screenshot
    awful.key({                   }, "Print", function () awful.util.spawn('xfce4-screenshooter') end)
    -- clipboard manager
    --awful.key({ "Mod1", "Control" }, "c",     function () awful.util.spawn('xfce4-popup-clipman') end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),

    -- custom shortcuts

    -- horizontal maximization
    awful.key({ modkey, "Mod1"    }, "h",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
        end),
    -- vertical maximization
    awful.key({ modkey, "Mod1"    }, "v",
        function (c)
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

local raise_last_active_window = function()
    local screen = mouse.screen
    local selected_client = awful.client.focus.history.get(screen, 0)
    if not selected_client then
        return nil
    end
    client.focus = selected_client
    client.focus:raise()
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                           raise_last_active_window()
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                           raise_last_active_window()
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                          raise_last_active_window()
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                          raise_last_active_window()
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2], maximized_vertical = true,
      maximized_horizontal = true, switchtotag = true } },
    -- Set chromium to always map on tags number 2 of screen 1.
    { rule = { class = "Chromium-browser" },
      properties = { tag = tags[1][2], maximized_vertical = true,
      maximized_horizontal = true, switchtotag = true } },
    -- Set Skype to always map on tags number 3 of screen 1.
    { rule = { class = "Skype" },
      properties = { tag = tags[1][3], switchtotag = true } },
    -- Set VLC to always map on tags number 6 of screen 1.
    { rule = { class = "Vlc" },
      properties = { tag = tags[1][6], maximized_vertical = true,
      maximized_horizontal = ture, switchtotag = true } },
    -- Set Pidgin to always map on tags number 3 of screen 1.
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][3], switchtotag = true } },
    -- Set Claws-mail to always map on tags number 1 of screen 1.
    { rule = { class = "Claws-mail" },
      properties = { tag = tags[1][1], switchtotag = false, minimized = true } },
    -- Set Empathy to always map on tags number 3 of screen 1.
    { rule = { class = "Empathy" },
      properties = { tag = tags[1][3], switchtotag = true } },
    -- Set Evolution to always map on tags number 3 of screen 1.
    { rule = { class = "Evolution" },
      properties = { tag = tags[1][3], switchtotag = true } },
    -- Set Virt-manager to always map on tags number 5 of screen 1.
    { rule = { class = "Virt-manager" },
      properties = { tag = tags[1][5], maximized_vertical = true,
      maximized_horizontal = true, switchtotag = true } },
    -- Set Vmplayer to always map on tags number 2 of screen 1.
    { rule = { class = "Vmplayer" },
      properties = { tag = tags[1][5], maximized_vertical = true,
      maximized_horizontal = true, switchtotag = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

function start_gnome_keyring()
  local output = awful.util.pread("/usr/bin/gnome-keyring-daemon --start")
  for key, val in string.gmatch(output, "([^\n]+)=([^\n]+)") do
    posix.setenv(key, val)
  end
end

run_once("source ~/.xprofile")
run_once("xmodmap $HOME/.Xmodmap &")

--run_once("kdeinit4")

start_gnome_keyring()

run_once("/usr/libexec/polkit-gnome-authentication-agent-1")
run_once("gnome-encfs-manager &")
run_once("nm-applet &")
--run_once("~/.config/awesome/workNetworkConnectionHelper.sh &")
run_once("clipit &")
awful.util.spawn_with_shell("killall xxkb; xxkb")
run_once("~/.config/awesome/auto-start-helper.sh 'evolution --online' 'empathy' 'firefox'")
run_once("blueman-applet &")

--run_once("sleep 3 && qdbus org.kde.kded /kded loadModule kdeconnect")

-- }}}
