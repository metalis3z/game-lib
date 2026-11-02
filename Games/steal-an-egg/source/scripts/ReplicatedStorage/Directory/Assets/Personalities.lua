-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LotteryCustom = require(ReplicatedStorage.Library.Functions.LotteryCustom)

require(script.Parent.Types.Personality)
require(ReplicatedStorage.Library.Types.AssetItem)

local DeepFreezeUnsafe = require(ReplicatedStorage.Library.Functions.DeepFreezeUnsafe)
local v1 = table.freeze({
	Normal = "Normal",
	Lazy = "Lazy",
	Loyal = "Loyal",
	Energetic = "Energetic",
	InvertedModel = "InvertedModel",
	Shy = "Shy",
	Scared = "Scared",
	ExtremelyEnergetic = "ExtremelyEnergetic",
	UltraLoyal = "UltraLoyal",
	JumpCrazy = "JumpCrazy"
})
local t = {
	RollWeight = 12,
	_id = v1.Energetic,
	Movement = {
		WalkSpeedMin = 9,
		WalkSpeedMax = 20,
		IdleSecondsMin = 0.1,
		IdleSecondsMax = 0.75,
		NearOwnerPreference = 0.2,
		IsolationPreference = 0,
		CurvedWanderChance = 0.62,
		BurstChance = 0.42,
		FollowOwnerInPen = false,
		AmbientJumpRatePerSecond = 0,
		AmbientSpinJumpChance = 0
	},
	Greeting = {
		Chance = 1,
		FirstPlacementChance = 1,
		FirstPlacementNormalChance = 0,
		FirstPlacementNormalJumpCount = 4,
		ReturnOrbitChance = 0.6,
		ReturnNormalJumpCount = 3,
		RandomOrbitChance = 0.2,
		RandomOrbitIntervalSeconds = 45,
		DurationSeconds = 6,
		JumpChancePerSecond = 0.85,
		SpinJumpChance = 0.3,
		Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
	},
	Affection = {
		Enabled = true,
		Chance = 0.125,
		IntervalSeconds = 5,
		DurationSeconds = 4.5,
		JumpCount = 5,
		Texts = {
			"\240\159\152\134",
			"\240\159\152\132",
			"\240\159\152\129",
			"\240\159\152\131",
			"\240\159\164\170",
			"\240\159\152\157",
			"\240\159\152\156",
			"\240\159\152\139",
			"\240\159\152\185",
			"\240\159\153\128",
			"\240\159\152\142"
		}
	}
}
local Greeting = t.Greeting
local v2 = DeepFreezeUnsafe({
	Normal = {
		RollWeight = 37,
		_id = v1.Normal,
		Movement = {
			WalkSpeedMin = 6.5,
			WalkSpeedMax = 12,
			IdleSecondsMin = 1.2,
			IdleSecondsMax = 3.2,
			NearOwnerPreference = 0.14,
			IsolationPreference = 0,
			CurvedWanderChance = 0.16,
			BurstChance = 0.035,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 0,
			AmbientSpinJumpChance = 0
		},
		Greeting = {
			Chance = 1,
			FirstPlacementChance = 0,
			FirstPlacementNormalChance = 1,
			FirstPlacementNormalJumpCount = 3,
			ReturnOrbitChance = 0,
			ReturnNormalJumpCount = 2,
			RandomOrbitChance = 0,
			RandomOrbitIntervalSeconds = 45,
			DurationSeconds = 6,
			JumpChancePerSecond = 0.8,
			SpinJumpChance = 0.08,
			Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
		},
		Affection = {
			Enabled = true,
			Chance = 0.16666666666666666,
			IntervalSeconds = 5,
			DurationSeconds = 4,
			JumpCount = 2,
			Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\153\130", "\226\152\186\239\184\143", "\240\159\165\176", "\240\159\152\131", "\240\159\152\129", "\240\159\164\151" }
		}
	},
	Lazy = {
		RollWeight = 15,
		_id = v1.Lazy,
		Movement = {
			WalkSpeedMin = 2.5,
			WalkSpeedMax = 3.75,
			IdleSecondsMin = 6,
			IdleSecondsMax = 15,
			NearOwnerPreference = 0.025,
			IsolationPreference = 0.08,
			CurvedWanderChance = 0.025,
			BurstChance = 0,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 0,
			AmbientSpinJumpChance = 0
		},
		Greeting = {
			Chance = 0,
			FirstPlacementChance = 0,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 0,
			ReturnOrbitChance = 0,
			ReturnNormalJumpCount = 1,
			RandomOrbitChance = 0,
			RandomOrbitIntervalSeconds = 60,
			DurationSeconds = 3.5,
			JumpChancePerSecond = 0.08,
			SpinJumpChance = 0,
			Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
		},
		Affection = {
			Enabled = false,
			Chance = 0,
			IntervalSeconds = 80,
			DurationSeconds = 0,
			JumpCount = 0,
			Texts = { "\240\159\152\180", "\240\159\165\177", "\240\159\152\170", "\240\159\152\140", "\240\159\152\144", "\240\159\152\145", "\240\159\152\182", "\240\159\153\131" }
		}
	},
	Loyal = {
		RollWeight = 10,
		_id = v1.Loyal,
		Movement = {
			WalkSpeedMin = 7.5,
			WalkSpeedMax = 10,
			IdleSecondsMin = 0.35,
			IdleSecondsMax = 1.25,
			NearOwnerPreference = 0.9,
			IsolationPreference = 0,
			CurvedWanderChance = 0.08,
			BurstChance = 0.055,
			FollowOwnerInPen = true,
			AmbientJumpRatePerSecond = 0,
			AmbientSpinJumpChance = 0
		},
		Greeting = {
			Chance = 1,
			FirstPlacementChance = 1,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 3,
			ReturnOrbitChance = 0.45,
			ReturnNormalJumpCount = 2,
			RandomOrbitChance = 0.08,
			RandomOrbitIntervalSeconds = 45,
			DurationSeconds = 6.5,
			JumpChancePerSecond = 0.55,
			SpinJumpChance = 0.06,
			Texts = { "Mama" }
		},
		Affection = {
			Enabled = true,
			Chance = 0.002976190476190476,
			IntervalSeconds = 5,
			DurationSeconds = 5,
			JumpCount = 2,
			Texts = { "\240\159\165\176", "\240\159\152\141", "\240\159\152\138", "\226\152\186\239\184\143", "\240\159\164\151", "\240\159\152\154" }
		}
	},
	Energetic = t,
	InvertedModel = {
		RollWeight = 1.5,
		_id = v1.InvertedModel,
		Movement = t.Movement,
		Greeting = {
			Chance = Greeting.Chance,
			FirstPlacementChance = Greeting.FirstPlacementChance,
			FirstPlacementNormalChance = Greeting.FirstPlacementNormalChance,
			FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount,
			ReturnOrbitChance = Greeting.ReturnOrbitChance,
			ReturnNormalJumpCount = Greeting.ReturnNormalJumpCount,
			RandomOrbitChance = Greeting.RandomOrbitChance,
			RandomOrbitIntervalSeconds = Greeting.RandomOrbitIntervalSeconds,
			DurationSeconds = Greeting.DurationSeconds,
			JumpChancePerSecond = Greeting.JumpChancePerSecond,
			SpinJumpChance = Greeting.SpinJumpChance,
			Texts = {
				"//ERRsORijwoR//",
				"0x?#!@NLL",
				"01011010???",
				"\226\150\147\226\150\146\226\150\145???\226\150\145\226\150\146\226\150\147",
				"M4M4.EXE???",
				"##!%$@//",
				"<???:\'aWsFE>",
				"1010_=249_0101",
				"??//V//#"
			}
		},
		Affection = t.Affection
	},
	Shy = {
		RollWeight = 10,
		_id = v1.Shy,
		Movement = {
			WalkSpeedMin = 3,
			WalkSpeedMax = 5,
			IdleSecondsMin = 5.5,
			IdleSecondsMax = 14,
			NearOwnerPreference = 0,
			IsolationPreference = 0.95,
			CurvedWanderChance = 0.035,
			BurstChance = 0,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 0,
			AmbientSpinJumpChance = 0,
			Retreat = {
				TriggerDistance = 22,
				Chance = 0.85,
				MaxTravelDistance = 16
			}
		},
		Greeting = {
			Chance = 0,
			FirstPlacementChance = 0,
			FirstPlacementBubbleChance = 0,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 0,
			ReturnOrbitChance = 0,
			ReturnNormalJumpCount = 0,
			RandomOrbitChance = 0,
			RandomOrbitIntervalSeconds = 30,
			DurationSeconds = 0,
			JumpChancePerSecond = 0,
			SpinJumpChance = 0,
			Texts = { "\240\159\152\138" }
		},
		Affection = {
			Enabled = false,
			Chance = 0,
			IntervalSeconds = 50,
			DurationSeconds = 0,
			JumpCount = 0,
			Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
		}
	},
	Scared = {
		RollWeight = 5,
		_id = v1.Scared,
		Movement = {
			WalkSpeedMin = 20,
			WalkSpeedMax = 40,
			IdleSecondsMin = 0.8,
			IdleSecondsMax = 4,
			NearOwnerPreference = 0,
			IsolationPreference = 1,
			CurvedWanderChance = 0.03,
			BurstChance = 0,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 0,
			AmbientSpinJumpChance = 0,
			Retreat = {
				TriggerDistance = 20,
				Chance = 1
			},
			IdleTremble = {
				Amplitude = 1.5,
				CyclesPerSecond = 16
			}
		},
		Greeting = {
			Chance = 0,
			FirstPlacementChance = 0,
			FirstPlacementBubbleChance = 1,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 0,
			ReturnOrbitChance = 0,
			ReturnNormalJumpCount = 0,
			RandomOrbitChance = 0,
			RandomOrbitIntervalSeconds = 30,
			DurationSeconds = 0,
			JumpChancePerSecond = 0,
			SpinJumpChance = 0,
			Texts = { "Where is MAMA \240\159\152\176?" }
		},
		Affection = {
			Enabled = false,
			Chance = 0,
			IntervalSeconds = 50,
			DurationSeconds = 0,
			JumpCount = 0,
			Texts = { "\240\159\152\168", "\240\159\152\176" }
		}
	},
	ExtremelyEnergetic = {
		RollWeight = 3.5,
		_id = v1.ExtremelyEnergetic,
		Movement = {
			WalkSpeedMin = 30,
			WalkSpeedMax = 70,
			IdleSecondsMin = 0.05,
			IdleSecondsMax = 0.2,
			NearOwnerPreference = 0.2,
			IsolationPreference = 0,
			CurvedWanderChance = 0.8,
			BurstChance = 0.7,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 3.5,
			AmbientSpinJumpChance = 0.35
		},
		Greeting = {
			Chance = 1,
			FirstPlacementChance = 1,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 5,
			ReturnOrbitChance = 0.75,
			ReturnNormalJumpCount = 5,
			RandomOrbitChance = 0.35,
			RandomOrbitIntervalSeconds = 30,
			DurationSeconds = 6,
			JumpChancePerSecond = 1.8,
			SpinJumpChance = 0.4,
			Texts = { "\240\159\164\169", "\240\159\164\170" }
		},
		Affection = {
			Enabled = true,
			Chance = 0.1,
			IntervalSeconds = 5,
			DurationSeconds = 4.5,
			JumpCount = 7,
			Texts = { "\240\159\164\169", "\240\159\152\134", "\240\159\164\170" }
		}
	},
	UltraLoyal = {
		RollWeight = 2.5,
		_id = v1.UltraLoyal,
		Movement = {
			WalkSpeedMin = 10,
			WalkSpeedMax = 16,
			IdleSecondsMin = 0.1,
			IdleSecondsMax = 0.5,
			NearOwnerPreference = 0.98,
			IsolationPreference = 0,
			CurvedWanderChance = 0.12,
			BurstChance = 0.1,
			FollowOwnerInPen = true,
			AmbientJumpRatePerSecond = 0.35,
			AmbientSpinJumpChance = 0.1
		},
		Greeting = {
			Chance = 1,
			FirstPlacementChance = 1,
			FirstPlacementNormalChance = 0,
			FirstPlacementNormalJumpCount = 4,
			ReturnOrbitChance = 0.9,
			ReturnNormalJumpCount = 3,
			RandomOrbitChance = 0.9,
			RandomOrbitIntervalSeconds = 5,
			DurationSeconds = 6.5,
			JumpChancePerSecond = 0.8,
			SpinJumpChance = 0.1,
			Texts = { "Mama \240\159\164\151", "Mama \240\159\165\176" }
		},
		Affection = {
			Enabled = true,
			Chance = 0.15151515151515152,
			IntervalSeconds = 5,
			DurationSeconds = 5,
			JumpCount = 3,
			Texts = { "\240\159\165\176", "\240\159\164\151" }
		}
	},
	JumpCrazy = {
		RollWeight = 3.5,
		_id = v1.JumpCrazy,
		Movement = {
			WalkSpeedMin = 10,
			WalkSpeedMax = 18,
			IdleSecondsMin = 0.05,
			IdleSecondsMax = 0.3,
			NearOwnerPreference = 0.2,
			IsolationPreference = 0,
			CurvedWanderChance = 0.25,
			BurstChance = 0.1,
			FollowOwnerInPen = false,
			AmbientJumpRatePerSecond = 12,
			AmbientSpinJumpChance = 0.5
		},
		Greeting = {
			Chance = 1,
			FirstPlacementChance = 0,
			FirstPlacementNormalChance = 1,
			FirstPlacementNormalJumpCount = 8,
			ReturnOrbitChance = 0,
			ReturnNormalJumpCount = 7,
			RandomOrbitChance = 0,
			RandomOrbitIntervalSeconds = 30,
			DurationSeconds = 6,
			JumpChancePerSecond = 2,
			SpinJumpChance = 0.5,
			Texts = {
				"\240\159\152\134",
				"\240\159\152\132",
				"\240\159\152\129",
				"\240\159\152\131",
				"\240\159\164\170",
				"\240\159\152\157",
				"\240\159\152\156",
				"\240\159\152\139",
				"\240\159\152\185",
				"\240\159\153\128",
				"\240\159\152\142"
			}
		},
		Affection = {
			Enabled = true,
			Chance = 0.1,
			IntervalSeconds = 5,
			DurationSeconds = 4,
			JumpCount = 8,
			Texts = {
				"\240\159\152\134",
				"\240\159\152\132",
				"\240\159\152\129",
				"\240\159\152\131",
				"\240\159\164\170",
				"\240\159\152\157",
				"\240\159\152\156",
				"\240\159\152\139",
				"\240\159\152\185",
				"\240\159\153\128",
				"\240\159\152\142"
			}
		}
	}
})
local v3 = table.freeze({
	{
		Personality = v1.Normal,
		Weight = v2[v1.Normal].RollWeight
	},
	{
		Personality = v1.Lazy,
		Weight = v2[v1.Lazy].RollWeight
	},
	{
		Personality = v1.Loyal,
		Weight = v2[v1.Loyal].RollWeight
	},
	{
		Personality = v1.Energetic,
		Weight = v2[v1.Energetic].RollWeight
	},
	{
		Personality = v1.InvertedModel,
		Weight = v2[v1.InvertedModel].RollWeight
	},
	{
		Personality = v1.Shy,
		Weight = v2[v1.Shy].RollWeight
	},
	{
		Personality = v1.Scared,
		Weight = v2[v1.Scared].RollWeight
	},
	{
		Personality = v1.ExtremelyEnergetic,
		Weight = v2[v1.ExtremelyEnergetic].RollWeight
	},
	{
		Personality = v1.UltraLoyal,
		Weight = v2[v1.UltraLoyal].RollWeight
	},
	{
		Personality = v1.JumpCrazy,
		Weight = v2[v1.JumpCrazy].RollWeight
	}
})
local v4 = table.freeze({
	{ v1.Normal, v2[v1.Normal].RollWeight },
	{ v1.Lazy, v2[v1.Lazy].RollWeight },
	{ v1.Loyal, v2[v1.Loyal].RollWeight },
	{ v1.Energetic, v2[v1.Energetic].RollWeight },
	{ v1.InvertedModel, v2[v1.InvertedModel].RollWeight },
	{ v1.Shy, v2[v1.Shy].RollWeight },
	{ v1.Scared, v2[v1.Scared].RollWeight },
	{ v1.ExtremelyEnergetic, v2[v1.ExtremelyEnergetic].RollWeight },
	{ v1.UltraLoyal, v2[v1.UltraLoyal].RollWeight },
	{ v1.JumpCrazy, v2[v1.JumpCrazy].RollWeight }
})
local t4 = {
	Personalities = v1,
	Configs = v2,
	RollTable = v3,
	IsPersonality = function(p1) --[[ IsPersonality | Line: 489 | Upvalues: v2 (copy) ]]
		return v2[p1] ~= nil
	end,
	GetConfig = function(p1) --[[ GetConfig | Line: 493 | Upvalues: v2 (copy) ]]
		local v1 = v2[p1]

		assert(v1 ~= nil, (("Unknown asset personality \"%*\""):format(p1)))

		return v1
	end
}

function t4.Roll(p1) --[[ Roll | Line: 499 | Upvalues: LotteryCustom (copy), v4 (copy), t4 (copy) ]]
	local v1 = LotteryCustom(p1, v4)

	assert(if typeof(v1) == "string" then t4.IsPersonality(v1) else false, "Asset personality roll failed")

	return v1
end
function t4.CreateNewItemData(p1, p2, p3) --[[ CreateNewItemData | Line: 505 | Upvalues: t4 (copy) ]]
	local v1 = table.clone(p1)

	v1.Mutations = table.clone(p1.Mutations)

	if p3 == nil then
		v1.Personality = t4.Roll(p2)
	else
		assert(t4.IsPersonality(p3), "Invalid asset personality override")
		v1.Personality = p3
	end

	v1.HasBeenFirstPlaced = false

	return v1
end
function t4.ResetFirstPlacementForTransfer(p1) --[[ ResetFirstPlacementForTransfer | Line: 522 ]]
	local v1 = table.clone(p1)

	v1.Mutations = table.clone(p1.Mutations)
	v1.HasBeenFirstPlaced = false

	return v1
end

return t4