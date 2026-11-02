-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = script:WaitForChild("Modules")
local v4 = require(v3:WaitForChild("ReplicationReciever"))
require(v3:WaitForChild("Signal"))
local v_u_5 = require(v3:WaitForChild("PathBuilder"))
local v6 = v1:WaitForChild("Data")
require(v6:WaitForChild("DefaultData"))
local v7 = v2.LocalPlayer
local v_u_8 = v4.new((("%*_DataServiceProfile"):format(v7.Name)))
local v_u_9 = {
	["PathBuilder"] = nil,
	["Reciever"] = v_u_8
}
v_u_8.GetDataAsync(v_u_8)
function v_u_9.GetPathSignal(_, p10)
	-- upvalues: (copy) v_u_8
	if p10 then
		return v_u_8:GetPathSignal((tostring(p10)))
	end
end
function v_u_9.GetPlayerDataAsync(_, p11)
	-- upvalues: (copy) v_u_8
	return v_u_8:GetDataAsync(p11)
end
function v_u_9.GetValueFromPathAsync(_, p12, _)
	-- upvalues: (copy) v_u_9
	local v13 = v_u_9:GetPlayerDataAsync()
	local v14 = tostring(p12)
	if typeof(v13) ~= "nil" and v14 ~= "nil" then
		for _, v15 in string.split(v14, "/") do
			v13 = v13[v15]
			if typeof(v13) == "nil" then
				return
			end
		end
		return v13
	end
end
setmetatable(v_u_9, {
	["__index"] = function(_, p16)
		-- upvalues: (copy) v_u_5, (copy) v_u_9
		if p16 == "PathBuilder" then
			local v18 = {
				["__index"] = function(_, p17)
					-- upvalues: (ref) v_u_5
					return v_u_5.new()[p17]
				end
			}
			return setmetatable({}, v18)
		else
			local v19 = v_u_9
			return rawget(v19, p16)
		end
	end
})
return v_u_9
