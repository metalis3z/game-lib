-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Milestones = require(script.Milestones)
local t2 = {
	CODE_PREFIX = Milestones.CODE_PREFIX,
	REWARD_LUCKY_BLOCK_ID = Milestones.REWARD_LUCKY_BLOCK_ID,
	SchemaValidation = {
		LikeCodeMilestone = t.interface({
			Id = t.string,
			Code = t.string,
			CodeNumber = t.number,
			LikesRequired = t.number,
			RewardLuckyBlockId = t.string
		}),
		LikeCodeState = t.interface({
			CurrentLikes = t.number,
			CurrentMilestoneId = t.optional(t.string),
			CurrentCodeNumber = t.number,
			CurrentCode = t.optional(t.string),
			ProgressLikes = t.number,
			ProgressTargetLikes = t.number,
			ProgressRatio = t.number,
			NextMilestoneId = t.optional(t.string),
			NextCodeNumber = t.number,
			NextCode = t.optional(t.string),
			NextCodeLikesRequired = t.optional(t.number)
		})
	}
}

function t2.GetCodeFromNumber(p1) --[[ GetCodeFromNumber | Line: 63 | Upvalues: t2 (copy) ]]
	local v1 = math.floor(p1)

	if v1 <= 0 then
		return nil
	end

	return ("%*%*"):format(t2.CODE_PREFIX, v1)
end
function t2.GetMilestones() --[[ GetMilestones | Line: 72 | Upvalues: Milestones (copy) ]]
	return Milestones.GetAllGeneratedMilestones()
end
function t2.GetMilestoneById(p1) --[[ GetMilestoneById | Line: 76 | Upvalues: Milestones (copy) ]]
	return Milestones.GetMilestoneById(p1)
end
function t2.GetMilestoneByCode(p1) --[[ GetMilestoneByCode | Line: 80 | Upvalues: Milestones (copy) ]]
	return Milestones.GetMilestoneByCode(p1)
end
function t2.GetCurrentMilestoneFromLikes(p1) --[[ GetCurrentMilestoneFromLikes | Line: 84 | Upvalues: Milestones (copy) ]]
	return Milestones.GetCurrentMilestoneFromLikes(p1)
end
function t2.GetNextMilestoneFromLikes(p1) --[[ GetNextMilestoneFromLikes | Line: 88 | Upvalues: Milestones (copy) ]]
	return Milestones.GetNextMilestoneFromLikes(p1)
end
function t2.HasClaimedMilestone(p1, p2) --[[ HasClaimedMilestone | Line: 92 ]]
	return if p1 == nil then false else p1[p2.Id] == true
end
function t2.GetStateFromLikes(p1) --[[ GetStateFromLikes | Line: 99 | Upvalues: t2 (copy) ]]
	local v2 = math.max(0, (math.floor(p1)))
	local v3 = t2.GetCurrentMilestoneFromLikes(v2)
	local v4 = t2.GetNextMilestoneFromLikes(v2)
	local v5 = if v3 then v3.LikesRequired else 0
	local v7 = math.max(1, (if v4 then v4.LikesRequired else v5) - v5)
	local v8 = math.clamp(v2 - v5, 0, v7)
	local v9 = math.clamp(v8 / v7, 0, 1)
	local t = {
		CurrentLikes = v2
	}

	t.CurrentMilestoneId = if v3 then v3.Id else nil
	t.CurrentCodeNumber = if v3 then v3.CodeNumber else 0
	t.CurrentCode = if v3 then v3.Code else nil
	t.ProgressLikes = v8
	t.ProgressTargetLikes = v7
	t.ProgressRatio = v9
	t.NextMilestoneId = if v4 then v4.Id else nil
	t.NextCodeNumber = if v4 then v4.CodeNumber else 0
	t.NextCode = if v4 then v4.Code else nil
	t.NextCodeLikesRequired = if v4 then v4.LikesRequired else nil

	return t
end

if Constants.IS_STUDIO then
	assert(t2.GetCodeFromNumber(1) == "free1", "Like code prefix generation is invalid")
	assert(if Milestones.GetLikesSeparationForLikes(248) == 500 then true else false, "Like code base separation is invalid")
	assert(if Milestones.GetLikesSeparationForLikes(8968237) == 31763 then true else false, "Like code curve separation is invalid")

	local v4 = t2.GetMilestones()

	assert(if v4[1] == nil or v4[1].Id ~= "like_code_1" then false elseif v4[1].LikesRequired == 0 then true else false, "First like milestone is invalid")
	assert(if t2.GetMilestoneByCode("FREE3") == nil then false else true, "Like milestone code lookup is invalid")
	assert(if t2.GetStateFromLikes(0).CurrentCode == "free1" then true else false, "Initial like code state is invalid")

	local v8, v9 = t2.SchemaValidation.LikeCodeMilestone(v4[1])

	assert(v8, (("Like code milestone validation failed: %*"):format(v9)))

	local v11, v12 = t2.SchemaValidation.LikeCodeState(t2.GetStateFromLikes(2345))

	assert(v11, (("Like code state validation failed: %*"):format(v12)))
end

return t2