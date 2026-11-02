-- Services Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

-- ServerStorage Variables
local StagesFolder = ServerStorage:WaitForChild("Stages")
local Stages = StagesFolder:GetChildren()

-- Workspace Variables
local Tower = game.Workspace:WaitForChild("Tower")
local Storage = game.Workspace:WaitForChild("Storage")
local Lobby = Storage:WaitForChild("Lobby")
local End = Storage:WaitForChild("End")
local SpawnsModel = Lobby:WaitForChild("Spawns")
local Spawns = SpawnsModel:GetChildren()
local Songs = game.Workspace:WaitForChild("Songs")
local WinTp = workspace.WinTp
local RandomSong
local RandomSpawn

-- ReplicatedStorage Variables
local TimerSpeed = ReplicatedStorage:WaitForChild("TimerSpeed")
local Minutes = ReplicatedStorage:WaitForChild("Minutes")
local Seconds = ReplicatedStorage:WaitForChild("Seconds")
local TimerTag = ReplicatedStorage:WaitForChild("TimerTag")
local MultiplierVisible = ReplicatedStorage:WaitForChild("MultiplierVisible")
local Multiplies = ReplicatedStorage:WaitForChild("Multiplies")
local TowerHeight = ReplicatedStorage:WaitForChild("TowerHeight")
local MutatorsFolder = ReplicatedStorage:WaitForChild("Mutators")

local Floor1
local Floor2
local Floor3
local Floor4
local Floor5

debounce = false

-- You might get errors for this function below
function NewTower()
	debounce = true
	Floor1 = Stages[math.random(1, #Stages)]:Clone()
	Floor1.Parent = Tower
	Floor1.PrimaryPart = Floor1:FindFirstChild("Center")
	Floor1:SetPrimaryPartCFrame(Floor1.Center.CFrame)
	local Floor1Height = Floor1.Height.Value
	wait()
	Floor2 = Stages[math.random(1, #Stages)]:Clone()
	Floor2.Parent = Tower
	Floor2.PrimaryPart = Floor2:FindFirstChild("Center")
	Floor2:SetPrimaryPartCFrame(Floor1.Center.CFrame + Vector3.new(0, Floor1Height, 0))
	Floor2:SetPrimaryPartCFrame(Floor2.Center.CFrame * CFrame.Angles(0, math.rad(180), 0))
	local Floor2Height = Floor2.Height.Value
	wait()
	Floor3 = Stages[math.random(1, #Stages)]:Clone()
	Floor3.Parent = Tower
	Floor3.PrimaryPart = Floor3:FindFirstChild("Center")
	Floor3:SetPrimaryPartCFrame(Floor2.Center.CFrame + Vector3.new(0, Floor2Height, 0))
	Floor3:SetPrimaryPartCFrame(Floor3.Center.CFrame * CFrame.Angles(0, math.rad(180), 0))
	local Floor3Height = Floor3.Height.Value
	wait()
	Floor4 = Stages[math.random(1, #Stages)]:Clone()
	Floor4.Parent = Tower
	Floor4.PrimaryPart = Floor4:FindFirstChild("Center")
	Floor4:SetPrimaryPartCFrame(Floor3.Center.CFrame + Vector3.new(0, Floor3Height, 0))
	Floor4:SetPrimaryPartCFrame(Floor4.Center.CFrame * CFrame.Angles(0, math.rad(180), 0))
	local Floor4Height = Floor4.Height.Value
	wait()
	Floor5 = Stages[math.random(1, #Stages)]:Clone()
	Floor5.Parent = Tower
	Floor5.PrimaryPart = Floor5:FindFirstChild("Center")
	Floor5:SetPrimaryPartCFrame(Floor4.Center.CFrame + Vector3.new(0, Floor4Height, 0))
	Floor5:SetPrimaryPartCFrame(Floor5.Center.CFrame * CFrame.Angles(0, math.rad(180), 0))
	local Floor5Height = Floor5.Height.Value
	wait()
	End.PrimaryPart = End:WaitForChild("Center")
	End:SetPrimaryPartCFrame(Floor5.Center.CFrame + Vector3.new(0, Floor5Height), 0)
	End:SetPrimaryPartCFrame(End.Center.CFrame * CFrame.Angles(0, math.rad(180), 0))
	debounce = false

	TowerHeight.Value = Floor1Height + Floor2Height + Floor3Height + Floor4Height + Floor5Height + 15 * 2
	ReplicatedStorage.HeightEvent:FireAllClients(TowerHeight.Value)
end

RandomSong = Songs:GetChildren()[math.random(1, #Songs:GetChildren())]
RandomSong:Play()
Minutes.Value = 8
Seconds.Value = 0
TimerSpeed.Value = 1
MultiplierVisible.Value = false
Multiplies.Value = 1
debounce = true
NewTower()

while true do
	if Minutes and Seconds and TimerSpeed and Tower and Stages then
		repeat
			if Seconds.Value <= 9 then
				TimerTag.Value = tostring(Minutes.Value)..":0"..tostring(Seconds.Value)
			else
				TimerTag.Value = tostring(Minutes.Value)..":"..tostring(Seconds.Value)
			end
			if Seconds.Value <= 0 then
				Minutes.Value = Minutes.Value - 1
				Seconds.Value = 59
			else
				Seconds.Value = Seconds.Value - 1
			end
			wait(TimerSpeed.Value)
		until Minutes.Value <= 0 and Seconds.Value <= 0
		if Minutes.Value <= 0 and Seconds.Value <= 0 then
			TimerTag.Value = "0:00"
		end
		wait(TimerSpeed.Value)
		for i, v in pairs(Players:GetChildren()) do
			if v.Character:FindFirstChild("Win") then
				v.Character.Win:Destroy()
			end
			if v:FindFirstChild("Backpack") then
				v.Backpack:ClearAllChildren()
			end
		end
		Tower:ClearAllChildren()
		Minutes.Value = 8
		Seconds.Value = 0
		TimerSpeed.Value = 1
		MultiplierVisible.Value = false
		Multiplies.Value = 1
		RandomSong:Stop()
		wait()
		RandomSong = Songs:GetChildren()[math.random(1, #Songs:GetChildren())]
		RandomSong:Play()
		NewTower()
		for i, v in pairs(Players:GetChildren()) do
			v.Character.Torso.CFrame = WinTp.CFrame
		end
		for i, v in pairs(MutatorsFolder:GetChildren()) do
			v.Value = false
		end
	end
end