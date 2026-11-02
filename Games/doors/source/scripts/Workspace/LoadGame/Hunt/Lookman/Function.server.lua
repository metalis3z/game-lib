game.ReplicatedStorage.EntityInfo.LookmanDamage.OnServerEvent:Connect(function(p)
	if p.Character.Humanoid.Health == 20 or p.haracter.Humanoid.Health < 20 then
		p.Character.Humanoid:TakeDamage(20)
	else
		p.Character.Humanoid:TakeDamage(20)
	end
end)