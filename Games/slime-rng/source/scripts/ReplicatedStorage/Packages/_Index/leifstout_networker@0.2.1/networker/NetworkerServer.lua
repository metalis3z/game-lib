-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NetworkerServer, time of decompilation: Sun May  3 10:10:38 2026 ]]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local NetworkerUtils = require(script.Parent.NetworkerUtils)
local Folder = nil

if RunService:IsRunning() and RunService:IsServer() then
	Folder = Instance.new("Folder")
	Folder.Name = "_remotes"
	Folder.Parent = script.Parent
end

local t1 = {}

t1.__index = t1

function t1.new(p1, t2: {[any]: any}?, p2) -- line: 52
	-- upvalues: RunService (copy), t1 (copy), NetworkerUtils (copy), HttpService (copy), Folder (ref)
	assert(RunService:IsServer(), "NetworkerServer can only be created on the server")

	local v10 = setmetatable({
		networkTag = p1
	}, t1)
	local Folder2 = Instance.new("Folder")
	local RemoteEvent = Instance.new("RemoteEvent")
	local RemoteFunction = Instance.new("RemoteFunction")

	RemoteEvent.Parent = Folder2
	RemoteFunction.Parent = Folder2
	v10.remotes = Folder2
	v10.event = RemoteEvent
	v10.func = RemoteFunction

	if typeof(p1) == "Instance" then
		assert(p1:GetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE) == nil, "NetworkerServer instance already has a networkTag attribute")

		local v14 = HttpService:GenerateGUID(false):sub(1, 13)

		v10.instance = p1
		v10.networkTag = v14
		p1:SetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE, v14)
		v10.instanceConn = p1.Destroying:Once(function() -- line: 81
			-- upvalues: v10 (copy)
			v10:destroy()
		end)
	end

	Folder2.Name = v10.networkTag
	assert(Folder:FindFirstChild(Folder2.Name) == nil, "NetworkerServer with the same name already exists")
	Folder2.Parent = Folder

	if not p2 then
		return v10
	end

	assert(t2, "Module must be provided when clientAccess is set")

	local function callback(p3, s1: string, ...) -- line: 96
		-- upvalues: t2 (copy), p1 (copy), p2 (copy)
		local v53 = t2[s1]

		if not v53 then
			warn("Method " .. s1 .. " does not exist on module", p1)

			return
		end

		if not table.find(p2, v53) then
			warn(p3.Name .. " attempted to call restricted method " .. s1 .. " on service", p1)

			return
		end

		return v53(t2, p3, ...)
	end

	RemoteEvent.OnServerEvent:Connect(callback)
	RemoteFunction.OnServerInvoke = callback

	return v10
end
function t1.addRecipient(p4, p5) -- line: 123
	if not p4.recipients then
		p4.recipients = {}
	end

	assert(p4.recipients, "Recipients list is nil")
	table.insert(p4.recipients, p5)
end
function t1.removeRecipient(p6, p7) -- line: 137
	if not p6.recipients then
		return
	end

	local v20 = table.find(p6.recipients, p7)

	if v20 then
		table.remove(p6.recipients, v20)
	end
end
function t1.clearRecipients(p8) -- line: 152
	p8.recipients = nil
end
function t1.fire(p9, p10, s2: string, ...) -- line: 163
	if typeof(p10) == "Instance" then
		p9.event:FireClient(p10, s2, ...)

		return
	end

	for _, v26 in p10 do
		p9.event:FireClient(v26, s2, ...)
	end
end
function t1.fireAll(p11, s3: string, ...) -- line: 180
	p11.event:FireAllClients(s3, ...)
end
function t1.fireAllExcept(p12, p13, s4: string, ...) -- line: 191
	-- upvalues: Players (copy)
	if typeof(p13) == "Instance" then
		p13 = { p13 }
	end

	for _, v33 in Players:GetPlayers() do
		if not table.find(p13, v33) then
			p12.event:FireClient(v33, s4, ...)
		end
	end
end
function t1.fireRecipients(p14, s5: string, ...) -- line: 209
	if not p14.recipients then
		warn("No recipients set for service ", p14.networkTag)

		return
	end

	p14:fire(p14.recipients, s5, ...)
end
function t1.set(p15, p16, s6: string, p17) -- line: 225
	-- upvalues: NetworkerUtils (copy)
	p15:fire(p16, NetworkerUtils.SET_TAG, s6, p17)
end
function t1.setAll(p18, s7: string, p19) -- line: 235
	-- upvalues: NetworkerUtils (copy)
	p18:fireAll(NetworkerUtils.SET_TAG, s7, p19)
end
function t1.setAllExcept(p20, p21, s8: string, p22) -- line: 246
	-- upvalues: NetworkerUtils (copy)
	p20:fireAllExcept(p21, NetworkerUtils.SET_TAG, s8, p22)
end
function t1.setRecipients(p23, s9: string, p24) -- line: 256
	-- upvalues: NetworkerUtils (copy)
	p23:fireRecipients(NetworkerUtils.SET_TAG, s9, p24)
end
function t1.destroy(p25) -- line: 264
	-- upvalues: NetworkerUtils (copy)
	p25.remotes:Destroy()
	p25:clearRecipients()

	if p25.instanceConn then
		p25.instanceConn:Disconnect()
	end

	if p25.instance then
		p25.instance:SetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE, nil)
		p25.instance = nil
	end
end

return t1
