

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
assert(v3, "LocalPlayer manquant")
local u4 = v3:WaitForChild("PlayerGui"):WaitForChild("AdminAbuseGui", 30)
if u4 and u4:IsA("ScreenGui") then
	local v5 = v2:WaitForChild("AdminAbuse"):WaitForChild("Remotes"):WaitForChild("AdminAbuseSync")
	local v6 = v2:WaitForChild("AdminAbuse"):WaitForChild("Remotes"):WaitForChild("AdminAbuseRequest")
	u4.Enabled = false
	v5.OnClientEvent:Connect(function(p7)

		if p7 == "Start" then
			u4.Enabled = true
		elseif p7 == "Stop" then
			u4.Enabled = false
		end
	end)
	v6:FireServer("GetState")
else
	warn("[AdminAbuseGuiVisibility] AdminAbuseGui ScreenGui introuvable")
end