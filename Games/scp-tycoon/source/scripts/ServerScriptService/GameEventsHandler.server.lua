
local function GetReadyPlayers()
	local TotalReady = 0
	for i,Player in pairs(game.Players:GetPlayers()) do
		if Player.Data.ReadyForEvent.Value == true then
			TotalReady += 1
		end
	end
	return TotalReady
end
local PlayersInMatch = {}

while wait(math.random(35,70)) do
	PlayersInMatch = {}
	local Event = "Blinding Lights"
	local Time = 50
	if game.Workspace["Event Maps"]:FindFirstChild(Event) then
		game.ReplicatedStorage.Events.PromptEvent:FireAllClients(Event)
		game.ReplicatedStorage.GameEventData.EventName.Value = Event
		game.ReplicatedStorage.GameEventData.Message.Value = "New Event starting soon! |".. Event
		wait(3)
		local WaitTime = 15
		while WaitTime >=1 do
			game.ReplicatedStorage.GameEventData.Message.Value = "Event: Waiting for players.. |".. Event
			WaitTime -= 1
			wait(1)
		end
		local TimeWaiting = 0
		local CanStart = false
		while wait(1) do
			TimeWaiting += 1
			if GetReadyPlayers() >= 1 then
				CanStart = true
				break
			end
			if TimeWaiting >= 30 then
				break
			end
		end
		
		if CanStart then
			
			
			for i,Player in pairs(game.Players:GetPlayers()) do
				if Player.Data.ReadyForEvent.Value == true then
					table.insert(PlayersInMatch,Player)
				end
			end
			

			for i,v in pairs(PlayersInMatch) do
				repeat wait() until v.Character:FindFirstChild("HumanoidRootPart")
				local forceField = Instance.new("ForceField")
				forceField.Visible = false
				forceField.Parent = v.Character
				v.Character.HumanoidRootPart.CFrame = game.Workspace["Event Maps"]:FindFirstChild(Event).Spawn.CFrame
				v.Data.InEvent.Value = true
				local humanoid = v.Character:WaitForChild("Humanoid", 1)
				print("Going")
				if humanoid then
				humanoid.Died:Connect(function()
						if table.find(PlayersInMatch,v) then
						
						table.remove(PlayersInMatch,table.find(PlayersInMatch,v))
					end
					if #PlayersInMatch == 1 then
						game.ReplicatedStorage.GameEventData.Message.Value = "Event Winner: ".. PlayersInMatch[1].Name
							game.Players:FindFirstChild(PlayersInMatch[1].Name).Data.Cash.Value += math.random(5000,15000)
							wait(7)
						end
					end)
				else
					
					if table.find(PlayersInMatch,v) then
						table.remove(PlayersInMatch,table.find(PlayersInMatch,v))
					end
					
				end
			end
			game.ReplicatedStorage.GameEventData.Message.Value = Event.." Event starting.."
			wait(4.5)
			for i,v in pairs(PlayersInMatch) do
				v.Character.Humanoid.Health = 100
				if v.Character:FindFirstChild("ForceField") then
					v.Character:FindFirstChild("ForceField"):Destroy()
				end
			end
	
			game.ReplicatedStorage.GameEventData.Message.Value = Event.." Event in Progress!"
		end
		
	end
	for i,v in pairs(game.Players:GetPlayers()) do
		v:WaitForChild("Data"):WaitForChild("InEvent").Value = false
		v:WaitForChild("Data"):WaitForChild("ReadyForEvent").Value = false
	end
	for i,Player in pairs(PlayersInMatch) do
		Player:LoadCharacter()
	end
	game.ReplicatedStorage.GameEventData.EventName.Value = ""
	game.ReplicatedStorage.GameEventData.Message.Value = "Weclome to SCP Tycoon"
	wait(math.random(20,40))
end

game.Players.PlayerRemoving:Connect(function(Player)
	if table.find(PlayersInMatch,Player) then
		table.remove(PlayersInMatch,table.find(PlayersInMatch,Player))
	end
end)