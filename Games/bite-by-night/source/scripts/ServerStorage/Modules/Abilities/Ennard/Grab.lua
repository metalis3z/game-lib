local Grab = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Private Functions -> --
local function GetPullInformation(Configuration)
	local Pull = Configuration.Hitbox and Configuration.Hitbox.Pull
	if typeof(Pull) == 'number' then
		return Configuration.GrabRange or 18, Vector3.new(Pull, Pull, Pull), CFrame.identity, {}
	elseif typeof(Pull) ~= 'table' then
		return Configuration.GrabRange or 18, Vector3.new(4, 4, 4), CFrame.identity, {}
	end

	local PullSize = Pull.TinySize or Pull.Size
	if typeof(PullSize) == 'number' then
		PullSize = Vector3.new(PullSize, PullSize, PullSize)
	elseif typeof(PullSize) ~= 'Vector3' then
		local PullRadius = Pull.RayRadius or Pull.Radius or 4
		PullSize = Vector3.new(PullRadius, PullRadius, PullRadius)
	end

	return Pull.Range or Configuration.GrabRange or 18, PullSize, Pull.CFrame or CFrame.identity, Pull
end

-- <- Public Functions -> --
function Grab.Use(Player: Player, Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) or Shared.IsDisguised(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	local PullRange, PullSize, PullOffset, PullInformation = GetPullInformation(Configuration);
	local AimRange = PullRange + math.abs(PullOffset.Position.Z)
	local Root = ServerUtil.GetRoot(Character);
	local AimPosition = Root and ServerUtil.GetMousePosition(Player, Root.Position, AimRange, 0.15)
	local CastPosition = AimPosition or (Root and Root.Position + Root.CFrame.LookVector * AimRange)
	if CastPosition then
		ServerUtil.FaceTowardsPosition(Character, CastPosition);
	end

	AbilityUtil.SetBusy(Character, Configuration.GrabBusyTime or 1.75);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'EnnardPullSound');

	local PullAnimation = Shared.GetBaseAsset(AssetMeta, 'Ennard_Pull') or Shared.GetBaseAsset(AssetMeta, 'Swing')
	local VictimAnimation = Shared.GetBaseAsset(AssetMeta, 'Victim_Pull');
	local PullTrack = ServerUtil.LoadAnimation(Character, PullAnimation);
	if PullTrack then
		PullTrack:Play();
	end

	Shared.PlayGrabLaunch(Character, AssetMeta, CastPosition);

	task.wait(Configuration.GrabWindup or 0.68);
	if not Character.Parent then
		return AbilityUtil.AbilityResult(true, Configuration.GrabCooldown or 12);
	end

	Root = ServerUtil.GetRoot(Character)
	if not Root then
		return AbilityUtil.AbilityResult(true, Configuration.GrabCooldown or 12);
	end
	if CastPosition then
		ServerUtil.FaceTowardsPosition(Character, CastPosition);
	end

	local TargetCharacter = nil
	local StartedAt = os.clock();
	repeat
		TargetCharacter = Shared.GetTinyHitboxTarget(Character, {
			Range = PullRange,
			Size = PullSize,
			Spacing = PullInformation.TinySpacing or 2.25,
			StartDistance = PullInformation.TinyStartDistance or 0,
			OriginOffset = PullOffset,
			AimPosition = CastPosition,
			DebugLifetime = PullInformation.DebugLifetime or 0.25,
			MaxParts = PullInformation.MaxParts or 80,
		});
		if TargetCharacter then
			break
		end

		task.wait(Configuration.GrabTinyPollInterval or 0.02);
	until os.clock() - StartedAt >= (Configuration.GrabActiveTime or 0.16)
	if not TargetCharacter then
		return AbilityUtil.AbilityResult(true, Configuration.GrabCooldown or 12);
	end

	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	if TargetRoot then
		ServerUtil.FaceTowardsPosition(Character, TargetRoot.Position);
	end

	local Result = AbilityUtil.ApplyDamage(Character, TargetCharacter, 0, {
		StunDuration = Configuration.GrabStunDuration or 0.3,
	});
	if Result.Parried then
		return AbilityUtil.AbilityResult(false);
	end

	Shared.PlayGrabImpact(Character, TargetCharacter, PullTrack, VictimAnimation);
	AbilityUtil.LocateForPlayer(Player, TargetCharacter);

	task.spawn(function()
		task.wait(Configuration.GrabPullDelay or 0.18);

		local PullTicks = Configuration.GrabPullTicks or 12
		local PullInterval = Configuration.GrabPullInterval or 0.035
		local ReleaseDistance = Configuration.GrabReleaseDistance or 3.75
		local StartPivot = TargetCharacter:GetPivot();
		for Index = 1, PullTicks do
			if not Character.Parent or not TargetCharacter.Parent then
				return
			end

			local CurrentRoot = ServerUtil.GetRoot(Character);
			local CurrentTargetRoot = ServerUtil.GetRoot(TargetCharacter);
			if not CurrentRoot or not CurrentTargetRoot then
				return
			end

			local GoalPivot = CurrentRoot.CFrame * CFrame.new(0, 0, -ReleaseDistance)
			TargetCharacter:PivotTo(StartPivot:Lerp(GoalPivot, math.clamp(Index / PullTicks, 0, 1)));
			task.wait(PullInterval);
		end
	end);

	return AbilityUtil.AbilityResult(true, Configuration.GrabCooldown or 12);
end

-- <- Return -> --
return Grab