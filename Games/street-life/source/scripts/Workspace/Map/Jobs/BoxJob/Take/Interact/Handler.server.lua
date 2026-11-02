local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

script.Parent.Triggered:Connect(function(Player)
	local Extra = Player:WaitForChild('Extra')
	local Stored = Player:WaitForChild('stored')

	if not Player.Backpack:FindFirstChild('Box') and not Player.Character:FindFirstChild('Box') then
		JobRemote:FireClient(Player, 'Box', script.Parent)
		NotifyRemote:FireClient(Player, 'Picked up Box.', 2)
		game:FindService('ServerStorage'):FindFirstChild('Box'):Clone().Parent = Player.Character
		local PickedUpBox = Instance.new('BoolValue', Player.Character)
		PickedUpBox.Name = 'PickedUpBox'
		task.wait(3)
		PickedUpBox:Destroy()
	end
end)