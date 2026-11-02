local Character = script.Parent

while true do
	wait(0.1)
	if Character then
		break
	end
end

local Player = game.Players:GetPlayerFromCharacter(Character)

if Player then
	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("Accessory") then
			if v.AccessoryType == Enum.AccessoryType.Shoulder or v.AccessoryType == Enum.AccessoryType.Face or v.AccessoryType == Enum.AccessoryType.Unknown or v.AccessoryType == Enum.AccessoryType.Pants then
				v:Destroy()
			end
		end
	end
end