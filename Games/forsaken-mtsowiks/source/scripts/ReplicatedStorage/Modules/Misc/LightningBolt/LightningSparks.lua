-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent)
local v_u_2 = {}
local v_u_3 = Random.new()
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4.new(p5, p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	local v7 = v_u_4
	local v8 = setmetatable({}, v7)
	v8.Enabled = true
	v8.LightningBolt = p5
	v8.MaxSparkCount = p6 or 10
	v8.MinSpeed = 4
	v8.MaxSpeed = 6
	v8.MinDistance = 3
	v8.MaxDistance = 6
	v8.MinPartsPerSpark = 8
	v8.MaxPartsPerSpark = 10
	v8.SparksN = 0
	v8.SlotTable = {}
	v8.RefIndex = #v_u_2 + 1
	v_u_2[v8.RefIndex] = v8
	return v8
end
function v_u_4.Destroy(p9)
	-- upvalues: (copy) v_u_2
	v_u_2[p9.RefIndex] = nil
	for v10, v11 in pairs(p9.SlotTable) do
		if v11.Parts[1].Parent == nil then
			p9.SlotTable[v10] = nil
		end
	end
end
function RandomVectorOffset(p12, p13)
	-- upvalues: (copy) v_u_3
	local v14 = CFrame.lookAt(Vector3.new(), p12) * CFrame.Angles(0, 0, v_u_3:NextNumber(0, 6.283185307179586))
	local v15 = CFrame.Angles
	local v16 = v_u_3:NextNumber(math.cos(p13), 1)
	return (v14 * v15(math.acos(v16), 0, 0)).LookVector
end
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_1
	for _, v17 in pairs(v_u_2) do
		if v17.Enabled == true and v17.SparksN < v17.MaxSparkCount then
			local v18 = v17.LightningBolt
			if v18.Parts[1].Parent == nil then
				v17:Destroy()
				return
			end
			local v19 = v18.Parts
			local v20 = #v19
			local v21 = {}
			for v22 = 1, #v19 do
				if v19[v22].Transparency < 0.3 then
					v21[#v21 + 1] = (v22 - 0.5) / v20
				end
			end
			local v23, v24
			if #v21 == 0 then
				v23 = nil
				v24 = nil
			else
				local v25 = v21[1] * v17.MaxSparkCount
				v24 = math.ceil(v25)
				local v26 = v21[#v21] * v17.MaxSparkCount
				v23 = math.ceil(v26)
			end
			for _ = 1, v_u_3:NextInteger(1, v17.MaxSparkCount - v17.SparksN) do
				if #v21 == 0 then
					break
				end
				local v27 = {}
				for v28 = v24, v23 do
					if v17.SlotTable[v28] == nil then
						v27[#v27 + 1] = v28
					end
				end
				if #v27 ~= 0 then
					local v29 = v27[v_u_3:NextInteger(1, #v27)]
					local v30 = v_u_3:NextNumber(-0.5, 0.5)
					local v31 = (v29 - 0.5 + v30) / v17.MaxSparkCount
					local v32 = 10
					local v33 = 1
					for v34 = 1, #v21 do
						local v35 = v21[v34] - v31
						local v36 = math.abs(v35)
						if v36 < v32 then
							local v37 = v21[v34] * v20 + 0.5 + 0.5
							v33 = math.floor(v37)
							v32 = v36
						end
					end
					local v38 = v19[v33]
					local v39 = {}
					local v40 = {}
					v39.WorldPosition = v38.Position + v30 * v38.CFrame.RightVector * v38.Size.X
					v40.WorldPosition = v39.WorldPosition + RandomVectorOffset(v38.CFrame.RightVector, 0.7853981633974483) * v_u_3:NextNumber(v17.MinDistance, v17.MaxDistance)
					v39.WorldAxis = (v40.WorldPosition - v39.WorldPosition).Unit
					v40.WorldAxis = v39.WorldAxis
					local v41 = v_u_1.new(v39, v40, v_u_3:NextInteger(v17.MinPartsPerSpark, v17.MaxPartsPerSpark))
					v41.MinRadius = 0
					v41.MaxRadius = 0.8
					v41.AnimationSpeed = 0
					v41.Thickness = v38.Size.Y / 2
					v41.MinThicknessMultiplier = 1
					v41.MaxThicknessMultiplier = 1
					v41.PulseLength = 0.5
					v41.PulseSpeed = v_u_3:NextNumber(v17.MinSpeed, v17.MaxSpeed)
					v41.FadeLength = 0.25
					local v42, _, v43 = Color3.toHSV(v38.Color)
					v41.Color = Color3.fromHSV(v42, 0.5, v43)
					v17.SlotTable[v29] = v41
				end
			end
		end
		local v44 = 0
		for v45, v46 in pairs(v17.SlotTable) do
			if v46.Parts[1].Parent == nil then
				v17.SlotTable[v45] = nil
			else
				v44 = v44 + 1
			end
		end
		v17.SparksN = v44
	end
end)
return v_u_4
