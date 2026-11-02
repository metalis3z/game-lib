local Grab = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Mimic/Shared');

-- <- Private Variables -> --
local GrabRange = 14
local GrabDot = 0.05

-- <- Public Functions -> --
function Grab.Use(Character: Model, Configuration, AssetMeta, AbilityMeta)
	if not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false);
	end
	if Character:GetAttribute('MimicDrilling') or Character:GetAttribute('MimicHoldingVictim') then
		return AbilityUtil.AbilityResult(false);
	end
	if Shared.EnsureMode(Character, Configuration) ~= 'Stealth' then
		return AbilityUtil.AbilityResult(false);
	end

	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, 0.9);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'GrabSFX');

	local Track = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, 'Grab'));
	if Track then
		Track:Play();
	end

	AbilityUtil.DashTowardMouse(ServerUtil.GetPlayer(Character), Character, 36, 0.12, GrabRange);

	task.delay(0.12, function()
		if not Character.Parent then
			return
		end

		local Target = Shared.GetAttackTarget(Character, Configuration, 'Grab', {
			ContinueTimeout = Configuration.GrabHitboxTime or 0.6,
			PollInterval = 0.01,
		}) or Shared.GetForwardTarget(Character, GrabRange, GrabDot) or ServerUtil.GetNearestTarget(Character, Configuration.GrabFallbackRadius or 5.5, nil, function(_, _, TargetRoot)
			local Root = ServerUtil.GetRoot(Character);
			return Root and TargetRoot and math.abs(TargetRoot.Position.Y - Root.Position.Y) <= 6
		end);
		if not Target then
			AbilityUtil.SetAbilityCooldown(AbilityMeta, Character, Configuration.GrabMissCooldown or 5);
			return
		end

		local Result = AbilityUtil.ApplyDamage(Character, Target, 0, {});
		if Result.Parried then
			return
		end

		local HoldTrack = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, 'Hold'));
		if HoldTrack then
			HoldTrack:Play();
		end

		Shared.HoldVictim(Character, Target, Configuration, AssetMeta, AbilityMeta);
	end);

	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end


-- <- Return -> --
return Grab