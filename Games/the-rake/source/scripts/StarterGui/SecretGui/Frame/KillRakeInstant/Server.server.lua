script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.The_Rake.NPC.Health > 0 then
		workspace.The_Rake.NPC.Health = 0
	end
end)