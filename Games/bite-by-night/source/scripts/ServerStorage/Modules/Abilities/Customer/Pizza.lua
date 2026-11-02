local Pizza = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local EatDuration = 1.15
local HealDelay = 0.65
local MinimumEatSpeed = 7

-- <- Public Functions -> --
function Pizza.Use(Character: Model, Humanoid: Humanoid, Animator: Animator, AssetMeta)
	local Animation = AssetMeta and AssetMeta:RequestAsset('PizzaEatAnim')
	if not Character or not Humanoid or not Animator or not Animation then
		return false
	end

	local BaseMaxHealth = Character:GetAttribute('BaseMaxHealth') or Humanoid.MaxHealth
	if Humanoid.Health <= 0 or Humanoid.Health >= BaseMaxHealth then
		return false
	end

	local HealAmount = math.max(1, math.floor(Character:GetAttribute('PizzaHeal') or 20));
	local WalkSpeed = Character:GetAttribute('WalkSpeed') or 12
	local EatSpeed = math.max(MinimumEatSpeed, WalkSpeed - 4);

	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, EatDuration + 0.35);
	AbilityUtil.ApplyCustomSpeed(Character, EatSpeed, EatDuration);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'eatSFX');

	local Track = ServerUtil.LoadAnimation(Animator, Animation);
	if Track then
		Track:Play();
	end

	task.delay(HealDelay, function()
		if not Character.Parent or Humanoid.Health <= 0 then
			return
		end

		AbilityUtil.HealCharacter(Character, HealAmount, 0);
	end);

	return true
end


-- <- Return -> --
return Pizza