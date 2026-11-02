

local function slice(p1, n1: number?, n2: number?)
	local v5 = #p1
	local v6 = if not n1 or not (n1 < 0) then n1 or 1 else v5 + (n1 + 1)
	local v7 = if not n2 or not (n2 < 0) then n2 or v5 else v5 + n2

	if v6 == 1 and v7 == #p1 then
		return p1
	end

	local t1 = {}
	local n3 = 1

	for i = v6, v7 do
		t1[n3] = p1[i]
		n3 += 1
	end

	return t1
end

return slice
