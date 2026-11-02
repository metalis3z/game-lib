-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local Pizza = require('@self/Pizza');
local Drink = require('@self/Drink');

-- <- Private Functions -> --
local function GetCustomer(Player: Player)
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
		['Pizza'] = {
			KeybindDisplay = 'Q',
			Cooldown = 30,
			Callback = function(Player: Player)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, Humanoid, Animator, AssetMeta = GetCustomer(Player);
				if not Character then
					return
				end

				return AbilityUtil.AbilityResult(Pizza.Use(Character, Humanoid, Animator, AssetMeta));
			end,
		},
		['Drink'] = {
			KeybindDisplay = 'E',
			Cooldown = 65,
			Callback = function(Player: Player)
				if not AbilityUtil.CanUseAbility(Player) then
					return
				end

				local Character, _, Animator, AssetMeta = GetCustomer(Player)
				if not Character then
					return
				end

				return AbilityUtil.AbilityResult(Drink.Use(Character, Animator, AssetMeta));
			end,
		},
	},
}