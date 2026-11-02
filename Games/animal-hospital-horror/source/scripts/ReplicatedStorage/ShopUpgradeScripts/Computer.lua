local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

Lib.Data.Get("UpgradeShopWares")
function t.SetUp(p1, p2, p3) --[[ Line: 5 | Upvalues: Lib (copy) ]]
	for i, v in ipairs(Lib.CS:GetTagged("ComputerUpgrade")) do
		local Monitor = v:FindFirstChild("Monitor")

		if Monitor and Monitor:IsA("MeshPart") then
			Monitor.TextureID = ""
			Monitor.Color = Color3.fromRGB(27, 42, 53)
		end
	end
end

return t