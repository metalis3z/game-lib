local Drink = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local SpeedDuration = 5
local EnergeticDuration = 15
local RestDuration = 20
local CrashDuration = 3
local SpeedMultiplier = 1.1
local EnergeticDrainMultiplier = 0.5
local RestRegenMultiplier = 0.5

-- <- Public Functions -> --
function Drink.Use(Character: Model, Animator: Animator, AssetMeta)
	local Animation = AssetMeta and AssetMeta:RequestAsset('EnergyDrinkAnim')
	if not Character or not Animator or not Animation then
		return false
	end

	local BaseWalkSpeed = Character:GetAttribute('WalkSpeed') or 12
	local BaseRunSpeed = Character:GetAttribute('RunSpeed') or 24
	local StaminaGain = Character:GetAttribute('DrinkStamina') or 20

	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, 1.45);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 1.05);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'drinkSFX');

	local Track = ServerUtil.LoadAnimation(Animator, Animation);
	if Track then
		Track:Play();
	end

	task.delay(0.6, function()
		if not Character.Parent then
			return
		end

		AbilityUtil.AddStamina(Character, StaminaGain);
		AbilityUtil.ApplyTimedAttribute(Character, 'Energetic', true, EnergeticDuration, nil);
		AbilityUtil.ApplyTimedAttribute(Character, 'Rest', true, RestDuration, nil);
		AbilityUtil.ApplyTimedAttribute(Character, 'StaminaDrainMultiplier', EnergeticDrainMultiplier, EnergeticDuration, nil);
		AbilityUtil.ApplyTimedAttribute(Character, 'StaminaRegenMultiplier', RestRegenMultiplier, RestDuration, nil);
		AbilityUtil.ApplyStatOverride(Character, {
			WalkSpeed = BaseWalkSpeed * SpeedMultiplier,
			RunSpeed = BaseRunSpeed * SpeedMultiplier,
		}, SpeedDuration)

		task.delay(EnergeticDuration, function()
			if not Character.Parent then
				return
			end

			AbilityUtil.ApplyCustomSpeed(Character, math.max(8, BaseWalkSpeed - 4), CrashDuration);
		end);
	end);

	return true
end


-- <- Return -> --
return Drink