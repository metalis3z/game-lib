local BeartrapModule = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Public Variables -> --
local IgnoreFolder = workspace.IGNORE

-- <- Private Variables -> --
local TrapAssets = ReplicatedStorage.Characters.Springtrap.Normal.Assets:FindFirstChild('TrapAssets');
local TrapTemplate = TrapAssets and TrapAssets:FindFirstChild('Trap')
local BearTrapTemplate = TrapAssets and TrapAssets:FindFirstChild('BearTrap')
local TrapRemoveVictim = TrapAssets and TrapAssets:FindFirstChild('TrapRemoveVictim')
local TrapRemovePartner = TrapAssets and TrapAssets:FindFirstChild('TrapRemovePartner')

local PlacementCounter = 0
local ActiveTraps = setmetatable({}, {__mode = 'k'});

-- <- Private Functions -> --
local function GetTrapList(Character: Model)
	local List = ActiveTraps[Character]
	if List then
		return List
	end

	List = {}
	ActiveTraps[Character] = List
	return List
end

local function PruneTrapList(Character: Model)
	local List = ActiveTraps[Character]
	if not List then
		return 0
	end

	for Index = #List, 1, -1 do
		local State = List[Index]
		if not State or State.Destroyed or not State.Active then
			table.remove(List, Index);
		end
	end

	if #List == 0 then
		ActiveTraps[Character] = nil
	end

	return List and #List or 0
end

local function RefreshTrapAbility(AbilityMeta, Character: Model)
	if AbilityMeta and Character and Character.Parent then
		AbilityUtil.RefreshAbility(AbilityMeta, Character);
	end
end

local function GetTrapRadius(Configuration)
	return Configuration.Hitbox and Configuration.Hitbox.Beartrap or 3.5
end

local function GetFlatDirection(Direction: Vector3?)
	if typeof(Direction) ~= 'Vector3' then
		return nil
	end

	local FlatDirection = Vector3.new(Direction.X, 0, Direction.Z)
	if FlatDirection.Magnitude <= 0.001 then
		return nil
	end

	return FlatDirection.Unit
end

local function CreatePrompt(Parent: Instance, ActionText: string, HoldDuration: number)
	local Prompt = Instance.new('ProximityPrompt');
	Prompt.ActionText = ActionText
	Prompt.ObjectText = 'Bear Trap'
	Prompt.HoldDuration = HoldDuration
	Prompt.KeyboardKeyCode = Enum.KeyCode.F
	Prompt.MaxActivationDistance = 8
	Prompt.RequiresLineOfSight = false
	Prompt.Style = Enum.ProximityPromptStyle.Custom
	Prompt.Parent = Parent

	return Prompt
end

local function PrepareModel(Model: Model, Anchored: boolean)
	for _, Descendant in ipairs(Model:GetDescendants()) do
		if Descendant:IsA('BasePart') then
			Descendant.Anchored = Anchored
			Descendant.CanCollide = false
			Descendant.Massless = true
			pcall(function()
				Descendant:SetNetworkOwner(nil);
			end);
		end
	end
end

local function LockPlacement(Character: Model, Duration: number)
	PlacementCounter += 1

	local Token = PlacementCounter
	Character:SetAttribute('SpringtrapPlacingBeartrap', Token);
	AbilityUtil.SetBusy(Character, Duration);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', Duration);

	return Token
end

local function UnlockPlacement(Character: Model, Token: number)
	if not Character.Parent or Character:GetAttribute('SpringtrapPlacingBeartrap') ~= Token then
		return
	end

	Character:SetAttribute('SpringtrapPlacingBeartrap', nil);
	AbilityUtil.ClearBusy(Character);
	AbilityUtil.ClearTimedTag(Character, 'CantMove');
end

local function DestroyTrapState(OwnerCharacter: Model, State)
	if not State or State.Destroyed then
		return
	end

	State.Destroyed = true
	State.Active = false

	for _, Connection in ipairs(State.Connections or {}) do
		Connection:Disconnect();
	end

	local List = ActiveTraps[OwnerCharacter]
	if List then
		for Index, Entry in ipairs(List) do
			if Entry == State then
				table.remove(List, Index);
				break
			end
		end

		if #List == 0 then
			ActiveTraps[OwnerCharacter] = nil
		end
	end

	if State.AttachedTrap and State.AttachedTrap.Parent then
		State.AttachedTrap:Destroy();
	end
	if State.Model and State.Model.Parent then
		State.Model:Destroy();
	end

	RefreshTrapAbility(State.AbilityMeta, OwnerCharacter);
end

local function ReleaseTrappedTarget(State)
	if State.Target and State.Target.Parent then
		State.Target:SetAttribute('Stun', false);
		State.Target:SetAttribute('SpringtrapBeartrapped', nil);
		if State.Target:HasTag('CantMove') then
			State.Target:RemoveTag('CantMove');
		end
	end

	DestroyTrapState(State.OwnerCharacter, State);
end

local function GetTargetLeg(TargetCharacter: Model)
	return TargetCharacter:FindFirstChild('Right Leg') or TargetCharacter:FindFirstChild('Left Leg') or ServerUtil.GetRoot(TargetCharacter)
end

local function PlayFreeAnimations(State, HelperCharacter: Model)
	if TrapRemoveVictim and State.Target and State.Target.Parent then
		local VictimTrack = ServerUtil.LoadAnimation(State.Target, TrapRemoveVictim);
		if VictimTrack then
			VictimTrack:Play();
		end
	end
	if TrapRemovePartner and HelperCharacter and HelperCharacter.Parent then
		local HelperTrack = ServerUtil.LoadAnimation(HelperCharacter, TrapRemovePartner);
		if HelperTrack then
			HelperTrack:Play();
		end
	end
end

local function AttachTrapToTarget(State, TargetCharacter: Model)
	if not BearTrapTemplate then
		return
	end

	local Leg = GetTargetLeg(TargetCharacter);
	if not Leg then
		return
	end

	local BearTrap = BearTrapTemplate:Clone();
	local Root = BearTrap:FindFirstChild('RootPart') or BearTrap.PrimaryPart or BearTrap:FindFirstChildWhichIsA('BasePart', true);
	if not Root then
		BearTrap:Destroy();
		return
	end

	BearTrap.Parent = IgnoreFolder
	PrepareModel(BearTrap, false);
	BearTrap:PivotTo(Leg.CFrame * CFrame.new(0, -0.35, 0));

	local Weld = Instance.new('WeldConstraint');
	Weld.Part0 = Leg
	Weld.Part1 = Root
	Weld.Parent = Root

	State.AttachedTrap = BearTrap
	State.Target = TargetCharacter
	TargetCharacter:SetAttribute('SpringtrapBeartrapped', true);

	local FreePrompt = CreatePrompt(Root, 'Free', 2.5);
	table.insert(State.Connections, FreePrompt.Triggered:Connect(function(HelperPlayer: Player)
		local HelperCharacter = HelperPlayer.Character
		if not HelperCharacter or HelperCharacter == TargetCharacter then
			return
		end
		if HelperCharacter.Parent ~= ServerUtil.GetEnemyFolder(State.OwnerCharacter) then
			return
		end

		AbilityUtil.PlayAssetSound(State.AssetMeta, HelperCharacter, 'Trap Help');
		PlayFreeAnimations(State, HelperCharacter);
		ReleaseTrappedTarget(State);
	end));
end

local function TriggerTrap(State, TargetCharacter: Model)
	if not State or State.Destroyed or State.Triggered then
		return
	end

	State.Triggered = true

	if State.Model and State.Model.Parent then
		State.Model:Destroy();
		State.Model = nil
	end

	AbilityUtil.PlayAssetSound(State.AssetMeta, TargetCharacter, 'TrapTrigger');
	AbilityUtil.ApplyDamage(State.OwnerCharacter, TargetCharacter, State.Configuration.Damage and State.Configuration.Damage.Beartrap or 15, {
		IgnoreParry = true,
	});
	AbilityUtil.ApplyStun(TargetCharacter, State.Configuration.BeartrapStun or 8);
	AttachTrapToTarget(State, TargetCharacter);

	task.delay(State.Configuration.BeartrapStun or 8, function()
		if State.Active and not State.Destroyed then
			ReleaseTrappedTarget(State);
		end
	end);
end

local function StartTrapWatcher(State)
	task.spawn(function()
		while State.Active and not State.Destroyed and not State.Triggered do
			local Core = State.Core
			if not Core or not Core.Parent then
				break
			end

			local Radius = GetTrapRadius(State.Configuration)
			local Target = ServerUtil.GetNearestTarget(Core.Position, Radius, ServerUtil.GetEnemyFolder(State.OwnerCharacter), function(_, _, Root, Distance)
				return Root and Distance <= Radius and math.abs(Root.Position.Y - Core.Position.Y) <= 5
			end);
			if Target then
				TriggerTrap(State, Target);
				return
			end

			task.wait(0.1);
		end
	end);
end

local function GetPlacement(Character: Model, Configuration)
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return nil
	end

	local Params = RaycastParams.new();
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {Character, IgnoreFolder}

	local Direction = GetFlatDirection(Root.CFrame.LookVector) or Vector3.new(0, 0, -1)
	local CastBase = Root.Position + Direction * (Configuration.TrapForwardOffset or 3.25)
	local Raycast = workspace:Raycast(CastBase + Vector3.new(0, 3, 0), Vector3.new(0, -12, 0), Params);
	local Position = Raycast and Raycast.Position or CastBase - Vector3.new(0, 2.5, 0)

	return Position, Direction
end

local function PlaceTrap(Player: Player, Character: Model, Configuration, AssetMeta, AbilityMeta)
	local Position, Direction = GetPlacement(Character, Configuration);
	if not Position or not Direction then
		return
	end

	local TrapModel = TrapTemplate:Clone();
	TrapModel.Parent = IgnoreFolder
	PrepareModel(TrapModel, true);
	TrapModel:PivotTo(CFrame.lookAt(Position + Vector3.new(0, 0.05, 0), Position + Direction));

	local Core = TrapModel:FindFirstChild('Core', true) or TrapModel:FindFirstChildWhichIsA('BasePart', true);
	if not Core then
		TrapModel:Destroy();
		return
	end

	local State = {
		Active = true,
		Connections = {},
		OwnerCharacter = Character,
		OwnerPlayer = Player,
		Configuration = Configuration,
		AssetMeta = AssetMeta,
		AbilityMeta = AbilityMeta,
		Model = TrapModel,
		Core = Core,
	}
	table.insert(GetTrapList(Character), State);
	RefreshTrapAbility(AbilityMeta, Character);

	local ReclaimPrompt = CreatePrompt(Core, 'Reclaim', 3.5);
	local DisarmPrompt = CreatePrompt(Core, 'Disarm', 15);
	table.insert(State.Connections, ReclaimPrompt.Triggered:Connect(function(TriggeringPlayer: Player)
		if TriggeringPlayer == Player then
			DestroyTrapState(Character, State);
		end
	end));
	
	table.insert(State.Connections, DisarmPrompt.Triggered:Connect(function(TriggeringPlayer: Player)
		local HelperCharacter = TriggeringPlayer.Character
		if not HelperCharacter or HelperCharacter.Parent ~= ServerUtil.GetEnemyFolder(Character) then
			return
		end

		DestroyTrapState(Character, State);
	end));

	StartTrapWatcher(State);
end

-- <- Public Functions -> --
function BeartrapModule.GetCurrentTraps(Character: Model)
	return PruneTrapList(Character)
end

function BeartrapModule.Beartrap(Player: Player, CharacterMeta, AssetMeta, AbilityMeta)
	local Character = Player.Character
	if not Character or not CharacterMeta or not CharacterMeta.Configuration then
		return
	end
	if not AbilityUtil.CanUseAbility(Character) then
		return
	end
	if not TrapTemplate then
		return
	end

	local Configuration = CharacterMeta.Configuration
	local TrapCount = PruneTrapList(Character)
	if TrapCount >= (Configuration.MaxTraps or 3) then
		return
	end

	local PlaceDelay = Configuration.TrapPlaceDelay or 1.7
	local LockDuration = Configuration.TrapPlacementLock or PlaceDelay + 1.25
	local PlacementToken = LockPlacement(Character, LockDuration);
	local Track = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset('TrapPlace'));
	local Placed = false
	local MarkerConnection = nil

	local function DropTrap()
		if Placed then
			return
		end

		Placed = true
		if MarkerConnection then
			MarkerConnection:Disconnect();
		end

		PlaceTrap(Player, Character, Configuration, AssetMeta, AbilityMeta);
	end

	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Trap');
	if Track then
		Track.Priority = Enum.AnimationPriority.Action4
		Track.Looped = false
		Track:Play();

		MarkerConnection = Track:GetMarkerReachedSignal('Place'):Once(DropTrap);
	end

	task.delay(PlaceDelay, DropTrap);

	task.delay(LockDuration + 0.25, function()
		if MarkerConnection then
			MarkerConnection:Disconnect();
		end
	end);
	
	task.delay(Track.Length, function()
		UnlockPlacement(Character, PlacementToken);
	end)
end

-- <- Return -> --
return BeartrapModule