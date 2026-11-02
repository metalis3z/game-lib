workspace.Values.Died.Changed:Connect(function()
	if workspace.Values.Died.Value == true then
		script.Parent.Parent.leaderstats.Kills.Value = script.Parent.Parent.leaderstats.Kills.Value + 1
		script.Parent.Parent.leaderstats.Points.Value = script.Parent.Parent.leaderstats.Points.Value + 100
	end
end)