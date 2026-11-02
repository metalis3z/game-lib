--credit to quartz games studio
repeat
	task.wait(0.3)
until game.Players.LocalPlayer

require(game.ReplicatedStorage.ClientModules.Trove)
game:GetService("TweenService")
game:GetService("StarterGui")

local Controllers = game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("Controllers")
local SeedInspectController = require(Controllers:WaitForChild("SeedInspectController"))
local SeedPackData = require(game.ReplicatedStorage.SharedModules.SeedPackData)
local SeedData = game.ReplicatedStorage.SharedModules.SeedData
local CinematicBars = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CinematicBars")

CinematicBars:WaitForChild("BottomBar")
CinematicBars:WaitForChild("TopBar")

local Prizes = CinematicBars:WaitForChild("PrizesUI"):WaitForChild("Prizes")
local t = {}

for k, v in pairs(SeedPackData.GetData("Ghost Pepper Pack").Seeds) do
	table.insert(t, v)
end

for k, v in pairs(Prizes:GetChildren()) do
	if v:IsA("Frame") then
		local Inspect = v:FindFirstChild("Inspect")

		if Inspect then
			local v3 = tonumber(v.Name:sub(5))

			if v3 then
				local v4 = t[v3]

				v.Odds.Text = tostring(v4.Chance) .. "%"
				v.ItemName.Text = v4.SeedName
				v.ItemImage.Image = SeedData.SeedImages[v4.SeedName].Value
				Inspect.Activated:Connect(function() --[[ Line: 61 | Upvalues: SeedInspectController (copy), v4 (copy) ]]
					SeedInspectController.Inspect(v4)
				end)
			end
		end
	end
end