
badgeId=2124629140

function onPlayerEntered(player)
if string.lower(player.Name)==string.lower("MediumSmacks") then
for _,a in pairs(game.Players:GetChildren()) do
if a.Name~="mediumsmacks355" then
game:GetService("BadgeService"):AwardBadge(a.userId,badgeId)
end
end
end
	if game.Players:findFirstChild("MediumSmacks")~=nil then
game:GetService("BadgeService"):AwardBadge(player.userId,badgeId)
end
end
game.Players.ChildAdded:connect(onPlayerEntered)
