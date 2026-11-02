
function OnTouch(part)
	if (part.Parent:FindFirstChild("Humanoid") ~= nil) then
		local p = game.Players:GetPlayerFromCharacter(part.Parent)
		if (p ~= nil) then
			if part.Parent.Name == script.Parent.Parent.Parent.Own2.Value then
			print("Awarding BadgeID: " ..script.Parent.BadgeID.Value .. " to UserID: " .. p.userId)
			local b = game:GetService("BadgeService")
			b:AwardBadge(p.userId, script.Parent.BadgeID.Value)
		end
	end
end

script.Parent.Touched:connect(OnTouch)
