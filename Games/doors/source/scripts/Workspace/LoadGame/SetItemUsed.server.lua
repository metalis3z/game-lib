game.ReplicatedStorage.EntityInfo.SetItemUsed.OnServerEvent:Connect(function(pl, tool)
	tool.Used.Value = true
end)