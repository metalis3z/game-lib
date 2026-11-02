local runAwayDistance = 10

function checkHRP()
	local closest 
	local closestMagnitude = 30
	for _, player in pairs(game.Players:GetPlayers()) do
		if player.Character then
			local hrp = player.Character.Torso
			local hrpMagnitude = hrp and (script.Parent.Torso.Position - hrp.Position).Magnitude or math.huge
			if closestMagnitude >= hrpMagnitude then
				closestMagnitude = hrpMagnitude
				closest = hrp
			end
		end
	end
	return closest
end

while wait() do
	local torso = checkHRP()
	if torso then
		script.Parent.Humanoid:MoveTo((CFrame.new(script.Parent.Torso.Position,torso.Position) * CFrame.new(0,0,runAwayDistance)).p)
	end
end