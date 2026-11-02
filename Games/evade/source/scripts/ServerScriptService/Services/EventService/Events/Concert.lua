-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	["initialized"] = false
}
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_remoteevent = require(v_u_replicatedstorage.Packages.Net):RemoteEvent("EventService/Concert/Shoot")
function rollAnimal()
	-- upvalues: (copy) v_u_http, (copy) v_u_run, (copy) v_u_remoteevent
	local v1 = {}
	for _, v2 in pairs(workspace:GetChildren()) do
		if v2:HasTag("Animal") then
			table.insert(v1, v2)
		end
	end
	if #v1 == 0 then
		return
	else
		local v3 = v1[math.random(1, #v1)]
		local v_jsondecode = v_u_http:JSONDecode(v3:GetAttribute("Traits") or "[]")
		if v_jsondecode then
			if table.find(v_jsondecode, "Disco") then
				return
			else
				table.insert(v_jsondecode, "Disco")
				local v_jsonencode = v_u_http:JSONEncode(v_jsondecode)
				if v_jsonencode then
					v3:SetAttribute("Traits", v_jsonencode)
					if v_u_run:IsServer() then
						v_u_remoteevent:FireAllClients(math.random(1, 3), v3.Name, workspace:GetServerTimeNow())
					end
				end
			end
		else
			return
		end
	end
end
function v_u1.Start(_)
	-- upvalues: (copy) v_u1, (copy) v_u_replicatedstorage
	if not v_u1.initialized then
		v_u1.initialized = true
		v_u_replicatedstorage:SetAttribute("ConcertEvent", true)
		while v_u1.initialized do
			task.wait(math.random(5, 15))
			rollAnimal()
		end
	end
end
function v_u1.Stop(_)
	-- upvalues: (copy) v_u1, (copy) v_u_replicatedstorage
	v_u1.initialized = false
	v_u_replicatedstorage:SetAttribute("ConcertEvent", nil)
end
return v_u1