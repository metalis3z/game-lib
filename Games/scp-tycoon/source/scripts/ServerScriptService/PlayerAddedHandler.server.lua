game.Players.PlayerAdded:Connect(function(Player)
	local Data = Instance.new("Folder")
	Data.Name = "Data"
	Data.Parent = Player
	
	local TycoonOwned = Instance.new("NumberValue")
	TycoonOwned.Name = "TycoonOwned"
	TycoonOwned.Value = 0
	TycoonOwned.Parent = Data
	
	local Cash = Instance.new("NumberValue")
	Cash.Name = "Cash"
	Cash.Parent = Data
	
	local InEvent = Instance.new("BoolValue")
	InEvent.Name = "InEvent"
	InEvent.Parent = Data
	
	local InEvent = Instance.new("BoolValue")
	InEvent.Name = "ReadyForEvent"
	InEvent.Parent = Data
	
	if game:GetService('RunService'):IsStudio() then
		Cash.Value = 100000
	end
end)