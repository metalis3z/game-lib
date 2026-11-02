local Initializer = require(game.ReplicatedStorage.Initializer)
Initializer.Initialize()

while not Initializer.Loaded do 
	task.wait()
	if Initializer.Loaded then
		break
	end
end

workspace:SetAttribute('ServerLoaded', true)