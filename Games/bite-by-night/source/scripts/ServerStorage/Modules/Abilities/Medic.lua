-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local Heal = require('@self/Heal');
local SelfHeal = require('@self/SelfHeal');

-- <- Private Functions -> --
local function GetMedic(Player: Player)
	local Character = Player.Character
	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	local Animator = Humanoid and Humanoid:FindFirstChildOfClass('Animator');
	local AssetMeta = AssetManager.Player[Player]
	if not Humanoid or not Animator or not AssetMeta then
		return
	end

	return Character, Humanoid, Animator, AssetMeta
end

-- <- Return -> --
return {
	Abilities = {
		['Heal'] = {
			KeybindDisplay = 'Q',
			Cooldown = 45,
			Callback = function(Player: Player, _AbilityMeta, CharacterMeta)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, _, Animator, AssetMeta = GetMedic(Player);
				if not Character or not CharacterMeta or not CharacterMeta.Configuration then
					return
				end

				return AbilityUtil.AbilityResult(Heal.Use(Player, Character, Animator, AssetMeta, CharacterMeta.Configuration));
			end,
		},
		['Self Heal'] = {
			KeybindDisplay = 'E',
			Cooldown = 60,
			Callback = function(Player: Player, _AbilityMeta, CharacterMeta)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, Humanoid, Animator, AssetMeta = GetMedic(Player);
				if not Character or not CharacterMeta or not CharacterMeta.Configuration then
					return
				end

				return AbilityUtil.AbilityResult(SelfHeal.Use(Character, Humanoid, Animator, AssetMeta, CharacterMeta.Configuration));
			end,
		},
	},
}