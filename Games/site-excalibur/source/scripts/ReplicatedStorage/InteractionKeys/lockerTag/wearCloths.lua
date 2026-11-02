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
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	local objectCloths = objectConfiguration.lockerCloths;
	local objectAccess = objectConfiguration.objectAccess;
	
	local morphInstance = Morphs:FindFirstChild(objectCloths);
	
	if morphInstance then return string.upper('Wear ' .. morphInstance.Name) else return 'No Cloths Found | Contact Development' end
end
---------------------------------------
function keyOption.canAccess(...) -- Are they even able to access this interaction option?
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	local objectAccess = objectConfiguration.objectAccess;
	
	local AccessModule = require(Modules:FindFirstChild('accessModule'));
	return AccessModule.checkAccess(playerInstance,objectAccess)
end

function keyOption.canExectue(...) -- If they have access, is there anything prohibiting them from executing the option?
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	
	local objectLockerDoor = objectInstance:FindFirstChild('lockerDoor');
	if not objectLockerDoor then return false end
	
	local lockerAnchor = objectLockerDoor:FindFirstChild('anchorPart');
	if not lockerAnchor then return false end
	
	local lockerMoving = lockerAnchor:FindFirstChild('currentlyMoving');
	local lockerDebounce = objectConfiguration.lockerDebounce;
	
	if not lockerMoving or not lockerDebounce then return false end
	if lockerMoving.Value or lockerDebounce.Value then return false end
	
	return true
end
---------------------------------------
function keyOption.localCallback(...) -- Code that is run on the client of the executor
	local functionArguements = {...};
	
	local playerInstance = functionArguements[1];
	local objectInstance = functionArguements[2];
	
	local objectLockerDoor = objectInstance:FindFirstChild('lockerDoor');
	if not objectLockerDoor then return true end
	
	local objectSecurity = objectInstance:FindFirstChild('objectSecurity');
	local objectConfiguration = require(objectSecurity) or {};
	local lockerDebounce = objectConfiguration.lockerDebounce;
	
	lockerDebounce.Value = true;
	
	local directionalOpposites = {}
	directionalOpposites['rotate_clockwise'] = 'rotate_counter_clockwise';
	directionalOpposites['rotate_counter_clockwise'] = 'rotate_clockwise';
	
	local TweenModule = require(Modules:FindFirstChild('tweenModule'));
	local TweenInformation = {};
	TweenInformation.object = objectLockerDoor;
	TweenInformation.length = 0.3;
	TweenInformation.type = Enum.EasingStyle.Back;
	TweenInformation.direction = 'rotate_counter_clockwise';
	
	
	
	local lockerTween = TweenModule:createTween(TweenInformation,true);
	lockerTween.Completed:Connect(function()
		wait(1)
		
		TweenInformation.type = Enum.EasingStyle.Linear
		TweenInformation.direction = directionalOpposites[TweenInformation.direction];
		lockerTween = TweenModule:createTween(TweenInformation,true);
		lockerTween:Play();
		
		lockerTween.Completed:Connect(function()
			lockerDebounce.Value = false;
		end)
	end)
	
	lockerTween:Play()
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
	
	local objectCloths = objectConfiguration.lockerCloths;
	local objectAccess = objectConfiguration.objectAccess;
	
	local morphInstance = Morphs:FindFirstChild(objectCloths);
	local characterInstance = playerInstance.Character;
	
	local AccessModule = require(Modules:FindFirstChild('accessModule'));
	local MorphModule = require(Modules:FindFirstChild('morphModule'));
	
	if morphInstance and characterInstance and AccessModule.checkAccess(playerInstance,objectAccess) then
		MorphModule:applyCharacterMorph(characterInstance,morphInstance)
	end
end
---------------------------------------
return keyOption
