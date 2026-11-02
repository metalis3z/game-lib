script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.Values.SeerHour.Value == false and workspace.The_Rake.NPC.Health > 0 then
		workspace.Values.SeerHour.Value = true
	end
end)