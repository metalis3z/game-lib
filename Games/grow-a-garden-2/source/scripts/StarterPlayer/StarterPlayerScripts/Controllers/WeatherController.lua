--credit to prince games studio
local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local WeatherData = require(ReplicatedStorage.SharedModules.WeatherData)
local WeatherValues = ReplicatedStorage:WaitForChild("WeatherValues")
local Frame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("WeatherUI"):WaitForChild("Frame")
local t2 = {}
local t3 = {}

local function GetAttr(p1, p2) --[[ GetAttr | Line: 24 | Upvalues: WeatherValues (copy) ]]
	return WeatherValues:GetAttribute(p1 .. "_" .. p2)
end

local function FormatTime(p1) --[[ FormatTime | Line: 29 ]]
	if p1 <= 0 then
		return "0s"
	end

	local v1 = math.floor(p1 / 60)
	local v2 = math.floor(p1 % 60)

	if v1 > 0 then
		return string.format("%dm %ds", v1, v2)
	end

	return string.format("%ds", v2)
end

local function StartEffects(p1) --[[ StartEffects | Line: 46 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not (v1 and v1.StartWeather) then
		return
	end

	v1.StartWeather()
end

local function StopEffects(p1) --[[ StopEffects | Line: 54 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not (v1 and v1.EndWeather) then
		return
	end

	v1.EndWeather()
end

local function RefreshTimeLabel(p1, p2) --[[ RefreshTimeLabel | Line: 62 | Upvalues: WeatherValues (copy) ]]
	local UnixTimestamp = DateTime.now().UnixTimestamp
	local v2 = math.max(0, (WeatherValues:GetAttribute(p1 .. "_EndTime") or 0) - UnixTimestamp)
	local v3

	if v2 <= 0 then
		v3 = "0s"
	else
		local v4 = math.floor(v2 / 60)
		local v5 = math.floor(v2 % 60)

		v3 = if v4 > 0 then string.format("%dm %ds", v4, v5) else string.format("%ds", v5)
	end

	p2.Text = v3
end

local function StartTimer(p1, p2) --[[ StartTimer | Line: 70 | Upvalues: t3 (copy), WeatherValues (copy), RunService (copy) ]]
	if not p2 then
		return
	end

	if t3[p1] then
		t3[p1]:Disconnect()
		t3[p1] = nil
	end

	local UnixTimestamp = DateTime.now().UnixTimestamp
	local v1 = (WeatherValues:GetAttribute(p1 .. "_EndTime") or 0) - UnixTimestamp
	local v2 = math.max(0, v1)
	local v3

	if v2 <= 0 then
		v3 = "0s"
	else
		local v4 = math.floor(v2 / 60)
		local v5 = math.floor(v2 % 60)

		v3 = if v4 > 0 then string.format("%dm %ds", v4, v5) else string.format("%ds", v5)
	end

	p2.Text = v3
	t3[p1] = RunService.Heartbeat:Connect(function() --[[ Line: 83 | Upvalues: p1 (copy), WeatherValues (ref), p2 (copy) ]]
		if not WeatherValues:GetAttribute(p1 .. "_Playing") then
			return
		end

		local UnixTimestamp = DateTime.now().UnixTimestamp
		local v4 = math.max(0, (WeatherValues:GetAttribute(p1 .. "_EndTime") or 0) - UnixTimestamp)
		local v5

		if v4 <= 0 then
			v5 = "0s"
		else
			local v6 = math.floor(v4 / 60)
			local v7 = math.floor(v4 % 60)

			v5 = if v6 > 0 then string.format("%dm %ds", v6, v7) else string.format("%ds", v7)
		end

		p2.Text = v5
	end)
end

function t.SetupWeather(p1, p2) --[[ SetupWeather | Line: 90 | Upvalues: t2 (copy), Frame (copy), WeatherValues (copy), StartTimer (copy), t3 (copy) ]]
	local v1 = script:FindFirstChild(p2)

	if v1 then
		t2[p2] = require(v1)
	end

	local v2 = Frame:FindFirstChild(p2)

	if not v2 then
		return
	end

	local Time = v2:FindFirstChild("Time")
	local v3 = WeatherValues:GetAttribute(p2 .. "_Playing")

	v2.Visible = v3 or false

	if v3 then
		local v4 = t2[p2]

		if v4 and v4.StartWeather then
			v4.StartWeather()
		end

		StartTimer(p2, Time)
	end

	WeatherValues:GetAttributeChangedSignal(p2 .. "_Playing"):Connect(function() --[[ Line: 113 | Upvalues: p2 (copy), WeatherValues (ref), v2 (copy), t2 (ref), StartTimer (ref), Time (copy), t3 (ref) ]]
		local v1 = WeatherValues:GetAttribute(p2 .. "_Playing")

		v2.Visible = v1

		if v1 then
			local v22 = t2[p2]

			if v22 and v22.StartWeather then
				v22.StartWeather()
			end

			StartTimer(p2, Time)
		else
			local v3 = t2[p2]

			if v3 and v3.EndWeather then
				v3.EndWeather()
			end

			if not t3[p2] then
				return
			end

			t3[p2]:Disconnect()
			t3[p2] = nil
		end
	end)
end
function t.Init(p1) --[[ Init | Line: 133 ]] end
function t.Start(p1) --[[ Start | Line: 138 | Upvalues: WeatherData (copy) ]]
	for v1, v2 in WeatherData.Data do
		p1:SetupWeather(v2.Name)
	end
end

return t