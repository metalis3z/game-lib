local DoorManager = {}
DoorManager.__index = DoorManager

-- <- Modules -> --
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Public Variables -> --
local GameMap = workspace.MAPS:FindFirstChild('GAME MAP')

-- <- Private Variables -> --
local RuntimeFolderName = 'DoorScripts'
local DoorServerTemplate = script:WaitForChild('DoorServer');
local DotServerTemplate = script:WaitForChild('DotServer');
local DoorHitRange = 10
local DoorHitDot = 0.15

-- <- Private Functions -> --
local function GetDoorModel(Container: Model)
	local Door = Container:FindFirstChild('Door');
	if Door and Door:IsA('Model') and Door:FindFirstChild('Root') then
		return Door
	end

	if Container:FindFirstChild('Root') then
		return Container
	end

	return nil
end

local function GetAssetServer(Container: Model, Door: Model)
	local RuntimeFolder = Container:FindFirstChild(RuntimeFolderName);
	local RuntimeServer = RuntimeFolder and RuntimeFolder:FindFirstChild('Server')
	if RuntimeServer and RuntimeServer:IsA('Script') then
		return RuntimeServer
	end

	local Server = Container:FindFirstChild('Server')
	if Server and Server:IsA('Script') then
		return Server
	end

	Server = Door:FindFirstChild('Server')
	if Server and Server:IsA('Script') then
		return Server
	end

	return nil
end

local function IsDoorFolder(Folder: Instance)
	return Folder.Name == 'Doors' or Folder.Name == 'Double Doors'
end

local function IsDoorReady(Door: Model?)
	return Door and Door:FindFirstChild('Root') and Door:FindFirstChild('Trigger')
end

local function GetGameMap()
	return workspace.MAPS:FindFirstChild('GAME MAP')
end

local function IsDoorHeld(Container: Model, Door: Model)
	return Container:GetAttribute('HOLD') == true or Door:GetAttribute('HOLD') == true
end

local function IsDoorInFront(CharacterRoot: BasePart, DoorRoot: BasePart, Range: number)
	local Offset = DoorRoot.Position - CharacterRoot.Position
	local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z)
	if FlatOffset.Magnitude > Range or FlatOffset.Magnitude <= 0.01 then
		return false
	end

	local LookVector = CharacterRoot.CFrame.LookVector
	local FlatLook = Vector3.new(LookVector.X, 0, LookVector.Z)
	if FlatLook.Magnitude <= 0.01 then
		return false
	end

	return FlatOffset.Unit:Dot(FlatLook.Unit) >= DoorHitDot
end

local function ForEachDoor(Map: Instance, Callback)
	local Amount = 0
	for _, Folder in Map:GetDescendants() do
		if not IsDoorFolder(Folder) then
			continue
		end

		for _, Container in Folder:GetChildren() do
			if not Container:IsA('Model') then
				continue
			end

			Amount += Callback(Container) or 0
		end
	end

	return Amount
end

local function EnsurePublicRoot(Container: Model, Door: Model)
	if Container == Door then
		return
	end

	local Root = Door:FindFirstChild('Root');
	if not Root or not Root:IsA('BasePart') then
		return
	end

	local PublicRoot = Container:FindFirstChild('Root');
	if PublicRoot and PublicRoot:IsA('BasePart') then
		PublicRoot.Size = Root.Size
		PublicRoot.CFrame = Root.CFrame
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

local function SeedDoorAttributes(Container: Model, Door: Model)
	Container:SetAttribute('HOLD', Door:GetAttribute('HOLD') == true);
	Container:SetAttribute('Broken', Door:GetAttribute('Broken') == true);
	Container:SetAttribute('Hits', Door:GetAttribute('Hits') or 0);
	Container:SetAttribute('HOLDER', Door:GetAttribute('HOLDER'));
end

local function ClearRuntime(Container: Model)
	local RuntimeFolder = Container:FindFirstChild(RuntimeFolderName);
	if RuntimeFolder then
		RuntimeFolder:Destroy();
	end
end

local function CopyAssets(AssetServer: Script?, DoorServer: Script)
	if not AssetServer then
		return
	end

	for _, Child in AssetServer:GetChildren() do
		if Child:IsA('Script') then
			continue
		end

		local Clone = Child:Clone();
		Clone.Parent = DoorServer
	end
end

local function ClearOldScripts(Container: Model, RuntimeFolder: Folder)
	for _, Descendant in Container:GetDescendants() do
		if Descendant:IsA('Script') and not Descendant:IsDescendantOf(RuntimeFolder) then
			Descendant:Destroy();
		end
	end
end

local function LoadDotServer(AssetServer: Script?)
	local Dot = AssetServer and AssetServer:FindFirstChild('Dot')
	if not Dot then
		return 0
	end

	for _, Child in Dot:GetChildren() do
		if Child:IsA('Script') and Child.Name == 'Server' then
			Child:Destroy();
		end
	end

	local DotServer = DotServerTemplate:Clone();
	DotServer.Name = 'Server'
	DotServer.Enabled = false
	DotServer.Parent = Dot

	return 1
end

local function LoadDoor(Container: Model)
	local Door = GetDoorModel(Container);
	if not IsDoorReady(Door) then
		return 0
	end

	EnsurePublicRoot(Container, Door);
	SeedDoorAttributes(Container, Door);

	local Loaded = 0
	local AssetServer = GetAssetServer(Container, Door);
	ClearRuntime(Container);

	local RuntimeFolder = Instance.new('Folder');
	RuntimeFolder.Name = RuntimeFolderName
	RuntimeFolder.Parent = Container

	local DoorServer = DoorServerTemplate:Clone();
	DoorServer.Name = 'Server'
	DoorServer.Enabled = false
	CopyAssets(AssetServer, DoorServer);
	Loaded += LoadDotServer(DoorServer);
	DoorServer.Parent = RuntimeFolder
	ClearOldScripts(Container, RuntimeFolder);
	Loaded += 1

	task.defer(function()
		if DoorServer.Parent then
			DoorServer.Enabled = true
		end
	end);

	return Loaded
end

local function RepairDoor(Container: Model)
	local Door = GetDoorModel(Container);
	if not IsDoorReady(Door) then
		return 0
	end

	Door:SetAttribute('RepairDoor', os.clock());
	return 1
end

local function HitDoor(Container: Model, Door: Model, Player: Player)
	local Stamp = os.clock()
	Door:SetAttribute('DoorHitUserId', Player.UserId);
	Door:SetAttribute('DoorHit', Stamp);
	if Container ~= Door then
		Container:SetAttribute('DoorHitUserId', Player.UserId);
		Container:SetAttribute('DoorHit', Stamp);
	end
end

-- <- Public Functions -> --
function DoorManager.LoadMap(Map: Instance)
	if not Map then
		return 0
	end

	return ForEachDoor(Map, LoadDoor)
end

function DoorManager.RepairAll(Map: Instance?)
	Map = Map or GameMap or GetGameMap()
	if not Map then
		return 0
	end

	return ForEachDoor(Map, RepairDoor)
end

function DoorManager.HitClosestDoor(Player: Player, Character: Model?, Range: number?)
	if not Player then
		return false
	end

	Character = Character or Player.Character
	Range = Range or DoorHitRange

	local CharacterRoot = Character and ServerUtil.GetRoot(Character)
	local Map = GetGameMap();
	if not CharacterRoot or not Map then
		return false
	end

	local ClosestContainer = nil
	local ClosestDoor = nil
	local ClosestDistance = Range
	ForEachDoor(Map, function(Container: Model)
		local Door = GetDoorModel(Container);
		local DoorRoot = Door and Door:FindFirstChild('Root')
		if not IsDoorReady(Door) or not DoorRoot or not IsDoorHeld(Container, Door) then
			return 0
		end
		if not IsDoorInFront(CharacterRoot, DoorRoot, Range) then
			return 0
		end

		local Distance = (DoorRoot.Position - CharacterRoot.Position).Magnitude
		if Distance < ClosestDistance then
			ClosestContainer = Container
			ClosestDoor = Door
			ClosestDistance = Distance
		end

		return 0
	end)

	if not ClosestDoor then
		return false
	end

	HitDoor(ClosestContainer, ClosestDoor, Player);
	return true
end

-- <- Return -> --
return DoorManager