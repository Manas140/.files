local taglist_buttons = gears.table.join(
  -- Left click
  awful.button({}, 1, function (t)
    t:view_only()
  end)
)

return function(s)
  local tag = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = {
      shape = help.rrect(beautiful.br),
    },
    layout = {
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal
    },
    widget_template = {
      {
        {
          {
            id = 'index_role',
            widget = wibox.widget.textbox,
          },
          margins = dpi(20),
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      id = 'background_role',
      widget = wibox.container.background,
      -- Add support for hover colors and an index label
      create_callback = function(self, _, _, _) --luacheck: no unused args
        self:get_children_by_id('index_role')[1].markup = ' '
      end,
      update_callback = function(self, _, _, _) --luacheck: no unused args
        self:get_children_by_id('index_role')[1].markup = ' '
      end,
    },
    buttons = taglist_buttons
  }
  return tag
end
