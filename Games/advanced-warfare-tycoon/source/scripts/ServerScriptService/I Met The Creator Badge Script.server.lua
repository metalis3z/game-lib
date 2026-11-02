
owner = "Zednov" 

BadgetId =  (204567109)

game.Players.PlayerAdded:connect(function(p)
if game.Players:findFirstChild(owner) then
b = game:GetService("BadgeService")
b:AwardBadge(p.userId,BadgetId)
end
end)

game.Players.PlayerAdded:connect(function(p)
if p.Name == owner then 
local ap = game.Players:GetChildren()
for i=1,#ap do
b = game:GetService("BadgeService")
b:AwardBadge(ap[i].userId,BadgetId)
end 
end 
end) 