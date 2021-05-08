ui = nil
updateEvent = nil

function init()
  ui = g_ui.loadUI('stats', modules.game_interface.getMapPanel())
  
  if not modules.client_options.getOption("showFps") then
    ui.fps:hide()
  end
  if not modules.client_options.getOption("showPing") then
    ui.ping:hide()
  end

  updateEvent = scheduleEvent(update, 200)
end

function terminate()
  removeEvent(updateEvent)
end

function update()
  updateEvent = scheduleEvent(update, 500)
  if ui:isHidden() then return end

  text = 'FPS: ' .. g_app.getFps()
  ui.fps:setText(text)
end

function show()
  ui:setVisible(true)
end

function hide()
  ui:setVisible(false)
end