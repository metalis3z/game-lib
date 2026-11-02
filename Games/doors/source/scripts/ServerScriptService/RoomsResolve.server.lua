repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Rooms_FirstRoom" then
	
else
	return
end

local Hunt_Generation = require(game.ServerScriptService.Game.Directory.Hunt_RoomGeneration)

for v7, v8 in pairs(game.Players:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.Workspace:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.ServerScriptService:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.ReplicatedStorage:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

function GameGenerate()
	local room = workspace.CurrentRooms:WaitForChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

	if game.Workspace:FindFirstChild("SkyboxPart") then
		game.Workspace:FindFirstChild("SkyboxPart"):PivotTo(room[room.Name].CFrame)
	end

	if room then

		for i, v in pairs(room:GetDescendants()) do

			if v:GetAttribute("LoadModule") == "Door" then

				v:SetAttribute("LoadModule", "Loaded")
				Hunt_Generation:SetRoomGenerate(false)

			end

		end

	end
end

workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
	GameGenerate()
end)

for i = 1, 1 do
	GameGenerate()
end