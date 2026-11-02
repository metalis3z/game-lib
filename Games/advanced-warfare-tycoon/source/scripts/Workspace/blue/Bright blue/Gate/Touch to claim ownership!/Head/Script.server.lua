function touch(part)
	if part.Parent:FindFirstChild("Humanoid") then
		local plr = game.Players:FindFirstChild(part.Parent.Name)
		if plr then
			if plr.TeamColor == BrickColor.new("Institutional white") then
		h = part.Parent:FindFirstChild("Humanoid")
			h.WalkSpeed = 16
				if h.Parent:FindFirstChild("ForceField") then
				local ff = h.Parent:FindFirstChild("ForceField")
				if ff then
				ff:remove()
				end
				local plr = game.Players:FindFirstChild(part.Parent.Name)
				if plr then
					wait(.15)
					plr:LoadCharacter()
					end
				end
			end
		end
	end
end
script.Parent.Touched:connect(touch)