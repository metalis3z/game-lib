return function(context, action)
	local animalservice = require(game:GetService("ServerScriptService").Services.AnimalService)

	if typeof(action) == "string" then
		local command = action:lower()

		if command == "stop" then
			animalservice:PauseSpawning()

		elseif command == "resume" then
			animalservice:UnpauseSpawning()
		end
	end
end