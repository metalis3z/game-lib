--credit to prince games studio
local bxor = bit32.bxor
local rrotate = bit32.rrotate
local copy = buffer.copy
local create = buffer.create
local fromstring = buffer.fromstring
local len = buffer.len
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local readu32 = buffer.readu32
local v1 = buffer.tostring
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu16 = buffer.writeu16
local writeu32 = buffer.writeu32
local floor = math.floor
local sub = string.sub
local v2 = create(131072)
local v3 = create(65536)
local v4 = create(65536)
local v5 = create(65536)
local v6 = create(65536)
local v7 = create(65536)

local function keySchedule(p1, p2, p3, p4) --[[ keySchedule | Line: 158 | Upvalues: copy (copy), writestring (copy), readu32 (copy), rrotate (copy), v2 (copy), floor (copy), readu16 (copy), bxor (copy), writeu32 (copy) ]]
	if p4 then
		copy(p3, 0, p1, 0, p2)
	else
		writestring(p3, 0, p1, p2)
	end

	local v1 = rrotate(readu32(p3, p2 - 4), 8)
	local v22 = 0.5

	if p2 == 32 then
		for i = 32, 192, 32 do
			v22 = v22 * 2 % 229

			local v3 = bxor(readu32(p3, i - 32), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), v22)

			writeu32(p3, i, v3)

			local v4 = bxor(readu32(p3, i - 28), v3)

			writeu32(p3, i + 4, v4)

			local v5 = bxor(readu32(p3, i - 24), v4)

			writeu32(p3, i + 8, v5)

			local v6 = bxor(readu32(p3, i - 20), v5)

			writeu32(p3, i + 12, v6)

			local v7 = bxor(readu32(p3, i - 16), readu16(v2, floor(v6 / 65536) * 2) * 65536 + readu16(v2, v6 % 65536 * 2))

			writeu32(p3, i + 16, v7)

			local v8 = bxor(readu32(p3, i - 12), v7)

			writeu32(p3, i + 20, v8)

			local v9 = bxor(readu32(p3, i - 8), v8)

			writeu32(p3, i + 24, v9)

			local v10 = bxor(readu32(p3, i - 4), v9)

			writeu32(p3, i + 28, v10)
			v1 = rrotate(v10, 8)
		end

		local v12 = bxor(readu32(p3, 192), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), 64)

		writeu32(p3, 224, v12)

		local v13 = bxor(readu32(p3, 196), v12)

		writeu32(p3, 228, v13)

		local v14 = bxor(readu32(p3, 200), v13)

		writeu32(p3, 232, v14)
		writeu32(p3, 236, (bxor(readu32(p3, 204), v14)))
	elseif p2 == 24 then
		for j = 24, 168, 24 do
			v22 = v22 * 2 % 229

			local v15 = bxor(readu32(p3, j - 24), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), v22)

			writeu32(p3, j, v15)

			local v16 = bxor(readu32(p3, j - 20), v15)

			writeu32(p3, j + 4, v16)

			local v17 = bxor(readu32(p3, j - 16), v16)

			writeu32(p3, j + 8, v17)

			local v18 = bxor(readu32(p3, j - 12), v17)

			writeu32(p3, j + 12, v18)

			local v19 = bxor(readu32(p3, j - 8), v18)

			writeu32(p3, j + 16, v19)

			local v20 = bxor(readu32(p3, j - 4), v19)

			writeu32(p3, j + 20, v20)
			v1 = rrotate(v20, 8)
		end

		local v222 = bxor(readu32(p3, 168), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), 128)

		writeu32(p3, 192, v222)

		local v23 = bxor(readu32(p3, 172), v222)

		writeu32(p3, 196, v23)

		local v24 = bxor(readu32(p3, 176), v23)

		writeu32(p3, 200, v24)
		writeu32(p3, 204, (bxor(readu32(p3, 180), v24)))
	else
		for k = 16, 144, 16 do
			v22 = v22 * 2 % 229

			local v25 = bxor(readu32(p3, k - 16), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), v22)

			writeu32(p3, k, v25)

			local v26 = bxor(readu32(p3, k - 12), v25)

			writeu32(p3, k + 4, v26)

			local v27 = bxor(readu32(p3, k - 8), v26)

			writeu32(p3, k + 8, v27)

			local v28 = bxor(readu32(p3, k - 4), v27)

			writeu32(p3, k + 12, v28)
			v1 = rrotate(v28, 8)
		end

		local v30 = bxor(readu32(p3, 144), readu16(v2, floor(v1 / 65536) * 2) * 65536 + readu16(v2, v1 % 65536 * 2), 54)

		writeu32(p3, 160, v30)

		local v31 = bxor(readu32(p3, 148), v30)

		writeu32(p3, 164, v31)

		local v32 = bxor(readu32(p3, 152), v31)

		writeu32(p3, 168, v32)
		writeu32(p3, 172, (bxor(readu32(p3, 156), v32)))
	end

	return p3
end

local function encryptBlock(p1, p2, p3, p4, p5, p6) --[[ encryptBlock | Line: 259 | Upvalues: readu8 (copy), bxor (copy), v3 (copy), v4 (copy), v2 (copy), readu16 (copy), readu32 (copy), writeu32 (copy) ]]
	local v1 = bxor(readu8(p3, p4), (readu8(p1, 0)))
	local v22 = bxor(readu8(p3, p4 + 1), (readu8(p1, 1)))
	local v32 = bxor(readu8(p3, p4 + 2), (readu8(p1, 2)))
	local v42 = bxor(readu8(p3, p4 + 3), (readu8(p1, 3)))
	local v5 = bxor(readu8(p3, p4 + 4), (readu8(p1, 4)))
	local v6 = bxor(readu8(p3, p4 + 5), (readu8(p1, 5)))
	local v7 = bxor(readu8(p3, p4 + 6), (readu8(p1, 6)))
	local v8 = bxor(readu8(p3, p4 + 7), (readu8(p1, 7)))
	local v9 = bxor(readu8(p3, p4 + 8), (readu8(p1, 8)))
	local v10 = bxor(readu8(p3, p4 + 9), (readu8(p1, 9)))
	local v11 = bxor(readu8(p3, p4 + 10), (readu8(p1, 10)))
	local v12 = bxor(readu8(p3, p4 + 11), (readu8(p1, 11)))
	local v13 = bxor(readu8(p3, p4 + 12), (readu8(p1, 12)))
	local v14 = bxor(readu8(p3, p4 + 13), (readu8(p1, 13)))
	local v15 = bxor(readu8(p3, p4 + 14), (readu8(p1, 14)))
	local v16 = bxor(readu8(p3, p4 + 15), (readu8(p1, 15)))
	local v17 = v32 * 256 + v8
	local v18 = v14 * 256 + v32
	local v19 = v8 * 256 + v9
	local v20 = v16 * 256 + v1
	local v21 = v5 * 256 + v10
	local v222 = v15 * 256 + v42
	local v23 = v10 * 256 + v15
	local v24 = v42 * 256 + v5
	local v25 = v1 * 256 + v6
	local v26 = v13 * 256 + v22
	local v27 = v7 * 256 + v12
	local v28 = v22 * 256 + v7
	local v29 = v12 * 256 + v13
	local v30 = v6 * 256 + v11
	local v31 = v11 * 256 + v16
	local v322 = v9 * 256 + v14

	for i = 16, p2, 16 do
		local v33 = bxor(readu8(v3, v25), readu8(v4, v31), (readu8(p1, i)))
		local v34 = bxor(readu8(v3, v30), readu8(v4, v20), (readu8(p1, i + 1)))
		local v35 = bxor(readu8(v3, v31), readu8(v4, v25), (readu8(p1, i + 2)))
		local v36 = bxor(readu8(v3, v20), readu8(v4, v30), (readu8(p1, i + 3)))
		local v37 = bxor(readu8(v3, v21), readu8(v4, v222), (readu8(p1, i + 4)))
		local v38 = bxor(readu8(v3, v23), readu8(v4, v24), (readu8(p1, i + 5)))
		local v39 = bxor(readu8(v3, v222), readu8(v4, v21), (readu8(p1, i + 6)))
		local v40 = bxor(readu8(v3, v24), readu8(v4, v23), (readu8(p1, i + 7)))
		local v41 = bxor(readu8(v3, v322), readu8(v4, v17), (readu8(p1, i + 8)))
		local v422 = bxor(readu8(v3, v18), readu8(v4, v19), (readu8(p1, i + 9)))
		local v43 = bxor(readu8(v3, v17), readu8(v4, v322), (readu8(p1, i + 10)))
		local v44 = bxor(readu8(v3, v19), readu8(v4, v18), (readu8(p1, i + 11)))
		local v45 = bxor(readu8(v3, v26), readu8(v4, v27), (readu8(p1, i + 12)))
		local v46 = bxor(readu8(v3, v28), readu8(v4, v29), (readu8(p1, i + 13)))
		local v47 = bxor(readu8(v3, v27), readu8(v4, v26), (readu8(p1, i + 14)))
		local v48 = bxor(readu8(v3, v29), readu8(v4, v28), (readu8(p1, i + 15)))

		v17 = v35 * 256 + v40
		v18 = v46 * 256 + v35
		v19 = v40 * 256 + v41
		v20 = v48 * 256 + v33
		v21 = v37 * 256 + v422
		v222 = v47 * 256 + v36
		v23 = v422 * 256 + v47
		v24 = v36 * 256 + v37
		v25 = v33 * 256 + v38
		v26 = v45 * 256 + v34
		v27 = v39 * 256 + v44
		v28 = v34 * 256 + v39
		v29 = v44 * 256 + v45
		v30 = v38 * 256 + v43
		v31 = v43 * 256 + v48
		v322 = v41 * 256 + v46
	end

	writeu32(p5, p6, (bxor(readu16(v2, bxor(readu8(v3, v29), readu8(v4, v28), (readu8(p1, p2 + 31))) * 512 + bxor(readu8(v3, v17), readu8(v4, v322), (readu8(p1, p2 + 26))) * 2) * 65536 + readu16(v2, bxor(readu8(v3, v23), readu8(v4, v24), (readu8(p1, p2 + 21))) * 512 + bxor(readu8(v3, v25), readu8(v4, v31), (readu8(p1, p2 + 16))) * 2), (readu32(p1, p2 + 32)))))
	writeu32(p5, p6 + 4, (bxor(readu16(v2, bxor(readu8(v3, v20), readu8(v4, v30), (readu8(p1, p2 + 19))) * 512 + bxor(readu8(v3, v27), readu8(v4, v26), (readu8(p1, p2 + 30))) * 2) * 65536 + readu16(v2, bxor(readu8(v3, v18), readu8(v4, v19), (readu8(p1, p2 + 25))) * 512 + bxor(readu8(v3, v21), readu8(v4, v222), (readu8(p1, p2 + 20))) * 2), (readu32(p1, p2 + 36)))))
	writeu32(p5, p6 + 8, (bxor(readu16(v2, bxor(readu8(v3, v24), readu8(v4, v23), (readu8(p1, p2 + 23))) * 512 + bxor(readu8(v3, v31), readu8(v4, v25), (readu8(p1, p2 + 18))) * 2) * 65536 + readu16(v2, bxor(readu8(v3, v28), readu8(v4, v29), (readu8(p1, p2 + 29))) * 512 + bxor(readu8(v3, v322), readu8(v4, v17), (readu8(p1, p2 + 24))) * 2), (readu32(p1, p2 + 40)))))
	writeu32(p5, p6 + 12, (bxor(readu16(v2, bxor(readu8(v3, v19), readu8(v4, v18), (readu8(p1, p2 + 27))) * 512 + bxor(readu8(v3, v222), readu8(v4, v21), (readu8(p1, p2 + 22))) * 2) * 65536 + readu16(v2, bxor(readu8(v3, v30), readu8(v4, v20), (readu8(p1, p2 + 17))) * 512 + bxor(readu8(v3, v26), readu8(v4, v27), (readu8(p1, p2 + 28))) * 2), (readu32(p1, p2 + 44)))))
end

local function decryptBlock(p1, p2, p3, p4, p5, p6) --[[ decryptBlock | Line: 326 | Upvalues: v5 (copy), readu8 (copy), bxor (copy), v6 (copy), v7 (copy), writeu32 (copy) ]]
	local v1 = bxor(readu8(v5, readu8(p3, p4) * 256 + readu8(p1, p2 + 32)), (readu8(p1, p2 + 16)))
	local v2 = bxor(readu8(v5, readu8(p3, p4 + 13) * 256 + readu8(p1, p2 + 45)), (readu8(p1, p2 + 17)))
	local v3 = bxor(readu8(v5, readu8(p3, p4 + 10) * 256 + readu8(p1, p2 + 42)), (readu8(p1, p2 + 18)))
	local v4 = bxor(readu8(v5, readu8(p3, p4 + 7) * 256 + readu8(p1, p2 + 39)), (readu8(p1, p2 + 19)))
	local v52 = bxor(readu8(v5, readu8(p3, p4 + 4) * 256 + readu8(p1, p2 + 36)), (readu8(p1, p2 + 20)))
	local v62 = bxor(readu8(v5, readu8(p3, p4 + 1) * 256 + readu8(p1, p2 + 33)), (readu8(p1, p2 + 21)))
	local v72 = bxor(readu8(v5, readu8(p3, p4 + 14) * 256 + readu8(p1, p2 + 46)), (readu8(p1, p2 + 22)))
	local v8 = bxor(readu8(v5, readu8(p3, p4 + 11) * 256 + readu8(p1, p2 + 43)), (readu8(p1, p2 + 23)))
	local v9 = bxor(readu8(v5, readu8(p3, p4 + 8) * 256 + readu8(p1, p2 + 40)), (readu8(p1, p2 + 24)))
	local v10 = bxor(readu8(v5, readu8(p3, p4 + 5) * 256 + readu8(p1, p2 + 37)), (readu8(p1, p2 + 25)))
	local v11 = bxor(readu8(v5, readu8(p3, p4 + 2) * 256 + readu8(p1, p2 + 34)), (readu8(p1, p2 + 26)))
	local v12 = bxor(readu8(v5, readu8(p3, p4 + 15) * 256 + readu8(p1, p2 + 47)), (readu8(p1, p2 + 27)))
	local v13 = bxor(readu8(v5, readu8(p3, p4 + 12) * 256 + readu8(p1, p2 + 44)), (readu8(p1, p2 + 28)))
	local v14 = bxor(readu8(v5, readu8(p3, p4 + 9) * 256 + readu8(p1, p2 + 41)), (readu8(p1, p2 + 29)))
	local v15 = bxor(readu8(v5, readu8(p3, p4 + 6) * 256 + readu8(p1, p2 + 38)), (readu8(p1, p2 + 30)))
	local v16 = bxor(readu8(v5, readu8(p3, p4 + 3) * 256 + readu8(p1, p2 + 35)), (readu8(p1, p2 + 31)))
	local v17 = v62 * 256 + v72
	local v18 = v72 * 256 + v8
	local v19 = v15 * 256 + v16
	local v20 = v13 * 256 + v14
	local v21 = v14 * 256 + v15
	local v22 = v16 * 256 + v13
	local v23 = v11 * 256 + v12
	local v24 = v9 * 256 + v10
	local v25 = v8 * 256 + v52
	local v26 = v12 * 256 + v9
	local v27 = v10 * 256 + v11
	local v28 = v1 * 256 + v2
	local v29 = v3 * 256 + v4
	local v30 = v52 * 256 + v62
	local v31 = v2 * 256 + v3
	local v32 = v4 * 256 + v1

	for i = p2, 16, -16 do
		local v33 = bxor(readu8(v5, readu8(v6, v28) * 256 + readu8(v7, v29)), (readu8(p1, i)))
		local v34 = bxor(readu8(v5, readu8(v6, v21) * 256 + readu8(v7, v22)), (readu8(p1, i + 1)))
		local v35 = bxor(readu8(v5, readu8(v6, v23) * 256 + readu8(v7, v24)), (readu8(p1, i + 2)))
		local v36 = bxor(readu8(v5, readu8(v6, v25) * 256 + readu8(v7, v17)), (readu8(p1, i + 3)))
		local v37 = bxor(readu8(v5, readu8(v6, v30) * 256 + readu8(v7, v18)), (readu8(p1, i + 4)))
		local v38 = bxor(readu8(v5, readu8(v6, v31) * 256 + readu8(v7, v32)), (readu8(p1, i + 5)))
		local v39 = bxor(readu8(v5, readu8(v6, v19) * 256 + readu8(v7, v20)), (readu8(p1, i + 6)))
		local v40 = bxor(readu8(v5, readu8(v6, v26) * 256 + readu8(v7, v27)), (readu8(p1, i + 7)))
		local v41 = bxor(readu8(v5, readu8(v6, v24) * 256 + readu8(v7, v23)), (readu8(p1, i + 8)))
		local v42 = bxor(readu8(v5, readu8(v6, v17) * 256 + readu8(v7, v25)), (readu8(p1, i + 9)))
		local v43 = bxor(readu8(v5, readu8(v6, v29) * 256 + readu8(v7, v28)), (readu8(p1, i + 10)))
		local v44 = bxor(readu8(v5, readu8(v6, v22) * 256 + readu8(v7, v21)), (readu8(p1, i + 11)))
		local v45 = bxor(readu8(v5, readu8(v6, v20) * 256 + readu8(v7, v19)), (readu8(p1, i + 12)))
		local v46 = bxor(readu8(v5, readu8(v6, v27) * 256 + readu8(v7, v26)), (readu8(p1, i + 13)))
		local v47 = bxor(readu8(v5, readu8(v6, v18) * 256 + readu8(v7, v30)), (readu8(p1, i + 14)))
		local v48 = bxor(readu8(v5, readu8(v6, v32) * 256 + readu8(v7, v31)), (readu8(p1, i + 15)))

		v17 = v38 * 256 + v39
		v18 = v39 * 256 + v40
		v19 = v47 * 256 + v48
		v20 = v45 * 256 + v46
		v21 = v46 * 256 + v47
		v22 = v48 * 256 + v45
		v23 = v43 * 256 + v44
		v24 = v41 * 256 + v42
		v25 = v40 * 256 + v37
		v26 = v44 * 256 + v41
		v27 = v42 * 256 + v43
		v28 = v33 * 256 + v34
		v29 = v35 * 256 + v36
		v30 = v37 * 256 + v38
		v31 = v34 * 256 + v35
		v32 = v36 * 256 + v33
	end

	writeu32(p5, p6, bxor(readu8(v5, readu8(v6, v25) * 256 + readu8(v7, v17)), (readu8(p1, 3))) * 16777216 + bxor(readu8(v5, readu8(v6, v23) * 256 + readu8(v7, v24)), (readu8(p1, 2))) * 65536 + bxor(readu8(v5, readu8(v6, v21) * 256 + readu8(v7, v22)), (readu8(p1, 1))) * 256 + bxor(readu8(v5, readu8(v6, v28) * 256 + readu8(v7, v29)), (readu8(p1, 0))))
	writeu32(p5, p6 + 4, bxor(readu8(v5, readu8(v6, v26) * 256 + readu8(v7, v27)), (readu8(p1, 7))) * 16777216 + bxor(readu8(v5, readu8(v6, v19) * 256 + readu8(v7, v20)), (readu8(p1, 6))) * 65536 + bxor(readu8(v5, readu8(v6, v31) * 256 + readu8(v7, v32)), (readu8(p1, 5))) * 256 + bxor(readu8(v5, readu8(v6, v30) * 256 + readu8(v7, v18)), (readu8(p1, 4))))
	writeu32(p5, p6 + 8, bxor(readu8(v5, readu8(v6, v22) * 256 + readu8(v7, v21)), (readu8(p1, 11))) * 16777216 + bxor(readu8(v5, readu8(v6, v29) * 256 + readu8(v7, v28)), (readu8(p1, 10))) * 65536 + bxor(readu8(v5, readu8(v6, v17) * 256 + readu8(v7, v25)), (readu8(p1, 9))) * 256 + bxor(readu8(v5, readu8(v6, v24) * 256 + readu8(v7, v23)), (readu8(p1, 8))))
	writeu32(p5, p6 + 12, bxor(readu8(v5, readu8(v6, v32) * 256 + readu8(v7, v31)), (readu8(p1, 15))) * 16777216 + bxor(readu8(v5, readu8(v6, v18) * 256 + readu8(v7, v30)), (readu8(p1, 14))) * 65536 + bxor(readu8(v5, readu8(v6, v27) * 256 + readu8(v7, v26)), (readu8(p1, 13))) * 256 + bxor(readu8(v5, readu8(v6, v20) * 256 + readu8(v7, v19)), (readu8(p1, 12))))
end

local v8 = create(256)
local v9 = create(256)
local v10 = create(256)
local v11 = create(256)
local v12 = create(256)

local function gfmul(p1, p2) --[[ gfmul | Line: 409 | Upvalues: bxor (copy), floor (copy) ]]
	local v1 = 0

	for i = 0, 7 do
		if p2 % 2 == 1 then
			v1 = bxor(v1, p1)
		end

		if p1 >= 128 then
			p1 = bxor(p1 * 2 % 256, 27)
		else
			p1 = p1 * 2 % 256
		end

		p2 = floor(p2 / 2)
	end

	return v1
end

writeu8(v8, 0, 99)

local v13 = 1
local v14 = 1

for i = 1, 255 do
	v13 = bxor(v13, v13 * 2, if v13 < 128 then 0 else 27) % 256

	local v17 = bxor(v14, v14 * 2)
	local v18 = bxor(v17, v17 * 4)

	v14 = bxor(v18, v18 * 16) % 256

	if v14 >= 128 then
		v14 = bxor(v14, 9)
	end

	local v20 = bxor(v14, v14 % 128 * 2 + v14 / 128, v14 % 64 * 4 + v14 / 64, v14 % 32 * 8 + v14 / 32, v14 % 16 * 16 + v14 / 16, 99)

	writeu8(v8, v13, v20)
	writeu8(v9, v20, v13)
	writeu8(v10, v13, (gfmul(3, v13)))
	writeu8(v11, v13, (gfmul(9, v13)))
	writeu8(v12, v13, (gfmul(11, v13)))
end

local count = 0

for j = 0, 255 do
	local v21 = readu8(v8, j)
	local v22 = gfmul(2, v21)
	local v23 = gfmul(13, j)
	local v24 = gfmul(14, j)
	local v25, v26, v27 = v22, v21 * 256, v23

	for k = 0, 255 do
		local v28 = readu8(v8, k)

		writeu16(v2, count * 2, v26 + v28)
		writeu8(v5, count, (readu8(v9, (bxor(j, k)))))
		writeu8(v3, count, (bxor(v25, (readu8(v10, v28)))))
		writeu8(v4, count, (bxor(v21, v28)))
		writeu8(v6, count, (bxor(v24, (readu8(v12, k)))))
		writeu8(v7, count, (bxor(v27, (readu8(v11, k)))))
		count = count + 1
	end
end

local function newidx(p1, p2) --[[ newidx | Line: 481 ]]
	return error((("%* cannot be assigned to"):format(p2)))
end

local function tostr() --[[ tostr | Line: 484 ]]
	return "AesCipher"
end

local Modes = require(script.Modes)
local Pads = require(script.Pads)

local function expandKey(p1, p2) --[[ expandKey | Line: 490 | Upvalues: len (copy), keySchedule (copy), create (copy) ]]
	local v1 = if typeof(p1) == "buffer" then true else false
	local v2 = if v1 then len(p1) else #p1

	return keySchedule(p1, v2, if p2 then p2 else create(if v2 == 32 then 240 elseif v2 == 24 then 208 elseif v2 == 16 then 176 else error("Key must be either 16, 24 or 32 bytes long")), v1)
end

local function fromKey(p1, p2, p3) --[[ fromKey | Line: 496 | Upvalues: len (copy), v1 (copy), sub (copy), Modes (copy), Pads (copy), encryptBlock (copy), decryptBlock (copy), fromstring (copy), create (copy), newidx (copy), tostr (copy) ]]
	local v12 = len(p1)
	local v2 = nil
	local v3 = nil
	local v4 = v1(p1)

	if v12 == 240 then
		v3 = sub(v4, 1, 32)
		v2 = 192
	elseif v12 == 208 then
		v3 = sub(v4, 1, 24)
		v2 = 160
	elseif v12 == 176 then
		v3 = sub(v4, 1, 16)
		v2 = 128
	else
		error("Round keys must be either 240, 208 or 128 bytes long")
	end

	local v5 = p1
	local v6 = p2 or Modes.ECB
	local FwdMode = v6.FwdMode
	local InvMode = v6.InvMode
	local v7 = v6.SegmentSize or 16
	local v8 = p3 or Pads.Pkcs7
	local Pad = v8.Pad
	local Unpad = v8.Unpad
	local v9 = newproxy(true)
	local v10 = getmetatable(v9)

	local function encp(p1, p2, p3, p4) --[[ encp | Line: 523 | Upvalues: encryptBlock (ref), v5 (ref), v2 (ref) ]]
		encryptBlock(v5, v2, p1, p2, p3, p4)
	end

	local function decp(p1, p2, p3, p4) --[[ decp | Line: 526 | Upvalues: decryptBlock (ref), v5 (ref), v2 (ref) ]]
		decryptBlock(v5, v2, p1, p2, p3, p4)
	end

	local function enc(p1, p2, p3, ...) --[[ enc | Line: 529 | Upvalues: fromstring (ref), v9 (copy), v2 (ref), Pad (copy), v7 (copy), FwdMode (ref), encp (copy), decp (copy), v8 (ref), v6 (ref), create (ref) ]]
		local v1 = if typeof(p2) == "buffer" then p2 elseif typeof(p2) == "string" then fromstring(p2) else error((("Unable to cast %* to buffer"):format((typeof(p2)))))
		local v22 = if typeof(p3) == "buffer" then p3 else false

		if p1 ~= v9 then
			return p1:Encrypt(v1, v22, ...)
		end

		if not v2 then
			error("AesCipher object\'s already destroyed")
		end

		local v3 = Pad(v1, v22, v7)

		FwdMode(encp, decp, if v8.Overwrite == false then v1 else v3, v3, v6, ...)

		return v3
	end

	local function encb(p1, p2, p3, p4, p5) --[[ encb | Line: 544 | Upvalues: v9 (copy), v2 (ref), encryptBlock (ref), v5 (ref) ]]
		if p1 ~= v9 then
			p1:EncryptBlock(p2, p3, p4, p5)

			return
		end

		if v2 then
			encryptBlock(v5, v2, p2, p3, p4 or p2, p5 or p3)
		else
			error("AesCipher object\'s already destroyed")
		end
	end

	local function dec(p1, p2, p3, ...) --[[ dec | Line: 553 | Upvalues: fromstring (ref), v9 (copy), v2 (ref), v8 (ref), create (ref), len (ref), InvMode (ref), encp (copy), decp (copy), v6 (ref), Unpad (copy), v7 (copy) ]]
		local v1 = if typeof(p2) == "buffer" then p2 elseif typeof(p2) == "string" then fromstring(p2) else error((("Unable to cast %* to buffer"):format((typeof(p2)))))
		local v22 = if typeof(p3) == "buffer" then p3 else false

		if p1 ~= v9 then
			return p1:Decrypt(v1, v22, ...)
		end

		if not v2 then
			error("AesCipher object\'s already destroyed")
		end

		local Overwrite = v8.Overwrite
		local v3, v4

		if Overwrite == nil then
			v3 = create(len(v1))
			v4 = v22
		elseif Overwrite then
			v3 = v1
			v4 = v22
		elseif v22 then
			v3 = v22
			v4 = v22
		else
			v3 = create(len(v1))
			v4 = v22
		end

		InvMode(encp, decp, v1, v3, v6, ...)

		return Unpad(v3, v4, v7)
	end

	local function decb(p1, p2, p3, p4, p5) --[[ decb | Line: 569 | Upvalues: v9 (copy), v2 (ref), decryptBlock (ref), v5 (ref) ]]
		if p1 ~= v9 then
			p1:DecryptBlock(p2, p3, p4, p5)

			return
		end

		if v2 then
			decryptBlock(v5, v2, p2, p3, p4 or p2, p5 or p3)
		else
			error("AesCipher object\'s already destroyed")
		end
	end

	local function destroy(p1) --[[ destroy | Line: 578 | Upvalues: v9 (copy), v2 (ref), v4 (ref), v5 (ref), FwdMode (ref), InvMode (ref), v6 (ref), v8 (ref), v3 (ref), v12 (ref) ]]
		if p1 ~= v9 then
			p1:Destroy()

			return
		end

		if v2 then
			v4 = nil
			v5 = nil
			v2 = nil
			FwdMode = nil
			InvMode = nil
			v6 = nil
			v8 = nil
			v3 = nil
			v12 = nil
		else
			error("AesCipher object\'s already destroyed")
		end
	end

	function v10.__index(p1, p2) --[[ Line: 589 | Upvalues: enc (copy), dec (copy), encb (copy), decb (copy), destroy (copy), v2 (ref), v3 (ref), v4 (ref), v6 (ref), v8 (ref), v12 (ref) ]]
		if p2 == "Encrypt" then
			return enc
		end

		if p2 == "Decrypt" then
			return dec
		end

		if p2 == "EncryptBlock" then
			return encb
		end

		if p2 == "DecryptBlock" then
			return decb
		end

		if p2 == "Destroy" then
			return destroy
		end

		if not v2 then
			return error("AesCipher object\'s already destroyed")
		end

		if p2 == "Key" then
			return v3
		end

		if p2 == "RoundKeys" then
			return v4
		end

		if p2 == "Mode" then
			return v6
		end

		if p2 == "Padding" then
			return v8
		end

		if p2 == "Length" then
			return v12
		end

		return error((("%* is not a valid member of AesCipher"):format(p2)))
	end
	v10.__newindex = newidx
	v10.__tostring = tostr
	function v10.__len() --[[ Line: 597 | Upvalues: v12 (ref) ]]
		return v12 or error("AesCipher object\'s destroyed")
	end
	v10.__metatable = "AesCipher object: Metatable\'s locked"

	return v9
end

return table.freeze({
	new = function(p1, p2, p3) --[[ new | Line: 605 | Upvalues: fromKey (copy), expandKey (copy) ]]
		return fromKey(expandKey(p1), p2, p3)
	end,
	expandKey = expandKey,
	fromKey = fromKey,
	modes = Modes,
	pads = Pads
})