local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = script.Parent
local _ = v2.Parent.Parent
local v_u_3 = require(v1.Shared.LaserGunsShared)
local v_u_4 = (-1 / 0)
v2.Activated:Connect(function()
	local v5 = workspace:GetServerTimeNow()
	if v5 - v_u_4 >= v_u_3.Settings.Cooldown:Get() then
		v_u_4 = v5
		v_u_3.ShootLocal()
	end
end)