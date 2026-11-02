local Player = game.Players.LocalPlayer
local d = require(game.ReplicatedStorage.ClientModules.Module_Events)

local v1 = Player:GetMouse()
local v2 = false

while true do
	wait()
	if v1.Target ~= nil then
		if v1.Target.Parent:FindFirstChild("Core") then
			if v2 == false then
				v2 = true
				game.Lighting.TempLookmanCC.Enabled = true
				Player.Character.Humanoid:TakeDamage(20)
				
				task.delay(0.6, function()
					d.flickerLights(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1), 1)
				end)
				
				task.delay(0.8, function()
					v2 = false
					game.Workspace:FindFirstChild("BackdoorLookman", true).Core.Open:Play()
					game.Workspace:FindFirstChild("BackdoorLookman", true).Core.Name = "D_LOL"
					wait(game.Workspace:FindFirstChild("BackdoorLookman", true).D_LOL.Open.TimeLength / 10)
					game.Workspace:FindFirstChild("BackdoorLookman", true):Destroy()
					game.Lighting.TempLookmanCC.Enabled = false
					v2 = true
				end)
				
			end
		end
	end
end