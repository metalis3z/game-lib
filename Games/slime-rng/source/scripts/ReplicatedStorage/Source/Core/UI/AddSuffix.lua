-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AddSuffix, time of decompilation: Sun May  3 10:10:58 2026 ]]
local t1 = {
	"st",
	"nd",
	"rd"
}

return function(n1: number) -- line: 2
	-- upvalues: t1 (copy)
	local v3 = n1 % 100

	if v3 >= 10 and v3 <= 19 then
		return n1 .. "th"
	end

	return n1 .. (t1[n1 % 10] or "th")
end
