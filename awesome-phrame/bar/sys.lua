local M = {}

-- Wifi
M.net = wibox.widget {
  {
    widget = wibox.container.margin,
    margins = dpi(20),
  },
  bg = beautiful.fg,
  shape = help.rrect(beautiful.br),
  widget = wibox.container.background,
}

-- Volume
M.vol = wibox.widget {
  bar_shape = help.rrect(beautiful.br),
  bar_height = dpi(20),
  handle_width = dpi(10),
  bar_color = '#00000000',
  handle_color = beautiful.pri,
  handle_shape = help.rrect(beautiful.br),
  forced_width = dpi(125),
  widget = wibox.widget.slider,
}

M.snd = wibox.widget {
  {
    id = 'prg',
    max_value = 100,
    value = M.vol.value,
    shape = help.rrect(beautiful.br),
    color = beautiful.pri,
    background_color = beautiful.bg3,
    forced_width = dpi(125),
    widget = wibox.widget.progressbar,
  },
  M.vol,
  layout = wibox.layout.stack,
}

-- Clock
M.time= wibox.widget {
  max_value = 24 * 60,
  shape = help.rrect(beautiful.br),
  color = beautiful.pri,
  background_color = beautiful.bg3,
  widget = wibox.widget.progressbar,
}

-- Tool Tips
local net_t = awful.tooltip {
  shape = help.rrect(beautiful.br),
  margins = 15,
}
local vol_t = awful.tooltip {
  shape = help.rrect(beautiful.br),
  margins = 15,
}
local blue_t= awful.tooltip {
  text = "Bluethooth",
  shape = help.rrect(beautiful.br),
  margins = 15,
}
local time_t = awful.tooltip {
  timer_function = function()
    return os.date('%T')
  end,
  shape = help.rrect(beautiful.br),
  margins = 15,
}

time_t:add_to_object(M.time)
blue_t:add_to_object(M.blu)
net_t:add_to_object(M.net)
vol_t:add_to_object(M.vol)

-- Connect Signals
gears.timer {
  autostart = true,
  timeout = 1,
  callback = function ()
    M.time.value = tonumber(os.date("%H") * 60 + os.date("%M"))
  end
}

awesome.connect_signal('vol::value', function(mut, val)
  if mut == 0 then
    M.vol.handle_color = beautiful.pri
    M.snd:get_children_by_id('prg')[1].color = beautiful.pri
  else
    M.vol.handle_color = beautiful.fg2
    M.snd:get_children_by_id('prg')[1].color = beautiful.fg2
  end
  M.vol.value = val
  vol_t.text = "Volume: "..val
  M.snd:get_children_by_id('prg')[1].value = val
end)

M.vol:connect_signal('property::value', function(val)
  sig.set_vol(val.value)
  vol_t.text = "Volume: "..val.value
  M.snd:get_children_by_id('prg')[1].value = val.value
end)

-- Bluethooth
M.blu = wibox.widget {
  {
    widget = wibox.container.margin,
    margins = dpi(20),
  },
  shape = help.rrect(beautiful.br),
  bg = beautiful.fg,
  widget = wibox.container.background,
}


awesome.connect_signal("blu::value", function(stat)
  if stat:match("no") then
    M.blu.bg = beautiful.pri.."66"
  else
    M.blu.bg = beautiful.pri
  end
end)

awesome.connect_signal("net::value", function(stat, name)
  if stat:match("up") then
    M.net.bg = beautiful.pri
    net_t.markup = name
  else
    M.net.bg = beautiful.pri.."66"
  end
end)

return M
