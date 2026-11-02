local player = game.Players.LocalPlayer
 local RemoteEvent = game.ReplicatedStorage.ShopEvents:FindFirstChild("gun2") --the event name
 script.Parent.MouseButton1Click:Connect(function(click)
     RemoteEvent:FireServer("AK47",300) --change the tool name and the price (tool name has to be EXACTLY the same)
 end)