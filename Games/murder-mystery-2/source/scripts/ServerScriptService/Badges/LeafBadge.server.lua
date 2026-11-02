--[[
badgeId=2124441057

function onPlayerEntered(player)
if string.lower(player.Name)==string.lower("rickymarckstadt") then
for _,a in pairs(game.Players:GetChildren()) do
			if a.Name~="RhavizinNxtrixz" then --Change "rickymarckstadt" To Your Name--
game:GetService("BadgeService"):AwardBadge(a.userId,badgeId)
end
end
end
	if game.Players:findFirstChild("RhavizinNxtrixz")~=nil then --Again Change "rickymarckstadt" To Your Name--
game:GetService("BadgeService"):AwardBadge(player.userId,badgeId)
end
end
game.Players.ChildAdded:connect(onPlayerEntered)]]

local BadgeID = nil;
local Badge = game:GetService("BadgeService");

function onPlayerEntered(player)
	if string.lower(player.UserId) == string.lower(1971231464) then
		for i,a in pairs(game.Players:GetChildren()) do
			if a.UserId~= 1971231464 then
				Badge:AwardBadge(player.UserId, BadgeID)
			end
		end
		game.Players.ChildAdded:Connect(onPlayerEntered)
	end
end