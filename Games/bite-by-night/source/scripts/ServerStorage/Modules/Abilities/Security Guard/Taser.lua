local Taser = {};

-- <- Services -> --
local Debris = game:GetService('Debris');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local VFXHandler = require('@game/ReplicatedStorage/Modules/VFXHandler');

-- <- Private Variables -> --
local MoveFolder = ReplicatedStorage.Modules.Moves
local SecurityGuardTaserAim = MoveFolder and MoveFolder:FindFirstChild('SecurityGuardTaserAim')
local AliveFolder = workspace.PLAYERS.ALIVE
local KillerFolder = workspace.PLAYERS.KILLER
local IgnoreFolder = workspace.IGNORE
local ChargeStates = setmetatable({}, {__mode = 'k'});
local TierSlowDuration = {3, 5, 7, 9}
local TierSlowSpeed = {12, 11, 10, 8}
local TierChargeSpeed = {14, 12, 10, 8}
local TaserBeamDuration = 0.16
local RedStunDuration = 0.1
local PostHitSlowDuration = 0.85
local PostHitSlowSpeed = 5

-- <- Private Functions -> --
local function GetState(Character: Model)
	local State = ChargeStates[Character]
	if State then
		return State
	end

	State = {}
	ChargeStates[Character] = State
	return State
end

local function ApplyCooldown(State, Duration)
	if not State or not State.AbilityMeta or not Duration or Duration <= 0 then
		return
	end

	AbilityUtil.SetAbilityCooldown(State.AbilityMeta, State.Character, Duration);
end

local function SendAimChange(Player: Player, FunctionName: string)
	if not Player or not SecurityGuardTaserAim then
		return
	end

	ServerUtil.SendMove(Player, SecurityGuardTaserAim, FunctionName);
end

local function SetChargeSpeed(Character: Model, Speed: number?)
	if not Speed then
		Character:SetAttribute('CustomSpeed', nil);
		if Character:HasTag('CustomSpeed') then
			Character:RemoveTag('CustomSpeed');
		end
		return
	end

	Character:SetAttribute('CustomSpeed', Speed);
	if not Character:HasTag('CustomSpeed') then
		Character:AddTag('CustomSpeed');
	end
end

local function GetChargeTier(Configuration, ChargeDuration: number)
	local Thresholds = Configuration.ChargeThresholds or {5, 10, 15, 20}
	if ChargeDuration >= Thresholds[3] then
		return 4
	elseif ChargeDuration >= Thresholds[2] then
		return 3
	elseif ChargeDuration >= Thresholds[1] then
		return 2
	end

	return 1
end

local function GetChargeMovement(Configuration, ChargeDuration: number)
	local ChargeSpeed = Configuration.TierChargeSpeed or TierChargeSpeed
	return ChargeSpeed[GetChargeTier(Configuration, ChargeDuration)] or TierChargeSpeed[1]
end

local function GetTaserModel(Character: Model)
	local TaserModel = Character:FindFirstChild('FAZ-TAZER');
	if TaserModel and TaserModel:IsA('Model') then
		return TaserModel
	end
end

local function GetTaserBase(Character: Model)
	local TaserModel = GetTaserModel(Character);
	local Base = TaserModel and TaserModel:FindFirstChild('Base')
	if Base and Base:IsA('BasePart') then
		return TaserModel, Base
	end
end

local function GetTaserOrigin(Character: Model)
	local TaserModel = GetTaserModel(Character);
	local Point = TaserModel and TaserModel:FindFirstChild('TaserPoint')
	if Point and Point:IsA('BasePart') then
		return Point.CFrame
	end

	local _, Base = GetTaserBase(Character);
	if Base then
		local Attachment = Base:FindFirstChild('Fire Attachment');
		if Attachment and Attachment:IsA('Attachment') then
			return Attachment.WorldCFrame
		end
		return Base.CFrame
	end

	local Root = ServerUtil.GetRoot(Character);
	if Root then
		return Root.CFrame
	end
end

local function PlayTaserSound(Character: Model, SoundName: string, ShouldLoop: boolean?)
	local _, Base = GetTaserBase(Character);
	local Sound = Base and Base:FindFirstChild(SoundName)
	if not Sound or not Sound:IsA('Sound') then
		return
	end

	if ShouldLoop ~= nil then
		Sound.Looped = ShouldLoop
	end
	if Sound.IsPlaying then
		Sound:Stop();
	end
	Sound:Play();
	return Sound
end

local function StopSound(Sound)
	if Sound and Sound:IsA('Sound') and Sound.IsPlaying then
		Sound:Stop();
	end
end

local function GetSecurityCount()
	local Count = 0
	for _, Character in AliveFolder:GetChildren() do
		local Humanoid = Character:FindFirstChildOfClass('Humanoid');
		if Humanoid and Humanoid.Health > 0 and Character:GetAttribute('Character') == 'Survivor-Security Guard' then
			Count += 1
		end
	end

	return Count
end

local function GetDurationScale()
	local SecurityCount = GetSecurityCount();
	if SecurityCount <= 2 then
		return 1
	end

	local Reduction = math.min(0.6, 0.2 + ((SecurityCount - 3) * 0.1));
	return 1 - Reduction
end

local function EmitStunEffect(AssetMeta, TargetCharacter: Model)
	if not AssetMeta then
		return
	end

	local Effect = AssetMeta:RequestAsset('StunEffect', true);
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	if not Effect or not Effect:IsA('BasePart') or not TargetRoot then
		if Effect then
			Effect:Destroy();
		end
		return
	end

	Effect.CFrame = TargetRoot.CFrame
	Effect.Parent = IgnoreFolder

	local Weld = Instance.new('WeldConstraint');
	Weld.Part0 = TargetRoot
	Weld.Part1 = Effect
	Weld.Parent = Effect
	Debris:AddItem(Effect, 3);
end

local function EnableShotBeams(OriginAttachment: Attachment?, TargetAttachment: Attachment?, Enabled: boolean, BeamList: {})
	if not OriginAttachment then
		return
	end

	for _, Child in ipairs(OriginAttachment:GetChildren()) do
		if not Child:IsA('Beam') then
			continue
		end

		if not Child.Attachment0 then
			Child.Attachment0 = OriginAttachment
		end
		Child.Attachment1 = Enabled and TargetAttachment or nil
		Child.Enabled = Enabled
		if Enabled and BeamList then
			table.insert(BeamList, Child);
		end
	end
end

local function EmitTaserBeam(Character: Model, HitPosition: Vector3, DidHit: boolean)
	local TaserModel, Base = GetTaserBase(Character);
	local PointTemplate = TaserModel and TaserModel:FindFirstChild('TaserPoint')
	if not Base or not PointTemplate or not PointTemplate:IsA('BasePart') then
		return
	end

	local OriginCFrame = GetTaserOrigin(Character);
	local BeamPoint = PointTemplate:Clone();
	local Weld = BeamPoint:FindFirstChild('Weld');
	if Weld then
		Weld:Destroy();
	end

	BeamPoint.Anchored = true
	BeamPoint.CanCollide = false
	BeamPoint.CanTouch = false
	BeamPoint.CanQuery = false
	BeamPoint.CFrame = OriginCFrame and CFrame.lookAt(HitPosition, OriginCFrame.Position) or CFrame.new(HitPosition)
	BeamPoint.Parent = IgnoreFolder

	local BeamFolder = BeamPoint:FindFirstChild('Beam');
	local AttachmentA = BeamFolder and BeamFolder:FindFirstChild('AttachmentA')
	local AttachmentB = BeamFolder and BeamFolder:FindFirstChild('AttachmentB')
	local ActiveBeams = {}

	EnableShotBeams(Base:FindFirstChild('b'), AttachmentA, true, ActiveBeams);
	EnableShotBeams(Base:FindFirstChild('b2'), AttachmentB, true, ActiveBeams);

	local ShootVFX = Base:FindFirstChild('shoot');
	if ShootVFX then
		VFXHandler.doEmitCount(ShootVFX);
	end

	local PointVFX = BeamPoint:FindFirstChild(DidHit and 'Hit VFX' or 'Main VFX');
	if PointVFX then
		VFXHandler.doEmitCount(PointVFX);
	end

	PlayTaserSound(Character, 'Shoot');
	PlayTaserSound(Character, 'Zip');
	PlayTaserSound(Character, DidHit and 'Impact' or 'Miss');

	task.delay(TaserBeamDuration, function()
		for _, Beam in ipairs(ActiveBeams) do
			if Beam.Parent then
				Beam.Enabled = false
				Beam.Attachment1 = nil
			end
		end

		local EndedSound = Base:FindFirstChild('Ended');
		if EndedSound and EndedSound:IsA('Sound') then
			EndedSound:Play();
		end
	end);

	Debris:AddItem(BeamPoint, TaserBeamDuration + 0.15);
end

local function GetShotResult(Player: Player, Character: Model, Configuration)
	local OriginCFrame = GetTaserOrigin(Character);
	if not OriginCFrame then
		return nil, nil
	end

	local Radius = Configuration.Hitbox and Configuration.Hitbox.Fire or 4
	local MaxRange = Configuration.TaserRange or 12
	local HitPosition = ServerUtil.GetMousePosition(Player, OriginCFrame.Position, MaxRange, 0.15);
	if HitPosition then
		ServerUtil.FaceTowardsPosition(Character, HitPosition);
		OriginCFrame = GetTaserOrigin(Character) or OriginCFrame
	end

	local Direction = HitPosition and (HitPosition - OriginCFrame.Position) or (OriginCFrame.LookVector * MaxRange)
	if Direction.Magnitude <= 0.001 then
		Direction = OriginCFrame.LookVector * MaxRange
	else
		Direction = Direction.Unit * math.min(Direction.Magnitude, MaxRange)
	end
	HitPosition = OriginCFrame.Position + Direction

	local Params = RaycastParams.new();
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {Character, AliveFolder, IgnoreFolder}

	local Result = workspace:Spherecast(OriginCFrame.Position, Radius, Direction, Params);
	local TargetCharacter
	if Result and Result.Instance then
		HitPosition = Result.Position
		local Model = Result.Instance:FindFirstAncestorWhichIsA('Model');
		if Model and Model.Parent == KillerFolder then
			TargetCharacter = Model
		end
	end

	if not TargetCharacter then
		TargetCharacter = ServerUtil.GetNearestTarget(HitPosition, Radius + 1, KillerFolder, function(_, _, TargetRoot)
			local Root = ServerUtil.GetRoot(Character);
			return Root and TargetRoot and math.abs(TargetRoot.Position.Y - Root.Position.Y) <= 6
		end);
	end

	return TargetCharacter, HitPosition
end

local function ForceLookAtTarget(Character: Model, TargetCharacter: Model, Duration: number)
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	local Root = ServerUtil.GetRoot(Character);
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	if not Humanoid or not Root or not TargetRoot then
		return
	end

	local OriginalAutoRotate = Humanoid.AutoRotate
	Humanoid.AutoRotate = false

	task.spawn(function()
		local ExpireAt = os.clock() + Duration
		while Character.Parent and TargetCharacter.Parent and os.clock() <= ExpireAt do
			local CurrentRoot = ServerUtil.GetRoot(Character);
			local CurrentTargetRoot = ServerUtil.GetRoot(TargetCharacter);
			if not CurrentRoot or not CurrentTargetRoot then
				break
			end

			local LookPosition = Vector3.new(CurrentTargetRoot.Position.X, CurrentRoot.Position.Y, CurrentTargetRoot.Position.Z);
			Character:PivotTo(CFrame.lookAt(CurrentRoot.Position, LookPosition));
			task.wait(0.05);
		end

		if Humanoid.Parent then
			Humanoid.AutoRotate = OriginalAutoRotate
		end
	end);
end

local function ClearCharge(Character: Model)
	local State = ChargeStates[Character]
	if not State then
		SetChargeSpeed(Character, nil);
		Character:SetAttribute('TaserCharging', false);
		AbilityUtil.ClearBusy(Character);
		if Character:GetAttribute('Team') ~= 'Lobby' and not Character:GetAttribute('Exhausted') then
			Character:SetAttribute('CanRun', true);
		end
		return 0
	end

	local ChargeDuration = 0
	if State.Charging and State.StartedAt then
		ChargeDuration = math.max(0, os.clock() - State.StartedAt)
	end

	State.Charging = nil
	State.StartedAt = nil
	State.LastHealth = nil
	Character:SetAttribute('TaserCharging', false);
	SendAimChange(State.Player, 'Clear');
	SetChargeSpeed(Character, nil);
	AbilityUtil.ClearBusy(Character);
	if Character:GetAttribute('Team') ~= 'Lobby' and not Character:GetAttribute('Exhausted') then
		Character:SetAttribute('CanRun', true);
	end

	if State.Track then
		State.Track:Stop();
		State.Track = nil
	end
	StopSound(State.ChargeSound);
	State.ChargeSound = nil

	return ChargeDuration
end

local function ApplyTaserEffects(TargetCharacter: Model, Tier: number, Configuration)
	local DurationScale = GetDurationScale();
	local SlowDuration = ((Configuration.TierSlowDuration or TierSlowDuration)[Tier] or TierSlowDuration[Tier] or 3) * DurationScale
	local SlowSpeed = (Configuration.TierSlowSpeed or TierSlowSpeed)[Tier] or TierSlowSpeed[Tier] or 8
	AbilityUtil.ApplyCustomSpeed(TargetCharacter, SlowSpeed, SlowDuration);
	AbilityUtil.ApplyStun(TargetCharacter, (Configuration.RedStunDuration or RedStunDuration) * DurationScale);

	if Tier == 2 then
		AbilityUtil.ApplyDazed(TargetCharacter, 5 * DurationScale);
	elseif Tier == 3 then
		AbilityUtil.ApplyTimedTag(TargetCharacter, 'Confusion', 7 * DurationScale);
	elseif Tier >= 4 then
		AbilityUtil.ApplySilence(TargetCharacter, 9 * DurationScale);
	end
end

local function FireTaser(Player: Player, Character: Model, AssetMeta, Configuration)
	local State = ChargeStates[Character]
	if not State or not State.Charging then
		return AbilityUtil.AbilityResult(false, nil, {UseCooldown = false});
	end

	local ChargeDuration = ClearCharge(Character);
	local Tier = GetChargeTier(Configuration, ChargeDuration);
	local DamageKey = 'Taser' .. Tier
		local TargetCharacter, HitPosition = GetShotResult(Player, Character, Configuration);

	AbilityUtil.SetBusy(Character, 0.95);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.25);

	local Animation = AssetMeta and AssetMeta:RequestAsset('FireTaser')
	local Track = ServerUtil.LoadAnimation(Character, Animation);
	if Track then
		Track:Play();
	end

	task.delay(0.12, function()
		if not Character.Parent then
			return
		end

		local TargetCharacter, HitPosition = GetShotResult(Character, Configuration);
		if HitPosition then
			EmitTaserBeam(Character, HitPosition, TargetCharacter ~= nil);
		end

		local Cooldown = TargetCharacter and (Configuration.HitCooldown or 30) or (Configuration.MissCooldown or 20)
		ApplyCooldown(State, Cooldown);
		if not TargetCharacter then
			return
		end

		local Result = AbilityUtil.ApplyDamage(Character, TargetCharacter, Damage, {
			IgnoreParry = true,
			IgnoreShield = true,
		});
		if Result.Target and Result.Humanoid and Result.Humanoid.Health > 0 then
			ApplyTaserEffects(Result.Target, Tier, Configuration);
			EmitStunEffect(AssetMeta, Result.Target);
			AbilityUtil.ApplyCustomSpeed(Character, PostHitSlowSpeed, PostHitSlowDuration);
			ForceLookAtTarget(Character, Result.Target, PostHitSlowDuration);
		end
	end);

	return AbilityUtil.AbilityResult(true, nil, {UseCooldown = false});
end

local function StartCharge(Player: Player, Character: Model, AssetMeta, Configuration, AbilityMeta)
	if not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false, nil, {UseCooldown = false});
	end

	local State = GetState(Character);
	if State.Charging then
		return AbilityUtil.AbilityResult(false, nil, {UseCooldown = false});
	end

	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		return AbilityUtil.AbilityResult(false, nil, {UseCooldown = false});
	end

	State.Player = Player
	State.Character = Character
	State.AssetMeta = AssetMeta
	State.Configuration = Configuration
	State.AbilityMeta = AbilityMeta
	State.Charging = true
	State.StartedAt = os.clock()
	State.LastHealth = Humanoid.Health
	Character:SetAttribute('Running', false);
	Character:SetAttribute('TaserCharging', true);
	Character:SetAttribute('CanRun', false);
	SendAimChange(Player, 'Activate');
	AbilityUtil.SetBusy(Character, ((Configuration.ChargeThresholds and Configuration.ChargeThresholds[4]) or 20) + 0.75);
	SetChargeSpeed(Character, GetChargeMovement(Configuration, 0));

	local IdleAnimation = AssetMeta and AssetMeta:RequestAsset('IdleTaser')
	local Track = ServerUtil.LoadAnimation(Character, IdleAnimation);
	if Track then
		Track.Looped = true
		Track.Priority = Enum.AnimationPriority.Action4
		Track:Play();
		State.Track = Track
	end

	State.ChargeSound = PlayTaserSound(Character, 'Electicity', true)
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'equip');

	task.spawn(function()
		while Character.Parent and State.Charging do
			local ChargeDuration = math.max(0, os.clock() - (State.StartedAt or os.clock()));
			SetChargeSpeed(Character, GetChargeMovement(Configuration, ChargeDuration));

			if Humanoid.Health < (State.LastHealth or Humanoid.Health) or Character:GetAttribute('Stun') or Character:HasTag('CantMove') then
				ClearCharge(Character);
				ApplyCooldown(State, Configuration.CancelCooldown or 15);
				return
			end
			if ChargeDuration >= ((Configuration.ChargeThresholds and Configuration.ChargeThresholds[4]) or 20) then
				FireTaser(Player, Character, AssetMeta, Configuration);
				return
			end

			State.LastHealth = Humanoid.Health
			task.wait(0.1);
		end
	end);

	return AbilityUtil.AbilityResult(true, nil, {UseCooldown = false});
end


-- <- Public Functions -> --
function Taser.Use(Player: Player, Character: Model, AssetMeta, Configuration, AbilityMeta, ShouldCharge)
	if ShouldCharge then
		return StartCharge(Player, Character, AssetMeta, Configuration, AbilityMeta);
	end

	return FireTaser(Player, Character, AssetMeta, Configuration);
end


-- <- Return -> --
return Taser