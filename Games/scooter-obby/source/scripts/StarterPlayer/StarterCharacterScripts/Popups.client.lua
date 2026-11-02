local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer

local stageObjects = {}

local CollectionService = game:GetService("CollectionService")

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end

	table.insert(stageObjects[stage], cp)
end

ReplicatedStorage.RemoteEvents.clientTP.OnClientEvent:Connect(function(stageObjectFired)
	workspace.CurrentCamera.CFrame = CFrame.Angles(math.rad(-20),math.rad(-90),0)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	if not LocalPlayer:FindFirstChild("PopupDeaths") then
		local pud = Instance.new("NumberValue", LocalPlayer)
		pud.Name = "PopupDeaths"
	end
	LocalPlayer:FindFirstChild("PopupDeaths").Value += 1
	if LocalPlayer:FindFirstChild("PopupDeaths").Value >= 2 then
		LocalPlayer:FindFirstChild("PopupDeaths").Value = 0
		ReplicatedStorage.RemoteEvents.sendPopup:Fire()
	end
	if game:GetService("Players"):FindFirstChild(LocalPlayer.Name) then
		local player = game:GetService("Players"):FindFirstChild(LocalPlayer.Name)
		local stage = player.leaderstats.Stage.Value

		if stageObjectFired then
			for i, v in pairs(stageObjectFired) do
				if v.Name == "Checkpoint" then
					local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
					FakeChar.Velocity = Vector3.new(0,0,0)
					FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
				end
			end
		end
	end
end)

ReplicatedStorage.RemoteEvents.clientTPFromClient.Event:Connect(function(player, stageObjectFired)
	if player ~= LocalPlayer then
		return
	end
	workspace.CurrentCamera.CFrame = CFrame.Angles(math.rad(-20),math.rad(-90),0)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	if not LocalPlayer:FindFirstChild("PopupDeaths") then
		local pud = Instance.new("NumberValue", LocalPlayer)
		pud.Name = "PopupDeaths"
	end
	LocalPlayer:FindFirstChild("PopupDeaths").Value += 1
	if LocalPlayer:FindFirstChild("PopupDeaths").Value >= 2 then
		LocalPlayer:FindFirstChild("PopupDeaths").Value = 0
		ReplicatedStorage.RemoteEvents.sendPopup:Fire()
	end
	if game:GetService("Players"):FindFirstChild(LocalPlayer.Name) then
		local player = game:GetService("Players"):FindFirstChild(LocalPlayer.Name)
		local stage = player.leaderstats.Stage.Value

		if stageObjectFired then
			for i, v in pairs(stageObjectFired) do
				if v.Name == "Checkpoint" then
					local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
					FakeChar.Velocity = Vector3.new(0,0,0)
					FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
				end
			end
		end
	end
end)