-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

require(game.ReplicatedStorage.GlobalTypes)
local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(v_u_1.Modules.Network)
local v4 = require(v_u_1.Modules.Misc.Signal)
local v_u_5 = v2:IsClient()
local function v_u_12(p6, p7, ...)
	local v8 = typeof(p6) == "table"
	assert(v8, "bad eventFile")
	local v9 = typeof(p7) == "string"
	assert(v9, "bad method")
	local v10, v11 = pcall(p6[p7], p6, ...)
	if not v10 then
		warn((("[%*]: Failed to call method %* due to: %*"):format(script:GetFullName(), p7, v11)))
	end
	return v11
end
return {
	["onEventInfoGiven"] = v4.new(),
	["RunningEvents"] = {},
	["ClientEvents"] = {},
	["Init"] = function(p13)
		-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_1, (copy) v_u_12
		if v_u_5 then
			local v14 = v_u_3:FireServerConnection("RequestEventInfoAsync", "REMOTE_FUNCTION")
			if v14 then
				for v15, _ in v14 do
					local v16, v17 = pcall(require, v_u_1.Events:FindFirstChild(v15:gsub("Server", "Client")))
					if v16 then
						p13.ClientEvents[v15] = v17
						v_u_12(v17, "Init")
					else
						warn((("[%*]: Could not locate Client file for: %*"):format(script:GetFullName(), v15)))
					end
				end
				p13.RunningEvents = v14
				p13.onEventInfoGiven:Fire(v14)
			else
				warn((("[%*]: Failed to get Event info from the server."):format((script:GetFullName()))))
			end
		else
			return
		end
	end,
	["GetInfo"] = function(p18)
		return p18.RunningEvents
	end
}
