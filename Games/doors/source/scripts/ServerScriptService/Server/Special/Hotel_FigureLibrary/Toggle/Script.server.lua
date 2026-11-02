local debounce = false

script.Parent.Touched:Connect(function(player)
	if not debounce then
		debounce = true
		for i, d in pairs(game.Players:GetPlayers()) do 
			if d.Character then 
				game.ReplicatedStorage.EntityInfo.FigureCutsceneNew:FireClient(d)
				if d.Character and d.Character.PrimaryPart then
					d.Character.PrimaryPart.Anchored = true
				end
				
				task.delay(0.9, function()
					workspace.Ambience_Figure.TimePosition = 0
					workspace.Ambience_Figure:Play()
				end)
			end
		end
		script.Parent.Parent.Animated.Generation.Enabled = true
		--script.Parent.Parent.FigureSetup.TriggerFigure:Fire(player)
		script.Parent.Parent.Door.Door.Open:Play()
		script.Parent.Parent.Door.Door1.Open:Play()
		script.Parent.Parent.Door.Door.Anchored = false
		script.Parent.Parent.Door.Door.CanCollide = false
		script.Parent.Parent.Door.Door1.Anchored = false
		script.Parent.Parent.Door.Door1.CanCollide = false
		script.Parent.Parent.Door.HingeConstraint2.TargetAngle = -100
		script.Parent.Parent.Door.HingeConstraint.TargetAngle = 100
		wait(4)
		script.Parent.Parent.Door.HingeConstraint2.TargetAngle = 0
		script.Parent.Parent.Door.HingeConstraint.TargetAngle = 0
		wait(4)
		script.Parent.Parent.Door.FigureCollision.CollisionGroup = "WallStuff"
		script.Parent.Parent.Door.FigureCollision.CanCollide = true
		script.Parent.Parent.FigureSetup.FigureMovement.AssetControl.Enabled = true
		for i, d in pairs(game.Players:GetPlayers()) do 
			if d.Character then 
				if d.Character and d.Character.PrimaryPart then
					d.Character.PrimaryPart.Anchored = false
				end
				d.Character:PivotTo(script.Parent.Parent.FigureSetup.TeleportGame.CFrame)
			end
		end
	end
end)