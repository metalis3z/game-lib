local ReplicatedStorage = game:GetService('ReplicatedStorage');
local PlayerService = game:GetService('Players');
local CollectionService = game:GetService('CollectionService');
local RunService = game:GetService('RunService');
local Workspace = game:GetService('Workspace');
local UserInputService = game:GetService('UserInputService');
----------------------------------------------------------------
local LocalPlayer = PlayerService.LocalPlayer;
local LocalCamera = Workspace.CurrentCamera;
----------------------------------------------------------------
local Assets = ReplicatedStorage:FindFirstChild('Assets');
local Remotes = ReplicatedStorage:FindFirstChild('Remotes');
local Modules = ReplicatedStorage:FindFirstChild('Modules');
local InteractionKeys = ReplicatedStorage:FindFirstChild('InteractionKeys');
----------------------------------------------------------------
local Interfaces = Assets:FindFirstChild('Interfaces');
----------------------------------------------------------------
local interactionBillboard = Interfaces:FindFirstChild('InteractionPopup'); -- Path to the billboardGui that is displayed
local interactionOptionFrame = Interfaces:FindFirstChild('interactionOptionFrame'); -- Path to the frame that is inserted for every option
----------------------------------------------------------------
local AccessModule = require(Modules:FindFirstChild('accessModule'));
----------------------------------------------------------------
local INTERACTION_DISTANCE = 10; -- Maximum distance someone can be for interaction to be possible.
local INTERACTION_COOLDOWN = 3; -- How long in seconds there should be until someone can interact again [OUTDATED] THIS IS NOW DETERMINED ON A PER OBJECT BASIS!
----------------------------------------------------------------
local currentObjectDisplayPart = nil;
local currentObjectInstance = nil;
local currentObjectBillboard = nil;
local currentObjectKey = nil;

local keyPressCooldown = false;

local pendingRemovalBillboards = {}; -- Making this a table instead of a single variable ensures that there won't be lasting billboards.
----------------------------------------------------------------
local function findClosestInteractionWithRayCast() -- Uses distance functions as well as raycasting to find the closest visible object
	local keyModules = InteractionKeys:GetChildren();
	
	local foundObject,connectedKeyTag,distanceFromObject = nil,nil,nil;
	local closestDistance = math.huge;
	
	for moduleNumberIndex,keyModule in pairs(keyModules) do
		if keyModule:IsA('ModuleScript') then
			keyModule = require(keyModule);
			
			local keyName = keyModule.Name;
			local keyEnabled = keyModule.Enabled;
			local keyOptions = keyModule.Options;
			
			local collectedObjects = CollectionService:GetTagged(keyName);
			for objectNumberIndex,objectInstance in pairs(collectedObjects) do
				
				local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
				local LocalRoot = LocalCharacter and LocalCharacter:WaitForChild('HumanoidRootPart');
				
				if LocalRoot then
					local objectPosition = (objectInstance:IsA('Model') and objectInstance:FindFirstChild('detectionPart') and objectInstance:FindFirstChild('detectionPart').Position or objectInstance:IsA('Model') and objectInstance:GetModelCFrame().p or objectInstance:IsA('BasePart') and objectInstance.Position);
					local objectDistance = LocalPlayer:DistanceFromCharacter(objectPosition);
					
					local objectCameraObstruction = Ray.new(LocalCamera.CFrame.p,objectPosition - LocalCamera.CFrame.p);
					local objectRootObstruction = Ray.new(LocalRoot.Position,objectPosition - LocalRoot.Position);
					
					local objectObstructionIgnores = {LocalCharacter,objectInstance};
					local obstructionFoundOnCamera = Workspace:FindPartOnRayWithIgnoreList(objectCameraObstruction,objectObstructionIgnores);
					local obstructionFoundOnRoot = Workspace:FindPartOnRayWithIgnoreList(objectRootObstruction,objectObstructionIgnores);
					
					if not obstructionFoundOnCamera and not obstructionFoundOnRoot then
						if objectDistance <= INTERACTION_DISTANCE and objectDistance < closestDistance and objectInstance ~= LocalPlayer.Character then 

							closestDistance = objectDistance;
							foundObject = objectInstance;
							connectedKeyTag = keyName;
							distanceFromObject = objectDistance;
							
						end
					end
				end
			end
		end
	end
	
	return foundObject,connectedKeyTag,distanceFromObject
end
----------------------------------------------------------------
RunService.Heartbeat:Connect(function(deltaTime) -- Fires every frame and is client specific to their monitor. Better the monitor, quicker it updates.
	for billboardNumberIndex,pendingBillboard in pairs(pendingRemovalBillboards) do if pendingBillboard ~= currentObjectBillboard then pendingBillboard:Destroy() end end
	
	local objectInstance,objectKey,objectDistance = findClosestInteractionWithRayCast();
	local replicatedBillboard = interactionBillboard:Clone();
	
	if not objectInstance then
		currentObjectInstance = nil;
		currentObjectKey = nil;
		currentObjectBillboard = nil;
		
		return replicatedBillboard:Destroy() 
	end
	
	if objectInstance == currentObjectInstance then
		replicatedBillboard:Destroy();
		replicatedBillboard = currentObjectBillboard;
	end
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	if objectSecurity then 
		objectSecurity = require(objectSecurity);
		if not AccessModule.checkAccess(LocalPlayer,objectSecurity.objectAccess) then return replicatedBillboard:Destroy() end	
	end
	
	objectKey = require(InteractionKeys:FindFirstChild(objectKey));
	local keyName = objectKey.Name;
	local keyEnabled = objectKey.Enabled;
	local keyOptions = objectKey.Options; 
	
	for optionNumberIndex,keyOption in pairs(keyOptions) do
		local replicatedOptionFrame = replicatedBillboard:FindFirstChild('animationFrame'):FindFirstChild(keyOption.Name) or interactionOptionFrame:Clone();
		
		local keyModule = require(keyOption);
		local optionKeyCode = keyModule.KeyCode;
		local optionString,optionColor = keyModule:GetOptionString(LocalPlayer,objectInstance);
		if optionString and keyModule.canAccess(LocalPlayer,objectInstance) then
			replicatedOptionFrame.Name = keyOption.Name;
			
			replicatedOptionFrame:FindFirstChild('keyIcon'):FindFirstChild('keyText').Text = UserInputService:GetStringForKeyCode(optionKeyCode);
			replicatedOptionFrame:FindFirstChild('optionString').Text = optionString;
			replicatedOptionFrame:FindFirstChild('optionString'):FindFirstChild('shadowText').Text = optionString;
			
			if optionColor then replicatedOptionFrame:FindFirstChild('optionString'):FindFirstChild('shadowText').TextColor3 = optionColor end
			
			replicatedOptionFrame.Parent = replicatedBillboard:FindFirstChild('animationFrame');
		else
			replicatedOptionFrame:Destroy()
		end
	end
	
	local displayPart = objectInstance;
	if objectInstance:IsA('Model') then
		local displayParts = {};
		for descendantNumberIndex,descendantInstance in pairs(objectInstance:GetDescendants()) do if descendantInstance.Name == 'displayPart' then table.insert(displayParts,descendantInstance) end end
		
		if #displayParts >= 1 then
			local closestDistance = math.huge;
			
			for displayPartNumberIndex,displayInstance in pairs(displayParts) do
				local instancePosition = LocalPlayer:DistanceFromCharacter(displayInstance.Position);
				if instancePosition < closestDistance then
					closestDistance = instancePosition;
					displayPart = displayInstance;
				end
			end
		end
		
		if displayPart == objectInstance then displayPart = objectInstance.PrimaryPart end
	end
	
	if displayPart then replicatedBillboard.Parent = displayPart end

	currentObjectDisplayPart = displayPart;
	currentObjectInstance = objectInstance;
	currentObjectBillboard = replicatedBillboard;
	currentObjectKey = objectKey;
	
	table.insert(pendingRemovalBillboards,replicatedBillboard)
end)
----------------------------------------------------------------
UserInputService.InputEnded:Connect(function(keyInput,currentlyOccupied)
	if currentlyOccupied or keyInput.UserInputType ~= Enum.UserInputType.Keyboard or keyPressCooldown then return false end
	if not currentObjectInstance or not currentObjectBillboard or not currentObjectKey then return false end
	
	local objectKeyOptions = currentObjectKey.Options;
	for optionNumberIndex,keyOption in pairs(objectKeyOptions) do
		keyOption = require(keyOption)
		
		if keyInput.KeyCode == keyOption.KeyCode then
			
			if not keyOption.canAccess(LocalPlayer,currentObjectInstance) then return false end
			if not keyOption.canExectue(LocalPlayer,currentObjectInstance) then return false end
			
			local objectSecurity = currentObjectInstance:FindFirstChild('objectSecurity');
			keyPressCooldown = true;
			
			if objectSecurity then 
				objectSecurity = require(objectSecurity);
				if not AccessModule.checkAccess(LocalPlayer,objectSecurity.objectAccess) then return Remotes:FindFirstChild('clientDoorUpdate'):Fire(currentObjectInstance,'onError') end	
			end
			
			local callbackFunction = coroutine.wrap(keyOption.localCallback);
			keyOption.localCallback(LocalPlayer,currentObjectInstance)
			Remotes:FindFirstChild('interactionActionFunction'):FireServer(currentObjectInstance,currentObjectKey.Name,keyOption.KeyCode,currentObjectDisplayPart)
			
			keyPressCooldown = false;
		end
	end
end)