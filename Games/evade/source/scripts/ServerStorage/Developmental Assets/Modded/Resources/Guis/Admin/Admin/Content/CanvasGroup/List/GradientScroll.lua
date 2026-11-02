-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v_u_2 = {}
return function(p_u_3, p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v_u_5 = p4 or 1
	local v_u_6
	if v_u_2[p_u_3] then
		v_u_6 = v_u_2[p_u_3]
	else
		v_u_6 = {}
		for _, v7 in ipairs(p_u_3.Color.Keypoints) do
			local v8 = {
				["Color"] = v7.Value,
				["Time"] = v7.Time
			}
			table.insert(v_u_6, v8)
		end
		v_u_2[p_u_3] = v_u_6
	end
	local v_u_9 = false
	local function v10()
		-- upvalues: (ref) v_u_9
		if not v_u_9 then
			v_u_9 = true
		end
	end
	task.spawn(function()
		-- upvalues: (ref) v_u_9, (copy) v_u_5, (ref) v_u_6, (copy) p_u_3, (ref) v_u_1
		local v11 = tick()
		while not v_u_9 do
			local v12 = (tick() - v11) / v_u_5
			local v13 = {}
			for _, v14 in v_u_6 do
				local v15 = ColorSequenceKeypoint.new
				local v16 = v14.Time + v12
				local v17 = math.fmod(v16, 1)
				local v18 = v14.Color
				table.insert(v13, v15(v17, v18))
			end
			table.sort(v13, function(p19, p20)
				return p19.Time < p20.Time
			end)
			local v21 = 1 - v13[#v13].Time
			local v22 = v21 + v13[1].Time
			local v23 = v13[#v13].Value:Lerp(v13[1].Value, v21 / v22)
			local v24 = ColorSequenceKeypoint.new
			table.insert(v13, 1, v24(0, v23))
			local v25 = ColorSequenceKeypoint.new
			table.insert(v13, v25(1, v23))
			p_u_3.Color = ColorSequence.new(v13)
			v_u_1.RenderStepped:Wait()
		end
	end)
	p_u_3.Destroying:Connect(v10)
	return v10
end
