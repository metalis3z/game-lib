local AxeThrowModule = {
	AxeThrowPlayers = {}
}
AxeThrowModule.__index = AxeThrowModule

-- <- Services -> --
local Players = game:GetService('Players');

-- <- Modules -> --
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local TestModule = require('@game/ServerStorage/Modules/ProjectilesModule');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local Bezier = require('@game/ReplicatedStorage/Modules/Bezier');
local BezierProjectiles = require('@game/ReplicatedStorage/Modules/BezierProjectileUtil');

-- <- Private Variables -> --
local ThrowsTalk = {
	'talk7',
	'talk8'
}

-- <- Public Variables -> --
local IgnoreFolder = workspace.IGNORE

-- <- Private Functions -> --
local function FailedThrowAxe(Player: Player): ()
	local Character = Player.Character
	if not Character then
		warn(`No character for {Player}`);

		return
	end

	warn(`Axe throw failed for {Player} !`);

	ServerUtil.FreezePlayerViaTag(Character, false);
end

local function GetThrowDestination(Player: Player, Character: Model, RootPart: BasePart): (Vector3, RaycastResult?, string)
	local Params = RaycastParams.new();
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {Character, IgnoreFolder}

	local Origin = RootPart.Position + Vector3.new(0, 1.25, 0);
	local MaxDistance = 110
	local AimPosition = ServerUtil.GetMousePosition(Player, Origin, MaxDistance, 0.15)
	local Direction = AimPosition and (AimPosition - Origin)
	if not Direction or Direction.Magnitude <= 0.001 then
		Direction = RootPart.CFrame.LookVector * MaxDistance
	else
		Direction = Direction.Unit * math.min(Direction.Magnitude, MaxDistance)
	end

	local DirectResult = workspace:Raycast(Origin, Direction, Params);
	if DirectResult then
		local SurfaceType = DirectResult.Normal.Y > 0.35 and 'Ground' or 'Wall'
		return DirectResult.Position, DirectResult, SurfaceType
	end

	local FarPoint = Origin + Direction
	local GroundProbeOrigin = FarPoint + Vector3.new(0, 8, 0);
	local GroundResult = workspace:Raycast(GroundProbeOrigin, Vector3.new(0, -24, 0), Params);
	if GroundResult then
		return GroundResult.Position, GroundResult, 'Ground'
	end

	return FarPoint, nil, 'Air'
end

local function PlayDialog(Player: Player): ()
	local TalkToDo = ThrowsTalk[math.random(1, #ThrowsTalk)]
	warn(TalkToDo)
	
	ServerUtil.PlayDialog(Player, 'Springtrap-Normal', TalkToDo, 'Springtrap-Normal');
end

-- <- Public Functions -> --
function AxeThrowModule:ThrowStart(): ()	
	if self.Character:GetAttribute('ThrowingWait') then
		return
	end

	local Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		warn(`No humanoid for {self.Player}`);

		return
	end

	local Animator = Humanoid:FindFirstChildOfClass('Animator');
	if not Animator then
		warn(`No animator for {self.Player}`);

		return
	end

	local ThrowAnimationStart = self.AssetMeta:RequestAsset('ThrowStart');
	if not ThrowAnimationStart then
		return
	end

	local ThrowAnimationHold = self.AssetMeta:RequestAsset('ThrowHold');
	if not ThrowAnimationHold then
		return
	end

	local ThrowStartSFX: Sound = self.AssetMeta:RequestAsset('ThrowStartSFX', true);
	if not ThrowStartSFX then
		return
	end

	local LoadedThrowStart = Animator:LoadAnimation(ThrowAnimationStart);
	if not LoadedThrowStart then
		return
	end

	local LoadedThrowHold = Animator:LoadAnimation(ThrowAnimationHold);
	if not LoadedThrowHold then
		return
	end

	repeat task.wait()

	until LoadedThrowStart.Length > 0 and LoadedThrowHold.Length > 0

	LoadedThrowStart:Play();
	ThrowStartSFX.Parent = self.Character
	ThrowStartSFX:Play();
	
	self.Character:SetAttribute('AxeWaiting', true);

	task.delay(LoadedThrowStart.Length, function(): ()
		if self.Character:GetAttribute('ThrowingWait') then
			return
		end

		self.Character:SetAttribute('ThrowingWait', true);
		
		ServerUtil.FreezePlayerViaTag(self.Character, true);

		warn('Hm.');

		LoadedThrowHold:Play();
		
		self.LoopHoldAnimation = LoadedThrowHold
	end)

	ThrowStartSFX.Ended:Connect(function()
		ThrowStartSFX:Destroy();
	end)
end

function AxeThrowModule:ThrowAxe(): ()
	self.Character:SetAttribute('AxeWaiting', nil);
	self.Character:SetAttribute('ThrowingWait', nil);

	local Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		warn(`No humanoid for {self.Player}`);

		return FailedThrowAxe(self.Player);
	end

	local Animator = Humanoid:FindFirstChildOfClass('Animator');
	if not Animator then
		warn(`No animator for {self.Player}`);

		return FailedThrowAxe(self.Player);
	end

	local Root = self.Character:FindFirstChild('HumanoidRootPart');
	if not Root or not Root:IsA('BasePart') then
		warn(`No HumanoidRootPart for {self.Player}`);

		return FailedThrowAxe(self.Player);
	end

	local AxeProjectile: BasePart = self.AssetMeta:RequestAsset('Axe', true);
	if not AxeProjectile then
		return FailedThrowAxe(self.Player);
	end

	local AxeThrowAnimation = self.AssetMeta:RequestAsset('ThrowAnim');
	if not AxeThrowAnimation then
		return FailedThrowAxe(self.Player);
	end

	local ThrowSFX = self.AssetMeta:RequestAsset('Throw', true);
	if not ThrowSFX then
		return FailedThrowAxe(self.Player);
	end

	local LoadedThrowAnimation = Animator:LoadAnimation(AxeThrowAnimation);

	repeat
		task.wait();
	until LoadedThrowAnimation.Length > 0

	local Released = false
	local Finished = false
	
	local function SetAnimateScript(enableAnimate: boolean, enableAnimate2: boolean): ()
		local Animate = self.Character:FindFirstChild('Animate');
		if Animate then
			Animate.Enabled = enableAnimate
		end

		local Animate2Script = self.Character:FindFirstChild('Animate2');
		if Animate2Script then
			Animate2Script.Enabled = enableAnimate2
		end
	end
	
	local function SetAxeVisibility(Visible: boolean): ()
		local HeldAxe = self.Character:FindFirstChild('Axe.001', true);
		if not HeldAxe then
			return
		end
		
		HeldAxe.Transparency = Visible and 0 or 1
	end
	
	local function RetrieveAxe(Axe: BasePart): ()
		SetAnimateScript(true, false);
		
		ServerUtil.FreezePlayerViaTag(self.Character, true);
		
		local RetrieveAxeAnimation = self.AssetMeta:RequestAsset('AxePullWall');
		if not RetrieveAxeAnimation then
			return
		end
		
		local RetrieveAxeLoaded = Animator:LoadAnimation(RetrieveAxeAnimation);
		
		repeat task.wait() until RetrieveAxeLoaded.Length > 0
		
		RetrieveAxeLoaded:Play();
		Axe:Destroy();
		
		SetAxeVisibility(true);
		
		task.delay(RetrieveAxeLoaded.Length, function(): ()			
			self.Character:SetAttribute('RunSpeed', self.CharacterMeta.Configuration.DefaultRunSpeed);
			self.Character:SetAttribute('Axeless', nil);
			
			ServerUtil.FreezePlayerViaTag(self.Character, false);
		end)
	end
	
	local function FinishThrow(Position: Vector3, HitResult: RaycastResult?, HitboxResult: {Model}): ()
		if Finished then
			return
		end

		Finished = true
		
		-- // Try to request the axe mesh.
		local LodgedAxe: BasePart = self.AssetMeta:RequestAsset('Axe', true)
		if not LodgedAxe then
			warn('No axe')
			return
		end

		local HitCharacter: Model? = HitboxResult
		local HitCharacterPart: BasePart? = nil
		
		if HitCharacter and HitCharacter:IsA('Model') then
			HitCharacterPart = HitCharacter:FindFirstChild('Torso') or HitCharacter.PrimaryPart
		end

		LodgedAxe.Name = `{self.Player.Name}LodgedAxe`
		LodgedAxe.Anchored = true
		LodgedAxe.CanCollide = false
		LodgedAxe.Massless = true
		
		local LodgedAxeHightlight = LodgedAxe:FindFirstChildOfClass('Highlight')
		if LodgedAxeHightlight then
			ServerUtil.SendChange(self.Player, {
				LodgedAxeHightlight,
				'Enabled',
				true
			})
		end
		
		if HitCharacterPart then
			local SurfaceNormal = HitResult and HitResult.Normal or (HitCharacterPart.Position - Position).Unit
			local HitPosition = Position - SurfaceNormal * 0.15
			LodgedAxe.CFrame = CFrame.lookAt(HitPosition, HitPosition - SurfaceNormal);
		elseif HitResult then
			local HitPosition = Position - HitResult.Normal * 0.15
			LodgedAxe.CFrame = CFrame.lookAt(HitPosition, HitPosition - HitResult.Normal);
		else
			LodgedAxe.CFrame = CFrame.new(Position);
		end

		LodgedAxe.Parent = IgnoreFolder
		
		if HitCharacterPart then
			local AxeWeld = LodgedAxe:FindFirstChild('Weld');
			if AxeWeld and AxeWeld:IsA('Weld') then
				AxeWeld.Part0 = HitCharacterPart
				AxeWeld.Part1 = LodgedAxe
				AxeWeld.C0 = HitCharacterPart.CFrame:ToObjectSpace(LodgedAxe.CFrame);
				AxeWeld.C1 = CFrame.new()
				LodgedAxe.Anchored = false
			end
			
			PlayDialog(self.Player);
			AbilityUtil.ApplyDamage(self.Character, HitCharacter, self.CharacterMeta.Configuration.Damage['Remnant Cleaver'] or 20, {
				IgnoreParry = true,
				BleedDuration = 15,
				BleedTick = 1,
				SlowDuration = 4,
				SlowSpeed = 9,
			})
		end
		
		local DelayForceRetrieve: thread
		local DelayDropAxe: thread
		local ProximityConnection: RBXScriptConnection
		local NewProximity = Instance.new('ProximityPrompt')
		NewProximity.Enabled = false
		NewProximity.RequiresLineOfSight = false
		NewProximity.ActionText = 'Pick up'
		NewProximity.KeyboardKeyCode = Enum.KeyCode.F
		NewProximity.Style = Enum.ProximityPromptStyle.Custom
		NewProximity.MaxActivationDistance = 5
		NewProximity.HoldDuration = .4
		NewProximity.Parent = LodgedAxe
		
		-- // Create a proximity prompt trigger signal.
		ProximityConnection = NewProximity.Triggered:Connect(function(PlayerWhoTriggered: Player): ()
			if PlayerWhoTriggered ~= self.Player then
				return
			end
			
			if DelayForceRetrieve then
				task.cancel(DelayForceRetrieve);
			end
			
			if DelayDropAxe then
				task.cancel(DelayDropAxe);
			end
			
			ProximityConnection:Disconnect();
			
			RetrieveAxe(LodgedAxe);
		end)
		
		-- // Check if the player was hit, if it was don't enable the proximity prompt.
		if not HitCharacterPart then
			ServerUtil.SendChange(self.Player, {
				NewProximity,
				'Enabled',
				true
			});
		end
		
		-- // Force retrieve the axe.
		DelayForceRetrieve = task.delay(self.CharacterMeta.Configuration.AxeDuration, function(): ()
			if LodgedAxe then
				RetrieveAxe(LodgedAxe);
			end
		end)
		
		-- // Delay before the axe drops to the ground ^^
		DelayDropAxe = task.delay(self.CharacterMeta.Configuration.HitAxeDuration, function(): ()
			
		end)
	end
	
	-- // Moving this function would mean rescripting it at like 60%.
	-- // It handle the throw releasing. (Aka sending the axe)
	local function ReleaseThrow(): ()
		if Released or Finished then
			return
		end

		Released = true

		local HeldAxe = self.Character:FindFirstChild('Axe.001', true);
		local StartPosition

		if HeldAxe and HeldAxe:IsA('BasePart') then
			StartPosition = HeldAxe.Position + Root.CFrame.LookVector * .35
			
			SetAxeVisibility(false);
		else
			StartPosition = Root.Position + Root.CFrame.LookVector * 1.5 + Vector3.new(0, 1.25, 0);
		end
		
		SetAnimateScript(false, true);

		self.Character:SetAttribute('RunSpeed', self.CharacterMeta.Configuration.AxelessRunSpeed);
		self.Character:SetAttribute('Axeless', true);
		
		ServerUtil.FreezePlayerViaTag(self.Character, false);

		ThrowSFX.Parent = self.Character
		ThrowSFX:Play();
		ThrowSFX.Ended:Connect(function(): ()
			ThrowSFX:Destroy();
		end)
				
		local HitboxResult
		local HitboxLoop = HitboxManager.new(self.Character, self.CharacterMeta.Configuration, 'Remnant Cleaver', {
			Projectile = AxeProjectile,
			ModeOverride = 'Box',
			ForcedSize = Vector3.new(4, 4, 4),
			ForcedCFrame = CFrame.identity,
			ContinueUntilFind = true,
			ContinueTimeout = 2,
			PollInterval = 0.03,
			DebugLifetime = 0.08,
		});
						
		local EndPosition, HitResult, ImpactType = GetThrowDestination(self.Player, self.Character, Root);
		local Distance = (EndPosition - StartPosition).Magnitude
		local ArcHeight = math.clamp(Distance / 180, .2, .85);
		local ControlPoint = StartPosition:Lerp(EndPosition, .5) + Vector3.new(0, ArcHeight, 0);
		local ThrowDuration = math.clamp(.1 + (Distance / 360), .14, .24);

		AxeProjectile.Name = `{self.Player.Name}Axe`
		AxeProjectile.Anchored = true
		AxeProjectile.CanCollide = false

		TestModule.SpawnBezierProjectile({
			Projectile = AxeProjectile,
			StartPosition = StartPosition,
			EndPosition = EndPosition,
			ControlPoint = ControlPoint,
			Duration = ThrowDuration,
			ArcHeight = ArcHeight,
			Rotate = true,
			Parent = IgnoreFolder,
			OnHit = function(Position, Projectile): ()
				task.wait(.2);
				
				HitboxLoop.Timeout = true
				
				warn(HitboxResult);
				
				FinishThrow(Position, HitResult, HitboxResult);
			end,
		});
		
		HitboxResult = HitboxLoop:Activate();
		
		if self.LoopHoldAnimation then
			self.LoopHoldAnimation:Stop();
			self.LoopHoldAnimation = nil
		end
	end

	LoadedThrowAnimation:GetMarkerReachedSignal('Release'):Connect(ReleaseThrow);
	LoadedThrowAnimation:Play();

	task.delay(math.max(0.08, LoadedThrowAnimation.Length * 0.35), ReleaseThrow);
end

function AxeThrowModule:Use(): ()
	-- // Check if the player is about to release the throw.
	if self.Character:GetAttribute('ThrowingWait') then
		self:ThrowAxe();
		
		-- // Clear the player axethrow meta table to say that the throw is 'finished' / 'done'.
		if AxeThrowModule.AxeThrowPlayers[self.Player] then
			AxeThrowModule.AxeThrowPlayers[self.Player] = nil
		end
		
	-- // If not about to release / Holding and isn't axeless, create the throw waiting.
	elseif not self.Character:GetAttribute('AxeWaiting') and not self.Character:GetAttribute('Axeless') then
		self:ThrowStart();
	end
end

function AxeThrowModule.new(Player: Player, AssetMeta, CharacterMeta)
	local self = setmetatable({}, AxeThrowModule);
	self.Player = Player
	self.Character = Player.Character
	self.AssetMeta = AssetMeta
	self.CharacterMeta = CharacterMeta
	self.LoopHoldAnimation = nil
	
	-- // Create a meta and save it somewhere all other scripts can access to reuse it.
	AxeThrowModule.AxeThrowPlayers[Player] = self

	return self
end

-- <- Return -> --
return AxeThrowModule