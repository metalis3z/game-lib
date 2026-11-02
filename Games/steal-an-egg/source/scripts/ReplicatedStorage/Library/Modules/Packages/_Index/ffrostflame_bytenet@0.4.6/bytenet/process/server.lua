-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(script.Parent.Parent.types)

local read = require(script.Parent.read)
local writePacket = require(script.Parent.bufferWriter).writePacket
local t = {}
local t2 = {}

local function create() --[[ create | Line: 18 ]]
	return {
		cursor = 0,
		size = 256,
		references = {},
		buff = buffer.create(256)
	}
end

local function dump(p1) --[[ dump | Line: 27 ]]
	local cursor = p1.cursor
	local v1 = buffer.create(cursor)

	buffer.copy(v1, 0, p1.buff, 0, cursor)

	if #p1.references > 0 then
		return v1, p1.references
	end

	return v1, nil
end

local v1 = create()
local v2 = create()

local function onServerEvent(p1, p2, p3) --[[ onServerEvent | Line: 41 | Upvalues: read (copy) ]]
	if typeof(p2) == "buffer" then
		read(p2, p3, p1)
	end
end

local function playerAdded(p1) --[[ playerAdded | Line: 50 | Upvalues: t (copy), create (copy), t2 (copy) ]]
	if not t[p1] then
		t[p1] = create()
	end

	if t2[p1] then
		return
	end

	t2[p1] = create()
end

return {
	sendAllReliable = function(p1, p2, p3) --[[ sendAllReliable | Line: 62 | Upvalues: v1 (ref), writePacket (copy) ]]
		v1 = writePacket(v1, p1, p2, p3)
	end,
	sendAllUnreliable = function(p1, p2, p3) --[[ sendAllUnreliable | Line: 66 | Upvalues: v2 (ref), writePacket (copy) ]]
		v2 = writePacket(v2, p1, p2, p3)
	end,
	sendPlayerReliable = function(p1, p2, p3, p4) --[[ sendPlayerReliable | Line: 70 | Upvalues: t (copy), writePacket (copy) ]]
		t[p1] = writePacket(t[p1], p2, p3, p4)
	end,
	sendPlayerUnreliable = function(p1, p2, p3, p4) --[[ sendPlayerUnreliable | Line: 79 | Upvalues: t2 (copy), writePacket (copy) ]]
		t2[p1] = writePacket(t2[p1], p2, p3, p4)
	end,
	start = function() --[[ start | Line: 88 | Upvalues: onServerEvent (copy), ReplicatedStorage (copy), Players (copy), t (copy), create (copy), t2 (copy), playerAdded (copy), RunService (copy), v1 (ref), v2 (ref) ]]
		local ByteNetReliable = Instance.new("RemoteEvent")

		ByteNetReliable.Name = "ByteNetReliable"
		ByteNetReliable.OnServerEvent:Connect(onServerEvent)
		ByteNetReliable.Parent = ReplicatedStorage

		local ByteNetUnreliable = Instance.new("UnreliableRemoteEvent")

		ByteNetUnreliable.Name = "ByteNetUnreliable"
		ByteNetUnreliable.OnServerEvent:Connect(onServerEvent)
		ByteNetUnreliable.Parent = ReplicatedStorage

		for v12, v22 in Players:GetPlayers() do
			if not t[v22] then
				t[v22] = create()
			end

			if not t2[v22] then
				t2[v22] = create()
			end
		end

		Players.PlayerAdded:Connect(playerAdded)
		RunService.Heartbeat:Connect(function() --[[ Line: 105 | Upvalues: v1 (ref), ByteNetReliable (copy), v2 (ref), ByteNetUnreliable (copy), Players (ref), t (ref), t2 (ref) ]]
			if v1.cursor > 0 then
				local v12 = v1
				local cursor = v12.cursor
				local v22 = buffer.create(cursor)

				buffer.copy(v22, 0, v12.buff, 0, cursor)
				ByteNetReliable:FireAllClients(v22, if #v12.references > 0 then v12.references else nil)
				v1.cursor = 0
				table.clear(v1.references)
			end

			if v2.cursor > 0 then
				local v4 = v2
				local cursor = v4.cursor
				local v5 = buffer.create(cursor)

				buffer.copy(v5, 0, v4.buff, 0, cursor)
				ByteNetUnreliable:FireAllClients(v5, if #v4.references > 0 then v4.references else nil)
				v2.cursor = 0
				table.clear(v2.references)
			end

			for v7, v8 in Players:GetPlayers() do
				if t[v8].cursor > 0 then
					local v9 = t[v8]
					local cursor = v9.cursor
					local v10 = buffer.create(cursor)

					buffer.copy(v10, 0, v9.buff, 0, cursor)
					ByteNetReliable:FireClient(v8, v10, if #v9.references > 0 then v9.references else nil)
					t[v8].cursor = 0
					table.clear(t[v8].references)
				end

				if t2[v8].cursor > 0 then
					local v12 = t2[v8]
					local cursor = v12.cursor
					local v13 = buffer.create(cursor)

					buffer.copy(v13, 0, v12.buff, 0, cursor)
					ByteNetUnreliable:FireClient(v8, v13, if #v12.references > 0 then v12.references else nil)
					t2[v8].cursor = 0
					table.clear(t2[v8].references)
				end
			end
		end)
	end
}