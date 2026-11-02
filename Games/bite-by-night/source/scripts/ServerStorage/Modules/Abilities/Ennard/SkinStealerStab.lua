local SkinStealerStab = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Private Variables -> --
local HitExplodeLock = 5

-- <- Public Functions -> --
function SkinStealerStab.Use(AbilityMeta, CharacterMeta, Character: Model, Configuration, AssetMeta)
	if not Shared.IsDisguised(Character) or not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	local DisguiseConfiguration = Shared.GetDisguiseConfiguration();
	AbilityUtil.SetBusy(Character, 0.95);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SwingHit');

	local AttackAnimation = Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Player') or Shared.GetBaseAsset(AssetMeta, 'Swing')
	local Track = ServerUtil.LoadAnimation(Character, AttackAnimation);
	if Track then
		Track:Play();
	end
	AbilityUtil.DashTowardMouse(ServerUtil.GetPlayer(Character), Character, 42, 0.12, 18);
	Shared.ReduceDisguiseTime(Character, Configuration.DisguiseTimePenalty or 4);

	task.delay(0.1, function()
		if not Character.Parent then
			return
		end

		local TargetCharacter = Shared.GetAttackTarget(Character, DisguiseConfiguration, 'Swing', {
			ContinueTimeout = 0.45,
			PollInterval = 0.02,
		}) or Shared.GetForwardTarget(Character, 12, 0.35)
		if not TargetCharacter then
			AbilityUtil.SetAbilityCooldown(AbilityMeta, Character, Configuration.StabMissCooldown or 5);
			return
		end

		local Result = AbilityUtil.ApplyDamage(Character, TargetCharacter, DisguiseConfiguration.Damage and DisguiseConfiguration.Damage.Stab or Configuration.Damage and Configuration.Damage.Stab or 38, {
			BleedDuration = 5,
			BleedTick = 1,
		});
		AbilityUtil.SetAbilityCooldown(AbilityMeta, Character, Configuration.StabHitCooldown or 24);
		AbilityUtil.SetLinkedAbilityCooldown(CharacterMeta, Character, 4, Configuration.StabExplodeCooldown or HitExplodeLock);

		if Result.Died then
			Shared.RegisterDisguise(Character, TargetCharacter);
			Shared.BroadcastMove(true, Shared.GetMoveModule(AssetMeta, 'EnnardDisguiseFinisher'), {
				{Character, TargetCharacter},
				{
					Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Kill_Player'),
					Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Kill_Victim'),
				},
			});
		end
	end);

	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end


-- <- Return -> --
return SkinStealerStab