local storyboard 			= require( "storyboard" )
local Levels 				= require( "levels" )
local scene = storyboard.newScene()

print('here')

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local playScreen = self.view
	local gridSize = 10
	local fontSize = 24
	-- playScreen = display.newGroup()
	local grid = {} -- tile grid
	local grid1 = Levels.gridLines()

	local function makeGrid() -- creates grid
		for i=1, gridSize do
		-- print('here inside make grid')
			grid[i] = {}
			for j=1, gridSize do
				-- Assign color based on level layout
				if (grid1[i][j] == 1) then
					grid[i][j] = display.newImage("images/tile.png")
					grid[i][j].walkable = 1
					grid[i][j]:setFillColor(0, 255, 0)
					print('tHeight: ' .. grid[i][j].height)
					print('tWidth: ' .. grid[i][j].width)
				elseif (grid1[i][j] == 2) then
					grid[i][j] = display.newImage("images/tile.png")
					grid[i][j].walkable = 0
					grid[i][j]:setFillColor(0, 0, 255)
				elseif (grid1[i][j] == 3) then
					grid[i][j] = display.newImage("images/building_blue_tile.png")
					grid[i][j].walkable = 0
				-- else
					-- grid[i][j]:setFillColor(255, 0, 0)
				end
				-- Position the grid tiles to mesh together correctly
				-- tHeight = grid[i][j].height
				-- tWidth = grid[i][j].width
				grid[i][j].x = grid[i][j].width/2*(i-1) + grid[i][j].width/2*(j-1)
				grid[i][j].y = display.contentHeight / 2 - grid[i][j].height/2*(j-1) + grid[i][j].height/2*(i-1)
				playScreen:insert(grid[i][j])
			end
		end

		playScreen:setReferencePoint(display.CenterReferencePoint)
		playScreen.x = display.contentWidth / 2
		playScreen.y = display.contentHeight / 2
		return grid
	end
	local playScreenGrid = makeGrid()

-- This can be used to add something to the grid after it has been created.
		local i = 3
		local j = 3
		playScreenGrid[i][j] = display.newImage("images/building_blue_tile.png")
		playScreenGrid[i][j].walkable = 0
		playScreenGrid[i][j].x = playScreenGrid[i][j].width/2*(i-1) + playScreenGrid[i][j].width/2*(j-1)
		playScreenGrid[i][j].y = display.contentHeight / 2 - playScreenGrid[i][j].height/2*(j-1) + playScreenGrid[i][j].height/2*(i-1)
		playScreen:insert(playScreenGrid[i][j])
	
	
	-- playScreen.x = display.contentWidth + grid[1][1].width
	playScreen.alpha = 0
		local deltaX = 0
		local deltaY = 0
	local function moveScreen(event)
		local target = event.target
		local phase = event.phase
		if phase == 'began' then
			-- if not deltaX then
				-- deltaX = playScreen.x
			-- end
			-- if not deltaY then
				-- deltaY = playScreen.y
			-- end
			deltaX = event.x - target.x
			deltaY = event.y - target.y	
		elseif phase == 'moved' then
			-- Check to see if grid will being moved too far in either X direction
			if (event.x - deltaX >= target.width / 2) then
				-- Bind grid to left border
				target.x = target.width / 2
			elseif (event.x - deltaX <= display.contentWidth - (target.width / 2)) then
				-- Bind grid to right border
				target.x = display.contentWidth - target.width / 2
			else
				target.x = event.x - deltaX
			end
			-- Check to see if grid will being moved too far in either X direction
			if (event.y - deltaY >= target.height / 2) then
				-- Bind grid to top border
				target.y = target.height / 2
			elseif (event.y - deltaY <= display.contentHeight - (target.height / 2)) then
				-- Bind grid to bottom border
				target.y = display.contentHeight - target.height / 2
			else
				target.y = event.y - deltaY
			end
		end
		return true
	end
	playScreen:addEventListener('touch', moveScreen)
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	
	-- remove previous scene's view
	storyboard.purgeScene( "splash" )

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
        -----------------------------------------------------------------------------
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        -----------------------------------------------------------------------------
		
		--Remove All the Runtime Listener
		playScreen:removeEventListener('touch', moveScreen)
		
		--Remove Functions
		makeGrid = nil;
		moveScreen = nil;
		
		gridSize = nil
		fontSize = nil
		playScreen = nil
		grid = nil
        
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 1's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene