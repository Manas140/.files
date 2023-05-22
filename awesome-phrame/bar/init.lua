local sys = require("bar.sys")

awful.screen.connect_for_each_screen(function(s)
  awful.wibar({
    position = "top",
    bg = beautiful.bg,
    fg = beautiful.fg,
    height = dpi(25),
    screen = s
  }):setup {
    layout = wibox.layout.align.horizontal,
    { -- Top
      {
        require("bar.tag")(s),
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal
      },
      margins = dpi(7.5),
      widget = wibox.container.margin,
    },
    { -- Middle
      {
        sys.time,
        spacing = dpi(10),
        layout = wibox.layout.flex.horizontal,
      },
      top = dpi(7.5),
      bottom = dpi(7.5),
      right = dpi(350),
      left = dpi(350),
      widget = wibox.container.margin,
    },
    { -- Bottom
      {
        sys.blu,
        sys.net,
        sys.snd,
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal,
      },
      margins = dpi(7.5),
      widget = wibox.container.margin,
    },
  }
end)
