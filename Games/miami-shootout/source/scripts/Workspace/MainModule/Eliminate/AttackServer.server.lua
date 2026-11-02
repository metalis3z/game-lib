script.Parent.RemoteEvent.OnServerEvent:Connect(function(p,target)
	if p.Name ~= script.Parent.Parent.Name then
		return print("ownership denied")
	end
	
	local fleshExplode = script.Parent.Explode
	local blood = script.Parent["Blood Particle"]
	
	local bClone = blood:Clone()
	local fleshClone = fleshExplode:Clone()
	
	fleshClone.Parent = target.PrimaryPart
	bClone.Parent = target.PrimaryPart
	
	fleshClone:Play()
	game.Debris:AddItem(fleshClone, fleshClone.TimeLength)
	
	bClone:Emit(math.random(20,25))
	
	game.Debris:AddItem(bClone, 5)
	
	target:FindFirstChild("Humanoid"):TakeDamage(math.huge)
end)