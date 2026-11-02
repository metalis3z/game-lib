local team = game.Teams.Inmates

tm = script.Parent

function onTouched(hit)
	local h = hit.Parent:FindFirstChild("Humanoid")
	if h ~= nil then
		local char = game.Players:GetPlayerFromCharacter(hit.Parent)
		if char.Team == team then
			local n = hit.Parent
			local p = game.Players:FindFirstChild(""..n.Name.."")
			if p ~= nil then
				p.TeamColor = tm.BrickColor
			end
		end
	end
end

script.Parent.Touched:connect(onTouched)