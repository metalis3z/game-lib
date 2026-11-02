-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Products, time of decompilation: Sun May  3 10:12:05 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckLadderServiceUtils = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceUtils)

require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

local t1 = {
	doubleRoll = {
		id = 1786977228,
		giftId = 3571971085,
		isPass = true
	},
	moreDrops = {
		id = 1788427830,
		giftId = 3571971006,
		isPass = true
	},
	autoCollect = {
		id = 1790666518,
		giftId = 3571970941,
		isPass = true
	},
	fastRoll = {
		id = 1790147513,
		giftId = 3571970892,
		isPass = true
	},
	vip = {
		id = 1789471691,
		giftId = 3571970809,
		isPass = true
	},
	extraEquip = {
		id = 1787010888,
		giftId = 3571970753,
		isPass = true
	},
	luckyRolls = {
		id = 1790207602,
		giftId = 3571970645,
		isPass = true
	},
	coinBoost = {
		id = 3572152265,
		giftId = 3572152323,
		isPass = false
	},
	luckBoost = {
		id = 3572151839,
		giftId = 3572151888,
		isPass = false
	},
	ultraLuckBoost = {
		id = 3572151954,
		giftId = 3572152012,
		isPass = false
	},
	rollSpeedBoost = {
		id = 3572152146,
		giftId = 3572152203,
		isPass = false
	},
	coinsSmall = {
		id = 3572159781,
		giftId = 3572159827,
		isPass = false
	},
	coinsMedium = {
		id = 3572159973,
		giftId = 3572160018,
		isPass = false
	},
	coinsLarge = {
		id = 3572160095,
		giftId = 3572160142,
		isPass = false
	},
	jackpotSpinSingle = {
		id = 3572176764,
		giftId = 3572512789,
		isPass = false,
		random = true
	},
	jackpotSpinBundle = {
		id = 3572176831,
		giftId = 3572512863,
		isPass = false,
		random = true
	},
	jackpotSpinCrate = {
		id = 3572176895,
		giftId = 3572512939,
		isPass = false,
		random = true
	},
	foodSnack = {
		id = 3572537916,
		giftId = 3572541392,
		isPass = false
	},
	foodMeal = {
		id = 3572537965,
		giftId = 3572541477,
		isPass = false
	},
	foodFeast = {
		id = 3572538010,
		giftId = 3572541523,
		isPass = false
	},
	starterPack = {
		id = 3572566312,
		isPass = false,
		oneTimePurchase = true
	}
}
local t2 = {
	[2] = 3572064707,
	[4] = 3572064914,
	[8] = 3572064967,
	[16] = 3572065044,
	[32] = 3572065323,
	[64] = 3572065426,
	[128] = 3572065656,
	[256] = 3572065832,
	[512] = 3572066033,
	[1024] = 3572066153,
	[2048] = 3572066283,
	[4096] = 3579155306,
	[8192] = 3579155597,
	[16384] = 3579155739
}

for _, v6 in LuckLadderServiceUtils.getPurchasableMultipliers() do
	t1[LuckLadderServiceUtils.getProductKey(v6)] = {
		id = t2[v6]
	}
end

return t1
