-----------------------------------------------------------------
local PlayerService = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local ServerStorage = game:GetService('ServerStorage');
local TweenService = game:GetService('TweenService');
local RunService = game:GetService('RunService');
-----------------------------------------------------------------
local Modules = ReplicatedStorage:FindFirstChild('Modules');
-----------------------------------------------------------------
local tweenModule = {};

tweenModule.clientQueue = {};
tweenModule.serverQueue = {};
-----------------------------------------------------------------
local function verifyObjectIntegrity(tweenObject)
	local verifiedTweenObjects = {};
	
	if tweenObject:IsA('Part') or tweenObject:IsA('MeshPart') or tweenObject:IsA('UnionOperation') then table.insert(verifiedTweenObjects,tweenObject) else
		if tweenObject:IsA('Model') then
			for childNumberInstance,childInstance in pairs(tweenObject:GetChildren()) do if childInstance.Name == 'anchorPart' then table.insert(verifiedTweenObjects,childInstance) end end
			
			local generatedAnchorPart = tweenObject:FindFirstChild('anchorPart') or Instance.new('Part');
			generatedAnchorPart.Anchored = true;
			generatedAnchorPart.Transparency = 1;
			generatedAnchorPart.CanCollide = true;
			generatedAnchorPart.Parent = tweenObject;
			
			if not tweenObject:FindFirstChild('anchorPart') then
				generatedAnchorPart.Size = tweenObject:GetExtentsSize();
				generatedAnchorPart.CFrame = tweenObject:GetModelCFrame();
			end
			
			generatedAnchorPart.Name = 'anchorPart';
			
			local tweenObjectChildren = tweenObject:GetChildren();
			for instanceNumberIndex,childInstance in pairs(tweenObjectChildren) do
				if not childInstance:FindFirstChild('tweenWeld') and childInstance ~= generatedAnchorPart then
					local tweenWeld = Instance.new('WeldConstraint');
					tweenWeld.Part0 = childInstance;
					tweenWeld.Part1 = generatedAnchorPart;
					tweenWeld.Enabled = true;
					tweenWeld.Name = 'tweenWeld';
					tweenWeld.Parent = childInstance;
					
					childInstance.Anchored = false;
				end
			end
			
			table.insert(verifiedTweenObjects,generatedAnchorPart)
		end
	end
	
	return verifiedTweenObjects[1]
end


local function calculateEndPosition(tweenObject,tweenDirection)
	local tweenPositionOffset = 0; -- Studs
	
	local objectSize = tweenObject.Size;
	local objectCFrame = tweenObject.CFrame;
	local objectPosition = tweenObject.Position;
	local objectLookVector = objectCFrame.LookVector;
	
	local xAxisSize = objectSize.X;
	local yAxisSize = objectSize.Y;
	local zAxisSize = objectSize.Z;
	
	local directionalVectors = {};
	directionalVectors['up'] = CFrame.new(0,objectSize.Y,0);
	directionalVectors['down'] = CFrame.new(0,-objectSize.Y,0);
	directionalVectors['right'] = CFrame.new(0,0,-objectSize.Z);
	directionalVectors['left'] = CFrame.new(0,0,objectSize.Z);
	directionalVectors['rotate_clockwise'] = CFrame.Angles(0,math.rad(90),0);
	directionalVectors['rotate_counter_clockwise'] = CFrame.Angles(0,math.rad(-90),0);
	directionalVectors['rotate_up_forward'] = CFrame.Angles(0,0,math.rad(90));
	directionalVectors['rotate_down_forward'] = CFrame.Angles(0,0,math.rad(-90));
	
	local connectedVector = directionalVectors[string.lower(tweenDirection)];
	local vectorEquation = objectCFrame * connectedVector;
	local endPositionResult = vectorEquation;
	
	return endPositionResult
end
-----------------------------------------------------------------
function tweenModule:createTween(tweenInformation)
	local tweenTable = {};
	
	local tweenObject = tweenInformation.object;
	local tweenDirection = tweenInformation.direction;
	local tweenTime = tweenInformation.length;
	local tweenType = tweenInformation.type;
	
	tweenObject = verifyObjectIntegrity(tweenObject);
	
	if not tweenObject then return warn('Part/Model is not configured for this module!') end
	
	local isCurrentlyBeingTweened = tweenObject:FindFirstChild('currentlyMoving');
	
	if RunService:IsServer() then
		if not isCurrentlyBeingTweened then isCurrentlyBeingTweened = Instance.new('BoolValue') end
		isCurrentlyBeingTweened.Name = 'currentlyMoving';
		isCurrentlyBeingTweened.Parent = tweenObject;
	end
	
	local suppliedInformation = TweenInfo.new(tweenTime, tweenType, Enum.EasingDirection.Out);
	local tweenEndPosition = calculateEndPosition(tweenObject,tweenDirection);
	local completedTween = TweenService:Create(tweenObject,suppliedInformation, {CFrame = tweenEndPosition});
	
	tweenTable.tweenInstance = completedTween;
	tweenTable.tweenInformation = suppliedInformation;
	tweenTable.tweenTime = tweenTime;
	tweenTable.Completed = completedTween.Completed
	
	function tweenTable:Play()
		self.tweenInstance.Completed:Connect(function()
			isCurrentlyBeingTweened.Value = false;
		end)
		
		repeat wait()
			isCurrentlyBeingTweened = tweenObject:FindFirstChild('currentlyMoving');
		until isCurrentlyBeingTweened
		
		if isCurrentlyBeingTweened.Value then return end
		
		isCurrentlyBeingTweened.Value = true;
		
		return self.tweenInstance:Play()
	end
	
	return tweenTable
end
-----------------------------------------------------------------
return tweenModule