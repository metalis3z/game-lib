deb = true
act = script.Parent.Parent.Parent.Act
function touch(part)
	local h = part.Parent:FindFirstChild("Humanoid") 
	if h then
		local plr = script.Parent.Parent.Parent.Parent.Parent.Own2.Value
		if part.Parent.Name ~= plr then
			if act.Value == true then
				if deb == true then
				deb = false
				local ex = Instance.new("Explosion",script.Parent)
				ex.BlastPressure = 25
				ex.Position = script.Parent.Position
				ex.BlastRadius = 50
				wait(5)
			deb = true
				end
			end
		end
	end
end

script.Parent.Touched:connect(touch)