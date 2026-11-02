-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: merge, time of decompilation: Sun May  3 10:10:17 2026 ]]
local ParentParent = script.Parent.Parent
local None = require(ParentParent.None)

return function(...) --[[ merge ]] -- line: 27
	-- upvalues: None (copy)
	local t1 = {}

	for i = 1, select("#", ...) do
		local v5 = select(i, ...)

		if type(v5) == "table" then
			for k, v in pairs(v5) do
				t1[k] = if v ~= None then v else nil
			end
		end
	end

	return t1
end
