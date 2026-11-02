-- @name        DeathHandler
-- @author      lofe#1820
-- @began       20/07/2020 12:21
-- @finish      20/07/2020 12:24

-- SERVICES
-- No services required.

-- MODULES
-- No modules required.

-- SETTINGS
-- No settings required.

-- EVENTS
-- No events required.

-- TABLES
local main = {}
local available = {
	"'L' - gabe53",
	"'try harder next time' - mikeer",
	"'You are halal meat brother' - maksio039",
	"'/e dance nub' - rofay135"
}

-- VARIABLES
local player = game.Players.LocalPlayer

-- FUNCTIONS
function main:log(message)
    print("["..script.Name.."] " .. message)
end

-- EVENT HANDLING
player.Character:WaitForChild("Humanoid").Died:Connect(function()
	script.Parent.Enabled = true
	script.Parent.Sound:Play()
	script.Parent.Frame.Random.Text = available[math.random(1, #available)]
	repeat
		script.Parent.Frame.Time.Text = tonumber(script.Parent.Frame.Time.Text) - 1
		wait(1)
	until script.Parent.Frame.Time.Text == "0"
end)
	
-- CODE
-- No additional code required.