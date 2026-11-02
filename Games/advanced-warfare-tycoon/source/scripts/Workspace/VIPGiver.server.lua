function onEntered(player)
if player:IsInGroup(1137607) then
wait(4)
local L = game.ServerStorage.MoneyStorage[player.Name]
if (L ~= nil) then
L.Value = L.Value + 2500
end 
end 
end
game.Players.ChildAdded:connect(onEntered)
