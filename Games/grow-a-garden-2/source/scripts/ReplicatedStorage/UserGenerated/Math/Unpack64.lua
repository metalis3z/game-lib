--credit to quartz games studio
return function(p1) --[[ Unpack64 | Line: 20 ]]
	if p1 < 0 then
		local v1 = -1 - p1

		return bit32.bnot(v1 // 4294967296), bit32.bnot(v1)
	end

	return bit32.bor(p1 // 4294967296, 0), bit32.bor(p1, 0)
end