--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local CrateShop = ReplicatedStorage.StockValues.CrateShop
local UnixNextRestock = CrateShop.UnixNextRestock
local UnixLastRestock = CrateShop.UnixLastRestock
local UIGradient = script.Parent.UIGradient
local Timer = script.Parent:WaitForChild("Timer")
local v1 = nil
local v2 = nil

Networking.CrateShop.PersonalRestock.OnClientEvent:Connect(function(p1, p2) --[[ Line: 13 | Upvalues: v2 (ref), v1 (ref) ]]
	v2 = os.time()
	v1 = p2
end)

local function FormatTime(p1) --[[ FormatTime | Line: 18 ]]
	local v1 = math.max(p1, 0)
	local v2 = math.floor(v1 / 60)

	return string.format("%dm %ds", v2, (math.floor(v1 % 60)))
end

RunService.Heartbeat:Connect(function() --[[ Line: 25 | Upvalues: v1 (ref), UnixNextRestock (copy), v2 (ref), UnixLastRestock (copy), Timer (copy), UIGradient (copy) ]]
	local v12 = os.time()
	local v22 = v1 or UnixNextRestock.Value
	local v4 = v22 - v12
	local v5 = v22 - (v2 or UnixLastRestock.Value)

	if v4 <= 0 then
		Timer.Text = "Restocking..."
		UIGradient.Offset = Vector2.new(1, 0)
	else
		local v7 = math.max(v4, 0)

		Timer.Text = "Restock in " .. string.format("%dm %ds", math.floor(v7 / 60), (math.floor(v7 % 60)))
		UIGradient.Offset = Vector2.new(math.clamp(1 - v4 / math.max(v5, 1), 0, 1), 0)
	end
end)