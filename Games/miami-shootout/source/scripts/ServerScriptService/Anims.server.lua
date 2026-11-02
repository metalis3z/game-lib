function onPlayerRespawned(newPlayer)
	while true do
		if newPlayer.Character:findFirstChild("Animate")~=nil then break end
		wait()
	end
	newPlayer.Character.Animate.Disabled = true
	local c = script.Anima:Clone()
	c.Parent = newPlayer.Character
	c.Disabled = false
end

function onPlayerEntered(newPlayer)
	newPlayer.Changed:connect(function (property)
		if (property == "Character") then
			onPlayerRespawned(newPlayer)
		end
	end)
end

game.Players.PlayerAdded:connect(onPlayerEntered)                                     																																							--TalentGoesBy made this script.
