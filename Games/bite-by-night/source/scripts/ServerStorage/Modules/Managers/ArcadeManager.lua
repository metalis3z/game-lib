local ArcadeManager = {
	ArcadesInUse = {}
}

-- <- Public Variables -> --
local Lobby = workspace.Lobby
local Arcades = Lobby.Arcades
local Animation = Arcades.Animation.loop
local ArcadeLoader = Arcades.Animation.ArcadeLoader

-- <- Private Functions -> --
local function Clear(Player: Player): ()
	local PlayerInformation = ArcadeManager.ArcadesInUse[Player]
	if not PlayerInformation then
		return
	end
	
	local Arcade = PlayerInformation.Arcade
	if not Arcade then
		return
	end
	
	local ProximityPrompt = PlayerInformation.ProximityPrompt
	if not ProximityPrompt then
		return
	end
	
	local Connections = PlayerInformation.Connections
	if not Connections then
		return
	end
	
	local AnimationTrack = PlayerInformation.AnimationTrack
	if not AnimationTrack then
		return
	end
	
	Player:SetAttribute('Arcade', false);

	Arcade:SetAttribute('InUse', false);
	
	ProximityPrompt.Enabled = true
	
	AnimationTrack:Stop();
	
	for _, Connection in Connections do 
		if typeof(Connection) == 'RBXScriptConnection' then
			Connection:Disconnect();
		end
	end

	ArcadeManager.ArcadesInUse[Player] = nil
	
	local Character = Player.Character
	if Character then
		Character.PrimaryPart.Anchored = false
	end
	
	warn('Cleared !');
end

local function TriggeredPrompt(Player: Player, Arcade: Model, ProximityPrompt: ProximityPrompt): ()
	if Player:GetAttribute('Arcade') then
		return
	end
	
	local Character = Player.Character
	if not Character then
		return
	end
	
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		return
	end
	
	local Animator = Humanoid:FindFirstChildOfClass('Animator');
	if not Animator then
		return
	end 
	
	local ArcadeRoot = Arcade:FindFirstChild('Root');
	if not ArcadeRoot then		
		return
	end
	
	local LoopLoaded = Animator:LoadAnimation(Animation);
	
	Player:SetAttribute('Arcade', true);
	Arcade:SetAttribute('InUse', true);
	
	local PlayerInformation = {
		Arcade = Arcade,
		ProximityPrompt = ProximityPrompt,
		Connections = {},
		AnimationTrack = LoopLoaded
	}
	
	LoopLoaded:Play();
	
	Character:PivotTo(ArcadeRoot:GetPivot());
		
	local CopiedArcadeScript = ArcadeLoader:Clone();
	CopiedArcadeScript.Parent = Character
	CopiedArcadeScript.Enabled = true -- // OMG !!!
	
	local Remote = CopiedArcadeScript.CloseEvent
	PlayerInformation.Connections[#PlayerInformation.Connections + 1] =  Remote.OnServerEvent:Connect(Clear);
	
	ProximityPrompt.Enabled = false
	
	ArcadeManager.ArcadesInUse[Player] = PlayerInformation
	
	task.delay(.2, function(): ()
		Character.PrimaryPart.Anchored = true
	end)
end

local function SetupArcade(): ()
	for _, ProximityPrompt in Arcades:GetDescendants() do 
		if not (ProximityPrompt:IsA('ProximityPrompt') or ProximityPrompt.Parent:IsA('Attachment')) then
			continue
		end

		ProximityPrompt.Triggered:Connect(function(Player: Player): ()
			local ArcadeModel = ProximityPrompt:FindFirstAncestorWhichIsA('MeshPart');
			if not ArcadeModel then
				return
			end
			
			if ArcadeModel:GetAttribute('InUse') then
				return
			end
			
			TriggeredPrompt(Player, ArcadeModel, ProximityPrompt);
		end)
	end
end

-- <- Public Functions -> --
function ArcadeManager.Start(): ()
	SetupArcade();
end

function ArcadeManager.__PlayerLeft(Player: Player): ()
	Clear(Player);
end

-- <- Return -> --
return ArcadeManager