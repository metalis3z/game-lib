-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: concatDeep, time of decompilation: Sun May  3 10:09:49 2026 ]]
local ParentParent = script.Parent.Parent
local copyDeep = require(script.Parent.copyDeep)
local None = require(ParentParent.None)

return function(...) --[[ concatDeep ]] -- line: 28
	-- upvalues: None (copy), copyDeep (copy)
	local t1 = {}

	for i = 1, select("#", ...) do
		local v6 = select(i, ...)

		if type(v6) == "table" then
			for _, v in ipairs(v6) do
				if v ~= None then
					if type(v) == "table" then
						table.insert(t1, copyDeep(v))
					else
						table.insert(t1, v)
					end
				end
			end
		end
	end

	return t1
end
