Window = script.Parent
local Canvas = Window:WaitForChild("Canvas")
local Colors = Window:WaitForChild("Colors")
local Save = Window:WaitForChild("Save")
local Load = Window:WaitForChild("Load")
local New = Window:WaitForChild("New")
local Title = Window:WaitForChild("Title")
local LoadWindow = Window:WaitForChild("LoadWindow")
local Template = LoadWindow:WaitForChild("Template")
local CloseMessage = Window:WaitForChild("BanMessage"):WaitForChild("CloseMessage")



local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

local WindowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,true)

local GRID_SIZE = 8
local CELL_SIZE = Canvas.AbsoluteSize.X / GRID_SIZE

local ProjectName
local InputBegan, InputEnded, InputChanged
local NewPressed, SavePressed, LoadPressed, CloseBanMessage
local color = Color3.new(1,1,1)
local Pixels = {}


local ProjectList = Utility:SendData("GetProjectsList","PlayerChannel",10)


function round(a,b) 
	return (math.floor(((a)/b)+0.5)*b)
end


local function ClearCanvas()
	Canvas:ClearAllChildren()
	Pixels = {}
end

local function LoadWindowVisible(visible)
	Canvas.Visible = not visible
	LoadWindow.Visible = visible
	New.Visible = visible
	Save.Visible = not visible
	Load.Visible = not visible
	Colors.Visible = not visible
end


local function SetPixel(x,y)

	x = round(x,CELL_SIZE)
	y = round(y,CELL_SIZE)
	
	local key = tostring(x) .. "/" .. tostring(y)
	local frame = nil
	
	if not Pixels[key] and color then
		Pixels[key] = Instance.new("Frame")
		Pixels[key].BackgroundColor3 = color
		Pixels[key].BorderSizePixel = 0
		Pixels[key].Position = UDim2.new(0,x,0,y)
		Pixels[key].Size = UDim2.new(0,CELL_SIZE,0,CELL_SIZE)
		Pixels[key].Parent = Canvas
	
	elseif Pixels[key] and color then
		Pixels[key].BackgroundColor3 = color
		
	elseif Pixels[key] and not color then
		Pixels[key]:Destroy()
		Pixels[key] = nil
	end
end




local X = 0
local Y = 0
local function LoadPaintData(paintData)
	
	if paintData then
		
		ClearCanvas()
		
		for w in string.gmatch(paintData, "%P+") do
			
			if w == " " then
				color = nil
			else
				color = BrickColor.new(tonumber(w)).Color
			end
			
			SetPixel(X,Y)
			
			if X >= GRID_SIZE * CELL_SIZE - CELL_SIZE then
				X = 0
				Y = Y + CELL_SIZE
			else
				X = X + CELL_SIZE
			end
			
		end
		X = 0
	    Y = 0
		color = Color3.new(1,1,1)
	end
end


local function EncodePaintData()
	local encoded = ""
	for y=0,GRID_SIZE*CELL_SIZE-CELL_SIZE,CELL_SIZE do
		for x=0,GRID_SIZE*CELL_SIZE-CELL_SIZE,CELL_SIZE do
			local frame = Pixels[tostring(x) .. "/" .. tostring(y)]
			if frame then
				encoded = encoded .. tostring(BrickColor.new(frame.BackgroundColor3).Number) .. ","
			else
				encoded = encoded .. " ,"
			end
		end
	end
	return encoded
end


local function SaveProject()
	if ProjectName ~= nil then
		Utility:SendData("SaveCanvasProject","PlayerChannel",nil,ProjectName,EncodePaintData())
	end
end

local function LoadProject(projectName)
	ProjectName = projectName
	Title.Text = ProjectName
	LoadWindowVisible(false)
	local data = Utility:SendData("LoadCanvasProject","PlayerChannel",10,ProjectName)
	LoadPaintData(data)
end

local Templates = {}
local function RefreshProjectsList()
	for i,projectName in ipairs(ProjectList) do
		if not Templates[i] then
			Templates[i] = Template:clone()
			Templates[i].Visible = true
			Templates[i].ProjectName.Text = projectName
			Templates[i].ProjectName.MouseButton1Click:connect(function()
				SaveProject()
				LoadProject(projectName)
			end)
			Templates[i].Delete.MouseButton1Click:connect(function()
				if projectName == ProjectName then
					ProjectName = nil
					Title.Text = ""
					ClearCanvas()
				end
				Templates[i]:Destroy()
				table.remove(Templates,i)
				table.remove(ProjectList,i)
				Utility:SendData("DeleteCanvasProject","PlayerChannel",nil,projectName)
				RefreshProjectsList()
			end)
			Templates[i].Parent = LoadWindow
		end
		Templates[i].Position = UDim2.new(0,0,0,(i-1) * Template.Size.Y.Offset)
		LoadWindow.CanvasSize = UDim2.new(0,0,0,i * Template.Size.Y.Offset)
	end
end


local connections = {}
local finished = false

UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window then
		if visible then
			
			
			
			local mouseDown = false

			InputBegan = Canvas.InputBegan:connect(function(inputObject,gameProcessed)
				if (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch)  then
					SetPixel(inputObject.Position.X-CELL_SIZE/2-Canvas.AbsolutePosition.X,inputObject.Position.Y-CELL_SIZE/2-Canvas.AbsolutePosition.Y)
					mouseDown = true
				end
			end)
			
			InputChanged = Canvas.InputChanged:connect(function(inputObject,gameProcessed)
				if mouseDown and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch)  then
					SetPixel(inputObject.Position.X-CELL_SIZE/2-Canvas.AbsolutePosition.X,inputObject.Position.Y-CELL_SIZE/2-Canvas.AbsolutePosition.Y)
				end
			end)
			
			InputEnded = Canvas.InputEnded:connect(function(inputObject,gameProcessed)
				if (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch)  then
					mouseDown = false
				end
			end)
			
			
			
			
			CloseBanMessage = CloseMessage.MouseButton1Click:connect(function()
				CloseMessage.Parent:Destroy()
				CloseBanMessage:disconnect()
			end)
			
			
			
			
			SavePressed = Save.MouseButton1Click:connect(function()
				SaveProject()
				finished = true
			end)
			
			
			
			NewPressed = New.MouseButton1Click:connect(function()
				
				if #ProjectList >= 30 then
					Dialog:ShowMessage("Too many saved paintings","You have reached the limit of 30 saved paintings. You must delete a painting to save a new one.")
					return
				end
				
				SaveProject()
				
				--UPDATECHANGE
				if not Enums.CanChat then
					--create default project names for player that cant chat

					local projectNumber = 1
					for _,name in ipairs(ProjectList) do
						local number = tonumber(string.sub(name,8))
						if number and number > projectNumber then
							projectNumber = number
						end
					end
					ProjectName = "Project" .. projectNumber + 1
				else
					ProjectName = game.Workspace.MessageService.GetShortString.GetShortString:Invoke("Enter name of painting")
				end
				Title.Text = ProjectName
				table.insert(ProjectList,ProjectName)
				ClearCanvas()
				LoadWindowVisible(false)
			end)
			
			
			
			LoadPressed = Load.MouseButton1Click:connect(function()
				RefreshProjectsList()
				LoadWindowVisible(true)
			end)
			
			
			
			--hook up click events for color picker
			local currentColorButton = nil
			for _,frame in ipairs(Colors:GetChildren()) do
				table.insert(connections,frame.TextButton.MouseButton1Click:connect(function()
					
					
					if currentColorButton then
						currentColorButton.BorderSizePixel = 0
					end
					
					currentColorButton = frame.TextButton
					
					currentColorButton.BorderSizePixel = 1
					currentColorButton.BorderColor3 = Color3.new(1,1,1)
					
					
					color = currentColorButton.BackgroundColor3
					
					if frame.Name == "X" then
						color = nil
					end
					
				end))
			end

		else
			
			finished = true
			InputBegan:disconnect()
			InputEnded:disconnect()
			InputChanged:disconnect()
			NewPressed:disconnect()
			LoadPressed:disconnect()
			SavePressed:disconnect()
			
			if CloseBanMessage then CloseBanMessage:disconnect() end
			
			for _,clickconnection in ipairs(connections) do
				clickconnection:disconnect()
			end
			
			connections = {}
			
		end
	end
end)






debounce = false

function workspace.Main.EditPainting.OnClientInvoke(projectName)
	if debounce then return "" end
	debounce = true
	if projectName ~= "" then
		LoadProject(projectName)
	else --show list of projects
		ProjectName = nil
		Title.Text = ""
		LoadWindowVisible(true)
		RefreshProjectsList()
	end
	
	finished = false
	WindowData:SetVisible(true)

	
	while not finished do 
		wait(.1)
	end
	debounce = false
	WindowData:SetVisible(false)
	return ProjectName
	
end


RefreshProjectsList()



