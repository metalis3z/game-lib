game.ServerScriptService.Handler:GetAttributeChangedSignal("LibraryEscape"):Connect(function()
	if game.ServerScriptService.Handler:GetAttribute("LibraryEscape") == true then
		script.Parent.Door1.Anchored = false
		script.Parent.Door2.Anchored = false

		script.Parent.Door1.Open:Play()
		script.Parent.Door2.Open:Play()
	else
		script.Parent.Door1.Anchored = false
		script.Parent.Door2.Anchored = false
	end
end)

local Trigger = script.Parent.Parent.Trigger
local Functed = false

Trigger.Touched:Connect(function()
	if Functed == false then
		Functed = true
		game.Workspace.Ambience_Figure:Stop()
		game.Workspace.Ambience_FigureEnd:Play()
		game.Workspace.Ambience_FigureEnd.TimePosition = 178.5
		
		game.Workspace.GameSettings.Server.NextRush.Value = false
		game.Workspace.GameSettings.Server.RunRush.Value = true
		
		workspace:FindFirstChild("FigureMovement", true).Head.Growl:Play()
		workspace:FindFirstChild("FigureMovement", true).Root.Anchored = true
		workspace:FindFirstChild("FigureMovement", true).FigureRagdoll.HumanoidRootPart.Anchored = true
		workspace:FindFirstChild("FigureMovement", true).AssetControl.Enabled = false
		
		script.Parent.HingeConstraint2.TargetAngle = 0
		script.Parent.HingeConstraint.TargetAngle = 0
		game.ServerScriptService.Handler:SetAttribute("LibraryEscape", false)
		
		task.delay(5, function()
			workspace:FindFirstChild("FigureMovement", true):Destroy()
		end)

		for i, v in pairs(game.Players:GetPlayers()) do 
			if v.Character then 
				if v.Character.Humanoid.Health == 0 then

				else
					v.Character:PivotTo(script.Parent.Parent.Trigger.CFrame)
				end
			end
		end
	end
end)