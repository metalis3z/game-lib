--credit to leon games studio
local function MatClone(p1) --[[ MatClone | Line: 23 ]]
	local v1 = table.clone(p1)

	for i = 1, #v1 do
		v1[i] = table.clone(v1[i])
	end

	return v1
end

local function MatZero(p1) --[[ MatZero | Line: 33 ]]
	local v1 = table.create(p1)

	for i = 1, p1 do
		v1[i] = table.create(p1, 0)
	end

	return v1
end

local function MatIdent(p1) --[[ MatIdent | Line: 43 | Upvalues: MatZero (copy) ]]
	local v1 = MatZero(p1)

	for i = 1, p1 do
		v1[i][i] = 1
	end

	return v1
end

local function MatMul(p1, p2) --[[ MatMul | Line: 53 ]]
	local v1 = #p1[1]
	local v2 = #p2[1]
	local t = {}

	for i = 1, #p1 do
		local v3 = table.create(v2, 0)

		for j = 1, v2 do
			local v4 = 0

			for k = 1, v1 do
				v4 = bit32.bxor(v4, (bit32.band(p1[i][k], p2[k][j])))
			end

			v3[j] = v4
		end

		t[i] = v3
	end

	return t
end

local function MatMulVec(p1, p2) --[[ MatMulVec | Line: 73 ]]
	local v1 = #p1
	local v2 = #p1[1]
	local v3 = table.create(v1, 0)

	for i = 1, v1 do
		local v4 = 0

		for j = 1, v2 do
			v4 = bit32.bxor(v4, (bit32.band(p1[i][j], p2[j])))
		end

		v3[i] = v4
	end

	return v3
end

local function MatSum(p1, p2) --[[ MatSum | Line: 89 | Upvalues: MatZero (copy) ]]
	local v1 = #p1
	local v2 = #p1[1]
	local v3 = MatZero(v1)

	for i = 1, v1 do
		for j = 1, v2 do
			v3[i][j] = bit32.bxor(p1[i][j], p2[i][j])
		end
	end

	return v3
end

local function MatInverse(p1) --[[ MatInverse | Line: 103 | Upvalues: MatClone (copy), MatZero (copy) ]]
	local v1 = #p1
	local v2 = MatClone(p1)
	local v3 = MatZero(v1)

	for i = 1, v1 do
		v3[i][i] = 1
	end

	local v4 = v3

	for j = 1, v1 do
		local v5 = nil

		for k = j, v1 do
			if v2[k][j] == 1 then
				v5 = k

				break
			end
		end

		assert(v5, "not invertible")

		local v7 = v2[j]

		v2[j] = v2[v5]
		v2[v5] = v7

		local v9 = v4[j]

		v4[j] = v4[v5]
		v4[v5] = v9

		for n = 1, v1 do
			if n ~= j and v2[n][j] == 1 then
				for m = 1, v1 do
					v2[n][m] = bit32.bxor(v2[n][m], v2[j][m])
					v4[n][m] = bit32.bxor(v4[n][m], v4[j][m])
				end
			end
		end
	end

	return v4
end

local function MatPow(p1, p2) --[[ MatPow | Line: 132 | Upvalues: MatZero (copy), MatInverse (copy), MatClone (copy), MatMul (copy) ]]
	local v1 = #p1
	local v2 = MatZero(v1)

	for i = 1, v1 do
		v2[i][i] = 1
	end

	local v3 = if p2 < 0 then MatInverse(p1) else MatClone(p1)
	local v5, v6 = math.abs(p2), v2

	while v5 > 0 do
		if math.fmod(v5, 2) >= 0.5 then
			v6 = MatMul(v6, v3)
		end

		local v8 = MatMul(v3, v3)

		v5, v3 = math.floor(v5 / 2), v8
	end

	return v6
end

local function L(p1, p2) --[[ L | Line: 150 | Upvalues: MatZero (copy) ]]
	local v1 = MatZero(p2)

	for i = 1, p2 - p1 do
		v1[i][i + p1] = 1
	end

	return v1
end

local function R(p1, p2) --[[ R | Line: 161 | Upvalues: MatZero (copy) ]]
	local v1 = MatZero(p2)

	for i = p1 + 1, p2 do
		v1[i][i - p1] = 1
	end

	return v1
end

local function Embed(p1, p2, p3, p4) --[[ Embed | Line: 172 | Upvalues: MatZero (copy) ]]
	local v1 = MatZero(p2)

	for i = 1, #p1 do
		for j = 1, #p1[1] do
			v1[p3 + i][p4 + j] = p1[i][j]
		end
	end

	return v1
end

local function ToColumnVector128(p1, p2, p3, p4) --[[ ToColumnVector128 | Line: 187 ]]
	local v1 = table.create(128, 0)

	for i = 0, 31 do
		v1[32 - i] = bit32.band(bit32.rshift(p1, i), 1)
		v1[64 - i] = bit32.band(bit32.rshift(p2, i), 1)
		v1[96 - i] = bit32.band(bit32.rshift(p3, i), 1)
		v1[128 - i] = bit32.band(bit32.rshift(p4, i), 1)
	end

	return v1
end

local function FromColumnVector128(p1) --[[ FromColumnVector128 | Line: 203 ]]
	local v1 = 0
	local v2 = 0
	local v3 = 0
	local v4 = 0

	for i = 0, 31 do
		v1, v2, v3, v4 = bit32.bor(v1, (bit32.lshift(p1[32 - i], i))), bit32.bor(v2, (bit32.lshift(p1[64 - i], i))), bit32.bor(v3, (bit32.lshift(p1[96 - i], i))), bit32.bor(v4, (bit32.lshift(p1[128 - i], i)))
	end

	return v1, v2, v3, v4
end

local function BuildMatTransform() --[[ BuildMatTransform | Line: 216 | Upvalues: MatIdent (copy), L (copy), MatMul (copy), MatSum (copy), Embed (copy), R (copy) ]]
	local v1 = MatIdent(32)
	local v2 = MatIdent(128)
	local v3 = MatMul(MatSum(v2, (Embed(L(11, 32), 128, 0, 0))), v2)
	local v4 = MatMul(MatSum(v2, (Embed(R(8, 32), 128, 0, 0))), v3)
	local v5 = MatMul(MatSum(v2, (Embed(v1, 128, 0, 96))), v4)
	local v6 = MatMul(MatSum(v2, (Embed(R(19, 32), 128, 0, 96))), v5)

	return MatMul(MatSum(L(32, 128), (R(96, 128))), v6)
end

local v1 = BuildMatTransform()

return table.freeze({
	ToColumnVector128 = ToColumnVector128,
	FromColumnVector128 = FromColumnVector128,
	MatTransform = function() --[[ MatTransform | Line: 249 | Upvalues: MatClone (copy), v1 (copy) ]]
		return MatClone(v1)
	end,
	Transform = function(p1, p2, p3, p4, p5) --[[ Transform | Line: 253 | Upvalues: ToColumnVector128 (copy), MatMulVec (copy), MatPow (copy), MatClone (copy), v1 (copy), FromColumnVector128 (copy) ]]
		local v12 = ToColumnVector128(p1, p2, p3, p4)

		return FromColumnVector128((MatMulVec(MatPow(MatClone(v1), p5), v12)))
	end
})