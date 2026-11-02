local Drill = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Mimic/Shared');

-- <- Public Functions -> --
function Drill.Use(Player: Player, Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false);
	end
	if Shared.EnsureMode(Character, Configuration) ~= 'Stealth' then
		return AbilityUtil.AbilityResult(false);
	end

	if Character:GetAttribute('MimicDrilling') then
		AbilityUtil.SetBusy(Character, 2);
		Shared.SetDrillState(Player, Character, Configuration, false);
		AbilityUtil.RemoveStamina(Character, Configuration.DrillExitCost or 30);

		local DrillOutTrack = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, 'DrillOut'));
		if DrillOutTrack then
			DrillOutTrack:Play();
		end
		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Drill Exit');

		task.delay(0.2, function()
			if not Character.Parent then
				return
			end

			local Radius = Configuration.Hitbox and Configuration.Hitbox.DigOut or 13
			local BaseDamage = Configuration.Damage and Configuration.Damage.DigOut or 32
			local Root = ServerUtil.GetRoot(Character);
			if not Root then
				return
			end

			for _, Target in ServerUtil.GetTargetsInRadius(Character, Radius) do
				local TargetRoot = ServerUtil.GetRoot(Target);
				if not TargetRoot then
					continue
				end

				local Distance = (TargetRoot.Position - Root.Position).Magnitude
				local Damage = math.max(8, math.floor(BaseDamage * (1 - (0.5 * math.clamp(Distance / Radius, 0, 1)))));
				AbilityUtil.ApplyDamage(Character, Target, Damage, {
					IgnoreParry = true,
					StunDuration = 1,
				});
			end
		end);

		return AbilityUtil.AbilityResult(true, Configuration.DrillCooldown or 45);
	end

	local EnterDuration = Configuration.DrillEnterDuration or 5
	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, EnterDuration + 0.5);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', EnterDuration);

	local DrillTrack = ServerUtil.LoadAnimation(Character, AbilityUtil.GetAsset(AssetMeta, 'DrillHole'));
	if DrillTrack then
		DrillTrack:Play();
	end
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Drill Enter');

	task.delay(EnterDuration, function()
		if not Character.Parent then
			return
		end

		Shared.SetDrillState(Player, Character, Configuration, true);
		Shared.StartDrillRevealLoop(Player, Character);
	end);

	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end


function Drill.UseStab(Character: Model, Configuration, AssetMeta)
	if not Character:GetAttribute('MimicHoldingVictim') then
		return AbilityUtil.AbilityResult(false);
	end

	return AbilityUtil.AbilityResult(Shared.ResolveHeldVictim(Character, Configuration, AssetMeta, true, {
		Cooldown = Configuration.DrillStabCooldown or 4,
		Damage = Configuration.Damage and Configuration.Damage.Grab or 25,
		NoSplash = true,
		ThrowDistance = 4,
		StunDuration = 1,
	}), nil, {
		UseCooldown = false,
	});
end


-- <- Return -> --
return Drill