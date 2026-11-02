local Players = game.Players
local workspace = workspace

local SanityM = {}

function SanityM.CheckSanity(Player, ActionType, Object)
	local PassedSanity = true
	if Player and Players:FindFirstChild(Player.Name) then
		if ActionType == "" then
			if Player:GetAttribute("Alive") == false or Player.Character == nil then
				PassedSanity = false
			elseif Player.Character.Health == 0 then
				PassedSanity = false
			end
		elseif ActionType == "OpenDrawerContainer" then

		elseif ActionType == "Revive" then

		elseif ActionType == "PickUpItem" then

		end
	else
		PassedSanity = false
	end
	return PassedSanity
end

return SanityM
