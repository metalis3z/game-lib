local Swing = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Public Functions -> --
function Swing.Use(Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	AbilityUtil.SetBusy(Character, 0.85);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SwingSFX');

	local Track = ServerUtil.LoadAnimation(Character, Shared.GetBaseAsset(AssetMeta, 'Swing'));
	if Track then
		Track:Play();
	end
	AbilityUtil.DashTowardMouse(ServerUtil.GetPlayer(Character), Character, 28, 0.1, 20);

	task.delay(0.12, function()
		if not Character.Parent then
			return
		end

		local TargetCharacter = Shared.GetAttackTarget(Character, Configuration, 'Swing', {
			ContinueTimeout = 0.45,
			PollInterval = 0.015,
		});
		if not TargetCharacter then
			return
		end

		local Result = AbilityUtil.ApplyDamage(Character, TargetCharacter, Configuration.Damage and Configuration.Damage.Swing or 34, {});
		if Result.Died then
			Shared.RegisterDisguise(Character, TargetCharacter);
		end
	end);

	return AbilityUtil.AbilityResult(true, Configuration.SwingCooldown or 2.5);
end


-- <- Return -> --
return Swing