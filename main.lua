bump = require 'bump'
gird = require 'grid'
world = bump.newWorld(64)
cooldown = 10

enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage("enemy.png")
enemies_controller.image:setFilter("nearest","nearest")

function love.load()
	Grid:init(50, 200, 50, 200, 10)

	player = {}
	player.x = 0
	player.y = love.graphics.getHeight() - 50
	player.w = 50
	player.h = 10
	player.bullets = {}
	player.cooldown = cooldown
	player.speed = 5
	player.image = love.graphics.newImage("player.png")
	player.fire = function() 
		if player.cooldown <= 0 then
			player.cooldown = cooldown
			bullet = {}
			bullet.x = player.x + 19 -- player.x + player.w / 2 - 5
			bullet.y = love.graphics.getHeight() - 45
			bullet.w = 10
			bullet.h = 10
			bullet.speed = 10
			table.insert(player.bullets, bullet)
		end
	end

	for i = 1, 10 do
		enemies_controller:spawnEnemy(math.random(0, 700), math.random(0, 100))
		--enemies_controller:spawnEnemy(math.random(0, 400), math.random(0, 100))
	end

	enemies = {}
end

function enemies_controller:spawnEnemy(x, y, speed)
	enemy = {}
	enemy.x = x
	enemy.y = y
	enemy.w = 50
	enemy.h = 10
	enemy.bullets = {}
	enemy.cooldown = 20
	enemy.speed = speed or 1
	table.insert(self.enemies, enemy)
end

function enemy:fire()
	if self.cooldown <= 0 then
		self.cooldown = 20
		bullet = {}
		bullet.x = self.x + 35
		bullet.y = self.y
		bullet.w = 10
		bullet.h = 10
		bullet.speed = 10
		table.insert(self.bullets, bullet)
	end
end

function love.update(dt)
	player.y = love.graphics.getHeight() - 50
	player.cooldown = player.cooldown - 1

	if (love.keyboard.isDown("right")) and (player.x < love.graphics.getWidth() - player.w) then
		player.x = player.x + player.speed
	elseif love.keyboard.isDown("left") and (player.x > 0) then
		player.x = player.x - player.speed
	end

	if love.keyboard.isDown(" ") then
		player.fire()
	end

	for i,b in ipairs(player.bullets) do
		if b.y < 1 then
			table.remove(player.bullets, i)
		end
		
		b.y = b.y - b.speed
	end

	for k,e in ipairs(enemies_controller.enemies) do
		if e.y > love.graphics.getHeight() - 50 then
			table.remove(enemies_controller.enemies, k)
			enemies_controller:spawnEnemy(math.random(0, 800), math.random(0, 200), math.random(1, 5))
		else
			e.y = e.y + e.speed	
		end
	end
	-- loveframes.update(dt)
end

function love.draw()
	Grid:draw()
	-- love.graphics.scale(0.5)
	love.graphics.setColor(255, 255, 255)
	-- love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
	love.graphics.draw(player.image, player.x, player.y, 0, 2, 2)

	-- love.graphics.setColor(255, 255, 255)
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
	end

	-- love.graphics.setColor(255, 255, 255)
	for _,e in pairs(enemies_controller.enemies) do
		-- love.graphics.rectangle("fill", e.x, e.y, e.w, e.h)
		love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 2, 2)
	end
	-- loveframes.draw()
end


function love.mousepressed(x, y, button)

    -- your code

    -- loveframes.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

    -- your code

    -- loveframes.mousereleased(x, y, button)

end

function love.keypressed(key, unicode)

    -- your code

    -- loveframes.keypressed(key, unicode)

end

function love.keyreleased(key)

    -- your code

    -- loveframes.keyreleased(key)

end

-- -- function love.textinput(text)
-- 	-- If you are using version 0.9.0 or greater, 
-- 	-- you will need to add this extra callback
-- -- 	loveframes.textinput(text)
-- -- end

-- local bump = require 'bump'

-- -- The grid cell size can be specified via the initialize method
-- -- By default, the cell size is 64
-- world = bump.newWorld(100)

-- -- create two rectangles
-- pointer = {name="player", x=10, y=50, w=20, h=20}
-- block = {name="block", x=50, y=50, w=40, h=40}

-- function love.load()
-- 	-- insert both rectangles into bump
-- 	world:add(pointer, pointer.x, pointer.y, pointer.w, pointer.h) -- x,y, width, height
-- 	world:add(block, block.x, block.y, block.w, block.h)
-- 	actualX, actualY, cols, len = 0, 0, 0, 0
-- end

-- function love.update(dt)
-- 	pointer.x, pointer.y = love.mouse.getPosition()
-- 	actualX, actualY, cols, len = world:move(pointer, pointer.x, pointer.y)

-- 	if (love.keyboard.isDown("right")) then
-- 		actualX, actualY, cols, len = world:move(block, block.x + 1, block.y)
-- 		block.x = block.x + 1
-- 	elseif love.keyboard.isDown("left") then
-- 		actualX, actualY, cols, len = world:move(block, block.x - 1, block.y)
-- 		block.x = block.x - 1
-- 	end


-- 	-- actualX, actualY, cols, len = world:move(pointer, pointer.x, pointer.y)
-- 	-- if love.keyboard.isDown(" ") then
-- 	-- 	player.fire()
-- 	-- end

-- 	-- for i,b in ipairs(player.bullets) do
-- 	-- 	if b.y < 100 then
-- 	-- 		table.remove(player.bullets, i)
-- 	-- 	end
		
-- 	-- 	b.y = b.y - b.speed
-- 	-- end
-- end

-- function love.draw()
-- 	if len > 0 then
-- 		love.graphics.setColor(255, 255, 255)
-- 	else
-- 		love.graphics.setColor(0, 255, 0)
-- 	end

-- 	love.graphics.rectangle("fill", block.x, block.y, block.w, block.h)

-- 	love.graphics.setColor(200, 0, 0)
-- 	love.graphics.rectangle("fill", pointer.x, pointer.y, pointer.w, pointer.h)
-- end