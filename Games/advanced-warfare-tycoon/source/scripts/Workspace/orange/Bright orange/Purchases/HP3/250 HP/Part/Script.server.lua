hp = script.Parent.Parent.HP
deb = true
function touch(part)
	local h = part.Parent:FindFirstChild("Humanoid")
	if h then
		local plr = game.Players:FindFirstChild(part.Parent.Name)
		if plr then
			if deb == true then
				deb = false
				script.Parent.BrickColor = BrickColor.new("Bright red")
			h.MaxHealth = hp.Value
			wait()
			h.Health = h.MaxHealth
			wait(7)
			script.Parent.BrickColor = BrickColor.new("Mid gray")
			deb = true
			end
		end
	end
end
script.Parent.Touched:connect(touch)