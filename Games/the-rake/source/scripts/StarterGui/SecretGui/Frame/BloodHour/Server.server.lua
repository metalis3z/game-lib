script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.Values.BloodHour.Value == false and workspace.The_Rake.NPC.Health > 0 then
		workspace.Values.BloodHour.Value = true
	end
end)