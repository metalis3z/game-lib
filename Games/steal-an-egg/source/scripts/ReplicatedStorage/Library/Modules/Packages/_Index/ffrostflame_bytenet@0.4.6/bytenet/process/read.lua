-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local packetIDs = require(script.Parent.Parent.namespaces.packetIDs)
local readRefs = require(script.Parent.readRefs)
local v1 = packetIDs.ref()
local v2 = nil

local function functionPasser(p1, ...) --[[ functionPasser | Line: 9 | Upvalues: v2 (ref) ]]
	local v1 = v2

	v2 = nil
	p1(...)
	v2 = v1
end

local function yielder() --[[ yielder | Line: 16 | Upvalues: functionPasser (copy) ]]
	while true do
		functionPasser(coroutine.yield())
	end
end

local function runListener(p1, ...) --[[ runListener | Line: 22 | Upvalues: v2 (ref), yielder (copy) ]]
	if v2 == nil then
		v2 = coroutine.create(yielder)
		coroutine.resume(v2)
	end

	task.spawn(v2, p1, ...)
end

return function(p1, p2, p3) --[[ Line: 31 | Upvalues: readRefs (copy), v1 (copy), runListener (copy) ]]
	local v12 = buffer.len(p1)

	readRefs.set(p2)

	local v2 = 0

	while v2 < v12 do
		local v3 = v1[buffer.readu8(p1, v2)]
		local v4 = v2 + 1
		local v5, v6 = v3.reader(p1, v4)

		v2 = v4 + v6

		for v7, v8 in v3.getListeners() do
			runListener(v8, v5, p3)
		end
	end
end