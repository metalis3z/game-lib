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
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EffectController)
local v_u_10 = require(v_u_1.Controllers.CameraController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
local v_u_12 = require(v_u_1.Controllers.EventController)
local v_u_13 = require(v_u_1.Controllers.CycleController)
local v_u_14 = require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_15 = require(v_u_1.Packages.Observers)
local v_u_16 = require(v_u_1.Utils.MathUtils)
local v_u_17 = require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_18 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v19 = require(v_u_1.Packages.Net)
local v_u_20 = require(v_u_1.Shared.VFX)
local v_u_21 = v_u_5.LocalPlayer
local v_u_22 = workspace.CurrentCamera
local v_u_23 = script.Name
local v_u_24 = workspace.Sounds.Concert
local v_u_25 = v19:RemoteEvent("EventService/Concert/Shoot")
local v_u_26 = v_u_18.new()
local v_u_27 = nil
function v6.OnStart(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_12, (copy) v_u_23, (copy) v_u_26, (copy) v_u_9, (copy) v_u_13, (copy) v_u_11, (copy) v_u_4, (copy) v_u_1, (copy) v_u_22, (copy) v_u_7, (copy) v_u_20, (copy) v_u_15, (copy) v_u_25, (copy) v_u_8, (copy) v_u_3, (copy) v_u_16, (copy) v_u_14, (copy) v_u_10, (copy) v_u_17, (copy) v_u_5, (copy) v_u_18, (copy) v_u_21
	v_u_24:Play()
	local v_u_28 = v_u_12:GetActiveEventData(v_u_23)
	assert(v_u_28)
	local function v_u_39(p29, p_u_30, p_u_31)
		-- upvalues: (copy) v_u_28
		local function v_u_34()
			-- upvalues: (copy) p_u_30, (ref) v_u_28
			local v32 = p_u_30
			local v33 = v_u_28.startedAt + v32 - workspace:GetServerTimeNow()
			return math.max(v33, 0)
		end
		local function v35()
			-- upvalues: (copy) p_u_31, (copy) v_u_34
			p_u_31(v_u_34)
		end
		local v_u_36 = nil
		local v37 = v_u_28.startedAt + p29 - workspace:GetServerTimeNow()
		local v38 = math.max(v37, 0)
		if v38 > 0 then
			v_u_36 = task.delay(v38, v35)
		else
			p_u_31(v_u_34)
		end
		return function()
			-- upvalues: (ref) v_u_36
			if v_u_36 and coroutine.status(v_u_36) == "suspended" then
				pcall(task.cancel, v_u_36)
			end
		end
	end
	v_u_26:Add(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_13, (ref) v_u_11
		v_u_9:Activate("Blink")
		v_u_13:Update()
		v_u_11:UpdateOST()
	end)
	local v_u_40 = v_u_4:FindFirstChild("Atmosphere")
	if v_u_40 then
		v_u_40.Parent = v_u_1
		v_u_26:Add(function()
			-- upvalues: (copy) v_u_40, (ref) v_u_4
			v_u_40.Parent = v_u_4
		end)
	end
	v_u_26:Clone(script.Atmosphere).Parent = v_u_4
	local v_u_41 = v_u_4:FindFirstChild("Cartoon")
	if v_u_41 then
		v_u_41.Parent = v_u_1
		v_u_26:Add(function()
			-- upvalues: (copy) v_u_41, (ref) v_u_4
			v_u_41.Parent = v_u_4
		end)
	end
	local v_u_42 = nil
	local v_u_43 = v_u_26:Clone(Instance.new("ColorCorrectionEffect"))
	v_u_43.Parent = v_u_22
	local function v_u_175()
		-- upvalues: (ref) v_u_4, (ref) v_u_26, (ref) v_u_24, (ref) v_u_7, (copy) v_u_28, (ref) v_u_20, (ref) v_u_15, (ref) v_u_25, (ref) v_u_8, (ref) v_u_11, (ref) v_u_1, (ref) v_u_3, (ref) v_u_16, (copy) v_u_39, (ref) v_u_42, (ref) v_u_14, (ref) v_u_10
		v_u_4.Ambient = Color3.new(0, 0, 0)
		v_u_4.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
		v_u_4.EnvironmentDiffuseScale = 0
		v_u_4.EnvironmentSpecularScale = 0
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_4
			v_u_4.Ambient = Color3.fromRGB(241, 241, 241)
			v_u_4.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
			v_u_4.EnvironmentDiffuseScale = 1
			v_u_4.EnvironmentSpecularScale = 0.5
		end)
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_24
			v_u_24:Stop()
		end)
		v_u_26:Add(task.spawn(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_24, (ref) v_u_28
			v_u_7:WaitForAssetId("rbxassetid://122013252437083")
			v_u_24.SoundId = ""
			v_u_24.SoundId = "rbxassetid://122013252437083"
			while not v_u_24.IsLoaded do
				task.wait()
			end
			local v44 = v_u_24
			local v45 = v_u_24.TimePosition
			local v46 = workspace:GetServerTimeNow() - (v_u_28.startedAt + 5)
			v44.TimePosition = math.max(v45, v46)
			v_u_24:Play()
		end))
		local v_u_47 = {
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
		v_u_26:Clone(script.Night_Sky).Parent = v_u_4
		local v48 = v_u_26:Clone(script.Stage)
		local v_u_49 = v_u_26:Clone(script.VFX)
		local v_u_50 = v_u_49.SmokeStage
		v_u_26:Add(v_u_50)
		v_u_50.Parent = workspace
		v_u_49.Parent = v48
		v_u_20.disable(v_u_49)
		local v_u_51 = v48.SpotLights:GetChildren()
		local _ = #v_u_51
		local v_u_52 = {}
		local v_u_53 = {}
		local v_u_54 = {}
		local v_u_55 = {}
		local v_u_56 = {}
		local v_u_57 = {}
		local v_u_58 = false
		local v_u_59 = false
		local v_u_60 = {}
		local v_u_61 = {}
		local v_u_62 = {}
		for _, v63 in v_u_51 do
			v_u_52[v63] = v63:GetPivot()
			v_u_53[v63] = 0
			v_u_54[v63] = 0
			v_u_55[v63] = 25
			v63.Rotate.Neon["1"].LightBeam:Destroy()
			local v64 = script.lightbeambig.Beams:Clone()
			for _, v65 in v64:GetChildren() do
				v65.Attachment0 = v63.Rotate.Neon["1"]
				v65.Attachment1 = v63.Rotate.Neon["2"]
				v65.Parent = v63.Rotate.Neon
				table.insert(v_u_56, v65)
			end
			v64:Destroy()
		end
		v48.Parent = workspace
		v_u_26:Add(v_u_15.observeTag("HideInConcert", function(p_u_66)
			local v_u_67 = p_u_66.Parent
			p_u_66.Parent = script
			return function()
				-- upvalues: (copy) p_u_66, (copy) v_u_67
				pcall(function()
					-- upvalues: (ref) p_u_66, (ref) v_u_67
					p_u_66.Parent = v_u_67
				end)
			end
		end, { workspace, script }))
		local v_u_68 = { v48.Rigs.Tralalero, v48.Rigs.Chimpanzini, v48.Rigs.Chimpanzini2 }
		local v_u_69 = {}
		for _, v70 in v_u_68 do
			local v71 = {}
			local v72 = v70.Throw
			local v73 = v70.AnimationController.Animator:LoadAnimation(v72)
			v_u_26:Add(v73, "Stop")
			v_u_26:Add(v73)
			v71.Throw = v73
			local v74 = v70.Shuffle
			local v75 = v70.AnimationController.Animator:LoadAnimation(v74)
			v_u_26:Add(v75, "Stop")
			v_u_26:Add(v75)
			v71.Shuffle = v75
			v_u_69[v70] = v71
		end
		local v_u_76 = v_u_26:Add(Instance.new("Color3Value"))
		v_u_76.Value = Color3.fromRGB(0, 0, 0)
		for _, v77 in v_u_69 do
			v77.Shuffle:Play()
		end
		local v_u_78 = true
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_78
			v_u_78 = false
		end)
		v_u_26:Add(v_u_25.OnClientEvent:Connect(function(p79, p80, p_u_81)
			-- upvalues: (ref) v_u_8, (copy) v_u_68, (copy) v_u_69, (ref) v_u_78, (ref) v_u_11, (ref) v_u_1, (ref) v_u_3, (ref) v_u_16, (ref) v_u_20
			local v_u_82 = v_u_8:GetAnimals()[p80]
			if v_u_82 then
				local v83 = v_u_68[p79] or v_u_68[1]
				if v83 then
					v_u_69[v83].Throw:Play()
					task.wait(0.25)
					if v_u_78 then
						local v_u_84 = v83:FindFirstChild("SHOOT", true).WorldPosition
						task.spawn(function()
							-- upvalues: (ref) v_u_11, (ref) v_u_1, (copy) v_u_84
							v_u_11:PlaySound(v_u_1.Sounds.Events.Concert.Shoot, v_u_84)
						end)
						local v_u_85 = script.DiscoProjectile:Clone()
						v_u_85.Part.CFrame = CFrame.new(v_u_84)
						v_u_85.Parent = workspace
						local v_u_86 = nil
						v_u_86 = v_u_3.PreRender:Connect(function()
							-- upvalues: (copy) v_u_82, (copy) v_u_84, (copy) p_u_81, (ref) v_u_16, (copy) v_u_85, (ref) v_u_86, (ref) v_u_11, (ref) v_u_1, (ref) v_u_20
							debug.profilebegin("Concert Disco Shoot")
							local v87 = v_u_82.AnimalModel
							local v88
							if v87.PrimaryPart then
								v88 = v87.PrimaryPart.CFrame
							else
								v88 = v87:GetPivot()
							end
							local v_u_89 = v88.Position
							local v90 = v_u_84 + (v_u_89 - v_u_84) * 0.5 + Vector3.new(0, 90, 0)
							local v91 = 1 - (p_u_81 + 3 - workspace:GetServerTimeNow()) / 3
							local v92 = v_u_16.quadBezier(math.clamp(v91, 0, 1), v_u_84, v90, v_u_89)
							v_u_85.Part.CFrame = CFrame.new(v92)
							if v91 >= 1 then
								v_u_86:Disconnect()
								task.spawn(function()
									-- upvalues: (ref) v_u_11, (ref) v_u_1, (copy) v_u_89
									v_u_11:PlaySound(v_u_1.Sounds.Events.Concert.Hit, v_u_89)
								end)
								v_u_85:Destroy()
								local v_u_93 = script.DiscoExplosion:Clone()
								v_u_93:PivotTo(CFrame.new(v_u_89))
								v_u_93.Anchored = false
								local v94 = Instance.new("WeldConstraint")
								v94.Part0 = v_u_93
								v94.Part1 = v_u_82.AnimalModel.PrimaryPart
								v94.Parent = v_u_93
								v_u_93.Parent = workspace
								v_u_20.emit(v_u_93)
								task.delay(3, function()
									-- upvalues: (copy) v_u_93
									v_u_93:Destroy()
								end)
							end
							debug.profileend()
						end)
					end
				else
					return
				end
			else
				return
			end
		end))
		for _, v95 in v_u_56 do
			v95.Enabled = false
		end
		v_u_26:Add((v_u_39(10, 15, function(p_u_96)
			-- upvalues: (ref) v_u_20, (copy) v_u_49, (copy) v_u_56, (ref) v_u_26, (ref) v_u_3, (ref) v_u_24, (copy) v_u_61, (copy) v_u_60, (copy) v_u_69, (ref) v_u_42, (copy) v_u_47, (ref) v_u_14, (copy) v_u_76, (copy) v_u_62, (copy) v_u_57, (copy) v_u_51, (copy) v_u_54, (copy) v_u_55, (copy) v_u_53, (copy) v_u_52, (ref) v_u_58, (ref) v_u_59, (copy) v_u_50, (ref) v_u_10
			v_u_20.enable(v_u_49)
			local v_u_97 = 1
			local v_u_98 = 0
			local v_u_99 = 0
			local v_u_100 = 0
			local v_u_101 = 0
			local v_u_102 = {}
			local v_u_103 = Color3.new(0, 0, 0)
			local v_u_104 = ColorSequence.new(v_u_103)
			task.delay(p_u_96(), function()
				-- upvalues: (ref) v_u_56
				for _, v105 in v_u_56 do
					v105.Enabled = true
				end
			end)
			v_u_26:Add(function()
				workspace.Gravity = 196.2
			end)
			v_u_26:Add(v_u_3.PostSimulation:Connect(function(p106)
				-- upvalues: (ref) v_u_99, (ref) v_u_98, (ref) v_u_101, (ref) v_u_100, (ref) v_u_24, (ref) v_u_61, (ref) v_u_60, (ref) v_u_69, (ref) v_u_42, (copy) p_u_96, (ref) v_u_97, (ref) v_u_47, (ref) v_u_14, (ref) v_u_76, (copy) v_u_103, (ref) v_u_62, (copy) v_u_102, (copy) v_u_104, (ref) v_u_57, (ref) v_u_51, (ref) v_u_54, (ref) v_u_55, (ref) v_u_53, (ref) v_u_52, (ref) v_u_58, (ref) v_u_56, (ref) v_u_59, (ref) v_u_20, (ref) v_u_50, (ref) v_u_10
				debug.profilebegin("Concert:Update")
				workspace.Gravity = 29.429999999999996
				v_u_99 = v_u_99 - p106
				v_u_98 = v_u_98 - p106
				v_u_101 = v_u_101 - p106
				v_u_100 = v_u_100 - p106
				local v107 = v_u_24.TimePosition
				local v108
				if v107 >= 20 and v107 <= 25 then
					v108 = true
				elseif v107 >= 70 then
					v108 = v107 <= 94.5
				else
					v108 = false
				end
				local v109 = (v_u_24.PlaybackLoudness - 100) / 900
				local v110 = math.clamp(v109, 0, 1)
				for _, v111 in v_u_61 do
					local v112 = v110 / 0.05
					v111.TimeScale = math.clamp(v112, 1, 2) * v_u_60[v111]
				end
				for _, v113 in v_u_69 do
					local v114 = v113.Shuffle
					local v115 = v110 / 0.13
					v114:AdjustSpeed((math.clamp(v115, 0.5, 1.5)))
				end
				if v_u_42 then
					local v116 = v_u_42
					local v117
					if v108 then
						v117 = 3
					else
						local v118 = v110 / 0.06
						v117 = math.clamp(v118, 1, 3)
					end
					v116:AdjustSpeed(v117)
				end
				local v119
				if v107 >= 70 and v107 <= 94.5 then
					if v107 >= 85 then
						v119 = 0.05
					else
						local v120 = (v107 - 70) / 12
						local v121 = math.min(v120, 1)
						v119 = math.lerp(0.5, 0.2, v121)
					end
				else
					v119 = v108 and 0.1 or 0.3
				end
				if (v110 >= 0.11 or v108) and (v_u_100 <= 0 and p_u_96() <= 0) then
					v_u_100 = v119
					v_u_97 = v_u_97 % #v_u_47 + 1
					v_u_14(v_u_76, TweenInfo.new(0.2), {
						["Value"] = v_u_47[v_u_97]
					})
				end
				local v122 = v_u_76.Value
				if v107 >= 94.3 and v107 <= 97.7 then
					v122 = v_u_103
				end
				local v123 = ColorSequence.new(v122)
				for _, v124 in v_u_62 do
					local v125
					if v_u_102[v124] then
						v125 = v_u_104
					else
						v125 = v123
					end
					v124.Color = v125
				end
				for _, v126 in v_u_57 do
					local v127
					if v_u_102[v126] then
						v127 = v_u_103
					else
						v127 = v122
					end
					v126.Color = v127
				end
				local v128
				if v108 then
					v128 = 1.5
				else
					local v129 = v110 / 0.25
					v128 = math.clamp(v129, 0.05, 1)
				end
				local v130 = p106 * v128
				for _, v131 in v_u_51 do
					local v132 = v_u_54[v131] or 0
					local v133 = v_u_55[v131] or 0
					local v134 = (v_u_53[v131] or 0) + v130
					local v135 = math.clamp(v134, 0, 1)
					v_u_53[v131] = v135
					if v135 >= 1 then
						v_u_53[v131] = 0
						v_u_54[v131] = v133
						local v136 = v_u_55
						v136[v131] = v136[v131] * -1
					else
						local v137 = math.lerp(v132, v133, v135)
						local v138 = math.rad(v137)
						v131:PivotTo(v_u_52[v131] * CFrame.Angles(0, v138, not v_u_58 and 0 or v138))
						if v_u_58 then
							for _, v139 in v131.Rotate.Neon:GetChildren() do
								if v139.Name == "CustomAttachment_-1" or (v139.Name == "2" or v139.Name == "CustomAttachment_2") then
									local v140 = v139.Position.X
									local v141 = v135 * 3.141592653589793
									local v142 = math.sin(v141) * 100
									v139.Position = Vector3.new(v140, v142, 300)
								end
							end
						end
					end
				end
				if v108 and v_u_99 <= 0 then
					local v143 = math.random(100, 200)
					v_u_99 = v143 / 1000
					local v144 = {}
					for _, v_u_145 in v_u_56 do
						v144[v_u_145] = true
						local v146 = v_u_145.Width0 - 0.5
						v_u_145.Width0 = math.max(v146, 0.5)
						local v147 = v_u_145.Width1 - 2.5
						v_u_145.Width1 = math.max(v147, 1)
						local v148 = v_u_145.Brightness + 0.5
						v_u_145.Brightness = math.min(v148, 13)
						v_u_145.Enabled = false
						task.delay(math.random(50, v143) / 1000, function()
							-- upvalues: (copy) v_u_145
							v_u_145.Enabled = true
						end)
					end
					for _, v_u_149 in v_u_62 do
						if not v144[v_u_149] then
							v_u_102[v_u_149] = true
							task.delay(math.random(50, v143) / 1000, function()
								-- upvalues: (ref) v_u_102, (copy) v_u_149
								v_u_102[v_u_149] = nil
							end)
						end
					end
					for _, v_u_150 in v_u_57 do
						v_u_102[v_u_150] = true
						task.delay(math.random(50, v143) / 1000, function()
							-- upvalues: (ref) v_u_102, (copy) v_u_150
							v_u_102[v_u_150] = nil
						end)
					end
				end
				if v107 >= 25 and not v_u_59 then
					v_u_59 = true
					for _, v151 in v_u_51 do
						local v152 = v151.Rotate.Neon["1"]
						local v153 = v151.Rotate.Neon["2"]
						local v154 = v153:Clone()
						v154.Name = "CustomAttachment_1"
						v154.Parent = v151.Rotate.Neon
						v_u_14(v153, TweenInfo.new(5), {
							["Position"] = v153.Position + Vector3.new(15, 0, 0)
						})
						v_u_14(v154, TweenInfo.new(5), {
							["Position"] = v153.Position - Vector3.new(15, 0, 0)
						})
						local v155 = script.lightbeambig.Beams:Clone()
						for _, v156 in v155:GetChildren() do
							v156.Width0 = 0.5
							v156.Width1 = 1
							v156.Brightness = 13
							v156.Attachment0 = v152
							v156.Attachment1 = v154
							v156.Parent = v151.Rotate.Neon
							local v157 = v_u_56
							table.insert(v157, v156)
							local v158 = v_u_62
							table.insert(v158, v156)
						end
						v155:Destroy()
					end
				end
				if v107 >= 71 and not v_u_58 then
					v_u_20.enable(v_u_50)
					task.delay(5, function()
						-- upvalues: (ref) v_u_20, (ref) v_u_50
						v_u_20.disable(v_u_50)
					end)
					v_u_58 = true
					for _, v159 in v_u_51 do
						local v160 = v159.Rotate.Neon["1"]
						local v161 = v159.Rotate.Neon["2"]
						local v162 = v161.Position - Vector3.new(15, 0, 0)
						v_u_14(v161, TweenInfo.new(5), {
							["Position"] = v162
						})
						for v163 = -2, 2 do
							if v163 ~= 0 then
								local v164 = v161:Clone()
								v164.Name = ("CustomAttachment_%*"):format(v163)
								v164.Parent = v159.Rotate.Neon
								local v165 = v_u_14
								local v166 = TweenInfo.new(5)
								local v167 = {}
								local v168 = v163 * 30
								v167.Position = v162 + Vector3.new(v168, 0, 0)
								v165(v164, v166, v167)
								local v169 = script.lightbeambig.Beams:Clone()
								for _, v170 in v169:GetChildren() do
									v170.Width0 = 0.5
									v170.Width1 = 1
									v170.Brightness = 13
									v170.Attachment0 = v160
									v170.Attachment1 = v164
									v170.Parent = v159.Rotate.Neon
									local v171 = v_u_56
									table.insert(v171, v170)
									local v172 = v_u_62
									table.insert(v172, v170)
								end
								v169:Destroy()
							end
						end
					end
				end
				if (v110 >= 0.2 or v108) and v_u_98 <= 0 then
					v_u_98 = v108 and 0.2 or 0.1
					v_u_10:Fov((v110 - 0.2) * 15 + 70, 0.1)
				end
				debug.profileend()
			end))
		end)))
		for _, v173 in v48:GetDescendants() do
			if v173:IsA("BasePart") and v173.Name == "Neon" or v173:IsA("SpotLight") then
				table.insert(v_u_57, v173)
			elseif v173:IsA("ParticleEmitter") or v173:IsA("Beam") then
				table.insert(v_u_62, v173)
				if v173:IsA("ParticleEmitter") then
					v_u_60[v173] = v173.TimeScale
					table.insert(v_u_61, v173)
				end
			end
		end
		v_u_26:Add((v_u_39(10, 15, function(p174)
			-- upvalues: (ref) v_u_14, (copy) v_u_76, (copy) v_u_47
			v_u_14(v_u_76, TweenInfo.new(p174()), {
				["Value"] = v_u_47[1]
			})
		end)))
	end
	v_u_26:Add((v_u_39(0, 5, function(p176)
		-- upvalues: (ref) v_u_14, (copy) v_u_43, (copy) v_u_175, (ref) v_u_9, (ref) v_u_26
		v_u_14(v_u_43, TweenInfo.new(p176(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -1.2
		})
		task.delay(p176(), v_u_175)
		v_u_9:Run("ConcertEvent", "GrassRecolor")
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_9
			v_u_9:Stop("ConcertEvent", "GrassRecolor")
		end)
		v_u_9:Run("ConcertEvent", "WallRecolor")
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_9
			v_u_9:Stop("ConcertEvent", "WallRecolor")
		end)
		v_u_9:Run("ConcertEvent", "WallBottomRecolor")
		v_u_26:Add(function()
			-- upvalues: (ref) v_u_9
			v_u_9:Stop("ConcertEvent", "WallBottomRecolor")
		end)
	end)))
	v_u_26:Add((v_u_39(10, 15, function(p177)
		-- upvalues: (ref) v_u_14, (copy) v_u_43
		v_u_14(v_u_43, TweenInfo.new(p177(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -0.05
		})
	end)))
	local v178 = v_u_26
	local v179 = task.delay
	local v180 = v_u_28.startedAt + 24.5 - workspace:GetServerTimeNow()
	v178:Add(v179(math.max(v180, 0), function()
		-- upvalues: (ref) v_u_26, (ref) v_u_17, (ref) v_u_15, (ref) v_u_5, (ref) v_u_18, (ref) v_u_42, (ref) v_u_3, (copy) v_u_28, (ref) v_u_21
		v_u_26:Add(v_u_17.new())
		v_u_26:Add(v_u_15.observeCharacter(v_u_5.LocalPlayer, function(_, p_u_181)
			-- upvalues: (ref) v_u_18, (ref) v_u_42, (ref) v_u_3, (ref) v_u_28, (ref) v_u_21
			local v_u_182 = v_u_18.new()
			v_u_182:Add(task.spawn(function()
				-- upvalues: (copy) p_u_181, (ref) v_u_42, (copy) v_u_182, (ref) v_u_3, (ref) v_u_28, (ref) v_u_21
				local v_u_183 = p_u_181:WaitForChild("Humanoid")
				if v_u_183 then
					local v184 = v_u_183:WaitForChild("Animator")
					if v184 then
						local v_u_185 = v184:LoadAnimation(script.Dance)
						v_u_185.Priority = Enum.AnimationPriority.Action
						v_u_42 = v_u_185
						local v_u_186 = 0
						v_u_182:Add(v_u_3.PostSimulation:Connect(function(p187)
							-- upvalues: (ref) v_u_28, (copy) v_u_185, (copy) v_u_183, (ref) v_u_21, (ref) v_u_186
							debug.profilebegin("Concert:Player:Dance")
							workspace:GetServerTimeNow()
							local v188 = v_u_28.startedAt + 84.5 - workspace:GetServerTimeNow()
							if math.max(v188, 0) > 0 then
								if not v_u_185.IsPlaying then
									v_u_185:Play()
								end
								debug.profileend()
							else
								if v_u_183.MoveDirection == Vector3.new(0, 0, 0) and not v_u_21:GetAttribute("Stealing") then
									if v_u_186 < 3 then
										v_u_186 = v_u_186 + p187
									elseif not v_u_185.IsPlaying then
										v_u_185:Play()
									end
								else
									v_u_186 = 0
									if v_u_185.IsPlaying then
										v_u_185:Stop()
									end
								end
								debug.profileend()
							end
						end))
						v_u_182:Add(function()
							-- upvalues: (copy) v_u_185, (ref) v_u_42
							v_u_185:Stop()
							v_u_185:Destroy()
							v_u_42 = nil
						end)
					end
				else
					return
				end
			end))
			return v_u_182:WrapClean()
		end))
	end))
	v_u_13:Update()
	v_u_11:UpdateOST()
end
function v6.OnStop(_)
	-- upvalues: (copy) v_u_26, (ref) v_u_27
	v_u_26:Destroy()
	v_u_27 = nil
end
function v6.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_24
	task.spawn(function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_24, (ref) v_u_2
		v_u_7:WaitForAssetId("rbxassetid://122013252437083")
		v_u_24.SoundId = "rbxassetid://122013252437083"
		v_u_2:PreloadAsync({ v_u_24 })
	end)
end
return v6
