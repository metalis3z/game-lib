-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: concat, time of decompilation: Sun May  3 10:09:48 2026 ]]
local ParentParent = script.Parent.Parent
local None = require(ParentParent.None)

return function(...) --[[ concat ]] -- line: 26
	-- upvalues: None (copy)
	local t1 = {}

	for i = 1, select("#", ...) do
		local v5 = select(i, ...)

		if type(v5) == "table" then
			for _, v in ipairs(v5) do
				if v ~= None then
					table.insert(t1, v)
				end
			end
		end
	end

	return t1
end
