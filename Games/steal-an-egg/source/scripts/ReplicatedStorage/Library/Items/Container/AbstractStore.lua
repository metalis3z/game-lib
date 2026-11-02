-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Items = game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Items")
local AbstractItem = require(Items.AbstractItem)
local t = {
	HARD_AMOUNT_CAPACITY = 1e300,
	DEFAULT_SIZE_CAPACITY = 1000000000000000,
	HARD_SIZE_CAPACITY = 1000000000000000,
	Assert = function(p1) --[[ Assert | Line: 11 ]]
		assert(p1.IsValid)
	end,
	AssertOptional = function(p1) --[[ AssertOptional | Line: 15 ]]
		assert(if p1 == nil then true else p1.IsValid)
	end,
	ClearReference = function(p1) --[[ ClearReference | Line: 20 ]]
		p1:Each(function(p12) --[[ Line: 21 | Upvalues: p1 (copy) ]]
			p1:RemoveReference(p12)
		end)
	end,
	SetReference = function(p1, p2, p3) --[[ SetReference | Line: 26 ]]
		local v1 = p1:Get(p2)

		if p3 then
			local Class = p3.Class
			local v2 = Class.Name
			local v3 = p3:StackKey()
			local v4 = p1:Type(v2)
			local v5 = v4:Stack(v3)

			if v1 then
				local v6 = v1:StackKey()

				if Class == v1.Class then
					local v7 = v4:GetStack(v6)

					if v7 and v5 ~= v7 then
						v7:_SetReference(p2, nil)
					end
				else
					local v8 = v1.Class.Name

					p1:_SetData(v8, p2, nil)

					local v9 = p1:GetType(v8)

					if v9 then
						v9:_SetReference(p2, nil)

						local v10 = v9:GetStack(v6)

						if v10 and v5 ~= v10 then
							v10:_SetReference(p2, nil)
						end
					end
				end
			end

			p1:_SetData(v2, p2, p3:GetData())
			p1:_SetReference(p2, p3)
			v4:_SetReference(p2, p3)
			v5:_SetReference(p2, p3)
		else
			if not v1 then
				return
			end

			local v11 = v1.Class.Name

			p1:_SetData(v11, p2, nil)
			p1:_SetReference(p2, nil)

			local v12 = p1:GetType(v11)

			if not v12 then
				return
			end

			v12:_SetReference(p2, nil)

			local v13 = v12:GetStack(v1:StackKey())

			if not v13 then
				return
			end

			v13:_SetReference(p2, nil)
		end
	end
}

function t.AddReference(p1, p2) --[[ AddReference | Line: 75 | Upvalues: t (copy) ]]
	local v1 = p2:GetUID()
	local v2 = p1:Capacity() or t.DEFAULT_SIZE_CAPACITY

	if v2 <= p1:Size() then
		return false
	end

	if p1:Get(v1) then
		return false
	end

	p1:SetReference(v1, p2)

	return true
end
function t.RemoveReference(p1, p2) --[[ RemoveReference | Line: 87 ]]
	local v1 = p2:GetUID()

	if p1:Get(v1) == p2 then
		p1:SetReference(v1, nil)

		return true
	end

	return false
end
function t.Clear(p1) --[[ Clear | Line: 96 ]]
	local t = {}

	p1:Each(function(p12, p2) --[[ Line: 98 | Upvalues: p1 (copy) ]]
		p1:RemoveReference(p12)
		table.insert(p2, p12)
	end, t)

	return t
end
function t.Add(p1, p2, p3, p4) --[[ Add | Line: 105 | Upvalues: AbstractItem (copy), t (copy) ]]
	AbstractItem:Assert(p2)
	assert(if p3 == nil then true elseif typeof(p3) == "Instance" then if p3.ClassName == "Player" then true else false else false, "Provided owner is not a valid instance class.")
	assert(if p4 == nil then true elseif type(p4) == "boolean" then true else false, "Provided flag is not a boolean.")

	local v3 = p2:IsTracked()

	if not v3 then
		if not p2:GetTag() then
			warn("Missing item tag:", p2, debug.traceback())
		end

		p2:SetTracked(true)
	end

	local v4 = if v3 then if p2.TrackingEnabled then true else false else false

	p2:Populate(p3, p2:PopulateUID(), v4)

	local v5 = p2:GetAmount()

	assert(if v5 > 0 then true else false, "Expected amount to be greater than 0")
	assert(if v5 <= math.min(p2:GetMaxAmount(), t.HARD_AMOUNT_CAPACITY) then true else false, "Amount exceeds the allowed maximum capacity.")
	p2:Freeze()

	local v9 = p2:GetUID()

	if p1:Get(v9) then
		warn(("[DupeDetector] [AbstractStore.Add] %* %* %*"):format(p2, debug.traceback(), _G.DupeDetectorTraceback))

		return false, false, v5
	end

	local list = {}
	local v10 = p1:Type(p2.Class.Name)
	local sum, sum2, v11

	if v10 then
		local v13 = math.min(v5, t.HARD_AMOUNT_CAPACITY - v10:Amount())

		if v5 ~= v13 and not p4 then
			return false, false, v5
		end

		local v14 = v10:GetStack(p2:StackKey())

		if v14 then
			local v16 = math.min(v13, t.HARD_AMOUNT_CAPACITY - v14:Amount())

			if v5 ~= v16 and not p4 then
				return false, false, v5
			end

			if p2:IsStackable() then
				local t2 = {}

				v14:Each(function(p1, p22) --[[ Line: 164 | Upvalues: p2 (copy) ]]
					if not (p1:GetAmount() < p1:GetMaxAmount() and p1:IsLikeExact(p2)) then
						return
					end

					table.insert(p22, p1)
				end, t2)
				table.sort(t2, function(p1, p2) --[[ Line: 170 ]]
					return p1:GetAmount() < p2:GetAmount()
				end)

				local count

				sum = v16
				count = 1
				sum2 = v5
				v11 = v14

				while sum > 0 and not (#t2 < count) do
					local v17 = t2[count]

					count = count + 1

					local v18 = v17:GetAmount()
					local v20 = math.min(v17:GetMaxAmount() - v18, sum)

					if v20 > 0 then
						local v21 = v17:Clone()

						v21:SetAmount(v18 + v20)

						local pack = table.pack

						table.insert(list, pack(v17:GetUID(), v21))
						sum = sum - v20
						sum2 = sum2 - v20
					end
				end
			else
				sum = v16
				v11 = v14
				sum2 = v5
			end
		else
			sum = v13
			v11 = v14
			sum2 = v5
		end
	else
		sum = v5
		v11 = nil
		sum2 = v5
	end

	if sum > 0 then
		local v24 = if p2.StackLimit <= (v11 and v11:Size() or 0) then 0 else sum
		local v26 = if p2.TypeStackLimit <= (v10 and v10:Size() or 0) then 0 else v24
		local v27 = p1:Capacity() or t.DEFAULT_SIZE_CAPACITY
		local v28 = if v27 <= p1:Size() then 0 else v26

		if v28 > 0 then
			if v28 ~= v5 then
				p2:Clone():SetAmount(v28)
			end

			table.insert(list, table.pack(v9, p2))
			sum2 = sum2 - v28
		end
	end

	if sum2 > 0 and not p4 then
		return false, false, sum2
	end

	for i, v in ipairs(list) do
		p1:SetReference(table.unpack(v))
	end

	return true, v4, sum2
end
function SubtractItem(p1, p2, p3, p4, p5, p6) --[[ SubtractItem | Line: 236 ]]
	if p3:IsLocked() and not p2:IsLocked() then
		return p4
	end

	local v1 = p3:GetAmount()
	local v2 = math.min(v1, p4)

	if v2 > 0 then
		local v3 = v1 - v2
		local v4, v5

		if v3 > 0 then
			local v6 = p3:Clone()

			v6:SetAmount(v3)

			local v7 = p3:Clone()

			v7:SetAmount(v2)
			v7:StripUID()
			v7:Freeze()
			v4 = v6
			v5 = v7
		else
			v4 = nil
			v5 = p3
		end

		local pack = table.pack

		table.insert(p6, pack(p3:GetUID(), v4))
		table.insert(p5, v5)
		p4 = p4 - v2
	end

	return p4
end
function RemoveGeneric(p1, p2, p3) --[[ RemoveGeneric | Line: 267 | Upvalues: AbstractItem (copy), t (copy) ]]
	AbstractItem:Assert(p2)

	local t2 = {}
	local v1 = p2:GetAmount()

	assert(if v1 > 0 then true else false)
	assert(if v1 <= math.min(p2:GetMaxAmount(), t.HARD_AMOUNT_CAPACITY) then true else false)

	local list = {}
	local v5 = p2:GetOptionalUID()
	local v6

	if v5 then
		local v7 = p1:Get(v5)

		v6 = v7

		if v7 then
			local v8

			v8 = p3 and v7:IsLikeAny(p2) or v7:IsLikeExact(p2)

			if v8 then
				v1 = SubtractItem(p1, p2, v6, v1, t2, list)
			else
				v6 = nil
			end
		end
	else
		v6 = nil
	end

	if v1 > 0 then
		local v10 = p1:GetType(p2.Class.Name)

		if v10 then
			local v11 = v10:GetStack(p2:StackKey())

			if v11 then
				local t3 = {}

				v11:Each(function(p1, p22, p32) --[[ Line: 303 | Upvalues: p3 (copy), p2 (copy) ]]
					if p1 == p32 then
						return
					end

					if not (p3 or p1:IsLikeExact(p2)) then
						return
					end

					table.insert(p22, p1)
				end, t3, v6)
				table.sort(t3, function(p1, p2) --[[ Line: 310 ]]
					return p1:GetAmount() > p2:GetAmount()
				end)

				local v12 = 1

				while v1 > 0 and not (#t3 < v12) do
					v1, v12 = SubtractItem(p1, p2, t3[v12], v1, t2, list), v12 + 1
				end
			end
		end
	end

	if v1 > 0 then
		return nil
	end

	for i, v in ipairs(list) do
		p1:SetReference(table.unpack(v))
	end

	return t2
end
function t.RemoveExact(p1, p2) --[[ RemoveExact | Line: 335 ]]
	return RemoveGeneric(p1, p2, false)
end
function t.RemoveAny(p1, p2) --[[ RemoveAny | Line: 339 ]]
	return RemoveGeneric(p1, p2, true)
end
function HasGeneric(p1, p2, p3) --[[ HasGeneric | Line: 343 | Upvalues: AbstractItem (copy) ]]
	AbstractItem:Assert(p2)

	local v1 = p2:GetAmount()
	local v2 = p1:GetType(p2.Class.Name)
	local v3 = if v2 then v2:GetStack(p2:StackKey()) else v2

	if v3 then
		v3:Each(function(p1) --[[ Line: 349 | Upvalues: p3 (copy), p2 (copy), v1 (ref) ]]
			if not (p3 or p1:IsLikeExact(p2)) then
				return
			end

			v1 = v1 - math.min(p1:GetAmount(), v1)

			if v1 <= 0 then
				return true
			end
		end)
	end

	local v4 = v1 <= 0

	return v4
end
function t.HasExact(p1, p2) --[[ HasExact | Line: 361 ]]
	return HasGeneric(p1, p2, false)
end
function t.HasAny(p1, p2) --[[ HasAny | Line: 365 ]]
	return HasGeneric(p1, p2, true)
end
function CountGeneric(p1, p2, p3) --[[ CountGeneric | Line: 369 | Upvalues: AbstractItem (copy) ]]
	AbstractItem:Assert(p2)

	local v1 = 0
	local v2 = p1:GetType(p2.Class.Name)
	local v3 = if v2 then v2:GetStack(p2:StackKey()) else v2

	if v3 then
		v3:Each(function(p1) --[[ Line: 375 | Upvalues: p3 (copy), p2 (copy), v1 (ref) ]]
			if not (p3 or p1:IsLikeExact(p2)) then
				return
			end

			v1 = v1 + p1:GetAmount()
		end)
	end

	return v1
end
function t.CountExact(p1, p2) --[[ CountExact | Line: 384 ]]
	return CountGeneric(p1, p2, false)
end
function t.CountAny(p1, p2) --[[ CountAny | Line: 388 ]]
	return CountGeneric(p1, p2, true)
end
function FindGeneric(p1, p2, p3) --[[ FindGeneric | Line: 392 | Upvalues: AbstractItem (copy) ]]
	AbstractItem:Assert(p2)

	local t = {}
	local v1 = p1:GetType(p2.Class.Name)
	local v2 = if v1 then v1:GetStack(p2:StackKey()) else v1

	if v2 then
		v2:Each(function(p1) --[[ Line: 398 | Upvalues: p3 (copy), p2 (copy), t (copy) ]]
			if not (p3 or p1:IsLikeExact(p2)) then
				return
			end

			table.insert(t, p1)
		end)
	end

	return t
end
function t.FindExact(p1, p2) --[[ FindExact | Line: 407 ]]
	return FindGeneric(p1, p2, false)
end
function t.FindAny(p1, p2) --[[ FindAny | Line: 411 ]]
	return FindGeneric(p1, p2, true)
end

return t