script.Parent.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.PoliceCalls:InvokeServer("accept",script.Parent.Parent.CALLID.Value)
end)