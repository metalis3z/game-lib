local detector = script.Parent
local debounce = false
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Global = require(game.ServerScriptService:WaitForChild("Global"))
local Players = Global.Players

function onMouseClick(player)

	if player == nil or debounce then return end
	if player.TeamColor == BrickColor.new(37) and player.Character ~= nil and Players[player] then
		debounce = true
		Players[player]:SetUniform("MenSuit")


		wait(3)
		debounce = false
	end
end
detector.Detector.Event:connect(onMouseClick)

script.Parent.Parent.Touched:connect(function(hit) 
	if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		onMouseClick(game.Players:GetPlayerFromCharacter(hit.Parent))
	end
end)