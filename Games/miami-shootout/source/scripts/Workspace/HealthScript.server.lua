--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS
--DO NOT MESS WITH THIS


function onPlayerRespawned(newPlayer)
	while true do
		if newPlayer.Character ~= nil then break end
		wait(.1)
	end
	local newJob = script.Health:Clone()
	newJob.Disabled = false
	newJob.Parent = newPlayer.Character
end

function onPlayerEntered(newPlayer)
	newPlayer.Changed:connect(function (property)
		if (property == "Character") then
			onPlayerRespawned(newPlayer)
		end
	end)
end

game.Players.PlayerAdded:connect(onPlayerEntered)