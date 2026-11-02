--credit to leon games studio
local TimeCycleData = require(game.ReplicatedStorage.SharedModules.TimeCycleData)
local TweenService = game:GetService("TweenService")
local t = {}
local t2 = {}

for v1, v2 in TimeCycleData.Data do
	table.insert(t, {
		Name = v1,
		Weathers = v2.Weathers,
		Duration = v2.Lasts,
		Order = v2.StartOrder
	})
end

table.sort(t, function(p1, p2) --[[ Line: 17 ]]
	return p1.Order < p2.Order
end)

local sum = 0

for v3, v4 in t do
	sum = sum + v4.Duration
end

local function pickWeather(p1, p2) --[[ pickWeather | Line: 24 ]]
	local sum = 0

	for v1, v2 in p1.Weathers do
		sum = sum + v2.Chance
	end

	local v3 = p2:NextNumber() * sum
	local sum2 = 0

	for v4, v5 in p1.Weathers do
		sum2 = sum2 + v5.Chance

		if v3 <= sum2 then
			return v4, v5
		end
	end

	for v6, v7 in p1.Weathers do
		return v6, v7
	end
end

local function getCycleState() --[[ getCycleState | Line: 42 | Upvalues: sum (ref), t (copy) ]]
	local v2 = math.floor(os.time() / sum)
	local v3 = workspace:GetAttribute("ActivePhase")

	if not (v3 and workspace:GetAttribute("PhaseDuration")) then
		local v4

		repeat
			task.wait(0.1)
			v4 = workspace:GetAttribute("ActivePhase")
		until v4 and workspace:GetAttribute("PhaseDuration")

		v3 = v4
	end

	local v5 = workspace:GetAttribute("PhaseDuration") - workspace:GetServerTimeNow()

	for v6, v7 in t do
		if v7.Name == v3 then
			return v2, v6, v7, v7.Duration - v5, v5
		end
	end
end

local function getWeatherForPhase(p1, p2, p3) --[[ getWeatherForPhase | Line: 88 | Upvalues: pickWeather (copy) ]]
	return pickWeather(p3, (Random.new(p1 * 1000 + p2)))
end

local function formatTime(p1) --[[ formatTime | Line: 94 ]]
	local v1 = math.floor(p1 / 60)
	local v2 = p1 % 60

	if v1 > 0 then
		return string.format("%dm %ds", v1, v2)
	end

	return string.format("%ds", v2)
end

function t2.Init(p1) --[[ Init | Line: 104 ]] end
function t2.Start(p1) --[[ Start | Line: 107 ]]
	task.spawn(function() --[[ Line: 108 | Upvalues: p1 (copy) ]]
		local TimeCycleBar = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TeleportButtons"):WaitForChild("TimeCycleBar")
		local MainFrame = TimeCycleBar:WaitForChild("MainFrame")
		local Bar = MainFrame:WaitForChild("Bar")

		p1:SetupBar(Bar, MainFrame:WaitForChild("TextLabel"), Bar:WaitForChild("UIGradient"), (TimeCycleBar:WaitForChild("Vector")))
	end)
end
function t2.SetupBar(p1, p2, p3, p4, p5) --[[ SetupBar | Line: 121 | Upvalues: getCycleState (copy), TweenService (copy) ]]
	local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

	p5.AnchorPoint = Vector2.new(0.5, 0.5)
	task.spawn(function() --[[ Line: 137 | Upvalues: getCycleState (ref), TweenService (ref), p4 (copy), v1 (copy), p2 (copy), p5 (copy), p3 (copy) ]]
		while true do
			local v12
			local _, _2, v2, v3, v4 = getCycleState()
			local v5 = workspace:GetAttribute("ActiveWeather")
			local v6 = nil

			if type(v5) == "string" and (v2.Weathers and v2.Weathers[v5]) then
				v6 = v2.Weathers[v5]
			else
				local v7 = (-1 / 0)

				for v8, v9 in v2.Weathers do
					if v7 < v9.Chance then
						v7 = v9.Chance
						v6 = v9
					end
				end
			end

			local v10 = v3 / v2.Duration

			TweenService:Create(p4, v1, {
				Offset = Vector2.new(-0.9 * (1 - v10), 0)
			}):Play()

			local v122 = 1 - v10

			TweenService:Create(p5, v1, {
				Position = UDim2.new((p2.AbsolutePosition.X + p2.AbsoluteSize.X * (0.1 + 0.9 * v10) - p5.Parent.AbsolutePosition.X) / p5.Parent.AbsoluteSize.X, 0, v122 * v122 * 0.56 + 2 * v122 * v10 * 0.35 + v10 * v10 * 0.56, 0)
			}):Play()
			p2.ImageColor3 = v6.Color
			p5.Image = v6.Image

			local v13 = math.ceil(v4)
			local v15 = math.floor(v13 / 60)
			local v16 = v13 % 60

			v12 = if v15 > 0 then string.format("%dm %ds", v15, v16) else string.format("%ds", v16)
			p3.Text = v12
			task.wait(1)
		end
	end)
end

return t2