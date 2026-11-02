
local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents").Notifications 
local gui = script.Parent
local Canvas = gui.list


_G.SendNotification = function(Mode, Text, Duration)
	if script:FindFirstChild(Mode) then
		local success, err = pcall(function()
			local Notification = script:WaitForChild(Mode):Clone()
			Notification.Header.Text = Text
			Notification.Size = UDim2.new(0, 0,0.087, 0)
			Notification.Filler.Size = UDim2.new(1, 0,1, 0)
			Notification.Parent = Canvas

			Notification:TweenSize(UDim2.new(1, 0,0.087, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			task.wait(0.2)
			Notification.Filler:TweenSize(UDim2.new(0.011, 0,1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

			Notification.bar:TweenSize(UDim2.new(1, 0,0.05, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, Duration, true)
			task.wait(Duration)

			Notification.Filler:TweenSize(UDim2.new(1, 0,1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2,true)
			task.wait(0.25)
			Notification:TweenSize(UDim2.new(0, 0,0.087, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			task.wait(0.2)
			Notification:Destroy()
		end)
		if not success then
			warn("There was an error while trying to create an notification!")
			warn(err)
		end
	else
		warn("Could not fetch an available mode!")
		print(tostring(Mode))
	end
end

RemoteEvent.OnClientEvent:Connect(_G.SendNotification)



