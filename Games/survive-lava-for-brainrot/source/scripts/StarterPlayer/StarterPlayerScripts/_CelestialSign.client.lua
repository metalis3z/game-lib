-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local function v_u_7(p2)
	-- upvalues: (copy) v_u_1
	local v3 = workspace:GetAttribute("CurrentEvent")
	for _, v4 in v_u_1:GetTagged(p2) do
		local v5 = v4:GetAttribute("Event")
		local v6
		if v3 and v5 == v3 then
			v6 = true
		else
			v6 = not v3
			if v6 then
				v6 = not v5
			end
		end
		v4.Enabled = v6
	end
end
local function v8()
	-- upvalues: (copy) v_u_7
	v_u_7("SpawnCelestialGui")
	v_u_7("CelestialCountdown")
end
v_u_7("SpawnCelestialGui")
v_u_7("CelestialCountdown")
workspace:GetAttributeChangedSignal("CurrentEvent"):Connect(v8)
v_u_1:GetInstanceAddedSignal("SpawnCelestialGui"):Connect(v8)
v_u_1:GetInstanceAddedSignal("CelestialCountdown"):Connect(v8)
local v_u_9 = {}
local v_u_10 = {}
for _, v11 in v_u_1:GetTagged("CelestialBrainrotSpin") do
	v_u_9[v11] = v11:GetPivot()
end
v_u_1:GetInstanceAddedSignal("CelestialBrainrotSpin"):Connect(function(p12)
	-- upvalues: (copy) v_u_9
	v_u_9[p12] = p12:GetPivot()
end)
v_u_1:GetInstanceRemovedSignal("CelestialBrainrotSpin"):Connect(function(p13)
	-- upvalues: (copy) v_u_9
	v_u_9[p13] = nil
end)
for _, v14 in v_u_1:GetTagged("Float") do
	v_u_10[v14] = v14:GetPivot()
end
v_u_1:GetInstanceAddedSignal("Float"):Connect(function(p15)
	-- upvalues: (copy) v_u_10
	v_u_10[p15] = p15:GetPivot()
end)
v_u_1:GetInstanceRemovedSignal("Float"):Connect(function(p16)
	-- upvalues: (copy) v_u_10
	v_u_10[p16] = nil
end)
while task.wait() do
	local v17 = tick() * 3
	for v18, v19 in v_u_9 do
		local v20 = v19 * CFrame.new(0, math.sin(v17) / 1 + 0.5, 0)
		local v21 = CFrame.fromOrientation
		local v22 = tick() % 8 * 360 / 8
		v18:PivotTo(v20 * v21(0, math.rad(v22), 0))
	end
	for v23, v24 in v_u_10 do
		local v25 = v23:GetAttribute("SpinAmount") or 1
		local v26 = v23:GetAttribute("Amount") or 0
		local v27 = 0.5 + math.sin(v17) / 1 * v26
		local v28 = tick() * v25 % 8 * 360 / 8
		v23:PivotTo(v24 * CFrame.new(0, v27, 0) * CFrame.fromOrientation(0, math.rad(v28), 0))
	end
end
