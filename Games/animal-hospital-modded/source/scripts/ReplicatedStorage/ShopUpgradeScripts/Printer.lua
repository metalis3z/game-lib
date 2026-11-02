local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

Lib.Data.Get("UpgradeShopWares")
function t.SetUp(p1, p2, p3) --[[ Line: 5 | Upvalues: Lib (copy) ]]
	for i, v in ipairs(Lib.CS:GetTagged("PrinterUpgrade")) do
		local Printer = v:FindFirstChild("Printer")

		if Printer and Printer:IsA("BasePart") then
			Printer.Color = Color3.fromRGB(159, 161, 172)
		end
	end
end

return t