-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local SwingModule = require('@self/Swing');
local WireEyesModule = require('@self/WireEyes');
local GrabModule = require('@self/Grab');
local SkinStealerModule = require('@self/SkinStealer');
local SkinStealerThrowModule = require('@self/SkinStealerThrow');
local SkinStealerExplodeModule = require('@self/SkinStealerExplode');
local SkinStealerStabModule = require('@self/SkinStealerStab');

-- <- Private Functions -> --
local function GetInformation(Player: Player, CharacterMeta)
	local Character = Player.Character
	local AssetMeta = AbilityUtil.GetAssetMeta(Player);
	if not Character or not AssetMeta or not CharacterMeta or not CharacterMeta.Configuration then
		return
	end

	return Character, CharacterMeta.Configuration, AssetMeta
end

local function HiddenCallback()
	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end

-- <- Return -> --
return {
	Abilities = {
		['Swing'] = {
			KeybindDisplay = 'M1',
			Cooldown = 2.5,
			Variants = {
				['Skin Stealer: Stab'] = {
					Attributes = {
						'SkinStealer',
					},
					Callback = function(Player, AbilityMeta, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return SkinStealerStabModule.Use(AbilityMeta, CharacterMeta, Character, Configuration, AssetMeta);
					end,
				},
			},
			Callback = function(Player, _, CharacterMeta)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

				return SwingModule.Use(Character, Configuration, AssetMeta);
			end,
		},
		['Wire Eyes'] = {
			KeybindDisplay = 'Q',
			Cooldown = 15,
			Variants = {
				['Skin Stealer: Throw'] = {
					Attributes = {
						'SkinStealer',
					},
					Callback = function(Player, _, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

						return SkinStealerThrowModule.Use(Player, Character, Configuration, AssetMeta);
					end,
				},
			},
			Callback = function(Player, _, CharacterMeta)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

				return WireEyesModule.Use(Player, Character, Configuration, AssetMeta);
			end,
		},
		['Grab'] = {
			KeybindDisplay = 'E',
			Cooldown = 12,
			Variants = {
				['Skin Stealer Hidden'] = {
					Attributes = {
						'SkinStealer',
					},
					TurnInvisible = true,
					Callback = HiddenCallback,
				},
			},
			Callback = function(Player, _, CharacterMeta)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

				return GrabModule.Use(Player, Character, Configuration, AssetMeta);
			end,
		},
		['Skin Stealer'] = {
			KeybindDisplay = 'R',
			Variants = {
				['Skin Stealer: Explode'] = {
					Attributes = {
						'SkinStealer',
					},
					Cooldown = 3,
					Callback = function(Player, _, CharacterMeta)
						local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
						if not Character then
							return AbilityUtil.AbilityResult(false);
						end

					--	return SkinStealerExplodeModule.Use(Character, Configuration, AssetMeta);
					end,
				},
			},
			Callback = function(Player, _, CharacterMeta)
				local Character, Configuration, AssetMeta = GetInformation(Player, CharacterMeta);
				if not Character then
					return AbilityUtil.AbilityResult(false);
				end

			--	return SkinStealerModule.Use(Character, Configuration, AssetMeta);
			end,
		},
	},
}