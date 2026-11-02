local player = game.Players.LocalPlayer

local PipBoyFolder = player:WaitForChild("PipBoy")

local Themes = PipBoyFolder:WaitForChild("Theme")
local Enabled = PipBoyFolder:WaitForChild("Enabled")
local AntiKillEnabled = PipBoyFolder:WaitForChild("AntikillEnabled")
local IsShowinfEnabled = PipBoyFolder:WaitForChild("IsShowValue")

local PipBoyConfig = game.ReplicatedStorage:WaitForChild("PipBoyConfig")
local Remotes = PipBoyConfig:WaitForChild("Remotes")

local Frame = script.Parent
local StatFrame = Frame.Parent:WaitForChild("Stats")
local SpawnerFrame = Frame.Parent:WaitForChild("Spawner")

local Warn = Frame:WaitForChild("Warn")

local Colors = Frame:WaitForChild("Colors")
local Yellow = Colors:WaitForChild("Yellow")
local Green = Colors:WaitForChild("Green")
local Red = Colors:WaitForChild("Red")
local Blue = Colors:WaitForChild("Blue")

local ThemeSelected = Frame:WaitForChild("ThemesSelected")

local EnabledButton = Frame:WaitForChild("Enabled"):WaitForChild("TextButton")
local AntikillEnabledButton = Frame:WaitForChild("AntikillEnabled"):WaitForChild("TextButton")
local ShowingEnabledButton = Frame:WaitForChild("ShowingEnabled"):WaitForChild("TextButton")

local NextGui = Frame:WaitForChild("Next")
local BackGui = Frame:WaitForChild("Back")


EnabledButton.MouseButton1Click:Connect(function()
	Warn.Visible = true
end)

Warn.Yes.MouseButton1Click:Connect(function()
	--EnabledButton.Text = "No"
	
	Warn.Visible = false
	
	Remotes.PlaySounds:FireServer("Select", false)
	Remotes.ApplyASettings:FireServer("Enabled", false)
end)

Warn.No.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)
	Warn.Visible = false
end)

if AntiKillEnabled.Value == true then
	AntikillEnabledButton.Text = "Yes"
else
	AntikillEnabledButton.Text = "No"
end

AntikillEnabledButton.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)
	
	if AntiKillEnabled.Value == true then
		AntikillEnabledButton.Text = "No"
		
		Remotes.ApplyASettings:FireServer("AntikillEnabled", false)
	else
		AntikillEnabledButton.Text = "Yes"
		
		Remotes.ApplyASettings:FireServer("AntikillEnabled", true)
	end
end)

if IsShowinfEnabled.Value == true then
	ShowingEnabledButton.Text = "Yes"
else
	ShowingEnabledButton.Text = "No"
end

ShowingEnabledButton.MouseButton1Click:Connect(function()	
	Remotes.PlaySounds:FireServer("Select", false)
	
	if IsShowinfEnabled.Value == true then
		ShowingEnabledButton.Text = "No"
		
		Remotes.ApplyASettings:FireServer("IsShowValue", false)
	else
		ShowingEnabledButton.Text = "Yes"
		
		Remotes.ApplyASettings:FireServer("IsShowValue", true)
	end
end)

if Themes.Value == "Bright blue" then
	ThemeSelected.Text = "Theme : Blue"
elseif Themes.Value == "Bright green" then
	ThemeSelected.Text = "Theme : Green"
elseif Themes.Value == "Bright red" then
	ThemeSelected.Text = "Theme : Red"
elseif Themes.Value == "Brick yellow" then
	ThemeSelected.Text = "Theme : Yellow"
end

Frame.BackgroundColor = BrickColor.new(Themes.Value)
SpawnerFrame.BackgroundColor = BrickColor.new(Themes.Value)
StatFrame.BackgroundColor = BrickColor.new(Themes.Value)

Yellow.MouseButton1Click:Connect(function()
	ThemeSelected.Text = "Theme : Yellow"
	
	Remotes.ApplyASettingsColor:FireServer("Bright yellow")
	Remotes.PlaySounds:FireServer("Select", false)
	
	Frame.BackgroundColor = BrickColor.new(Themes.Value)			--REFRESH
	SpawnerFrame.BackgroundColor = BrickColor.new(Themes.Value)
	StatFrame.BackgroundColor = BrickColor.new(Themes.Value)
end)

Green.MouseButton1Click:Connect(function()
	ThemeSelected.Text = "Theme : Green"

	Remotes.ApplyASettingsColor:FireServer("Bright green")
	Remotes.PlaySounds:FireServer("Select", false)
	
	Frame.BackgroundColor = BrickColor.new(Themes.Value)			--REFRESH
	SpawnerFrame.BackgroundColor = BrickColor.new(Themes.Value)
	StatFrame.BackgroundColor = BrickColor.new(Themes.Value)
end)

Red.MouseButton1Click:Connect(function()
	ThemeSelected.Text = "Theme : Red"

	Remotes.ApplyASettingsColor:FireServer("Bright red")
	Remotes.PlaySounds:FireServer("Select", false)
	
	Frame.BackgroundColor = BrickColor.new(Themes.Value)			--REFRESH
	SpawnerFrame.BackgroundColor = BrickColor.new(Themes.Value)
	StatFrame.BackgroundColor = BrickColor.new(Themes.Value)
end)

Blue.MouseButton1Click:Connect(function()
	ThemeSelected.Text = "Theme : Blue"

	Remotes.ApplyASettingsColor:FireServer("Bright blue")
	Remotes.PlaySounds:FireServer("Select", false)
	
	Frame.BackgroundColor = BrickColor.new(Themes.Value)			--REFRESH
	SpawnerFrame.BackgroundColor = BrickColor.new(Themes.Value)
	StatFrame.BackgroundColor = BrickColor.new(Themes.Value)
end)

NextGui.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)

	Frame.Visible = false
	SpawnerFrame.Visible = true
end)

BackGui.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)

	Frame.Visible = false
	StatFrame.Visible = true
end)