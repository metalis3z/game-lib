local ReplicatedStorage = game:GetService('ReplicatedStorage');
local PlayerService = game:GetService('Players');
local CollectionService = game:GetService('CollectionService');
local RunService = game:GetService('RunService');
local Workspace = game:GetService('Workspace');
local UserInputService = game:GetService('UserInputService');
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
local TweenModule = require(Modules:FindFirstChild('tweenModule'));
local AccessModule = require(Modules:FindFirstChild('accessModule'));
----------------------------------------------------------------
Remotes:FindFirstChild('interactionActionFunction').OnServerEvent:Connect(function(...)
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	local interactionKeyName = functionArguements[3] or 'DefaultKEY';
	local optionKeyCode = functionArguements[4] or Enum.KeyCode.E;
	local displayInstance = functionArguements[5];
	
	local interactionKey = InteractionKeys:FindFirstChild(interactionKeyName);
	local interactionKeyModule = require(interactionKey);
	
	local keyName = interactionKeyModule.Name;
	local keyEnabled = interactionKeyModule.Enabled;
	local keyOptions = interactionKeyModule.Options;
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	if objectConfiguration.objectAccess then
		if not AccessModule.checkAccess(playerInstance,objectConfiguration.objectAccess) then return false end
	end
	
	for optionNumberIndex,keyOption in pairs(keyOptions) do
		keyOption = require(keyOption)
		
		if optionKeyCode == keyOption.KeyCode then
			if not keyOption.canAccess(playerInstance,objectInstance) then return false end
			if not keyOption.canExectue(playerInstance,objectInstance) then return false end
			
			local callbackFunction = coroutine.wrap(keyOption.serverCallback);
			keyOption.serverCallback(playerInstance,objectInstance, displayInstance)
		end
	end
	
	return true
end)