grid = {}
camera = {x = 0,y = 0}

function generateNoiseGrid()
	-- Fill each tile in our grid with noise.
	local baseX = 10000 * love.math.random()
	local baseY = 10000 * love.math.random()
	for y = 1, 60 do
		grid[y] = {}
		for x = 1, 60 do
			grid[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
		end
	end
end

function camera:Move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y + 60*dt
    end

    if love.keyboard.isDown("s") then
        self.y = self.y - 60*dt
    end

    if love.keyboard.isDown("a") then
        self.x = self.x + 60*dt
    end

    if love.keyboard.isDown("d") then
        self.x = self.x - 60*dt
    end
end

function love.load()
    print("hi")
	generateNoiseGrid()
end

function love.update(dt)
    camera:Move(dt)
end

function love.draw()
	local tileSize = 8
	for y = 1, #grid do
		for x = 1, #grid[y] do
            if grid[y][x] < 0.5 then
                love.graphics.setColor(30/255,95/255,174/255)
            end
            if grid[y][x] > 0.5 and grid[y][x] < 0.6 then
                love.graphics.setColor(239/225,228/255,176/255)
            end
            if grid[y][x] > 0.6 and grid[y][x] < 0.9 then
                love.graphics.setColor(27/255,141/255,61/255)
            end

            if grid[y][x] > 0.9 and grid[y][x] < 1 then
                love.graphics.setColor(92/255,92/255,92/255)
            end

            love.graphics.rectangle("fill", x*tileSize+camera.x, y*tileSize+camera.y, tileSize, tileSize)
		end
	end
end

function love.keypressed(key)
	if key == "space" then
        generateNoiseGrid()
    end
end