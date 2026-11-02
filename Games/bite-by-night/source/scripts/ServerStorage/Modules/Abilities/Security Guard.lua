-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local Taser = require('@self/Taser');
local Cams = require('@self/Cams');

-- <- Private Functions -> --
local function GetSecurityGuard(Player: Player)
	local Character = Player.Character
	if not Character then
		return
	end

	local AssetMeta = AssetManager.Player[Player]
	if not AssetMeta then
		return
	end

	return Character, AssetMeta
end

-- <- Return -> --
return {
	Abilities = {
		['Taser'] = {
			KeybindDisplay = 'M1',
			Callback = function(Player: Player, AbilityMeta, CharacterMeta, ShouldCharge)
				local Character, AssetMeta = GetSecurityGuard(Player);
				if not Character or not AssetMeta or not CharacterMeta or not CharacterMeta.Configuration then
					return
				end

				return Taser.Use(Player, Character, AssetMeta, CharacterMeta.Configuration, AbilityMeta, ShouldCharge);
			end,
		},
		['Cams'] = {
			KeybindDisplay = 'E',
			Cooldown = 1,
			Callback = function(Player: Player)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, AssetMeta = GetSecurityGuard(Player);
				if not Character or not AssetMeta then
					return
				end

				return AbilityUtil.AbilityResult(Cams.Use(Player, Character, AssetMeta));
			end,
		},
	},
}