-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.FreeGifts)

local t = {}
local t2 = {
	Id = "",
	TemplateId = "LuckyBlock",
	Category = "Limited Block"
}
local t3 = {
	Id = "",
	TemplateId = "RandomCurrentSpeedPowerOrCurrentStepMoney",
	SpeedPowerPercent = 0.03,
	MoneySeconds = 60,
	CurrencyId = "Money"
}
local t4 = {
	Id = "",
	TemplateId = "RandomCurrentSpeedPowerOrCurrentStepMoney",
	SpeedPowerPercent = 0.04,
	MoneySeconds = 75,
	CurrencyId = "Money"
}
local t5 = {
	Id = "",
	TemplateId = "RandomCurrentSpeedPowerOrCurrentStepMoney",
	SpeedPowerPercent = 0.05,
	MoneySeconds = 90,
	CurrencyId = "Money"
}

local function cloneAssetRewardWithId(p1, p2) --[[ cloneAssetRewardWithId | Line: 45 ]]
	local v1 = table.clone(p1)

	v1.Id = p2

	return v1
end

local function cloneRandomRewardWithId(p1, p2) --[[ cloneRandomRewardWithId | Line: 51 ]]
	local v1 = table.clone(p1)

	v1.Id = p2

	return v1
end

function t.CloneCurrentSpeedPowerOrCurrentStepMoneyReward(p1) --[[ CloneCurrentSpeedPowerOrCurrentStepMoneyReward | Line: 60 | Upvalues: t3 (copy) ]]
	local v2 = table.clone(t3)

	v2.Id = p1

	return v2
end
function t.CloneEpicCurrentSpeedPowerOrCurrentStepMoneyReward(p1) --[[ CloneEpicCurrentSpeedPowerOrCurrentStepMoneyReward | Line: 66 | Upvalues: t4 (copy) ]]
	local v2 = table.clone(t4)

	v2.Id = p1

	return v2
end
function t.CloneLegendaryCurrentSpeedPowerOrCurrentStepMoneyReward(p1) --[[ CloneLegendaryCurrentSpeedPowerOrCurrentStepMoneyReward | Line: 72 | Upvalues: t5 (copy) ]]
	local v2 = table.clone(t5)

	v2.Id = p1

	return v2
end
function t.CloneLimitedBlock(p1) --[[ CloneLimitedBlock | Line: 78 | Upvalues: t2 (copy) ]]
	local v2 = table.clone(t2)

	v2.Id = p1

	return v2
end

return t