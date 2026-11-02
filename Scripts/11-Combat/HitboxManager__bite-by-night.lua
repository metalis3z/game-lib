-- Reference copy for study. Game: bite-by-night
-- Original: ServerStorage/Modules/Managers/HitboxManager.lua  (ModuleScript, 406 lines)
-- What it does: Typed hitbox manager: Box, Radius or Ray modes from a per-ability definition, follows the root or a projectile, keeps polling until it finds a target (with timeout), sorts by distance, team filters, and debug adornments.

local HitboxManager = {}
HitboxManager.__index = HitboxManager

-- <- Type -> --
type HitboxDefinition = {
	Mode: string,
	Size: Vector3,
	Offset: CFram
}

type HitboxDefinition2 = {
	Mode: string,
	Length: number,
	Radius: number
}

type self = {
	Definition: HitboxDefinition | HitboxDefinition2,
	Attacker: Model | BasePart,
	AttackerModel: Model,
	RootPart: BasePart,
	Projectile: BasePart,
	TargetFolder: Folder,
	IgnoreList: {any},
	ExcludeSelf: boolean,
	SortByDistance: boolean,
	ContinueUntilFind: boolean,
	Timeout: boolean,
	ContinueTimeout: number,
	MaxParts: number,
	PollInterval: number,
	DebugLifetime: number,
	ForcedSize: Vector3,
	ForcedCFrame: CFrame,
	Filter: () -> (boolean),
	Activate: (self) -> {Model}
}

type Options = {
	ModeOverride: 'Box' | 'Radius' | 'Ray',
	ForcedSize: Vector3,
	ForcedCFrame: CFrame,
	IgnoreList: {any},
	Projectile: BasePart,
	Timeout: number,
	MaxParts: number,
	ContinueTimeout: number,
	PollInterval: number,
	DebugLifetime: number,
	TargetFolder: Folder,
	ContinueUntilFind: boolean,
	ExcludeSelf: boolean,
	SortByDistance: boolean,
	Filter: (Model) -> boolean,
}

-- <- Services -> --
local Debris = game:GetService('Debris');

-- <- Modules -> --
local HitboxSettings = require('@game/ServerStorage/Modules/Hitbox Settings');
local ToolKit = require('@game/ReplicatedStorage/Modules/ToolKit');

-- <- Public Variables -> --
local HitboxUtil = ToolKit.Hitbox

local IgnoreFolder = workspace.IGNORE
local KillerFolder = workspace.PLAYERS.KILLER
local SurvivorFolder = workspace.PLAYERS.ALIVE

local Terrain = workspace.Terrain

-- <- Private Variables -> --
local HitboxToolkit = ToolKit.Hitbox

-- <- Private Functions -> --
local function GetSourceCFrame(self: self): CFrame
	local Source = self.Projectile or self.RootPart
	return Source.CFrame
end

local function GetBoxCFrame(self: self): CFrame
	return GetSourceCFrame(self) * (self.ForcedCFrame or self.Definition.Offset or CFrame.identity)
end

local function CreateDebugAdornment(Kind: 'Box' | 'Sphere', CFrameToPlace: CFrame, SizeOrRadius: Vector3 | number, Color: Color3?, Lifetime: number): ()
	local Adornment = Instance.new(`{Kind}HandleAdornment`);
	Adornment.Adornee = Terrain
	Adornment.AlwaysOnTop = false
	Adornment.ZIndex = 10
	Adornment.CFrame = CFrameToPlace
	Adornment.Size = SizeOrRadius
	Adornment.Color3 = Color or Color3.fromRGB(255, 80, 80);
	Adornment.Transparency = .65
	Adornment.Parent = Terrain

	Debris:AddItem(Adornment, Lifetime);
end

local function IsModelKiller(Model: Model): boolean
	return KillerFolder and KillerFolder:IsAncestorOf(Model);
end

local function GetModel(InstanceToCheck: Instance?): Model?
	if not InstanceToCheck then
		return
	end

	if InstanceToCheck:IsA('Model') then
		return InstanceToCheck
	end

	return InstanceToCheck:FindFirstAncestorWhichIsA('Model');
end

local function GetTargetFolder(self: self): Folder
	if IsModelKiller(self.AttackerModel) then
		return SurvivorFolder
	end
	
	return KillerFolder
end

local function CollectModelsFromParts(Parts: {Part}, self: self): {Model}
	local Result = {}
	local Seen = {}
		
	for _, Part in Parts do 
		local Model = Part:FindFirstAncestorWhichIsA('Model');
		if Model and self.TargetFolder:IsAncestorOf(Model) then			
			if Seen[Model] then
				continue
			end
			
			if self.ExcludeSelf and self.AttackerModel and Model == self.AttackerModel then
				continue
			end
			
			if self.Filter and not self.Filter(Model) then
				continue
			end
			
			Seen[Model] = true
			
			table.insert(Result, Model);
		end
	end
	
	if self.SortByDistance and self.OriginPosition then
		table.sort(Result, function(Left, Right)
			local LeftRoot = Left.PrimaryPart
			local RightRoot = Right.PrimaryPart

			if not LeftRoot or not RightRoot then
				return LeftRoot.Name < RightRoot.Name
			end

			local LeftDistance = (LeftRoot.Position - self.OriginPosition).Magnitude
			local RightDistance = (RightRoot.Position - self.OriginPosition).Magnitude

			if LeftDistance == RightDistance then
				return Left.Name < Right.Name
			end

			return LeftDistance < RightDistance
		end)
	end
	
	return Result
end

local function BuildIncludeOverlapParams(self: self): OverlapParams	
	local NewOverlapParams = OverlapParams.new();
	NewOverlapParams.FilterType = Enum.RaycastFilterType.Include
	NewOverlapParams.FilterDescendantsInstances = {self.TargetFolder}
	NewOverlapParams.MaxParts = self.MaxParts
end

local function BuildRaycastParams(self: self): RaycastParams
	local FilterList = {}
	local RaycastParams = RaycastParams.new();
	RaycastParams.FilterType = Enum.RaycastFilterType.Exclude
	
	if self.IgnoreList then
		for _, InstanceThing in self.IgnoreList do 
			table.insert(FilterList, InstanceThing);
		end
	end
	
	if IgnoreFolder then
		table.insert(FilterList, IgnoreFolder);
	end
	
	RaycastParams.FilterDescendantsInstances = FilterList
	
	return RaycastParams
end

local function ResolveDefinition(CharacterConfiguration, MoveName: string): HitboxDefinition | HitboxDefinition2 -- // Else sphere thingg
	if not CharacterConfiguration then
		return
	end

	local HitboxConfig = CharacterConfiguration.Hitbox
	if not HitboxConfig or typeof(HitboxConfig) ~= 'table' then
		return
	end

	local MoveDefinition = HitboxConfig[MoveName]
	if not MoveDefinition then
		return
	end

	if typeof(MoveDefinition) == 'table' and MoveDefinition.Size and MoveDefinition.CFrame then
		return {
			Mode = 'Box',
			Size = MoveDefinition.Size,
			Offset = MoveDefinition.CFrame
		}
	elseif typeof(MoveDefinition) == 'number' then
		if typeof(HitboxConfig.RayRadius) then
			return {
				Mode = 'Ray',
				Length = MoveDefinition,
				Radius = HitboxConfig.RayRadius
			}
		end

		return {
			Mode = 'Radius',
			Radius = MoveDefinition
		}
	elseif typeof(MoveDefinition) == 'table' then
		if MoveDefinition.Radius then
			return {
				Mode = 'Radius',
				Radius = MoveDefinition.Radius
			}
		elseif MoveDefinition.Length then
			return {
				Mode = 'Ray',
				Length = MoveDefinition.Length,
				Radius = MoveDefinition.RayRadius or MoveDefinition.Radius or 0
			}
		end
	end

	return
end

local function QueryAliveInBox(self: self, BoxCFrame: CFrame): {Model}
	self.OriginPosition = BoxCFrame.Position
	
	local Size = self.ForcedSize or self.Definition.Size
	local BoxOverlapParams = BuildIncludeOverlapParams(self);
	local Parts = workspace:GetPartBoundsInBox(BoxCFrame, Size, BoxOverlapParams);
	
	CreateDebugAdornment('Box', BoxCFrame, Size, nil, self.DebugLifetime);
	
	return CollectModelsFromParts(Parts, self);
end

local function QueryAliveOnRay(self: self): {Model}
	local OriginCFrame = self.Projectile.CFrame or self.RootPart.CFrame
	local OriginPosition = OriginCFrame.Position	
	local LookVector: Vector3 = OriginCFrame.LookVector * self.Definition.Length
	local Length = LookVector.Magnitude
	if Length <= 0 then
		return {}
	end
	
	warn(OriginPosition);
	
	local Unit = LookVector.Unit
	local Radius = self.Definition.Radius or 0
	if Radius <= 0 then
		local BuiltRaycastParams = BuildRaycastParams(self);
		local RaycastResult = workspace:Raycast(OriginPosition, LookVector, BuiltRaycastParams);
		if not RaycastResult then
			return {}
		end
		
		local TargetFolder = GetTargetFolder(self);
		local Model = RaycastResult.Instance:FindFirstAncestorWhichIsA('Model');
		if Model and TargetFolder:IsAncestorOf(Model) then
			if self.Filter and not self.Filter(Model) then
				return {}
			end
			
			if self.ExcludeSelf and self.AttackerModel and Model == self.AttackerModel then
				return {}
			end
			
			return {Model}
		end
		
		return {}
	end
	
	local RayCFrame = CFrame.lookAt(OriginPosition, OriginPosition + Unit);
	local BoxCFrame = RayCFrame + CFrame.new(0, 0, -Length * 0);
	local BoxSize = Vector3.new(Radius * 2, Radius * 2, Length);
	
	self.ForcedSize = BoxSize
	
	return QueryAliveInBox(self, BoxCFrame);
end

local function WaitForFirstAlive(self: self): Model?
	local Elapsed = 0 -- // Time elsapsed between the start and end
	
	while not self.Timeout and Elapsed <= self.ContinueTimeout do
		local Hits
		if self.Definition.Mode == 'Box' then
			Hits = QueryAliveInBox(self, GetBoxCFrame(self));
		elseif self.Definition.Mode == 'Ray' then
			Hits = QueryAliveOnRay(self);
		end
		
		if #Hits > 0 then
			return Hits[1], Hits
		end
		
		task.wait(self.PollInterval);
		
		Elapsed += self.PollInterval
	end
	
	return nil, {}
end

-- <- Public Functions -> --
function HitboxManager:Activate(): {Model}
	if not self then
		return
	end
	
	if self.ContinueUntilFind then
		-- // This one cost more in memory btw
		return WaitForFirstAlive(self);
	end	

	if self.Definition.Mode == 'Box' then		
		return QueryAliveInBox(self, GetSourceCFrame(self) * (self.ForcedCFrame or self.Definition.Offset or CFrame.identity));
	elseif self.Definition.Mode == 'Radius' then

	elseif self.Definition.Mode == 'Ray' then
		return QueryAliveOnRay(self);
	end
end

function HitboxManager.new(Attacker: Model | BasePart, CharacterConfiguration, MoveName: string, Options: Options): self
	local AttackerModel = GetModel(Attacker);
	if not AttackerModel then
		return
	end

	local RootPart = AttackerModel.PrimaryPart
	if not RootPart then
		return
	end

	local Definition = ResolveDefinition(CharacterConfiguration, MoveName);
	if not Definition then
		return
	end
	
	if Options.ModeOverride == 'Box' then
		Definition = {
			Mode = 'Box',
			Size = Options.ForcedSize,
			Offset = Options.ForcedCFrame
		}
	elseif Options.ModeOverride == 'Ray' then
		Definition = {
			Mode = 'Ray',
			Length = Definition.Length or 0,
			Radius = Definition.Radius or 0,
		}
	end

	local self = setmetatable({}, HitboxManager);
	self.Attacker = Attacker
	self.AttackerModel = AttackerModel
	self.RootPart = RootPart
	self.Definition = Definition
	self.Projectile = Options.Projectile or nil
	self.TargetFolder = Options.TargetFolder or GetTargetFolder(self);
	self.IgnoreList = Options.IgnoreList or nil
	self.Filter = Options.Filter or nil
	self.ContinueUntilFind = Options.ContinueUntilFind or false
	self.Timeout = Options.Timeout or false
	self.ExcludeSelf = Options.ExcludeSelf or false	
	self.SortByDistance = Options.SortByDistance or false
	self.MaxParts = Options.MaxParts or 0
	self.ContinueTimeout = Options.ContinueTimeout or .3
	self.PollInterval = Options.PollInterval or .1
	self.DebugLifetime = Options.DebugLifetime or 1.5
	self.ForcedSize = Options.ForcedSize or nil
	self.ForcedCFrame = Options.ForcedCFrame or nil
	
	return self
end

-- <- Return -> --
return HitboxManager
