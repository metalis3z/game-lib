-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Default = require(script.Parent.Parent.BaseConfigs.Default)
local RewardTemplates = require(script.Parent.Parent.BaseConfigs.RewardTemplates)

require(script.Parent.Parent.Types.Interface)

return setmetatable({
	Id = 2,
	Type = "Easy",
	WaitTime = 600,
	Rewards = { RewardTemplates.CloneCurrentSpeedPowerOrCurrentStepMoneyReward(script.Name) }
}, {
	__index = Default
})