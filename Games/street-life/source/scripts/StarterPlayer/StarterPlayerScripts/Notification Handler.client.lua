if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()

game:FindService('ReplicatedStorage'):WaitForChild('Notify').OnClientEvent:Connect(function(Message, Time)
	if Message and Time then
		if PlayerGui:FindFirstChild('Notification') then PlayerGui:FindFirstChild('Notification'):Destroy() end
		local Clone = game:FindService('ReplicatedStorage'):FindFirstChild('Notification'):Clone()
		Clone.Main.Noti.Text = Message
		if game:FindService('UserInputService').TouchEnabled then
			Clone.Main.Position = UDim2.new(Clone.Main.Position.X.Scale, Clone.Main.Position.X.Offset, Clone.Main.Position.Y.Scale - 0.115, Clone.Main.Position.Y.Offset)
			Clone.Line.Position = UDim2.new(Clone.Line.Position.X.Scale, Clone.Line.Position.X.Offset, Clone.Line.Position.Y.Scale - 0.115, Clone.Line.Position.Y.Offset)
		else
			Clone.Main.Position = UDim2.new(Clone.Main.Position.X.Scale, Clone.Main.Position.X.Offset, Clone.Main.Position.Y.Scale - 0.025, Clone.Main.Position.Y.Offset)
			Clone.Line.Position = UDim2.new(Clone.Line.Position.X.Scale, Clone.Line.Position.X.Offset, Clone.Line.Position.Y.Scale - 0.025, Clone.Line.Position.Y.Offset)
		end
		Clone.Parent = PlayerGui
		game:FindService('TweenService'):Create(Clone.Line:FindFirstChild('Color'), TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 1, 0)}):Play()
		task.wait(Time)
		Clone:Destroy()
	end
end)