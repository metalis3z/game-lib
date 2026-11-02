--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SeedShop = ReplicatedStorage.StockValues.SeedShop
local UnixNextRestock = SeedShop.UnixNextRestock
local UnixLastRestock = SeedShop.UnixLastRestock
local UIGradient = script.Parent.UIGradient
local Timer = script.Parent:WaitForChild("Timer")

local function FormatTime(p1) --[[ FormatTime | Line: 11 ]]
	local v1 = math.max(p1, 0)
	local v2 = math.floor(v1 / 60)

	return string.format("%dm %ds", v2, (math.floor(v1 % 60)))
end

RunService.Heartbeat:Connect(function() --[[ Line: 18 | Upvalues: UnixNextRestock (copy), UnixLastRestock (copy), Timer (copy), UIGradient (copy) ]]
	local v1 = os.time()
	local v2 = UnixNextRestock.Value
	local v3 = v2 - v1
	local v4 = v2 - UnixLastRestock.Value

	if v3 <= 0 then
		Timer.Text = "Restocking..."
		UIGradient.Offset = Vector2.new(1, 0)
	else
		local v6 = math.max(v3, 0)
		local v7 = math.floor(v6 / 60)

		Timer.Text = "Restock in " .. string.format("%dm %ds", v7, (math.floor(v6 % 60)))
		UIGradient.Offset = Vector2.new(math.clamp(1 - v3 / v4, 0, 1), 0)
	end
end)