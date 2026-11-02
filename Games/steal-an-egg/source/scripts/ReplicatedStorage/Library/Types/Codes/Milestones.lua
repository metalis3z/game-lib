-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("ReplicatedStorage")

local t = {}
local t2 = {}
local t3 = {}
local v1 = 0
local v2 = 0
local t4 = {}

local function createMilestone(p1, p2) --[[ createMilestone | Line: 43 ]]
	local v2 = math.max(1, (math.floor(p1)))
	local v4 = math.max(0, (math.floor(p2)))
	local v5 = ("free%*"):format(v2)

	return {
		RewardLuckyBlockId = "",
		Id = ("like_code_%*"):format(v2),
		Code = v5,
		CodeNumber = v2,
		LikesRequired = v4
	}
end

local function generateNextMilestone() --[[ generateNextMilestone | Line: 57 | Upvalues: v1 (ref), v2 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	local v12 = v1 + 1
	local v3 = createMilestone(v12, if v12 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

	table.insert(t, v3)
	t2[v3.Id] = v3
	t3[v3.Code] = v3
	v1 = v3.CodeNumber
	v2 = v3.LikesRequired

	return v3
end

local function ensureGeneratedForCodeNumber(p1) --[[ ensureGeneratedForCodeNumber | Line: 74 | Upvalues: v1 (ref), v2 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	while v1 < math.max(0, (math.floor(p1))) do
		local v3 = v1 + 1
		local v5 = createMilestone(v3, if v3 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v5)
		t2[v5.Id] = v5
		t3[v5.Code] = v5
		v1 = v5.CodeNumber
		v2 = v5.LikesRequired
	end
end

local function ensureGeneratedForLikes(p1) --[[ ensureGeneratedForLikes | Line: 81 | Upvalues: v2 (ref), v1 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	while v2 <= math.max(0, (math.floor(p1))) do
		local v3 = v1 + 1
		local v5 = createMilestone(v3, if v3 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v5)
		t2[v5.Id] = v5
		t3[v5.Code] = v5
		v1 = v5.CodeNumber
		v2 = v5.LikesRequired
	end
end

t4.CODE_PREFIX = "free"
t4.REWARD_LUCKY_BLOCK_ID = ""
function t4.GetLikesSeparationForLikes(p1) --[[ GetLikesSeparationForLikes | Line: 92 ]]
	return math.max(500, (math.floor(math.sqrt((math.max(0, (math.floor(p1))))) * 10.60639937944559 + 0.5)))
end
function t4.GetAllGeneratedMilestones() --[[ GetAllGeneratedMilestones | Line: 99 | Upvalues: v1 (ref), v2 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	if not (v1 <= 0) then
		return t
	end

	while v1 < 1 do
		local v12 = v1 + 1
		local v3 = createMilestone(v12, if v12 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v3)
		t2[v3.Id] = v3
		t3[v3.Code] = v3
		v1 = v3.CodeNumber
		v2 = v3.LikesRequired
	end

	return t
end
function t4.GetMilestoneById(p1) --[[ GetMilestoneById | Line: 107 | Upvalues: t2 (copy) ]]
	return t2[p1]
end
function t4.GetMilestoneByCode(p1) --[[ GetMilestoneByCode | Line: 111 | Upvalues: t3 (copy), v1 (ref), v2 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy) ]]
	local v12 = string.lower(p1)
	local v22 = t3[v12]

	if v22 ~= nil then
		return v22
	end

	local v4 = tonumber((string.sub(v12, 5)))

	if v4 == nil then
		return nil
	end

	local v5 = math.floor(v4)

	if string.sub(v12, 1, 4) ~= "free" or v5 <= 0 then
		return nil
	end

	while v1 < math.max(0, (math.floor(v5))) do
		local v8 = v1 + 1
		local v10 = createMilestone(v8, if v8 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v10)
		t2[v10.Id] = v10
		t3[v10.Code] = v10
		v1 = v10.CodeNumber
		v2 = v10.LikesRequired
	end

	return t3[v12]
end
function t4.GetMilestoneByCodeNumber(p1) --[[ GetMilestoneByCodeNumber | Line: 132 | Upvalues: v1 (ref), v2 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	local v12 = math.floor(p1)

	if v12 <= 0 then
		return nil
	end

	while v1 < math.max(0, (math.floor(v12))) do
		local v4 = v1 + 1
		local v6 = createMilestone(v4, if v4 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v6)
		t2[v6.Id] = v6
		t3[v6.Code] = v6
		v1 = v6.CodeNumber
		v2 = v6.LikesRequired
	end

	return t[v12]
end
function t4.GetCurrentMilestoneFromLikes(p1) --[[ GetCurrentMilestoneFromLikes | Line: 142 | Upvalues: v2 (ref), v1 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	local v22 = math.max(0, (math.floor(p1)))

	while v2 <= math.max(0, (math.floor(v22))) do
		local v5 = v1 + 1
		local v7 = createMilestone(v5, if v5 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v7)
		t2[v7.Id] = v7
		t3[v7.Code] = v7
		v1 = v7.CodeNumber
		v2 = v7.LikesRequired
	end

	for i = #t, 1, -1 do
		local v9 = t[i]

		if v9.LikesRequired <= v22 then
			return v9
		end
	end

	return nil
end
function t4.GetNextMilestoneFromLikes(p1) --[[ GetNextMilestoneFromLikes | Line: 156 | Upvalues: v2 (ref), v1 (ref), t4 (copy), createMilestone (copy), t (copy), t2 (copy), t3 (copy) ]]
	local v22 = math.max(0, (math.floor(p1)))

	while v2 <= math.max(0, (math.floor(v22))) do
		local v5 = v1 + 1
		local v7 = createMilestone(v5, if v5 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

		table.insert(t, v7)
		t2[v7.Id] = v7
		t3[v7.Code] = v7
		v1 = v7.CodeNumber
		v2 = v7.LikesRequired
	end

	for i, v in ipairs(t) do
		if v22 < v.LikesRequired then
			return v
		end
	end

	local v9 = v1 + 1
	local v11 = createMilestone(v9, if v9 == 1 then 0 else v2 + t4.GetLikesSeparationForLikes(v2))

	table.insert(t, v11)
	t2[v11.Id] = v11
	t3[v11.Code] = v11
	v1 = v11.CodeNumber
	v2 = v11.LikesRequired

	return v11
end

return t4