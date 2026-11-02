if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui', true)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)

local Settings = PlayerGui:WaitForChild('Settings', true)
local Emotes = PlayerGui:WaitForChild('Emotes', true)

local IconManager = require(game:FindService('ReplicatedStorage'):WaitForChild('Icon'))
local SettingsIcon = IconManager.new()
local EmotesIcon = IconManager.new()

SettingsIcon:setImage(17281697710)
SettingsIcon:setImageScale(.75)
SettingsIcon:setLabel('')
SettingsIcon:setCaption('Toggle Settings')
SettingsIcon.highlightKey = Enum.KeyCode.DPadRight
SettingsIcon:modifyTheme({{'Widget', 'MinimumWidth', 40}, {'IconCorners', 'CornerRadius', UDim.new(0, 8)}})
SettingsIcon:bindEvent('deselected', function() Settings.Enabled = not Settings.Enabled end) 
SettingsIcon:oneClick()


EmotesIcon:setImage(17502933516)
EmotesIcon:setImageScale(.75)
EmotesIcon:setLabel('')
EmotesIcon:setCaption('Toggle Emotes')
EmotesIcon.highlightKey = Enum.KeyCode.DPadRight
EmotesIcon:modifyTheme({{'Widget', 'MinimumWidth', 40}, {'IconCorners', 'CornerRadius', UDim.new(0, 8)}})
EmotesIcon:bindEvent('deselected', function() Emotes.Enabled = not Emotes.Enabled end) 
EmotesIcon:oneClick()