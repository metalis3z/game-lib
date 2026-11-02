script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.Values.MikeHour.Value == false and workspace.The_Rake.NPC.Health > 0 then
		workspace.Values.MikeHour.Value = true
	end
end)
