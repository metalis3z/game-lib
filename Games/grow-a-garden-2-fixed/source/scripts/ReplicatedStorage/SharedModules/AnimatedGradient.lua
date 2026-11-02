--credit to leon games studio
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PerfFlags = require(ReplicatedStorage.SharedModules.Flags.PerfFlags)
local t = {}
local t2 = {}
local v1 = nil

local function SampleColor(p1, p2) --[[ SampleColor | Line: 74 ]]
	for i = 1, #p1 - 1 do
		local v1 = p1[i]
		local v2 = p1[i + 1]

		if v1.Time <= p2 and p2 <= v2.Time then
			local v3 = v2.Time - v1.Time

			return v1.Value:Lerp(v2.Value, if v3 > 0 then (p2 - v1.Time) / v3 else 0)
		end
	end

	return p1[#p1].Value
end

local function ShiftColorSequence(p1, p2) --[[ ShiftColorSequence | Line: 89 | Upvalues: SampleColor (copy) ]]
	local Keypoints = p1.Keypoints
	local v1 = table.create(20)

	for i = 0, 19 do
		local v2 = i / 19

		v1[i + 1] = ColorSequenceKeypoint.new(v2, SampleColor(Keypoints, (v2 + p2) % 1))
	end

	return ColorSequence.new(v1)
end

local t3 = {}

local function MaybeDisconnect() --[[ MaybeDisconnect | Line: 105 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
	if not v1 or (next(t) ~= nil or next(t2) ~= nil) then
		return
	end

	v1:Disconnect()
	v1 = nil
end

local function Step(p1) --[[ Step | Line: 112 | Upvalues: PerfFlags (copy), t (copy), t3 (copy), ShiftColorSequence (copy), t2 (copy) ]]
	if PerfFlags.AnimatedGradientsDisabled:Get() then
		return
	end

	for v1, v2 in t do
		if v1.Parent then
			v2.Shift = (v2.Shift + p1 * v2.Speed) % 1
			v1.Color = ShiftColorSequence(v2.Base, v2.Shift)

			continue
		end

		t3:Remove(v1)
	end

	local v3 = os.clock()

	for v4, v5 in t2 do
		if v4.Parent then
			v4[v5.Property] = Color3.fromHSV(v3 * v5.Speed % 1, v5.Saturation, v5.Value)

			continue
		end

		t3:Remove(v4)
	end
end

local function EnsureConnected() --[[ EnsureConnected | Line: 139 | Upvalues: v1 (ref), RunService (copy), Step (copy) ]]
	if v1 then
		return
	end

	v1 = RunService.RenderStepped:Connect(Step)
end

function t3.Add(p1, p2, p3) --[[ Add | Line: 148 | Upvalues: t (copy), t3 (copy), v1 (ref), RunService (copy), Step (copy) ]]
	if typeof(p2) ~= "Instance" or not p2:IsA("UIGradient") then
		return
	end

	local v12 = t[p2]

	if v12 then
		v12.Base = p2.Color
		v12.Speed = if p3 then p3 else v12.Speed
	else
		t[p2] = {
			Shift = 0,
			Base = p2.Color,
			Speed = p3 or 0.5,
			DestroyConn = p2.Destroying:Once(function() --[[ Line: 162 | Upvalues: t3 (ref), p2 (copy) ]]
				t3:Remove(p2)
			end)
		}

		if v1 then
			return
		end

		v1 = RunService.RenderStepped:Connect(Step)
	end
end
function t3.AddRainbowColor(p1, p2, p3, p4) --[[ AddRainbowColor | Line: 173 | Upvalues: t2 (copy), t3 (copy), v1 (ref), RunService (copy), Step (copy) ]]
	if typeof(p2) ~= "Instance" then
		return
	end

	local v12 = p3 or "ImageColor3"
	local v2 = t2[p2]

	if v2 then
		v2.Property = v12
		v2.Speed = p4 or v2.Speed
	else
		local v4 = Color3.new(255/255, 255/255, 255/255)

		pcall(function() --[[ Line: 185 | Upvalues: v4 (ref), p2 (copy), v12 (copy) ]]
			v4 = p2[v12]
		end)
		t2[p2] = {
			Saturation = 1,
			Value = 1,
			Instance = p2,
			Property = v12,
			Speed = p4 or 0.5,
			Original = v4,
			DestroyConn = p2.Destroying:Once(function() --[[ Line: 196 | Upvalues: t3 (ref), p2 (copy) ]]
				t3:Remove(p2)
			end)
		}

		if v1 then
			return
		end

		v1 = RunService.RenderStepped:Connect(Step)
	end
end
function t3.Remove(p1, p2) --[[ Remove | Line: 207 | Upvalues: t (copy), v1 (ref), t2 (copy) ]]
	local v12 = t[p2]

	if v12 then
		v12.DestroyConn:Disconnect()
		t[p2] = nil

		if p2.Parent then
			p2.Color = v12.Base
		end
	else
		local v2 = t2[p2]

		if not v2 then
			return
		end

		v2.DestroyConn:Disconnect()
		t2[p2] = nil

		if p2.Parent then
			pcall(function() --[[ Line: 225 | Upvalues: p2 (copy), v2 (copy) ]]
				p2[v2.Property] = v2.Original
			end)
		end
	end

	if not v1 or (next(t) ~= nil or next(t2) ~= nil) then
		return
	end

	v1:Disconnect()
	v1 = nil
end

return t3