if (not game["Run Service"]:IsStudio() or not workspace:GetAttribute("Testing")) and not (game.PrivateServerId ~= "" and game.PrivateServerOwnerId == 0) then
	workspace:SetAttribute("Testing", nil)
	if workspace:FindFirstChild("StudioAssets") then workspace.StudioAssets:Destroy() end
else
	workspace:SetAttribute("Testing", true)
	Instance.new("IntValue", game.ReplicatedStorage).Name = "ServerFPS"
	game.ServerStorage.Assets.Miscellaneous.Testing.TestingGUI:Clone().Parent = game.StarterGui
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