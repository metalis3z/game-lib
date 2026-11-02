script.Parent.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.PoliceCalls:InvokeServer("rem",script.Parent.Parent.CALLID.Value)
end)