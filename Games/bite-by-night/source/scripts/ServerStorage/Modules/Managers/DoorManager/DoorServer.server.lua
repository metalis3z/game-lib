-- <- Services -> --
local Debris = game:GetService('Debris');
local Players = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local TweenService = game:GetService('TweenService');

-- <- Modules -> --
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local KillerFolder = workspace.PLAYERS.KILLER

-- <- Private Variables -> --
local RuntimeFolder = script.Parent
local Container = RuntimeFolder.Parent
local Door = Container:FindFirstChild('Door');
if not Door or not Door:IsA('Model') or not Door:FindFirstChild('Root') then
	Door = Container
end

local Root = Door:FindFirstChild('Root');
local Trigger = Door:FindFirstChild('Trigger');
local AssetServer = script
local SharedServer = nil

local BarricadeCooldown = 8
local MaxHits = 3
local CancelDistance = 9
local HitDebounce = 0.75
local HitPressure = 18
local BreakHP = 8
local KillerHitLag = 0.65
local KillerBreakLag = 0.9
local KnockbackTime = 1.15
local SafeKnockbackTime = 0.45
local BoxStart = 0.3
local BoxShrink = 0.055
local BoxMin = 0.105
local DoorOpenDistance = 8
local DoorCloseDelay = 3.25
local DoorStunDistance = 4.75
local DoorStunTime = 0.45
local DoorStunCooldown = 1.25
local DoorMoveGrace = 0.45
local BarricadeRayHeight = 8
local BarricadeRayDepth = 20
local DoorOpenAngle = math.rad(95)
local DoorWalkTweenInfo = TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local DoorRunTweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local DoorCloseTweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local DoorKickCooldown = 0.75
local BrokenDoorTravel = 18
local BrokenDoorHeight = 2.5
local BrokenDoorTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local ContestReleaseDelay = 1.25

local Holder = nil
local HolderCharacter = nil
local Gui = nil
local Event = nil
local EventConnection = nil
local HPConnection = nil
local StartTrack = nil
local IdleTrack = nil
local LoopSound = nil
local Hits = 0
local HP = 100
local Token = 0
local Broken = false
local LastHit = nil
local Connections = {}
local OriginalParts = {}
local DoorMotors = {}
local DoorOpened = false
local DoorPresenceStamp = 0
local LastDoorStun = 0
local BrokenDoorVisual = nil
local BrokenDoorConnection = nil
local BrokenDoorJoints = {}
local LastDoorKick = 0
local LastDoorHit = nil
local PublicRoot = nil

-- <- Private Functions -> --
local function GetDoorModel(DoorContainer: Model)
	local DoorModel = DoorContainer:FindFirstChild('Door');
	if DoorModel and DoorModel:IsA('Model') and DoorModel:FindFirstChild('Root') then
		return DoorModel
	end

	if DoorContainer:FindFirstChild('Root') then
		return DoorContainer
	end

	return nil
end

local function GetServerAsset(DoorContainer: Model, DoorModel: Model)
	local DoorScripts = DoorContainer:FindFirstChild('DoorScripts');
	local RuntimeServer = DoorScripts and DoorScripts:FindFirstChild('Server')
	if RuntimeServer and RuntimeServer:IsA('Script') then
		return RuntimeServer
	end

	return DoorContainer:FindFirstChild('Server') or DoorModel:FindFirstChild('Server')
end

local function FindSharedServerAsset()
	local Current = Container.Parent
	while Current and Current ~= game do
		local Doors = Current:FindFirstChild('Doors');
		if Doors then
			for _, DoorContainer in Doors:GetChildren() do
				if not DoorContainer:IsA('Model') then
					continue
				end

				local DoorModel = GetDoorModel(DoorContainer);
				local Server = DoorModel and GetServerAsset(DoorContainer, DoorModel)
				if Server and Server:FindFirstChild('Dot') then
					return Server
				end
			end
		end

		Current = Current.Parent
	end

	return nil
end

local function AddConnection(Connection: RBXScriptConnection)
	Connections[#Connections + 1] = Connection
end

local function SetDoorAttribute(AttributeName: string, AttributeValue: any)
	Door:SetAttribute(AttributeName, AttributeValue);
	if Container ~= Door then
		Container:SetAttribute(AttributeName, AttributeValue);
	end
end

local function EnsurePublicRoot()
	if Container == Door or Container:FindFirstChild('Root') then
		return
	end

	PublicRoot = Instance.new('Part');
	PublicRoot.Name = 'Root'
	PublicRoot.Size = Root.Size
	PublicRoot.CFrame = Root.CFrame
	PublicRoot.Anchored = true
	PublicRoot.CanCollide = false
	PublicRoot.CanQuery = false
	PublicRoot.CanTouch = false
	PublicRoot.Transparency = 1
	PublicRoot.Parent = Container
end

local function SyncPublicRoot()
	if PublicRoot and PublicRoot.Parent then
		PublicRoot.CFrame = Root.CFrame
	end
end

local function ApplyTimedTag(Character: Model, TagName: string, Duration: number)
	local Attribute = `{TagName}DoorCount`
	local Count = (Character:GetAttribute(Attribute) or 0) + 1
	Character:SetAttribute(Attribute, Count);

	if not Character:HasTag(TagName) then
		Character:AddTag(TagName);
	end

	task.delay(Duration, function()
		if not Character.Parent then
			return
		end

		local CurrentCount = math.max((Character:GetAttribute(Attribute) or 1) - 1, 0)
		Character:SetAttribute(Attribute, CurrentCount);
		if CurrentCount <= 0 and Character:HasTag(TagName) then
			Character:RemoveTag(TagName);
		end
	end);
end

local function ApplyTimedStun(Character: Model, Duration: number)
	Character:SetAttribute('Running', false);
	Character:SetAttribute('Stun', true);
	ApplyTimedTag(Character, 'CantMove', Duration);

	task.delay(Duration, function()
		if Character.Parent then
			Character:SetAttribute('Stun', false);
		end
	end);
end

local function GetCharacterSide(Character: Model)
	local CharacterRoot = ServerUtil.GetRoot(Character);
	if not CharacterRoot then
		return nil
	end

	local Position1 = Door:FindFirstChild('Position1');
	local Position2 = Door:FindFirstChild('Position2');
	if Position1 and Position2 then
		local Distance1 = (CharacterRoot.Position - Position1.Position).Magnitude
		local Distance2 = (CharacterRoot.Position - Position2.Position).Magnitude

		return Distance1 <= Distance2 and Position1 or Position2
	end

	return nil
end

local function IsDoorLeaf(Part: BasePart)
	local Name = Part.Name
	return Name == 'Door'
		or Name == 'Door1'
		or Name == 'Door2'
		or string.find(Name, 'Door Base') ~= nil
		or string.find(Name, 'Door Handle') ~= nil
end

local function IsDoorPanel(Part: BasePart)
	local Name = Part.Name
	if Name == 'Frame' or Name == 'Door Frame' or Name == 'Root' or Name == 'Trigger' or Name == 'Position1' or Name == 'Position2' or Name == 'VFX' then
		return false
	end

	return IsDoorLeaf(Part) or Part.CanCollide or string.find(Name, 'Door') ~= nil
end

local function IsDoorCollider(Part: BasePart)
	local Name = Part.Name
	return Name == 'Door' or Name == 'Door1' or Name == 'Door2'
end

local function SetDoorCollision(Enabled: boolean)
	for Part in OriginalParts do
		if Part.Parent and IsDoorCollider(Part) then
			Part.CanCollide = Enabled and not Broken
			Part.CanTouch = Enabled and not Broken
			Part.CanQuery = Enabled and not Broken
		end
	end
end

local function SetJointEnabled(Joint: Instance, Enabled: boolean)
	pcall(function()
		Joint.Enabled = Enabled
	end);
end

local function ClearBrokenDoorVisual()
	if BrokenDoorConnection then
		BrokenDoorConnection:Disconnect();
		BrokenDoorConnection = nil
	end

	if BrokenDoorVisual and BrokenDoorVisual.Parent then
		BrokenDoorVisual:Destroy();
	end
	BrokenDoorVisual = nil

	for _, Joint in BrokenDoorJoints do
		if Joint.Parent then
			SetJointEnabled(Joint, true);
		end
	end
	table.clear(BrokenDoorJoints);
end

local function GetDoorBreakDirection(KillerPlayer: Player?)
	local Character = KillerPlayer and KillerPlayer.Character
	local CharacterRoot = Character and ServerUtil.GetRoot(Character)
	if CharacterRoot and Root then
		local Offset = Root.Position - CharacterRoot.Position
		local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z)
		if FlatOffset.Magnitude > 0.05 then
			return FlatOffset.Unit
		end
	end

	return Root and Root.CFrame.LookVector or Vector3.zAxis
end

local function GetBrokenDoorParts()
	local Parts = {}
	for Part in OriginalParts do
		if Part.Parent and IsDoorLeaf(Part) then
			Parts[#Parts + 1] = Part
		end
	end

	return Parts
end

local function DisableBrokenDoorJoints(Parts: {BasePart})
	local Lookup = {}
	for _, Part in Parts do
		Lookup[Part] = true
	end

	for _, Descendant in Door:GetDescendants() do
		if Descendant:IsA('JointInstance') then
			if Lookup[Descendant.Part0] or Lookup[Descendant.Part1] then
				BrokenDoorJoints[#BrokenDoorJoints + 1] = Descendant
				SetJointEnabled(Descendant, false);
			end
		elseif Descendant:IsA('Constraint') then
			local _, Attachment0 = pcall(function()
				return Descendant.Attachment0
			end);
			local _, Attachment1 = pcall(function()
				return Descendant.Attachment1
			end);
			if (Attachment0 and Lookup[Attachment0.Parent]) or (Attachment1 and Lookup[Attachment1.Parent]) then
				BrokenDoorJoints[#BrokenDoorJoints + 1] = Descendant
				SetJointEnabled(Descendant, false);
			end
		end
	end
end

local function SetBrokenDoorParts(Parts: {BasePart}, Enabled: boolean)
	for _, Part in Parts do
		local Information = OriginalParts[Part]
		Part.Transparency = Information and Information.Transparency or Part.Transparency
		Part.Anchored = Enabled
		Part.Massless = true
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.AssemblyLinearVelocity = Vector3.zero
		Part.AssemblyAngularVelocity = Vector3.zero
	end
end
local function ReleaseBrokenDoorParts(Parts: {BasePart}, Direction: Vector3)
	for _, Part in Parts do
		if not Part.Parent then
			continue
		end

		Part.Anchored = false
		Part.Massless = true
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.AssemblyLinearVelocity = Direction * 55 + Vector3.yAxis * 8
		Part.AssemblyAngularVelocity = Vector3.new(math.random(-8, 8), math.random(-12, 12), math.random(-8, 8))
		pcall(function()
			Part:SetNetworkOwner(nil);
		end);
	end
end

local function LaunchBrokenDoor(KillerPlayer: Player?)
	ClearBrokenDoorVisual();

	local Parts = GetBrokenDoorParts();
	if #Parts <= 0 then
		return
	end

	local StartPivot = Root and Root.CFrame or Door:GetPivot()
	local Offsets = {}
	for _, Part in Parts do
		Offsets[Part] = StartPivot:ToObjectSpace(Part.CFrame)
	end

	DisableBrokenDoorJoints(Parts);
	SetBrokenDoorParts(Parts, true);

	local Direction = GetDoorBreakDirection(KillerPlayer)
	local EndPivot = StartPivot + Direction * BrokenDoorTravel + Vector3.yAxis * BrokenDoorHeight
	EndPivot *= CFrame.Angles(math.rad(math.random(-16, 16)), math.rad(math.random(-22, 22)), math.rad(math.random(-12, 12)))

	local Pivot = Instance.new('CFrameValue');
	Pivot.Value = StartPivot
	Pivot.Parent = Door
	BrokenDoorVisual = Pivot

	BrokenDoorConnection = Pivot:GetPropertyChangedSignal('Value'):Connect(function()
		for Part, Offset in Offsets do
			if Part.Parent then
				Part.CFrame = Pivot.Value * Offset
			end
		end
	end)

	TweenService:Create(Pivot, BrokenDoorTweenInfo, {
		Value = EndPivot
	}):Play();

	task.delay(BrokenDoorTweenInfo.Time, function()
		if BrokenDoorConnection then
			BrokenDoorConnection:Disconnect();
			BrokenDoorConnection = nil
		end
		for Part, Offset in Offsets do
			if Part.Parent then
				Part.CFrame = Pivot.Value * Offset
			end
		end
		ReleaseBrokenDoorParts(Parts, Direction);
		if Pivot.Parent then
			Pivot:Destroy();
		end
		if BrokenDoorVisual == Pivot then
			BrokenDoorVisual = nil
		end
	end);
end

local function IsAliveCharacter(Character: Model?)
	return Character and AliveFolder:IsAncestorOf(Character)
end

local function IsKillerCharacter(Character: Model?)
	return Character and KillerFolder:IsAncestorOf(Character)
end

local function SetPromptState(Prompt: ProximityPrompt?)
	if not Prompt then
		return
	end

	if Broken then
		Prompt.Enabled = false
		Prompt.ActionText = 'Broken'
	elseif Holder then
		Prompt.Enabled = true
		Prompt.ActionText = 'Barge'
	else
		Prompt.Enabled = true
		Prompt.ActionText = 'Barricade'
	end
end

local function EnsurePrompt()
	if not Root then
		return nil
	end

	local Attachment = Root:FindFirstChild('Attachment');
	if not Attachment then
		Attachment = Instance.new('Attachment');
		Attachment.Name = 'Attachment'
		Attachment.Parent = Root
	end

	local Prompt = Attachment:FindFirstChildOfClass('ProximityPrompt');
	if not Prompt then
		Prompt = Instance.new('ProximityPrompt');
		Prompt.Parent = Attachment
	end

	Prompt.ActionText = 'Barricade'
	Prompt.ObjectText = 'Door'
	Prompt.HoldDuration = 0
	Prompt.KeyboardKeyCode = Enum.KeyCode.F
	Prompt.GamepadKeyCode = Enum.KeyCode.ButtonX
	Prompt.MaxActivationDistance = 7.5
	Prompt.RequiresLineOfSight = false
	Prompt.Style = Enum.ProximityPromptStyle.Custom
	Prompt.Enabled = true

	return Prompt
end

local function SetDoorBlocking(Enabled: boolean)
	if Trigger then
		Trigger.CanCollide = false
		Trigger.CanTouch = not Broken
		Trigger.CanQuery = not Broken
		Trigger.Transparency = 1
	end

	SetDoorAttribute('HOLD', Enabled);
end

local function PlaySound(SoundName: string, Looped: boolean?)
	local Sound = Root and Root:FindFirstChild(SoundName)
	local SFX = AssetServer and AssetServer:FindFirstChild('SFX') or (SharedServer and SharedServer:FindFirstChild('SFX'))
	Sound = Sound or (SFX and SFX:FindFirstChild(SoundName))
	if not Sound or not Sound:IsA('Sound') then
		return nil
	end

	local Clone = Sound:Clone();
	Clone.Looped = Looped == true
	Clone.Parent = Root or Door
	Clone:Play();

	if not Clone.Looped then
		Debris:AddItem(Clone, math.max(Clone.TimeLength / math.max(Clone.PlaybackSpeed, 0.01), 2));
	end

	return Clone
end

local function StopSound(Sound: Sound?)
	if not Sound then
		return
	end

	Sound:Stop();
	Sound:Destroy();
end

local function GetAnimation(AnimationName: string)
	local Anims = AssetServer and AssetServer:FindFirstChild('Anims') or (SharedServer and SharedServer:FindFirstChild('Anims'))
	local Animation = Anims and Anims:FindFirstChild(AnimationName)
	Animation = Animation or (AssetServer and AssetServer:FindFirstChild(AnimationName))
	Animation = Animation or (SharedServer and SharedServer:FindFirstChild(AnimationName))

	return Animation
end

local function PlayAnimation(Character: Model?, AnimationName: string, Looped: boolean?)
	if not Character then
		return nil
	end

	local Animation = GetAnimation(AnimationName);
	if not Animation then
		return nil
	end

	local Track = ServerUtil.LoadAnimation(Character, Animation);
	if not Track then
		return nil
	end

	Track.Looped = Looped == true
	Track:Play();

	return Track
end

local function StopTrack(Track: AnimationTrack?)
	if Track and Track.IsPlaying then
		Track:Stop(0.15);
	end
end

local function GetDotTemplate()
	local DotTemplate = AssetServer and AssetServer:FindFirstChild('Dot');
	if DotTemplate then
		return DotTemplate
	end

	local UI = AssetServer and AssetServer:FindFirstChild('UI');
	if UI and UI:IsA('ObjectValue') and UI.Value and UI.Value:IsA('ScreenGui') then
		return UI.Value
	end

	return SharedServer and SharedServer:FindFirstChild('Dot')
end

local function SetContestSize()
	if not Gui then
		return
	end

	local ContainerFrame = Gui:FindFirstChild('Container');
	local Box = ContainerFrame and ContainerFrame:FindFirstChild('Box')
	if not Box then
		return
	end

	local Size = math.clamp(BoxStart - (Hits * BoxShrink), BoxMin, BoxStart);
	Box.Size = UDim2.fromScale(Size, Size);
end

local function ConfigureDoorMotors()
	table.clear(DoorMotors);

	for _, Descendant in Door:GetDescendants() do
		if not Descendant:IsA('Motor6D') then
			continue
		end
		if not Descendant.Part1 or not string.find(Descendant.Part1.Name, 'Door Base') then
			continue
		end

		local Direction = string.find(Descendant.Name, '2') and -1 or 1
		table.insert(DoorMotors, {
			Motor = Descendant,
			ClosedC0 = Descendant.C0,
			Direction = Direction,
		});
	end
end

local function GetClosestDoorCharacter()
	local ClosestCharacter = nil
	local ClosestDistance = DoorOpenDistance
	for _, Folder in {AliveFolder, KillerFolder} do
		for _, Character in Folder:GetChildren() do
			local CharacterRoot = ServerUtil.GetRoot(Character);
			if not CharacterRoot then
				continue
			end

			local Distance = (CharacterRoot.Position - Root.Position).Magnitude
			if Distance < ClosestDistance then
				ClosestCharacter = Character
				ClosestDistance = Distance
			end
		end
	end

	return ClosestCharacter
end

local function GetDoorTouchCharacter(Part: BasePart)
	local Character = ServerUtil.GetCharacter(Part);
	if IsAliveCharacter(Character) or IsKillerCharacter(Character) then
		return Character
	end

	return nil
end

local function GetOpenDirection(Character: Model?)
	local CharacterRoot = Character and ServerUtil.GetRoot(Character)
	if not CharacterRoot then
		return 1
	end

	local Difference = Root.Position - CharacterRoot.Position
	if Difference.Magnitude <= 0 then
		return 1
	end

	return Difference.Unit:Dot(Root.CFrame.LookVector) >= 0 and 1 or -1
end

local function IsRunningIntoDoor(Character: Model?)
	local CharacterRoot = Character and ServerUtil.GetRoot(Character)
	if not CharacterRoot then
		return false
	end

	local Velocity = CharacterRoot.AssemblyLinearVelocity
	local FlatVelocity = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude
	if FlatVelocity < 8 then
		return false
	end

	return Character:GetAttribute('Running') == true or FlatVelocity >= 18
end

local function GetFallbackDoorKickAnimation()
	local Characters = ReplicatedStorage:FindFirstChild('Characters');
	local Springtrap = Characters and Characters:FindFirstChild('Springtrap');
	local Normal = Springtrap and Springtrap:FindFirstChild('Normal');
	local Assets = Normal and Normal:FindFirstChild('Assets');
	local Kicks = Assets and Assets:FindFirstChild('Kicks');

	return Kicks and Kicks:FindFirstChild('DoorKick1')
end

local function GetRunStartAnimation(Character: Model?)
	local Player = Character and ServerUtil.GetPlayer(Character)
	local AssetMeta = Player and AssetManager.Player[Player]
	local Animate = AssetMeta and AssetMeta.AssetFolder and AssetMeta.AssetFolder:FindFirstChild('Animate')
	local RunStart = Animate and Animate:FindFirstChild('runStart')

	return RunStart and RunStart:FindFirstChildOfClass('Animation')
end

local function GetCharacterDoorBumpAnimation(Character: Model?)
	if IsAliveCharacter(Character) then
		return GetRunStartAnimation(Character)
	end

	return GetFallbackDoorKickAnimation()
end

local function GetDoorKickAnimation(Character: Model?)
	local Player = Character and ServerUtil.GetPlayer(Character)
	local AssetMeta = Player and AssetManager.Player[Player]
	local Kicks = AssetMeta and AssetMeta.AssetFolder and AssetMeta.AssetFolder:FindFirstChild('Kicks')
	if not Kicks then
		return GetCharacterDoorBumpAnimation(Character)
	end

	local Animations = {}
	for _, Animation in Kicks:GetChildren() do
		if Animation:IsA('Animation') and string.find(Animation.Name, 'DoorKick') then
			Animations[#Animations + 1] = Animation
		end
	end
	if #Animations <= 0 then
		return GetCharacterDoorBumpAnimation(Character)
	end

	return Animations[math.random(1, #Animations)]
end

local function PlayDoorKick(Character: Model?)
	if not IsRunningIntoDoor(Character) or os.clock() - LastDoorKick < DoorKickCooldown then
		return
	end

	local Animation = GetDoorKickAnimation(Character);
	if not Animation then
		return
	end

	local Track = ServerUtil.LoadAnimation(Character, Animation);
	if Track then
		LastDoorKick = os.clock()
		Track.Priority = Enum.AnimationPriority.Action
		Track:Play();
	end
end

local function StunKillersWithDoor(Character: Model?)
	if not Character or not IsAliveCharacter(Character) or os.clock() - LastDoorStun < DoorStunCooldown then
		return
	end

	local CharacterSide = GetOpenDirection(Character)
	local HitKiller = false
	for _, KillerCharacter in KillerFolder:GetChildren() do
		local KillerRoot = ServerUtil.GetRoot(KillerCharacter);
		if not KillerRoot then
			continue
		end
		if GetOpenDirection(KillerCharacter) == CharacterSide then
			continue
		end
		if (KillerRoot.Position - Root.Position).Magnitude > DoorStunDistance then
			continue
		end

		HitKiller = true
		ApplyTimedStun(KillerCharacter, DoorStunTime);
	end

	if HitKiller then
		LastDoorStun = os.clock()
	end
end

local function SetDoorOpen(Enabled: boolean, Character: Model?, ShouldAnimate: boolean?)
	if Broken or Holder then
		Enabled = false
	end
	if DoorOpened == Enabled then
		if Enabled then
			SetDoorCollision(false);
			if ShouldAnimate then
				PlayDoorKick(Character);
			end
		elseif not Broken then
			SetDoorCollision(true);
		end

		return
	end

	DoorOpened = Enabled
	local RunningIntoDoor = IsRunningIntoDoor(Character)
	local TweenInformation = Enabled and (RunningIntoDoor and DoorRunTweenInfo or DoorWalkTweenInfo) or DoorCloseTweenInfo
	if Enabled then
		SetDoorCollision(false);
		StunKillersWithDoor(Character);
		if RunningIntoDoor then
			PlayDoorKick(Character);
		end
	else
		task.delay(DoorCloseTweenInfo.Time, function()
			if not DoorOpened and not Broken then
				SetDoorCollision(true);
			end
		end);
	end

	local Direction = GetOpenDirection(Character)
	for _, Information in DoorMotors do
		local MotorDirection = #DoorMotors == 1 and Direction or Information.Direction
		local Goal = Enabled and Information.ClosedC0 * CFrame.Angles(0, 0, DoorOpenAngle * MotorDirection) or Information.ClosedC0
		TweenService:Create(Information.Motor, TweenInformation, {
			C0 = Goal
		}):Play();
	end
end

local function RefreshDoorPresence(Character: Model?, ShouldAnimate: boolean?)
	if not Character or Broken or Holder then
		return
	end

	DoorPresenceStamp = os.clock()
	SetDoorOpen(true, Character, ShouldAnimate);
end

local function StartDoorOpenWatcher()
	task.spawn(function()
		while RuntimeFolder.Parent and Container.Parent do
			SyncPublicRoot();
			RefreshDoorPresence(GetClosestDoorCharacter(), false);
			if os.clock() - DoorPresenceStamp > DoorCloseDelay then
				SetDoorOpen(false);
			end

			task.wait(0.05);
		end
	end);
end

local function FireContest(Message: string)
	if not Event or not Holder then
		return
	end

	if Gui then
		Gui:SetAttribute('HP', HP);
	end

	Event:FireClient(Holder, Message);
end

local function DestroyGui(GuiObject: ScreenGui?)
	if not GuiObject then
		return
	end

	GuiObject:SetAttribute('Active', false);
	task.delay(0.25, function()
		if GuiObject.Parent then
			GuiObject:Destroy();
		end
	end);
end

local function DestroyContest()
	if EventConnection then
		EventConnection:Disconnect();
		EventConnection = nil
	end

	if HPConnection then
		HPConnection:Disconnect();
		HPConnection = nil
	end

	local OldGui = Gui
	Gui = nil
	Event = nil
	DestroyGui(OldGui);
end

local function CreateContest(Player: Player)
	local DotTemplate = GetDotTemplate();
	local PlayerGui = Player:FindFirstChildOfClass('PlayerGui')
	if not DotTemplate or not PlayerGui then
		return
	end

	DestroyGui(PlayerGui:FindFirstChild('DoorBarricade'));

	Gui = DotTemplate:Clone();
	Gui.Name = 'DoorBarricade'
	Gui.ResetOnSpawn = false
	Gui:SetAttribute('OwnerUserId', Player.UserId);
	Gui:SetAttribute('HP', HP);
	Gui:SetAttribute('Active', true);
	Gui.Parent = PlayerGui

	local DotServer = Gui:FindFirstChild('Server');
	if DotServer and DotServer:IsA('Script') then
		DotServer.Enabled = true
	end

	HPConnection = Gui:GetAttributeChangedSignal('HP'):Connect(function()
		local NewHP = Gui:GetAttribute('HP')
		if typeof(NewHP) == 'number' then
			HP = math.clamp(NewHP, 0, 100);
		end
	end);

	local Main = Gui:FindFirstChild('Main');
	local Remote = Main and Main:FindFirstChild('Event')
	if Remote and Remote:IsA('RemoteEvent') then
		Event = Remote
	end

	SetContestSize();
end

local function RestoreDoorParts()
	for Part, Information in OriginalParts do
		if Part.Parent then
			Part.CFrame = Information.CFrame
			Part.Anchored = Information.Anchored
			Part.Massless = Information.Massless
			Part.Transparency = Information.Transparency
			Part.CanCollide = Information.CanCollide
			Part.CanTouch = Information.CanTouch
			Part.CanQuery = Information.CanQuery
		end
	end
end

local function SetDoorBrokenVisual(IsBroken: boolean)
	for Part, Information in OriginalParts do
		if Part.Parent and IsDoorPanel(Part) then
			Part.Transparency = Information.Transparency
			Part.CanCollide = IsBroken and false or (IsDoorCollider(Part) and true or Information.CanCollide)
			Part.CanTouch = IsBroken and false or Information.CanTouch
			Part.CanQuery = IsBroken and false or Information.CanQuery
		end
	end

	if Trigger then
		Trigger.CanCollide = false
		Trigger.CanTouch = not IsBroken
		Trigger.CanQuery = not IsBroken
	end
end

local function EmitDoorVFX()
	local VFX = Door:FindFirstChild('VFX')
	if not VFX then
		return
	end

	for _, Descendant in VFX:GetDescendants() do
		if Descendant:IsA('ParticleEmitter') then
			local EmitCount = Descendant:GetAttribute('EmitCount') or 12
			Descendant:Emit(EmitCount);
		end
	end
end

local function SetCooldown(Player: Player)
	local CooldownEnd = os.clock() + BarricadeCooldown
	Player:SetAttribute('DoorBarricadeCooldown', CooldownEnd);
end

local function GetCooldown(Player: Player)
	return math.max(0, (Player:GetAttribute('DoorBarricadeCooldown') or 0) - os.clock())
end

local function CancelBarricade(ShouldCooldown: boolean?)
	local Player = Holder
	local Character = HolderCharacter
	local Prompt = EnsurePrompt();

	StopTrack(StartTrack);
	StopTrack(IdleTrack);
	StopSound(LoopSound);
	DestroyContest();

	if Character and Character.Parent then
		Character:SetAttribute('BarricadingDoor', nil);
		if Character:HasTag('Barricading') then
			Character:RemoveTag('Barricading');
		end
	end

	Token += 1
	Holder = nil
	HolderCharacter = nil
	HP = 100
	StartTrack = nil
	IdleTrack = nil
	LoopSound = nil

	SetDoorBlocking(false);
	SetDoorAttribute('HOLDER', nil);

	if Player and ShouldCooldown then
		SetCooldown(Player);
	end

	SetPromptState(Prompt);
end

local function BreakDoor(KillerPlayer: Player?)
	if Broken then
		return
	end

	local FinalHolder = HolderCharacter
	local FinalHP = HP

	Broken = true
	Hits = MaxHits
	SetDoorAttribute('Broken', true);
	SetDoorAttribute('Hits', Hits);

	CancelBarricade(FinalHolder ~= nil);
	LaunchBrokenDoor(KillerPlayer);
	SetDoorBrokenVisual(true);
	SetDoorBlocking(false);
	EmitDoorVFX();
	PlaySound('Break');

	if FinalHolder and FinalHolder.Parent then
		local FinalKnockbackTime = FinalHP >= 55 and SafeKnockbackTime or KnockbackTime
		ApplyTimedStun(FinalHolder, FinalKnockbackTime);
		PlayAnimation(FinalHolder, 'Knockback');
	end

	local KillerCharacter = KillerPlayer and KillerPlayer.Character
	if KillerCharacter and KillerCharacter.Parent then
		ApplyTimedTag(KillerCharacter, 'CantMove', KillerBreakLag);
	end

	SetPromptState(EnsurePrompt());
end

local function StartWatcher()
	local CurrentToken = Token
	local StartedAt = os.clock()

	task.spawn(function()
		while Holder and Token == CurrentToken and not Broken do
			local Character = HolderCharacter
			local CharacterRoot = Character and ServerUtil.GetRoot(Character)
			if not Character or not Character.Parent or not CharacterRoot or not Root.Parent then
				CancelBarricade(true);
				return
			end

			local Humanoid = Character:FindFirstChildOfClass('Humanoid')
			if os.clock() - StartedAt > DoorMoveGrace and Humanoid and Humanoid.MoveDirection.Magnitude > 0.05 then
				CancelBarricade(true);
				return
			end

			if (CharacterRoot.Position - Root.Position).Magnitude > CancelDistance then
				CancelBarricade(true);
				return
			end

			if HP <= 0 then
				BreakDoor();
				return
			end

			task.wait(0.15);
		end
	end);
end

local function GetStandingPosition(Character: Model, Position: BasePart)
	local CharacterRoot = ServerUtil.GetRoot(Character);
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not CharacterRoot or not Humanoid then
		return Position.Position
	end

	local Params = RaycastParams.new();
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {Character, Container}

	local Origin = Position.Position + Vector3.yAxis * BarricadeRayHeight
	local Result = workspace:Raycast(Origin, Vector3.yAxis * -BarricadeRayDepth, Params)
	local Height = Humanoid.HipHeight + (CharacterRoot.Size.Y * 0.5)
	local TargetY = Result and Result.Position.Y + Height or math.max(Position.Position.Y + Height, CharacterRoot.Position.Y)

	return Vector3.new(Position.Position.X, TargetY, Position.Position.Z)
end

local function PositionCharacter(Character: Model)
	local CharacterRoot = ServerUtil.GetRoot(Character);
	local Position = GetCharacterSide(Character);
	if not CharacterRoot or not Position then
		return
	end

	local TargetPosition = GetStandingPosition(Character, Position)
	local LookPosition = Vector3.new(Root.Position.X, TargetPosition.Y, Root.Position.Z)
	Character:PivotTo(CFrame.lookAt(TargetPosition, LookPosition));
	Character:SetAttribute('Running', false);
end

local function StartBarricade(Player: Player)
	local Character = Player.Character
	if not Character or not IsAliveCharacter(Character) then
		return
	end
	if Broken or Holder or GetCooldown(Player) > 0 then
		return
	end

	Token += 1
	Holder = Player
	HolderCharacter = Character
	HP = 100
	SetDoorAttribute('HOLD', true);
	SetDoorAttribute('HOLDER', Player.Name);

	if not Character:HasTag('Barricading') then
		Character:AddTag('Barricading');
	end
	Character:SetAttribute('BarricadingDoor', Door:GetFullName());

	PositionCharacter(Character);
	SetDoorOpen(false);
	SetDoorBlocking(true);
	SetPromptState(EnsurePrompt());
	CreateContest(Player);

	StartTrack = PlayAnimation(Character, 'Start');
	IdleTrack = PlayAnimation(Character, 'Idle', true);
	PlaySound('Start');
	LoopSound = PlaySound('Loop', true);

	StartWatcher();
end

local function HitDoor(Player: Player)
	local Character = Player.Character
	if not Character or not IsKillerCharacter(Character) or not Holder or Broken then
		return
	end

	local Now = os.clock()
	if LastHit and Now - LastHit < HitDebounce then
		return
	end

	LastHit = Now
	Hits += 1
	HP = math.max(0, HP - HitPressure);
	SetDoorAttribute('Hits', Hits);

	ApplyTimedTag(Character, 'CantMove', KillerHitLag);
	PlayAnimation(Character, 'Bash');
	PlayAnimation(HolderCharacter, Hits % 2 == 0 and 'Knock2' or 'Knock1');
	PlaySound(Hits % 2 == 0 and 'Hit2' or 'Hit1');
	PlaySound(Hits % 2 == 0 and 'Barge2' or 'Barge');

	if not Gui and Holder then
		CreateContest(Holder);
	end

	SetContestSize();
	FireContest('Bump');

	if Hits >= MaxHits or HP <= BreakHP then
		BreakDoor(Player);
	else
		SetPromptState(EnsurePrompt());
	end
end

local function OnDoorHit()
	local HitStamp = Door:GetAttribute('DoorHit') or Container:GetAttribute('DoorHit')
	if not HitStamp or HitStamp == LastDoorHit then
		return
	end

	LastDoorHit = HitStamp
	local UserId = Door:GetAttribute('DoorHitUserId') or Container:GetAttribute('DoorHitUserId')
	if typeof(UserId) ~= 'number' then
		return
	end

	local Player = Players:GetPlayerByUserId(UserId);
	if Player then
		HitDoor(Player);
	end
end

local function OnPromptTriggered(Player: Player)
	local Character = Player.Character
	if not Character then
		return
	end

	if Holder then
		if Holder == Player then
			CancelBarricade(true);
		elseif IsKillerCharacter(Character) then
			HitDoor(Player);
		end

		return
	end

	if IsAliveCharacter(Character) then
		StartBarricade(Player);
	end
end

local function ConfigureParts()
	for _, Descendant in Door:GetDescendants() do
		if Descendant:IsA('BasePart') then
			OriginalParts[Descendant] = {
				Transparency = Descendant.Transparency,
				CanCollide = Descendant.CanCollide,
				CanTouch = Descendant.CanTouch,
				CanQuery = Descendant.CanQuery,
				CFrame = Descendant.CFrame,
				Anchored = Descendant.Anchored,
				Massless = Descendant.Massless,
			}

			if IsDoorPanel(Descendant) and not Descendant:HasTag('SecurityDoor') then
				Descendant:AddTag('SecurityDoor');
			end
		end
	end

	if Trigger and not Trigger:HasTag('DoorCollision') then
		Trigger:AddTag('DoorCollision');
	end
end

local function RepairDoor(Silent: boolean?)
	CancelBarricade(false);
	ClearBrokenDoorVisual();

	Broken = false
	Hits = 0
	HP = 100
	LastHit = nil
	SetDoorAttribute('Broken', false);
	SetDoorAttribute('Hits', 0);
	SetDoorAttribute('HOLD', false);
	SetDoorAttribute('HOLDER', nil);

	RestoreDoorParts();
	SetDoorBrokenVisual(false);
	SetDoorBlocking(false);
	SetPromptState(EnsurePrompt());

	if not Silent then
		PlaySound('Start');
	end
end

local function Cleanup()
	CancelBarricade(false);
	ClearBrokenDoorVisual();

	for _, Connection in Connections do
		if Connection and Connection.Connected then
			Connection:Disconnect();
		end
	end

	table.clear(Connections);
end

local function Setup()
	if not Door or not Root or not Trigger then
		return
	end

	SharedServer = FindSharedServerAsset();
	EnsurePublicRoot();
	ConfigureDoorMotors();
	ConfigureParts();

	local Prompt = EnsurePrompt();
	if Prompt then
		AddConnection(Prompt.Triggered:Connect(OnPromptTriggered));
	end

	Trigger.CanTouch = true
	AddConnection(Trigger.Touched:Connect(function(Part: BasePart)
		RefreshDoorPresence(GetDoorTouchCharacter(Part), true);
	end));

	AddConnection(Door:GetAttributeChangedSignal('DoorHit'):Connect(OnDoorHit));
	if Container ~= Door then
		AddConnection(Container:GetAttributeChangedSignal('DoorHit'):Connect(OnDoorHit));
	end

	AddConnection(Door:GetAttributeChangedSignal('RepairDoor'):Connect(function()
		RepairDoor();
	end));
	AddConnection(RuntimeFolder.Destroying:Connect(Cleanup));
	AddConnection(Container.Destroying:Connect(Cleanup));

	RepairDoor(true);
	StartDoorOpenWatcher();
end

-- <- Initialize -> --
Setup();