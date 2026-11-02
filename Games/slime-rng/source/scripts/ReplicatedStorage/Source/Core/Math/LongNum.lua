-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LongNum, time of decompilation: Sun May  3 10:11:10 2026 ]]
return {
	encode = function(n1: number) --[[ encode ]] -- line: 3
		local v2 = math.floor((math.log10(n1)))
		local v3 = math.floor(n1 / 10 ^ (v2 - 2))

		if n1 < 1000 then
			return (math.floor(n1))
		end

		return (tonumber(v2 .. math.floor(v3)))
	end,
	decode = function(n2: number) --[[ decode ]] -- line: 14
		if n2 < 1000 then
			return n2
		end

		local v5 = n2 // 1000

		return n2 % 1000 * 10 ^ (v5 - 2)
	end
}
