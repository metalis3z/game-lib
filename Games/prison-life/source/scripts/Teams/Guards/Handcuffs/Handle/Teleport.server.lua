local team = game.Teams.Inmates
local team2 = game.Teams.Criminals

script.Parent.Touched:Connect(function(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if hit.Parent:FindFirstChild("Humanoid")then
		if h.WalkSpeed == 16 or h.WalkSpeed == 24 then
			local char = game.Players:GetPlayerFromCharacter(hit.Parent)
			if char.Team == team then
				if char.valueArrest.Value == true then
					char.sprint.Value = false
					char.valueArrest.Value = false
					wait(0.5)
					h.WalkSpeed = 0
					Arrest = hit.Parent:FindFirstChild("Humanoid"):LoadAnimation(script.Parent.Parent.Arrest)
					Arrest:Play()
					char.Backpack:ClearAllChildren()
					wait(10)
					char:LoadCharacter()
					char.sprint.Value = true
					char.PlayerGui.Home.intro.Visible = false
					char.PlayerGui.Home.hud.Visible = true
				end
			end
		end
	else
		return
	end
end)

script.Parent.Touched:Connect(function(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if hit.Parent:FindFirstChild("Humanoid")then
		if h.WalkSpeed == 16 then
			local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
			if plr.Team == team2 then
				local n = hit.Parent
				local p = game.Players:FindFirstChild(""..n.Name.."")
				if p ~= nil then
					p.TeamColor = BrickColor.new("Bright orange")
				end
				wait(0.5)
				h.WalkSpeed = 0
				Arrest = hit.Parent:FindFirstChild("Humanoid"):LoadAnimation(script.Parent.Parent.Arrest)
				Arrest:Play()
				wait(10)
				plr:LoadCharacter()
				plr.PlayerGui.Home.intro.Visible = false
				plr.PlayerGui.Home.hud.Visible = true
			end
		end
	else
		return
	end
end)