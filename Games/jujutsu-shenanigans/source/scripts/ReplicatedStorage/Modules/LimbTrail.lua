local module = {}

function module.limbtrail(part,duration) 
	local trail = script["Limb Trail"].Trail:Clone()
	trail.Parent = part
	game.Debris:AddItem(trail,duration)
end	

function module.waterplam(part,duration) 
	local trail = script.WaterPalm:Clone()
	trail.Parent = workspace.Effects
	trail.CFrame = part.CFrame
	local w = Instance.new("Weld")
	spawn(function()
		w.Parent = part
		w.Part0 = w.Parent
		w.Part1 = trail
		task.wait()
		for _,Particles in pairs(trail:GetDescendants()) do
			if Particles:IsA("ParticleEmitter") then
				Particles.Enabled = true
			end
		end
	end)
	task.delay(duration,function()
		w:Destroy()
		trail.Anchored = true
		for _,Particles in pairs(trail:GetDescendants()) do
			if Particles:IsA("ParticleEmitter") then
				Particles.Enabled = false
			end
		end
	end)
	game.Debris:AddItem(trail,duration+0.5)
end	

function module.wind(part,duration) 
	local trail = script.wind:Clone()
	trail.Parent = workspace.Effects
	trail.CFrame = part.CFrame
	local w = Instance.new("Weld")
	spawn(function()
		w.Parent = part
		w.Part0 = w.Parent
		w.Part1 = trail
		task.wait()
	end)
	task.delay(duration,function()
		w:Destroy()
		trail.Anchored = true
	end)
	game.Debris:AddItem(trail,duration)
end

function module.Saitama(part,duration) 
	local trail = script.Saitama:Clone()
	trail.Parent = workspace.Effects
	trail.CFrame = part.CFrame
	local w = Instance.new("Weld")
	spawn(function()
		w.Parent = part
		w.Part0 = w.Parent
		w.Part1 = trail
		task.wait()
	end)
	task.delay(duration,function()
		w:Destroy()
		trail.Anchored = true
	end)
	game.Debris:AddItem(trail,duration)
end



function module.colortrail(part,duration) 
	local trail = script["Color Trail"]:Clone()
	trail.Parent = workspace.Effects
	trail.CFrame = part.CFrame
	local w = Instance.new("Weld")
	spawn(function()
		w.Parent = part
		w.Part0 = w.Parent
		w.Part1 = trail
		trail.Trail.Trail.Color = ColorSequence.new(part.Color)
		task.wait()
		for _,Particles in pairs(trail:GetDescendants()) do
			if Particles:IsA("ParticleEmitter") then
				Particles.Enabled = true
			end
		end
	end)
	task.delay(duration,function()
		w:Destroy()
		trail.Anchored = true
		for _,Particles in pairs(trail:GetDescendants()) do
			if Particles:IsA("ParticleEmitter") then
				Particles.Enabled = false
			end
		end
	end)
	game.Debris:AddItem(trail,duration+0.5)
end	

return module
