-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local Shared = require('@self/Shared');
local SwingModule = require('@self/Swing');
local ModeSwitchModule = require('@self/ModeSwitch');
local LeapModule = require('@self/Leap');
local GrabModule = require('@self/Grab');
local DrillModule = require('@self/Drill');

-- <- Private Functions -> --
local function GetInformation(Player: Player, CharacterMeta)
	local Character = Player.Character
	local AssetMeta = AbilityUtil.GetAssetMeta(Player);
	if not Character or not AssetMeta or not CharacterMeta or not CharacterMeta.Configuration then
		return
	end

	return Character, CharacterMeta.Configuration, AssetMeta
end

local function EmptyCallback(Player: Player, _, CharacterMeta)
	local Character = Player.Character
	if not Character or not CharacterMeta or not CharacterMeta.Configuration then
		return AbilityUtil.AbilityResult(false);
	end

	Shared.EnsureMode(Character, CharacterMeta.Configuration);
	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end

-- <- Return -> --
return {
	Abilities = {
		['Swing'] = {
			KeybindDisplay = 'M1',
			Cooldown = 3,
			Callback = function(Player, _, CharacterMeta)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

				return SwingModule.Use(Character, Configuration, AssetMeta);
			end,
		},
		['Mode Switch'] = {
			KeybindDisplay = 'Q',
			Cooldown = 5,
			Callback = function(Player, _, CharacterMeta, RequestedMode)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

				return ModeSwitchModule.Use(Player, Character, Configuration, AssetMeta, CharacterMeta, RequestedMode);
			end,
		},
		['Mode: Strength'] = {
			KeybindDisplay = 'E',
			Variants = {
				['HiddenStrength'] = {
					Attributes = {
						'MimicStrength',
					},
					TurnInvisible = true,
					Callback = EmptyCallback,
				},
				['Leap: Speed'] = {
					Attributes = {
						'MimicSpeed',
					},
					Cooldown = 25,
					Callback = function(Player, _, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return LeapModule.Use(Player, Character, Configuration, AssetMeta);
					end,
				},
				['DrillHidden'] = {
					Attributes = {
						'MimicStealth',
						'MimicDrilling',
					},
					TurnInvisible = true,
					Callback = EmptyCallback,
				},
				['Drill Stab: Stealth'] = {
					Attributes = {
						'MimicStealth',
						'MimicHoldingVictim',
					},
					Cooldown = 4,
					Callback = function(Player, _, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return DrillModule.UseStab(Character, Configuration, AssetMeta);
					end,
				},
				['Grab: Stealth'] = {
					Attributes = {
						'MimicStealth',
					},
					Callback = function(Player, AbilityMeta, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return GrabModule.Use(Character, Configuration, AssetMeta, AbilityMeta);
					end,
				},
			},
			Callback = EmptyCallback,
		},
		['Mode: Speed'] = {
			KeybindDisplay = 'R',
			Variants = {
				['HiddenStrength'] = {
					Attributes = {
						'MimicStrength',
					},
					TurnInvisible = true,
					Callback = EmptyCallback,
				},
				['HiddenSpeed'] = {
					Attributes = {
						'MimicSpeed',
					},
					TurnInvisible = true,
					Callback = EmptyCallback,
				},
				['HiddenHolding'] = {
					Attributes = {
						'MimicStealth',
						'MimicHoldingVictim',
					},
					TurnInvisible = true,
					Callback = EmptyCallback,
				},
				['Drill: Stealth'] = {
					Attributes = {
						'MimicStealth',
					},
					Callback = function(Player, _, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return DrillModule.Use(Player, Character, Configuration, AssetMeta);
					end,
				},
			},
			Callback = EmptyCallback,
		},
	},
}