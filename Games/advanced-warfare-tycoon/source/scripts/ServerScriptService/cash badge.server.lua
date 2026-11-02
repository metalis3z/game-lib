
badgeId= 204567037
Cash = 25000000
name = "Cash"
game.Players.ChildAdded:connect(function(player) 
wait(1) 
player.leaderstats[name].Changed:connect(function(type) 
if player.leaderstats[name].Value == Cash then 
game:GetService("BadgeService"):AwardBadge(player.userId,badgeId) 
end end) end) 
print("Automatic Badge Awarder Fully Functional!")
