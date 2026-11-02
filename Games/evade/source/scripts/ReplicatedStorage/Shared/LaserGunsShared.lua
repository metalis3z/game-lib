-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("SoundService")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("Debris")
local v_u_7 = require(v1.Packages.Net)
local v_u_8 = require(v1.Classes.Projectile)
require(v1.UserGenerated.VFX.Emit)
local v_u_9 = require(v1.UserGenerated.SFX.PlaySFX)
local v_u_10 = require(v1.UserGenerated.VFX.PlayVFX)
local v11 = require(v1.UserGenerated.Lang.Asserts)
require(v1.UserGenerated.Lang.Finally)
local v12 = require(v1.UserGenerated.FastFlags)
local v_u_13 = script:WaitForChild("Sounds")
local v_u_14 = script:WaitForChild("Particles")
local v_u_15 = script:WaitForChild("Models"):WaitForChild("Projectile")
Random.new()
local v_u_16 = table.freeze({
	["Speed"] = v12.Replicated("LaserGun.Speed", v11.FinitePositive, 100),
	["Radius"] = v12.Replicated("LaserGun.Radius", v11.FiniteNonNegative, 0),
	["Gravity"] = Vector3.new(0, 0, 0),
	["MaxAge"] = v12.Replicated("LaserGun.MaxAge", v11.FinitePositive, 5),
	["TrackingRadius"] = v12.Replicated("LaserGun.TrackingRadius", v11.Optional(v11.FiniteNonNegative), 4),
	["TrackingFalloff"] = v12.Replicated("LaserGun.TrackingFalloff", v11.Optional(v11.FiniteNonNegative), 0.005),
	["TrackingResponse"] = v12.Replicated("LaserGun.TrackingResponse", v11.Optional(v11.FiniteNonNegative), 12),
	["MaxBounces"] = v12.Replicated("LaserGun.MaxBounces", v11.IntegerNonNegative, 8),
	["Cooldown"] = v12.Replicated("LaserGun.Cooldown", v11.FiniteNonNegative, 1.5),
	["ImpulseForce"] = v12.Replicated("LaserGun.ImpulseForce", v11.FiniteNonNegative, 1200),
	["StunDuration"] = v12.Replicated("LaserGun.StunDuration", v11.FiniteNonNegative, 2)
})
local function v19(p17)
	-- upvalues: (copy) v_u_16
	local v18 = ((p17.Attributes.Bounces or 1) - 1) * 0.25 + 1
	return v_u_16.ImpulseForce:Get() * v18
end
local function v22(p20)
	-- upvalues: (copy) v_u_16
	local v21 = ((p20.Attributes.Bounces or 1) - 1) * 0.25 + 1
	return v_u_16.StunDuration:Get() * v21
end
local v_u_23 = {}
local function v_u_48(p24, p25)
	-- upvalues: (copy) v_u_23, (copy) v_u_10, (copy) v_u_14, (copy) v_u_9, (copy) v_u_13, (copy) v_u_16, (copy) v_u_5, (copy) v_u_6
	if p25.HitPart then
		local v26 = p25.Character
		if v26 then
			local v27 = v26.PrimaryPart
			if v27 then
				local v28 = v26:FindFirstChildOfClass("Humanoid")
				if v28 then
					if not v_u_23[p24] then
						v_u_23[p24] = true
						local _ = p25.Attributes.Bounces or 0
						v_u_10(v27, v27.CFrame, v_u_14:WaitForChild("ImpactCharacter"):Clone())
						local v29 = v_u_9
						local v30 = v27.CFrame
						local v31 = v_u_13:WaitForChild("ImpactCharacter"):Clone()
						v31.PlaybackSpeed = v31.PlaybackSpeed * (0.9 + 0.2 * math.random())
						v29(v27, v30, v31)
						local v32 = v_u_9
						local v33 = v27.CFrame
						local v34 = v_u_13:WaitForChild("FireFaded5s"):Clone()
						v34.PlaybackSpeed = v34.PlaybackSpeed * (0.9 + 0.2 * math.random())
						v32(v27, v33, v34)
						local v35 = v28.HipHeight + 0.5 * v27.Size.Y
						local v36 = v27.CFrame * CFrame.new(0, -v35, 0)
						local v37 = Instance.new("Attachment")
						v37.CFrame = v27.CFrame:ToObjectSpace(v36)
						for _, v38 in ipairs(v_u_14:WaitForChild("Smoke1"):GetChildren()) do
							v38:Clone().Parent = v37
						end
						v37.Parent = v27
						local v39 = Instance.new("Attachment")
						for _, v40 in ipairs(v_u_14:WaitForChild("Smoke2"):GetChildren()) do
							v40:Clone().Parent = v39
						end
						v39.Parent = v27
						local v41 = Instance.new("Highlight")
						v41.Adornee = v26
						v41.Name = "BurnEffect"
						v41.FillColor = Color3.fromRGB(0, 0, 0)
						v41.FillTransparency = 1
						v41.OutlineTransparency = 1
						v41.DepthMode = Enum.HighlightDepthMode.Occluded
						v41.Parent = v26
						local v42 = ((p25.Attributes.Bounces or 1) - 1) * 0.25 + 1
						local v43 = v_u_16.StunDuration:Get() * v42
						local v44 = v_u_5:Create(v41, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							["FillTransparency"] = 0
						})
						v44:Play()
						v44.Completed:Wait()
						task.wait(v43 - 1)
						for _, v45 in ipairs(v37:GetDescendants()) do
							if v45:IsA("ParticleEmitter") then
								v45.Enabled = false
							end
						end
						v_u_6:AddItem(v37, 5)
						for _, v46 in ipairs(v39:GetDescendants()) do
							if v46:IsA("ParticleEmitter") then
								v46.Enabled = false
							end
						end
						v_u_6:AddItem(v39, 5)
						local v47 = v_u_5:Create(v41, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
							["FillTransparency"] = 1
						})
						v47:Play()
						v47.Completed:Wait()
						v41:Destroy()
						v_u_23[p24] = nil
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_71(p49, p50)
	-- upvalues: (copy) v_u_16, (copy) v_u_48, (copy) v_u_10, (copy) v_u_14, (copy) v_u_9, (copy) v_u_13
	local v51 = workspace:GetServerTimeNow()
	local v52 = (p49.Attributes.Bounces or 0) + 1
	p49.Attributes.Bounces = v52
	local v_u_53 = p50.Instance
	local v54 = p50.Position
	local v55 = p50.Normal
	local v56 = p49.LinearVelocity
	local v57 = v56 - 2 * v56:Dot(v55) * v55
	if p49.TrackingFalloff then
		p49.TrackingFalloff = p49.TrackingFalloff / 2
	end
	if p49.TrackingResponse then
		p49.TrackingResponse = p49.TrackingResponse * 2
	end
	p49.LinearVelocity = v57
	p49.MaxAge = p49.Age + v_u_16.MaxAge:Get()
	local v_u_58 = CFrame.lookAlong(v54 + v55 * 0.001, v57)
	local v59 = {
		["Timestamp"] = v51,
		["CFrame"] = p49.CFrame,
		["LinearVelocity"] = p49.LinearVelocity,
		["Age"] = p49.Age,
		["HitPart"] = v_u_53,
		["HitNormal"] = v55,
		["HitPosition"] = v54,
		["HitEnding"] = p50.Ending,
		["HitAlpha"] = p50.Alpha,
		["HitSize"] = v_u_53.Size,
		["HitCFrame"] = v_u_53.CFrame,
		["Attributes"] = table.clone(p49.Attributes)
	}
	local v60 = v_u_53:FindFirstAncestorOfClass("Model")
	if v60 and (v60.PrimaryPart and v60:FindFirstChildOfClass("Humanoid")) then
		v59.Character = v60
	end
	local v61 = p49.Impacts
	local v62 = table.freeze
	table.insert(v61, v62(v59))
	if v59.Character then
		p49:Destroy()
		if p49.Model then
			task.spawn(function() end)
			task.spawn(v_u_48, p49.Id, v59)
			return
		end
	elseif v52 <= v_u_16.MaxBounces:Get() then
		if p49.Model then
			task.spawn(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_53, (copy) v_u_58, (ref) v_u_14, (ref) v_u_9, (ref) v_u_13
				v_u_10(v_u_53, v_u_58, v_u_14:WaitForChild("ImpactBounce"):Clone())
				local v63 = v_u_9
				local v64 = v_u_53
				local v65 = v_u_58
				local v66 = v_u_13:WaitForChild("ImpactBounce"):Clone()
				v66.PlaybackSpeed = v66.PlaybackSpeed * (0.9 + 0.2 * math.random())
				v63(v64, v65, v66)
			end)
			return
		end
	else
		p49:Destroy()
		if p49.Model then
			task.spawn(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_53, (copy) v_u_58, (ref) v_u_14, (ref) v_u_9, (ref) v_u_13
				v_u_10(v_u_53, v_u_58, v_u_14:WaitForChild("ImpactFinal"):Clone())
				local v67 = v_u_9
				local v68 = v_u_53
				local v69 = v_u_58
				local v70 = v_u_13:WaitForChild("ImpactFinal"):Clone()
				v70.PlaybackSpeed = v70.PlaybackSpeed * (0.9 + 0.2 * math.random())
				v67(v68, v69, v70)
			end)
		end
	end
end
local function v_u_76(p72)
	if not (p72 and p72:IsA("Model")) then
		return nil
	end
	local v73 = p72:FindFirstChildOfClass("Tool")
	if not v73 or v73.Name ~= "Laser Gun" then
		return nil
	end
	local v74 = v73:FindFirstChild("Handle")
	if not (v74 and v74:IsA("BasePart")) then
		return nil
	end
	local v75 = v74:FindFirstChild("Muzzle")
	return v75 and (v75:IsA("Attachment") and {
		["Character"] = p72,
		["Tool"] = v73,
		["Handle"] = v74,
		["Muzzle"] = v75
	}) or nil
end
local function v_u_82(p77, p78, p79)
	-- upvalues: (copy) v_u_8, (copy) v_u_16, (copy) v_u_71
	local v_u_80 = v_u_8.new({
		["Id"] = p77.Id,
		["CreationTime"] = p77.Timestamp,
		["Origin"] = p77.Origin,
		["LinearVelocity"] = p77.Direction * v_u_16.Speed:Get(),
		["Radius"] = v_u_16.Radius:Get(),
		["Gravity"] = v_u_16.Gravity,
		["MaxAge"] = v_u_16.MaxAge:Get(),
		["TrackingRadius"] = v_u_16.TrackingRadius:Get(),
		["TrackingFalloff"] = v_u_16.TrackingFalloff:Get(),
		["TrackingResponse"] = v_u_16.TrackingResponse:Get(),
		["FilterDescendantsInstances"] = { p78.Character },
		["TemplateModel"] = p79
	})
	v_u_80.Hit:Connect(function(p81)
		-- upvalues: (ref) v_u_71, (copy) v_u_80
		v_u_71(v_u_80, p81)
	end)
	return v_u_80
end
local function v99()
	-- upvalues: (copy) v_u_76, (copy) v_u_2, (copy) v_u_8, (copy) v_u_3, (copy) v_u_7, (copy) v_u_9, (copy) v_u_13, (copy) v_u_10, (copy) v_u_14, (copy) v_u_16, (copy) v_u_82, (copy) v_u_15
	local v83 = v_u_76(v_u_2.LocalPlayer.Character)
	if v83 then
		local v84 = v83.Muzzle.WorldCFrame.Position
		local v85 = v_u_8.PickTarget({
			["FilterDescendantsInstances"] = { v83.Character }
		})
		local v86 = workspace:GetServerTimeNow()
		local v_u_87 = {
			["Id"] = v_u_3:GenerateGUID(false):lower():gsub("%-", ""),
			["Character"] = v83.Character,
			["Origin"] = v84,
			["Direction"] = (v85 - v84).Unit,
			["Timestamp"] = v86
		}
		task.spawn(function()
			-- upvalues: (ref) v_u_7, (copy) v_u_87
			v_u_7:RemoteEvent("LaserGun_Fire"):FireServer(v_u_87.Id, v_u_87.Origin, v_u_87.Direction, v_u_87.Timestamp)
		end)
		local v_u_88 = v_u_76(v_u_87.Character)
		local v_u_89
		if v_u_88 then
			task.spawn(function()
				-- upvalues: (ref) v_u_9, (copy) v_u_88, (ref) v_u_13, (ref) v_u_10, (ref) v_u_14, (ref) v_u_16
				local v90 = v_u_9
				local v91 = v_u_88.Handle
				local v92 = v_u_88.Muzzle.WorldCFrame
				local v93 = v_u_13:WaitForChild("Fire"):Clone()
				v93.PlaybackSpeed = v93.PlaybackSpeed * (0.9 + 0.2 * math.random())
				v90(v91, v92, v93)
				v_u_10(v_u_88.Handle, v_u_88.Muzzle.WorldCFrame, v_u_14:WaitForChild("Fire"):Clone())
				local v_u_94 = v_u_88.Tool.Handle.Mesh.VertexColor
				v_u_88.Tool.Handle.Mesh.VertexColor = v_u_94 * 0.1
				task.delay(v_u_16.Cooldown:Get(), function()
					-- upvalues: (ref) v_u_88, (copy) v_u_94, (ref) v_u_9, (ref) v_u_13
					v_u_88.Tool.Handle.Mesh.VertexColor = v_u_94
					local v95 = v_u_9
					local v96 = v_u_88.Handle
					local v97 = v_u_88.Muzzle.WorldCFrame
					local v98 = v_u_13:WaitForChild("Reload"):Clone()
					v98.PlaybackSpeed = v98.PlaybackSpeed * (0.9 + 0.2 * math.random())
					v95(v96, v97, v98)
				end)
			end)
			v_u_89 = v_u_82(v_u_87, v_u_88, v_u_15)
		else
			v_u_89 = nil
		end
		if v_u_89 then
			v_u_89.Destroying:Connect(function()
				-- upvalues: (ref) v_u_7, (ref) v_u_89
				v_u_7:RemoteEvent("LaserGun_Impact"):FireServer(v_u_89.Id, v_u_89.Impacts)
			end)
		end
	end
end
if v4:IsClient() then
	task.spawn(function()
		-- upvalues: (copy) v_u_7, (copy) v_u_76, (copy) v_u_9, (copy) v_u_13, (copy) v_u_10, (copy) v_u_14, (copy) v_u_16, (copy) v_u_82, (copy) v_u_15, (copy) v_u_48
		v_u_7:RemoteEvent("LaserGun_Fire").OnClientEvent:Connect(function(p100)
			-- upvalues: (ref) v_u_76, (ref) v_u_9, (ref) v_u_13, (ref) v_u_10, (ref) v_u_14, (ref) v_u_16, (ref) v_u_82, (ref) v_u_15
			local v_u_101 = v_u_76(p100.Character)
			if v_u_101 then
				task.spawn(function()
					-- upvalues: (ref) v_u_9, (copy) v_u_101, (ref) v_u_13, (ref) v_u_10, (ref) v_u_14, (ref) v_u_16
					local v102 = v_u_9
					local v103 = v_u_101.Handle
					local v104 = v_u_101.Muzzle.WorldCFrame
					local v105 = v_u_13:WaitForChild("Fire"):Clone()
					v105.PlaybackSpeed = v105.PlaybackSpeed * (0.9 + 0.2 * math.random())
					v102(v103, v104, v105)
					v_u_10(v_u_101.Handle, v_u_101.Muzzle.WorldCFrame, v_u_14:WaitForChild("Fire"):Clone())
					local v_u_106 = v_u_101.Tool.Handle.Mesh.VertexColor
					v_u_101.Tool.Handle.Mesh.VertexColor = v_u_106 * 0.1
					task.delay(v_u_16.Cooldown:Get(), function()
						-- upvalues: (ref) v_u_101, (copy) v_u_106, (ref) v_u_9, (ref) v_u_13
						v_u_101.Tool.Handle.Mesh.VertexColor = v_u_106
						local v107 = v_u_9
						local v108 = v_u_101.Handle
						local v109 = v_u_101.Muzzle.WorldCFrame
						local v110 = v_u_13:WaitForChild("Reload"):Clone()
						v110.PlaybackSpeed = v110.PlaybackSpeed * (0.9 + 0.2 * math.random())
						v107(v108, v109, v110)
					end)
				end)
				v_u_82(p100, v_u_101, v_u_15)
			end
		end)
		v_u_7:RemoteEvent("LaserGun_ImpactCharacter").OnClientEvent:Connect(function(p111, p112)
			-- upvalues: (ref) v_u_48
			v_u_48(p111, p112)
		end)
	end)
end
return table.freeze({
	["Settings"] = v_u_16,
	["ShootLocal"] = v99,
	["GetSourceInfo"] = v_u_76,
	["SharedShoot"] = v_u_82,
	["ComputeImpulseForce"] = v19,
	["ComputeStunDuration"] = v22
})
