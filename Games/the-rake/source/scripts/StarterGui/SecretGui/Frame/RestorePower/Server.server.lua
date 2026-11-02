script.Parent.RemoteEvent.OnServerEvent:Connect(function()
	if workspace.PowerOutValue.Value == 1 then
		workspace.PowerOutValue.Value = 0
	elseif workspace.PowerOutValue.Value == 0 then
		workspace.PowerOutValue.Value = 1
	end
end)