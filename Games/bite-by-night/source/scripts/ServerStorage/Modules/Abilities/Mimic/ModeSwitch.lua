local ModeSwitch = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Mimic/Shared');

-- <- Public Functions -> --
function ModeSwitch.Use(Player: Player, Character: Model, Configuration, AssetMeta, CharacterMeta, RequestedMode)
	local CurrentMode = Shared.EnsureMode(Character, Configuration);

	if RequestedMode == 'Cancel' or RequestedMode == nil then
		if Character:HasTag('Selecting') then
			Shared.ClearSelection(Player, Character);
		else
			Shared.OpenSelection(Player, Character, AssetMeta);
		end
		return AbilityUtil.AbilityResult(true, 0.1);
	elseif RequestedMode ~= 'Strength' and RequestedMode ~= 'Speed' and RequestedMode ~= 'Stealth' then
		return AbilityUtil.AbilityResult(false);
	end

	Shared.ClearSelection(Player, Character);
	Shared.ReleaseHeldVictim(Character);
	if Character:GetAttribute('MimicDrilling') then
		Shared.SetDrillState(Player, Character, Configuration, false);
	end
	Character:SetAttribute('Running', false);
	if CurrentMode == RequestedMode then
		return AbilityUtil.AbilityResult(true, 0.1);
	end

	Shared.ApplyMode(Character, Configuration, RequestedMode);
	AbilityUtil.SetBusy(Character, 0.55);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SwitchSFX');

	local Track = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, 'ModeSwitch'));
	if Track then
		Track:Play();
	end

	if CharacterMeta and CharacterMeta.Abilities then
		if RequestedMode == 'Speed' then
			AbilityUtil.SetLinkedAbilityCooldown(CharacterMeta, Character, 3, Configuration.SpeedSwitchLock or 3);
		elseif RequestedMode == 'Stealth' then
			AbilityUtil.SetLinkedAbilityCooldown(CharacterMeta, Character, 3, Configuration.StealthSwitchLock or 5);
			AbilityUtil.SetLinkedAbilityCooldown(CharacterMeta, Character, 4, Configuration.StealthSwitchLock or 5);
		end
	end

	return AbilityUtil.AbilityResult(true, Configuration.ModeSwitchCooldown or 5);
end


-- <- Return -> --
return ModeSwitch