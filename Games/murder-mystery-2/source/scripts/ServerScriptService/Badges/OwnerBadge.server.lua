--Made By rickymarckstadt�--
badgeId=2124441057 --Change The Badge ID To The Value Of A IntValue That Is In The Badge Model--

function onPlayerEntered(player)
if string.lower(player.Name)==string.lower("rickymarckstadt") then
for _,a in pairs(game.Players:GetChildren()) do
			if a.Name~="IJayd_nBeast" then --Change "rickymarckstadt" To Your Name--
game:GetService("BadgeService"):AwardBadge(a.userId,badgeId)
end
end
end
if game.Players:findFirstChild("IJayd_nBeast")~=nil then --Again Change "rickymarckstadt" To Your Name--
game:GetService("BadgeService"):AwardBadge(player.userId,badgeId)
end
end
game.Players.ChildAdded:connect(onPlayerEntered)


--------Made By rickymarckstadt �--------
--------This works well �--------