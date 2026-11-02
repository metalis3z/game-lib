--credit to quartz games studio
local function mult(p1, p2) --[[ mult | Line: 37 ]]
	local v1 = bit32.band(p1, 65535) * p2

	return v1 + bit32.lshift(bit32.band(bit32.rshift(p1, 16) * p2, 65535), 16)
end

return function(p1, p2) --[[ xxhash32 | Line: 50 ]]
	local v1 = if p2 == nil then 0 else bit32.bor(p2, 0)
	local v2 = #p1
	local sum = 1
	local sum2 = 1
	local v3

	if v2 >= 16 then
		v4 = v1 - 2654435761
		v5 = v1 + 2654435761 + 2246822519
		v6 = v1 + 2246822519
		v7 = v1

		for i = 0, v2 - 16, 16 do
			local v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 = string.byte(p1, sum2, sum2 + 15)
			local v27 = bit32.bor(bit32.lshift(v11, 24), bit32.lshift(v10, 16), bit32.lshift(v9, 8), v8)
			local v28 = bit32.band(v27, 65535) * 2246822519
			local v32 = bit32.lrotate(v5 + (v28 + bit32.lshift(bit32.band(bit32.rshift(v27, 16) * 2246822519, 65535), 16)), 13)
			local v33 = bit32.band(v32, 65535) * 2654435761

			v5 = v33 + bit32.lshift(bit32.band(bit32.rshift(v32, 16) * 2654435761, 65535), 16)

			local v39 = bit32.bor(bit32.lshift(v15, 24), bit32.lshift(v14, 16), bit32.lshift(v13, 8), v12)
			local v40 = bit32.band(v39, 65535) * 2246822519
			local v44 = bit32.lrotate(v6 + (v40 + bit32.lshift(bit32.band(bit32.rshift(v39, 16) * 2246822519, 65535), 16)), 13)
			local v45 = bit32.band(v44, 65535) * 2654435761

			v6 = v45 + bit32.lshift(bit32.band(bit32.rshift(v44, 16) * 2654435761, 65535), 16)

			local v51 = bit32.bor(bit32.lshift(v19, 24), bit32.lshift(v18, 16), bit32.lshift(v17, 8), v16)
			local v52 = bit32.band(v51, 65535) * 2246822519
			local v56 = bit32.lrotate(v7 + (v52 + bit32.lshift(bit32.band(bit32.rshift(v51, 16) * 2246822519, 65535), 16)), 13)
			local v57 = bit32.band(v56, 65535) * 2654435761

			v7 = v57 + bit32.lshift(bit32.band(bit32.rshift(v56, 16) * 2654435761, 65535), 16)

			local v63 = bit32.bor(bit32.lshift(v23, 24), bit32.lshift(v22, 16), bit32.lshift(v21, 8), v20)
			local v64 = bit32.band(v63, 65535) * 2246822519
			local v68 = bit32.lrotate(v4 + (v64 + bit32.lshift(bit32.band(bit32.rshift(v63, 16) * 2246822519, 65535), 16)), 13)
			local v69 = bit32.band(v68, 65535) * 2654435761

			v4 = v69 + bit32.lshift(bit32.band(bit32.rshift(v68, 16) * 2654435761, 65535), 16)
			sum = sum + 4
			sum2 = sum2 + 16
		end

		v3 = bit32.lrotate(v5, 1) + bit32.lrotate(v6, 7) + bit32.lrotate(v7, 12) + bit32.lrotate(v4, 18)
	else
		v3 = bit32.bor(v1 + 374761393, 0)
	end

	local v74 = bit32.bor(v3 + v2, 0)

	for j = sum, v2 // 4 do
		local v75, v76, v77, v78 = string.byte(p1, sum2, sum2 + 3)
		local v82 = bit32.bor(bit32.lshift(v78, 24), bit32.lshift(v77, 16), bit32.lshift(v76, 8), v75)
		local v83 = bit32.band(v82, 65535) * 3266489917
		local v87 = bit32.lrotate(v74 + (v83 + bit32.lshift(bit32.band(bit32.rshift(v82, 16) * 3266489917, 65535), 16)), 17)
		local v88 = bit32.band(v87, 65535) * 668265263

		v74 = v88 + bit32.lshift(bit32.band(bit32.rshift(v87, 16) * 668265263, 65535), 16)
		sum2 = sum2 + 4
		sum = sum + 1
	end

	for k = -(v2 % 4), -1 do
		local v91 = string.byte(p1, k)
		local v92 = bit32.band(v91, 65535) * 374761393
		local v96 = bit32.lrotate(v74 + (v92 + bit32.lshift(bit32.band(bit32.rshift(v91, 16) * 374761393, 65535), 16)), 11)
		local v97 = bit32.band(v96, 65535) * 2654435761

		v74 = v97 + bit32.lshift(bit32.band(bit32.rshift(v96, 16) * 2654435761, 65535), 16)
	end

	local v101 = bit32.bxor(v74, (bit32.rshift(v74, 15)))
	local v102 = bit32.band(v101, 65535) * 2246822519
	local v105 = v102 + bit32.lshift(bit32.band(bit32.rshift(v101, 16) * 2246822519, 65535), 16)
	local v107 = bit32.bxor(v105, (bit32.rshift(v105, 13)))
	local v108 = bit32.band(v107, 65535) * 3266489917
	local v111 = v108 + bit32.lshift(bit32.band(bit32.rshift(v107, 16) * 3266489917, 65535), 16)

	return bit32.bxor(v111, (bit32.rshift(v111, 16)))
end