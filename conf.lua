function love.conf(t)
	--[[ 
	LÖVE may crash if any function from 
	love.graphics is called before the first.
	Use	t.window = t.window or t.screen to fix this issue
	--]]
	--[[
	t.window = t.window or t.screen
	t.window.title = "Test" 
    t.window.width = 800
    t.window.height = 600
    --]]


end