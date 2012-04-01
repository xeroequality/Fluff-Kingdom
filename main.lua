-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local gridSize = 10
local fontSize = 24
local playScreen = display.newGroup()
local grid = {} -- tile grid
local button1 = display.newImage("Images/Button.png")
button1.x = display.contentWidth / 2
button1.y = display.contentHeight / 2

local grid1 = {
	{g, g, g, g, g, g, g, g, g, g},
	{g, g, w, w, w, w, g, g, g, g},
	{g, w, w, w, w, w, w, g, g, g},
	{g, g, g, w, w, w, w, w, g, g},
	{g, w, w, w, w, w, w, w, g, g},
	{g, w, w, w, w, w, w, g, g, g},
	{g, g, w, w, w, w, w, g, g, g},
	{g, g, w, w, w, w, g, g, g, g},
	{g, g, g, w, w, g, g, g, g, g},
	{g, g, g, g, g, g, g, g, g, g}
}


local function makeGrid() -- creates grid
	for i=1, gridSize do
		grid[i] = {}
		for j=1, gridSize do
			grid[i][j] = display.newImage("Images/Tile.png")
			grid[i][j].x = 31*(i-1) + 31*(j-1)
			grid[i][j].y = display.contentHeight / 2 - 15*(j-1) + 15*(i-1)
			if (grid1[i][j] == g) then
				grid[i][j]:setFillColor(0, 255, 0)
			elseif (grid1[i][j] == w) then
				grid[i][j]:setFillColor(0, 0, 255)
			else
				grid[i][j]:setFillColor(255, 0, 0)
			end
			playScreen:insert(grid[i][j])
		end
	end
	playScreen:setReferencePoint(display.CenterReferencePoint)
end

makeGrid()

playScreen.x = display.contentWidth + grid[1][1].width
playScreen.alpha = 0

local function activateButton(event)
	transition.to(button1, {time = 500, x = display.contentWidth * -1, transition=easing.linear, alpha=0})
	transition.to(playScreen, {time = 500, x = 0, transition=easing.linear, alpha=1})
end

button1:addEventListener("touch", activateButton)


local function moveScreen(event)
	local target = event.target
	local phase = event.phase
	
	if phase == 'began' then
		deltaX = event.x - target.x
		deltaY = event.y - target.y	
	elseif phase == 'moved' then
		target.x = event.x - deltaX
		target.y = event.y - deltaY
	end
	return true
end

playScreen:addEventListener('touch', moveScreen)
