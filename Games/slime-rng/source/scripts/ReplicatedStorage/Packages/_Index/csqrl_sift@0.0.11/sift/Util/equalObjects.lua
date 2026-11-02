-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: equalObjects, time of decompilation: Sun May  3 10:10:28 2026 ]]
require(script.Parent.Parent.Types)

return function(...) --[[ equalObjects ]] -- line: 20
	local v1 = select(1, ...)

	for i = 2, select("#", ...) do
		if v1 ~= select(i, ...) then
			return false
		end
	end

	return true
end
