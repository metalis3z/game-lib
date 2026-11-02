-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local Swing = require('@self/Swing');
local Parry = require('@self/Parry');

-- <- Private Functions -> --
local function GetFighter(Player: Player)
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

local function GetCurrentCharges(Character: Model)
	if not Character then
		return 0
	end

	local ChargesMax = Character:GetAttribute('ParryChargesMax') or 3
	return math.clamp(Character:GetAttribute('ParryCharges') or 0, 0, ChargesMax)
end

local function GetChargesMax(Character: Model)
	return Character and (Character:GetAttribute('ParryChargesMax') or 3) or 3
end

-- <- Return -> --
return {
	Abilities = {
		['Swing'] = {
			KeybindDisplay = 'Q',
			Cooldown = 30,
			Uses = GetChargesMax,
			CurrentUses = GetCurrentCharges,
			Callback = function(Player: Player, _AbilityMeta, CharacterMeta)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, _, Animator, AssetMeta = GetFighter(Player);
				if not Character or not CharacterMeta or not CharacterMeta.Configuration then
					return
				end

				return AbilityUtil.AbilityResult(Swing.Use(Character, Animator, AssetMeta, CharacterMeta.Configuration));
			end,
		},
		['Parry'] = {
			KeybindDisplay = 'E',
			Cooldown = 30,
			Callback = function(Player: Player, _AbilityMeta, CharacterMeta)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, _, Animator, AssetMeta = GetFighter(Player);
				if not Character then
					return
				end

				return AbilityUtil.AbilityResult(Parry.Use(Character, Animator, AssetMeta, CharacterMeta and CharacterMeta.Configuration));
			end,
		},
	},
}