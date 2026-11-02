---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v_u_2.Packages.Observers)
local v_u_4 = require(v_u_2.Packages.Trove)
local v_u_5 = require(v_u_2.Shared.VFX)
local v_u_6 = {}
local v7 = {}
local function v_u_35(p8, p9, p10, p11)
	local v12 = p8.X
	local v13 = p8.Z
	local v14 = vector.create(v12, 0, v13)
	local v15 = p9.X
	local v16 = p9.Z
	local v17 = vector.create(v15, 0, v16)
	local v18 = p10.X
	local v19 = p10.Z
	local v20 = vector.create(v18, 0, v19)
	local v21 = p11.X
	local v22 = p11.Z
	local v23 = vector.create(v21, 0, v22) - v17
	local v24 = v20 - v17
	local v25 = v14 - v17
	local v26 = v23:Dot(v23)
	local v27 = v23:Dot(v24)
	local v28 = v23:Dot(v25)
	local v29 = v24:Dot(v24)
	local v30 = v24:Dot(v25)
	local v31 = v26 * v29 - v27 * v27
	if v31 == 0 then
		return false
	end
	local v32 = (v29 * v28 - v27 * v30) / v31
	local v33 = (v26 * v30 - v27 * v28) / v31
	local v34
	if v32 >= 0 and v33 >= 0 then
		v34 = v32 + v33 <= 1
	else
		v34 = false
	end
	return v34
end
function v7.WaterSurfacePoint(_, p36)
	-- upvalues: (ref) v_u_6, (copy) v_u_35
	for _, v37 in v_u_6 do
		local v38, v39, v40 = unpack(v37)
		if v_u_35(p36, v38.WorldPosition, v39.WorldPosition, v40.WorldPosition) then
			local v41 = v38.Bone.WorldPosition + v38.Bone.Transform.Position
			local v42 = v39.Bone.WorldPosition + v39.Bone.Transform.Position
			local v43 = v40.Bone.WorldPosition + v40.Bone.Transform.Position
			local v44 = (v42 - v41):Cross(v43 - v41).Unit
			return p36 - v44 * (p36 - v41):Dot(v44)
		end
	end
	return p36
end
function v7.Start(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (ref) v_u_6, (copy) v_u_1
	v_u_3.observeTag("FishingCatchZone", function(p45)
		-- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_2
		task.wait(1)
		local v46 = v_u_4.new()
		if p45:FindFirstChild("PoolVFX") then
			p45:FindFirstChild("PoolVFX"):Destroy()
		end
		local v47 = p45:GetAttribute("Pool")
		local v_u_48 = script.PoolVFX:FindFirstChild(v47)
		v_u_48.Name = "PoolVFX"
		v_u_48:PivotTo(p45.CFrame * CFrame.Angles(1.5707963267948966, 0, 0))
		v_u_48.Parent = p45
		v46:Add(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_48
			v_u_5.disable(v_u_48)
			task.wait(2)
			v_u_48:Destroy()
		end)
		local v49 = v_u_2.Models.Animals:FindFirstChild(v47)
		if v49 and v_u_48:FindFirstChild("Animation") then
			local v50 = v46:Clone(v49)
			v50.PrimaryPart.Anchored = true
			v50:PivotTo(CFrame.new(p45.Position))
			v50.Parent = p45
			local v51 = v50:FindFirstChildWhichIsA("Animator", true)
			if v51 then
				local v_u_52 = v51:LoadAnimation(v_u_48.Animation)
				v46:Add(function()
					-- upvalues: (copy) v_u_52
					v_u_52:Stop(0)
					v_u_52:Destroy()
				end)
				v_u_52.Looped = true
				v_u_52:Play()
			end
		end
		return v46:WrapClean()
	end)
	v_u_3.observeTag("FishingWater", function(p53)
		-- upvalues: (ref) v_u_6
		local v54 = {}
		for _, v55 in p53:GetChildren() do
			if v55:IsA("Bone") then
				local v56 = v55:GetAttribute("Order")
				local v57 = {
					["Order"] = v56,
					["X"] = (v56 - 1) % 5 + 1
				}
				local v58 = (v56 - 1) / 5
				v57.Y = math.floor(v58) + 1
				v57.WorldPosition = v55.WorldPosition
				v57.Bone = v55
				local v59 = v57.X
				local v60 = v57.Y
				v54[vector.create(v59, v60)] = v57
			end
		end
		local v61 = {}
		for _, v62 in v54 do
			local v63 = v62.X
			local v64 = v62.Y
			if v63 < 5 then
				local v65 = v54[vector.create(v63, v64)]
				local v66 = v63 + 1
				local v67 = v54[vector.create(v66, v64)]
				local v68 = v64 + 1
				local v69 = v54[vector.create(v63, v68)]
				local v70 = v63 + 1
				local v71 = v64 + 1
				local v72 = v54[vector.create(v70, v71)]
				if v65 and (v67 and (v69 and v72)) then
					table.insert(v61, { v65, v67, v69 })
					table.insert(v61, { v67, v72, v69 })
				end
			end
		end
		v_u_6 = v61
		return function()
			-- upvalues: (ref) v_u_6
			v_u_6 = nil
		end
	end)
	v_u_3.observeTag("FishingBobber", function(p_u_73)
		-- upvalues: (ref) v_u_1
		local v74 = p_u_73:WaitForChild("RopeConstraint", 30)
		local v_u_75 = Instance.new("Beam")
		v_u_75.Attachment0 = v74.Attachment0
		v_u_75.Attachment1 = v74.Attachment1
		v_u_75.TextureSpeed = 0
		v_u_75.Segments = 1
		v_u_75.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
		v_u_75.Width0 = 0.04
		v_u_75.Width1 = 0.04
		v_u_75.Transparency = NumberSequence.new(0)
		v_u_75.Parent = p_u_73
		local v_u_76 = nil
		local v_u_77 = nil
		p_u_73:GetAttributeChangedSignal("bite"):Connect(function()
			-- upvalues: (copy) p_u_73, (ref) v_u_77, (ref) v_u_76, (ref) v_u_1
			if p_u_73:GetAttribute("bite") then
				if v_u_77 then
					v_u_77:Disconnect()
				end
				if v_u_76 then
					v_u_76:Destroy()
				end
				v_u_76 = script.catchbubbles:Clone()
				v_u_76.Parent = p_u_73
				v_u_77 = v_u_1.RenderStepped:Connect(function()
					-- upvalues: (ref) p_u_73, (ref) v_u_77, (ref) v_u_76
					if p_u_73:IsDescendantOf(workspace) then
						v_u_76.CFrame = CFrame.new(p_u_73.PrimaryPart.Position)
					else
						if v_u_77 then
							v_u_77:Disconnect()
						end
						if v_u_76 then
							v_u_76:Destroy()
							return
						end
					end
				end)
			else
				if v_u_77 then
					v_u_77:Disconnect()
				end
				if v_u_76 then
					v_u_76:Destroy()
				end
			end
		end)
		return function()
			-- upvalues: (copy) v_u_75
			v_u_75:Destroy()
		end
	end)
end
return v7
