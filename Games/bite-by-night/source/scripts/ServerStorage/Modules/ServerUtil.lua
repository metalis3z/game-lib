local Util = {}

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');
local KeyframeSequenceProvider = game:GetService('KeyframeSequenceProvider');

-- <- Modules -> --
local Warp = require('@game/ReplicatedStorage/Modules/Warp');

-- <- Public Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local KillerFolder = workspace.PLAYERS.KILLER

-- <- Private Variables -> --
local Dialog = Warp.Server('Dialogue');
local ScreenEffect = Warp.Server('ScreenEffect');
local CamShake = Warp.Server('Shake');
local ResetPlayer = Warp.Server('Reset');
local ReplicateEvent = Warp.Server('ReplicateEvent');
local ChatMessage = Warp.Server('ChatMessage');
local Change = Warp.Server('Change');
local Side = Warp.Server('Side');

-- <- Private Functions -> --
local function GetFlatDirection(Direction)
	if typeof(Direction) ~= 'Vector3' then
		return nil
	end

	local FlatDirection = Vector3.new(Direction.X, 0, Direction.Z);
	if FlatDirection.Magnitude <= 0.001 then
		return nil
	end

	return FlatDirection.Unit
end

local function GetOriginPosition(Target)
	if typeof(Target) == 'Vector3' then
		return Target
	end

	local Root = Util.GetRoot(Target);
	return Root and Root.Position or nil
end

-- <- Public Functions -> --
function Util.GetFlatDirection(Direction)
	return GetFlatDirection(Direction)
end

function Util.GetCharacter(Target)
	if typeof(Target) ~= 'Instance' then
		return nil
	end

	if Target:IsA('Player') then
		return Target.Character
	elseif Target:IsA('Model') then
		return Target
	elseif Target:IsA('BasePart') then
		return Target:FindFirstAncestorWhichIsA('Model');
	end

	return Target:FindFirstAncestorWhichIsA('Model');
end

function Util.GetPlayer(Target)
	if typeof(Target) ~= 'Instance' then
		return nil
	elseif Target:IsA('Player') then
		return Target
	end

	local Character = Util.GetCharacter(Target);
	if not Character then
		return nil
	end

	return Players:GetPlayerFromCharacter(Character);
end

function Util.GetHumanoid(Target)
	local Character = Util.GetCharacter(Target);
	if not Character then
		return nil
	end

	return Character:FindFirstChildOfClass('Humanoid');
end

function Util.GetRoot(Target)
	local Character = Util.GetCharacter(Target);
	if not Character then
		return nil
	end

	return Character:FindFirstChild('HumanoidRootPart') or Character.PrimaryPart
end

function Util.GetAnimator(Target)
	local Humanoid = Util.GetHumanoid(Target);
	if not Humanoid then
		return nil
	end

	return Humanoid:FindFirstChildOfClass('Animator');
end

function Util.GetMousePosition(Player, Origin, MaximumDistance, Timeout)
	if not Player then
		return nil
	end

	local OriginPosition = GetOriginPosition(Origin);
	local Success, MousePosition = pcall(function()
		return Side:Invoke(Timeout or 0.15, Player, 'Mouse');
	end);
	if not Success or typeof(MousePosition) ~= 'Vector3' then
		return nil
	end

	if OriginPosition and MaximumDistance and MaximumDistance > 0 then
		local Offset = MousePosition - OriginPosition
		if Offset.Magnitude > MaximumDistance then
			MousePosition = OriginPosition + Offset.Unit * MaximumDistance
		end
	end

	return MousePosition
end

function Util.GetFlatLookVector(Target, Player, MaximumDistance)
	local Root = Util.GetRoot(Target);
	if not Root then
		return nil
	end

	local AimPosition = Player and Util.GetMousePosition(Player, Root.Position, MaximumDistance)
	local AimDirection = AimPosition and GetFlatDirection(AimPosition - Root.Position)
	if AimDirection then
		return AimDirection, AimPosition
	end

	return GetFlatDirection(Root.CFrame.LookVector), AimPosition
end

function Util.FaceTowardsPosition(Target, Position)
	local Character = Util.GetCharacter(Target);
	local Root = Util.GetRoot(Target);
	local Direction = Root and Position and GetFlatDirection(Position - Root.Position)
	if not Character or not Root or not Direction then
		return nil
	end

	Character:PivotTo(CFrame.lookAt(Root.Position, Root.Position + Direction));
	return Direction
end

function Util.GetEnemyFolder(Target)
	local Character = Util.GetCharacter(Target);
	if not Character then
		return nil
	end

	if KillerFolder:IsAncestorOf(Character) then
		return AliveFolder
	end

	return KillerFolder
end

function Util.GetEnemyCharacters(Target, Filter)
	local EnemyFolder = Util.GetEnemyFolder(Target);
	if not EnemyFolder then
		return {}
	end

	local Results = {}
	for _, Model in EnemyFolder:GetChildren() do
		local Humanoid = Model:FindFirstChildOfClass('Humanoid');
		local Root = Util.GetRoot(Model);
		if Humanoid and Humanoid.Health > 0 and Root and (not Filter or Filter(Model, Humanoid, Root)) then
			table.insert(Results, Model);
		end
	end

	return Results
end

function Util.GetTargetsInRadius(Origin, Radius, TargetFolder, Filter)
	local OriginPosition
	if typeof(Origin) == 'Vector3' then
		OriginPosition = Origin
	else
		local Root = Util.GetRoot(Origin);
		if not Root then
			return {}
		end

		OriginPosition = Root.Position
	end

	local SearchFolder = TargetFolder or Util.GetEnemyFolder(Origin)
	if not SearchFolder then
		return {}
	end

	local Results = {}
	for _, Model in SearchFolder:GetChildren() do
		local Humanoid = Model:FindFirstChildOfClass('Humanoid');
		local Root = Util.GetRoot(Model);
		if Humanoid and Humanoid.Health > 0 and Root then
			local Distance = (Root.Position - OriginPosition).Magnitude
			if Distance <= Radius and (not Filter or Filter(Model, Humanoid, Root, Distance)) then
				table.insert(Results, Model);
			end
		end
	end

	table.sort(Results, function(Left, Right)
		local LeftRoot = Util.GetRoot(Left);
		local RightRoot = Util.GetRoot(Right);
		if not LeftRoot or not RightRoot then
			return Left.Name < Right.Name
		end

		return (LeftRoot.Position - OriginPosition).Magnitude < (RightRoot.Position - OriginPosition).Magnitude
	end);

	return Results
end

function Util.GetNearestTarget(Origin, Radius, TargetFolder, Filter)
	local Targets = Util.GetTargetsInRadius(Origin, Radius, TargetFolder, Filter);
	return Targets[1]
end

function Util.LoadAnimation(Target, Animation)
	local Animator = Target
	if typeof(Target) == 'Instance' and not Target:IsA('Animator') then
		Animator = Util.GetAnimator(Target)
	end

	if not Animator or not Animation then
		return nil
	end

	local Track = Animator:LoadAnimation(Animation);
	local StartedAt = os.clock();
	while Track.Length <= 0 and os.clock() - StartedAt < 1 do
		task.wait();
	end

	return Track
end

-- // Used to send client screen effects. (Check Main localscript to see how to use this)
function Util.SendScreenEffect(Player: Player | boolean, Information: {}): ()
	if typeof(Player) == 'boolean' then
		for _, Player in Players:GetChildren() do 
			ScreenEffect:Fire(true, Player, Information);
		end
	else 
		ScreenEffect:Fire(true, Player, Information);
	end
end

--[[
    Note, to require a module do:
    Player, {'Module', PathToClientModule, FunctionName, Arguments} ^^
]]
function Util.SendChange(Player: Player | boolean, Information: {}): ()	
	if typeof(Player) == 'boolean' then
		for _, Player in Players:GetChildren() do 
			Change:Fire(true, Player, Information);
		end
	else 
		Change:Fire(true, Player, Information);
	end
end

function Util.SendMove(Player: Player | boolean, ModuleScript: ModuleScript, FunctionName: string, ...): ()
	if not ModuleScript or typeof(FunctionName) ~= 'string' then
		return
	end

	Util.SendChange(Player, {'Module', ModuleScript, FunctionName, ...});
end

-- // I love my old code <3 (Need to suck my dick low-key)
function Util.TableMerge(Table: {}, SecondTable: {})
	if not Table then
		Table = {}
	end
	--
	if not SecondTable then
		SecondTable = {}
	end
	--
	if typeof(Table) ~= 'table' then
		return {}
	end
	--
	if typeof(SecondTable) ~= 'table' then
		return Table
	end
	--
	local FinalTable = {}
	--
	for Index, Value in Table do
		if typeof(Value) == 'table' and typeof(SecondTable[Index]) == 'table' then
			FinalTable[Index] = Util:TableMerge(Value, Table[Index], SecondTable);
		else
			FinalTable[Index] = Value
		end
	end
	--
	for Index, Value in SecondTable do 
		if typeof(Value) == 'table' and typeof(Table[Index]) == 'table' then
			FinalTable[Index] = Util:TableMerge(Table[Index], Value, SecondTable)
		else
			FinalTable[Index] = Value
		end
	end
	--
	return FinalTable
end

-- // Safely require a module without risk of it breaking / erroring an entire script.
function Util.SafeRequire(Module: ModuleScript): (boolean | nil, {} | nil)
	if not Module:IsA('ModuleScript') then
		return
	end

	local Success, ModuleInformation = pcall(require, Module);
	if not Success then
		warn(`Saferequire failed for {Module}. Error: {ModuleInformation}`);

		return
	end

	return ModuleInformation
end

-- // Used to emit / enable every particles in a folder, basepart or instance. (Just use VFXHandler)
--[[function Util.PlayParticlesInDescendants(Where: Folder | BasePart | Instance): ()
	for _, Particles in Where:GetDescendants() do 
		if not Particles:IsA('ParticleEmitter') then
			continue
		end
		
		local Information = Particles:GetAttributes();
		if not Information then
			continue
		end

		local EmitCount = Information['EmitCount'] or 0
		local EmitDelay = Information['EmitDelay'] or 0
		local EmitDuration = Information['EmitDuration'] or 0
		local ParticleType = EmitDuration > 0 and 'Enable' or 'Emit'
		if ParticleType == 'Enable' then
			Particles.Enabled = true
			
			task.delay(EmitDuration, function(): ()
				Particles.Enabled = false
			end)
		elseif ParticleType == 'Emit' then
			Particles:Emit(EmitCount);
		else 
			warn(`No particle type for {Particles}`);
		end
	end
end]]

-- // Used to get all the animation events from an animation id.
function Util.GetAllAnimationEventsNames(AnimationId: string): {KeyframeMarker}	
	local Markers = {}
	local KeyFrame: KeyframeSequence = KeyframeSequenceProvider:GetKeyframeSequenceAsync(AnimationId);

	local function Recurse(Parent: Instance): ()
		for _, Child in pairs(Parent:GetChildren()) do
			if (Child:IsA('KeyframeMarker')) then
				table.insert(Markers, Child);
			end
			if (#Child:GetChildren() > 0) then
				Recurse(Child);
			end
		end
	end

	Recurse(KeyFrame);

	return Markers
end

-- // Used to freeze / unfreeze the player via the CantMove Tag.
function Util.FreezePlayerViaTag(Character: Model, Enabled: boolean): ()
	if Enabled then
		Character:AddTag('CantMove');
	else 
		Character:RemoveTag('CantMove');
	end
end

function Util.PlayDialog(Player: Player, ...): ()	
	Dialog:Fire(true, Player, ...);
end

-- <- Return -> --
return Util