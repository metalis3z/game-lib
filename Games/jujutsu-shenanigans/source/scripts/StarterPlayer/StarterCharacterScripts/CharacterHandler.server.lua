repeat wait() until game.Loaded
local char : Model = script.Parent
local hum : Humanoid = char:WaitForChild('Humanoid',5)
local root : BasePart = char:WaitForChild('HumanoidRootPart')
local player : Player = nil
repeat until char:FindFirstChildOfClass('Humanoid')
if game.Players:GetPlayerFromCharacter(char) then
	player = game.Players:GetPlayerFromCharacter(char)
else
	player = nil
end

