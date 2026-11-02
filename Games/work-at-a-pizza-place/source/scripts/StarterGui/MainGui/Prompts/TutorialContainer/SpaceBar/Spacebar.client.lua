wait(2)
local keyboardInput = nil
local IsNewPlayer = workspace.Main.IsNewPlayer:InvokeServer()
local UIS = game:GetService("UserInputService")
ShowedStandMessage = false --only show once
ShowedExitMessage = false 
--detect when player sits, tell player to press space to jump, detect when player presses space. Then remove the intructions
if IsNewPlayer and not UIS.TouchEnabled then 
	script.Parent.Changed:connect(function(prop)
		if prop == "Visible" and not UIS.TouchEnabled then
			if script.Parent.Visible then
				keyboardInput = UIS.InputBegan:connect(function(input,gameProcessed)
					if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
						script.Parent:Destroy()
					end
				end)
				wait(7)
				script.Parent.Visible = false
			else
				if keyboardInput then keyboardInput:disconnect() keyboardInput = nil  end
			end
		
		end
	end)
	
	local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid",5)
	humanoid.Seated:connect(function(active,seat)
		if active and seat and seat.Parent then
			if not ShowedExitMessage and seat.Name == "Driver" then
				script.Parent.Frame.TextLabel.Text = "Exit Car"
				ShowedExitMessage = true
				wait(2)
				script.Parent.Visible = true
				
				
				
			elseif not ShowedStandMessage and seat.Name ~= "Driver" then
				script.Parent.Frame.TextLabel.Text = "Stand Up"
				ShowedStandMessage = true
				wait(.5)
				script.Parent.Visible = true
				
			end
		end
	end)
else
	script.Parent:Destroy()
	
end

