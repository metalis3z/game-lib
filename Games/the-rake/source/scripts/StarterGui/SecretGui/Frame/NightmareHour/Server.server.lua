script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.Values.NightmareHour.Value == false and workspace.The_Rake.NPC.Health > 0 then
		workspace.Values.NightmareHour.Value = true
	end
end)