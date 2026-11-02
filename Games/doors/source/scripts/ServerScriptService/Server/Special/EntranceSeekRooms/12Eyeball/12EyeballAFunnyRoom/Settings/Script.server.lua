local GameDetails = require(game.ServerScriptService.Game.Directory:FindFirstChild("GameDetails"))
local gem2 = require(game.ReplicatedStorage.ClientModules.Module_Events)
script.Parent.Parent.RoomStart.Touched:Connect(function()
	script.Parent.Parent.RoomStart.CanTouch = false
	for i = 1, 1 do
		gem2.flickerLights(script.Parent.Parent, 1.5)
		GameDetails:spawneyes(script.Parent.Level41, 4, 8)
		GameDetails:spawneyes(script.Parent.Level42, 4, 8)

		GameDetails:spawneyes(script.Parent.Level11, 1, 1)
		GameDetails:spawneyes(script.Parent.Level12, 1, 1)
		GameDetails:spawneyes(script.Parent.Level13, 1, 1)
		GameDetails:spawneyes(script.Parent.Level14, 1, 1)
	end
end)