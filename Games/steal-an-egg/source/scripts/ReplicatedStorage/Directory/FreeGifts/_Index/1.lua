-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Default = require(script.Parent.Parent.BaseConfigs.Default)
local RewardTemplates = require(script.Parent.Parent.BaseConfigs.RewardTemplates)

require(script.Parent.Parent.Types.Interface)

return setmetatable({
	Id = 1,
	Type = "Easy",
	WaitTime = 30,
	Rewards = { RewardTemplates.CloneCurrentSpeedPowerOrCurrentStepMoneyReward(script.Name) }
}, {
	__index = Default
})