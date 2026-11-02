-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("ServerStorage")
local v_u_4 = require(v3.Services._DataService)
require(v2.Types.ItemSchemas)
return function(p5)
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	local v6 = p5:GetAttribute("Owner")
	if not v6 then
		return
	end
	local v7 = v_u_1:GetPlayerByUserId(v6)
	if not v7 then
		return
	end
	local v8 = v_u_4:GetPlayerData(v7)
	if not v8 then
		return
	end
	local v9 = p5:GetAttribute("UUID")
	if not v9 then
		return
	end
	local v10 = v8.Inventory.Entries[v9]
	if not v10 then
		for _, v11 in v8.PlotBrainrots do
			if v11.UUID == v9 then
				v10 = v11
				break
			end
		end
		if not v10 then
			return
		end
	end
	return v10
end
