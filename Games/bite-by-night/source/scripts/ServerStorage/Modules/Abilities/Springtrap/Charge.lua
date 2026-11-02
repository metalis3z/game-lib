local ChargeModule = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local GrabCutscene = ReplicatedStorage.Modules.CutscenesFolder.SpringtrapGrab

-- <- Private Functions -> --
local function PlayGrabCutscene(Player: Player, TargetPlayer: Player?, Character: Model, TargetCharacter: Model, AssetMeta)
	if not GrabCutscene or not Character or not TargetCharacter then
		return
	end

	local InvolvedPlayers = {Player}
	if TargetPlayer then
		table.insert(InvolvedPlayers, TargetPlayer);
	end

	local KillerAnimation = AssetMeta and AssetMeta:RequestAsset('RushGrab_Springtrap');
	if KillerAnimation then
		ServerUtil.SendChange(true, {
			'Module',
			GrabCutscene,
			'Activate',
			{
				InvolvedPlayers,
				Character,
				KillerAnimation,
			},
		});
	end

	local VictimAnimation = AssetMeta and AssetMeta:RequestAsset('RushGrab_Victim');
	if VictimAnimation then
		ServerUtil.SendChange(true, {
			'Module',
			GrabCutscene,
			'Activate',
			{
				InvolvedPlayers,
				TargetCharacter,
				VictimAnimation,
			},
		});
	end
end

-- <- Public Functions -> --
function ChargeModule.Charge(Player: Player, CharacterMeta, AssetMeta)
	local Character = Player.Character
	if not Character or not CharacterMeta or not CharacterMeta.Configuration then
		return
	end
	if not AbilityUtil.CanUseAbility(Character) then
		return
	end

	AbilityUtil.SetBusy(Character);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.25);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'ChargeSFX');

	local StartTrack = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset('RushStart'));
	if StartTrack then
		StartTrack:Play();
	end

	local RushTrack = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset('Rush'));
	task.delay(0.22, function()
		if RushTrack and Character.Parent then
			RushTrack.Looped = true
			RushTrack:Play();
		end
	end);

	local HitTarget = nil
	local StartedAt = os.clock();
	while Character.Parent and os.clock() - StartedAt < 2.6 do
		local Stamina = Character:GetAttribute('Stamina') or 0
		if Stamina <= 0 then
			break
		end

		Character:SetAttribute('Stamina', math.max(0, Stamina - 5));
		AbilityUtil.DashTowardMouse(Player, Character, 78, 0.09, CharacterMeta.Configuration.RushAimRange or 90);

		local Hitbox = HitboxManager.new(Character, CharacterMeta.Configuration, 'Grab', {
			SortByDistance = true,
		});
		if Hitbox then
			local Target = Hitbox:Activate();
			if typeof(Target) == 'table' then
				Target = Target[1]
			end
			if Target then
				local ParryResult = AbilityUtil.ApplyDamage(Character, Target, 0, {});
				if not ParryResult.Parried then
					HitTarget = Target
				end
				break
			end
		end

		task.wait(0.08);
	end

	if RushTrack then
		RushTrack:Stop();
	end

	local EndTrack = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset('RushEnd'));
	if EndTrack then
		EndTrack:Play();
	end

	if HitTarget then
		local Humanoid = ServerUtil.GetHumanoid(HitTarget);
		local DamageRatio = CharacterMeta.Configuration.Damage and CharacterMeta.Configuration.Damage.Grab or 0.4
		local Damage = Humanoid and math.max(1, math.floor(Humanoid.Health * DamageRatio)) or 1

		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'grabSFX');
		AbilityUtil.ApplyDamage(Character, HitTarget, Damage, {
			IgnoreParry = true,
			StunDuration = 2,
		});
		HitTarget:SetAttribute('ChargeRagdolled', true);
		task.delay(2, function()
			if HitTarget.Parent then
				HitTarget:SetAttribute('ChargeRagdolled', nil);
			end
		end);

		PlayGrabCutscene(Player, ServerUtil.GetPlayer(HitTarget), Character, HitTarget, AssetMeta);
	end

	Character:SetAttribute('Screamed', nil);
	AbilityUtil.ClearBusy(Character);
end

-- <- Return -> --
return ChargeModule