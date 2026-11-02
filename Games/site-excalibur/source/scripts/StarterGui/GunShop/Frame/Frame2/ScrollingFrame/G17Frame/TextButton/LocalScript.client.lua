local player = game.Players.LocalPlayer
 local RemoteEvent = game.ReplicatedStorage.ShopEvents:FindFirstChild("gun3") -- the event name
 script.Parent.MouseButton1Click:Connect(function(click)
	RemoteEvent:FireServer("MK18",350) --change the tool name and the price (tool name has to be EXACTLY the same)
 end)