-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = script.Parent
local _ = v2.Parent.Parent
local v_u_3 = require(v1.Shared.LaserGunsShared)
local v_u_4 = (-1 / 0)
v2.Activated:Connect(function()
	-- upvalues: (ref) v_u_4, (copy) v_u_3
	local v5 = workspace:GetServerTimeNow()
	if v5 - v_u_4 >= v_u_3.Settings.Cooldown:Get() then
		v_u_4 = v5
		v_u_3.ShootLocal()
	end
end)
