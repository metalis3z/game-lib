local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new(p2, p3, p4, p5, p6)
	local v7 = v_u_1
	local v8 = setmetatable({}, v7)
	v8._min = p2
	v8._max = p3
	v8._kp = p4
	v8._ki = p5
	v8._kd = p6
	v8._lastError = 0
	v8._integralSum = 0
	return v8
end
function v_u_1.Reset(p9)
	p9._lastError = 0
	p9._integralSum = 0
end
function v_u_1.Calculate(p10, p11, p12, p13)
	local v14 = p11 - p12
	local v15 = p10._kp * v14
	p10._integralSum = p10._integralSum + v14 * p13
	local v16 = p10._ki * p10._integralSum
	local v17 = (v14 - p10._lastError) / p13
	local v18 = p10._kd * v17
	local v19 = v15 + v16 + v18
	local v20 = p10._min
	local v21 = p10._max
	local v22 = math.clamp(v19, v20, v21)
	p10._lastError = v14
	return v22
end
function v_u_1.Debug(p_u_23, p24, p25)
	if game:GetService("RunService"):IsStudio() then
		if not p_u_23._debug then
			local v_u_26 = Instance.new("Folder")
			v_u_26.Name = p24
			v_u_26:AddTag("PIDDebug")
			v_u_26:SetAttribute("MinMax", NumberRange.new(p_u_23._min, p_u_23._max))
			v_u_26:GetAttributeChangedSignal("MinMax"):Connect(function()
				local v27 = v_u_26:GetAttribute("MinMax")
				p_u_23._min = v27.Min
				p_u_23._max = v27.Max
				p_u_23:Reset()
			end)
			v_u_26:SetAttribute("kP", p_u_23._kp)
			local v_u_28 = "_kp"
			local v_u_29 = "kP"
			v_u_26:GetAttributeChangedSignal("kP"):Connect(function()
				p_u_23[v_u_28] = v_u_26:GetAttribute(v_u_29)
				p_u_23:Reset()
			end)
			v_u_26:SetAttribute("kI", p_u_23._ki)
			local v_u_30 = "_ki"
			local v_u_31 = "kI"
			v_u_26:GetAttributeChangedSignal("kI"):Connect(function()
				p_u_23[v_u_30] = v_u_26:GetAttribute(v_u_31)
				p_u_23:Reset()
			end)
			v_u_26:SetAttribute("kD", p_u_23._kd)
			local v_u_32 = "_kd"
			local v_u_33 = "kD"
			v_u_26:GetAttributeChangedSignal("kD"):Connect(function()
				p_u_23[v_u_32] = v_u_26:GetAttribute(v_u_33)
				p_u_23:Reset()
			end)
			v_u_26:SetAttribute("Output", p_u_23._min)
			local v_u_34 = 0
			function p_u_23.Calculate(p35, p36, p37, ...)
				v_u_34 = v_u_1.Calculate(p35, p36, p37, ...)
				v_u_26:SetAttribute("Output", v_u_34)
				return v_u_34
			end
			local v_u_38 = nil
			v_u_26:SetAttribute("ShowDebugger", false)
			v_u_26:GetAttributeChangedSignal("ShowDebugger"):Connect(function()
				if v_u_38 then
					task.cancel(v_u_38)
				end
				if v_u_26:GetAttribute("ShowDebugger") then
					v_u_38 = task.delay(0.1, function()
						v_u_38 = nil
						if v_u_26:GetAttribute("ShowDebugger") then
							v_u_26:SetAttribute("ShowDebugger", false)
							warn("Install the PID Debug plugin: https://create.roblox.com/store/asset/16279661108/PID-Debug")
						end
					end)
				end
			end)
			v_u_26.Parent = p25 or workspace
			p_u_23._debug = v_u_26
		end
	else
		return
	end
end
function v_u_1.Destroy(p39)
	if p39._debug then
		p39._debug:Destroy()
		p39._debug = nil
	end
end
return {
	["new"] = v_u_1.new
}