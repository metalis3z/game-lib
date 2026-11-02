-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)

local Currency = require(ReplicatedStorage.Library.Types.Currency)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}
local t3 = {
	Easy = {
		Icon = "rbxassetid://74160368106752",
		Rolls = 1,
		Scale = 0.83,
		Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 131, 131)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 49, 49)) })
	},
	Medium = {
		Icon = "rbxassetid://130331699933836",
		Rolls = 2,
		Scale = 0.94,
		Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 246, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 169, 64)) })
	},
	Hard = {
		Icon = "rbxassetid://139767177148368",
		Rolls = 3,
		Scale = 0.94,
		Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 134, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 52, 255)) })
	},
	Impossible = {
		Icon = "rbxassetid://126777374447687",
		Rolls = 3,
		Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 134, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 52, 255)) })
	}
}

t2.REFRESH_INTERVAL = 86400
t2.RESET_UTC_HOUR = 23
t2.TypeData = t3
function t2.GetResetPeriodIndex(p1) --[[ GetResetPeriodIndex | Line: 77 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return math.floor((math.max(p1, 0) - 82800) / 86400)
end
function t2.GetNextResetAt(p1) --[[ GetNextResetAt | Line: 82 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.number(p1)

	return (t2.GetResetPeriodIndex(p1) + 1) * 86400 + 82800
end
function t2.GetTimeLeftUntilReset(p1) --[[ GetTimeLeftUntilReset | Line: 87 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.number(p1)

	return math.max(0, t2.GetNextResetAt(p1) - p1)
end

for k, v in pairs(t2.TypeData) do
	v.Name = k
end

local t4 = {}

t2.SchemaValidation = t4
t4.TypeData = t.interface({
	Icon = t.string,
	Gradient = t.ColorSequence,
	Rolls = t.number,
	Scale = t.optional(t.number),
	Name = t.optional(t.string)
})
t4.AllDifficulties = t.union(t.literal("Easy"), t.literal("Medium"), t.literal("Hard"), t.literal("Impossible"))
t4.LuckyBlockReward = t.interface({
	Id = t.string,
	TemplateId = t.literal("LuckyBlock"),
	Category = t.string
})
t4.RandomCurrentSpeedPowerOrCurrentStepMoneyReward = t.interface({
	Id = t.string,
	TemplateId = t.literal("RandomCurrentSpeedPowerOrCurrentStepMoney"),
	SpeedPowerPercent = t.number,
	MoneySeconds = t.number,
	CurrencyId = Currency.SchemaValidation.AllCurrencyTypes
})
t4.RewardConfig = t.union(t4.LuckyBlockReward, t4.RandomCurrentSpeedPowerOrCurrentStepMoneyReward)
t4.RedeemPresentation = t.interface({
	RewardId = t.string,
	MoneyNotificationAmount = t.optional(t.number),
	SpeedPowerNotificationAmount = t.optional(t.number)
})
t4.RedeemPayload = t.interface({
	GiftId = t.number,
	Rewards = t.array(t4.RedeemPresentation)
})

return t2