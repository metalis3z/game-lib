local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")

runService.Heartbeat:Connect(function()
	pcall(function()
		starterGui:SetCore("DevConsoleVisible", false)
	end)
end)