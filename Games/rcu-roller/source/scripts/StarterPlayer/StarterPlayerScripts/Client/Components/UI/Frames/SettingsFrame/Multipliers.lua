-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:05
-- Luau version 6, Types version 3
-- Time taken: 0.001610 seconds

local Functions_upvr = require(game:GetService("ReplicatedStorage").Shared.Functions)
local Values_upvr = require(game:GetService("ReplicatedStorage").Shared.Values)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
return {
	clicksMultiplier = function(arg1) -- Line 7, Named "clicksMultiplier"
		--[[ Upvalues[3]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: Functions_upvr (readonly)
		]]
		local any_clicks_result1 = Values_upvr.clicks(LocalPlayer_upvr, arg1, {
			ignorePetMultiplier = true;
		})
		return `{Functions_upvr.suffixes(any_clicks_result1 * 100)}% (x{Functions_upvr.suffixes(any_clicks_result1)})`
	end;
	rebirthsMultiplier = function(arg1) -- Line 13, Named "rebirthsMultiplier"
		--[[ Upvalues[3]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: Functions_upvr (readonly)
		]]
		local any_rebirths_result1 = Values_upvr.rebirths(LocalPlayer_upvr, arg1)
		return `{Functions_upvr.suffixes(any_rebirths_result1 * 100)}% (x{Functions_upvr.suffixes(any_rebirths_result1)})`
	end;
	gemsMultiplier = function(arg1) -- Line 17, Named "gemsMultiplier"
		--[[ Upvalues[3]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: Functions_upvr (readonly)
		]]
		local any_gems_result1 = Values_upvr.gems(LocalPlayer_upvr, arg1)
		return `{Functions_upvr.suffixes(any_gems_result1 * 100)}% (x{Functions_upvr.suffixes(any_gems_result1)})`
	end;
	luckMultiplier = function(arg1) -- Line 21, Named "luckMultiplier"
		--[[ Upvalues[3]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: Functions_upvr (readonly)
		]]
		local any_luck_result1 = Values_upvr.luck(LocalPlayer_upvr, arg1)
		return `{Functions_upvr.suffixes(any_luck_result1 * 100)}% (x{Functions_upvr.suffixes(any_luck_result1)})`
	end;
	hatchingSpeed = function(arg1) -- Line 25, Named "hatchingSpeed"
		--[[ Upvalues[3]:
			[1]: Functions_upvr (readonly)
			[2]: Values_upvr (readonly)
			[3]: LocalPlayer_upvr (readonly)
		]]
		return `{Functions_upvr.floatingPoint(4.11 / Values_upvr.hatchSpeed(LocalPlayer_upvr, arg1))}s`
	end;
	petEquip = function(arg1) -- Line 28, Named "petEquip"
		--[[ Upvalues[2]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
		]]
		return `{Values_upvr.petsEquipped(LocalPlayer_upvr, arg1)}`
	end;
	goldenPets = function(arg1) -- Line 31, Named "goldenPets"
		--[[ Upvalues[2]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
		]]
		return `{Values_upvr.goldenPetsLuck(LocalPlayer_upvr, arg1)}%`
	end;
	toxicPets = function(arg1) -- Line 34, Named "toxicPets"
		--[[ Upvalues[2]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
		]]
		return `{Values_upvr.toxicPetsLuck(LocalPlayer_upvr, arg1)}%`
	end;
	shinyPets = function(arg1) -- Line 37, Named "shinyPets"
		--[[ Upvalues[2]:
			[1]: Values_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
		]]
		return `{Values_upvr.shinyPetsLuck(LocalPlayer_upvr, arg1)}%`
	end;
}