local tool = script.Parent
local name = tool.Name

tool.Activated:Connect(function()
	if name == "Delete" then
		local mouse = game.Players.LocalPlayer:GetMouse()
		if mouse.Target then
			mouse.Target:Destroy()
		end
	end
end)
