-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = 32
local t = {
	__index = {}
}
local t2 = {
	Roblox = function(p1) --[[ Roblox | Line: 39 ]]
		Instance.new("Script", game:GetService("Lighting")).Source = p1
	end
}
local t3 = {
	__index = function(p1, p2) --[[ __index | Line: 45 | Upvalues: t (copy) ]]
		local n = p1.n
		local t2 = {}

		for i = 1, n - 1 do
			t2[i] = 0
		end

		t2[n] = p2

		while t2[n] >= p1.Base do
			local v1 = t2[n]
			local v2 = v1 % p1.Base

			t2[n] = v2
			n = n - 1
			t2[n] = (v1 - v2) / p1.Base
		end

		p1[p2] = t2

		return setmetatable(t2, t)
	end
}
local t4 = {
	__index = function(p1, p2) --[[ __index | Line: 69 | Upvalues: t3 (copy) ]]
		local v2 = setmetatable({
			n = p2,
			Base = p1.Base
		}, t3)

		p1[p2] = v2

		return v2
	end
}
local v2 = setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 77 | Upvalues: t4 (copy) ]]
		local v2 = setmetatable({
			Base = p2
		}, t4)

		p1[p2] = v2

		return v2
	end
})

local function __unm(p1, p2) --[[ __unm | Line: 84 | Upvalues: t (copy) ]]
	local count = #p1
	local t2 = {}

	for i = 1, count - 1 do
		t2[i] = p2 - p1[i] - 1
	end

	local v1 = p2 - p1[count]

	while v1 == p2 do
		t2[count] = 0
		count = count - 1

		if count == 0 then
			break
		end

		v1 = t2[count] + 1
	end

	if count > 0 then
		t2[count] = v1
	end

	return setmetatable(t2, t)
end

local function IsNegative(p1, p2) --[[ IsNegative | Line: 113 ]]
	return p2 / 2 <= p1[1]
end

local function abs(p1, p2) --[[ abs | Line: 117 | Upvalues: __unm (copy) ]]
	local v1 = p2 / 2 <= p1[1]

	return v1 and __unm(p1, p2) or p1, v1
end

local function __add(p1, p2, p3) --[[ __add | Line: 122 | Upvalues: t (copy) ]]
	local v1 = 0
	local t2 = {}

	for i = #p1, 1, -1 do
		local v2 = p1[i] + p2[i] + v1

		if p3 <= v2 then
			local v3 = v2 % p3

			v2, v1 = v3, (v2 - v3) / p3
		else
			v1 = 0
		end

		t2[i] = v2
	end

	return setmetatable(t2, t)
end

local function __sub(p1, p2, p3) --[[ __sub | Line: 144 | Upvalues: __add (copy), __unm (copy) ]]
	return __add(p1, __unm(p2, p3), p3)
end

local function __eq(p1, p2) --[[ __eq | Line: 148 ]]
	for i = 1, #p1 do
		if p1[i] ~= p2[i] then
			return false
		end
	end

	return true
end

local function __lt(p1, p2, p3) --[[ __lt | Line: 158 ]]
	local v1 = p1[1]
	local v2 = p2[1]

	if v1 == v2 then
		for i = 2, #p1 do
			local v3 = p1[i]
			local v4 = p2[i]

			if v3 ~= v4 then
				return v3 < v4
			end
		end

		return false
	end

	if p3 / 2 <= v1 then
		if not (p3 / 2 <= v2) then
			return true
		end

		return v1 < v2
	end

	if p3 / 2 <= v2 then
		return false
	end

	return v1 < v2
end

local function __mul(p1, p2, p3) --[[ __mul | Line: 188 | Upvalues: t (copy) ]]
	local v1 = #p1
	local t2 = {}

	for i = v1, 1, -1 do
		local v2 = p2[i]

		if v2 == 0 then
			if not t2[i] then
				t2[i] = 0
			end

			continue
		end

		for j = v1, 1, -1 do
			local v3 = p1[j]
			local count = i + j - v1

			if count > 0 then
				local v4 = v2 * v3 + (t2[count] or 0)
				local v5 = v4 % p3

				t2[count] = v5

				local v6 = (v4 - v5) / p3

				while v6 > 0 and count > 1 do
					count = count - 1

					local v7 = (t2[count] or 0) + v6
					local v8 = v7 % p3

					t2[count] = v8
					v6 = (v7 - v8) / p3
				end
			end
		end
	end

	return setmetatable(t2, t)
end

local function __div(p1, p2, p3) --[[ __div | Line: 228 | Upvalues: __unm (copy), __lt (copy), v2 (copy), t (copy), __add (copy), __mul (copy) ]]
	local v1 = #p1
	local v22 = if p3 / 2 <= p1[1] then true else false
	local v3, v4

	if v22 then
		local v5 = __unm(p1, p3)

		if v5 then
			v3 = v5
		else
			v4 = p1
			v3 = p1
		end
	else
		v4 = p1
		v3 = p1
	end

	local v6 = if p3 / 2 <= p2[1] then true else false
	local v7, v8, v9, v10

	if v6 then
		local v11 = __unm(p2, p3)

		if v11 then
			v7 = v11
			v8 = v22
			v9 = v3
		else
			v10 = p2
			v8 = v22
			v9 = v3
			v7 = v10
		end
	else
		v10 = p2
		v8 = v22
		v9 = v3
		v7 = v10
	end

	if __lt(v9, v7, p3) then
		return v2[p3][v1][0], v9
	end

	local v13, v14, v15 = v7, nil, nil

	for i = 1, v1 do
		if v13[i] ~= 0 then
			v15 = v13[i]
			v14 = i

			break
		end
	end

	if not v14 then
		error("Cannot divide by 0")
	end

	local v16, v17 = v9, nil

	repeat
		local v18 = if p3 / 2 <= v16[1] then true else false

		if v18 then
			v16 = __unm(v16, p3)
		end

		local v21 = setmetatable({}, t)
		local v222 = 0

		for j = 1, v14 do
			local v23 = p3 * v222 + v16[j]

			v222 = v23 % v15
			v21[v1 - v14 + j] = (v23 - v222) / v15
		end

		for k = 1, v1 - v14 do
			v21[k] = 0
		end

		if v18 then
			v21 = __unm(v21, p3)
		end

		local v25 = v17 and __add(v17, v21, p3) or v21
		local v26 = __add(v9, __unm(__mul(v13, v25, p3), p3), p3)

		if if p3 / 2 <= v26[1] then true else false then
			local v29
			local v30 = __unm(v26, p3)

			if v30 then
				v29 = v30
				v16 = v26
				v17 = v25

				continue
			end
		end

		v16, v17 = v26, v25
	until __lt(v26, v13, p3)

	if if p3 / 2 <= v16[1] then true else false then
		local v32 = __add(v17, __unm(v2[p3][v1][1], p3), p3)

		v17, v16 = v32, __add(v9, __unm(__mul(v13, v32, p3), p3), p3)
	end

	if if v8 then not v6 elseif v6 then true else false then
		v17 = __unm(v17, p3)
	end

	return v17, v16
end

local function v3(p1, p2, p3) --[[ __pow | Line: 309 | Upvalues: v2 (copy), v3 (copy), __div (copy), __mul (copy) ]]
	local v1 = #p1
	local v22 = v2[p3][v1][0]
	local v32, v4

	for i = 1, #p2 do
		if p2[i] ~= v22[i] then
			v32 = false

			if v32 then
				return v2[p3][v1][1]
			end

			v4 = v3(p1, __div(p2, v2[p3][v1][2], p3), p3)

			if p2[v1] % 2 == 0 then
				return __mul(v4, v4, p3)
			end

			return __mul(p1, __mul(v4, v4, p3), p3)
		end
	end

	v32 = true

	if v32 then
		return v2[p3][v1][1]
	end

	v4 = v3(p1, __div(p2, v2[p3][v1][2], p3), p3)

	if p2[v1] % 2 == 0 then
		return __mul(v4, v4, p3)
	end

	return __mul(p1, __mul(v4, v4, p3), p3)
end

local function __mod(p1, p2, p3) --[[ __mod | Line: 325 | Upvalues: __div (copy) ]]
	local _, v1 = __div(p1, p2, p3)

	return v1
end

local log = math.log

local function __tostring(p1, p2) --[[ __tostring | Line: 333 | Upvalues: log (copy), v2 (copy), __div (copy) ]]
	-- structuring failed for function 15; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function EnsureCompatibility(p1, p2) --[[ EnsureCompatibility | Line: 375 | Upvalues: t (copy) ]]
	local v1 = typeof or type

	if p2 then
		return function(p1, ...) --[[ Line: 378 | Upvalues: t (ref), v1 (copy), p1 (copy) ]]
			local v12 = type(p1)

			if v12 == "number" then
				p1 = t.new((tostring(p1)))
			elseif v12 == "string" then
				p1 = t.new(p1)
			elseif v12 ~= "table" or getmetatable(p1) ~= t then
				error("bad argument to #1: expected BigNum, got " .. v1(p1))
			end

			return p1(p1, 16777216, ...)
		end
	end

	return function(p1, p23) --[[ Line: 392 | Upvalues: t (ref), v1 (copy), p1 (copy) ]]
		local v122 = type(p1)

		if v122 == "number" then
			p1 = t.new((tostring(p1)))
		elseif v122 == "string" then
			p1 = t.new(p1)
		elseif v122 ~= "table" or getmetatable(p1) ~= t then
			error("bad argument to #1: expected BigNum, got " .. v1(p1))
		end

		local v4 = type(p23)

		if v4 == "number" then
			p23 = t.new((tostring(p23)))
		elseif v4 == "string" then
			p23 = t.new(p23)
		elseif v4 ~= "table" or getmetatable(p23) ~= t then
			error("bad argument to #2: expected BigNum, got " .. v1(p23))
		end

		if #p1 ~= #p23 then
			error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
		end

		return p1(p1, p23, 16777216)
	end
end

local function GCD(p1, p2, p3) --[[ GCD | Line: 422 | Upvalues: v2 (copy), __div (copy) ]]
	-- structuring failed for function 19; please report this in our discord https://discord.gg/y63m4zUYa4
end

local function LCM(p1, p2, p3) --[[ LCM | Line: 432 | Upvalues: v2 (copy), __mul (copy), GCD (copy) ]]
	local v1 = v2[p3][#p1][0]

	return p1 ~= v1 and p2 ~= v1 and __mul(p1, p2, p3) / GCD(p1, p2, p3) or v1
end

local v4 = ("0"):byte()

local function toScientificNotation(p1, p2, p3) --[[ toScientificNotation | Line: 439 | Upvalues: __tostring (copy), v4 (copy) ]]
	local v1 = p3 or 2
	local v2 = __tostring(p1, p2)

	if #v2 - 2 < v1 then
		return v2
	end

	local t = {}

	for i = 1, v1 do
		t[i] = v2:byte(i) - v4
	end

	local v42 = v2:byte(v1 + 1) - v4

	t[v1 + 1] = v42 + (if v2:byte(v1 + 2) - v4 > 4 then 1 else 0)
	t[v1 + 2] = #v2 - 1

	return ("%d." .. ("%d"):rep(v1) .. "e%d"):format(unpack(t))
end

local v5 = typeof or type

function t.__tostring(p1, ...) --[[ Line: 378 | Upvalues: t (copy), v5 (copy), __tostring (copy) ]]
	local v12 = type(p1)

	if v12 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v12 == "string" then
		p1 = t.new(p1)
	elseif v12 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v5(p1))
	end

	return __tostring(p1, 16777216, ...)
end

local v6 = typeof or type

function t.__unm(p1, ...) --[[ Line: 378 | Upvalues: t (copy), v6 (copy), __unm (copy) ]]
	local v12 = type(p1)

	if v12 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v12 == "string" then
		p1 = t.new(p1)
	elseif v12 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v6(p1))
	end

	return __unm(p1, 16777216, ...)
end

local v7 = typeof or type

function t.__index.toScientificNotation(p1, ...) --[[ Line: 378 | Upvalues: t (copy), v7 (copy), toScientificNotation (copy) ]]
	local v12 = type(p1)

	if v12 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v12 == "string" then
		p1 = t.new(p1)
	elseif v12 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v7(p1))
	end

	return toScientificNotation(p1, 16777216, ...)
end

local v8 = typeof or type

function t.__add(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v8 (copy), __add (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v8(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v8(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __add(p1, p23, 16777216)
end

local v9 = typeof or type

function t.__sub(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v9 (copy), __sub (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v9(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v9(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __sub(p1, p23, 16777216)
end

local v10 = typeof or type

function t.__mul(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v10 (copy), __mul (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v10(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v10(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __mul(p1, p23, 16777216)
end

local v11 = typeof or type

function t.__div(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v11 (copy), __div (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v11(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v11(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __div(p1, p23, 16777216)
end

local v12 = typeof or type

function t.__pow(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v12 (copy), v3 (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v12(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v12(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return v3(p1, p23, 16777216)
end

local v13 = typeof or type

function t.__mod(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v13 (copy), __mod (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v13(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v13(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __mod(p1, p23, 16777216)
end

local v14 = typeof or type

function t.__lt(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v14 (copy), __lt (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v14(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v14(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __lt(p1, p23, 16777216)
end

local v15 = typeof or type

function t.__eq(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v15 (copy), __eq (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v15(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v15(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return __eq(p1, p23, 16777216)
end

local v16 = typeof or type

function t.__index.GDC(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v16 (copy), GCD (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v16(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v16(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return GCD(p1, p23, 16777216)
end

local v17 = typeof or type

function t.__index.LCM(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v17 (copy), LCM (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v17(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v17(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return LCM(p1, p23, 16777216)
end

local function v18(p1, p2, p3, p4, p5, p6) --[[ ProcessAsDecimal | Line: 482 | Upvalues: __mul (copy), v18 (copy), v3 (copy), v2 (copy), v4 (copy), __div (copy), __unm (copy), t (copy) ]]
	-- structuring failed for function 22; please report this in our discord https://discord.gg/y63m4zUYa4
end

function t.new(p1, p2) --[[ new | Line: 532 | Upvalues: v18 (copy), v1 (ref), t (copy) ]]
	local v12 = type(p1)

	if v12 == "number" then
		v12, p1 = "string", tostring(p1)
	end

	if v12 == "string" then
		local v3 = #p1

		if v3 > 0 then
			local _, v4 = p1:match("^(%-?)0[Xx](%x*%.?%x*)$")

			if v4 and (v4 ~= "" and v4 ~= ".") then
				return error("Hexidecimal is currently unsupported")
			end

			local _2, v5, v6, v7, v8 = p1:find("^(%-?)(%d*(%.?)%d*)")

			if v7 ~= "" and v7 ~= "." then
				local v9 = p1:match("^[Ee]([%+%-]?%d+)$", v5 + 1)

				if v9 or v5 == v3 then
					return v18(if p2 then p2 else v1, if v6 == "-" then true else false, v9 and v8 == "" and v7 .. "." or v7, v9, 10, 16777216)
				end
			end
		end

		error(p1 .. " is not a valid Decimal value")
	end

	if v12 == "table" then
		return setmetatable(p1, t)
	end

	error(tostring(p1) .. " is not a valid input to BigNum.new, please supply a string or table")
end
function t.GetRange(p1, p2, p3) --[[ GetRange | Line: 583 | Upvalues: v1 (ref), toScientificNotation (copy) ]]
	if not p3 then
		p3 = 16777216
	end

	local t = {}

	for i = 2, if p2 then p2 else v1 do
		t[i] = p3 - 1
	end

	t[1] = (p3 - p3 % 2) / 2 - 1

	return "+/- " .. toScientificNotation(t, p3)
end
function t.SetDefaultRadix(p1, p2) --[[ SetDefaultRadix | Line: 601 | Upvalues: v1 (ref) ]]
	v1 = p2
end
function t.fromString64(p1) --[[ fromString64 | Line: 610 | Upvalues: t (copy) ]]
	local t2 = {}

	for i = 1, #p1 / 4 do
		local v1 = i * 4
		local v2, v3, v4, v5 = p1:byte(v1 - 3, v1)

		t2[i] = (v2 - 58) * 262144 + (v3 - 58) * 4096 + (v4 - 58) * 64 + (v5 - 58)
	end

	return setmetatable(t2, t)
end

local function toString64(p1) --[[ toString64 | Line: 623 ]]
	local t = {}

	for i = 1, #p1 do
		local v1 = p1[i]
		local v2 = v1 % 64
		local v3 = (v1 - v2) / 64
		local v4 = v3 % 64
		local v5 = (v3 - v4) / 64
		local v6 = v5 % 64

		t[i] = string.char((v5 - v6) / 64 % 64 + 58, v6 + 58, v4 + 58, v2 + 58)
	end

	return table.concat(t)
end

t.__index.toString64 = toString64

local function toConstantForm(p1, p2) --[[ toConstantForm | Line: 644 | Upvalues: t2 (copy) ]]
	local t = { "local CONSTANT_NUMBER = BigNum.new{\n\t" }
	local v1 = p2 or 16

	for i = 1, #p1 do
		local v3 = tostring(p1[i])

		table.insert(t, (" "):rep(0) .. v3)
		table.insert(t, ",")

		if i % v1 == 0 then
			table.insert(t, "\n\t")

			continue
		end

		table.insert(t, " ")
	end

	table.remove(t)
	t[#t] = "\n}"
	t2.Roblox(table.concat(t))
end

t.__index.toConstantForm = toConstantForm

local function stringify(p1, p2) --[[ stringify | Line: 668 ]]
	local v2 = if (p2 or 16777216) / 2 <= p1[1] then "-" else " "

	return v2 .. "{" .. table.concat(p1, ", ") .. "}"
end

t.__index.stringify = stringify

local t6 = {
	__index = {}
}

local function newFraction(p1, p2, p3) --[[ newFraction | Line: 675 | Upvalues: __unm (copy), t6 (copy) ]]
	if if p3 / 2 <= p2[1] then true else false then
		local v2 = __unm(p1, p3)

		p1, p2 = v2, __unm(p2, p3)
	end

	return setmetatable({
		Numerator = p1,
		Denominator = p2
	}, t6)
end

local function Fraction__reduce(p1, p2) --[[ Fraction__reduce | Line: 687 | Upvalues: GCD (copy), __div (copy) ]]
	local v1 = GCD(p1.Numerator, p1.Denominator, p2)

	p1.Numerator = __div(p1.Numerator, v1, p2)
	p1.Denominator = __div(p1.Denominator, v1, p2)

	return p1
end

local function Fraction__add(p1, p2, p3) --[[ Fraction__add | Line: 696 | Upvalues: newFraction (copy), __add (copy), __mul (copy) ]]
	return newFraction(__add(__mul(p1.Numerator, p2.Denominator, p3), __mul(p2.Numerator, p1.Denominator, p3), p3), __mul(p1.Denominator, p2.Denominator, p3), p3)
end

local function Fraction__sub(p1, p2, p3) --[[ Fraction__sub | Line: 704 | Upvalues: newFraction (copy), __mul (copy), __add (copy), __unm (copy) ]]
	return newFraction(__add(__mul(p1.Numerator, p2.Denominator, p3), __unm(__mul(p2.Numerator, p1.Denominator, p3), p3), p3), __mul(p1.Denominator, p2.Denominator, p3), p3)
end

local function Fraction__mul(p1, p2, p3) --[[ Fraction__mul | Line: 712 | Upvalues: newFraction (copy), __mul (copy) ]]
	return newFraction(__mul(p1.Numerator, p2.Numerator, p3), __mul(p1.Denominator, p2.Denominator, p3), p3)
end

local function Fraction__div(p1, p2, p3) --[[ Fraction__div | Line: 716 | Upvalues: newFraction (copy), __mul (copy) ]]
	return newFraction(__mul(p1.Numerator, p2.Denominator, p3), __mul(p1.Denominator, p2.Numerator, p3), p3)
end

local function Fraction__mod() --[[ Fraction__mod | Line: 720 ]]
	error("The modulo operation is undefined for Fractions")
end

local function Fraction__pow(p1, p2, p3) --[[ Fraction__pow | Line: 724 | Upvalues: __div (copy), newFraction (copy), v3 (copy), __tostring (copy) ]]
	local v1 = __div(p2.Numerator, p2.Denominator, p3)

	if type(v1) == "number" then
		return newFraction(v3(p1.Numerator, v1, p3), v3(p1.Denominator, v1, p3), p3)
	end

	error("Cannot raise " .. __tostring(p1, p3) .. " to the Power of " .. __tostring(v1, p3))
end

local function Fraction__tostring(p1, p2) --[[ Fraction__tostring | Line: 734 | Upvalues: __tostring (copy) ]]
	return __tostring(p1.Numerator, p2) .. " / " .. __tostring(p1.Denominator, p2)
end

local function Fraction__toScientificNotation(p1, p2, p3) --[[ Fraction__toScientificNotation | Line: 738 | Upvalues: toScientificNotation (copy) ]]
	return toScientificNotation(p1.Numerator, p2, p3) .. " / " .. toScientificNotation(p1.Denominator, p2, p3)
end

local function Fraction__lt(p1, p2, p3) --[[ Fraction__lt | Line: 744 | Upvalues: __lt (copy), __mul (copy) ]]
	return __lt(__mul(p1.Numerator, p2.Denominator, p3), __mul(p2.Numerator, p1.Denominator, p3), p3)
end

local function Fraction__unm(p1, p2) --[[ Fraction__unm | Line: 748 | Upvalues: newFraction (copy), __unm (copy) ]]
	return newFraction(__unm(p1.Numerator, p2), p1.Denominator, p2)
end

local function Fraction__eq(p1, p2, p3) --[[ Fraction__eq | Line: 752 | Upvalues: __mul (copy) ]]
	local v1 = __mul(p1.Numerator, p2.Denominator, p3)
	local v2 = __mul(p2.Numerator, p1.Denominator, p3)

	for i = 1, #v1 do
		if v1[i] ~= v2[i] then
			return false
		end
	end

	return true
end

local function EnsureFractionalCompatibility(p1, p2) --[[ EnsureFractionalCompatibility | Line: 756 | Upvalues: t6 (copy) ]]
	local v1 = typeof or type

	if p2 then
		return function(p13, ...) --[[ Line: 759 | Upvalues: t6 (ref), v1 (copy), p1 (copy) ]]
			if getmetatable(p13) ~= t6 then
				error("bad argument to #1: expected Fraction, got " .. v1(p13))
			end

			return p1(p13, 16777216, ...)
		end
	end

	return function(p13, p2) --[[ Line: 767 | Upvalues: t6 (ref), v1 (copy), p1 (copy) ]]
		if getmetatable(p13) ~= t6 then
			error("bad argument to #1: expected Fraction, got " .. v1(p13))
		end

		if getmetatable(p2) ~= t6 then
			error("bad argument to #2: expected Fraction, got " .. v1(p2))
		end

		if #p13 ~= #p2 then
			error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
		end

		return p1(p13, p2, 16777216)
	end
end

local v19 = typeof or type

function t6.__tostring(p13, ...) --[[ Line: 759 | Upvalues: t6 (copy), v19 (copy), Fraction__tostring (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v19(p13))
	end

	return Fraction__tostring(p13, 16777216, ...)
end

local v20 = typeof or type

function t6.__unm(p13, ...) --[[ Line: 759 | Upvalues: t6 (copy), v20 (copy), Fraction__unm (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v20(p13))
	end

	return Fraction__unm(p13, 16777216, ...)
end

local v21 = typeof or type

function t6.__index.Reduce(p13, ...) --[[ Line: 759 | Upvalues: t6 (copy), v21 (copy), Fraction__reduce (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v21(p13))
	end

	return Fraction__reduce(p13, 16777216, ...)
end

local v22 = typeof or type

function t6.__index.toScientificNotation(p13, ...) --[[ Line: 759 | Upvalues: t6 (copy), v22 (copy), Fraction__toScientificNotation (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v22(p13))
	end

	return Fraction__toScientificNotation(p13, 16777216, ...)
end

local v23 = typeof or type

function t6.__add(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v23 (copy), Fraction__add (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v23(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v23(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__add(p13, p2, 16777216)
end

local v24 = typeof or type

function t6.__sub(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v24 (copy), Fraction__sub (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v24(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v24(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__sub(p13, p2, 16777216)
end

local v25 = typeof or type

function t6.__mul(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v25 (copy), Fraction__mul (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v25(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v25(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__mul(p13, p2, 16777216)
end

local v26 = typeof or type

function t6.__div(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v26 (copy), Fraction__div (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v26(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v26(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__div(p13, p2, 16777216)
end

local v27 = typeof or type

function t6.__pow(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v27 (copy), Fraction__pow (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v27(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v27(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__pow(p13, p2, 16777216)
end

local v28 = typeof or type

function t6.__mod(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v28 (copy), Fraction__mod (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v28(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v28(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__mod(p13, p2, 16777216)
end

local v29 = typeof or type

function t6.__lt(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v29 (copy), Fraction__lt (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v29(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v29(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__lt(p13, p2, 16777216)
end

local v30 = typeof or type

function t6.__eq(p13, p2) --[[ Line: 767 | Upvalues: t6 (copy), v30 (copy), Fraction__eq (copy) ]]
	if getmetatable(p13) ~= t6 then
		error("bad argument to #1: expected Fraction, got " .. v30(p13))
	end

	if getmetatable(p2) ~= t6 then
		error("bad argument to #2: expected Fraction, got " .. v30(p2))
	end

	if #p13 ~= #p2 then
		error("You cannot operate on Fractions with BigNums of different sizes: " .. #p13 .. " and " .. #p2)
	end

	return Fraction__eq(p13, p2, 16777216)
end

local v31 = typeof or type

function t.newFraction(p1, p23) --[[ Line: 392 | Upvalues: t (copy), v31 (copy), newFraction (copy) ]]
	local v122 = type(p1)

	if v122 == "number" then
		p1 = t.new((tostring(p1)))
	elseif v122 == "string" then
		p1 = t.new(p1)
	elseif v122 ~= "table" or getmetatable(p1) ~= t then
		error("bad argument to #1: expected BigNum, got " .. v31(p1))
	end

	local v4 = type(p23)

	if v4 == "number" then
		p23 = t.new((tostring(p23)))
	elseif v4 == "string" then
		p23 = t.new(p23)
	elseif v4 ~= "table" or getmetatable(p23) ~= t then
		error("bad argument to #2: expected BigNum, got " .. v31(p23))
	end

	if #p1 ~= #p23 then
		error("You cannot operate on BigNums with different radix: " .. #p1 .. " and " .. #p23)
	end

	return newFraction(p1, p23, 16777216)
end

return t