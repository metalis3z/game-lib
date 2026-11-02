-- // Hi...

local Players = game:GetService('Players');

local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

local PlayersFolder = workspace.PLAYERS
local AliveFolder = PlayersFolder.ALIVE

local GeneratorUi = script.Gen
local GeneratorModel = script:FindFirstAncestorWhichIsA('Model');

local RootPart = GeneratorModel:FindFirstChild('RootPart') or GeneratorModel:WaitForChild('RootPart', 10);

local PlayerConnections = {}
local DoneGenerator = {}
local DefaultValues = {
	MinTimePast = 5,
	ProgressPerStuff = 10
}

local IsGeneratorWorking = false

local function CleanConnections(Player: string): ()
	if Player then
		local PlayerConnectionToClear = PlayerConnections[Player]
		if not PlayerConnectionToClear then
			return
		end
		
		for _, Connection: RBXScriptConnection in PlayerConnectionToClear do 
			if typeof(Connection) ~= 'RBXScriptConnection' then
				continue
			end
			
			if not Connection.Connected then
				continue
			end
			
			Connection:Disconnect();
		end
		
		PlayerConnections[Player] = nil
	else 
		for TableIndex, _ in PlayerConnections do 
			CleanConnections(TableIndex);
		end
	end
end

local function ProximityPromtTriggered(Player: Player, Point: Attachment, ProximityPrompt: ProximityPrompt): ()
	warn('Hi')
	
	local Character = Player.Character
	if not Character then
		return
	end
	
	if not Character:IsDescendantOf(AliveFolder) then
		warn('Hm')
		
		return
	end
	
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		return
	end
	
	if not ProximityPrompt.Enabled then
		return
	end
	
	if Point:GetAttribute('Used') then
		return
	end
	
	local PlayerGui = Player.PlayerGui
	if not PlayerGui then
		return
	end
	
	if PlayerGui:FindFirstChild(GeneratorUi.Name) then
		return
	end
	
	local BasePartPoint: BasePart = GeneratorModel:FindFirstChild(Point.Name);
	if not BasePartPoint or not BasePartPoint:IsA('BasePart') then
		warn('Nop');
		
		return
	end
	
	local GeneratorUiCopy = GeneratorUi:Clone();
	local GeneratorMain = GeneratorUiCopy:FindFirstChild('GeneratorMain');
	if not GeneratorMain then
		warn('Meow ?');
		
		return
	end
	
	local GeneratorEvent = GeneratorMain:FindFirstChild('Event');
	if not GeneratorEvent then
		warn('Event');
		
		return
	end
	
	GeneratorUiCopy.Parent = PlayerGui
	
	Point:SetAttribute('Used', true);
	
	ServerUtil.FreezePlayerViaTag(Character, true);
	
	Character:PivotTo(BasePartPoint.CFrame);
	
	if not PlayerConnections[`{Player}`] then
		PlayerConnections[`{Player}`] = {}
	end
	
	local function DoCleanUp(): ()
		if GeneratorUiCopy then
			GeneratorUiCopy:Destroy();
		end

		if ProximityPrompt then
			ProximityPrompt.Enabled = true
		end
		
		if Point then
			Point:SetAttribute('Used', nil);
		end
		
		if Character then
			ServerUtil.FreezePlayerViaTag(Character, false);
		end

		CleanConnections(Player);
	end
	
	-- // I need it to be the player name ^^
	PlayerConnections[`{Player}`][#PlayerConnections + 1] = Players.PlayerRemoving:Connect(function(PlayerWhoLeft: Player): ()
		if PlayerWhoLeft == Player then
			DoCleanUp();
		end
	end)
	
	-- // Lol
	PlayerConnections[`{Player}`][#PlayerConnections + 1] = Humanoid.Died:Connect(function(): ()
		DoCleanUp();
	end)
	
	-- // Incase the player moves ^^
	PlayerConnections[`{Player}`][#PlayerConnections + 1] = Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(function(): ()
		DoCleanUp();
	end)
	
	PlayerConnections[`{Player}`][#PlayerConnections + 1] = GeneratorEvent.OnServerEvent:Connect(function(Player: Player, Confirmation: {}): ()
		local CurrentProgress = GeneratorModel:GetAttribute('Progress');
		if not CurrentProgress then
			return
		end
		
		local OldInformation = DoneGenerator[Player]
		if OldInformation then
			local OldDoneTime = OldInformation.DoneTime
			local TimePassed = workspace:GetServerTimeNow() - OldDoneTime
			if TimePassed < DefaultValues.MinTimePast then
				return
			end
		end
		
		DoneGenerator[Player] = {
			DoneTime = workspace:GetServerTimeNow(),
			Times = OldInformation and OldInformation.Times + 1 or 1
		}
		
		DoCleanUp();
		
		GeneratorModel:SetAttribute('Progress', CurrentProgress + DefaultValues.ProgressPerStuff);
	end)
end

local function SetupPoints(): ()
	if IsGeneratorWorking then
		return
	end
	
	for _, Point in RootPart:GetChildren() do 
		local PointProximityPrompt = Point:FindFirstChildOfClass('ProximityPrompt');
		if not PointProximityPrompt then
			continue
		end
		
		PointProximityPrompt.Triggered:Connect(function(Player: Player)
			ProximityPromtTriggered(Player, Point, PointProximityPrompt);
		end)
	end
	
	IsGeneratorWorking = true
end

if GeneratorModel:FindFirstAncestorWhichIsA('Workspace') then
	SetupPoints();
end