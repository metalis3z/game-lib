-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local v1 = Random.new()

local function Copy(p1, p2) --[[ Copy | Line: 39 ]]
	if p2 then
		local function v1(p1) --[[ DeepCopy | Line: 43 | Upvalues: v1 (copy) ]]
			local v12 = table.clone(p1)

			for v2, v32 in v12 do
				if type(v32) == "table" then
					v12[v2] = v1(v32)
				end
			end

			return v12
		end

		return v1(p1)
	end

	return table.clone(p1)
end

local function CopySafe(p1, p2, p3) --[[ CopySafe | Line: 55 ]]
	if p2 then
		local t = {}

		local function v1(p1) --[[ DeepCopy | Line: 61 | Upvalues: t (ref), p3 (copy), v1 (copy) ]]
			local v12 = t[p1]

			if v12 then
				return v12
			end

			local v2 = table.clone(p1)
			local v3 = if p3 then getmetatable(p1) else nil

			t[p1] = v2

			if v3 then
				setmetatable(v2, v3)
			end

			for v4, v5 in v2 do
				if type(v5) == "table" then
					v2[v4] = v1(v5)
				end
			end

			return v2
		end

		t = nil

		return v1(p1)
	end

	return table.clone(p1)
end

local function v2(p1, p2) --[[ Sync | Line: 119 | Upvalues: v2 (copy) ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "table" then true else false, "Second argument must be a table")

	local v3 = table.clone(p1)

	for k, v in pairs(v3) do
		local v4
		local v5 = p2[k]

		if v5 == nil then
			v3[k] = nil

			continue
		end

		if type(v) == type(v5) then
			if type(v) == "table" then
				v3[k] = v2(v, v5)
			end

			continue
		end

		if type(v5) == "table" then
			v4 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v4 (copy) ]]
				local v12 = table.clone(p1)

				for v2, v32 in v12 do
					if type(v32) == "table" then
						v12[v2] = v4(v32)
					end
				end

				return v12
			end
			v3[k] = v4(v5)

			continue
		end

		v3[k] = v5
	end

	for k, v in pairs(p2) do
		local v6

		if v3[k] == nil then
			if type(v) == "table" then
				v6 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v6 (copy) ]]
					local v12 = table.clone(p1)

					for v2, v32 in v12 do
						if type(v32) == "table" then
							v12[v2] = v6(v32)
						end
					end

					return v12
				end
				v3[k] = v6(v)

				continue
			end

			v3[k] = v
		end
	end

	return v3
end

local function v3(p1, p2) --[[ Reconcile | Line: 191 | Upvalues: v3 (copy) ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "table" then true else false, "Second argument must be a table")

	local v32 = table.clone(p1)

	for v6, v7 in p2 do
		local v4, v5
		local v8 = p1[v6]

		if v8 == nil then
			if type(v7) == "table" then
				v4 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v4 (copy) ]]
					local v12 = table.clone(p1)

					for v2, v32 in v12 do
						if type(v32) == "table" then
							v12[v2] = v4(v32)
						end
					end

					return v12
				end
				v32[v6] = v4(v7)

				continue
			end

			v32[v6] = v7

			continue
		end

		if type(v8) == "table" then
			if type(v7) == "table" then
				v32[v6] = v3(v8, v7)

				continue
			end

			v5 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v5 (copy) ]]
				local v12 = table.clone(p1)

				for v2, v32 in v12 do
					if type(v32) == "table" then
						v12[v2] = v5(v32)
					end
				end

				return v12
			end
			v32[v6] = v5(v8)
		end
	end

	return v32
end

local function HardReconcile(p1, p2) --[[ HardReconcile | Line: 217 | Upvalues: v3 (copy) ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "table" then true else false, "Second argument must be a table")

	for v5, v6 in p2 do
		local v32, v4
		local v7 = p1[v5]

		if v7 == nil then
			if type(v6) == "table" then
				v32 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v32 (copy) ]]
					local v12 = table.clone(p1)

					for v2, v32 in v12 do
						if type(v32) == "table" then
							v12[v2] = v32(v32)
						end
					end

					return v12
				end
				p1[v5] = v32(v6)

				continue
			end

			p1[v5] = v6

			continue
		end

		if type(v7) == "table" then
			if type(v6) == "table" then
				p1[v5] = v3(v7, v6)

				continue
			end

			v4 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v4 (copy) ]]
				local v12 = table.clone(p1)

				for v2, v32 in v12 do
					if type(v32) == "table" then
						v12[v2] = v4(v32)
					end
				end

				return v12
			end
			p1[v5] = v4(v7)
		end
	end

	return p1
end

local function ShallowReconcile(p1, p2) --[[ ShallowReconcile | Line: 241 ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "table" then true else false, "Second argument must be a table")

	local v3 = table.clone(p1)

	for v5, v6 in p2 do
		local v4

		if p1[v5] == nil then
			if type(v6) == "table" then
				v4 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v4 (copy) ]]
					local v12 = table.clone(p1)

					for v2, v32 in v12 do
						if type(v32) == "table" then
							v12[v2] = v4(v32)
						end
					end

					return v12
				end
				v3[v5] = v4(v6)

				continue
			end

			v3[v5] = v6
		end
	end

	return v3
end

local function HardShallowReconcile(p1, p2) --[[ HardShallowReconcile | Line: 261 ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "table" then true else false, "Second argument must be a table")

	for v4, v5 in p2 do
		local v3

		if p1[v4] == nil then
			if type(v5) == "table" then
				v3 = function(p1) --[[ DeepCopy | Line: 43 | Upvalues: v3 (copy) ]]
					local v12 = table.clone(p1)

					for v2, v32 in v12 do
						if type(v32) == "table" then
							v12[v2] = v3(v32)
						end
					end

					return v12
				end
				p1[v4] = v3(v5)

				continue
			end

			p1[v4] = v5
		end
	end

	return p1
end

local function SwapRemove(p1, p2) --[[ SwapRemove | Line: 306 ]]
	local v1 = #p1

	p1[p2] = p1[v1]
	p1[v1] = nil
end

local function SwapRemoveFirstValue(p1, p2) --[[ SwapRemoveFirstValue | Line: 331 ]]
	local v1 = table.find(p1, p2)

	if v1 then
		local v2 = #p1

		p1[v1] = p1[v2]
		p1[v2] = nil
	end

	return v1
end

local function Map(p1, p2) --[[ Map | Line: 359 ]]
	assert(if type(p1) == "table" then true else false, "First argument must be a table")
	assert(if type(p2) == "function" then true else false, "Second argument must be a function")

	local v3 = table.create(#p1)

	for v4, v5 in p1 do
		v3[v4] = p2(v5, v4, p1)
	end

	return v3
end

return {
	Copy = Copy,
	Sync = v2,
	Reconcile = v3,
	SwapRemove = SwapRemove,
	SwapRemoveFirstValue = SwapRemoveFirstValue,
	Map = Map,
	Filter = function(p1, p2) --[[ Filter | Line: 389 ]]
		assert(if type(p1) == "table" then true else false, "First argument must be a table")
		assert(if type(p2) == "function" then true else false, "Second argument must be a function")

		local v3 = table.create(#p1)

		if #p1 > 0 then
			local count = 0

			for v4, v5 in p1 do
				if p2(v5, v4, p1) then
					count = count + 1
					v3[count] = v5
				end
			end
		else
			for v6, v7 in p1 do
				if p2(v7, v6, p1) then
					v3[v6] = v7
				end
			end
		end

		return v3
	end,
	Reduce = function(p1, p2, p3) --[[ Reduce | Line: 432 ]]
		assert(if type(p1) == "table" then true else false, "First argument must be a table")
		assert(if type(p2) == "function" then true else false, "Second argument must be a function")

		if #p1 > 0 then
			local v3, v4

			if p3 == nil then
				v3 = p1[1]
				v4 = 2
			else
				v4 = 1
				v3 = p3
			end

			for i = v4, #p1 do
				v3 = p2(v3, p1[i], i, p1)
			end

			return v3
		end

		local v6, v7

		if p3 == nil then
			local v8 = next(p1)

			v6 = v8
			v7 = v8
		else
			v6 = nil
			v7 = p3
		end

		for v9, v10 in next, p1, v6 do
			v7 = p2(v7, v10, v9, p1)
		end

		return v7
	end,
	Assign = function(p1, ...) --[[ Assign | Line: 475 ]]
		local v1 = table.clone(p1)

		for v2, v3 in { ... } do
			for v4, v5 in v3 do
				v1[v4] = v5
			end
		end

		return v1
	end,
	Extend = function(p1, p2) --[[ Extend | Line: 504 ]]
		local v1 = table.clone(p1)

		for v2, v3 in p2 do
			table.insert(v1, v3)
		end

		return v1
	end,
	Reverse = function(p1) --[[ Reverse | Line: 529 ]]
		local v1 = #p1
		local v2 = table.create(v1)

		for i = 1, v1 do
			v2[i] = p1[v1 - i + 1]
		end

		return v2
	end,
	Shuffle = function(p1, p2) --[[ Shuffle | Line: 556 | Upvalues: v1 (copy) ]]
		assert(if type(p1) == "table" then true else false, "First argument must be a table")

		local v2 = table.clone(p1)
		local v3 = if typeof(p2) == "Random" then p2 else v1

		for i = #p1, 2, -1 do
			local v4 = v3:NextInteger(1, i)
			local v6 = v2[i]

			v2[i] = v2[v4]
			v2[v4] = v6
		end

		return v2
	end,
	Sample = function(p1, p2, p3) --[[ Sample | Line: 586 | Upvalues: v1 (copy) ]]
		assert(if type(p1) == "table" then true else false, "First argument must be a table")
		assert(if type(p2) == "number" then true else false, "Second argument must be a number")

		local v3 = #p1

		if v3 == 0 then
			return {}
		end

		local v4 = table.clone(p1)
		local v5 = table.create(p2)
		local v6 = if typeof(p3) == "Random" then p3 else v1
		local v7 = math.clamp(p2, 1, v3)

		for i = 1, v7 do
			local v9 = v6:NextInteger(i, v3)
			local v11 = v4[i]

			v4[i] = v4[v9]
			v4[v9] = v11
		end

		table.move(v4, 1, v7, 1, v5)

		return v5
	end,
	Flat = function(p1, p2) --[[ Flat | Line: 634 ]]
		local v1 = if type(p2) == "number" then p2 else 1
		local v2 = table.create(#p1)

		local function v3(p13, p23) --[[ Scan | Line: 637 | Upvalues: v1 (copy), v3 (copy), v2 (copy) ]]
			for v12, v22 in p13 do
				if type(v22) == "table" and p23 < v1 then
					v3(v22, p23 + 1)

					continue
				end

				table.insert(v2, v22)
			end
		end

		v3(p1, 0)

		return v2
	end,
	FlatMap = function(p1, p2) --[[ FlatMap | Line: 671 | Upvalues: Map (copy) ]]
		local v1 = Map(p1, p2)
		local v2 = table.create(#v1)
		local v3 = 1

		local function v4(p13, p23) --[[ Scan | Line: 637 | Upvalues: v3 (copy), v4 (copy), v2 (copy) ]]
			for v12, v22 in p13 do
				if type(v22) == "table" and p23 < v3 then
					v4(v22, p23 + 1)

					continue
				end

				table.insert(v2, v22)
			end
		end

		v4(v1, 0)

		return v2
	end,
	Keys = function(p1) --[[ Keys | Line: 697 ]]
		local v1 = table.create(#p1)

		for v2 in p1 do
			table.insert(v1, v2)
		end

		return v1
	end,
	Values = function(p1) --[[ Values | Line: 727 ]]
		local v1 = table.create(#p1)

		for v2, v3 in p1 do
			table.insert(v1, v3)
		end

		return v1
	end,
	Find = function(p1, p2) --[[ Find | Line: 766 ]]
		for v1, v2 in p1 do
			if p2(v2, v1, p1) then
				return v2, v1
			end
		end

		return nil, nil
	end,
	Every = function(p1, p2) --[[ Every | Line: 795 ]]
		for v1, v2 in p1 do
			if not p2(v2, v1, p1) then
				return false
			end
		end

		return true
	end,
	Some = function(p1, p2) --[[ Some | Line: 824 ]]
		for v1, v2 in p1 do
			if p2(v2, v1, p1) then
				return true
			end
		end

		return false
	end,
	Truncate = function(p1, p2) --[[ Truncate | Line: 850 ]]
		local v1 = #p1
		local v2 = math.clamp(p2, 1, v1)

		if v2 == v1 then
			return table.clone(p1)
		end

		return table.move(p1, 1, v2, 1, table.create(v2))
	end,
	Zip = function(...) --[[ Zip | Line: 883 ]]
		assert(select("#", ...) > 0, "Must supply at least 1 table")

		local function ZipIteratorArray(p1, p2) --[[ ZipIteratorArray | Line: 885 ]]
			local v1 = p2 + 1
			local t = {}

			for v2, v3 in p1 do
				local v4 = v3[v1]

				if v4 == nil then
					return nil, nil
				end

				t[v2] = v4
			end

			return v1, t
		end

		local function ZipIteratorMap(p1, p2) --[[ ZipIteratorMap | Line: 898 ]]
			local t = {}

			for v1, v2 in p1 do
				local v3 = next(v2, p2)

				if v3 == nil then
					return nil, nil
				end

				t[v1] = v3
			end

			return p2, t
		end

		local t = { ... }

		if #t[1] > 0 then
			return ZipIteratorArray, t, 0
		end

		return ZipIteratorMap, t, nil
	end,
	Lock = function(p1) --[[ Lock | Line: 936 ]]
		local function v1(p1) --[[ Freeze | Line: 937 | Upvalues: v1 (copy) ]]
			for k, v in pairs(p1) do
				if type(v) == "table" then
					p1[k] = v1(v)
				end
			end

			return table.freeze(p1)
		end

		return v1(p1)
	end,
	IsEmpty = function(p1) --[[ IsEmpty | Line: 966 ]]
		return next(p1) == nil
	end,
	EncodeJSON = function(p1) --[[ EncodeJSON | Line: 978 | Upvalues: HttpService (copy) ]]
		return HttpService:JSONEncode(p1)
	end,
	DecodeJSON = function(p1) --[[ DecodeJSON | Line: 990 | Upvalues: HttpService (copy) ]]
		return HttpService:JSONDecode(p1)
	end,
	ShallowReconcile = ShallowReconcile,
	HardShallowReconcile = HardShallowReconcile,
	CopySafe = CopySafe,
	HardReconcile = HardReconcile
}