local ReplicatedStorage = game:GetService('ReplicatedStorage');
local RunService = game:GetService('RunService');
local TeamService = game:GetService('Teams');
---------------------------------------
local Remotes = ReplicatedStorage:FindFirstChild('Remotes');
local Modules = ReplicatedStorage:FindFirstChild('Modules');
local Assets = ReplicatedStorage:FindFirstChild('Assets');
---------------------------------------
local Morphs = Assets:FindFirstChild('Morphs');
local Animations = Assets:FindFirstChild('Animations');
---------------------------------------
local keyOption = {};
---------------------------------------
keyOption.KeyCode = Enum.KeyCode.E;
---------------------------------------
function keyOption:GetOptionString(...) -- What should this option display next to the key?
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local playerCharacter = playerInstance.Character;
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	local objectMorphName = objectConfiguration.morphName;
	local objectAccess = objectConfiguration.objectAccess;
	
	local morphsFolder = playerCharacter:FindFirstChild('CurrentMorph');
	local morphInstance = Morphs:FindFirstChild(objectMorphName);
	
	if morphInstance then
		if not morphsFolder or morphsFolder and not morphsFolder:FindFirstChild(objectMorphName) then return string.upper('Wear ' .. morphInstance.Name) else
			return string.upper('Remove ' .. morphInstance.Name)
		end
	else 
		return 'No Morph Found | Contact Development'
	end
end
---------------------------------------
function keyOption.canAccess(...) -- Are they even able to access this interaction option?
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	local objectMorphName = objectConfiguration.morphName;
	local objectAccess = objectConfiguration.objectAccess;
	
	local morphInstance = Morphs:FindFirstChild(objectMorphName);
	local characterInstance = playerInstance.Character;
	
	local AccessModule = require(Modules:FindFirstChild('accessModule'));
	
	return AccessModule.checkAccess(playerInstance,objectAccess)
end

function keyOption.canExectue(...) -- If they have access, is there anything prohibiting them from executing the option?
	return true
end
---------------------------------------
function keyOption.localCallback(...) -- Code that is run on the client of the executor
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local characterInstance = playerInstance.Character or playerInstance.CharacterAdded:wait();
	local morphAnimationInstance = Animations:FindFirstChild('morphAnimation');
	
	local humanoidInstance = characterInstance:WaitForChild('Humanoid');
	local loadedAnimationInstance = humanoidInstance:LoadAnimation(morphAnimationInstance);
	
	loadedAnimationInstance:Play()
end
---------------------------------------
if RunService:IsClient() then return keyOption end
---------------------------------------
function keyOption.serverCallback(...) -- Code that is run on the server when executed
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	local objectMorphName = objectConfiguration.morphName;
	local objectAccess = objectConfiguration.objectAccess;
	
	local morphInstance = Morphs:FindFirstChild(objectMorphName);
	local characterInstance = playerInstance.Character;
	
	local morphsFolder = characterInstance:FindFirstChild('CurrentMorph');
	local AccessModule = require(Modules:FindFirstChild('accessModule'));
	local MorphModule = require(Modules:FindFirstChild('morphModule'));
	
	if morphInstance and characterInstance and AccessModule.checkAccess(playerInstance,objectAccess) then
		if morphsFolder and morphsFolder:FindFirstChild(objectMorphName) then MorphModule:removeCharacterMorph(characterInstance,morphInstance) else MorphModule:applyCharacterMorph(characterInstance,morphInstance) end
	end
end
---------------------------------------
return keyOption
