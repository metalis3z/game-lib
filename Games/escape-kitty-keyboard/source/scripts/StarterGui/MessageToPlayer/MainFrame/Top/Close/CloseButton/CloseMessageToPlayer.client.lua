

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local _ = v1.LocalPlayer
local v3 = script.Parent
local u4 = v3:FindFirstAncestorOfClass("ScreenGui")
local u5 = v2:WaitForChild("ClearMessageToPlayer")
v3.MouseButton1Click:Connect(function()

	u5:FireServer()
	if u4 then
		u4.Enabled = false
	end
end)