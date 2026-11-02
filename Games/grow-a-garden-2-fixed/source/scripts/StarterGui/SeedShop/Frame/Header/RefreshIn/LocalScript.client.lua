--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SeedShop = ReplicatedStorage.StockValues.SeedShop
local UnixNextRestock = SeedShop.UnixNextRestock
local UnixLastRestock = SeedShop.UnixLastRestock
local UIGradient = script.Parent.UIGradient
local Timer = script.Parent:WaitForChild("Timer")
local v1 = nil
local v2 = nil

require(ReplicatedStorage.SharedModules.Networking).SeedShop.PersonalRestock.OnClientEvent:Connect(function(p1, p2) --[[ Line: 15 | Upvalues: v1 (ref), v2 (ref) ]]
	v1 = p2
	v2 = os.time()
end)

local function FormatTime(p1) --[[ FormatTime | Line: 20 ]]
	local v1 = math.max(p1, 0)
	local v2 = math.floor(v1 / 60)

	return string.format("%dm %ds", v2, (math.floor(v1 % 60)))
end

RunService.Heartbeat:Connect(function() --[[ Line: 27 | Upvalues: v1 (ref), v2 (ref), UnixNextRestock (copy), UnixLastRestock (copy), Timer (copy), UIGradient (copy) ]]
	local v12 = os.time()
	local v22, v3

	if v1 and v12 < v1 then
		v22 = v1
		v3 = v2
	else
		v1 = nil
		v2 = nil
		v22 = UnixNextRestock.Value
		v3 = UnixLastRestock.Value
	end

	local v4 = v22 - v12
	local v5 = v22 - v3

	if v4 <= 0 then
		Timer.Text = "Restocking..."
		UIGradient.Offset = Vector2.new(1, 0)
	else
		local v7 = math.max(v4, 0)
		local v8 = math.floor(v7 / 60)

		Timer.Text = "Restock in " .. string.format("%dm %ds", v8, (math.floor(v7 % 60)))
		UIGradient.Offset = Vector2.new(math.clamp(1 - v4 / v5, 0, 1), 0)
	end
end)