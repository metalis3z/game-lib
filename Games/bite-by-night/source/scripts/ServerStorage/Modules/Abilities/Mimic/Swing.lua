local Swing = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Mimic/Shared');

-- <- Public Functions -> --
function Swing.Use(Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) or Character:GetAttribute('MimicDrilling') then
		return AbilityUtil.AbilityResult(false);
	end

	local Mode = Shared.EnsureMode(Character, Configuration);
	local ModeStats = Shared.GetModeStats(Configuration, Mode);
	local AnimationName = Mode == 'Speed' and 'SwingSpeed' or 'Swing'
	local Damage = ModeStats.SwingDamage or (Configuration.Damage and Configuration.Damage['Swing-' .. Mode]) or 0
	local BusyDuration = Mode == 'Speed' and 0.55 or 0.8

	AbilityUtil.SetBusy(Character, BusyDuration);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SwingSFX');

	local Track = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, AnimationName));
	if Track then
		Track:Play();
	end

	if Mode ~= 'Speed' then
		AbilityUtil.DashTowardMouse(ServerUtil.GetPlayer(Character), Character, Mode == 'Strength' and 30 or 26, 0.12, 20);
	end

	task.delay(0.1, function()
		if not Character.Parent then
			return
		end

		local Target = Shared.GetAttackTarget(Character, Configuration, 'Swing', {
			ContinueTimeout = 0.4,
			PollInterval = 0.015,
		});
		if Target then
			AbilityUtil.ApplyDamage(Character, Target, Damage, {});
		end
	end);

	return AbilityUtil.AbilityResult(true, Configuration.SwingCooldown or 3);
end


-- <- Return -> --
return Swing