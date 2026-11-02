-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1:WaitForChild("TrailUISystem"))
local v3 = require(v1:WaitForChild("EventUISystem"))
local v4 = require(v1:WaitForChild("NextEventTimerSystem"))
local v5 = require(v1:WaitForChild("RadarSystem"))
local v6 = require(v1:WaitForChild("EggRainClient"))
local v7 = require(v1:WaitForChild("StormClient"))
local u8 = require(v1:WaitForChild("NotificationSystem"))
require(v1:WaitForChild("ClientState"))
local v9 = v1:WaitForChild("Remotes")
local v10 = v9:WaitForChild("UpdateUI")
u2:InitLogic()
v3:Init()
v4:Init()
v5:Init()
v6:Init()
v7:Init()
v9:WaitForChild("CurrencyCollect").OnClientEvent:Connect(function(p11)
	-- upvalues: (copy) u8
	u8:ShowCurrencyCollect(p11.icon, p11.label, p11.amount, p11.rarity)
end)
v10.OnClientEvent:Connect(function(p12)
	-- upvalues: (copy) u2
	if p12.OwnedTrails or p12.EquippedTrail then
		task.defer(function()
			-- upvalues: (ref) u2
			u2:UpdateDisplay()
		end)
	end
end)