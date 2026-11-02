script.Parent.ModulePrompt.Triggered:Connect(function(player)
	
	if script.Parent.Parent.RightLide.Value == script.Parent.Name then
		local mad = math.random(1, 2)
		local clone

		if mad == 1 then
			clone = script.Parent.Parent.CutVercionR:Clone()
		elseif mad == 2 then
			clone = script.Parent.Parent.CutVercionL:Clone()
		else
			clone = script.Parent.Parent.CutVercionR:Clone()
		end
		
		script.Parent.Parent.Parent.ActiveElevator:Fire()

		clone.Parent = script.Parent.Parent
		clone.CeD1.Color = script.Parent.Color
		clone.CeD.Color = script.Parent.Color

		clone:PivotTo(script.Parent.Dot.CFrame)
		wait()
		script.Parent:Destroy()
		
	else
		script.Parent.ModulePrompt:Destroy()
		
		game.ReplicatedStorage.EntityInfo.Caption:FireClient(player, 'You have selected the wrong wire..')
		
		player.Character:FindFirstChild("Humanoid"):TakeDamage(40)
		game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(player, {"You Died to Electricity.", "Looks like you picked the wrong wire.", "Next time, watch which wire you cut."}, "Blue")
		player.Stats.Death.Value = "Electricity"
	end
	
end)