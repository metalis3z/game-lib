-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local v1 = t.interface({
	removeFrom = t.table,
	object = t.table
})

local function verifyTrove(p1) --[[ verifyTrove | Line: 36 ]]
	if typeof(p1) == "table" then
		if typeof(p1.Add) ~= "function" then
			error("Bad trove configuration inside removed object. If no trove intended then opt for creating one via config.")
		end
	else
		error("Bad trove configuration inside removed object. If no trove intended then opt for creating one via config.")
	end

	return p1
end

return function(p1) --[[ InjectAutoRemovalBehavior | Line: 47 | Upvalues: v1 (copy), Trove (copy) ]]
	assert(v1(p1))

	local object = p1.object
	local removeFrom = p1.removeFrom

	if p1.createTroveIfNotExists then
		p1.object._trove = Trove.new()
	end

	local v2 = p1.overrideObjectTrove or object._trove

	if typeof(v2) == "table" then
		if typeof(v2.Add) ~= "function" then
			error("Bad trove configuration inside removed object. If no trove intended then opt for creating one via config.")
		end
	else
		error("Bad trove configuration inside removed object. If no trove intended then opt for creating one via config.")
	end

	if p1.indexOverride then
		removeFrom[p1.indexOverride] = object
		v2:Add(function() --[[ Line: 62 | Upvalues: removeFrom (copy), p1 (copy) ]]
			removeFrom[p1.indexOverride] = nil
		end)
	else
		table.insert(removeFrom, object)
		v2:Add(function() --[[ Line: 67 | Upvalues: removeFrom (copy), object (copy) ]]
			table.remove(removeFrom, table.find(removeFrom, object))
		end)
	end

	return object
end