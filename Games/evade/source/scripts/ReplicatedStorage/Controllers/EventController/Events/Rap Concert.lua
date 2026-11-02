-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
local v_u_5 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EncryptedAssetsController)
require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.EffectController)
local v_u_9 = require(v_u_1.Controllers.CameraController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = require(v_u_1.Controllers.CycleController)
local v_u_13 = require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_14 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
local v_u_15 = require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_16 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_17 = require(v_u_1.Packages.Spr)
require(v_u_1.Packages.Net)
local v_u_18 = require(v_u_1.Shared.VFX)
local v_u_19 = v_u_5.LocalPlayer
local v_u_20 = workspace.CurrentCamera
local v_u_21 = script.Name
local v_u_22 = workspace.Sounds.RapConcert
local v_u_23 = v_u_16.new()
local v_u_24 = nil
function v6.OnStart(_)
	-- upvalues: (copy) v_u_22, (copy) v_u_11, (copy) v_u_21, (copy) v_u_23, (copy) v_u_8, (copy) v_u_12, (copy) v_u_10, (copy) v_u_4, (copy) v_u_1, (copy) v_u_20, (copy) v_u_7, (copy) v_u_18, (copy) v_u_14, (copy) v_u_3, (copy) v_u_13, (copy) v_u_17, (copy) v_u_9, (copy) v_u_15, (copy) v_u_5, (copy) v_u_16, (copy) v_u_19
	v_u_22:Play()
	local v_u_25 = v_u_11:GetActiveEventData(v_u_21)
	assert(v_u_25)
	local function v_u_36(p26, p_u_27, p_u_28)
		-- upvalues: (copy) v_u_25
		local function v_u_31()
			-- upvalues: (copy) p_u_27, (ref) v_u_25
			local v29 = p_u_27
			local v30 = v_u_25.startedAt + v29 - workspace:GetServerTimeNow()
			return math.max(v30, 0)
		end
		local function v32()
			-- upvalues: (copy) p_u_28, (copy) v_u_31
			p_u_28(v_u_31)
		end
		local v_u_33 = nil
		local v34 = v_u_25.startedAt + p26 - workspace:GetServerTimeNow()
		local v35 = math.max(v34, 0)
		if v35 > 0 then
			v_u_33 = task.delay(v35, v32)
		else
			p_u_28(v_u_31)
		end
		return function()
			-- upvalues: (ref) v_u_33
			if v_u_33 and coroutine.status(v_u_33) == "suspended" then
				pcall(task.cancel, v_u_33)
			end
		end
	end
	v_u_23:Add(function()
		-- upvalues: (ref) v_u_8, (ref) v_u_12, (ref) v_u_10
		v_u_8:Activate("Blink")
		v_u_12:Update()
		v_u_10:UpdateOST()
	end)
	local v_u_37 = v_u_4:FindFirstChild("Atmosphere")
	if v_u_37 then
		v_u_37.Parent = v_u_1
		v_u_23:Add(function()
			-- upvalues: (copy) v_u_37, (ref) v_u_4
			v_u_37.Parent = v_u_4
		end)
	end
	v_u_23:Clone(script.Atmosphere).Parent = v_u_4
	local v_u_38 = v_u_4:FindFirstChild("Cartoon")
	if v_u_38 then
		v_u_38.Parent = v_u_1
		v_u_23:Add(function()
			-- upvalues: (copy) v_u_38, (ref) v_u_4
			v_u_38.Parent = v_u_4
		end)
	end
	local v_u_39 = nil
	local v_u_40 = v_u_23:Clone(Instance.new("ColorCorrectionEffect"))
	v_u_40.Parent = v_u_20
	local function v_u_133()
		-- upvalues: (ref) v_u_4, (ref) v_u_23, (ref) v_u_22, (ref) v_u_7, (copy) v_u_25, (ref) v_u_18, (ref) v_u_14, (copy) v_u_36, (ref) v_u_3, (ref) v_u_39, (ref) v_u_13, (ref) v_u_17, (ref) v_u_9
		v_u_4.Ambient = Color3.new(0, 0, 0)
		v_u_4.Brightness = -1.2
		v_u_4.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
		v_u_4.EnvironmentDiffuseScale = 0
		v_u_4.EnvironmentSpecularScale = 0
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_4
			v_u_4.Brightness = 2
			v_u_4.Ambient = Color3.fromRGB(241, 241, 241)
			v_u_4.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
			v_u_4.EnvironmentDiffuseScale = 1
			v_u_4.EnvironmentSpecularScale = 0.5
		end)
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_22
			v_u_22:Stop()
		end)
		v_u_23:Add(task.spawn(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_22, (ref) v_u_25
			v_u_7:WaitForAssetId("rbxassetid://134531020235302")
			v_u_22.SoundId = ""
			v_u_22.SoundId = "rbxassetid://134531020235302"
			while not v_u_22.IsLoaded do
				task.wait(1)
			end
			local v41 = v_u_22
			local v42 = v_u_22.TimePosition
			local v43 = workspace:GetServerTimeNow() - (v_u_25.startedAt + 5)
			v41.TimePosition = math.max(v42, v43)
			v_u_22:Play()
		end))
		local v_u_44 = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 128, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(128, 255, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(0, 255, 128),
			Color3.fromRGB(0, 255, 255),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(128, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 0, 128),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(0, 128, 255)
		}
		v_u_23:Clone(script.Night_Sky).Parent = v_u_4
		local v45 = v_u_23:Clone(script.Stage)
		local v_u_46 = v_u_23:Clone(script.VFX)
		local v_u_47 = v_u_46.SmokeStage
		v_u_23:Add(v_u_47)
		v_u_47.Parent = workspace
		v_u_46.Parent = v45
		v_u_18.disable(v_u_46)
		local v_u_48 = v45.SpotLights:GetChildren()
		local _ = #v_u_48
		local v_u_49 = {}
		local v_u_50 = {}
		local v_u_51 = {}
		local v_u_52 = {}
		local v_u_53 = {}
		local v_u_54 = {}
		local v_u_55 = false
		local v_u_56 = {}
		local v_u_57 = {}
		local v_u_58 = false
		local v_u_59 = {}
		for _, v60 in v_u_48 do
			v_u_49[v60] = v60:GetPivot()
			v_u_50[v60] = 0
			v_u_51[v60] = 0
			v_u_52[v60] = 25
			v60.Rotate.Neon["1"].LightBeam:Destroy()
			local v61 = script.lightbeambig.Beams:Clone()
			for _, v62 in v61:GetChildren() do
				v62.Attachment0 = v60.Rotate.Neon["1"]
				v62.Attachment1 = v60.Rotate.Neon["2"]
				v62.Parent = v60.Rotate.Neon
				table.insert(v_u_53, v62)
			end
			v61:Destroy()
		end
		v45.Parent = workspace
		v_u_23:Add(v_u_14.observeTag("HideInRapConcert", function(p_u_63)
			local v_u_64 = p_u_63.Parent
			p_u_63.Parent = script
			return function()
				-- upvalues: (copy) p_u_63, (copy) v_u_64
				pcall(function()
					-- upvalues: (ref) p_u_63, (ref) v_u_64
					p_u_63.Parent = v_u_64
				end)
			end
		end, { workspace, script }))
		local v_u_65 = v_u_23:Add(Instance.new("Color3Value"))
		v_u_65.Value = Color3.fromRGB(0, 0, 0)
		local v_u_66 = true
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_66
			v_u_66 = false
		end)
		for _, v67 in v_u_53 do
			v67.Enabled = false
		end
		v_u_23:Add((v_u_36(10, 15, function(p_u_68)
			-- upvalues: (ref) v_u_18, (copy) v_u_46, (copy) v_u_53, (ref) v_u_23, (ref) v_u_3, (ref) v_u_22, (copy) v_u_56, (copy) v_u_59, (ref) v_u_39, (copy) v_u_44, (ref) v_u_13, (copy) v_u_65, (ref) v_u_25, (ref) v_u_17, (copy) v_u_54, (copy) v_u_57, (copy) v_u_48, (copy) v_u_51, (copy) v_u_52, (copy) v_u_50, (copy) v_u_49, (ref) v_u_55, (ref) v_u_58, (copy) v_u_47, (ref) v_u_9
			v_u_18.enable(v_u_46)
			local v_u_69 = 1
			local v_u_70 = 0
			local v_u_71 = 0
			local v_u_72 = 0
			local v_u_73 = 0
			local v_u_74 = {}
			local v_u_75 = Color3.new(0, 0, 0)
			local v_u_76 = ColorSequence.new(v_u_75)
			task.delay(p_u_68(), function()
				-- upvalues: (ref) v_u_53
				for _, v77 in v_u_53 do
					v77.Enabled = true
				end
			end)
			v_u_23:Add(function()
				workspace.Gravity = 196.2
			end)
			local v_u_78 = v_u_46.VFXDisco
			local v_u_79 = v_u_78:GetPivot()
			local v_u_80 = 0
			v_u_23:Add(v_u_3.PostSimulation:Connect(function(p81)
				-- upvalues: (ref) v_u_80, (ref) v_u_71, (ref) v_u_70, (ref) v_u_73, (ref) v_u_72, (ref) v_u_22, (ref) v_u_56, (ref) v_u_59, (ref) v_u_39, (copy) p_u_68, (ref) v_u_69, (ref) v_u_44, (ref) v_u_13, (ref) v_u_65, (copy) v_u_78, (copy) v_u_79, (ref) v_u_25, (ref) v_u_17, (ref) v_u_54, (copy) v_u_74, (copy) v_u_76, (ref) v_u_57, (copy) v_u_75, (ref) v_u_48, (ref) v_u_51, (ref) v_u_52, (ref) v_u_50, (ref) v_u_49, (ref) v_u_55, (ref) v_u_58, (ref) v_u_53, (ref) v_u_18, (ref) v_u_47, (ref) v_u_9
				debug.profilebegin("Rap Concert:Update")
				workspace.Gravity = 29.429999999999996
				v_u_80 = v_u_80 - p81
				v_u_71 = v_u_71 - p81
				v_u_70 = v_u_70 - p81
				v_u_73 = v_u_73 - p81
				v_u_72 = v_u_72 - p81
				local v82 = v_u_22.TimePosition
				local v83 = (v_u_22.PlaybackLoudness - 100) / 900
				local v84 = math.clamp(v83, 0, 1)
				for _, v85 in v_u_56 do
					local v86 = v84 / 0.05
					v85.TimeScale = math.clamp(v86, 1, 2) * v_u_59[v85]
				end
				if v_u_39 then
					local v87 = v_u_39
					local v88 = v84 / 0.2
					v87:AdjustSpeed((math.clamp(v88, 0.5, 1.1)))
				end
				if v84 >= 0.11 and (v_u_72 <= 0 and p_u_68() <= 0) then
					v_u_72 = 0.3
					v_u_69 = v_u_69 % #v_u_44 + 1
					v_u_13(v_u_65, TweenInfo.new(0.2), {
						["Value"] = v_u_44[v_u_69]
					})
				end
				v_u_78:PivotTo(v_u_79 * CFrame.Angles(0, workspace:GetServerTimeNow() - v_u_25.startedAt, 0))
				v_u_17.target(v_u_78, 1, 2, {
					["Scale"] = 1
				})
				if v_u_80 <= 0 and v84 > 0.05 then
					v_u_80 = 0.1
					v_u_17.target(v_u_78, 1, 10, {
						["Scale"] = v84 + 1
					})
				end
				local v89 = v_u_65.Value
				local v90 = ColorSequence.new(v89)
				for _, v91 in v_u_54 do
					local v92
					if v_u_74[v91] then
						v92 = v_u_76
					else
						v92 = v90
					end
					v91.Color = v92
				end
				for _, v93 in v_u_57 do
					local v94
					if v_u_74[v93] then
						v94 = v_u_75
					else
						v94 = v89
					end
					v93.Color = v94
				end
				local v95 = v84 / 0.25
				local v96 = p81 * math.clamp(v95, 0.05, 1)
				for _, v97 in v_u_48 do
					local v98 = v_u_51[v97] or 0
					local v99 = v_u_52[v97] or 0
					local v100 = (v_u_50[v97] or 0) + v96
					local v101 = math.clamp(v100, 0, 1)
					v_u_50[v97] = v101
					if v101 >= 1 then
						v_u_50[v97] = 0
						v_u_51[v97] = v99
						local v102 = v_u_52
						v102[v97] = v102[v97] * -1
					else
						local v103 = math.lerp(v98, v99, v101)
						local v104 = math.rad(v103)
						v97:PivotTo(v_u_49[v97] * CFrame.Angles(0, v104, not v_u_55 and 0 or v104))
						if v_u_55 then
							for _, v105 in v97.Rotate.Neon:GetChildren() do
								if v105.Name == "CustomAttachment_-1" or (v105.Name == "2" or v105.Name == "CustomAttachment_2") then
									local v106 = v105.Position.X
									local v107 = v101 * 3.141592653589793
									local v108 = math.sin(v107) * 100
									v105.Position = Vector3.new(v106, v108, 300)
								end
							end
						end
					end
				end
				if v82 >= 25 and not v_u_58 then
					v_u_58 = true
					for _, v109 in v_u_48 do
						local v110 = v109.Rotate.Neon["1"]
						local v111 = v109.Rotate.Neon["2"]
						local v112 = v111:Clone()
						v112.Name = "CustomAttachment_1"
						v112.Parent = v109.Rotate.Neon
						v_u_13(v111, TweenInfo.new(5), {
							["Position"] = v111.Position + Vector3.new(15, 0, 0)
						})
						v_u_13(v112, TweenInfo.new(5), {
							["Position"] = v111.Position - Vector3.new(15, 0, 0)
						})
						local v113 = script.lightbeambig.Beams:Clone()
						for _, v114 in v113:GetChildren() do
							v114.Width0 = 0.5
							v114.Width1 = 1
							v114.Brightness = 13
							v114.Attachment0 = v110
							v114.Attachment1 = v112
							v114.Parent = v109.Rotate.Neon
							local v115 = v_u_53
							table.insert(v115, v114)
							local v116 = v_u_54
							table.insert(v116, v114)
						end
						v113:Destroy()
					end
				end
				if v82 >= 71 and not v_u_55 then
					v_u_18.enable(v_u_47)
					task.delay(5, function()
						-- upvalues: (ref) v_u_18, (ref) v_u_47
						v_u_18.disable(v_u_47)
					end)
					v_u_55 = true
					for _, v117 in v_u_48 do
						local v118 = v117.Rotate.Neon["1"]
						local v119 = v117.Rotate.Neon["2"]
						local v120 = v119.Position - Vector3.new(15, 0, 0)
						v_u_13(v119, TweenInfo.new(5), {
							["Position"] = v120
						})
						for v121 = -2, 2 do
							if v121 ~= 0 then
								local v122 = v119:Clone()
								v122.Name = ("CustomAttachment_%*"):format(v121)
								v122.Parent = v117.Rotate.Neon
								local v123 = v_u_13
								local v124 = TweenInfo.new(5)
								local v125 = {}
								local v126 = v121 * 30
								v125.Position = v120 + Vector3.new(v126, 0, 0)
								v123(v122, v124, v125)
								local v127 = script.lightbeambig.Beams:Clone()
								for _, v128 in v127:GetChildren() do
									v128.Width0 = 0.5
									v128.Width1 = 1
									v128.Brightness = 13
									v128.Attachment0 = v118
									v128.Attachment1 = v122
									v128.Parent = v117.Rotate.Neon
									local v129 = v_u_53
									table.insert(v129, v128)
									local v130 = v_u_54
									table.insert(v130, v128)
								end
								v127:Destroy()
							end
						end
					end
				end
				if v84 >= 0.2 and v_u_70 <= 0 then
					v_u_70 = 0.1
					v_u_9:Fov((v84 - 0.2) * 15 + 70, 0.1)
				end
				debug.profileend()
			end))
		end)))
		for _, v131 in v45:GetDescendants() do
			if not v131:IsDescendantOf(v_u_46.VFXDisco) then
				if v131:IsA("BasePart") and v131.Name == "Neon" or v131:IsA("SpotLight") then
					table.insert(v_u_57, v131)
				elseif v131:IsA("ParticleEmitter") or v131:IsA("Beam") then
					table.insert(v_u_54, v131)
					if v131:IsA("ParticleEmitter") then
						v_u_59[v131] = v131.TimeScale
						table.insert(v_u_56, v131)
					end
				end
			end
		end
		v_u_23:Add((v_u_36(10, 15, function(p132)
			-- upvalues: (ref) v_u_13, (copy) v_u_65, (copy) v_u_44
			v_u_13(v_u_65, TweenInfo.new(p132()), {
				["Value"] = v_u_44[1]
			})
		end)))
	end
	v_u_23:Add((v_u_36(0, 5, function(p134)
		-- upvalues: (ref) v_u_13, (copy) v_u_40, (copy) v_u_133, (ref) v_u_8, (ref) v_u_23
		v_u_13(v_u_40, TweenInfo.new(p134(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -1.2
		})
		task.delay(p134(), v_u_133)
		v_u_8:Run("ConcertEvent", "GrassRecolor")
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_8
			v_u_8:Stop("ConcertEvent", "GrassRecolor")
		end)
		v_u_8:Run("ConcertEvent", "WallRecolor")
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_8
			v_u_8:Stop("ConcertEvent", "WallRecolor")
		end)
		v_u_8:Run("ConcertEvent", "WallBottomRecolor")
		v_u_23:Add(function()
			-- upvalues: (ref) v_u_8
			v_u_8:Stop("ConcertEvent", "WallBottomRecolor")
		end)
	end)))
	v_u_23:Add((v_u_36(10, 15, function(p135)
		-- upvalues: (ref) v_u_13, (copy) v_u_40
		v_u_13(v_u_40, TweenInfo.new(p135(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -0.05
		})
	end)))
	local v136 = v_u_23
	local v137 = task.delay
	local v138 = v_u_25.startedAt + 15 - workspace:GetServerTimeNow()
	v136:Add(v137(math.max(v138, 0), function()
		-- upvalues: (ref) v_u_23, (ref) v_u_15, (ref) v_u_14, (ref) v_u_5, (ref) v_u_16, (ref) v_u_39, (ref) v_u_3, (copy) v_u_25, (ref) v_u_19
		v_u_23:Add(v_u_15.new())
		v_u_23:Add(v_u_14.observeCharacter(v_u_5.LocalPlayer, function(_, p_u_139)
			-- upvalues: (ref) v_u_16, (ref) v_u_39, (ref) v_u_3, (ref) v_u_25, (ref) v_u_19
			local v_u_140 = v_u_16.new()
			v_u_140:Add(task.spawn(function()
				-- upvalues: (copy) p_u_139, (ref) v_u_39, (copy) v_u_140, (ref) v_u_3, (ref) v_u_25, (ref) v_u_19
				local v_u_141 = p_u_139:WaitForChild("Humanoid")
				if v_u_141 then
					local v142 = v_u_141:WaitForChild("Animator")
					if v142 then
						local v_u_143 = v142:LoadAnimation(script.Dance)
						v_u_143.Priority = Enum.AnimationPriority.Action
						v_u_39 = v_u_143
						local v_u_144 = 0
						v_u_140:Add(v_u_3.PostSimulation:Connect(function(p145)
							-- upvalues: (ref) v_u_25, (copy) v_u_143, (copy) v_u_141, (ref) v_u_19, (ref) v_u_144
							debug.profilebegin("Rap Concert:Player:Dance")
							workspace:GetServerTimeNow()
							local v146 = v_u_25.startedAt + 75 - workspace:GetServerTimeNow()
							if math.max(v146, 0) > 0 then
								if not v_u_143.IsPlaying then
									v_u_143:Play()
								end
								debug.profileend()
							else
								if v_u_141.MoveDirection == Vector3.new(0, 0, 0) and not v_u_19:GetAttribute("Stealing") then
									if v_u_144 < 3 then
										v_u_144 = v_u_144 + p145
									elseif not v_u_143.IsPlaying then
										v_u_143:Play()
									end
								else
									v_u_144 = 0
									if v_u_143.IsPlaying then
										v_u_143:Stop()
									end
								end
								debug.profileend()
							end
						end))
						v_u_140:Add(function()
							-- upvalues: (copy) v_u_143, (ref) v_u_39
							v_u_143:Stop()
							v_u_143:Destroy()
							v_u_39 = nil
						end)
					end
				else
					return
				end
			end))
			return v_u_140:WrapClean()
		end))
	end))
	v_u_12:Update()
	v_u_10:UpdateOST()
end
function v6.OnStop(_)
	-- upvalues: (copy) v_u_23, (ref) v_u_24
	v_u_23:Destroy()
	v_u_24 = nil
end
function v6.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_22
	task.spawn(function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_22, (ref) v_u_2
		v_u_7:WaitForAssetId("rbxassetid://134531020235302")
		v_u_22.SoundId = "rbxassetid://134531020235302"
		v_u_2:PreloadAsync({ v_u_22 })
	end)
end
return v6
