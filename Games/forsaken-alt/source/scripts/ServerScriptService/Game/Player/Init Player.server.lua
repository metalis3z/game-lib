-- <- Services -> --
local Storage = game:GetService('ServerStorage');
local Players = game:GetService('Players');
local RunService = game:GetService('RunService');

-- <- Modules -> --
local Titles = require(script.Titles);
local Initializer = require(game.ReplicatedStorage.Initializer);
while not Initializer.Loaded do 
	task.wait()
end
--
local Saving = Initializer.ServerSystems.Saving;
local Network = Initializer.Modules.Network;

-- <- Private Variables -> --
local FreeTesting = false

-- <- Functions -> --
function SetupCharacter(Character: Instance)
	if Character.Parent ~= workspace.Players.Spectating then
		pcall(function()
			Character.Parent = workspace.Players.Spectating
		end)
	end
end

-- <- Network -> --
Network:SetConnection('PlayerLoaded', 'REMOTE_EVENT', function(Player: Player)
	Player:SetAttribute('Loaded', true)
end)

-- <- Connections -> --
Players.PlayerAdded:Connect(function(Player: Player)
	--
	Saving:Load(Player)
	--
	if not workspace:GetAttribute('ServerOwnerID') and game.PrivateServerId ~= '' and game.PrivateServerOwnerId ~= 0 then
		workspace:SetAttribute('ServerOwnerID', game.PrivateServerOwnerId)
	end
	--
	if Titles[tostring(Player.UserId)] then 
		Player:SetAttribute('ChatTitle', Titles[tostring(Player.UserId)])
	end
	--
	SetupCharacter(Player)
end)

Players.PlayerRemoving:Connect(function(Player: Player)
	Saving:Save(Player)
end)

workspace.ChildAdded:Connect(function(Child: Instance)
	if Players:GetPlayerFromCharacter(Child) then
		SetupCharacter(Child)
	end
end)