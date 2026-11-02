local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

wait()
local CanvasProjects = require(game.ServerScriptService.Players)[house.Owner.Value].CanvasProjects

local SurfaceGui = model.Sign.SurfaceGui
local Canvas = SurfaceGui.Canvas

local GRID_SIZE = 8
local CELL_SIZE = SurfaceGui.AbsoluteSize.X / GRID_SIZE



local X = 0
local Y = 0
local function LoadPaintData(projectName)
	local paintData = CanvasProjects[projectName]
	if paintData then
		Canvas:ClearAllChildren()
		for w in string.gmatch(paintData, "%P+") do
			
		
			if w ~= " " then
				local pixel = Instance.new("Frame")
				pixel.BackgroundColor3 = BrickColor.new(tonumber(w)).Color
				pixel.BorderSizePixel = 0
				pixel.Position = UDim2.new(0,X,0,Y)
				pixel.Size = UDim2.new(0,CELL_SIZE,0,CELL_SIZE)
				pixel.Parent = Canvas
			end
					
			if X >= GRID_SIZE * CELL_SIZE - CELL_SIZE then
				X = 0
				Y = Y + CELL_SIZE
			else
				X = X + CELL_SIZE
			end
			
		end
		
		X = 0
	    Y = 0
	end
end

if model.Config.Value ~= "" then
	LoadPaintData(model.Config.Value)
	
elseif owner and owner.Parent and owner:DistanceFromCharacter(model.Sign.Position) < 150 then --dont show if player has just entered the game

	model.Config.Value = workspace.Main.EditPainting:InvokeClient(house.Owner.Value,model.Config.Value) or ""
	LoadPaintData(model.Config.Value)
end

if model.Config.Value == "" then
	Canvas.BackgroundTransparency = 0
else
	Canvas.BackgroundTransparency = 1
end
	
	

model.Sign.ClickDetector.MouseClick:connect(function(player)
	if player == house.Owner.Value then
		
		model.Config.Value = workspace.Main.EditPainting:InvokeClient(house.Owner.Value,model.Config.Value) or ""
		
		LoadPaintData(model.Config.Value)
		
		if model.Config.Value == "" then
			Canvas.BackgroundTransparency = 0
		else
			Canvas.BackgroundTransparency = 1
		end
	end
end)