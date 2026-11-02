local SoundFX = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))





--doesnt need player or object argument
function SoundFX:PlaySound(player,soundName,object)
	
	if type(player) ~= "userdata" then --if only sound and object arguments are supplied
		if object then object = soundName end
		soundName = player
	end 

	local IsClient = game:GetService("RunService"):IsClient()

	
			
	if IsClient then
		local SoundFolder = game.Players.LocalPlayer:WaitForChild("SoundFolder") 
		local sound = (object and object:FindFirstChild(soundName)) or (not object and SoundFolder:FindFirstChild(soundName)) or script[soundName]:clone()
		if object then
			sound.Parent = object
		else
			sound.Parent = SoundFolder
		end
		sound:Play()
		
		
	else
		
		if player then --play sound locally to player
			workspace.Main.PlaySound:FireClient(player,soundName,object)
	
		else --find sound in object then play it
			local sound = object:FindFirstChild(soundName) or script[soundName]:clone()
			sound.Parent = object
			sound:Play()
		end
	
	end
end
	
	

--only works from server - need to be compatable with clients too just needs to make a local copy of sound and play
function SoundFX:PlaySoundInsideZone(soundName,zoneName,object)
	if not game:GetService("RunService"):IsClient() or game:GetService("RunService"):IsStudio() then
		local zone = game.ReplicatedStorage.SoundZones[zoneName]
		for _,player in ipairs(game.Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and Utility.IsPointInsideBox(zone,player.Character.HumanoidRootPart.Position) then
				workspace.Main.PlaySound:FireClient(player,soundName,object)
			end
		end
	else
		error("Can only be called from server")
	end
end


function SoundFX:GetSoundObject(soundName)
	return script[soundName]
end



function SoundFX:InitializeLocal()
	local player = game.Players.LocalPlayer
	local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	workspace.Main.PlaySound.OnClientEvent:connect(function(player,soundName,object) 
		SoundFX:PlaySound(player,soundName,object) 
	end)
	
	--[[
	function connecter(dir)
		if dir.Name == "TouchGui" then return end
		for i,v in ipairs(dir:GetChildren()) do	
			if v:IsA("TextButton") or v:IsA("ImageButton") then
				v.MouseButton1Down:connect(function() script.Pop3:Play() end)
			elseif v:IsA("Frame") or v:IsA("ScreenGui") then
				connecter(v)
			end
		end
	end
	local UIS = game:GetService("UserInputService")
	
	
	function decAdded(dec)
		wait()
		if dec:IsA("TextButton") or dec:IsA("ImageButton")  then
			if UIS.TouchEnabled and script.Parent:FindFirstChild("TouchGui") and dec:IsDescendantOf(script.Parent.TouchGui) then return end
			if UIS.TouchEnabled and script.Parent:FindFirstChild("ContextActionGui") and dec:IsDescendantOf(script.Parent.ContextActionGui) then return end
			dec.MouseButton1Down:connect(function() script.Pop3:Play() end)
		end
	end
	PlayerGui.DescendantAdded:connect(decAdded)
	
	]]
	
	local ContentProvider = game:GetService("ContentProvider")
	ContentProvider:Preload("http://www.roblox.com/asset/?id=171406109")
	
	--[[delay(5,function()
		connecter(PlayerGui)
	end)]]
	
end



return SoundFX
