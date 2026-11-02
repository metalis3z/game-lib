wep = script.Parent.Weapon.Value
deb = true
function touch(part)
	hum = part.Parent:FindFirstChild("Humanoid")
	if hum then
		plr = game.Players:FindFirstChild(part.Parent.Name)
		if plr then
			if deb == true then
			deb = false
				script.Parent.BrickColor = BrickColor.new("Really red")
				local weapon = game.Lighting:FindFirstChild(wep)
				w2 = weapon:Clone()
				w2.Parent = plr.Backpack
				wait(5)
				script.Parent.BrickColor = BrickColor.new("Black")
			deb = true
			end
		end
	end
end
script.Parent.Touched:connect(touch)