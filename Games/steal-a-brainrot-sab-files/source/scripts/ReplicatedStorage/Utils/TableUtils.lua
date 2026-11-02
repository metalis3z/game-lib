local t1 = {}
local HttpService = game:GetService("HttpService")
local random = Random.new()

local function Sync(p1, p2)
	assert(type(p1) == "table", "First argument must be a table")
	assert(type(p2) == "table", "Second argument must be a table")

	local v12 = table.clone(p1)

	for k, v in pairs(v12) do
		local v15 = p2[k]

		if v15 == nil then
			v12[k] = nil
		elseif type(v) ~= type(v15) then
			if type(v15) == "table" then
				local function DeepCopy(t2: {[any]: any})
					local v136 = table.clone(t2)

					for v137, v138 in v136 do
						if type(v138) == "table" then
							v136[v137] = DeepCopy(v138)
						end
					end

					return v136
				end

				v12[k] = DeepCopy(v15)
			else
				v12[k] = v15
			end
		elseif type(v) == "table" then
			v12[k] = Sync(v, v15)
		end
	end

	for k, v in pairs(p2) do
		if v12[k] == nil then
			if type(v) == "table" then
				local function DeepCopy(t3: {[any]: any})
					local v140 = table.clone(t3)

					for v141, v142 in v140 do
						if type(v142) == "table" then
							v140[v141] = DeepCopy(v142)
						end
					end

					return v140
				end

				v12[k] = DeepCopy(v)
			else
				v12[k] = v
			end
		end
	end

	return v12
end
local function Reconcile(p3, p4)
	assert(type(p3) == "table", "First argument must be a table")
	assert(type(p4) == "table", "Second argument must be a table")

	local v22 = table.clone(p3)

	for v23, v24 in p4 do
		local v25 = p3[v23]

		if v25 == nil then
			if type(v24) == "table" then
				local function DeepCopy(t4: {[any]: any})
					local v144 = table.clone(t4)

					for v145, v146 in v144 do
						if type(v146) == "table" then
							v144[v145] = DeepCopy(v146)
						end
					end

					return v144
				end

				v22[v23] = DeepCopy(v24)
			else
				v22[v23] = v24
			end
		elseif type(v25) == "table" then
			if type(v24) == "table" then
				v22[v23] = Reconcile(v25, v24)
			else
				local function DeepCopy(t5: {[any]: any})
					local v148 = table.clone(t5)

					for v149, v150 in v148 do
						if type(v150) == "table" then
							v148[v149] = DeepCopy(v150)
						end
					end

					return v148
				end

				v22[v23] = DeepCopy(v25)
			end
		end
	end

	return v22
end
local function Map(t6: {[any]: any}, p5: ((...any) -> ...any))
	assert(type(t6) == "table", "First argument must be a table")
	assert(type(p5) == "function", "Second argument must be a function")

	local t7 = table.create(#t6)

	for v38, v39 in t6 do
		t7[v38] = p5(v39, v38, t6)
	end

	return t7
end

function t1.Copy(p6, b1: boolean?)
	if not b1 then
		return (table.clone(p6))
	end

	local function DeepCopy(t8: {[any]: any})
		local v132 = table.clone(t8)

		for v133, v134 in v132 do
			if type(v134) == "table" then
				v132[v133] = DeepCopy(v134)
			end
		end

		return v132
	end

	return (DeepCopy(p6))
end

t1.Sync = Sync
t1.Reconcile = Reconcile

function t1.SwapRemove(t9: {[any]: any}, n1: number)
	local v30 = #t9

	t9[n1] = t9[v30]
	t9[v30] = nil
end
function t1.SwapRemoveFirstValue(t10: {[any]: any}, p7)
	local v33 = table.find(t10, p7)

	if v33 then
		local v34 = #t10

		t10[v33] = t10[v34]
		t10[v34] = nil
	end

	return v33
end

t1.Map = Map

function t1.Filter(t11: {[any]: any}, p8: ((...any) -> ...any))
	assert(type(t11) == "table", "First argument must be a table")
	assert(type(p8) == "function", "Second argument must be a function")

	local t12 = table.create(#t11)

	if #t11 > 0 then
		local n2 = 0

		for v44, v45 in t11 do
			if p8(v45, v44, t11) then
				n2 += 1
				t12[n2] = v45
			end
		end

		return t12
	end

	for v46, v47 in t11 do
		if p8(v47, v46, t11) then
			t12[v46] = v47
		end
	end

	return t12
end
function t1.Reduce(t13: {[any]: any}, p9: ((...any) -> ...any), p10)
	assert(type(t13) == "table", "First argument must be a table")
	assert(type(p9) == "function", "Second argument must be a function")

	if #t13 > 0 then
		local n3 = 1

		if p10 == nil then
			p10 = t13[1]
			n3 = 2
		end

		for i = n3, #t13 do
			p10 = p9(p10, t13[i], i, t13)
		end

		return p10
	end

	local v53 = nil

	if p10 == nil then
		p10 = next(t13)
		v53 = p10
	end

	for k, v in next, t13, v53 do
		p10 = p9(p10, v, k, t13)
	end

	return p10
end
function t1.Assign(t14: {[any]: any}, ...)
	local v57 = table.clone(t14)

	for _, v59 in { ... } do
		for v60, v61 in v59 do
			v57[v60] = v61
		end
	end

	return v57
end
function t1.Extend(t15: {[any]: any}, t16: {[any]: any})
	local v64 = table.clone(t15)

	for _, v66 in t16 do
		table.insert(v64, v66)
	end

	return v64
end
function t1.Reverse(t17: {[any]: any})
	local v68 = #t17
	local t18 = table.create(v68)

	for i = 1, v68 do
		t18[i] = t17[v68 - i + 1]
	end

	return t18
end
function t1.Shuffle(t19: {[any]: any}, p11)
	assert(type(t19) == "table", "First argument must be a table")

	local v73 = table.clone(t19)
	local v74 = if typeof(p11) ~= "Random" then random else p11

	for i = #t19, 2, -1 do
		local v76 = v74:NextInteger(1, i)
		local v77 = v73[v76]
		local v78 = v73[i]

		v73[i] = v77
		v73[v76] = v78
	end

	return v73
end
function t1.Sample(t20: {[any]: any}, n4: number, p12)
	assert(type(t20) == "table", "First argument must be a table")
	assert(type(n4) == "number", "Second argument must be a number")

	local v82 = #t20

	if v82 == 0 then
		return {}
	end

	local v83 = table.clone(t20)
	local t21 = table.create(n4)
	local v85 = if typeof(p12) ~= "Random" then random else p12
	local v86 = math.clamp(n4, 1, v82)

	for i = 1, v86 do
		local v88 = v85:NextInteger(i, v82)
		local v89 = v83[v88]
		local v90 = v83[i]

		v83[i] = v89
		v83[v88] = v90
	end

	table.move(v83, 1, v86, 1, t21)

	return t21
end
function t1.Flat(t22: {[any]: any}, n5: number?)
	local v93 = type(n5) ~= "number" and 1 or n5
	local t23 = table.create(#t22)

	local function Scan(t24: {[any]: any}, n6: number)
		for _, v154 in t24 do
			if type(v154) == "table" and n6 < v93 then
				Scan(v154, n6 + 1)
			else
				table.insert(t23, v154)
			end
		end
	end

	Scan(t22, 0)

	return t23
end
function t1.FlatMap(t25: {[any]: any}, p13: ((...any) -> ...any))
	local v98 = Map(t25, p13)
	local t26 = table.create(#v98)
	local n7 = 1

	local function Scan(t27: {[any]: any}, n8: number)
		for _, v158 in t27 do
			if type(v158) == "table" and n8 < n7 then
				Scan(v158, n8 + 1)
			else
				table.insert(t26, v158)
			end
		end
	end

	Scan(v98, 0)

	return t26
end
function t1.Keys(t28: {[any]: any})
	local t29 = table.create(#t28)

	for v104 in t28 do
		table.insert(t29, v104)
	end

	return t29
end
function t1.Values(t30: {[any]: any})
	local t31 = table.create(#t30)

	for _, v108 in t30 do
		table.insert(t31, v108)
	end

	return t31
end
function t1.Find(t32: {[any]: any}, p14: ((...any) -> ...any))
	for v111, v112 in t32 do
		if p14(v112, v111, t32) then
			return v112, v111
		end
	end

	return nil, nil
end
function t1.Every(t33: {[any]: any}, p15: ((...any) -> ...any))
	for v115, v116 in t33 do
		if not p15(v116, v115, t33) then
			return false
		end
	end

	return true
end
function t1.Some(t34: {[any]: any}, p16: ((...any) -> ...any))
	for v119, v120 in t34 do
		if p16(v120, v119, t34) then
			return true
		end
	end

	return false
end
function t1.Truncate(t35: {[any]: any}, n9: number)
	local v123 = #t35
	local v124 = math.clamp(n9, 1, v123)

	if v124 == v123 then
		return (table.clone(t35))
	end

	return (table.move(t35, 1, v124, 1, table.create(v124)))
end
function t1.Zip(...)
	assert(select("#", ...) > 0, "Must supply at least 1 table")

	local t36 = { ... }

	if #t36[1] > 0 then
		return function(t37: {[any]: any}, n10: number)
			local v161 = n10 + 1
			local t38 = {}

			for v163, v164 in t37 do
				local v165 = v164[v161]

				if v165 == nil then
					return nil, nil
				end

				t38[v163] = v165
			end

			return v161, t38
		end, t36, 0
	end

	return function(t39: {[any]: any}, p17)
		local t40 = {}

		for v169, v170 in t39 do
			local v171 = next(v170, p17)

			if v171 == nil then
				return nil, nil
			end

			t40[v169] = v171
		end

		return p17, t40
	end, t36, nil
end
function t1.Lock(p18)
	local function Freeze(t41: {[any]: any})
		for k, v in pairs(t41) do
			if type(v) == "table" then
				t41[k] = Freeze(v)
			end
		end

		return table.freeze(t41)
	end

	return Freeze(p18)
end
function t1.IsEmpty(t42: {[any]: any})
	return next(t42) == nil
end
function t1.EncodeJSON(p19)
	return HttpService:JSONEncode(p19)
end
function t1.DecodeJSON(s1: string)
	return HttpService:JSONDecode(s1)
end

return t1
