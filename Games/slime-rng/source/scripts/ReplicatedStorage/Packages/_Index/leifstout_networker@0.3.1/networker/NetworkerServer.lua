-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NetworkerServer, time of decompilation: Sun May  3 10:10:39 2026 ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local NetworkerUtils = require(script.Parent.NetworkerUtils)
local Folder = nil

if RunService:IsRunning() and RunService:IsServer() then
	Folder = Instance.new("Folder")
	Folder.Name = "_remotes"
	Folder.Parent = script.Parent
end

local t1 = {}

t1.__index = t1

function t1.new(p1, t2: {[any]: any}?, p2) -- line: 53
	-- upvalues: RunService (copy), t1 (copy), NetworkerUtils (copy), HttpService (copy), Folder (ref)
	assert(RunService:IsServer(), "NetworkerServer can only be created on the server")

	local v10 = setmetatable({
		networkTag = p1,
		_accessLookup = {}
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
		v10.instanceConn = p1.Destroying:Once(function() -- line: 83
			-- upvalues: v10 (copy)
			v10:destroy()
		end)
	end

	Folder2.Name = v10.networkTag
	assert(Folder:FindFirstChild(Folder2.Name) == nil, "NetworkerServer with the same name already exists")
	Folder2.Parent = Folder

	if p2 then
		assert(t2, "Module must be provided if clientAccess is specified")
		v10:addClientAccess(t2, p2)
	end

	local function callback(p3, s1: string, ...) -- line: 97
		-- upvalues: v10 (copy), p1 (copy)
		local v59 = v10._accessLookup[s1]

		if not v59 then
			warn(s1 .. " does not exist or is restricted for ", p1)

			return
		end

		return v59.method(v59.module, p3, ...)
	end

	RemoteEvent.OnServerEvent:Connect(callback)
	RemoteFunction.OnServerInvoke = callback

	return v10
end
function t1.addClientAccess(p4, p5, t3: {[any]: any}) -- line: 119
	local function addAccess(p6) -- line: 120
		-- upvalues: t3 (copy), p4 (copy), p5 (copy)
		for _, v62 in t3 do
			for v63, v64 in p6 do
				if v64 == v62 then
					assert(p4._accessLookup[v63] == nil, "Client access method already exists: " .. v63)
					assert(type(v64) == "function", "Client access method must be a function: " .. v63)
					p4._accessLookup[v63] = {
						module = p5,
						method = v62
					}
				end
			end
		end
	end

	addAccess(p5)

	local mt = getmetatable(p5)
	local v21 = mt and mt.__index

	if v21 then
		addAccess(v21)
	end
end
function t1.addRecipient(p7, p8) -- line: 152
	if not p7.recipients then
		p7.recipients = {}
	end

	assert(p7.recipients, "Recipients list is nil")
	table.insert(p7.recipients, p8)
end
function t1.removeRecipient(p9, p10) -- line: 166
	if not p9.recipients then
		return
	end

	local v26 = table.find(p9.recipients, p10)

	if v26 then
		table.remove(p9.recipients, v26)
	end
end
function t1.clearRecipients(p11) -- line: 181
	p11.recipients = nil
end
function t1.fire(p12, p13, s2: string, ...) -- line: 192
	if typeof(p13) == "Instance" then
		p12.event:FireClient(p13, s2, ...)

		return
	end

	for _, v32 in p13 do
		p12.event:FireClient(v32, s2, ...)
	end
end
function t1.fireAll(p14, s3: string, ...) -- line: 209
	p14.event:FireAllClients(s3, ...)
end
function t1.fireAllExcept(p15, p16, s4: string, ...) -- line: 220
	-- upvalues: Players (copy)
	if typeof(p16) == "Instance" then
		p16 = { p16 }
	end

	for _, v39 in Players:GetPlayers() do
		if not table.find(p16, v39) then
			p15.event:FireClient(v39, s4, ...)
		end
	end
end
function t1.fireRecipients(p17, s5: string, ...) -- line: 238
	if not p17.recipients then
		warn("No recipients set for service ", p17.networkTag)

		return
	end

	p17:fire(p17.recipients, s5, ...)
end
function t1.set(p18, p19, s6: string, p20) -- line: 254
	-- upvalues: NetworkerUtils (copy)
	p18:fire(p19, NetworkerUtils.SET_TAG, s6, p20)
end
function t1.setAll(p21, s7: string, p22) -- line: 264
	-- upvalues: NetworkerUtils (copy)
	p21:fireAll(NetworkerUtils.SET_TAG, s7, p22)
end
function t1.setAllExcept(p23, p24, s8: string, p25) -- line: 275
	-- upvalues: NetworkerUtils (copy)
	p23:fireAllExcept(p24, NetworkerUtils.SET_TAG, s8, p25)
end
function t1.setRecipients(p26, s9: string, p27) -- line: 285
	-- upvalues: NetworkerUtils (copy)
	p26:fireRecipients(NetworkerUtils.SET_TAG, s9, p27)
end
function t1.destroy(p28) -- line: 293
	-- upvalues: NetworkerUtils (copy)
	p28.remotes:Destroy()
	p28:clearRecipients()

	if p28.instanceConn then
		p28.instanceConn:Disconnect()
	end

	if p28.instance then
		p28.instance:SetAttribute(NetworkerUtils.INSTANCE_ATTRIBUTE, nil)
		p28.instance = nil
	end
end

return t1
