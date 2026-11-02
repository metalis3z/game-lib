
return {
	RandomOnArray = function(_: {[any]: any}, t2: {[any]: any}, n1: number?, p1)
		local v5 = 1 + (n1 or 0) / 3
		local n2 = 0
		local t3 = {}

		for i = 1, #t2 do
			local v9 = t2[i] ^ (1 / v5)

			table.insert(t3, v9)
			n2 += v9
		end

		local v10 = p1 and p1:NextNumber(0, n2) or Random.new():NextNumber(0, 1) * n2
		local n3 = 0

		for i = 1, #t3 do
			n3 += t3[i]

			if v10 <= n3 then
				return i
			end
		end

		return nil
	end,
	RandomOnDict = function(_: {[any]: any}, t5: {[any]: any}, n4: number?, p2)
		local v17 = 1 + (n4 or 0) / 3
		local n5 = 0
		local t6 = {}

		for v20, v21 in t5 do
			local v22 = v21 ^ (1 / v17)

			t6[v20] = v22
			n5 += v22
		end

		local v23 = p2 and p2:NextNumber(0, n5) or Random.new():NextNumber(0, 1) * n5
		local n6 = 0

		for v25, v26 in t6 do
			n6 += v26

			if v23 <= n6 then
				return v25
			end
		end

		return nil
	end,
	RandomOnArrayWithChance = function(_: {[any]: any}, t8: {[any]: any}, n7: number?, p3)
		local v31 = 1 + (n7 or 0) / 3
		local n8 = 0
		local t9 = {}

		for i = 1, #t8 do
			local v35 = t8[i].Chance ^ (1 / v31)

			table.insert(t9, v35)
			n8 += v35
		end

		local v36 = p3 and p3:NextNumber(0, n8) or Random.new():NextNumber(0, 1) * n8
		local n9 = 0

		for i = 1, #t9 do
			n9 += t9[i]

			if v36 <= n9 then
				return t8[i]
			end
		end

		return nil
	end,
	RandomOnArrayWithWeight = function(_: {[any]: any}, t11: {[any]: any}, n10: number?, p4)
		local v43 = 1 + (n10 or 0) / 3
		local n11 = 0
		local t12 = {}

		for i = 1, #t11 do
			local v47 = t11[i].weight ^ (1 / v43)

			table.insert(t12, v47)
			n11 += v47
		end

		local v48 = p4 and p4:NextNumber(0, n11) or Random.new():NextNumber(0, 1) * n11
		local n12 = 0

		for i = 1, #t12 do
			n12 += t12[i]

			if v48 <= n12 then
				return t11[i], i
			end
		end

		return nil
	end,
	GetPercentage = function(_: {[any]: any}, t14: {[any]: any}, n13: number?)
		local v54 = 1 + (n13 or 0) / 3
		local n14 = 0
		local t15 = {}

		for i = 1, #t14 do
			local v58 = t14[i] ^ (1 / v54)

			table.insert(t15, v58)
			n14 += v58
		end

		local t16 = {}

		for i = 1, #t15 do
			table.insert(t16, t15[i] / n14 * 100)
		end

		return t16
	end
}
