script.Parent.Activated:Connect(function()
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.currentSelect.Value ~= script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.currentEquip.Value then
		if script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.currentSelect.Value == "Scooter" then
			script.Parent.Parent.Top.Label.Text = "Equipped"
			game:GetService("ReplicatedStorage").RemoteEvents.updateEquip:FireServer("default")
		else
			script.Parent.Parent.Top.Label.Text = "Equipped"
			game:GetService("ReplicatedStorage").RemoteEvents.updateEquip:FireServer(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.currentSelect.Value)
		end
	end
end)