-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Base64 = require(script.Base64)
local v1 = ipairs
local band = bit32.band
local bor = bit32.bor
local bxor = bit32.bxor
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local rrotate = bit32.rrotate
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local t8 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	28,
	25,
	26,
	27,
	0,
	0,
	10,
	9,
	11,
	12,
	0,
	15,
	16,
	17,
	18,
	0,
	20,
	22,
	23,
	21
}
local t9 = {}

local function sha256_feed_64(p1, p2, p3, p4) --[[ sha256_feed_64 | Line: 179 | Upvalues: t9 (copy), t2 (copy), rrotate (copy), lrotate (copy), rshift (copy), bxor (copy), band (copy) ]]
	local v1 = t9
	local v2 = t2
	local v3 = p1[1]
	local v4 = p1[2]
	local v5 = p1[3]
	local v6 = p1[4]
	local v7 = p1[5]
	local v8 = p1[6]
	local v9 = p1[7]
	local v10 = p1[8]

	for i = p3, p3 + p4 - 1, 64 do
		local sum = i

		for j = 1, 16 do
			sum = sum + 4

			local v11, v12, v13, v14 = string.byte(p2, sum - 3, sum)

			v1[j] = ((v11 * 256 + v12) * 256 + v13) * 256 + v14
		end

		for k = 17, 64 do
			local v15 = v1[k - 15]
			local v16 = v1[k - 2]

			v1[k] = bxor(rrotate(v15, 7), lrotate(v15, 14), (rshift(v15, 3))) + bxor(lrotate(v16, 15), lrotate(v16, 13), (rshift(v16, 10))) + v1[k - 7] + v1[k - 16]
		end

		local v17, v18, v19, v20, v21, v22, v23, v24 = v7, v8, v9, v10, v3, v6, v5, v4

		for n = 1, 64 do
			local v25 = bxor(rrotate(v17, 6), rrotate(v17, 11), (lrotate(v17, 7))) + band(v17, v18) + band(-1 - v17, v19) + v20 + v2[n] + v1[n]

			v17, v18, v19, v20, v21, v22, v23, v24 = v25 + v22, v17, v18, v19, v25 + band(v23, v24) + band(v21, (bxor(v23, v24))) + bxor(rrotate(v21, 2), rrotate(v21, 13), (lrotate(v21, 10))), v23, v24, v21
		end

		v6 = (v22 + v6) % 4294967296
		v7 = (v17 + v7) % 4294967296
		v8 = (v18 + v8) % 4294967296
		v9 = (v19 + v9) % 4294967296
		v10 = (v20 + v10) % 4294967296
		v3 = (v21 + v3) % 4294967296
		v4 = (v24 + v4) % 4294967296
		v5 = (v23 + v5) % 4294967296
	end

	p1[1] = v3
	p1[2] = v4
	p1[3] = v5
	p1[4] = v6
	p1[5] = v7
	p1[6] = v8
	p1[7] = v9
	p1[8] = v10
end

local function sha512_feed_128(p1, p2, p3, p4, p5) --[[ sha512_feed_128 | Line: 226 | Upvalues: t9 (copy), t (copy), t2 (copy), rshift (copy), lshift (copy), bxor (copy), band (copy) ]]
	local v1 = t9
	local v2 = t
	local v3 = t2
	local v4 = p1[1]
	local v5 = p1[2]
	local v6 = p1[3]
	local v7 = p1[4]
	local v8 = p1[5]
	local v9 = p1[6]
	local v10 = p1[7]
	local v11 = p1[8]
	local v12 = p2[1]
	local v13 = p2[2]
	local v14 = p2[3]
	local v15 = p2[4]
	local v16 = p2[5]
	local v17 = p2[6]
	local v18 = p2[7]
	local v19 = p2[8]

	for i = p4, p4 + p5 - 1, 128 do
		local sum = i

		for j = 1, 32 do
			sum = sum + 4

			local v20, v21, v22, v23 = string.byte(p3, sum - 3, sum)

			v1[j] = ((v20 * 256 + v21) * 256 + v22) * 256 + v23
		end

		for k = 34, 160, 2 do
			local v24 = v1[k - 30]
			local v25 = v1[k - 31]
			local v26 = v1[k - 4]
			local v27 = v1[k - 5]
			local v28 = bxor(rshift(v24, 1) + lshift(v25, 31), rshift(v24, 8) + lshift(v25, 24), rshift(v24, 7) + lshift(v25, 25)) % 4294967296 + bxor(rshift(v26, 19) + lshift(v27, 13), lshift(v26, 3) + rshift(v27, 29), rshift(v26, 6) + lshift(v27, 26)) % 4294967296 + v1[k - 14] + v1[k - 32]
			local v29 = v28 % 4294967296

			v1[k - 1] = bxor(rshift(v25, 1) + lshift(v24, 31), rshift(v25, 8) + lshift(v24, 24), (rshift(v25, 7))) + bxor(rshift(v27, 19) + lshift(v26, 13), lshift(v27, 3) + rshift(v26, 29), (rshift(v27, 6))) + v1[k - 15] + v1[k - 33] + (v28 - v29) / 4294967296
			v1[k] = v29
		end

		local v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45 = v16, v9, v19, v7, v12, v10, v11, v17, v18, v8, v15, v6, v14, v5, v13, v4

		for n = 1, 80 do
			local v46 = n * 2
			local v47 = bxor(rshift(v39, 14) + lshift(v30, 18), rshift(v39, 18) + lshift(v30, 14), lshift(v39, 23) + rshift(v30, 9)) % 4294967296 + (band(v39, v31) + band(-1 - v39, v35)) % 4294967296 + v36 + v2[n] + v1[v46]
			local v48 = v47 % 4294967296
			local v49 = bxor(rshift(v30, 14) + lshift(v39, 18), rshift(v30, 18) + lshift(v39, 14), lshift(v30, 23) + rshift(v39, 9)) + band(v30, v37) + band(-1 - v30, v38) + v32 + v3[n] + v1[v46 - 1] + (v47 - v48) / 4294967296
			local v50 = v48 + v33
			local v51 = v50 % 4294967296
			local v52 = v48 + (band(v41, v43) + band(v45, (bxor(v41, v43)))) % 4294967296 + bxor(rshift(v45, 28) + lshift(v34, 4), lshift(v45, 30) + rshift(v34, 2), lshift(v45, 25) + rshift(v34, 7)) % 4294967296
			local v53 = v52 % 4294967296

			v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45 = v49 + v40 + (v50 - v51) / 4294967296, v39, v38, v41, v49 + (band(v42, v44) + band(v34, (bxor(v42, v44)))) + bxor(rshift(v34, 28) + lshift(v45, 4), lshift(v34, 30) + rshift(v45, 2), lshift(v34, 25) + rshift(v45, 7)) + (v52 - v53) / 4294967296, v31, v35, v30, v37, v51, v42, v43, v44, v45, v34, v53
		end

		local v55 = v4 + v45

		v4 = v55 % 4294967296

		local v56 = v5 + v43

		v5 = v56 % 4294967296

		local v57 = v6 + v41

		v6 = v57 % 4294967296

		local v58 = v7 + v33

		v7 = v58 % 4294967296

		local v59 = v8 + v39

		v8 = v59 % 4294967296

		local v60 = v9 + v31

		v9 = v60 % 4294967296

		local v61 = v10 + v35

		v10 = v61 % 4294967296

		local v62 = v11 + v36

		v11 = v62 % 4294967296
		v13 = (v13 + v44 + (v56 - v5) / 4294967296) % 4294967296
		v14 = (v14 + v42 + (v57 - v6) / 4294967296) % 4294967296
		v15 = (v15 + v40 + (v58 - v7) / 4294967296) % 4294967296
		v16 = (v16 + v30 + (v59 - v8) / 4294967296) % 4294967296
		v17 = (v17 + v37 + (v60 - v9) / 4294967296) % 4294967296
		v18 = (v18 + v38 + (v61 - v10) / 4294967296) % 4294967296
		v19 = (v19 + v32 + (v62 - v11) / 4294967296) % 4294967296
		v12 = (v12 + v34 + (v55 - v4) / 4294967296) % 4294967296
	end

	p1[1] = v4
	p1[2] = v5
	p1[3] = v6
	p1[4] = v7
	p1[5] = v8
	p1[6] = v9
	p1[7] = v10
	p1[8] = v11
	p2[1] = v12
	p2[2] = v13
	p2[3] = v14
	p2[4] = v15
	p2[5] = v16
	p2[6] = v17
	p2[7] = v18
	p2[8] = v19
end

local function md5_feed_64(p1, p2, p3, p4) --[[ md5_feed_64 | Line: 350 | Upvalues: t9 (copy), t7 (copy), t8 (copy), band (copy), rrotate (copy), bxor (copy), bor (copy) ]]
	local v1 = t9
	local v2 = t7
	local v3 = t8
	local v4 = p1[1]
	local v5 = p1[2]
	local v6 = p1[3]
	local v7 = p1[4]

	for i = p3, p3 + p4 - 1, 64 do
		local sum = i

		for j = 1, 16 do
			sum = sum + 4

			local v8, v9, v10, v11 = string.byte(p2, sum - 3, sum)

			v1[j] = ((v11 * 256 + v10) * 256 + v9) * 256 + v8
		end

		local v12, v13, v14, v15, v16 = v4, 25, v5, v6, v7

		for k = 1, 16 do
			local v17 = rrotate(band(v14, v15) + band(-1 - v14, v16) + v12 + v2[k] + v1[k], v13) + v14

			v13 = v3[v13]
			v12, v14, v15, v16 = v16, v17, v14, v15
		end

		local v18 = 27

		for n = 17, 32 do
			local v19 = rrotate(band(v16, v14) + band(-1 - v16, v15) + v12 + v2[n] + v1[(n * 5 - 4) % 16 + 1], v18) + v14

			v18 = v3[v18]
			v12, v16, v14, v15 = v16, v15, v19, v14
		end

		local v20 = 28

		for m = 33, 48 do
			local v21 = rrotate(bxor(bxor(v14, v15), v16) + v12 + v2[m] + v1[(m * 3 + 2) % 16 + 1], v20) + v14

			v20 = v3[v20]
			v12, v14, v15, v16 = v16, v21, v14, v15
		end

		local v22 = 26

		for i2 = 49, 64 do
			local v23 = rrotate(bxor(v15, (bor(v14, -1 - v16))) + v12 + v2[i2] + v1[(i2 * 7 - 7) % 16 + 1], v22) + v14

			v22 = v3[v22]
			v15, v12, v16, v14 = v14, v16, v15, v23
		end

		v7 = (v16 + v7) % 4294967296
		v4 = (v12 + v4) % 4294967296
		v5 = (v14 + v5) % 4294967296
		v6 = (v15 + v6) % 4294967296
	end

	p1[1] = v4
	p1[2] = v5
	p1[3] = v6
	p1[4] = v7
end

local function sha1_feed_64(p1, p2, p3, p4) --[[ sha1_feed_64 | Line: 412 | Upvalues: t9 (copy), bxor (copy), lrotate (copy), band (copy), rrotate (copy) ]]
	local v1 = t9
	local v2 = p1[1]
	local v3 = p1[2]
	local v4 = p1[3]
	local v5 = p1[4]
	local v6 = p1[5]

	for i = p3, p3 + p4 - 1, 64 do
		local sum = i

		for j = 1, 16 do
			sum = sum + 4

			local v7, v8, v9, v10 = string.byte(p2, sum - 3, sum)

			v1[j] = ((v7 * 256 + v8) * 256 + v9) * 256 + v10
		end

		for k = 17, 80 do
			v1[k] = lrotate(bxor(v1[k - 3], v1[k - 8], v1[k - 14], v1[k - 16]), 1)
		end

		local v11, v12, v13, v14, v15 = v6, v2, v3, v4, v5

		for n = 1, 20 do
			local v16 = lrotate(v12, 5) + band(v13, v14) + band(-1 - v13, v15) + 1518500249 + v1[n] + v11

			v11, v12, v13, v14, v15 = v15, v16, v12, rrotate(v13, 2), v14
		end

		for m = 21, 40 do
			local v18 = lrotate(v12, 5) + bxor(v13, v14, v15) + 1859775393 + v1[m] + v11

			v11, v12, v13, v14, v15 = v15, v18, v12, rrotate(v13, 2), v14
		end

		for i2 = 41, 60 do
			local v20 = lrotate(v12, 5) + band(v15, v14) + band(v13, (bxor(v15, v14))) + 2400959708 + v1[i2] + v11

			v11, v12, v15, v14, v13 = v15, v20, v14, rrotate(v13, 2), v12
		end

		for i2 = 61, 80 do
			local v22 = lrotate(v12, 5) + bxor(v13, v14, v15) + 3395469782 + v1[i2] + v11

			v11, v12, v13, v14, v15 = v15, v22, v12, rrotate(v13, 2), v14
		end

		v5 = (v15 + v5) % 4294967296
		v6 = (v11 + v6) % 4294967296
		v2 = (v12 + v2) % 4294967296
		v3 = (v13 + v3) % 4294967296
		v4 = (v14 + v4) % 4294967296
	end

	p1[1] = v2
	p1[2] = v3
	p1[3] = v4
	p1[4] = v5
	p1[5] = v6
end

local function keccak_feed(p1, p2, p3, p4, p5, p6) --[[ keccak_feed | Line: 474 | Upvalues: t5 (copy), t6 (copy), bxor (copy), band (copy) ]]
	local v1 = t5
	local v2 = t6
	local v3 = p6 / 8

	for i = p4, p4 + p5 - 1, p6 do
		local sum = i

		for j = 1, v3 do
			local v4, v5, v6, v7 = string.byte(p3, sum + 1, sum + 4)

			p1[j] = bxor(p1[j], ((v7 * 256 + v6) * 256 + v5) * 256 + v4)
			sum = sum + 8

			local v8, v9, v10, v11 = string.byte(p3, sum - 3, sum)

			p2[j] = bxor(p2[j], ((v11 * 256 + v10) * 256 + v9) * 256 + v8)
		end

		local v12 = p1[1]
		local v13 = p2[1]
		local v14 = p1[2]
		local v15 = p2[2]
		local v16 = p1[3]
		local v17 = p2[3]
		local v18 = p1[4]
		local v19 = p2[4]
		local v20 = p1[5]
		local v21 = p2[5]
		local v22 = p1[6]
		local v23 = p2[6]
		local v24 = p1[7]
		local v25 = p2[7]
		local v26 = p1[8]
		local v27 = p2[8]
		local v28 = p1[9]
		local v29 = p2[9]
		local v30 = p1[10]
		local v31 = p2[10]
		local v32 = p1[11]
		local v33 = p2[11]
		local v34 = p1[12]
		local v35 = p2[12]
		local v36 = p1[13]
		local v37 = p2[13]
		local v38 = p1[14]
		local v39 = p2[14]
		local v40 = p1[15]
		local v41 = p2[15]
		local v42 = p1[16]
		local v43 = p2[16]
		local v44 = p1[17]
		local v45 = p2[17]
		local v46 = p1[18]
		local v47 = p2[18]
		local v48 = p1[19]
		local v49 = p2[19]
		local v50 = p1[20]
		local v51 = p2[20]
		local v52 = p1[21]
		local v53 = p2[21]
		local v54 = p1[22]
		local v55 = p2[22]
		local v56 = p1[23]
		local v57 = p2[23]
		local v58 = p1[24]
		local v59 = p2[24]
		local v60 = p1[25]
		local v61 = p2[25]

		for k = 1, 24 do
			local v62 = bxor(v12, v22, v32, v42, v52)
			local v63 = bxor(v13, v23, v33, v43, v53)
			local v64 = bxor(v14, v24, v34, v44, v54)
			local v65 = bxor(v15, v25, v35, v45, v55)
			local v66 = bxor(v16, v26, v36, v46, v56)
			local v67 = bxor(v17, v27, v37, v47, v57)
			local v68 = bxor(v18, v28, v38, v48, v58)
			local v69 = bxor(v19, v29, v39, v49, v59)
			local v70 = bxor(v20, v30, v40, v50, v60)
			local v71 = bxor(v21, v31, v41, v51, v61)
			local v72 = bxor(v62, v66 * 2 + (v67 % 4294967296 - v67 % 2147483648) / 2147483648)
			local v73 = bxor(v63, v67 * 2 + (v66 % 4294967296 - v66 % 2147483648) / 2147483648)
			local v74 = bxor(v72, v14)
			local v75 = bxor(v73, v15)
			local v76 = bxor(v72, v24)
			local v77 = bxor(v73, v25)
			local v78 = bxor(v72, v34)
			local v79 = bxor(v73, v35)
			local v80 = bxor(v72, v44)
			local v81 = bxor(v73, v45)
			local v82 = bxor(v72, v54)
			local v83 = bxor(v73, v55)
			local v84 = (v76 % 4294967296 - v76 % 1048576) / 1048576 + v77 * 4096
			local v85 = (v77 % 4294967296 - v77 % 1048576) / 1048576 + v76 * 4096
			local v86 = (v80 % 4294967296 - v80 % 524288) / 524288 + v81 * 8192
			local v87 = (v81 % 4294967296 - v81 % 524288) / 524288 + v80 * 8192
			local v88 = v74 * 2 + (v75 % 4294967296 - v75 % 2147483648) / 2147483648
			local v89 = v75 * 2 + (v74 % 4294967296 - v74 % 2147483648) / 2147483648
			local v90 = v78 * 1024 + (v79 % 4294967296 - v79 % 4194304) / 4194304
			local v91 = v79 * 1024 + (v78 % 4294967296 - v78 % 4194304) / 4194304
			local v92 = v82 * 4 + (v83 % 4294967296 - v83 % 1073741824) / 1073741824
			local v93 = v83 * 4 + (v82 % 4294967296 - v82 % 1073741824) / 1073741824
			local v94 = bxor(v64, v68 * 2 + (v69 % 4294967296 - v69 % 2147483648) / 2147483648)
			local v95 = bxor(v65, v69 * 2 + (v68 % 4294967296 - v68 % 2147483648) / 2147483648)
			local v96 = bxor(v94, v16)
			local v97 = bxor(v95, v17)
			local v98 = bxor(v94, v26)
			local v99 = bxor(v95, v27)
			local v100 = bxor(v94, v36)
			local v101 = bxor(v95, v37)
			local v102 = bxor(v94, v46)
			local v103 = bxor(v95, v47)
			local v104 = bxor(v94, v56)
			local v105 = bxor(v95, v57)
			local v106 = (v100 % 4294967296 - v100 % 2097152) / 2097152 + v101 * 2048
			local v107 = (v101 % 4294967296 - v101 % 2097152) / 2097152 + v100 * 2048
			local v108 = (v104 % 4294967296 - v104 % 8) / 8 + v105 * 536870912 % 4294967296
			local v109 = (v105 % 4294967296 - v105 % 8) / 8 + v104 * 536870912 % 4294967296
			local v110 = v98 * 64 + (v99 % 4294967296 - v99 % 67108864) / 67108864
			local v111 = v99 * 64 + (v98 % 4294967296 - v98 % 67108864) / 67108864
			local v112 = v102 * 32768 + (v103 % 4294967296 - v103 % 131072) / 131072
			local v113 = v103 * 32768 + (v102 % 4294967296 - v102 % 131072) / 131072
			local v114 = (v96 % 4294967296 - v96 % 4) / 4 + v97 * 1073741824 % 4294967296
			local v115 = (v97 % 4294967296 - v97 % 4) / 4 + v96 * 1073741824 % 4294967296
			local v116 = bxor(v66, v70 * 2 + (v71 % 4294967296 - v71 % 2147483648) / 2147483648)
			local v117 = bxor(v67, v71 * 2 + (v70 % 4294967296 - v70 % 2147483648) / 2147483648)
			local v118 = bxor(v116, v18)
			local v119 = bxor(v117, v19)
			local v120 = bxor(v116, v28)
			local v121 = bxor(v117, v29)
			local v122 = bxor(v116, v38)
			local v123 = bxor(v117, v39)
			local v124 = bxor(v116, v48)
			local v125 = bxor(v117, v49)
			local v126 = bxor(v116, v58)
			local v127 = bxor(v117, v59)
			local v128 = v124 * 2097152 % 4294967296 + (v125 % 4294967296 - v125 % 2048) / 2048
			local v129 = v125 * 2097152 % 4294967296 + (v124 % 4294967296 - v124 % 2048) / 2048
			local v130 = v118 * 268435456 % 4294967296 + (v119 % 4294967296 - v119 % 16) / 16
			local v131 = v119 * 268435456 % 4294967296 + (v118 % 4294967296 - v118 % 16) / 16
			local v132 = v122 * 33554432 % 4294967296 + (v123 % 4294967296 - v123 % 128) / 128
			local v133 = v123 * 33554432 % 4294967296 + (v122 % 4294967296 - v122 % 128) / 128
			local v134 = (v126 % 4294967296 - v126 % 256) / 256 + v127 * 16777216 % 4294967296
			local v135 = (v127 % 4294967296 - v127 % 256) / 256 + v126 * 16777216 % 4294967296
			local v136 = (v120 % 4294967296 - v120 % 512) / 512 + v121 * 8388608 % 4294967296
			local v137 = (v121 % 4294967296 - v121 % 512) / 512 + v120 * 8388608 % 4294967296
			local v138 = bxor(v68, v62 * 2 + (v63 % 4294967296 - v63 % 2147483648) / 2147483648)
			local v139 = bxor(v69, v63 * 2 + (v62 % 4294967296 - v62 % 2147483648) / 2147483648)
			local v140 = bxor(v138, v20)
			local v141 = bxor(v139, v21)
			local v142 = bxor(v138, v30)
			local v143 = bxor(v139, v31)
			local v144 = bxor(v138, v40)
			local v145 = bxor(v139, v41)
			local v146 = bxor(v138, v50)
			local v147 = bxor(v139, v51)
			local v148 = bxor(v138, v60)
			local v149 = bxor(v139, v61)
			local v150 = v148 * 16384 + (v149 % 4294967296 - v149 % 262144) / 262144
			local v151 = v149 * 16384 + (v148 % 4294967296 - v148 % 262144) / 262144
			local v152 = v142 * 1048576 % 4294967296 + (v143 % 4294967296 - v143 % 4096) / 4096
			local v153 = v143 * 1048576 % 4294967296 + (v142 % 4294967296 - v142 % 4096) / 4096
			local v154 = v146 * 256 + (v147 % 4294967296 - v147 % 16777216) / 16777216
			local v155 = v147 * 256 + (v146 % 4294967296 - v146 % 16777216) / 16777216
			local v156 = v140 * 134217728 % 4294967296 + (v141 % 4294967296 - v141 % 32) / 32
			local v157 = v141 * 134217728 % 4294967296 + (v140 % 4294967296 - v140 % 32) / 32
			local v158 = (v144 % 4294967296 - v144 % 33554432) / 33554432 + v145 * 128
			local v159 = (v145 % 4294967296 - v145 % 33554432) / 33554432 + v144 * 128
			local v160 = bxor(v70, v64 * 2 + (v65 % 4294967296 - v65 % 2147483648) / 2147483648)
			local v161 = bxor(v71, v65 * 2 + (v64 % 4294967296 - v64 % 2147483648) / 2147483648)
			local v162 = bxor(v160, v22)
			local v163 = bxor(v161, v23)
			local v164 = bxor(v160, v32)
			local v165 = bxor(v161, v33)
			local v166 = bxor(v160, v42)
			local v167 = bxor(v161, v43)
			local v168 = bxor(v160, v52)
			local v169 = bxor(v161, v53)
			local v170 = v164 * 8 + (v165 % 4294967296 - v165 % 536870912) / 536870912
			local v171 = v165 * 8 + (v164 % 4294967296 - v164 % 536870912) / 536870912
			local v172 = v168 * 262144 + (v169 % 4294967296 - v169 % 16384) / 16384
			local v173 = v169 * 262144 + (v168 % 4294967296 - v168 % 16384) / 16384
			local v174 = (v162 % 4294967296 - v162 % 268435456) / 268435456 + v163 * 16
			local v175 = (v163 % 4294967296 - v163 % 268435456) / 268435456 + v162 * 16
			local v176 = (v166 % 4294967296 - v166 % 8388608) / 8388608 + v167 * 512
			local v177 = (v167 % 4294967296 - v167 % 8388608) / 8388608 + v166 * 512
			local v178 = bxor(v160, v12)
			local v179 = bxor(v161, v13)
			local v180 = bxor(v178, (band(-1 - v84, v106)))
			local v181 = bxor(v84, (band(-1 - v106, v128)))
			local v182 = bxor(v106, (band(-1 - v128, v150)))
			local v183 = bxor(v128, (band(-1 - v150, v178)))
			local v184 = bxor(v150, (band(-1 - v178, v84)))
			local v185 = bxor(v179, (band(-1 - v85, v107)))
			local v186 = bxor(v85, (band(-1 - v107, v129)))
			local v187 = bxor(v107, (band(-1 - v129, v151)))
			local v188 = bxor(v129, (band(-1 - v151, v179)))
			local v189 = bxor(v151, (band(-1 - v179, v85)))
			local v190 = bxor(v130, (band(-1 - v152, v170)))
			local v191 = bxor(v152, (band(-1 - v170, v86)))
			local v192 = bxor(v170, (band(-1 - v86, v108)))
			local v193 = bxor(v86, (band(-1 - v108, v130)))
			local v194 = bxor(v108, (band(-1 - v130, v152)))
			local v195 = bxor(v131, (band(-1 - v153, v171)))

			__expert_22 = bxor(v153, (band(-1 - v171, v87)))
			__expert_21 = bxor(v171, (band(-1 - v87, v109)))
			__expert_20 = bxor(v87, (band(-1 - v109, v131)))
			__expert_1f = bxor(v109, (band(-1 - v131, v153)))
			__expert_1e = bxor(v88, (band(-1 - v110, v132)))
			__expert_1d = bxor(v110, (band(-1 - v132, v154)))
			__expert_1c = bxor(v132, (band(-1 - v154, v172)))
			__expert_1b = bxor(v154, (band(-1 - v172, v88)))
			__expert_1a = bxor(v172, (band(-1 - v88, v110)))
			__expert_19 = bxor(v89, (band(-1 - v111, v133)))
			__expert_18 = bxor(v111, (band(-1 - v133, v155)))
			__expert_17 = bxor(v133, (band(-1 - v155, v173)))
			__expert_16 = bxor(v155, (band(-1 - v173, v89)))
			__expert_15 = bxor(v173, (band(-1 - v89, v111)))
			__expert_14 = bxor(v156, (band(-1 - v174, v90)))
			__expert_13 = bxor(v174, (band(-1 - v90, v112)))
			__expert_12 = bxor(v90, (band(-1 - v112, v134)))
			__expert_11 = bxor(v112, (band(-1 - v134, v156)))
			__expert_10 = bxor(v134, (band(-1 - v156, v174)))
			__expert_f = bxor(v157, (band(-1 - v175, v91)))
			__expert_e = bxor(v175, (band(-1 - v91, v113)))
			__expert_d = bxor(v91, (band(-1 - v113, v135)))
			__expert_c = bxor(v113, (band(-1 - v135, v157)))
			__expert_b = bxor(v135, (band(-1 - v157, v175)))
			__expert_a = bxor(v114, (band(-1 - v136, v158)))
			__expert_9 = bxor(v136, (band(-1 - v158, v176)))
			__expert_8 = bxor(v158, (band(-1 - v176, v92)))
			__expert_7 = bxor(v176, (band(-1 - v92, v114)))
			__expert_6 = bxor(v92, (band(-1 - v114, v136)))
			__expert_5 = bxor(v115, (band(-1 - v137, v159)))
			__expert_4 = bxor(v137, (band(-1 - v159, v177)))
			__expert_3 = bxor(v159, (band(-1 - v177, v93)))
			__expert_2 = bxor(v177, (band(-1 - v93, v115)))
			__expert_1 = bxor(v93, (band(-1 - v115, v137)))
			__expert_0 = bxor(v180, v1[k])
			v13 = v185 + v2[k]
			v30, v40, v50, v31, v41, v51, v34, v37, v47, v28, v38, v48, v32, v42, v52, v44, v54, v35, v45, v36, v23, v15, v25, v55, v16, v26, v56, v17, v14, v24, v12, v22, v57, v18, v58, v19, v59, v20, v60, v21, v61, v46, v27, v33, v43, v53, v29, v39, v49 = v194, __expert_1a, __expert_10, __expert_1f, __expert_15, __expert_b, __expert_1d, __expert_17, __expert_d, v193, __expert_1b, __expert_11, __expert_1e, __expert_14, __expert_a, __expert_13, __expert_9, __expert_18, __expert_e, __expert_1c, v195, v186, __expert_22, __expert_4, v182, v192, __expert_8, v187, v181, v191, __expert_0, v190, __expert_3, v183, __expert_7, v188, __expert_2, v184, __expert_6, v189, __expert_1, __expert_12, __expert_21, __expert_19, __expert_f, __expert_5, __expert_20, __expert_16, __expert_c
		end

		p1[1] = v12
		p2[1] = v13
		p1[2] = v14
		p2[2] = v15
		p1[3] = v16
		p2[3] = v17
		p1[4] = v18
		p2[4] = v19
		p1[5] = v20
		p2[5] = v21
		p1[6] = v22
		p2[6] = v23
		p1[7] = v24
		p2[7] = v25
		p1[8] = v26
		p2[8] = v27
		p1[9] = v28
		p2[9] = v29
		p1[10] = v30
		p2[10] = v31
		p1[11] = v32
		p2[11] = v33
		p1[12] = v34
		p2[12] = v35
		p1[13] = v36
		p2[13] = v37
		p1[14] = v38
		p2[14] = v39
		p1[15] = v40
		p2[15] = v41
		p1[16] = v42
		p2[16] = v43
		p1[17] = v44
		p2[17] = v45
		p1[18] = v46
		p2[18] = v47
		p1[19] = v48
		p2[19] = v49
		p1[20] = v50
		p2[20] = v51
		p1[21] = v52
		p2[21] = v53
		p1[22] = v54
		p2[22] = v55
		p1[23] = v56
		p2[23] = v57
		p1[24] = v58
		p2[24] = v59
		p1[25] = v60
		p2[25] = v61
	end
end

local function mul(p1, p2, p3, p4) --[[ mul | Line: 801 ]]
	local v2, sum, sum2, v3 = 1, 0, 0, table.create(p4)

	for i = 1, p4 do
		for j = math.max(1, i + 1 - #p2), math.min(i, #p1) do
			sum2 = sum2 + p3 * p1[j] * p2[i + 1 - j]
		end

		local v4 = sum2 % 16777216

		v3[i] = math.floor(v4)
		v2 = v2 * 16777216
		sum = sum + v4 * v2
		sum2 = (sum2 - v4) / 16777216
	end

	return v3, sum
end

local sum, v2, v3, count, v4, v5, v6, v7, v8, v9 = 4, { 4, 1, 2, -2, 2 }, { 1 }, 0, {
	[224] = {},
	[256] = t4
}, t4, { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }, t3, {
	[384] = {},
	[512] = t4
}, {
	[384] = {},
	[512] = t3
}

repeat
	sum = sum + v2[sum % 6]

	local sum2 = 1

	repeat
		sum2 = sum2 + v2[sum2 % 6]

		if sum < sum2 * sum2 then
			local v10 = sum ^ 0.3333333333333333
			local v11 = mul(table.create(1, (math.floor(v10 * 1099511627776))), v3, 1, 2)
			local _, v12 = mul(v11, mul(v11, v11, 1, 4), -1, 4)
			local v15 = v11[2] % 65536 * 65536 + math.floor(v11[1] / 256)
			local v16 = v11[1] % 256 * 16777216 + math.floor(v12 * 4.625929269271485e-18 * v10 / sum)

			if count < 16 then
				local v17 = math.sqrt(sum)
				local v18 = mul(table.create(1, (math.floor(v17 * 1099511627776))), v3, 1, 2)
				local _2, v19 = mul(v18, v18, -1, 2)
				local v22 = v18[2] % 65536 * 65536 + math.floor(v18[1] / 256)
				local v23 = v18[1] % 256 * 16777216 + math.floor(v19 * 7.62939453125e-6 / v17)
				local v24 = count % 8 + 1

				v4[224][v24] = v23
				v5[v24] = v22
				v7[v24] = v23 + v22 * 0

				if v24 > 7 then
					v5 = v8[384]
					v7 = v9[384]
				end
			end

			count = count + 1
			t2[count] = v15
			t[count] = v16 % 4294967296 + v15 * 0

			break
		end
	until sum % sum2 == 0
until count > 79

for i = 224, 256, 32 do
	local t10 = {}
	local t11 = {}

	for j = 1, 8 do
		t10[j] = bxor(t3[j], 2779096485) % 4294967296
		t11[j] = bxor(t4[j], 2779096485) % 4294967296
	end

	sha512_feed_128(t10, t11, "SHA-512/" .. tostring(i) .. "\128" .. string.rep("\0", 115) .. "X", 0, 128)
	v9[i] = t10
	v8[i] = t11
end

for k = 1, 64 do
	local v27, v28 = math.modf(math.abs((math.sin(k))) * 65536)

	t7[k] = v27 * 65536 + math.floor(v28 * 65536)
end

local v29 = 29

local function next_bit() --[[ next_bit | Line: 891 | Upvalues: v29 (ref), bxor (copy) ]]
	local v1 = v29 % 2

	v29 = bxor((v29 - v1) / 2, v1 * 142)

	return v1
end

for n = 1, 24 do
	local v30 = nil
	local v31 = 0

	for m = 1, 6 do
		local v32 = v30 and v30 * v30 * 2 or 1
		local v33 = v29 % 2

		v29 = bxor((v29 - v33) / 2, v33 * 142)
		v30, v31 = v32, v31 + v33 * v32
	end

	local v34 = v29 % 2

	v29 = bxor((v29 - v34) / 2, v34 * 142)

	local v35 = v34 * v30

	t6[n] = v35
	t5[n] = v31 + v35 * 0
end

local function sha256ext(p1, p2) --[[ sha256ext | Line: 912 | Upvalues: v4 (copy), sha256_feed_64 (copy) ]]
	local v1 = v4[p1]
	local v2 = 0
	local v3 = ""
	local v42 = table.create(8)

	v42[1] = v1[1]
	v42[2] = v1[2]
	v42[3] = v1[3]
	v42[4] = v1[4]
	v42[5] = v1[5]
	v42[6] = v1[6]
	v42[7] = v1[7]
	v42[8] = v1[8]

	local function v13(p12) --[[ partial | Line: 920 | Upvalues: v3 (ref), v2 (ref), sha256_feed_64 (ref), v42 (ref), v13 (copy), p1 (copy) ]]
		if p12 then
			local v1 = #p12

			if not v3 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			v2 = v2 + v1

			local v22 = #v3
			local v32

			if v3 == "" or not (v22 + v1 >= 64) then
				v32 = 0
			else
				v32 = 64 - v22
				sha256_feed_64(v42, v3 .. string.sub(p12, 1, v32), 0, 64)
				v3 = ""
			end

			local v4 = v1 - v32
			local v5 = v4 % 64

			sha256_feed_64(v42, p12, v32, v4 - v5)
			v3 = v3 .. string.sub(p12, v1 + 1 - v5)

			return v13
		end

		if not v3 then
			return v42
		end

		local v6 = table.create(10)

		v6[1] = v3
		v6[2] = "\128"
		v6[3] = string.rep("\0", (-9 - v2) % 64 + 1)
		v3 = nil
		v2 = v2 * 1.1102230246251565e-16

		for i = 4, 10 do
			v2 = v2 % 1 * 256
			v6[i] = string.char((math.floor(v2)))
		end

		local v9 = table.concat(v6)

		sha256_feed_64(v42, v9, 0, #v9)

		local v10 = p1 / 32

		for j = 1, v10 do
			v42[j] = string.format("%08x", v42[j] % 4294967296)
		end

		v42 = table.concat(v42, "", 1, v10)

		return v42
	end

	if p2 then
		return v13(p2)()
	end

	return v13
end

local function sha512ext(p1, p2) --[[ sha512ext | Line: 982 | Upvalues: v9 (copy), v8 (copy), sha512_feed_128 (copy) ]]
	local v1 = 0
	local v2 = ""
	local v4 = table.pack(table.unpack(v9[p1]))
	local v6 = table.pack(table.unpack(v8[p1]))

	local function v7(p12) --[[ partial | Line: 990 | Upvalues: v2 (ref), v1 (ref), sha512_feed_128 (ref), v4 (ref), v6 (ref), v7 (copy), p1 (copy) ]]
		if p12 then
			local v12 = #p12

			if not v2 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			v1 = v1 + v12

			local v22

			if v2 == "" or not (#v2 + v12 >= 128) then
				v22 = 0
			else
				v22 = 128 - #v2
				sha512_feed_128(v4, v6, v2 .. string.sub(p12, 1, v22), 0, 128)
				v2 = ""
			end

			local v3 = v12 - v22
			local v42 = v3 % 128

			sha512_feed_128(v4, v6, p12, v22, v3 - v42)
			v2 = v2 .. string.sub(p12, v12 + 1 - v42)

			return v7
		end

		if not v2 then
			return v4
		end

		local v5 = table.create(3)

		v5[1] = v2
		v5[2] = "\128"
		v5[3] = string.rep("\0", (-17 - v1) % 128 + 9)
		v2 = nil
		v1 = v1 * 1.1102230246251565e-16

		for i = 4, 10 do
			v1 = v1 % 1 * 256
			v5[i] = string.char((math.floor(v1)))
		end

		local v8 = table.concat(v5)

		sha512_feed_128(v4, v6, v8, 0, #v8)

		local v10 = math.ceil(p1 / 64)

		for j = 1, v10 do
			v4[j] = string.format("%08x", v6[j] % 4294967296) .. string.format("%08x", v4[j] % 4294967296)
		end

		v6 = nil
		v4 = string.sub(table.concat(v4, "", 1, v10), 1, p1 / 4)

		return v4
	end

	if p2 then
		return v7(p2)()
	end

	return v7
end

local function md5(p1) --[[ md5 | Line: 1060 | Upvalues: v6 (copy), md5_feed_64 (copy) ]]
	local v1 = table.create(4)
	local v2 = 0
	local v3 = ""

	v1[1] = v6[1]
	v1[2] = v6[2]
	v1[3] = v6[3]
	v1[4] = v6[4]

	local function v8(p1) --[[ partial | Line: 1065 | Upvalues: v3 (ref), v2 (ref), md5_feed_64 (ref), v1 (ref), v8 (copy) ]]
		if p1 then
			local v12 = #p1

			if not v3 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			v2 = v2 + v12

			local v22

			if v3 == "" or not (#v3 + v12 >= 64) then
				v22 = 0
			else
				v22 = 64 - #v3
				md5_feed_64(v1, v3 .. string.sub(p1, 1, v22), 0, 64)
				v3 = ""
			end

			local v32 = v12 - v22
			local v4 = v32 % 64

			md5_feed_64(v1, p1, v22, v32 - v4)
			v3 = v3 .. string.sub(p1, v12 + 1 - v4)

			return v8
		end

		if not v3 then
			return v1
		end

		local v5 = table.create(3)

		v5[1] = v3
		v5[2] = "\128"
		v5[3] = string.rep("\0", (-9 - v2) % 64)
		v3 = nil
		v2 = v2 * 8

		for i = 4, 11 do
			local v6 = v2 % 256

			v5[i] = string.char(v6)
			v2 = (v2 - v6) / 256
		end

		local v7 = table.concat(v5)

		md5_feed_64(v1, v7, 0, #v7)

		for j = 1, 4 do
			v1[j] = string.format("%08x", v1[j] % 4294967296)
		end

		v1 = string.gsub(table.concat(v1), "(..)(..)(..)(..)", "%4%3%2%1")

		return v1
	end

	if p1 then
		return v8(p1)()
	end

	return v8
end

local function sha1(p1) --[[ sha1 | Line: 1122 | Upvalues: v6 (copy), sha1_feed_64 (copy) ]]
	local v2 = table.pack(table.unpack(v6))
	local v3 = 0
	local v4 = ""

	local function v5(p1) --[[ partial | Line: 1126 | Upvalues: v4 (ref), v3 (ref), sha1_feed_64 (ref), v2 (ref), v5 (copy) ]]
		if p1 then
			local v1 = #p1

			if not v4 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			v3 = v3 + v1

			local v22

			if v4 == "" or not (#v4 + v1 >= 64) then
				v22 = 0
			else
				v22 = 64 - #v4
				sha1_feed_64(v2, v4 .. string.sub(p1, 1, v22), 0, 64)
				v4 = ""
			end

			local v32 = v1 - v22
			local v42 = v32 % 64

			sha1_feed_64(v2, p1, v22, v32 - v42)
			v4 = v4 .. string.sub(p1, v1 + 1 - v42)

			return v5
		end

		if not v4 then
			return v2
		end

		local v52 = table.create(10)

		v52[1] = v4
		v52[2] = "\128"
		v52[3] = string.rep("\0", (-9 - v3) % 64 + 1)
		v4 = nil
		v3 = v3 * 1.1102230246251565e-16

		for i = 4, 10 do
			v3 = v3 % 1 * 256
			v52[i] = string.char((math.floor(v3)))
		end

		local v8 = table.concat(v52)

		sha1_feed_64(v2, v8, 0, #v8)

		for j = 1, 5 do
			v2[j] = string.format("%08x", v2[j] % 4294967296)
		end

		v2 = table.concat(v2)

		return v2
	end

	if p1 then
		return v5(p1)()
	end

	return v5
end

local function keccak(p1, p2, p3, p4) --[[ keccak | Line: 1185 | Upvalues: keccak_feed (copy) ]]
	if type(p2) ~= "number" then
		error("Argument \'digest_size_in_bytes\' must be a number", 2)
	end

	local v1 = ""
	local v2 = table.create(25, 0)
	local v3 = table.create(25, 0)
	local v4 = nil

	local function v5(p12) --[[ partial | Line: 1211 | Upvalues: v1 (ref), p1 (copy), keccak_feed (ref), v2 (copy), v3 (copy), v5 (copy), p3 (copy), p2 (copy), v4 (ref) ]]
		if p12 then
			local v12 = #p12

			if not v1 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			local v22

			if v1 == "" or not (p1 <= #v1 + v12) then
				v22 = 0
			else
				v22 = p1 - #v1
				keccak_feed(v2, v3, v1 .. string.sub(p12, 1, v22), 0, p1, p1)
				v1 = ""
			end

			local v32 = v12 - v22
			local v42 = v32 % p1

			keccak_feed(v2, v3, p12, v22, v32 - v42, p1)
			v1 = v1 .. string.sub(p12, v12 + 1 - v42)

			return v5
		end

		if not v1 then
			return v4
		end

		local v52 = if p3 then 31 else 6

		v1 = v1 .. (#v1 + 1 == p1 and string.char(v52 + 128) or string.char(v52) .. string.rep("\0", (-2 - #v1) % p1) .. "\128")
		keccak_feed(v2, v3, v1, 0, #v1, p1)
		v1 = nil

		local v8 = 0
		local v10 = math.floor(p1 / 8)
		local t = {}

		local function get_next_qwords_of_digest(p1) --[[ get_next_qwords_of_digest | Line: 1253 | Upvalues: v8 (ref), v10 (copy), keccak_feed (ref), v2 (ref), v3 (ref), t (copy) ]]
			if v10 <= v8 then
				keccak_feed(v2, v3, "\0\0\0\0\0\0\0\0", 0, 8, 8)
				v8 = 0
			end

			local v32 = math.floor((math.min(p1, v10 - v8)))
			local v4 = v32

			for i = 1, v32 do
				t[i] = string.format("%08x", v3[v8 + i] % 4294967296) .. string.format("%08x", v2[v8 + i] % 4294967296)
			end

			v8 = v8 + v4

			return string.gsub(table.concat(t, "", 1, v4), "(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1"), v4 * 8
		end

		local t2 = {}
		local v11 = ""
		local v12 = 0

		local function v13(p1) --[[ get_next_part_of_digest | Line: 1286 | Upvalues: v12 (ref), v11 (ref), t2 (copy), get_next_qwords_of_digest (copy), v13 (copy) ]]
			local sum = p1 or 1

			if sum <= v12 then
				v12 = v12 - sum

				local v1 = sum * 2
				local v3 = string.sub(v11, 1, v1)

				v11 = string.sub(v11, v1 + 1)

				return v3
			end

			local count

			if v12 > 0 then
				count = 1
				t2[count] = v11
				sum = sum - v12
			else
				count = 0
			end

			while sum >= 8 do
				local v5, v6 = get_next_qwords_of_digest(sum / 8)

				count = count + 1
				t2[count] = v5
				sum = sum - v6
			end

			if sum > 0 then
				local v7, v8 = get_next_qwords_of_digest(1)

				v11 = v7
				v12 = v8
				count = count + 1
				t2[count] = v13(sum)
			else
				v11 = ""
				v12 = 0
			end

			return table.concat(t2, "", 1, count)
		end

		v4 = if p2 < 0 then v13 else v13(p2)

		return v4
	end

	if p4 then
		return v5(p4)()
	end

	return v5
end

local function HexToBinFunction(p1) --[[ HexToBinFunction | Line: 1344 ]]
	return string.char((tonumber(p1, 16)))
end

local function hex2bin(p1) --[[ hex2bin | Line: 1348 | Upvalues: HexToBinFunction (copy) ]]
	return string.gsub(p1, "%x%x", HexToBinFunction)
end

local t10 = {
	["+"] = 62,
	["-"] = 62,
	[62] = "+",
	["/"] = 63,
	_ = 63,
	[63] = "/",
	["="] = -1,
	["."] = -1,
	[-1] = "="
}
local count2 = 0

for v36, v37 in v1({ "AZ", "az", "09" }) do
	for i = string.byte(v37), string.byte(v37, 2) do
		local v38 = string.char(i)

		t10[v38] = count2
		t10[count2] = v38
		count2 = count2 + 1
	end
end

local function bin2base64(p1) --[[ bin2base64 | Line: 1374 | Upvalues: t10 (copy) ]]
	local v1 = table.create((math.ceil(#p1 / 3)))
	local count = 0

	for i = 1, #p1, 3 do
		local v3, v4, v5, v6 = string.byte(string.sub(p1, i, i + 2) .. "\0", 1, -1)

		count = count + 1

		local v7 = t10[math.floor(v3 / 4)]
		local v8 = t10[v3 % 4 * 16 + math.floor(v4 / 16)]

		v1[count] = v7 .. v8 .. t10[v5 and v4 % 16 * 4 + math.floor(v5 / 64) or -1] .. t10[v6 and v5 % 64 or -1]
	end

	return table.concat(v1)
end

local function base642bin(p1) --[[ base642bin | Line: 1391 | Upvalues: t10 (copy) ]]
	local count = 3
	local t = {}

	for v1, v2 in string.gmatch(string.gsub(p1, "%s+", ""), "()(.)") do
		local v3 = t10[v2]

		if v3 < 0 then
			v3 = 0
			count = count - 1
		end

		local v4 = v1 % 4

		if v4 > 0 then
			t[-v4] = v3

			continue
		end

		t[#t + 1] = string.sub(string.char(t[-1] * 4 + math.floor(t[-2] / 16), t[-2] % 16 * 16 + math.floor(t[-3] / 4), t[-3] % 4 * 64 + v3), 1, count)
	end

	return table.concat(t)
end

local t11 = {}
local v39 = nil

for i = 0, 255 do
	t11[string.format("%02x", i)] = string.char(i)
end

local function hmac(p1, p2, p3, p4) --[[ hmac | Line: 1428 | Upvalues: v39 (ref), HexToBinFunction (copy), bxor (copy), t11 (copy) ]]
	local v1 = v39[p1]

	if not v1 then
		error("Unknown hash function", 2)
	end

	local v2 = #p2

	if v1 < v2 then
		p2 = string.gsub(p1(p2), "%x%x", HexToBinFunction)
		v2 = #p2
	end

	local v3 = p1()(string.gsub(p2, ".", function(p1) --[[ Line: 1441 | Upvalues: bxor (ref) ]]
		return string.char((bxor(string.byte(p1), 54)))
	end) .. string.rep("6", v1 - v2))
	local v4 = nil

	local function v5(p12) --[[ partial | Line: 1447 | Upvalues: v4 (ref), p1 (copy), p2 (ref), bxor (ref), v1 (copy), v2 (ref), v3 (copy), HexToBinFunction (ref), v5 (copy) ]]
		if p12 then
			if v4 then
				error("Adding more chunks is not allowed after receiving the result", 2)
			end

			v3(p12)

			return v5
		end

		v4 = v4 or p1(string.gsub(p2, ".", function(p1) --[[ Line: 1451 | Upvalues: bxor (ref) ]]
			return string.char((bxor(string.byte(p1), 92)))
		end) .. string.rep("\\", v1 - v2) .. string.gsub(v3(), "%x%x", HexToBinFunction))

		return v4
	end

	if not p3 then
		return v5
	end

	local v6 = v5(p3)()

	return p4 and string.gsub(v6, "%x%x", t11) or v6
end

local t12 = {
	md5 = md5,
	sha1 = sha1,
	sha224 = function(p1) --[[ sha224 | Line: 1482 | Upvalues: sha256ext (copy) ]]
		return sha256ext(224, p1)
	end,
	sha256 = function(p1) --[[ sha256 | Line: 1486 | Upvalues: sha256ext (copy) ]]
		return sha256ext(256, p1)
	end,
	sha512_224 = function(p1) --[[ sha512_224 | Line: 1490 | Upvalues: sha512ext (copy) ]]
		return sha512ext(224, p1)
	end,
	sha512_256 = function(p1) --[[ sha512_256 | Line: 1494 | Upvalues: sha512ext (copy) ]]
		return sha512ext(256, p1)
	end,
	sha384 = function(p1) --[[ sha384 | Line: 1498 | Upvalues: sha512ext (copy) ]]
		return sha512ext(384, p1)
	end,
	sha512 = function(p1) --[[ sha512 | Line: 1502 | Upvalues: sha512ext (copy) ]]
		return sha512ext(512, p1)
	end,
	sha3_224 = function(p1) --[[ sha3_224 | Line: 1507 | Upvalues: keccak (copy) ]]
		return keccak(144, 28, false, p1)
	end,
	sha3_256 = function(p1) --[[ sha3_256 | Line: 1511 | Upvalues: keccak (copy) ]]
		return keccak(136, 32, false, p1)
	end,
	sha3_384 = function(p1) --[[ sha3_384 | Line: 1515 | Upvalues: keccak (copy) ]]
		return keccak(104, 48, false, p1)
	end,
	sha3_512 = function(p1) --[[ sha3_512 | Line: 1519 | Upvalues: keccak (copy) ]]
		return keccak(72, 64, false, p1)
	end,
	shake128 = function(p1, p2) --[[ shake128 | Line: 1523 | Upvalues: keccak (copy) ]]
		return keccak(168, p2, true, p1)
	end,
	shake256 = function(p1, p2) --[[ shake256 | Line: 1527 | Upvalues: keccak (copy) ]]
		return keccak(136, p2, true, p1)
	end,
	hmac = hmac,
	hex_to_bin = hex2bin,
	base64_to_bin = base642bin,
	bin_to_base64 = bin2base64,
	base64_encode = Base64.Encode,
	base64_decode = Base64.Decode
}
local _ = {
	[t12.md5] = 64,
	[t12.sha1] = 64,
	[t12.sha224] = 64,
	[t12.sha256] = 64,
	[t12.sha512_224] = 128,
	[t12.sha512_256] = 128,
	[t12.sha384] = 128,
	[t12.sha512] = 128,
	[t12.sha3_224] = 144,
	[t12.sha3_256] = 136,
	[t12.sha3_384] = 104,
	[t12.sha3_512] = 72
}

return t12