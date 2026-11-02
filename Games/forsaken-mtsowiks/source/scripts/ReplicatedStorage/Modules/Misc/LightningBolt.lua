-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = os.clock
function DiscretePulse(p2, p3, p4, p5, p6, p7, p8)
	local v9 = p4 / (2 * p5)
	local v10 = (p2 - p6 * p3 + 0.5 * p4) / p5
	local v11 = v9 - math.abs(v10)
	return math.clamp(v11, p7, p8)
end
function NoiseBetween(p12, p13, p14, p15, p16)
	return p15 + (p16 - p15) * (math.noise(p12, p13, p14) + 0.5)
end
function CubicBezier(p17, p18, p19, p20, p21)
	return p17 * (1 - p21) ^ 3 + p18 * 3 * p21 * (1 - p21) ^ 2 + p19 * 3 * (1 - p21) * p21 ^ 2 + p20 * p21 ^ 3
end
local v_u_22 = Instance.new("Part")
v_u_22.TopSurface = 0
v_u_22.BottomSurface = 0
v_u_22.Anchored = true
v_u_22.CanCollide = false
v_u_22.Shape = "Block"
v_u_22.Name = "BoltPart"
v_u_22.Material = Enum.Material.Neon
v_u_22.Color = Color3.new(1, 1, 1)
v_u_22.Transparency = 1
Random.new()
local v_u_23 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()
local v_u_24 = {}
local v_u_25 = {}
v_u_25.__index = v_u_25
function v_u_25.new(p26, p27, p28)
	-- upvalues: (copy) v_u_25, (copy) v_u_22, (copy) v_u_23, (copy) v_u_1, (copy) v_u_24
	local v29 = v_u_25
	local v30 = setmetatable({}, v29)
	v30.Enabled = true
	v30.Attachment0 = p26
	v30.Attachment1 = p27
	v30.CurveSize0 = 0
	v30.CurveSize1 = 0
	v30.MinRadius = 0
	v30.MaxRadius = 2.4
	v30.Frequency = 1
	v30.AnimationSpeed = 7
	v30.Thickness = 1
	v30.MinThicknessMultiplier = 0.2
	v30.MaxThicknessMultiplier = 1
	v30.MinTransparency = 0
	v30.MaxTransparency = 1
	v30.PulseSpeed = 2
	v30.PulseLength = 1000000
	v30.FadeLength = 0.2
	v30.ContractFrom = 0.5
	v30.Color = Color3.new(1, 1, 1)
	v30.ColorOffsetSpeed = 3
	v30.Parts = {}
	local v31 = workspace.CurrentCamera
	local v32 = p26.WorldPosition
	local v33 = p26.WorldPosition + p26.WorldAxis * v30.CurveSize0
	local v34 = p27.WorldPosition - p27.WorldAxis * v30.CurveSize1
	local v35 = p27.WorldPosition
	local v36 = p28 or 30
	local v37 = v32
	local v38 = v37
	local v39 = v37
	v37 = v38
	v39 = v38
	for v40 = 1, v36 do
		local v41 = v40 / v36
		local v42 = CubicBezier(v32, v33, v34, v35, v41)
		local v43
		if v40 == v36 then
			v43 = v42
		else
			v43 = CFrame.lookAt(v37, v42).Position or v42
		end
		local v44 = v_u_22:Clone()
		local v45 = (v43 - v38).Magnitude
		v44.Size = Vector3.new(v45, 0, 0)
		v44.CFrame = CFrame.lookAt(0.5 * (v38 + v43), v43) * v_u_23
		v44.Parent = v31
		v44.Locked = true
		v44.CastShadow = false
		v30.Parts[v40] = v44
		v37 = v42
		v38 = v43
	end
	v30.PartsHidden = false
	v30.DisabledTransparency = 1
	v30.StartT = v_u_1()
	v30.RanNum = math.random() * 100
	v30.RefIndex = #v_u_24 + 1
	v_u_24[v30.RefIndex] = v30
	return v30
end
function v_u_25.Destroy(p46)
	-- upvalues: (copy) v_u_24
	v_u_24[p46.RefIndex] = nil
	for v47 = 1, #p46.Parts do
		p46.Parts[v47]:Destroy()
		if v47 % 100 == 0 then
			wait()
		end
	end
end
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_24, (copy) v_u_1, (copy) v_u_23
	for _, v48 in pairs(v_u_24) do
		if v48.Enabled == true then
			v48.PartsHidden = false
			local v49 = 1 - v48.MaxTransparency
			local v50 = 1 - v48.MinTransparency
			local v51 = v48.MinRadius
			local v52 = v48.MaxRadius
			local v53 = v48.Thickness
			local v54 = v48.Parts
			local v55 = #v54
			local v56 = v48.RanNum
			local v57 = v48.StartT
			local v58 = v48.AnimationSpeed
			local v59 = v48.Frequency
			local v60 = v48.MinThicknessMultiplier
			local v61 = v48.MaxThicknessMultiplier
			local v62 = v48.Attachment0
			local v63 = v48.Attachment1
			local v64 = v48.CurveSize0
			local v65 = v48.CurveSize1
			local v66 = v62.WorldPosition
			local v67 = v62.WorldPosition + v62.WorldAxis * v64
			local v68 = v63.WorldPosition - v63.WorldAxis * v65
			local v69 = v63.WorldPosition
			local v70 = v_u_1() - v57
			local v71 = v48.PulseLength
			local v72 = v48.PulseSpeed
			local v73 = v48.FadeLength
			local v74 = v48.Color
			local v75 = v48.ColorOffsetSpeed
			local v76 = 1 - v48.ContractFrom
			if v70 < (v71 + 1) / v72 then
				local v77 = v66
				local v78 = v77
				local v79 = v77
				v77 = v78
				v79 = v78
				for v80 = 1, v55 do
					local v81 = v54[v80]
					local v82 = v80 / v55
					local v83 = DiscretePulse(v82, v72, v71, v73, v70, v49, v50)
					local v84 = CubicBezier(v66, v67, v68, v69, v82)
					local v85 = -v70
					local v86 = v58 * v85 + v59 * 10 * v82 - 0.2 + v56 * 4
					local v87 = 5 * (v58 * 0.01 * v85 / 10 + v59 * v82) + v56 * 4
					local v88 = NoiseBetween(5 * v86, 1.5, 1 * v87, 0, 0.6283185307179586) + NoiseBetween(0.5 * v86, 1.5, 0.1 * v87, 0, 5.654866776461628)
					local v89 = NoiseBetween(3.4, v87, v86, v51, v52)
					local v90 = -5000 * (v82 - 0.5) ^ 10
					local v91 = v89 * math.exp(v90)
					local v92 = NoiseBetween(2.3, v87, v86, v60, v61)
					local v93
					if v80 == v55 then
						v93 = v84
					else
						local v94 = CFrame.new(v77, v84) * CFrame.Angles(0, 0, v88)
						local v95 = CFrame.Angles
						local v96 = NoiseBetween(v87, v86, 2.7, 6.123233995736766e-17, 1)
						local v97 = math.clamp(v96, -1, 1)
						v93 = (v94 * v95(math.acos(v97), 0, 0) * CFrame.new(0, 0, -v91)).Position or v84
					end
					if v76 < v83 then
						local v98 = (v93 - v78).Magnitude
						local v99 = v53 * v92 * v83
						local v100 = v53 * v92 * v83
						v81.Size = Vector3.new(v98, v99, v100)
						v81.CFrame = CFrame.lookAt(0.5 * (v78 + v93), v93) * v_u_23
						v81.Transparency = 1 - v83
					elseif v76 - 1 / (v55 * v73) < v83 then
						local v101 = (1 - (v83 - (v76 - 1 / (v55 * v73))) * v55 * v73) * (v82 < v70 * v72 - 0.5 * v71 and 1 or -1)
						local v102 = (1 - math.abs(v101)) * (v93 - v78).Magnitude
						local v103 = v53 * v92 * v83
						local v104 = v53 * v92 * v83
						v81.Size = Vector3.new(v102, v103, v104)
						v81.CFrame = CFrame.lookAt(v78 + (v93 - v78) * (math.max(0, v101) + (1 - math.abs(v101)) * 0.5), v93) * v_u_23
						v81.Transparency = 1 - v83
					else
						v81.Transparency = 1
					end
					if typeof(v74) == "Color3" then
						v81.Color = v74
					else
						local v105 = (v56 + v82 - v70 * v75) % 1
						local v106 = v74.Keypoints
						for v107 = 1, #v106 - 1 do
							if v106[v107].Time < v105 and v105 < v106[v107 + 1].Time then
								v81.Color = v106[v107].Value:lerp(v106[v107 + 1].Value, (v105 - v106[v107].Time) / (v106[v107 + 1].Time - v106[v107].Time))
								break
							end
						end
					end
					v77 = v84
					v78 = v93
				end
			else
				v48:Destroy()
			end
		elseif v48.PartsHidden == false then
			v48.PartsHidden = true
			local v108 = v48.DisabledTransparency
			for v109 = 1, #v48.Parts do
				v48.Parts[v109].Transparency = v108
			end
		end
	end
end)
return v_u_25
