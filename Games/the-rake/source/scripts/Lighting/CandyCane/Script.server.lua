script.parent.Equipped:Connect(function()
	workspace.CandyCaneSpawned.Value = false
    script:Destroy()
end)