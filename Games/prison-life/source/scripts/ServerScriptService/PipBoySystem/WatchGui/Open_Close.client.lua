local player = game.Players.LocalPlayer

local IsShotLaserValue = player:WaitForChild("PipBoy"):WaitForChild("IsAntiKill")
local EnabledValue = player:WaitForChild("PipBoy"):WaitForChild("Enabled")

local Uis = game:GetService("UserInputService")

local PipBoyConfig = game.ReplicatedStorage:WaitForChild("PipBoyConfig")
local Remote = PipBoyConfig:WaitForChild("Remotes")
local Open = Remote:WaitForChild("Open")
local Close = Remote:WaitForChild("Close")

local isOpen = false

local FrameStats = script.Parent:WaitForChild("Stats")

local WarnFrame = script.Parent:WaitForChild("Warn")

function closeAFrame()
	for i, frame in pairs(script.Parent:GetChildren()) do
		if frame:IsA("Frame") then
			if frame.Name ~= "AntiKill" then
				if frame.Visible == true then
					frame.Visible = false
				end
			end
		end
	end
end

Uis.InputBegan:Connect(function(input)
	local KeyCode = input.KeyCode
	
	if KeyCode == Enum.KeyCode.P then
		if EnabledValue.Value == true and IsShotLaserValue.Value == false then
			if isOpen == false then
				if player.Character:WaitForChild("Humanoid").Health < 1 then
					return
				else
					isOpen = true

					FrameStats.Visible = true
					Open:FireServer()
				end
			else
				closeAFrame()
				Close:FireServer()

				isOpen = false
			end
		else
			WarnFrame.Visible = true
		end
	end
end)

WarnFrame.Yes.MouseButton1Click:Connect(function()
	WarnFrame.Visible = false
	
	Remote.ApplyASettings:FireServer("Enabled", true)
end)


WarnFrame.No.MouseButton1Click:Connect(function()
	WarnFrame.Visible = false
end)


IsShotLaserValue.Changed:Connect(function() --when antikill started
	if IsShotLaserValue.Value == true then
		if isOpen == true then
			closeAFrame()
			Close:FireServer()
			isOpen = false
		end
	end
end)

player.Character.ChildAdded:Connect(function(child)
	if child:IsA("Tool") then
		if isOpen == true then
			closeAFrame()
			Close:FireServer()
			isOpen = false
		end
	end
end)

EnabledValue.Changed:Connect(function()
	if EnabledValue.Value == false then
		if isOpen == true then
			closeAFrame()
			Close:FireServer()
			isOpen = false
		end
	end
end)