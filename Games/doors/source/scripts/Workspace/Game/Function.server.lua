script.Parent:GetAttributeChangedSignal("SetTimer"):Connect(function()
	if script.Parent:GetAttribute("GameStart") == true then
		game.Workspace.Hunt_AmbienceStart.TimePosition = script.Parent:GetAttribute("Ambience")
	end
end)

script.Parent:GetAttributeChangedSignal("GameStart"):Connect(function()
	if script.Parent:GetAttribute("GameStart") == true then
		game.Workspace.Hunt_AmbienceStart:Play()
		script.Parent:SetAttribute("SetTimer", true)
		
		while true do
			task.wait(1)
			if script.Parent:GetAttribute("GameTimer") == 0 then
				
			else
				if game.Workspace.Game:GetAttribute("StopTimer") == true then
					game.Workspace.Hunt_AmbienceStart:Stop()
				else
					script.Parent:SetAttribute("Ambience", script.Parent:GetAttribute("Ambience") + 1)
					script.Parent:SetAttribute("GameTimer", script.Parent:GetAttribute("GameTimer") - 1)
				end
			end
		end
	end
end)