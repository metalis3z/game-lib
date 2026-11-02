local tool = script.Parent
local ms = game.Players.LocalPlayer:GetMouse()
local cd = false

tool.Activated:Connect(function()
	
	script.Parent.RemoteEvent:FireServer()
	
end)