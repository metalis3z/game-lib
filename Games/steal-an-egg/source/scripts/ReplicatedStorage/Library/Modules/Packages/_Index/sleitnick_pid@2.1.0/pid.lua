-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1, p2, p3, p4, p5) --[[ new | Line: 38 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._min = p1
	v2._max = p2
	v2._kp = p3
	v2._ki = p4
	v2._kd = p5
	v2._lastError = 0
	v2._integralSum = 0

	return v2
end
function t.Reset(p1) --[[ Reset | Line: 53 ]]
	p1._lastError = 0
	p1._integralSum = 0
end
function t.Calculate(p1, p2, p3, p4) --[[ Calculate | Line: 78 ]]
	local v1 = p2 - p3
	local v2 = p1._kp * v1

	p1._integralSum = p1._integralSum + v1 * p4

	local v6 = math.clamp(v2 + p1._ki * p1._integralSum + p1._kd * ((v1 - p1._lastError) / p4), p1._min, p1._max)

	p1._lastError = v1

	return v6
end
function t.Debug(p1, p2, p3) --[[ Debug | Line: 116 | Upvalues: t (copy) ]]
	if not game:GetService("RunService"):IsStudio() then
		return
	end

	if p1._debug then
		return
	end

	local v1 = Instance.new("Folder")

	v1.Name = p2
	v1:AddTag("PIDDebug")

	local function Bind(p12, p2) --[[ Bind | Line: 129 | Upvalues: v1 (copy), p1 (copy) ]]
		v1:SetAttribute(p12, p1[p2])
		v1:GetAttributeChangedSignal(p12):Connect(function() --[[ Line: 131 | Upvalues: p1 (ref), p2 (copy), v1 (ref), p12 (copy) ]]
			p1[p2] = v1:GetAttribute(p12)
			p1:Reset()
		end)
	end

	v1:SetAttribute("MinMax", NumberRange.new(p1._min, p1._max))
	v1:GetAttributeChangedSignal("MinMax"):Connect(function() --[[ Line: 138 | Upvalues: v1 (copy), p1 (copy) ]]
		local v12 = v1:GetAttribute("MinMax")

		p1._min = v12.Min
		p1._max = v12.Max
		p1:Reset()
	end)
	v1:SetAttribute("kP", p1._kp)

	local v2 = "_kp"
	local v3 = "kP"

	v1:GetAttributeChangedSignal("kP"):Connect(function() --[[ Line: 131 | Upvalues: p1 (copy), v2 (copy), v1 (copy), v3 (copy) ]]
		p1[v2] = v1:GetAttribute(v3)
		p1:Reset()
	end)
	v1:SetAttribute("kI", p1._ki)

	local v4 = "_ki"
	local v5 = "kI"

	v1:GetAttributeChangedSignal("kI"):Connect(function() --[[ Line: 131 | Upvalues: p1 (copy), v4 (copy), v1 (copy), v5 (copy) ]]
		p1[v4] = v1:GetAttribute(v5)
		p1:Reset()
	end)
	v1:SetAttribute("kD", p1._kd)

	local v6 = "_kd"
	local v7 = "kD"

	v1:GetAttributeChangedSignal("kD"):Connect(function() --[[ Line: 131 | Upvalues: p1 (copy), v6 (copy), v1 (copy), v7 (copy) ]]
		p1[v6] = v1:GetAttribute(v7)
		p1:Reset()
	end)
	v1:SetAttribute("Output", p1._min)

	local v8 = 0

	function p1.Calculate(p1, p2, p3, ...) --[[ Line: 152 | Upvalues: v8 (ref), t (ref), v1 (copy) ]]
		v8 = t.Calculate(p1, p2, p3, ...)
		v1:SetAttribute("Output", v8)

		return v8
	end

	local v9 = nil

	v1:SetAttribute("ShowDebugger", false)
	v1:GetAttributeChangedSignal("ShowDebugger"):Connect(function() --[[ Line: 160 | Upvalues: v9 (ref), v1 (copy) ]]
		if v9 then
			task.cancel(v9)
		end

		if not v1:GetAttribute("ShowDebugger") then
			return
		end

		v9 = task.delay(0.1, function() --[[ Line: 168 | Upvalues: v9 (ref), v1 (ref) ]]
			v9 = nil

			if not v1:GetAttribute("ShowDebugger") then
				return
			end

			v1:SetAttribute("ShowDebugger", false)
			warn("Install the PID Debug plugin: https://create.roblox.com/store/asset/16279661108/PID-Debug")
		end)
	end)
	v1.Parent = if p3 then p3 else workspace
	p1._debug = v1
end
function t.Destroy(p1) --[[ Destroy | Line: 185 ]]
	if not p1._debug then
		return
	end

	p1._debug:Destroy()
	p1._debug = nil
end

return {
	new = t.new
}