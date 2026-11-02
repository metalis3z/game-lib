wait(2)
local keyboardInput = nil
local IsNewPlayer = workspace.Main.IsNewPlayer:InvokeServer()
local UIS = game:GetService("UserInputService")

AlreadyShowedMessage = false --only show once

if UIS.TouchEnabled then
	script.Parent:Destroy()
	return
end


if IsNewPlayer and not UIS.TouchEnabled then 
	
	script.Parent.Changed:connect(function(prop)
		if prop == "Visible" and not UIS.TouchEnabled then
			
			if script.Parent.Visible then
				if not AlreadyShowedMessage then
					AlreadyShowedMessage  = true
					
					keyboardInput = UIS.InputBegan:connect(function(input,gameProcessed)
						if input.UserInputType == Enum.UserInputType.Keyboard and 
							(input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down or input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right or
							 input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D) then
							wait(2)
							if script.Parent then
								script.Parent:Destroy()
							end
							
						end
					end)
					
					wait(7)
					script.Parent:Destroy()
				else
					script.Parent.Visible = false
				end
			else
				if keyboardInput then keyboardInput:disconnect() keyboardInput = nil end
			end
	
		end
	end)
	
else
	if script.Parent then
		script.Parent:Destroy() 
	end
end


