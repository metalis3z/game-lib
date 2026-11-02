local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

Lib.Data.Get("UpgradeShopWares")
function t.SetUp(p1, p2, p3) --[[ Line: 5 | Upvalues: Lib (copy) ]]
	for i, v in ipairs(Lib.CS:GetTagged("AnalyzerUpgrade")) do
		for i2, v2 in ipairs(v:GetChildren()) do
			if v2:IsA("BasePart") and (v2.Name ~= "Screen" and v2.Color == Color3.fromRGB(209, 209, 193)) then
				if v2.Name == "Base" then
					v2.Color = Color3.fromRGB(27, 42, 53)

					continue
				end

				v2.Color = Color3.fromRGB(205, 205, 205)
			end
		end
	end
end

return t