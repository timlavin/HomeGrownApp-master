module(..., package.seeall)
-- REQUIRE THE LIBRARY
_G.GUI = require("widget_candy")


local lArrow
local rArrow
local group
local bg
local xCounter
local yCounter
local vIcoW
local vIcoH
local currentPage = 1
local numPages
local pagnation
local index = 1

local function removeModalArrows(var)
  
 lArrow.isVisible = var
 rArrow.isVisible = var
 pagnation.isVisible = var
end


function new(params)
--STEP 3---------------------------------------------------
-----------------------------------------------------------

	-- Step 3 Vegetable Details Modal -----------------------------------
	---------------------------------------------------------------------
	local veg_details_modal = _G.GUI.NewWindow(
	{
		x 			= "center",
		y 			= "center",
		name 		= "Veg_Details",
		theme 		= "theme_2",
		width 		= "78%",
		height 		= "77%",
		scale 		= 2.0,
		closeButton = true, 
		shadow 		= false,
		margin 		= 0,
		caption 	= "Lettuce", 
		textAlign 	= "center",
		textColor 	= {1,1,1},  
		slideOut 	= 2.5,
		selectable 	= false,
		modal 		= true,
		ListItemSelectedColor  = {68/255,219/255,94/255,1},
		onClose = function(EventData) 
		_G.GUI.GetHandle("Add_Vegetables" ):destroy()
		--_G.GUI.GetHandle("Select_Variety" ):destroy()
		_G.GUI.GetHandle("Veg_Details" ):destroy()
		 end
	} )
		_G.GUI.Show("Veg_Details", false, true )
		veg_details_modal.isVisible = false


	local displayInfo = _G.GUI.NewText(
		{
		x           = 15,
		y           = 140,
		name        = "VegTextInfo",
		theme       = "theme_1",
		width = 260,
		height      = "auto",
		caption     = "Veg Preparation Details",
		topMargin       = 5,
		textAlign   = "left",
		group         = "VegTextInfo",
		parentGroup     = "Veg_Details"
		} )

	-- Step 3 Selected Veg Image -----------------------------------
	----------------------------------------------------------------
	local selectedVegImage = _G.GUI.NewImage( display.newImage("vegData/lettuces/picture.png"),
	{
		x               = "center",
		y               = veg_details_modal.y-150,
		width           = 264,
		height          = 124,
		scale 			= 2.0,
		name            = "SELECTED_VEG",
		parentGroup     = "Veg_Details",
	} )


	-- Step 3 Veg Details Options ----------------------------------
	----------------------------------------------------------------
	local vegDetailsOptions = 
	{
		{ iconR = 6, caption = "Pre-Sow", image = "Images/VegDetailsIcon1.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "presow" },
		{ iconR = 6, caption = "Sow", image = "Images/VegDetailsIcon2.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "sow" },
		{ iconR = 6, caption = "Harvest", image = "Images/VegDetailsIcon3.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "harvest" },
		{ iconR = 6, caption = "Common Problems", image = "Images/VegDetailsIcon4.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "problems" },
		{ iconR = 6, caption = "Bugs", image = "Images/VegDetailsIcon5.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "bugs" },
		{ iconR = 6, caption = "Varieties", image = "Images/VegDetailsIcon6.png", imageSize = 64/2, baseDir = system.ResourceDirectory, name = "variety", },
	}

	-- Step 3 Veg Details List ----------------------------------
	-------------------------------------------------------------				
	local vegDetailsList =	_G.GUI.NewList(
	{
		x             = "center",
		y             = veg_details_modal.y-20,
		name          = "DetailsList",
		parentGroup   = "Veg_Details",
		theme         = "theme_1",
		width         = 265,
		height 		  = 242,
		scale 		  = 1.0,
		list          = vegDetailsOptions,
		itemHeight 	  = 40,
		allowDelete   = false,
		scrollbar     = "never",
		noScroll 	  = true,
		onSelect      = function(EventData)
							local List   = EventData.List
							local Item   = EventData.Item
		end				
	} )



	-- Step 3 Modal Back Button ---------------------------------
	-------------------------------------------------------------
	local backBtn2 = _G.GUI.NewShapeButton(
	{
		x       		= veg_details_modal.x-85,                
		y               = veg_details_modal.y-195, 
		width           = 43,
		height          = 44,
		pressColor      = {1,1,1,0},
		name            = "BACK2",  
		parentGroup     = "Veg_Details", 
		theme           = "theme_1",               
		icon            = 18,
		flipIconX       = false,
		toggleButton    = false,
		toggleState     = false,
		onPress         = function(EventData) end,
		onRelease       = function(EventData) 
							--[[if(displayInfo.isVisible==true)then
								_G.GUI.Show("VegTextInfo", false, true )
								_G.GUI.Show("DetailsList", true, true )
								_G.GUI.Show("btnSelectThisVeg", true, false )
								_G.GUI.Set( "btnSelectThisVeg", {  enabled = false } )
								
							else]]
								_G.GUI.Show("Veg_Details", false, true )
								_G.GUI.Show("Add_Vegetables", true, true )
							--end		
		 end,
	} )
	
	------------------------------------------------------------------
	
		_G.GUI.NewButton(
			{
			x               = veg_details_modal.x -70,                
			y               = veg_details_modal.y+225,                
			width           = 134,                   
			scale           = 1.0,
			name            = "SowSeeds",            
			parentGroup     = "Veg_Details",                    
			theme           = "theme_2",               
			caption         = "Seeds", 
			textAlign       = "left",   
			iconAlign       = "left",
			icon            = 49,                       
			toggleButton    = true,
			toggleState     = true or false,--i == 1 and true or false,
			toggleGroup     = "SeedSeedlingGroup",
			} )

		_G.GUI.NewButton(
			{
			x               = veg_details_modal.x +60,                
			y               = veg_details_modal.y+225,                
			width           = 134,                   
			scale           = 1.0,
			name            = "SowSeedlings",            
			parentGroup     = "Veg_Details",                    
			theme           = "theme_3",               
			caption         = "Seedlings", 
			textAlign       = "left",   
			iconAlign       = "left",
			icon            = 50,                       
			toggleButton    = true,
			toggleState     = true or false,--i == 1 and true or false,
			toggleGroup     = "SeedSeedlingGroup",
			} )


	--Step 3 Button "Select this Veg" ----------------------------------------
	--------------------------------------------------------------------------
	local selectThisVegBtn = _G.GUI.NewButton(
	{
		x       	= "center",
		y       	= veg_details_modal.y+270,
		width   	= "65%",
		name    	= "btnSelectThisVeg",
		theme   	= "theme_1",
		parentGroup = "Veg_Details", 
		icon    	= 3,
		caption 	= " Select This Crop",
		enabled 	= true,
		textAlign	= "left",	
		onRelease= function( EventData )
		_G.GUI.GetHandle("Veg_Details"):destroy()
		--_G.GUI.GetHandle("Select_Variety"):destroy()
		_G.GUI.GetHandle("Add_Vegetables"):destroy()
		end,
	} )

--end




-- --STEP 2---------------------------------------------------
-- -----------------------------------------------------------

-- --local function sect2(event)

-- 	-- Step 2 Vegetable Variety Modal ------------------------------
-- 	----------------------------------------------------------------
-- 	local veg_variety_modal = _G.GUI.NewWindow(
-- 	{
-- 		x 			= "center",
-- 		y 			= "center",
-- 		name 		= "Select_Variety",
-- 		theme 		= "theme_1",
-- 		width 		= "78%",
-- 		height 		= "55%",
-- 		scale 		= 2.0,
-- 		closeButton = true, 
-- 		shadow 		= false,
-- 		margin 		= 10,
-- 		caption 	= "Select Variety", 
-- 		textAlign 	= "center",
-- 		textColor 	= {1,1,1}, 
-- 		bgColor 	= {0,0,0}, 
-- 		slideOut 	= 0.5,
-- 		selectable 	= false,
-- 		modal 		= true,
-- 		ListItemSelectedColor  = {68/255,219/255,94/255,1},
-- 		onClose = function(EventData) 
-- 		_G.GUI.GetHandle("Add_Vegetables" ):destroy()
-- 		_G.GUI.GetHandle("Select_Variety" ):destroy()
-- 		_G.GUI.GetHandle("Veg_Details" ):destroy()
-- 		end
-- 		} )
-- 	_G.GUI.Show("Select_Variety", false, true )
-- 	veg_variety_modal.isVisible = false
	
	

-- 	-- Step 2 Populate Vegetable Varieties into a Table ------------------------------
-- 	----------------------------------------------------------------------------------
-- 	local lettuce   = {"Chinese Lettuces","Heading (Crisphead) Lettuces","Batavian Lettuces","Buttercrunch Lettuce","Cos (Romaine) Lettuce","Butterhead Lettuces","Looseleaf Lettuces"}
-- 	local vegVarietyList = {}
-- 		for i = 1, #lettuce do
-- 			table.insert(vegVarietyList, { 
-- 						iconR = 14, 
-- 						caption = lettuce[i], 
-- 						vegType = lettuce[i],
-- 						image = "vegData/lettuces/listIco.png", -- IMAGE FILE TO BE USED FOR THIS ITEM
-- 						imageSize = 40,-- DEFAULT IS ICON SIZE (AS DEFINED IN THEME.LUA)                           
-- 						baseDir   = system.ResourceDirectory, -- IMAGE FILE BASE DIRECTORY (F.E. system.DocumentsDirectory ETC. )      
-- 						} )
-- 			end

					
-- 	-- Step 2 List of Vegetable Varieties ------------------------------------
-- 	--------------------------------------------------------------------------
-- 	local varietyList =	_G.GUI.NewList(
-- 	{
-- 		x             = "center",
-- 		y             = "top",
-- 		name          = "VarietyList",
-- 		parentGroup   = "Select_Variety",
-- 		theme         = "theme_1",
-- 		width         = 280,
-- 		height 		  = 310,
-- 		scale 		  = 1.0,
-- 		list          = vegVarietyList,

-- 		itemHeight    = 50,
-- 		allowDelete   = false,
-- 		scrollbar     = "none",
-- 		onSelect      = function(EventData) 
-- 						selectedVeg = EventData.Item.caption -- <<< Updates the Selected Veg
-- 						_G.GUI.GetHandle("Veg_Details"):set ( "caption", selectedVeg )
-- 						_G.GUI.Show("Veg_Details", true, true )
-- 						_G.GUI.Show("Select_Variety", false, true )
-- 					 	end
-- 	} )



-- 	-- Step 2 Modal Back Button ---------------------------------
-- 	-------------------------------------------------------------
-- 	local backBtn = _G.GUI.NewShapeButton(
-- 	{
-- 		x               = 2,                
-- 		y               = -38, 
-- 		width           = 43,
-- 		height          = 44,
-- 		pressColor      = {1,1,1,0},
-- 		name            = "BACK",  
-- 		parentGroup     = "Select_Variety", 
-- 		theme           = "theme_1",               
-- 		icon            = 18,
-- 		flipIconX       = false,
-- 		toggleButton    = false,
-- 		toggleState     = false,
-- 		onPress         = function(EventData)end,
-- 		onRelease       = function(EventData)
-- 						_G.GUI.Show("Select_Variety", false, true )
-- 						_G.GUI.Show("Add_Vegetables", true, true )
-- 						removeModalArrows(true)
-- 						end,
-- 	} )



--STEP 1---------------------------------------------------
-----------------------------------------------------------

--Step 1 Vegetable Details Modal----------------------------------
------------------------------------------------------------------
local select_veg_modal = _G.GUI.NewWindow(
	{
	x = "center",
	y = "center",
	name = "Add_Vegetables",
	theme = "theme_1",
	width = "78%",
	height = "55%",
	scale = 2.0,
	closeButton = true,
	shadow = false,
	margin = 10,
	caption = "Add Vegetables", 
	textAlign = "center",
	textColor = {1,1,1}, 
	bgColor = {0,0,0}, 
	slideOut = 0.5,
	selectable = false,
	modal = true,
	onClose = function(EventData)
		_G.GUI.GetHandle("Add_Vegetables" ):destroy()
		--_G.GUI.GetHandle("Select_Variety" ):destroy()
		_G.GUI.GetHandle("Veg_Details" ):destroy()
		removeModalArrows(false) 
	end
	} )
	_G.GUI.GetHandle("Add_Vegetables" ):set("tapToFront", false)


-- Step 1 EVENT HANDLER FOR VEG ICONS----------------------------------------
-----------------------------------------------------------------------------

local function selectedVeg(event)
	if(event.phase == "ended")then
	    if(event.target.status == "Lettuce")then
	        _G.GUI.Show("Veg_Details", true, true )
			_G.GUI.Show("Add_Vegetables", false, true )
	        removeModalArrows(false) 
	   	end	
	end
	return true
end

-- Step 1 Display VEG Icons and Add to a Group --------------------------------
-------------------------------------------------------------------------------
vIcoW = 90 -- Veg Icon Height
vIcoH = 90 -- Veg Icon Width
local 	veg = {}
		veg[1] = display.newImageRect("Images/Tomato_Button.png", vIcoW, vIcoH)
		veg[1].status = "Tomato"
		veg[2] = display.newImageRect("Images/Spinach_Button.png", vIcoW, vIcoH)
		veg[2].status = "Spinach"
		veg[3] = display.newImageRect("Images/Lettuce_Button.png", vIcoW, vIcoH)
		veg[3].status = "Lettuce"
		veg[4] = display.newImageRect("Images/Courgette_Button.png", vIcoW, vIcoH)
		veg[4].status = "Courgette"
		veg[5] = display.newImageRect("Images/FrenchBeans_Button.png", vIcoW, vIcoH)
		veg[5].status = "French Beans"
		veg[6] = display.newImageRect("Images/Carrot_Button.png", vIcoW, vIcoH)
		veg[6].status = "Carrots"
		veg[7] = display.newImageRect("Images/SwissChard_Button.png", vIcoW, vIcoH)
		veg[7].status = "Swiss Chard"
		veg[8] = display.newImageRect("Images/Kale_Button.png", vIcoW, vIcoH)
		veg[8].status = "Kale"
		veg[9] = display.newImageRect("Images/SpringOnion_Button.png", vIcoW, vIcoH)
		veg[9].status = "Spring Onion"
		veg[10] = display.newImageRect("Images/Tomato_Button.png", vIcoW, vIcoH)
		veg[10].status = "Tomato"
		veg[11] = display.newImageRect("Images/Spinach_Button.png", vIcoW, vIcoH)
		veg[11].status = "Spinach"
		veg[12] = display.newImageRect("Images/Lettuce_Button.png", vIcoW, vIcoH)
		veg[12].status = "Lettuce"
		veg[13] = display.newImageRect("Images/Courgette_Button.png", vIcoW, vIcoH)
		veg[13].status = "Courgette"
		veg[14] = display.newImageRect("Images/FrenchBeans_Button.png", vIcoW, vIcoH)
		veg[14].status = "French Beans"
		veg[15] = display.newImageRect("Images/Carrot_Button.png", vIcoW, vIcoH)
		veg[15].status = "Carrots"
		veg[16] = display.newImageRect("Images/SwissChard_Button.png", vIcoW, vIcoH)
		veg[16].status = "Swiss Chard"
		veg[17] = display.newImageRect("Images/Kale_Button.png", vIcoW, vIcoH)
		veg[17].status = "Kale"
		veg[18] = display.newImageRect("Images/SpringOnion_Button.png", vIcoW, vIcoH)
		veg[18].status = "Spring Onion"
		veg[19] = display.newImageRect("Images/Tomato_Button.png", vIcoW, vIcoH)
		veg[19].status = "Tomato"
		veg[20] = display.newImageRect("Images/Spinach_Button.png", vIcoW, vIcoH)
		veg[20].status = "Spinach"
		veg[21] = display.newImageRect("Images/Lettuce_Button.png", vIcoW, vIcoH)
		veg[21].status = "Lettuce"
		veg[22] = display.newImageRect("Images/Courgette_Button.png", vIcoW, vIcoH)
		veg[22].status = "Courgette"
		veg[23] = display.newImageRect("Images/FrenchBeans_Button.png", vIcoW, vIcoH)
		veg[23].status = "French Beans"
		veg[24] = display.newImageRect("Images/Carrot_Button.png", vIcoW, vIcoH)
		veg[24].status = "Carrots"
		veg[25] = display.newImageRect("Images/SwissChard_Button.png", vIcoW, vIcoH)
		veg[25].status = "Swiss Chard"
		veg[26] = display.newImageRect("Images/Kale_Button.png", vIcoW, vIcoH)
		veg[26].status = "Kale"
		veg[27] = display.newImageRect("Images/SpringOnion_Button.png", vIcoW, vIcoH)
		veg[27].status = "Spring Onion"


		group = display.newGroup()
		group.height = 280
		xCounter = 0
		yCounter = 0
			for i=1, #veg
				do
				veg[i]:addEventListener("touch", selectedVeg)
				veg[i].x = (veg[i].width / 2) + xCounter
				veg[i].y = (veg[i].height / 2) + yCounter
				yCounter = yCounter + 91
					if(yCounter == 273)then
						yCounter = 0
						xCounter = xCounter + 91
					end
				group:insert( veg[i] )
			end 



-- Step 1 Display and Update Pagnation Control --------------------------------
-------------------------------------------------------------------------------


local function displayPagnation(event)
	local offset = 0
	numPages = #veg / 9 
	local pageIcon = {}
	pagnation = display.newGroup()
	pagnation.anchorX = 0.5
	pagnation.anchorY = 0.5

	for i=1, numPages, 1
	do
		if(i==currentPage)then
			pageIcon[i] = display.newImageRect( "Images/pageIco_yes.png", 20, 20 )
			pageIcon[i]:toFront()
			pageIcon[i].x = pageIcon[i].x + offset
			offset = offset + 30
			pagnation:insert(pageIcon[i])
		else
			pageIcon[i] = display.newImageRect( "Images/pageIco_no.png", 20, 20 )
			pageIcon[i]:toFront()
			pageIcon[i].x = pageIcon[i].x + offset
			offset = offset + 30
			pagnation:insert(pageIcon[i])
		end
		pagnation.x = display.contentCenterX - pagnation.width / 2
		pagnation.y = display.contentCenterY+325
		pagnation:toFront()
	end
end	

local function updatePagnation(event)
	print("Current Page: "..currentPage)
	pagnation:removeSelf()
	displayPagnation()
end
	


-- Step 1 Scrollview for VEG Icons --------------------------------------------
-------------------------------------------------------------------------------
local vegScroll = _G.GUI.NewScrollView(
	{
	x               = "left",
	y               = "top",
	width = "100%",
	height = 280,
	scale           = 1.0,
	name            = "SELECT_VEG",
	parentGroup     = "Add_Vegetables",
	theme           = "theme_1",
	bgColor 		= {1,1,1}, 
	margin          = 0,    -- MARGIN BETWEEN BORDER & CONTENT
	dragX           = true, -- ALLOW HORIZONTAL DRAGGING
	dragY           = false,-- ALLOW VERTICAL DRAGGING
	slideOut        = .4,   -- DRAG-RELEASE SLIDE OUT SPEED (0-.99)
	pagingMode      = true, -- SNAP TO CERTAIN PAGES
	currPage        = 1,    -- PAGE TO START WITH
	content         = group, -- IMAGE OR GROUP OF OBJECTS
	--border          = {"inset",4,1, 1,1,1 ,.25, 0,0,0, 1},
	scrollbarH = onScroll,
	onPress         = function(EventData) end,
	onRelease       = function(EventData) end,
	onDidScroll     = function(EventData)
		currentPage = EventData.currPage
		updatePagnation(event)
										  end,
	onClose = function(EventData) end
	} )
	_G.GUI.Show("Add_Vegetables", true, true )



-- Step 1 Navigation Arrows -----------------------------------------------
---------------------------------------------------------------------------			
local function navArrows(event)
	numPages = #veg / 9
		if(event.target.id == "left" and currentPage>1)then
			currentPage = currentPage - 1
			vegScroll:setPage (currentPage)
			
				event.target:setFillColor(1,0,0,0.9)
				timer.performWithDelay( 100, function(event) lArrow:setFillColor(1,1,1,1) end)
			
			updatePagnation()
		elseif(event.target.id == "right" and currentPage<numPages)then
			currentPage = currentPage + 1
			vegScroll:setPage (currentPage)
				event.target:setFillColor(1,0,0,0.9)
				timer.performWithDelay( 100, function(event) rArrow:setFillColor(1,1,1,1) end)
			updatePagnation()
		end
end

lArrow = display.newImageRect( "Images/veg_arrow.png", 82, 152 )
lArrow.x = display.contentCenterX / 8
lArrow.y = display.contentCenterY
lArrow.id = "left"
lArrow:toFront()
lArrow:addEventListener("tap", navArrows)

rArrow = display.newImageRect( "Images/veg_arrow.png", 82, 152 )
rArrow.rotation = 180
rArrow.x = display.contentCenterX * 1.89
rArrow.y = display.contentCenterY
rArrow.id = "right"
rArrow:toFront()
rArrow:addEventListener("tap", navArrows)


--Call Runtime Functions-----------------------------------------------
-----------------------------------------------------------------------
displayPagnation()
end