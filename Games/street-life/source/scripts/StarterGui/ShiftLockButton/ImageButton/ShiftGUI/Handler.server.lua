script.Parent:WaitForChild('RemoteEvent').OnServerEvent:Connect(function(Player, Shiftlock, Arg)
	if Player and Shiftlock:IsA('BoolValue') and Shiftlock.Name == 'Shiftlock' then
		Shiftlock.Value = Arg
	end
end)