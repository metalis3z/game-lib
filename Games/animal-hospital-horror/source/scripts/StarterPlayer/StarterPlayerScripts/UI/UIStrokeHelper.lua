local Lib = require(game.ReplicatedStorage.Lib)
local LocalPlayer = game.Players.LocalPlayer

local function SetUp() --[[ SetUp | Line: 5 | Upvalues: Lib (copy), LocalPlayer (copy) ]]
	local v1 = Lib.CS:GetTagged(LocalPlayer.Name .. "Tycoon")[1]

	if not v1 then
		return
	end

	local Buttons = v1.Structures:FindFirstChild("Buttons")

	for i, v in ipairs(Buttons:GetChildren()) do

	end
end

Lib.UIStrokeAdjuster:SetUp()

return {}