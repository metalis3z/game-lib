-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: mergeDeep, time of decompilation: Sun May  3 10:10:17 2026 ]]
local ParentParent = script.Parent.Parent
local None = require(ParentParent.None)
local copyDeep = require(script.Parent.copyDeep)

local function mergeDeep(...) -- line: 28
	-- upvalues: None (copy), copyDeep (copy), mergeDeep (copy)
	local t1 = {}

	for i = 1, select("#", ...) do
		local v7 = select(i, ...)

		if type(v7) == "table" then
			for k, v in pairs(v7) do
				if v == None then
					t1[k] = nil
				elseif type(v) == "table" then
					if t1[k] == nil or type(t1[k]) ~= "table" then
						t1[k] = copyDeep(v)
					else
						t1[k] = mergeDeep(t1[k], v)
					end
				else
					t1[k] = v
				end
			end
		end
	end

	return t1
end

return mergeDeep
