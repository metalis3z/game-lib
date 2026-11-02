

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Synchronizer = require(Packages.Synchronizer)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Index = require(ReplicatedStorage.Datas.Index)
local Updates = require(ReplicatedStorage.Shared.Updates)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Animals = require(Datas.Animals)
local t1 = {}

local function getLimitedTime(s1: string)
	local v15 = Index[s1]

	return FFlags:GetInstant(`{ s1 }Timer`, v15 and v15.LimitedMutation)
end
local function isLimitedEventIndexExpired(s2: string)
	local v17 = Index[s2]

	if not v17 or v17.IsMutation then
		return false
	end

	local v18 = Index[s2]
	local Instant = FFlags:GetInstant(`{ s2 }Timer`, v18 and v18.LimitedMutation)

	if not Instant then
		return false
	end

	return Instant < workspace:GetServerTimeNow()
end
local function shouldUseExplicitIndexKey(s3: string, p1)
	local v22 = Index[s3]
	local v23 = false

	if v22 ~= nil then
		v23 = false

		if v22.CountAllMutations == true then
			local v24 = Index[s3]

			if not v24 or v24.IsMutation then
				v23 = false
			else
				local v25 = Index[s3]
				local Instant = FFlags:GetInstant(`{ s3 }Timer`, v25 and v25.LimitedMutation)

				v23 = if Instant then Instant < workspace:GetServerTimeNow() else false
			end

			if v23 then
				v23 = p1:Get("Migrations.LimitedIndexProgress_v1") == true
			end
		end
	end

	return v23
end

function t1.GetIndexLimitedTime(_: {[any]: any}, s4: string)
	return getLimitedTime(s4)
end
function t1.CanShowInIndex(_: {[any]: any}, s5: string)
	local v31 = Animals[s5]

	if not v31 then
		return false
	end

	if v31.IsEnabled and not v31.IsEnabled() then
		return false
	end

	if v31.HideFromIndex then
		return false
	end

	return true
end
function t1.CanProgressIndex(_: {[any]: any}, s6: string)
	local v34 = Index[s6]
	local v35

	if not v34 or v34.IsMutation then
		v35 = false
	else
		local v36 = Index[s6]
		local Instant = FFlags:GetInstant(`{ s6 }Timer`, v36 and v36.LimitedMutation)

		v35 = if Instant then Instant < workspace:GetServerTimeNow() else false
	end

	return not v35
end

local t5 = {
	Strawberry = "Strawberry Elephant",
	Meowl = "Meowl",
	Skibidi = "Skibidi Toilet",
	Headless = "Headless Horseman",
	["John Pork"] = "John Pork",
	Spyder = "Spyder Elephant"
}

function t1.IsComplete(_: {[any]: any}, p2, s7: string?)
	local v41 = Synchronizer:Get(p2)

	if not v41 then
		return false
	end

	local v42 = t5[s7]

	if v42 ~= nil then
		for _, v44 in v41:Get("AnimalPodiums") do
			if typeof(v44) == "table" and v42 == v44.Index then
				return true
			end
		end

		return false
	end

	local v45 = v41:Get("Index")
	local n1 = 0
	local n2 = 0
	local v48 = s7 and Index[s7]

	if v48 and v48.DisableIndex then
		return false
	end

	if v48 and v48.Update and not Updates.Methods.IsEnabled(v48.Update) then
		return false
	end

	local v49 = v48 and v48.Index

	if v49 then
		local v50 = Index[s7]
		local v51 = false

		if v50 ~= nil then
			v51 = false

			if v50.CountAllMutations == true then
				local v52 = Index[s7]

				if not v52 or v52.IsMutation then
					v51 = false
				else
					local v53 = Index[s7]
					local Instant = FFlags:GetInstant(`{ s7 }Timer`, v53 and v53.LimitedMutation)

					v51 = if Instant then Instant < workspace:GetServerTimeNow() else false
				end

				if v51 then
					v51 = v41:Get("Migrations.LimitedIndexProgress_v1") == true
				end
			end
		end

		for v55, v56 in v49 do
			if not v56.IgnoreIndexCounter then
				n2 += 1
			end

			local v57 = v45[v55]

			if v57 and if not v48 or not v48.CustomIndex then if not v51 then if not v48 or v48.IsMutation then v57[s7] else next(v57) ~= nil else v57[s7] else v57[v48.CustomIndex.Name] then
				n1 += 1
			end
		end

		local v58 = v48 and v48.CompletitionPercent or (s7 ~= "Default" and 1 or 0.75)

		if v58 ~= 1 then
			n2 = math.max(math.ceil(n2 * v58), 1)

			if v48 and v48.CompletitionForcedAmount then
				n2 = v48.CompletitionForcedAmount
			end
		end

		return n2 <= n1
	end

	for v59 in Animals do
		if t1:CanShowInIndex(v59) then
			n2 += 1

			local v60 = v45[v59]

			if v60 and v60[s7 and s7 or "Default"] then
				n1 += 1
			end
		end
	end

	local v61 = v48 and v48.CompletitionPercent or (s7 ~= "Default" and 1 or 0.75)

	if v61 ~= 1 then
		n2 = math.max(math.ceil(n2 * v61), 1)

		if v48 and v48.CompletitionForcedAmount then
			n2 = v48.CompletitionForcedAmount
		end
	end

	return n2 <= n1
end
function t1.GetIndexAnimals(_: {[any]: any}, p3, s8: string?)
	local v65 = Synchronizer:Get(p3)

	if not v65 then
		return nil
	end

	local v66 = v65:Get("Index")
	local v67 = s8 and Index[s8]
	local v68 = v67 and v67.Index

	if v68 then
		local n3 = 0
		local n4 = 0
		local n5 = 0
		local v72 = Index[s8]
		local v73 = false

		if v72 ~= nil then
			v73 = false

			if v72.CountAllMutations == true then
				local v74 = Index[s8]

				if not v74 or v74.IsMutation then
					v73 = false
				else
					local v75 = Index[s8]
					local Instant = FFlags:GetInstant(`{ s8 }Timer`, v75 and v75.LimitedMutation)

					v73 = if Instant then Instant < workspace:GetServerTimeNow() else false
				end

				if v73 then
					v73 = v65:Get("Migrations.LimitedIndexProgress_v1") == true
				end
			end
		end

		for v77, v78 in v68 do
			n5 += 1

			if not v78.IgnoreIndexCounter then
				n4 += 1
			end

			local v79 = v66[v77]

			if v79 and if not v67 or not v67.CustomIndex then if not v73 then if not v67 or v67.IsMutation then v79[s8] else next(v79) ~= nil else v79[s8] else v79[v67.CustomIndex.Name] then
				n3 += 1
			end
		end

		local v80 = v67 and v67.CompletitionPercent or (s8 ~= "Default" and 1 or 0.75)

		if v80 ~= 1 then
			n4 = math.max(math.ceil(n4 * v80), 1)

			if v67 and v67.CompletitionForcedAmount then
				n4 = v67.CompletitionForcedAmount
			end
		end

		return n3, n4, n5
	end

	local n6 = 0
	local n7 = 0
	local n8 = 0

	for v84, _ in Animals do
		if t1:CanShowInIndex(v84) then
			n8 += 1
			n7 += 1

			local v86 = v66[v84]

			if v86 then
				local v87 = v86[s8 and s8 or "Default"]

				if v87 and not (v87 <= 0) then
					n6 += 1
				end
			end
		end
	end

	local v88 = v67 and v67.CompletitionPercent or (s8 ~= "Default" and 1 or 0.75)

	if v88 ~= 1 then
		n7 = math.max(math.ceil(n7 * v88), 1)

		if v67 and v67.CompletitionForcedAmount then
			n7 = v67.CompletitionForcedAmount
		end
	end

	return n6, n7, n8
end
function t1.GetMultipliers(_: {[any]: any}, p4)
	local n9 = 0

	if Synchronizer:Get(p4) then
		local v92 = 0 + (t1:IsComplete(p4) ~= true and 0 or 1)

		for v93, v94 in Index do
			if not v94.LimitedMutation and v94.IsMutation then
				v92 += t1:IsComplete(p4, v93) ~= true and 0 or 1
			end
		end

		n9 += v92 * 0.5
	end

	return n9
end

return t1
