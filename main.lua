local widget = require( "widget" ) --<< For Native Widgets, Scrollview, etc.
local grid = require("grid") --<<-- Require the AddVeg Module
_G.GUI = require("widget_candy")
_G.GUI.LoadTheme("theme_1", "themes/theme_1/")-- LOAD A THEME
_G.GUI.LoadTheme("theme_2", "themes/theme_2/")-- LOAD A THEME
_G.GUI.LoadTheme("theme_3", "themes/theme_3/")-- LOAD A THEME


-- APPLY A TINT COLOR TO ALL WIDGETS USING THIS THEME:
--_G.GUI.SetThemeColor("theme_1", { 91/255,194/255,54/255 } )
--GLOBAL VARIABLES
centerX = display.contentCenterX
centerY = display.contentCenterY 
screenLeft = display.screenOriginX
screenWidth = display.contentWidth - screenLeft * 2
screenRight = screenLeft + screenWidth
screenTop = display.screenOriginY
screenHeight = display.contentHeight - screenTop * 2
screenBottom = screenTop + screenHeight
display.contentWidth = screenWidth
display.contentHeight = screenHeight
screenTopSB = screenTop + display.topStatusBarContentHeight -- when status bar is showing
screenHeightSB = display.contentHeight - screenTopSB
screenBottomSB = screenTopSB + screenHeightSB
--
display.tl = display.TopLeftReferencePoint
display.tc = display.TopCenterReferencePoint
display.tr = display.TopRightReferencePoint
display.cl = display.CenterLeftReferencePoint
display.c  = display.CenterReferencePoint
display.cr = display.CenterRightReferencePoint
display.bl = display.BottomLeftReferencePoint
display.bc = display.BottomCenterReferencePoint
display.br = display.BottomRightReferencePoint
display.setStatusBar( display.HiddenStatusBar )


--Declare Splash and Background Colour
local splashscreen = display.newImage( "Default-667h@2x.png",750,1337 );
splashscreen.x, splashscreen.y = display.contentWidth / 2, display.contentHeight / 2
display.setDefault("background", 1, 1, 1, 1 )

local function removeSplash(event)
    splashscreen:removeSelf()
    splashscreen = nil
    
    local hasData = true; --<<--- Need to Check DB for Code so this will be replaced
       if(hasData) then
            
            --Create a New Veg Grid Object
			local vegGrid = grid.new()

			-- Our Scrollview listener
			--[[local function scrollListener (event)
				local phase = event.phase
				local direction = event.direction

			-- If the scrollView has reached it's scroll limit
				if event.limitReached then
						if "up" == direction then
						print("Reached Top Limit")
					elseif "down" == direction then
						print("Reached Bottom Limit")
					elseif "left" == direction then
						print("Reached Left Limit")	
					elseif "right" == direction then
						print("Reached Right Limit")
					end	
				end	
				return true
			end


			local scrollView = widget.newScrollView
			{
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				width = display.contentWidth,
				height = display.contentHeight,
				topPadding = 0,
				leftPadding = 0,
				bottomPadding = 0,
				rightPadding = 0,
				horizontalScrollDisabled = false,
				verticalScrollDisabled = false,
				listener = scrollListener,
				hideBackground = false
			}]]--
			--scrollView:insert(vegGrid)

			_G.GUI.NewScrollView(
				{
				x               = "center",
				y               = "center",
				width           = screenWidth+10,
				height          = screenHeight+20,
				scale           = 1.0,
				name            = "Grid Scrollview",
				parentGroup     = nil,
				theme           = "theme_1",
				margin          = 0,    -- MARGIN BETWEEN BORDER & CONTENT
				dragX           = true, -- ALLOW HORIZONTAL DRAGGING
				dragY           = true,-- ALLOW VERTICAL DRAGGING
				slideOut        = .4,   -- DRAG-RELEASE SLIDE OUT SPEED (0-.99)
				pagingMode      = false, -- SNAP TO CERTAIN PAGES
				currPage        = 1,    -- PAGE TO START WITH
				content         = vegGrid,-- IMAGE OR GROUP OF OBJECTS
				onPress         = function(EventData)end,
				onRelease       = function(EventData)end,
				onDidScroll     = function(EventData)end
			} )



			function loadMenu( event )

			    if ( event.phase == "began") then      
			        print( "began phase" )
			        event.target.alpha = 0.5
			        display.getCurrentStage():setFocus( event.target )
			        Runtime:removeEventListener(scrollListener)


			    elseif (event.phase == "ended" or event.phase == "cancelled" ) then
			        print( "end phase" )
			        event.target.alpha = 1
			        display.getCurrentStage():setFocus( nil )
			        Runtime:removeEventListener(scrollListener)
			    end
			    return true;
			end

			local menuButton = display.newImageRect("Images/MenuButton.png", 144, 144)
			      menuButton.x = screenRight - menuButton.width/2 - 24
			      menuButton.y = screenTop + menuButton.height/2 + 24
			      menuButton:addEventListener( "touch", loadMenu )



        elseif(hasData) == false then
            composer.gotoScene( "wizard", { effect= "fade", time = 500 })
		end
end 




local function onSystemEvent( event )

    local eventType = event.type

    if ( eventType == "applicationStart" ) then
        -- Occurs when the application is launched and all code in "main.lua" is executed
            timer.performWithDelay(2000,removeSplash)
        print("Application Started")
    elseif ( eventType == "applicationExit" ) then
        -- Occurs when the user or OS task manager quits the application
        print("Application Exited")
    elseif ( eventType == "applicationSuspend" ) then
        -- Perform all necessary actions for when the device suspends the application, i.e. during a phone call
        print("Application Suspended")
    elseif ( eventType == "applicationResume" ) then
        -- Perform all necessary actions for when the app resumes from a suspended state
        print("Application Resumed")
    elseif ( eventType == "applicationOpen" ) then
        -- Occurs when the application is asked to open a URL resource (Android and iOS only)
        print("Application Opened")
    end
end




Runtime:addEventListener( "system", onSystemEvent )