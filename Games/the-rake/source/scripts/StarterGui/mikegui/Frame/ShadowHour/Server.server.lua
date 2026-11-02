script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.Values.ShadowHour.Value == false and workspace.The_Rake.NPC.Health > 0 then
		workspace.Values.ShadowHour.Value = true
	end
end)
