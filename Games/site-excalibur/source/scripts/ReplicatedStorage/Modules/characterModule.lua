local ReplicatedStorage = game:GetService('ReplicatedStorage');
local PlayerService = game:GetService('Players');
local Workspace = game:GetService('Workspace');
local RunService = game:GetService('RunService');
local TweenService = game:GetService('TweenService');
--------------------------------------------------------------
local CharacterModule = {};

CharacterModule.Mode = 'Default';
--------------------------------------------------------------
function CharacterModule.alignCharacterToMouse()
	local Remotes
	local Assets
	
	local CharacterReplicationEvent
	
	if RunService:IsServer() then -- If this function is being called serverside, lets set up the event listener for the replication.
		Remotes = ReplicatedStorage:FindFirstChild('Remotes') or Instance.new('Folder');
		Assets = ReplicatedStorage:FindFirstChild('Assets') or Instance.new('Folder');
		CharacterReplicationEvent = Remotes:FindFirstChild('characterReplicatedEvent') or Instance.new('RemoteEvent');
		
		Remotes.Name = 'Remotes';
		Assets.Name = 'Assets';
		CharacterReplicationEvent.Name = 'characterReplicatedEvent';
		
		Remotes.Parent = ReplicatedStorage;
		Assets.Parent = ReplicatedStorage;
		CharacterReplicationEvent.Parent = Remotes;
		
		CharacterReplicationEvent.OnServerEvent:Connect(function(replicatingPlayer,characterValues)
			local replicatingCharacter = replicatingPlayer.Character;
			if replicatingCharacter then CharacterReplicationEvent:FireAllClients(replicatingCharacter,characterValues) end
		end)
	elseif RunService:IsClient() then
		local LocalPlayer = PlayerService.LocalPlayer;
		local LocalMouse = LocalPlayer:GetMouse();
		local LocalCamera = Workspace:FindFirstChild('Camera') or Workspace.CurrentCamera;
		local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait();
		
		Remotes = ReplicatedStorage:WaitForChild('Remotes');
		Assets = ReplicatedStorage:FindFirstChild('Assets');
		CharacterReplicationEvent = Remotes:FindFirstChild('characterReplicatedEvent');
		
		local lastReplication = tick();
		
		if CharacterReplicationEvent then
			CharacterReplicationEvent.OnClientEvent:Connect(function(replicatingCharacter,characterValues)
				local characterHumanoid = replicatingCharacter:WaitForChild('Humanoid');
				local characterHumanoidRoot = replicatingCharacter:WaitForChild('HumanoidRootPart');
				local characterHead = replicatingCharacter:WaitForChild('Head');
				local characterTorso = replicatingCharacter:FindFirstChild('Torso') or LocalCharacter:WaitForChild('UpperTorso');
				
				local characterNeck = characterHead:WaitForChild('Neck');
				local characterWaist = characterTorso:WaitForChild('Waist');
				
				characterNeck.C0 = characterValues.neckCFrame;
				characterWaist.C0 = characterValues.waistCFrame;
			end)
		end
		
		LocalMouse.Move:Connect(function()
			local characterHumanoid = LocalCharacter:WaitForChild('Humanoid');
			local characterHumanoidRoot = LocalCharacter:WaitForChild('HumanoidRootPart');
			local characterHead = LocalCharacter:WaitForChild('Head');
			local characterTorso = LocalCharacter:FindFirstChild('Torso') or LocalCharacter:WaitForChild('UpperTorso');
			
			local characterNeck = characterHead:WaitForChild('Neck');
			local characterWaist = characterTorso:WaitForChild('Waist');
			
			local characterCFrameAngle = math.atan2(characterHumanoidRoot.CFrame.LookVector.X, characterHumanoidRoot.CFrame.LookVector.Z);
				
			local mouseCFrame = LocalMouse.Hit;
			local mouseCFrameAngle = math.atan2(mouseCFrame.LookVector.X,mouseCFrame.LookVector.Z);
			local mouseAngleY = math.asin(mouseCFrame.LookVector.Y);
			local mouseAngleX = (characterCFrameAngle - characterCFrameAngle)%(2*math.pi);
				
			if mouseAngleX > math.pi/2 and mouseAngleX < math.pi * 1.5 then mouseAngleX = math.pi - mouseAngleX end
			if mouseAngleY > math.pi/2 and mouseAngleY < math.pi * 1.5 then mouseAngleY = math.pi - mouseAngleY end
			
			characterHumanoid.AutoRotate = true;
			
			local characterValues = {
				neckCFrame = CFrame.new(0, 0.8, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.Angles(mouseAngleX * 0.5, -mouseAngleX, 0);
				waistCFrame = CFrame.new(0, 0.2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) *  CFrame.Angles(mouseAngleY * 0.5, 0, 0);
			}
			
			characterNeck.C0 = characterValues.neckCFrame;
			characterWaist.C0 = characterValues.waistCFrame;
			
			characterHumanoidRoot = characterValues.waistCFrame;
			
			local currentReplicationTime = tick();
			if currentReplicationTime - lastReplication >= 0.15 then		
				lastReplication = currentReplicationTime
					
				CharacterReplicationEvent:FireServer(characterValues)
			end
		end)
	end
end
--------------------------------------------------------------
return CharacterModule