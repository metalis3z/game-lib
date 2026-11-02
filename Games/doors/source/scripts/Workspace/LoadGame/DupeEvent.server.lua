local l__TweenService__1 = game:GetService("TweenService");

game.Workspace.GameSettings.Fires.DupeEvent.Event:Connect(function()
	local room_2 = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2):WaitForChild("Door")
	local room_3 = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3):WaitForChild("Door")
	local image = game.Workspace.GameSettings.Fires.DupeEvent.Duped
	
	task.delay(3, function()
		local clone1 = image:Clone()
		-- Current room
		clone1.Parent = room_2.Sign
		clone1.Visible = true
		l__TweenService__1:Create(clone1, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			ImageTransparency = 0
		}):Play();
		l__TweenService__1:Create(room_2.Sign.Stinker, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();
		l__TweenService__1:Create(room_2.Sign.Stinker.Highlight, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();
		l__TweenService__1:Create(room_2.Sign.Stinker.Shadow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();

		-- Room - 2
		local clone2 = image:Clone()
		clone2.Parent = room_3.Sign
		clone2.Visible = true
		l__TweenService__1:Create(clone2, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			ImageTransparency = 0
		}):Play();
		l__TweenService__1:Create(room_3.Sign.Stinker, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();
		l__TweenService__1:Create(room_3.Sign.Stinker.Highlight, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();
		l__TweenService__1:Create(room_3.Sign.Stinker.Shadow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play();
	end)
end)