local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuBlur = game.Lighting:WaitForChild("MenuBlur")
local WindowService = require(game.ReplicatedStorage.Modules.WindowService)
local Connection, Frame

local function FindFrame()
	for _, Object in ipairs(PlayerGui:GetDescendants()) do
		if Object.Name == "GamepassShop" and Object:IsA("GuiObject") then
			return Object
		end
	end
end

local function Connect(FrameObject)
	if Connection then
		Connection:Disconnect()
	end
	
	Frame = FrameObject
	if not Frame then
		MenuBlur.Enabled = false
		return
	end
	
	MenuBlur.Enabled = Frame.Visible
	Connection = Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		MenuBlur.Enabled = Frame.Visible
	end)
end

local function Update()
	Connect(FindFrame())
end

PlayerGui.DescendantAdded:Connect(function(Object)
	if Object.Name == "GamepassShop" and Object:IsA("GuiObject") then
		Connect(Object)
	end
end)

script.Parent.Triggered:Connect(function(PlayerTriggered)
	if PlayerTriggered ~= Player then
		return
	end
	
	if _G.ReturnGUI then
		_G.ReturnGUI()
		_G.SetDock(false)
	end
	WindowService:ToggleFrame("GamepassShop")
	
	local Timeout = tick() + 2
	while not Frame and tick() < Timeout do
		Update()
		task.wait(0.1)
	end
end)

Update()

