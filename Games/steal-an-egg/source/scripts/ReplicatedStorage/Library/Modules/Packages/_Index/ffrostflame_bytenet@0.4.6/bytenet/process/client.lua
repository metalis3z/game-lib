-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(script.Parent.Parent.types)

local read = require(script.Parent.read)
local writePacket = require(script.Parent.bufferWriter).writePacket

local function onClientEvent(p1, p2) --[[ onClientEvent | Line: 10 | Upvalues: read (copy) ]]
	read(p1, p2)
end

local function create() --[[ create | Line: 15 ]]
	return {
		cursor = 0,
		size = 256,
		references = {},
		buff = buffer.create(256)
	}
end

local function dump(p1) --[[ dump | Line: 24 ]]
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

return {
	sendReliable = function(p1, p2, p3) --[[ sendReliable | Line: 39 | Upvalues: v1 (ref), writePacket (copy) ]]
		v1 = writePacket(v1, p1, p2, p3)
	end,
	sendUnreliable = function(p1, p2, p3) --[[ sendUnreliable | Line: 43 | Upvalues: v2 (ref), writePacket (copy) ]]
		v2 = writePacket(v2, p1, p2, p3)
	end,
	start = function() --[[ start | Line: 47 | Upvalues: ReplicatedStorage (copy), onClientEvent (copy), RunService (copy), v1 (ref), v2 (ref) ]]
		local ByteNetReliable = ReplicatedStorage:WaitForChild("ByteNetReliable")

		ByteNetReliable.OnClientEvent:Connect(onClientEvent)

		local ByteNetUnreliable = ReplicatedStorage:WaitForChild("ByteNetUnreliable")

		ByteNetUnreliable.OnClientEvent:Connect(onClientEvent)
		RunService.Heartbeat:Connect(function() --[[ Line: 54 | Upvalues: v1 (ref), ByteNetReliable (copy), v2 (ref), ByteNetUnreliable (copy) ]]
			if v1.cursor > 0 then
				local v12 = v1
				local cursor = v12.cursor
				local v22 = buffer.create(cursor)

				buffer.copy(v22, 0, v12.buff, 0, cursor)
				ByteNetReliable:FireServer(v22, if #v12.references > 0 then v12.references else nil)
				v1.cursor = 0
				table.clear(v1.references)
			end

			if not (v2.cursor > 0) then
				return
			end

			local v4 = v2
			local cursor = v4.cursor
			local v5 = buffer.create(cursor)

			buffer.copy(v5, 0, v4.buff, 0, cursor)
			ByteNetUnreliable:FireServer(v5, if #v4.references > 0 then v4.references else nil)
			v2.cursor = 0
			table.clear(v2.references)
		end)
	end
}