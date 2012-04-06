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
				grid[i][j] = display.newImage("Images/Tile.png")
				grid[i][j].x = 31*(i-1) + 31*(j-1)
				grid[i][j].y = display.contentHeight / 2 - 15*(j-1) + 15*(i-1)
				if (grid1[i][j] == 1) then
					grid[i][j]:setFillColor(0, 255, 0)
				elseif (grid1[i][j] == 2) then
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

	-- playScreen.x = display.contentWidth + grid[1][1].width
	playScreen.alpha = 0
		local deltaX = playScreen.x
		local deltaY = playScreen.y
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
			target.x = event.x - deltaX
			target.y = event.y - deltaY
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