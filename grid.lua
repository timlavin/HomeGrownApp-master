module(..., package.seeall) --<<-- DECALRE Lua File as a Module

local AddVeg = require("AddVeg") --<<-- Require the AddVeg Module

-- LOCAL VATIABLES
local group = display.newGroup()
local cell --<<-- The Cell that has been tapped
local grassImg = { type="image", filename="Images/grassIco.png" }
local soilImg = { type="image", filename="Images/soilIco.png" }
local gd
local numCols = 25 --<<-- Number of Columns in the Grid
local numRows = 25 --<<-- Number of Rows in the Grid
local lastTapped = {row = 1, col = 1} --<<-- Track the last tapped object
local addVegButton
local wasCalled = false



function new(params)

  -- CALCULATE THE CELLS NEIGHBOURS AND PASS IN GRID ID AND RETURNS LUA TABLE
  local function getNeighbors(padNum)
    local neighbors = {} --<<-- Create Table to store neighbouring cells
      
      local function inLeftColumn()
        return ((padNum-1) % numCols) == 0
      end
                            
      local function inRightColumn()
        return (padNum % numCols) == 0
      end

      local inLeft = inLeftColumn() 
      local inRight = inRightColumn()

      -- number above, above left/right
        if padNum > numCols then
            neighbors[#neighbors+1] = padNum - numCols
              if not inLeft then
                neighbors[#neighbors+1] = padNum - numCols - 1
              end
              if not inRight then
                neighbors[#neighbors+1] = padNum - numCols + 1
              end
        end

        -- number below &amp; below left/right
        if padNum <= (numCols * (numRows-1)) then
            neighbors[#neighbors+1] = padNum + numCols -- number below
              if not inLeft then
                neighbors[#neighbors+1] = padNum + numCols - 1
              end
              if not inRight then
               neighbors[#neighbors+1] = padNum + numCols + 1
              end
        end

        -- number to right
              if not inRight then
                neighbors[#neighbors+1] = padNum + 1
              end

        -- number to left
              if not inLeft then
                neighbors[#neighbors+1] = padNum - 1
              end

    return neighbors
  end --<<--END FUNCTION getNeighbors(padNum)

           
  local function hideArrow(event)
    event.target.isVisible = false
  end



  local function hasArrowCollided( obj1, obj2 )
    
    if ( obj1 == nil ) then  -- Make sure the first object exists
      return false
    end

    if ( obj2 == nil ) then  -- Make sure the other object exists
      return false
    end
    
    if ( obj1.isSelected == true ) then  -- Make sure the first object exists
      local dx = obj1.x - obj2.x
      local dy = obj1.y - obj2.y
      local distance = math.sqrt( dx*dx + dy*dy )
      local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)
               
        if ( distance < objectSize ) then
          return true
        end
    end
  return false

  end --<<-- End has Arrow Collided

  
  -- Remove the tick and x icons over the selected cell when the x is ticked
  local function removeButtonIco(lastTapped, cell)   
    if (gd[lastTapped.row][lastTapped.col].apply ~= nil) then 
        gd[lastTapped.row][lastTapped.col].apply.isVisible = false;
        gd[lastTapped.row][lastTapped.col].cancel.isVisible = false;
    end
  end

  local function removeSelectedChip(selected_cell)
    selected_cell.isSelected = false
    selected_cell:setFillColor( 1, 1, 1 )
    group:remove(selected_cell.topArrow)
    group:remove(selected_cell.leftArrow)
    group:remove(selected_cell.rightArrow)
    group:remove(selected_cell.bottomArrow)
    group:remove(selected_cell.cancel)
    group:remove(selected_cell.apply)
    selected_cell.fill = grassImg;
    selected_cell.state = "Grass";

    for k, v in pairs( getNeighbors(selected_cell.counter) ) do  
      for cols = 1, numCols do
        for rows = 1, numRows do
          if(gd[cols][rows].counter == v)then
            local paint = { 1, 1, 1 }
                  gd[cols][rows].stroke = paint
                  gd[cols][rows].strokeWidth = 0

                  if (gd[cols][rows].isSelected == true and gd[cols][rows].state == "Grass Selected")  then

                      if (gd[cols][rows].counter == selected_cell.counter + numRows) then
                          gd[cols][rows].leftArrow.isVisible = true;

                      elseif (gd[cols][rows].counter == selected_cell.counter - numRows) then
                          gd[cols][rows].rightArrow.isVisible = true;

                      elseif (gd[cols][rows].counter == selected_cell.counter - 1) then
                          gd[cols][rows].bottomArrow.isVisible = true;

                      elseif (gd[cols][rows].counter == selected_cell.counter + 1) then
                          gd[cols][rows].topArrow.isVisible = true;
                      end

                  end --<<--End Inner IF
          end --<<--End Outer IF
        end --<<--Inner For Loop
      end --<<--End Middle For Loop
    end --<<--End Outer For Loop

  end --<<--End RemoveSelectedChip function

local function displayVegManageButtons( event )


  if (addVegButton == nil and wasCalled == false)then --<<--If addVegButton has not being assigned, assign image object.

      _G.GUI.NewButton(
    {
    x       = centerX - 194,
    y       = screenBottom-150,
    width   = 388,
    height  = 76, 
    name    = "addVegButton",
    theme   = "theme_1",
    textAlign = "center",
    scale   = "2.0",
    caption = "Add Vegetables",
    onPress = function(EventData)  
    AddVeg.new() 
    wasCalled = true
    end,
    } )

  end

end


  local function changeSelectedToSoil( event )
    display.getCurrentStage():setFocus( event.target )
    if(event.phase == "began") then
    display.getCurrentStage():setFocus( nil )
      for col = 1, numCols do
        for row = 1, numRows do
          if gd[col][row].isSelected == true then
            gd[col][row].fill = soilImg;
            gd[col][row].state = "Soil"
            gd[col][row].topArrow.isVisible = false;
            gd[col][row].bottomArrow.isVisible = false;
            gd[col][row].leftArrow.isVisible = false;
            gd[col][row].rightArrow.isVisible = false;
            gd[col][row].apply.isVisible = false;
            gd[col][row].cancel.isVisible = false;
            hasSoil = true
          end --End If Statement
        end --End Inner For Loop
      end --End Outer For Loop
    end --End If/Else
    displayVegManageButtons( event )
  return true
  end--End Function


          
  local function cancelSelectedCells( event )
    display.getCurrentStage():setFocus( event.target )
    if(event.phase == "began") then
    display.getCurrentStage():setFocus( nil )
    for col = 1, numCols do
      for row = 1, numRows do
        if gd[col][row].isSelected == true and gd[col][row].state == "Grass Selected" then
          removeSelectedChip(gd[col][row]);
        end
      end
    end
  end
  return true
  end



  local function displayButtonIco(event, cell)

     cell.apply =  _G.GUI.NewImage( display.newImage("Images/tick.png"),
                    {
                    x               = cell.x - 110,
                    y               = cell.y - 110,
                    width           = 70,
                    height          = 70,
                    --name            = "IMG_SAMPLE",
                    parentGroup     = nil,
                    --border          = {"inset",4,1, .7,1,.7,.25},
                    onPress         = function(EventData) print("IMAGE PRESSED!")  end,
                    onRelease       = function(EventData) changeSelectedToSoil(event) end,
                    onDrag          = function(EventData) print("IMAGE DRAGGING!") end,
                    } )
    --cell.apply = display.newImageRect("Images/tick.png", 70, 70)
    --cell.apply.x = cell.x - cell.apply.width
    --cell.apply.y = cell.y - cell.apply.height
    --cell.apply:addEventListener("touch",changeSelectedToSoil)
    group:insert(cell.apply)

    cell.cancel =  _G.GUI.NewImage( display.newImage("Images/cross.png"),
                    {
                    x               = cell.x + 40,
                    y               = cell.y - 110,
                    width           = 70,
                    height          = 70,
                    --name            = "IMG_SAMPLE",
                    parentGroup     = nil,
                    --border          = {"inset",4,1, .7,1,.7,.25},
                    onPress         = function(EventData) print("IMAGE PRESSED!")  end,
                    onRelease       = function(EventData) cancelSelectedCells(event) end,
                    onDrag          = function(EventData) print("IMAGE DRAGGING!") end,
                    } )
    --display.newImageRect("Images/cross.png", 70,70)
   -- cell.cancel.x = cell.x+cell.cancel.height
    --cell.cancel.y = cell.y-cell.cancel.width
    --cell.cancel:addEventListener("touch",cancelSelectedCells)
    group:insert(cell.cancel)
           
    removeButtonIco(lastTapped, cell)
    lastTapped = {row = cell.gridPos.x, col = cell.gridPos.y}
  end



  -- RUN FUNCTION IF CHIPPED IS TAPPED
    local function chipTapped(event)
        if(event.phase == "began")then
          display.getCurrentStage():setFocus( event.target )
      local function checkBoundryCell( boundry_cell )
          
          if (boundry_cell.counter <= numRows) then
              boundry_cell.leftArrow.isVisible =  false;
          end

          if ((boundry_cell.counter - 1 ) % numRows == 0) then
              boundry_cell.topArrow.isVisible =  false;
          end

          if (boundry_cell.counter % numRows) == 0 then
            boundry_cell.bottomArrow.isVisible = false;
          end

          if (boundry_cell.counter >= numRows*numCols - numRows) then
            boundry_cell.rightArrow.isVisible = false;
          end
      end
      -- If is not already selected, make it selected
      if(event.target.isSelected == false) then
        cell = event.target
        cell.isSelected = true
        cell:setFillColor( 44/255, 152/255, 146/255, 1 )
        cell.state = "Grass Selected"
        displayButtonIco(event, cell)

        cell.topArrow = display.newImageRect("Images/gridArrow.png", 150, 150)
	      cell.topArrow.rotation = 0
	      cell.topArrow.x = cell.x
	      cell.topArrow.y = cell.y - cell.height

	      cell.leftArrow = display.newImageRect("Images/gridArrow.png", 150, 150)
	      cell.leftArrow.rotation = 270
	      cell.leftArrow.x = cell.x - cell.width
	      cell.leftArrow.y = cell.y 

	      cell.rightArrow = display.newImageRect("Images/gridArrow.png", 150, 150)
	      cell.rightArrow.rotation = 90
	      cell.rightArrow.x = cell.x + cell.width
	      cell.rightArrow.y = cell.y 
	        
        cell.bottomArrow = display.newImageRect("Images/gridArrow.png", 150, 150)
	      cell.bottomArrow.rotation = 180
	      cell.bottomArrow.x = cell.x
	      cell.bottomArrow.y = cell.y + cell.height
	        
        group:insert(cell.topArrow)
        group:insert(cell.leftArrow)
        group:insert(cell.rightArrow)
        group:insert(cell.bottomArrow)

        cell.topArrow:addEventListener( "touch", hideArrow )
        cell.bottomArrow:addEventListener( "touch", hideArrow )
        cell.leftArrow:addEventListener( "touch", hideArrow )
        cell.rightArrow:addEventListener( "touch", hideArrow )

        checkBoundryCell(cell);

		    for k, v in pairs( getNeighbors(cell.counter) ) do	
   		    for cols = 1, numCols do
				    for rows = 1, numRows do
					     if(gd[cols][rows].counter == v)then
                  local isLeftArrow =  hasArrowCollided(gd[cols][rows], cell.leftArrow)
						      local isRightArrow =  hasArrowCollided(gd[cols][rows], cell.rightArrow)
						      local isTopArrow =  hasArrowCollided(gd[cols][rows], cell.topArrow)
						      local isBottomArrow =  hasArrowCollided(gd[cols][rows], cell.bottomArrow)
                  if(isLeftArrow == true)then
								    cell.leftArrow.isVisible = false
							    end
							    if(isRightArrow == true)then
							      cell.rightArrow.isVisible = false
							    end	
							    if(isTopArrow == true)then	
								    cell.topArrow.isVisible = false
							    end
							    if(isBottomArrow == true)then	
								    cell.bottomArrow.isVisible = false
							    end
   					    end
				    end
			    end
		    end
    
      elseif (event.target.isSelected == true and event.target.state == "Grass Selected") then
        local selected_cell = event.target;
        removeSelectedChip(selected_cell);

      end -- End Outer If/Else
    end
  end -- End Function


--=================================================================
-- grid code
--=================================================================
local chipWidth = 150 --<-- Width of the Grid Cell
local chipHeight = 150 --<-- Width of the Grid Cell
local counter = 0

gd = {} --<<-- The Grid Table

    for col = 1, numCols do
    	gd[col] = {}
        for row = 1, numRows do          
            local grass = display.newRect(0,0,chipWidth,chipHeight);
            grass.x = col * grass.width - grass.width/2
            grass.y = row * grass.height - grass.height/2
            grass.gridPos = {x=col, y=row}
            grass.isSelected = false
            grass.fill = grassImg;
            grass.state = "Grass"
            grass:addEventListener("touch", chipTapped)
            gd[col][row] = grass
            counter = counter  + 1 
            grass.counter = counter
            group:insert(grass)          
        end
    end	
return group
end