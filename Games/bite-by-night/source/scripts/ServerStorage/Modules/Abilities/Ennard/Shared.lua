local Shared = {};

-- <- Services -> --
local Debris = game:GetService('Debris');
local PathfindingService = game:GetService('PathfindingService');
local Players = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local EffectUtility = require('@game/ReplicatedStorage/Modules/EffectUtility');
local DisguiseConfiguration = require('@game/ReplicatedStorage/Characters/Ennard/Normal/Assets/Disguise/Configuration');

-- <- Private Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local IgnoreFolder = workspace.IGNORE
local MoveFolder = ReplicatedStorage.Modules.Moves.Ennard
local MinionLifetime = 40
local MinionActivationDelay = 4
local MinionWalkSpeed = 7
local MinionThinkRate = 0.45
local MinionAggroRange = 50
local MinionLatchRange = 4.75
local MinionWanderDistance = 18
local MinionWanderRefresh = 2.25
local MinionTickDamage = 3
local MinionTickCount = 4
local MinionTickInterval = 2
local MinionExplosionRadius = 10
local MinionExplosionDamage = 12
local GrabRange = 18
local GrabDot = 0.2
local ActiveMinions = setmetatable({}, {__mode = 'k'});
local ActiveDisguises = setmetatable({}, {__mode = 'k'});
local StoredDisguises = setmetatable({}, {__mode = 'k'});

-- <- Private Functions -> --
local function GetStoredDisguiseList(Character)
	local List = StoredDisguises[Character]
	if List then
		return List
	end

	List = {}
	StoredDisguises[Character] = List
	return List
end

local function GetMinionList(Character)
	local List = ActiveMinions[Character]
	if List then
		return List
	end

	List = {}
	ActiveMinions[Character] = List
	return List
end

local function GetCharacterPart(Character, ...)
	if not Character then
		return nil
	end

	for _, PartName in ipairs({...}) do
		local Part = Character:FindFirstChild(PartName);
		if Part then
			return Part
		end
	end

	return nil
end

local function GetAnimator(Model)
	if not Model then
		return nil
	end

	for _, Descendant in Model:GetDescendants() do
		if Descendant:IsA('Animator') then
			return Descendant
		end
	end

	return nil
end

local function PrepareEffectModel(Model)
	for _, Descendant in Model:GetDescendants() do
		if Descendant:IsA('BasePart') then
			Descendant.Anchored = true
			Descendant.CanCollide = false
			Descendant.Massless = true
		end
	end
end

local function GetAimCFrame(Root, Position, Distance, OriginPosition: Vector3?)
	if not Root then
		return CFrame.identity
	end

	local CastOrigin = OriginPosition or Root.Position
	local TargetPosition = Position
	if TargetPosition then
		TargetPosition = Vector3.new(TargetPosition.X, CastOrigin.Y, TargetPosition.Z)
	end
	if not TargetPosition or (TargetPosition - CastOrigin).Magnitude <= 0.1 then
		TargetPosition = CastOrigin + Root.CFrame.LookVector * (Distance or GrabRange)
	end

	return CFrame.lookAt(CastOrigin, TargetPosition);
end

local function EmitEffect(Effect, ToggleDuration, BeamDuration)
	if not Effect then
		return
	end

	EffectUtility.EmitAttachment(Effect);
	if ToggleDuration then
		EffectUtility.ToggleAttachment(Effect, true, ToggleDuration);
	end
	if BeamDuration then
		EffectUtility.TweenBeamTransparency(Effect, {
			transparency = 1,
			duration = BeamDuration,
			speed = 0,
			beamEasingStyle = Enum.EasingStyle.Sine,
			beamEasingDirection = Enum.EasingDirection.Out,
		});
	end
end


-- <- Public Functions -> --
function Shared.GetDisguiseConfiguration()
	return DisguiseConfiguration
end


function Shared.GetSkinName(AssetMeta)
	local AssetFolder = AssetMeta and AssetMeta.AssetFolder
	if not AssetFolder then
		return 'Normal'
	end

	local Parent = AssetFolder.Parent
	if Parent then
		return Parent.Name
	end

	return 'Normal'
end


function Shared.GetMoveModule(AssetMeta, BaseName: string)
	local SkinName = Shared.GetSkinName(AssetMeta);
	local VariantName = nil
	if SkinName == 'Spaghetti' then
		VariantName = BaseName .. '-Spaghetti'
	elseif SkinName == 'Anomaly' or SkinName == 'Mime' or SkinName == 'Molten' then
		VariantName = BaseName .. '-Anomaly'
	end

	if VariantName then
		local VariantModule = MoveFolder:FindFirstChild(VariantName);
		if VariantModule then
			return VariantModule
		end
	end

	return MoveFolder:FindFirstChild(BaseName);
end


function Shared.BroadcastMove(Target, ModuleScript, Payload)
	if not ModuleScript then
		return
	end

	ServerUtil.SendMove(Target or true, ModuleScript, 'Activate', Payload);
end


function Shared.GetPathPayload(Target)
	if not Target or not Target.Parent then
		return nil
	end

	return {Target.Parent, Target.Name}
end


function Shared.GetBaseAsset(AssetMeta, AssetName: string, Clone: boolean?)
	return AbilityUtil.GetAsset(AssetMeta, AssetName, Clone == true);
end


function Shared.GetDisguiseAsset(AssetMeta, AssetName: string, Clone: boolean?)
	return AbilityUtil.GetAsset(AssetMeta, AssetName, Clone == true, 'Disguise');
end


function Shared.PlayGrabLaunch(Character: Model, AssetMeta, CastPosition: Vector3?)
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return
	end

	local NormalAssets = ReplicatedStorage.Characters.Ennard.Normal.Assets
	local GrabEffect = Shared.GetBaseAsset(AssetMeta, 'GrabVFX') or NormalAssets:FindFirstChild('GrabVFX')
	local Wires = Shared.GetBaseAsset(AssetMeta, 'Wires', true);
	local WiresAnimation = Shared.GetBaseAsset(AssetMeta, 'Ennard_Pull_Wires') or NormalAssets:FindFirstChild('Ennard_Pull_Wires')
	if not Wires then
		local Template = NormalAssets:FindFirstChild('Wires');
		Wires = Template and Template:Clone()
	end

	local Fired = false
	local function FireCast()
		if Fired or not Root.Parent then
			return
		end
		Fired = true

		local Effect = GrabEffect and GrabEffect:Clone()
		if not Effect then
			return
		end
		local AimCFrame = GetAimCFrame(Root, CastPosition, 24);
		Effect.Parent = Root
		Effect.WorldCFrame = CFrame.lookAt(Effect.WorldPosition, AimCFrame.Position + AimCFrame.LookVector * 24)
		EmitEffect(Effect, 0.15, 0.2);
		Debris:AddItem(Effect, 1);
	end

	if not Wires then
		task.delay(0.68, FireCast);
		return
	end

	Wires.Name = 'EnnardGrabWires'
	Wires.Parent = IgnoreFolder
	PrepareEffectModel(Wires);
	local _, WireSize = Wires:GetBoundingBox();
	local WireOrigin = Root.Position + Vector3.new(0, -1.65, 0)
	local WireCFrame = GetAimCFrame(Root, CastPosition, 24, WireOrigin) * CFrame.Angles(0, math.rad(-90), 0)
	Wires:PivotTo(WireCFrame * CFrame.new(-WireSize.X * 0.5, 0, 0));
	local Animator = GetAnimator(Wires);
	local Track = Animator and WiresAnimation and ServerUtil.LoadAnimation(Animator, WiresAnimation)
	local Connection = nil
	if Track then
		Track.Priority = Enum.AnimationPriority.Action4
		Connection = Track.KeyframeReached:Connect(function(KeyframeName)
			if KeyframeName == 'Grab' then
				FireCast();
			end
		end);
		Track:Play(0);
	end

	task.delay(0.68, FireCast);
	task.delay(2, function()
		if Connection then
			Connection:Disconnect();
		end
		if Wires and Wires.Parent then
			Wires:Destroy();
		end
	end);
end


function Shared.PlayGrabImpact(Character: Model, TargetCharacter: Model, PullTrack, VictimAnimation)
	local Root = ServerUtil.GetRoot(Character);
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	local TargetTorso = GetCharacterPart(TargetCharacter, 'Torso', 'UpperTorso', 'HumanoidRootPart');
	if not Root or not TargetRoot or not TargetTorso then
		return
	end

	local VictimTrack = ServerUtil.LoadAnimation(TargetCharacter, VictimAnimation);
	if VictimTrack then
		VictimTrack.Priority = Enum.AnimationPriority.Action4
		VictimTrack:Play();
	end

	local MoveModule = MoveFolder:FindFirstChild('EnnardGrab');
	local VFXTemplate = MoveModule and MoveModule:FindFirstChild('VFX')
	if not VFXTemplate then
		return
	end

	local VFXModel = VFXTemplate:Clone();
	VFXModel.Parent = IgnoreFolder
	VFXModel:PivotTo(TargetRoot.CFrame);

	local VictimAttachments = {}
	local PlayerAttachments = {}
	local VictimFolder = VFXModel:FindFirstChild('VictimTorso');
	local PlayerFolder = VFXModel:FindFirstChild('PlayerTorso');
	if VictimFolder then
		for _, Attachment in VictimFolder:GetChildren() do
			if Attachment:IsA('Attachment') then
				Attachment.Parent = TargetTorso
				table.insert(VictimAttachments, Attachment);
			end
		end
	end
	if PlayerFolder then
		for _, Attachment in PlayerFolder:GetChildren() do
			if Attachment:IsA('Attachment') then
				Attachment.Parent = Root
				table.insert(PlayerAttachments, Attachment);
			end
		end
	end

	local EffectFolder = VFXModel:FindFirstChild('vfx');
	local FiredSteps = {}
	local HitCount = 0
	local Connections = {}
	local Cleaned = false
	local StepMap = {
		[1] = 1,
		[3] = 2,
		[5] = 3,
		[6] = 4,
		[7] = 5,
	}

	local function FireStep(StepIndex)
		if not StepIndex or FiredSteps[StepIndex] then
			return
		end
		FiredSteps[StepIndex] = true

		if StepIndex == 1 then
			EmitEffect(PlayerAttachments[1], nil, 1);
			EmitEffect(VictimAttachments[1], 0.7);
		elseif StepIndex == 2 then
			EmitEffect(VictimAttachments[2], 0.7);
			EmitEffect(EffectFolder and EffectFolder:FindFirstChild('Splatter1'), 0.7);
			EmitEffect(PlayerAttachments[2]);
		elseif StepIndex == 3 then
			EmitEffect(VictimAttachments[3], 0.3);
			EmitEffect(EffectFolder and EffectFolder:FindFirstChild('Splatter2'), 0.5);
			EmitEffect(PlayerAttachments[3]);
		elseif StepIndex == 4 then
			EmitEffect(VictimAttachments[4], 0.5);
		elseif StepIndex == 5 then
			EmitEffect(PlayerAttachments[4], nil, 0.5);
		end
	end

	local function HandleSignal(SignalName)
		local Normalized = string.lower(tostring(SignalName));
		if Normalized == 'hit' then
			HitCount += 1
			FireStep(StepMap[HitCount]);
			return
		end

		if Normalized == 'vfx1' then
			FireStep(1);
		elseif Normalized == 'vfx2' then
			FireStep(2);
		elseif Normalized == 'vfx3' then
			FireStep(3);
		elseif Normalized == 'vfx4' then
			FireStep(4);
		elseif Normalized == 'vfx5' then
			FireStep(5);
		end
	end

	local function BindTrack(Track)
		if not Track then
			return
		end

		table.insert(Connections, Track.KeyframeReached:Connect(HandleSignal));
		for _, MarkerName in ipairs({'hit', 'vfx1', 'vfx2', 'vfx3', 'vfx4', 'vfx5'}) do
			table.insert(Connections, Track:GetMarkerReachedSignal(MarkerName):Connect(function()
				HandleSignal(MarkerName);
			end));
		end
	end

	local function Cleanup()
		if Cleaned then
			return
		end
		Cleaned = true

		for _, Connection in Connections do
			Connection:Disconnect();
		end
		for _, Attachment in VictimAttachments do
			Debris:AddItem(Attachment, 2);
		end
		for _, Attachment in PlayerAttachments do
			Debris:AddItem(Attachment, 2);
		end
		Debris:AddItem(VFXModel, 2);
	end

	BindTrack(PullTrack);
	BindTrack(VictimTrack);
	for Index, DelayTime in ipairs({0.05, 0.18, 0.32, 0.46, 0.62}) do
		task.delay(DelayTime, function()
			FireStep(Index);
		end);
	end
	if PullTrack then
		PullTrack.Stopped:Once(Cleanup);
	end
	if VictimTrack then
		VictimTrack.Stopped:Once(Cleanup);
	end
	task.delay(2.2, Cleanup);
end


function Shared.TrimStoredDisguises(Character: Model)
	local List = StoredDisguises[Character]
	if not List then
		return
	end

	for Index = #List, 1, -1 do
		local TargetCharacter = List[Index]
		local Humanoid = TargetCharacter and TargetCharacter:FindFirstChildOfClass('Humanoid')
		if not TargetCharacter or not TargetCharacter.Parent or not Humanoid or Humanoid.Health > 0 then
			table.remove(List, Index);
		end
	end
end


function Shared.RegisterDisguise(Character: Model, TargetCharacter: Model)
	local Humanoid = TargetCharacter and TargetCharacter:FindFirstChildOfClass('Humanoid')
	if not TargetCharacter or not Humanoid or Humanoid.Health > 0 then
		return
	end

	local List = GetStoredDisguiseList(Character);
	for Index, StoredCharacter in ipairs(List) do
		if StoredCharacter == TargetCharacter then
			table.remove(List, Index);
			break
		end
	end

	table.insert(List, TargetCharacter);
end


function Shared.GetDisguiseSource(Character: Model)
	Shared.TrimStoredDisguises(Character);

	local List = StoredDisguises[Character]
	if List and #List > 0 then
		return List[#List]
	end

	for _, TargetCharacter in AliveFolder:GetChildren() do
		local Humanoid = TargetCharacter:FindFirstChildOfClass('Humanoid');
		if Humanoid and Humanoid.Health <= 0 then
			return TargetCharacter
		end
	end

	return nil
end


function Shared.GetForwardTarget(Character: Model, MaxDistance: number?, MinDot: number?)
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return nil
	end

	local Range = MaxDistance or GrabRange
	local DotThreshold = MinDot or GrabDot
	local Player = ServerUtil.GetPlayer(Character);
	local FlatLook = ServerUtil.GetFlatLookVector(Character, Player, Range);
	if not FlatLook then
		return nil
	end

	local BestTarget = nil
	local BestDistance = math.huge
	for _, TargetCharacter in ServerUtil.GetEnemyCharacters(Character) do
		local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
		if not TargetRoot then
			continue
		end

		local Offset = TargetRoot.Position - Root.Position
		local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z);
		local Distance = FlatOffset.Magnitude
		if Distance <= 0.01 or Distance > Range then
			continue
		end

		local Dot = FlatOffset.Unit:Dot(FlatLook);
		if Dot >= DotThreshold and Distance < BestDistance then
			BestTarget = TargetCharacter
			BestDistance = Distance
		end
	end

	return BestTarget, BestDistance
end


function Shared.GetLineTarget(Character: Model, MaxDistance: number?, Radius: number?, OriginOffset: CFrame?)
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return nil
	end

	local Range = MaxDistance or GrabRange
	local HitRadius = Radius or 4
	local OffsetCFrame = OriginOffset or CFrame.identity
	local Player = ServerUtil.GetPlayer(Character);
	local FlatLook = ServerUtil.GetFlatLookVector(Character, Player, Range + math.abs(OffsetCFrame.Position.Z));
	if not FlatLook then
		return nil
	end

	local OriginPosition = (Root.CFrame * OffsetCFrame).Position
	local BestTarget = nil
	local BestProjection = math.huge
	for _, TargetCharacter in ServerUtil.GetEnemyCharacters(Character) do
		local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
		if not TargetRoot then
			continue
		end

		local Offset = TargetRoot.Position - OriginPosition
		local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z);
		local Projection = FlatOffset:Dot(FlatLook);
		if Projection < -HitRadius or Projection > Range + HitRadius then
			continue
		end

		local SideDistance = (FlatOffset - FlatLook * Projection).Magnitude
		local HeightDistance = math.abs(TargetRoot.Position.Y - OriginPosition.Y);
		if SideDistance <= HitRadius and HeightDistance <= 6 and Projection < BestProjection then
			BestTarget = TargetCharacter
			BestProjection = Projection
		end
	end

	return BestTarget, BestProjection
end


function Shared.GetTinyHitboxTarget(Character: Model, Options)
	Options = Options or {}

	local Root = ServerUtil.GetRoot(Character);
	local EnemyFolder = ServerUtil.GetEnemyFolder(Character);
	if not Root or not EnemyFolder then
		return nil
	end

	local Range = Options.Range or GrabRange
	local HitboxSize = Options.Size or Vector3.new(4, 4, 4)
	if typeof(HitboxSize) == 'number' then
		HitboxSize = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
	end

	local Direction = nil
	if Options.AimPosition then
		local FlatAim = Vector3.new(Options.AimPosition.X, Root.Position.Y, Options.AimPosition.Z);
		local Offset = FlatAim - Root.Position
		if Offset.Magnitude > 0.1 then
			Direction = Offset.Unit
		end
	end
	Direction = Direction or Root.CFrame.LookVector
	Direction = Vector3.new(Direction.X, 0, Direction.Z)
	if Direction.Magnitude <= 0.01 then
		return nil
	end
	Direction = Direction.Unit

	local RootCFrame = CFrame.lookAt(Root.Position, Root.Position + Direction);
	local OriginPosition = (RootCFrame * (Options.OriginOffset or CFrame.identity)).Position
	local Spacing = Options.Spacing or math.max(math.min(HitboxSize.X, HitboxSize.Z) * 0.75, 1.75)
	local StartDistance = Options.StartDistance or 0
	local DebugLifetime = Options.DebugLifetime or 0.25
	local OverlapParameters = OverlapParams.new();
	OverlapParameters.FilterType = Enum.RaycastFilterType.Include
	OverlapParameters.FilterDescendantsInstances = { EnemyFolder }
	OverlapParameters.MaxParts = Options.MaxParts or 60

	local BestTarget = nil
	local BestDistance = math.huge
	local Seen = {}
	for Distance = StartDistance, Range, Spacing do
		local BoxPosition = OriginPosition + Direction * Distance
		local BoxCFrame = CFrame.lookAt(BoxPosition, BoxPosition + Direction);
		local Adornment = Instance.new('BoxHandleAdornment');
		Adornment.Adornee = workspace.Terrain
		Adornment.CFrame = BoxCFrame
		Adornment.Size = HitboxSize
		Adornment.Color3 = Color3.fromRGB(255, 80, 80)
		Adornment.Transparency = 0.65
		Adornment.AlwaysOnTop = false
		Adornment.ZIndex = 10
		Adornment.Parent = workspace.Terrain
		Debris:AddItem(Adornment, DebugLifetime);

		local Parts = workspace:GetPartBoundsInBox(BoxCFrame, HitboxSize, OverlapParameters);
		for _, Part in Parts do
			local TargetCharacter = Part:FindFirstAncestorWhichIsA('Model');
			if not TargetCharacter or Seen[TargetCharacter] or not EnemyFolder:IsAncestorOf(TargetCharacter) then
				continue
			end

			local TargetHumanoid = TargetCharacter:FindFirstChildOfClass('Humanoid');
			local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
			if not TargetHumanoid or TargetHumanoid.Health <= 0 or not TargetRoot then
				continue
			end

			Seen[TargetCharacter] = true
			local TargetDistance = (TargetRoot.Position - OriginPosition).Magnitude
			if TargetDistance < BestDistance then
				BestTarget = TargetCharacter
				BestDistance = TargetDistance
			end
		end
	end

	return BestTarget, BestDistance
end


function Shared.GetAttackTarget(Character: Model, Configuration, MoveName: string, Options)
	Options = Options or {}

	local Hitbox = HitboxManager.new(Character, Configuration, MoveName, {
		ContinueUntilFind = true,
		ContinueTimeout = Options.ContinueTimeout or 0.18,
		PollInterval = Options.PollInterval or 0.03,
		SortByDistance = Options.SortByDistance == nil and true or Options.SortByDistance,
		ModeOverride = Options.ModeOverride,
		ForcedSize = Options.ForcedSize,
		ForcedCFrame = Options.ForcedCFrame,
		ForcedRadius = Options.ForcedRadius,
		Projectile = Options.Projectile,
		TargetFolder = Options.TargetFolder,
		IgnoreList = Options.IgnoreList,
		Filter = Options.Filter,
		MaxParts = Options.MaxParts,
	});
	if not Hitbox then
		return nil
	end

	local HitModel = Hitbox:Activate();
	if typeof(HitModel) == 'table' then
		return HitModel[1]
	end

	return HitModel
end


function Shared.IsDisguised(Character: Model)
	return Character:GetAttribute('SkinStealer') or Character:HasTag('Imitation');
end


function Shared.GetDisguiseState(Character: Model)
	return ActiveDisguises[Character]
end


function Shared.SetStatsFromConfiguration(Character: Model, Configuration)
	if Configuration.Speed ~= nil then
		Character:SetAttribute('WalkSpeed', Configuration.Speed);
	end
	if Configuration.RunSpeed ~= nil then
		Character:SetAttribute('RunSpeed', Configuration.RunSpeed);
	end
	if Configuration.Regen ~= nil then
		Character:SetAttribute('Regen', Configuration.Regen);
	end
	if Configuration.StaminaDrain ~= nil then
		Character:SetAttribute('StaminaDrain', Configuration.StaminaDrain);
	end
	if Configuration.Stamina ~= nil then
		Character:SetAttribute('MaxStamina', Configuration.Stamina);
		Character:SetAttribute('Stamina', math.min(Character:GetAttribute('Stamina') or Configuration.Stamina, Configuration.Stamina));
	end
	if Configuration.Dodges ~= nil then
		Character:SetAttribute('Dodges', Configuration.Dodges);
	end
	if Configuration.ShieldMax ~= nil then
		Character:SetAttribute('ShieldMax', Configuration.ShieldMax);
		Character:SetAttribute('ShieldBlocksOverflow', Configuration.ShieldBlocksOverflow);
	end
end


function Shared.ClearDisguise(Character: Model, BaseConfiguration)
	local State = ActiveDisguises[Character]
	ActiveDisguises[Character] = nil
	Character:SetAttribute('SkinStealer', nil);
	Character:SetAttribute('SkinStealerSource', nil);
	if Character:HasTag('Imitation') then
		Character:RemoveTag('Imitation');
	end

	local Configuration = BaseConfiguration or (State and State.BaseConfiguration)
	if Configuration then
		Shared.SetStatsFromConfiguration(Character, Configuration);
	end

	return State
end


function Shared.ReduceDisguiseTime(Character: Model, Amount: number)
	local State = ActiveDisguises[Character]
	if not State then
		return
	end

	State.ExpiresAt = math.max(os.clock() + 1, (State.ExpiresAt or os.clock()) - math.abs(Amount or 0))
end


function Shared.StartDisguise(Character: Model, BaseConfiguration, SourceCharacter: Model)
	local DisguiseStats = {
		Speed = SourceCharacter and (SourceCharacter:GetAttribute('WalkSpeed') or DisguiseConfiguration.Speed) or DisguiseConfiguration.Speed,
		RunSpeed = SourceCharacter and (SourceCharacter:GetAttribute('RunSpeed') or DisguiseConfiguration.RunSpeed) or DisguiseConfiguration.RunSpeed,
		Stamina = SourceCharacter and (SourceCharacter:GetAttribute('MaxStamina') or DisguiseConfiguration.Stamina) or DisguiseConfiguration.Stamina,
		Regen = SourceCharacter and (SourceCharacter:GetAttribute('Regen') or DisguiseConfiguration.Regen) or DisguiseConfiguration.Regen,
		StaminaDrain = SourceCharacter and (SourceCharacter:GetAttribute('StaminaDrain') or DisguiseConfiguration.StaminaDrain) or DisguiseConfiguration.StaminaDrain,
		Dodges = SourceCharacter and (SourceCharacter:GetAttribute('Dodges') or DisguiseConfiguration.Dodges) or DisguiseConfiguration.Dodges,
		ShieldMax = SourceCharacter and (SourceCharacter:GetAttribute('ShieldMax') or DisguiseConfiguration.ShieldMax) or DisguiseConfiguration.ShieldMax,
		ShieldBlocksOverflow = SourceCharacter and (SourceCharacter:GetAttribute('ShieldBlocksOverflow') or DisguiseConfiguration.ShieldBlocksOverflow) or DisguiseConfiguration.ShieldBlocksOverflow,
	}

	local State = {
		BaseConfiguration = BaseConfiguration,
		Source = SourceCharacter,
		DisguiseStats = DisguiseStats,
		ExpiresAt = os.clock() + (BaseConfiguration.DisguiseDuration or 18),
		Token = os.clock(),
	}
	ActiveDisguises[Character] = State
	Character:SetAttribute('SkinStealer', true);
	Character:SetAttribute('SkinStealerSource', SourceCharacter and SourceCharacter.Name or nil);
	if not Character:HasTag('Imitation') then
		Character:AddTag('Imitation');
	end
	Shared.SetStatsFromConfiguration(Character, DisguiseStats);

	task.spawn(function()
		while Character.Parent and ActiveDisguises[Character] == State do
			if os.clock() >= (State.ExpiresAt or 0) then
				local Root = ServerUtil.GetRoot(Character);
				Shared.ClearDisguise(Character, BaseConfiguration);
				if Root then
					Shared.ExplodeAtPosition(Character, Root.Position, BaseConfiguration.Hitbox and BaseConfiguration.Hitbox.Explode or 12, BaseConfiguration.Damage and BaseConfiguration.Damage.Explode or 25);
				end
				break
			end

			task.wait(0.2);
		end
	end);

	return State
end


local function GetMinionRoot(Minion: Model)
	return Minion:FindFirstChild('HumanoidRootPart') or Minion.PrimaryPart
end

local function GetGroundedPosition(Position: Vector3, IgnoreList)
	local Params = RaycastParams.new();
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = IgnoreList or {IgnoreFolder, AliveFolder}

	local Result = workspace:Raycast(Position + Vector3.new(0, 8, 0), Vector3.new(0, -40, 0), Params);
	if Result then
		return Result.Position + Vector3.new(0, 1.5, 0)
	end

	return Position
end

local function GetMinionSpawnCFrame(Root: BasePart, XOffset: number, ForwardOffset: number)
	local Position = (Root.CFrame * CFrame.new(XOffset, 0, -(ForwardOffset or 5))).Position
	Position = GetGroundedPosition(Position, {Root.Parent, IgnoreFolder, AliveFolder});

	return CFrame.lookAt(Position, Position + Root.CFrame.LookVector)
end

local function PrepareMinionModel(Minion: Model, Root: BasePart?)
	if Root and not Minion.PrimaryPart then
		Minion.PrimaryPart = Root
	end

	for _, Descendant in ipairs(Minion:GetDescendants()) do
		if Descendant:IsA('BasePart') then
			Descendant.Anchored = false
			Descendant.CanCollide = false
			Descendant.Massless = true
			pcall(function()
				Descendant:SetNetworkOwner(nil);
			end);
		end
	end
end

local function SetMinionAnchored(State, Anchored: boolean)
	local Model = State and State.Model
	if not Model then
		return
	end

	for _, Descendant in ipairs(Model:GetDescendants()) do
		if Descendant:IsA('BasePart') then
			Descendant.Anchored = Anchored == true
			Descendant.AssemblyLinearVelocity = Vector3.zero
			Descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end
end

local function ClearMinionAttachment(State)
	local Weld = State and State.AttachWeld
	if not Weld then
		return
	end

	Weld:Destroy();
	State.AttachWeld = nil
end

local function PlayMinionSound(Root: BasePart?, SoundName: string)
	local Sound = Root and Root:FindFirstChild(SoundName);
	if Sound and Sound:IsA('Sound') then
		Sound:Play();
	end
end

local function PlayMinionAnimation(State, AnimationName: string, Looped: boolean?, FadeTime: number?)
	if not State.Animator or not State.AnimationFolder then
		return nil
	end

	local Animation = State.AnimationFolder:FindFirstChild(AnimationName);
	local Track = Animation and ServerUtil.LoadAnimation(State.Animator, Animation)
	if Track then
		Track.Priority = Enum.AnimationPriority.Action4
		Track.Looped = Looped == true
		Track:Play(FadeTime or 0);
	end

	return Track
end

local function StopMinionTrack(State, TrackName: string, FadeTime: number?)
	local Track = State[TrackName]
	if not Track then
		return
	end

	Track:Stop(FadeTime or 0);
	State[TrackName] = nil
end

local function StopMinionAnimations(State, FadeTime: number?)
	StopMinionTrack(State, 'SpawnTrack', FadeTime);
	StopMinionTrack(State, 'WalkTrack', FadeTime);
	StopMinionTrack(State, 'AttachTrack', FadeTime);
	if not State.Animator then
		return
	end

	for _, Track in State.Animator:GetPlayingAnimationTracks() do
		Track:Stop(FadeTime or 0);
	end
end

local function PlayMinionExplosion(State)
	if State.Exploded then
		return
	end
	State.Exploded = true

	StopMinionAnimations(State, 0.05);
	ClearMinionAttachment(State);
	SetMinionAnchored(State, true);
	PlayMinionSound(State.Root, 'Explode');
	PlayMinionAnimation(State, 'Explode');
	EmitEffect(State.Root and State.Root:FindFirstChild('ExplodeEffect'), 0.6, 0.65);
end

local function GetPathWaypoint(Root: BasePart, Destination: Vector3)
	local Path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 3,
		AgentCanJump = true,
	});

	local Success = pcall(function()
		Path:ComputeAsync(Root.Position, Destination);
	end);
	if not Success or Path.Status ~= Enum.PathStatus.Success then
		return nil
	end

	local Waypoints = Path:GetWaypoints();
	return Waypoints[2]
end

local function MoveMinion(State, Destination: Vector3)
	local Root = State.Root
	if not Root or not Destination then
		return
	end

	local Waypoint = GetPathWaypoint(Root, Destination)
	local MovePosition = Waypoint and Waypoint.Position or Destination
	if State.Humanoid then
		if Waypoint and Waypoint.Action == Enum.PathWaypointAction.Jump then
			State.Humanoid.Jump = true
		end
		State.Humanoid:MoveTo(MovePosition);
		return
	end

	local Direction = MovePosition - Root.Position
	if Direction.Magnitude <= 0.1 then
		return
	end

	State.Model:PivotTo(CFrame.lookAt(Root.Position + Direction.Unit * math.min(MinionWalkSpeed * MinionThinkRate, Direction.Magnitude), MovePosition));
end

local function GetMinionTarget(OwnerCharacter: Model, Root: BasePart)
	local EnemyFolder = ServerUtil.GetEnemyFolder(OwnerCharacter);
	if not EnemyFolder then
		return nil
	end

	return ServerUtil.GetNearestTarget(Root.Position, MinionAggroRange, EnemyFolder, function(_, _, TargetRoot)
		return TargetRoot ~= nil
	end);
end

local function GetWanderPosition(State, Index: number)
	local Root = State.Root
	if not Root then
		return nil
	end

	if State.WanderPosition and os.clock() < (State.WanderRefreshAt or 0) then
		if (State.WanderPosition - Root.Position).Magnitude > 5 then
			return State.WanderPosition
		end
	end

	local Seed = math.floor(os.clock() * 10) + Index * 37
	local Angle = math.rad((Seed * 57) % 360)
	local Distance = MinionWanderDistance + (Seed % 12)
	local Offset = Vector3.new(math.cos(Angle) * Distance, 0, math.sin(Angle) * Distance)
	State.WanderPosition = GetGroundedPosition(Root.Position + Offset, {State.Model, IgnoreFolder, AliveFolder});
	State.WanderRefreshAt = os.clock() + MinionWanderRefresh

	return State.WanderPosition
end

local function StartMinionMovement(State, Index: number)
	if not State.Active or State.Target then
		return
	end

	StopMinionTrack(State, 'SpawnTrack', 0.05);
	if State.Humanoid then
		State.Humanoid.WalkSpeed = MinionWalkSpeed
	end
	State.WalkTrack = PlayMinionAnimation(State, 'Walk', true, 0.1);
	PlayMinionSound(State.Root, 'Walking');
end

function Shared.GetMinionSpawnCFrame(Root: BasePart, XOffset: number?, ForwardOffset: number?)
	if not Root then
		return CFrame.identity
	end

	return GetMinionSpawnCFrame(Root, XOffset or 0, ForwardOffset or 5)
end


function Shared.DestroyMinionState(OwnerCharacter: Model, State, ExplosionDamage: number?)
	if not State or State.Destroyed then
		return
	end
	State.Destroyed = true
	State.Active = false

	local List = ActiveMinions[OwnerCharacter]
	if List then
		for Index, Entry in ipairs(List) do
			if Entry == State then
				table.remove(List, Index);
				break
			end
		end
		if #List == 0 then
			ActiveMinions[OwnerCharacter] = nil
		end
	end

	if not State.Model or not State.Model.Parent then
		return
	end

	if ExplosionDamage ~= nil then
		local Position = State.Root and State.Root.Position or State.Model:GetPivot().Position
		PlayMinionExplosion(State);
		if ExplosionDamage > 0 then
			Shared.ExplodeAtPosition(OwnerCharacter, Position, MinionExplosionRadius, ExplosionDamage);
		end
		Debris:AddItem(State.Model, 1.2);
		return
	end

	State.Model:Destroy();
end


function Shared.DestroyAllMinions(OwnerCharacter: Model)
	local List = ActiveMinions[OwnerCharacter]
	if not List then
		return
	end

	for Index = #List, 1, -1 do
		Shared.DestroyMinionState(OwnerCharacter, List[Index]);
	end
	ActiveMinions[OwnerCharacter] = nil
end


function Shared.ExplodeAtPosition(OwnerCharacter: Model, Position: Vector3, Radius: number, Damage: number)
	local EnemyFolder = ServerUtil.GetEnemyFolder(OwnerCharacter);
	if not EnemyFolder then
		return
	end

	for _, TargetCharacter in ServerUtil.GetTargetsInRadius(Position, Radius, EnemyFolder) do
		local Result = AbilityUtil.ApplyDamage(OwnerCharacter, TargetCharacter, Damage, {
			IgnoreParry = true,
			StunDuration = 1,
		});
		if Result.Died then
			Shared.RegisterDisguise(OwnerCharacter, TargetCharacter);
		end
	end
end


function Shared.AttachMinion(OwnerPlayer: Player, OwnerCharacter: Model, State, TargetCharacter: Model)
	if not State or not State.Active or State.Target or not TargetCharacter then
		return
	end

	local MinionRoot = State.Root
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	if not MinionRoot or not TargetRoot then
		return
	end

	State.Target = TargetCharacter
	State.Attached = true
	StopMinionAnimations(State, 0.05);
	ClearMinionAttachment(State);
	SetMinionAnchored(State, false);
	State.Model:PivotTo(TargetRoot.CFrame * CFrame.new(0, 1.35, -1.4));

	local Weld = Instance.new('WeldConstraint');
	Weld.Part0 = MinionRoot
	Weld.Part1 = TargetRoot
	Weld.Parent = MinionRoot
	State.AttachWeld = Weld

	if State.Humanoid then
		State.Humanoid.WalkSpeed = 0
		State.Humanoid.AutoRotate = false
		State.Humanoid:MoveTo(MinionRoot.Position);
	end
	State.AttachTrack = PlayMinionAnimation(State, 'Walk', true, 0.05);
	PlayMinionSound(State.Root, 'Lunge');
	PlayMinionSound(State.Root, 'Attached');
	task.spawn(function()
		for _ = 1, MinionTickCount do
			if not State.Active or State.Target ~= TargetCharacter then
				break
			end

			local MinionRoot = State.Root
			local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
			local TargetHumanoid = ServerUtil.GetHumanoid(TargetCharacter);
			if not MinionRoot or not TargetRoot or not TargetHumanoid or TargetHumanoid.Health <= 0 then
				break
			end

			for _ = 1, math.floor(MinionTickInterval / 0.1) do
				if not State.Active or State.Target ~= TargetCharacter then
					break
				end
				if not TargetRoot.Parent then
					break
				end
				if not State.AttachWeld then
					State.Model:PivotTo(TargetRoot.CFrame * CFrame.new(0, 1.35, -1.4));
				end
				task.wait(0.1);
			end

			if not State.Active or State.Target ~= TargetCharacter then
				break
			end

			AbilityUtil.LocateForPlayer(OwnerPlayer, TargetCharacter);
			local Result = AbilityUtil.ApplyDamage(OwnerCharacter, TargetCharacter, MinionTickDamage, {
				IgnoreParry = true,
				BlindDuration = 0.75,
				BlindIntensity = 0.2,
				SlowDuration = 2,
				SlowSpeed = 10,
			});
			if Result.Died then
				Shared.RegisterDisguise(OwnerCharacter, TargetCharacter);
				break
			end
		end

		Shared.DestroyMinionState(OwnerCharacter, State, MinionExplosionDamage);
	end);
end


function Shared.SpawnMinion(OwnerPlayer: Player, OwnerCharacter: Model, AssetMeta, Position, Index: number)
	local Minion = Shared.GetBaseAsset(AssetMeta, 'Minion', true);
	if not Minion then
		local Fallback = ReplicatedStorage.Characters.Ennard.Normal.Assets:FindFirstChild('Minion');
		if Fallback then
			Minion = Fallback:Clone()
		end
	end
	if not Minion then
		return nil
	end

	local SpawnCFrame = typeof(Position) == 'CFrame' and Position or CFrame.new(GetGroundedPosition(Position, {OwnerCharacter, IgnoreFolder, AliveFolder}));
	Minion.Name = string.format('%s_WireEye_%d', OwnerPlayer.Name, Index);
	Minion:PivotTo(SpawnCFrame);
	Minion.Parent = IgnoreFolder

	local Root = GetMinionRoot(Minion)
	local Humanoid = Minion:FindFirstChildOfClass('Humanoid');
	PrepareMinionModel(Minion, Root);
	if Humanoid then
		Humanoid.WalkSpeed = 0
		Humanoid.AutoRotate = true
	end

	local AnimationFolder = Minion:FindFirstChild('Animations');
	local Animator = Humanoid and Humanoid:FindFirstChildOfClass('Animator');
	local State = {
		Active = true,
		Model = Minion,
		Root = Root,
		Humanoid = Humanoid,
		Animator = Animator,
		AnimationFolder = AnimationFolder,
		AwakeAt = os.clock() + MinionActivationDelay,
	}
	table.insert(GetMinionList(OwnerCharacter), State);

	State.SpawnTrack = PlayMinionAnimation(State, Index % 2 == 0 and 'Spawning2' or 'Spawning1');
	task.delay(MinionActivationDelay, function()
		if not State.Active or State.Target then
			return
		end

		StartMinionMovement(State, Index);
	end);

	task.spawn(function()
		local StartedAt = os.clock()
		while State.Active and State.Model and State.Model.Parent and Root and os.clock() - StartedAt < MinionLifetime do
			if os.clock() < State.AwakeAt then
				task.wait(0.15);
			else
				local TargetCharacter = GetMinionTarget(OwnerCharacter, Root);
				if TargetCharacter then
					local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
					if TargetRoot then
						local Distance = (TargetRoot.Position - Root.Position).Magnitude
						if Distance <= MinionLatchRange then
							Shared.AttachMinion(OwnerPlayer, OwnerCharacter, State, TargetCharacter);
							return
						end

						State.WanderPosition = nil
						MoveMinion(State, TargetRoot.Position);
					end
				else
					MoveMinion(State, GetWanderPosition(State, Index));
				end

				task.wait(MinionThinkRate);
			end
		end

		Shared.DestroyMinionState(OwnerCharacter, State, MinionExplosionDamage);
	end);

	return State
end

-- <- Return -> --
return Shared