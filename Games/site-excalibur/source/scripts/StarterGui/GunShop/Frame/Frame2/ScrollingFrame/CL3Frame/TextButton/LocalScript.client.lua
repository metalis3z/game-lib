local player = game.Players.LocalPlayer
 local RemoteEvent = game.ReplicatedStorage.ShopEvents:FindFirstChild("gun1") --the event name
 script.Parent.MouseButton1Click:Connect(function(click)
	RemoteEvent:FireServer("M4A1",250) --change the tool name and the price (tool name has to be EXACTLY the same)
 end)