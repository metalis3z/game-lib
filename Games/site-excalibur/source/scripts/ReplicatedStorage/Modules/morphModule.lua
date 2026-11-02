-----------------------------------------------------------------
local PlayerService = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local ServerStorage = game:GetService('ServerStorage');
local RunService = game:GetService('RunService');
-----------------------------------------------------------------
local Modules = ReplicatedStorage:FindFirstChild('Modules');
-----------------------------------------------------------------
local morphModule = setmetatable({},{__index = function(calledTable,quariedValue)
	warn('MorphModule | Request not found.')
	return nil
end});
-----------------------------------------------------------------
local isRunningServerSide = RunService:IsServer();
if not isRunningServerSide then return nil end
-----------------------------------------------------------------
local function applyMorphLimb(characterMorphLimbFolder,playerCharacterLimb,morphLimbModel) -- Function used to apply individual morphs
	local morphSuccess,morphError = pcall(function()
		if not playerCharacterLimb or not morphLimbModel or not characterMorphLimbFolder then return end
		
		local replicatedLimbModel = morphLimbModel:Clone();
		local limbAnchorPart = replicatedLimbModel:FindFirstChild('Middle') or Instance.new('Part'); -- If an anchorPart doesn't already exist, then lets make one. Making one is LESS accurate!
		if not replicatedLimbModel:FindFirstChild('Middle') then -- Check if we need to set the size or not depending on if it already exists.
			limbAnchorPart.CFrame = replicatedLimbModel:GetModelCFrame();
			limbAnchorPart.Size = Vector3.new(0,0,0) 
		end
		
		limbAnchorPart.Name = 'Middle';
		limbAnchorPart.Anchored = true;
		limbAnchorPart.Parent = replicatedLimbModel;
		
		replicatedLimbModel.Parent = characterMorphLimbFolder;
		replicatedLimbModel.PrimaryPart = limbAnchorPart;
		
		local morphLimbChildren = replicatedLimbModel:GetChildren();
		for morphLimbPartNumberIndex,morphLimbPart in pairs(morphLimbChildren) do
			local morphWeld = Instance.new('Weld');
			morphWeld.Part0 = playerCharacterLimb;
			morphWeld.Part1 = morphLimbPart;
			morphWeld.C0 = limbAnchorPart.CFrame:inverse() * CFrame.new(limbAnchorPart.Position);
			morphWeld.C1 = morphLimbPart.CFrame:inverse() * CFrame.new(limbAnchorPart.Position);
			morphWeld.Name = 'morphWeld';
			morphWeld.Parent = morphLimbPart;
			
			morphLimbPart.CanCollide = false;
			morphLimbPart.Parent = characterMorphLimbFolder
			
			if morphLimbPart ~= limbAnchorPart then morphLimbPart.Anchored = false end
		end
		
		replicatedLimbModel:Destroy() -- All the items within the model have been moved into the character folder
		limbAnchorPart:Destroy() -- No need for this anymore as everything is anchored & moved
	end)
		
	return morphSuccess
end
-----------------------------------------------------------------
function morphModule:applyCharacterMorph(playerCharacter,morphModel)
	if not playerCharacter or not morphModel then return end
	----------------------------------------------------------------- Variable Definitions
	local characterMorphFolder = playerCharacter:FindFirstChild('CurrentMorph') or Instance.new('Folder');
	local appliedMorphFolder = characterMorphFolder:FindFirstChild(morphModel.Name) or Instance.new('Folder');
	local morphConfiguration = require(morphModel:FindFirstChild('morphConfiguration'));
	local morphReplacePrevious = morphConfiguration.replacePrevious;
	local morphSpawnSettings = morphConfiguration.spawnSettings;
	local morphLimbs = morphModel:GetChildren();
	
	characterMorphFolder.Name = 'CurrentMorph';
	characterMorphFolder.Parent = playerCharacter;
	
	if appliedMorphFolder.Name == morphModel.Name then return 'Morph Already Applied!' end
	
	appliedMorphFolder.Name = morphModel.Name;
	appliedMorphFolder.Parent = characterMorphFolder;
	----------------------------------------------------------------- Morph Limb Application
	if morphReplacePrevious then
		for appliedMorphNumberIndex,appliedMorph in pairs(characterMorphFolder:GetChildren()) do
			for appliedMorphLimbNumberIndex,appliedMorphLimb in pairs(appliedMorph:GetChildren()) do
				if morphModel:FindFirstChild(appliedMorphLimb.Name) then appliedMorphLimb:Destroy() end
			end
			
			if #appliedMorph:GetChildren() == 0 and appliedMorph ~= appliedMorphFolder then appliedMorph:Destroy() end
		end
	end
	
	for morphLimbNumberIndex,morphLimb in pairs(morphLimbs) do
		if morphLimb:IsA('Model') then
			local connectedCharacterLimb = playerCharacter:FindFirstChild(morphLimb.Name);
			if connectedCharacterLimb then
				local morphLimbFolder = appliedMorphFolder:FindFirstChild(morphLimb.Name) or Instance.new('Folder');
				
				morphLimbFolder.Name = morphLimb.Name;
				morphLimbFolder.Parent = appliedMorphFolder;
				
				local successfullyApplied = applyMorphLimb(morphLimbFolder,connectedCharacterLimb,morphLimb)
				if not successfullyApplied then
					repeat 
						wait(0.25)
						for previousPartNumberIndex,previousPart in pairs(morphLimbFolder:GetChildren()) do previousPart:Destroy() end
						successfullyApplied = applyMorphLimb(morphLimbFolder,connectedCharacterLimb,morphLimb)
					until successfullyApplied
				end
			end
		end
	end
	----------------------------------------------------------------- spawnSetting Application
	if morphSpawnSettings then
		local characterHumanoid = playerCharacter:WaitForChild('Humanoid');
		
		local characterHealth = characterHumanoid.Health;
		local characterSpeed = characterHumanoid.WalkSpeed;
		
		if morphSpawnSettings.spawnHealth then characterHealth = morphSpawnSettings.spawnHealth end
		if morphSpawnSettings.spawnSpeed then characterSpeed = morphSpawnSettings.spawnSpeed end
		
		if morphSpawnSettings.spawnClothing then
			local playerOutfit = characterHumanoid:GetAppliedDescription();
			
			if morphSpawnSettings.spawnClothing.Shirt then playerOutfit.Shirt = morphSpawnSettings.spawnClothing.Shirt end
			if morphSpawnSettings.spawnClothing.Pants then playerOutfit.Pants = morphSpawnSettings.spawnClothing.Pants end
			
			if not morphSpawnSettings.spawnClothing.AccessoriesPersist then
				
				playerOutfit.BackAccessory = 0;
				playerOutfit.FaceAccessory = 0;
				playerOutfit.FrontAccessory = 0;
				playerOutfit.HairAccessory = 0;
				playerOutfit.HatAccessory = 0;
				playerOutfit.NeckAccessory = 0;
				playerOutfit.ShouldersAccessory = 0;
				
			end
			
			characterHumanoid:ApplyDescription(playerOutfit)
		end
		
		characterHumanoid.Health = characterHealth;
		characterHumanoid.WalkSpeed = characterSpeed;
	end
	
	return true
end

function morphModule:removeCharacterMorph(playerCharacter,morphModel)
	if not playerCharacter or not morphModel then return end
	----------------------------------------------------------------- Variable Definitions
	local characterMorphFolder = playerCharacter:FindFirstChild('CurrentMorph');
	local appliedMorphFolder = characterMorphFolder:FindFirstChild(morphModel.Name) or nil;
	
	if appliedMorphFolder then return appliedMorphFolder:Destroy() end
end
-----------------------------------------------------------------
return morphModule