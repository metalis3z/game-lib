-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types.Interface)

return {
	Type = "Easy",
	Rewards = { require(script.Parent.Parent.BaseConfigs.RewardTemplates).CloneCurrentSpeedPowerOrCurrentStepMoneyReward(script.Name) }
}