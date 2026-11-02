if (not game["Run Service"]:IsStudio() or not workspace:GetAttribute("Testing")) and not (game.PrivateServerId ~= "" and game.PrivateServerOwnerId == 0) then
	workspace:SetAttribute("Testing", nil)
	if workspace:FindFirstChild("StudioAssets") then workspace.StudioAssets:Destroy() end
else
	workspace:SetAttribute("Testing", true)
	Instance.new("IntValue", game.ReplicatedStorage).Name = "ServerFPS"
	game.ServerStorage.Assets.Miscellaneous.Testing.TestingGUI:Clone().Parent = game.StarterGui
	game.ServerStorage.Assets.Miscellaneous.Testing.StarterCharacter:Clone().Parent = game.StarterPlayer
	workspace.Map.Lobby:Destroy()
	if game.ServerStorage.Assets.Miscellaneous:FindFirstChild("StudioAssets") then
		game.ServerStorage.Assets.Miscellaneous.StudioAssets.Parent = workspace
	end
	for _, v in pairs(workspace.StudioAssets.studiooo.Noobs:GetChildren()) do
		v:Clone().Parent = game.ServerStorage.Assets.Miscellaneous.Testing.TestingPlaceSurvivors
		v.Parent = workspace.Players.Survivors
	end
end

local Initializer = require(game.ReplicatedStorage.Initializer)
Initializer.Initialize()

while not Initializer.Loaded do 
	task.wait()
	if Initializer.Loaded then
		break
	end
end

workspace:SetAttribute('ServerLoaded', true)