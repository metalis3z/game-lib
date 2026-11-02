local player = game.Players.LocalPlayer
local Character = player.Character

local Remotes = game.ReplicatedStorage:WaitForChild("PipBoyConfig"):WaitForChild("Remotes")

local Lighing = game:GetService("Lighting")

local Frame = script.Parent
local SettingsFrame = Frame.Parent:WaitForChild("Settings")
local SpawnerFrame = Frame.Parent:WaitForChild("Spawner")

local HealthGui = Frame:WaitForChild("Health")
local DisplayNameGui = Frame:WaitForChild("DisplayName")
local NameGui = Frame:WaitForChild("Name")
local ArmingLaserGui = Frame:WaitForChild("armingLaser")
local CharGui = Frame:WaitForChild("Character")
local TimeGui = Frame:WaitForChild("Time")
local Next = Frame:WaitForChild("Next")
local Back = Frame:WaitForChild("Back")

local Humanoid = Character:WaitForChild("Humanoid")

HealthGui.Text = "Healths : "..Humanoid.Health

Humanoid.HealthChanged:Connect(function()
	HealthGui.Text = "Healths : "..Humanoid.Health
end)

DisplayNameGui.Text = "Display Name : "..player.DisplayName
NameGui.Text = "Name : "..player.Name


local ArmingLaserTimeValue = player:WaitForChild("PipBoy"):WaitForChild("TimeArmingLaser")

if ArmingLaserTimeValue.Value == 0 then
	ArmingLaserGui.Text = "Arming laser : Ready"
else
	ArmingLaserGui.Text = "Arming laser : "..ArmingLaserTimeValue.Value.."s"
end


ArmingLaserTimeValue.Changed:Connect(function()
	if ArmingLaserTimeValue.Value == 0 then
		ArmingLaserGui.Text = "Arming laser : Ready"
	else
		ArmingLaserGui.Text = "Arming laser : "..ArmingLaserTimeValue.Value.."s"
	end
end)

CharGui.Image = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size180x180)


TimeGui.Text = "Time : "..Lighing.TimeOfDay

Lighing.Changed:Connect(function()
	TimeGui.Text = "Time : "..Lighing.TimeOfDay
end)

Next.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)
	
	Frame.Visible = false
	SettingsFrame.Visible = true
end)

Back.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)

	Frame.Visible = false
	SpawnerFrame.Visible = true
end)