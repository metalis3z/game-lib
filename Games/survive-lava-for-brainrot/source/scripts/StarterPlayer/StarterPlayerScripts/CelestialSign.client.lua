-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("CollectionService")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = {}
local function v9(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	v_u_4[p5] = true
	if p5 then
		local v6 = v_u_3:GetAttribute("CurrentEvent")
		local v7 = p5:GetAttribute("Event")
		local v8
		if v6 and v7 == v6 then
			v8 = true
		else
			v8 = not v6
			if v8 then
				v8 = not v7
			end
		end
		p5.Enabled = v8
	end
end
local function v11(p10)
	-- upvalues: (copy) v_u_4
	v_u_4[p10] = nil
end
local function v16()
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	v_u_3:GetAttribute("CurrentEvent")
	for v12 in pairs(v_u_4) do
		if v12 then
			local v13 = v_u_3:GetAttribute("CurrentEvent")
			local v14 = v12:GetAttribute("Event")
			local v15
			if v13 and v14 == v13 then
				v15 = true
			else
				v15 = not v13
				if v15 then
					v15 = not v14
				end
			end
			v12.Enabled = v15
		end
	end
end
local v_u_17 = {}
local v_u_18 = {}
for _, v19 in { "SpawnCelestialGui", "CelestialCountdown" } do
	v1:GetInstanceAddedSignal(v19):Connect(v9)
	v1:GetInstanceRemovedSignal(v19):Connect(v11)
	for _, v20 in ipairs(v1:GetTagged(v19)) do
		v_u_4[v20] = true
		if v20 then
			local v21 = v_u_3:GetAttribute("CurrentEvent")
			local v22 = v20:GetAttribute("Event")
			local v23
			if v21 and v22 == v21 then
				v23 = true
			else
				v23 = not v21
				if v23 then
					v23 = not v22
				end
			end
			v20.Enabled = v23
		end
	end
end
workspace:GetAttributeChangedSignal("CurrentEvent"):Connect(v16)
v1:GetInstanceAddedSignal("CelestialBrainrotSpin"):Connect(function(p24)
	-- upvalues: (copy) v_u_17
	v_u_17[p24] = p24:GetPivot()
end)
v1:GetInstanceRemovedSignal("CelestialBrainrotSpin"):Connect(function(p25)
	-- upvalues: (copy) v_u_17
	v_u_17[p25] = nil
end)
local function v27(p26)
	-- upvalues: (copy) v_u_18
	v_u_18[p26] = {
		["Pivot"] = p26:GetPivot(),
		["SpinAmount"] = p26:GetAttribute("SpinAmount") or 1,
		["Amount"] = p26:GetAttribute("Amount") or 0
	}
end
local function v29(p28)
	-- upvalues: (copy) v_u_18
	v_u_18[p28] = nil
end
for _, v30 in ipairs(v1:GetTagged("CelestialBrainrotSpin")) do
	v_u_17[v30] = v30:GetPivot()
end
v1:GetInstanceAddedSignal("Float"):Connect(v27)
v1:GetInstanceRemovedSignal("Float"):Connect(v29)
for _, v31 in ipairs(v1:GetTagged("Float")) do
	v27(v31)
end
v2.RenderStepped:Connect(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_18
	local v32 = os.clock()
	local v33 = v32 * 3
	local v34 = math.sin(v33)
	local v35 = v32 % 8 * 45
	local v36 = math.rad(v35)
	for v37, v38 in pairs(v_u_17) do
		if v37.Parent then
			local v39 = CFrame.new(0, v34 + 0.5, 0)
			local v40 = CFrame.fromOrientation(0, v36, 0)
			v37:PivotTo(v38 * v39 * v40)
		else
			v_u_17[v37] = nil
		end
	end
	for v41, v42 in pairs(v_u_18) do
		if v41.Parent then
			local v43 = 0.5 + v34 * v42.Amount
			local v44 = v32 * v42.SpinAmount % 8 * 45
			local v45 = CFrame.fromOrientation(0, math.rad(v44), 0)
			v41:PivotTo(v42.Pivot * CFrame.new(0, v43, 0) * v45)
		else
			v_u_18[v41] = nil
		end
	end
end)
