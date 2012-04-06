-- local LevelStructure 			= require ( "levelStructure" )
local storyboard 				= require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


local playButton

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease( self, event )
	if event.phase == "began" then
		storyboard.gotoScene( "levelStructure", "fade", 800  )
		-- transition.to(playButton, {time = 500, x = display.contentWidth * -1, transition=easing.linear, alpha=0})
		-- transition.to(playScreen, {time = 500, x = 0, transition=easing.linear, alpha=1})
		--LevelStructure.makeGrid()
	end
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	playButton = display.newImage("Images/Button.png")
	playButton.x = display.contentWidth / 2
	playButton.y = display.contentHeight / 2
	playButton.text = display.newText('Click me',0,0,native.systemFont,28)
	playButton.text:setTextColor(0)
	playButton.text.x = playButton.x
	playButton.text.y = playButton.y
	screenGroup:insert(playButton)
	screenGroup:insert(playButton.text)
	playButton.touch = onPlayBtnRelease
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	playButton:addEventListener("touch", playButton)
	print( "1: enterScene event" )

end
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        
        -----------------------------------------------------------------------------
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        -----------------------------------------------------------------------------
		--Remove the Runtime Listeners
		playButton:removeEventListener("touch",playButton)

end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )

	-----------------------------------------------------------------------------
	--      INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-----------------------------------------------------------------------------
	if playButton then
		playButton:removeSelf()
		playButton.text = nil
		playButton = nil
	end
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