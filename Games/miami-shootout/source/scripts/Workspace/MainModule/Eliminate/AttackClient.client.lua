local tool = script.Parent
local ms = game.Players.LocalPlayer:GetMouse()
local cd = false

tool.Activated:Connect(function()
	
	if cd then return end
	
	local target = ms.Target
	
	if target.Parent:FindFirstChild("Humanoid") then
		cd = true
		script.Parent.RemoteEvent:FireServer(target.Parent)
		wait(2)
		cd = false
	end
	
end)