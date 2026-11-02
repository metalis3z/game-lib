if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Settings = require(game:FindService('ReplicatedStorage'):WaitForChild('Gang Settings'))

Update_Zone = function(Zone, Current_Gang)
	if Current_Gang ~= nil and Current_Gang ~= '' then
		if Player:IsInGroup(Current_Gang) and Player:FindFirstChild('stored'):FindFirstChild('Gang').Value == Current_Gang then
			Zone.Color = Settings.Config.Colors.Owned
		else
			Zone.Color = Settings.Config.Colors.Not_Owned
		end
	else
		Zone.Color = Settings.Config.Colors.Not_Owned
	end 
	Zone:FindFirstChild('Sparkles').Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Zone.Color), ColorSequenceKeypoint.new(1, Zone.Color)}
	Zone:FindFirstChild('SurfaceLight').Color = Zone.Color
	return
end

for _,v in next, workspace:WaitForChild('GZones'):GetChildren() do
	if v:IsA('MeshPart') and v:FindFirstChild('Gang') then
		local Current_Gang, Handler, Touch = v:WaitForChild('Gang'), v:WaitForChild('Interact'):WaitForChild('Handler'), v:WaitForChild('Touch')
		Update_Zone(v, Current_Gang.Value)
		Touch.Touched:Connect(function(Hit)
			if Hit.Name == 'HumanoidRootPart' then
				v.Color = Settings.Config.Colors.Owned
				v:FindFirstChild('Sparkles').Color = ColorSequence.new{ColorSequenceKeypoint.new(0, v.Color), ColorSequenceKeypoint.new(1, v.Color)}
				v:FindFirstChild('SurfaceLight').Color = v.Color
				if not Touch.Notification.IsPlaying then Touch.Notification:Play() end
				Handler.Enabled = true
			end
		end)
		Touch.TouchEnded:Connect(function(Hit)
			if Hit.Name == 'HumanoidRootPart' then 
				Update_Zone(v, Current_Gang.Value)
				Handler.Enabled = false
			end
			if Touch.Notification.TimePosition >= 1 then Touch.Notification:Stop() end
			if Player.PlayerGui:FindFirstChild('Zone') then Player.PlayerGui:FindFirstChild('Zone'):Destroy() end
		end)
		Current_Gang:GetPropertyChangedSignal('Value'):Connect(function()
			Update_Zone(v, Current_Gang.Value)
		end)
		Handler.Triggered:Connect(function()
			Handler.Enabled = false
			repeat task.wait(.01) until Player.PlayerGui:FindFirstChild('Zone')
			Player.PlayerGui:FindFirstChild('Zone').Main.Close.MouseButton1Click:Connect(function()
				Handler.Enabled = true
			end)
		end)
	end
end