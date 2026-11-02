---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
local v_u_5 = game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EffectController)
local v_u_10 = require(v_u_1.Controllers.CameraController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
local v_u_12 = require(v_u_1.Controllers.EventController)
local v_u_13 = require(v_u_1.Controllers.CycleController)
local v_u_14 = require(v_u_1.Shared.SharedEventUtils)
local v_u_15 = require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_16 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_17 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v18 = require(v_u_1.Packages.Net)
local v_u_19 = require(v_u_1.Shared.VFX)
local v_u_20 = v_u_5.LocalPlayer
local v_u_21 = workspace.CurrentCamera
local v_u_22 = Color3.fromRGB(128, 255, 0)
local v_u_23 = Color3.fromRGB(0, 255, 0)
local v_u_24 = script.Name
local v_u_25 = workspace.Sounds.BrazilEvent
local v_u_26 = workspace.Events.Brazil.FullMapFloor
local v_u_27 = workspace.RenderedMovingAnimals
local v_u_28 = v18:RemoteEvent("EventService/Brazil/Focus")
local v_u_29 = v18:RemoteEvent("EventService/Brazil/Burst")
local v_u_30 = v_u_17.new()
local function v_u_34()
	-- upvalues: (copy) v_u_26
	local v31 = v_u_26.Position
	local v32 = v_u_26.Size.X * 0.5 * (math.random(0, 1) * 2 - 1)
	local v33 = v_u_26.Size.Z * 0.5 * (math.random(0, 1) * 2 - 1)
	return v31 + Vector3.new(v32, 0, v33)
end
local function v_u_38(p35)
	local v_u_36 = Instance.new("Attachment")
	v_u_36.Name = "Attachment"
	v_u_36.CFrame = CFrame.new(0, 3, 0)
	local v_u_37 = Instance.new("PointLight")
	v_u_37.Name = "PointLight"
	v_u_37.Brightness = 4
	v_u_37.Color = Color3.fromRGB(255, 157, 0)
	v_u_37.Range = 6
	v_u_37.Parent = v_u_36
	v_u_36.Parent = p35
	return function()
		-- upvalues: (copy) v_u_36, (copy) v_u_37
		v_u_36:Destroy()
		v_u_37:Destroy()
	end
end
function v6.OnStart(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_24, (copy) v_u_30, (copy) v_u_9, (copy) v_u_13, (copy) v_u_11, (copy) v_u_29, (copy) v_u_8, (copy) v_u_1, (copy) v_u_19, (copy) v_u_4, (copy) v_u_21, (copy) v_u_16, (copy) v_u_5, (copy) v_u_17, (copy) v_u_3, (copy) v_u_20, (copy) v_u_14, (copy) v_u_28, (copy) v_u_38, (copy) v_u_27, (copy) v_u_25, (copy) v_u_7, (copy) v_u_34, (copy) v_u_15, (copy) v_u_22, (copy) v_u_23, (copy) v_u_10
	local v_u_39 = v_u_12:GetActiveEventData(v_u_24)
	assert(v_u_39)
	local function v_u_50(p40, p_u_41, p_u_42)
		-- upvalues: (copy) v_u_39
		local function v_u_45()
			-- upvalues: (copy) p_u_41, (ref) v_u_39
			local v43 = p_u_41
			local v44 = v_u_39.startedAt + v43 - workspace:GetServerTimeNow()
			return math.max(v44, 0)
		end
		local function v46()
			-- upvalues: (copy) p_u_42, (copy) v_u_45
			p_u_42(v_u_45)
		end
		local v_u_47 = nil
		local v48 = v_u_39.startedAt + p40 - workspace:GetServerTimeNow()
		local v49 = math.max(v48, 0)
		if v49 > 0 then
			v_u_47 = task.delay(v49, v46)
		else
			p_u_42(v_u_45)
		end
		return function()
			-- upvalues: (ref) v_u_47
			if v_u_47 and coroutine.status(v_u_47) == "suspended" then
				pcall(task.cancel, v_u_47)
			end
		end
	end
	v_u_30:Add(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_13, (ref) v_u_11
		v_u_9:Activate("Blink")
		v_u_13:Update()
		v_u_11:UpdateOST()
	end)
	v_u_30:Add(v_u_29.OnClientEvent:Connect(function(p51)
		-- upvalues: (ref) v_u_8, (ref) v_u_11, (ref) v_u_1, (ref) v_u_19
		local v52 = v_u_8:GetAnimals()[p51]
		if v52 then
			local v53 = v52.AnimalModel
			local v54
			if v53.PrimaryPart then
				v54 = v53.PrimaryPart.CFrame
			else
				v54 = v53:GetPivot()
			end
			local v_u_55 = v54.Position
			task.spawn(function()
				-- upvalues: (ref) v_u_11, (ref) v_u_1, (copy) v_u_55
				v_u_11:PlaySound(v_u_1.Sounds.Events.Brazil.Hit, v_u_55)
			end)
			local v_u_56 = script.Burst:Clone()
			v_u_56:PivotTo(CFrame.new(v_u_55))
			v_u_56.Anchored = false
			local v57 = Instance.new("WeldConstraint")
			v57.Part0 = v_u_56
			v57.Part1 = v52.AnimalModel.PrimaryPart
			v57.Parent = v_u_56
			v_u_56.Parent = workspace
			v_u_19.emit(v_u_56)
			task.delay(5, function()
				-- upvalues: (copy) v_u_56
				v_u_56:Destroy()
			end)
		end
	end))
	local v_u_58 = v_u_4:FindFirstChild("Cartoon")
	if v_u_58 then
		v_u_58.Parent = v_u_1
		v_u_30:Add(function()
			-- upvalues: (copy) v_u_58, (ref) v_u_4
			v_u_58.Parent = v_u_4
		end)
	end
	local v_u_59 = v_u_30:Clone(Instance.new("ColorCorrectionEffect"))
	v_u_59.Parent = v_u_21
	local v_u_60 = nil
	local v_u_61 = v_u_30:Clone(script.Stage)
	local v_u_62 = v_u_30:Clone(script.VFX)
	local function v_u_109()
		-- upvalues: (copy) v_u_62, (ref) v_u_30, (ref) v_u_16, (ref) v_u_17, (ref) v_u_3, (ref) v_u_8, (ref) v_u_1, (ref) v_u_14, (ref) v_u_28
		local v_u_63 = {}
		local v_u_64 = {}
		local v_u_65 = {}
		for _, v66 in v_u_62.Square.Bottom:GetChildren() do
			if v66:IsA("Attachment") then
				v_u_63[v66] = v66.Position
				table.insert(v_u_64, v66)
			end
		end
		for _, v67 in v_u_62.Square.Top:GetChildren() do
			if v67:IsA("Attachment") then
				v_u_63[v67] = v67.Position
				table.insert(v_u_65, v67)
			end
		end
		local v_u_68 = Vector3.new(9, 9, 9)
		for _, v69 in v_u_64 do
			v69.Position = v_u_63[v69] * Vector3.new(1, 1, 1) * 9
		end
		for _, v70 in v_u_65 do
			v70.Position = v_u_63[v70] * Vector3.new(1, 1, 1) * 9
		end
		v_u_30:Add(v_u_16.observeTag("BrazilHitbox", function(p_u_71)
			-- upvalues: (ref) v_u_17, (ref) v_u_3, (ref) v_u_8, (ref) v_u_1, (ref) v_u_68, (copy) v_u_65, (copy) v_u_63, (copy) v_u_64, (ref) v_u_14, (ref) v_u_62, (ref) v_u_28
			local v72 = v_u_17.new()
			local v_u_73 = nil
			local v_u_74 = nil
			local v_u_75 = 0
			local v_u_76 = false
			v72:Add(v_u_3.PostSimulation:Connect(function(p77)
				-- upvalues: (copy) p_u_71, (ref) v_u_74, (ref) v_u_8, (ref) v_u_76, (ref) v_u_1, (ref) v_u_75, (ref) v_u_73, (ref) v_u_68, (ref) v_u_65, (ref) v_u_63, (ref) v_u_64, (ref) v_u_14, (ref) v_u_62
				debug.profilebegin("Brazil:Hitbox")
				local v78 = workspace:GetServerTimeNow()
				local v79 = p_u_71.CFrame
				local v80 = p_u_71:GetAttribute("Focused")
				local v81
				if v_u_74 and (v80 and v80 <= v78) then
					v81 = v_u_8:GetAnimals()[v_u_74]
				else
					v81 = nil
				end
				if v81 then
					if not v_u_76 then
						v_u_76 = true
						local v_u_82 = v_u_1.Sounds.Events.Brazil.Cube:Clone()
						v_u_82.Parent = p_u_71
						v_u_82:Play()
						v_u_82.Ended:Once(function()
							-- upvalues: (copy) v_u_82
							v_u_82:Destroy()
						end)
					end
					local v83 = (v78 - v80) / 1
					local v84 = math.clamp(v83, 0, 1)
					local v85 = (v78 - (v80 + 1)) / 1
					v_u_75 = math.clamp(v85, 0, 1)
					local v86 = v81.AnimalModel
					local v87 = v86:FindFirstChild("VfxInstance")
					local v88 = v81.Instance:GetPivot()
					local v89
					if v87 then
						v89 = v87.Size
					else
						v89 = v86:GetExtentsSize()
					end
					local v90 = (v89 * Vector3.new(1.25, 1.5, 1.25)):Min(Vector3.new(9, 18, 9))
					v79 = CFrame.new(v88.X, v79.Y, v88.Z)
					if not v_u_73 then
						v_u_73 = v_u_68
					end
					local v91 = v_u_73
					assert(v91)
					local v92 = v_u_73:Lerp(v90, v84)
					local v93 = v_u_73
					local v94 = v90.X
					local v95 = v90.Z
					local v96 = v93:Lerp(Vector3.new(v94, 0, v95), v84)
					v_u_68 = v92
					for _, v97 in v_u_65 do
						local v98 = v_u_63[v97]
						local v99 = v_u_75 * 1
						v97.Position = (v98 + Vector3.new(0, v99, 0)) * v92
					end
					for _, v100 in v_u_64 do
						v100.Position = v_u_63[v100] * v96
					end
				else
					if v_u_76 then
						v_u_76 = false
					end
					local v101 = -4 * p77
					local v102 = math.exp(v101)
					v_u_68 = (Vector3.new(9, 9, 9)):Lerp(v_u_68, v102)
					v_u_73 = v_u_68
					local v103 = v_u_75
					v_u_75 = math.lerp(0, v103, v102)
					for _, v104 in v_u_65 do
						local v105 = v_u_63[v104]
						local v106 = v_u_75 * 1
						v104.Position = (v105 + Vector3.new(0, v106, 0)) * v_u_68
					end
					for _, v107 in v_u_64 do
						v107.Position = v_u_63[v107] * v_u_68
					end
				end
				v_u_14.pushPartCFrame(v_u_62.Square, v79)
				debug.profileend()
			end))
			v72:Add(v_u_28.OnClientEvent:Connect(function(p108)
				-- upvalues: (ref) v_u_73, (ref) v_u_68, (ref) v_u_74
				v_u_73 = v_u_68
				v_u_74 = p108
			end))
			return v72:WrapClean()
		end, { workspace }))
	end
	local function v_u_116()
		-- upvalues: (ref) v_u_30, (ref) v_u_16, (ref) v_u_17, (ref) v_u_38, (ref) v_u_27
		v_u_30:Add(v_u_16.observeCharacters(function(_, p_u_110)
			-- upvalues: (ref) v_u_17, (ref) v_u_38
			local v_u_111 = v_u_17.new()
			v_u_111:Add(task.spawn(function()
				-- upvalues: (copy) p_u_110, (copy) v_u_111, (ref) v_u_38
				local v112 = p_u_110:WaitForChild("UpperTorso")
				if v112 then
					v_u_111:Add((v_u_38(v112)))
				end
			end))
			return v_u_111:WrapClean()
		end))
		v_u_30:Add(v_u_16.observeChildren(v_u_27, function(p_u_113)
			-- upvalues: (ref) v_u_17, (ref) v_u_38
			local v_u_114 = v_u_17.new()
			v_u_114:Add(task.spawn(function()
				-- upvalues: (copy) p_u_113, (copy) v_u_114, (ref) v_u_38
				local v115 = p_u_113:WaitForChild("RootPart")
				if v115 then
					v_u_114:Add((v_u_38(v115)))
				end
			end))
			return v_u_114:WrapClean()
		end))
	end
	local function v_u_196()
		-- upvalues: (ref) v_u_4, (ref) v_u_30, (ref) v_u_25, (ref) v_u_7, (copy) v_u_39, (copy) v_u_62, (copy) v_u_61, (ref) v_u_19, (copy) v_u_116, (copy) v_u_109, (ref) v_u_34, (ref) v_u_3, (ref) v_u_15, (ref) v_u_22, (ref) v_u_23, (ref) v_u_60, (ref) v_u_10, (copy) v_u_50, (ref) v_u_16
		v_u_4.Ambient = Color3.fromRGB(50, 50, 50)
		v_u_4.OutdoorAmbient = Color3.fromRGB(71, 71, 71)
		v_u_30:Add(function()
			-- upvalues: (ref) v_u_4
			v_u_4.Ambient = Color3.fromRGB(241, 241, 241)
			v_u_4.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
		end)
		v_u_30:Add(function()
			-- upvalues: (ref) v_u_25
			v_u_25:Stop()
		end)
		v_u_30:Add(task.spawn(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_25, (ref) v_u_39
			v_u_7:WaitForAssetId("rbxassetid://88307756942873")
			v_u_25.SoundId = ""
			v_u_25.SoundId = "rbxassetid://88307756942873"
			while not v_u_25.IsLoaded do
				task.wait()
			end
			v_u_25.TimePosition = workspace:GetServerTimeNow() - (v_u_39.startedAt + 5)
			v_u_25:Play()
		end))
		v_u_30:Clone(script.Night_Sky).Parent = v_u_4
		v_u_62.Parent = v_u_61
		v_u_19.disable(v_u_62)
		local v_u_117 = v_u_30:Add(Instance.new("Color3Value"))
		v_u_117.Value = Color3.fromRGB(0, 0, 0)
		local v_u_118 = v_u_30:Add(Instance.new("Color3Value"))
		v_u_118.Value = Color3.fromRGB(0, 0, 0)
		v_u_19.enable(v_u_62)
		v_u_19.disable(v_u_62.firestuff)
		v_u_116()
		v_u_109()
		local v_u_119 = {}
		local v_u_120 = {}
		local v_u_121 = {}
		local v_u_122 = {}
		local v_u_123 = {}
		local v_u_124 = 0
		local v_u_125 = 1
		local v_u_126 = 0
		for _, v127 in v_u_61:GetDescendants() do
			if v127:IsA("SpotLight") then
				table.insert(v_u_119, v127)
			elseif v127:IsA("ParticleEmitter") or v127:IsA("Beam") then
				if v127:IsDescendantOf(v_u_62.Square) or v127:IsDescendantOf(v_u_62.bigbeams) then
					table.insert(v_u_120, v127)
				else
					table.insert(v_u_123, v127)
				end
				if v127:IsA("ParticleEmitter") then
					v_u_121[v127] = v127.TimeScale
					table.insert(v_u_122, v127)
				end
			end
		end
		local v_u_128 = {}
		local v_u_129 = {}
		local v_u_130 = {}
		local v_u_131 = {}
		for _, v132 in v_u_62.initial:GetChildren() do
			local v133 = v132.att1
			v_u_128[v133] = v_u_34()
			v_u_129[v133] = v_u_34()
			v133.WorldCFrame = CFrame.new(v_u_129[v133])
			table.insert(v_u_130, v133)
			for _, v134 in v133:GetChildren() do
				table.insert(v_u_131, v134)
			end
		end
		local v_u_135 = {}
		local v_u_136 = {}
		local v_u_137 = {}
		for _, v138 in v_u_62.thinbeams:GetChildren() do
			local v139 = v138.att1
			v_u_128[v139] = v_u_34()
			v_u_129[v139] = v_u_34()
			v139.WorldCFrame = CFrame.new(v_u_129[v139])
			table.insert(v_u_135, v139)
			local v140 = {}
			for _, v141 in v139:GetChildren() do
				v141.Enabled = false
				table.insert(v140, v141)
			end
			v_u_136[v140] = v138.Position.Y
			table.insert(v_u_137, v140)
		end
		table.sort(v_u_137, function(p142, p143)
			-- upvalues: (copy) v_u_136
			return v_u_136[p142] < v_u_136[p143]
		end)
		local v_u_144 = false
		local v_u_145 = false
		local v_u_146 = 0
		v_u_30:Add(v_u_3.PostSimulation:Connect(function(p147)
			-- upvalues: (ref) v_u_126, (ref) v_u_124, (ref) v_u_25, (copy) v_u_122, (copy) v_u_121, (ref) v_u_146, (copy) v_u_128, (ref) v_u_34, (copy) v_u_135, (copy) v_u_130, (copy) v_u_129, (copy) v_u_137, (ref) v_u_144, (ref) v_u_19, (ref) v_u_62, (copy) v_u_131, (ref) v_u_145, (ref) v_u_39, (ref) v_u_125, (ref) v_u_15, (copy) v_u_117, (ref) v_u_22, (ref) v_u_23, (copy) v_u_118, (ref) v_u_60, (copy) v_u_123, (copy) v_u_120, (copy) v_u_119, (ref) v_u_10
			debug.profilebegin("Brazil:Update")
			local v148 = workspace:GetServerTimeNow()
			v_u_126 = v_u_126 - p147
			v_u_124 = v_u_124 - p147
			local v149 = v_u_25.TimePosition
			local v150 = v_u_25.PlaybackLoudness
			local v151 = v150 / 1000
			local v152 = math.clamp(v151, 0, 1)
			for _, v153 in v_u_122 do
				local v154 = v152 / 0.05
				v153.TimeScale = math.clamp(v154, 1, 2) * v_u_121[v153]
			end
			if v150 >= 320 and v148 - v_u_146 >= 2 then
				v_u_146 = v148
				for v155, _ in v_u_128 do
					v_u_128[v155] = v_u_34()
				end
			end
			for _, v156 in { v_u_135, v_u_130 } do
				for _, v157 in v156 do
					local v158 = v_u_129[v157]
					local v159 = v_u_128[v157]
					local v160 = v159 - v158
					local v161 = vector.magnitude(v160)
					local v162 = (v150 - 100) / 200
					local v163 = math.clamp(v162, 0, 1)
					local v164 = math.lerp(35, 120, v163) * p147
					if v161 < v164 then
						v_u_128[v157] = v_u_34()
					else
						v159 = v158 + vector.normalize(v160) * v164
					end
					v_u_129[v157] = v159
					v157.WorldCFrame = CFrame.new(v159)
				end
			end
			if v149 >= 17 then
				local v165 = (v149 - 17) // #v_u_137
				local v166 = math.max(v165, 2)
				if v149 >= 82 then
					v166 = v166 + 10
				end
				local v167 = #v_u_137
				for v168 = 1, math.min(v166, v167) do
					for _, v169 in v_u_137[v168] do
						v169.Enabled = true
					end
				end
			end
			if v149 >= 17 and not v_u_144 then
				v_u_19.enable(v_u_62.firestuff)
				task.delay(5.5, function()
					-- upvalues: (ref) v_u_19, (ref) v_u_62
					v_u_19.disable(v_u_62.firestuff)
				end)
				v_u_144 = true
				for _, v170 in v_u_131 do
					v170.Enabled = false
				end
			end
			if v149 >= 83 and not v_u_145 then
				v_u_145 = true
				v_u_19.enable(v_u_62.firestuff)
				task.delay(5.5, function()
					-- upvalues: (ref) v_u_19, (ref) v_u_62
					v_u_19.disable(v_u_62.firestuff)
				end)
			end
			if v152 >= 0.11 and v_u_124 <= 0 then
				local v171 = v_u_39.startedAt + 6 - workspace:GetServerTimeNow()
				if math.max(v171, 0) <= 0 then
					v_u_124 = 0.4
					v_u_125 = v_u_125 == 1 and 2 or 1
					local v172 = v_u_15
					local v173 = v_u_117
					local v174 = TweenInfo.new(0.2)
					local v175 = {}
					local v176
					if v_u_125 == 1 then
						v176 = v_u_22
					else
						v176 = v_u_23
					end
					v175.Value = v176
					v172(v173, v174, v175)
					local v177 = v_u_15
					local v178 = v_u_118
					local v179 = TweenInfo.new(0.2)
					local v180 = {}
					local v181
					if v_u_125 == 1 then
						v181 = v_u_23
					else
						v181 = v_u_22
					end
					v180.Value = v181
					v177(v178, v179, v180)
				end
			end
			if v_u_60 then
				local v182 = v_u_60
				local v183 = v152 / 0.07
				v182:AdjustSpeed((math.clamp(v183, 0.8, 1.5)))
			end
			local v184 = v_u_117.Value
			local v185 = v_u_118.Value
			local v186 = ColorSequence.new(v184)
			local v187 = ColorSequence.new(v185)
			for _, v188 in v_u_123 do
				v188.Color = v186
			end
			for _, v189 in v_u_120 do
				v189.Color = v187
			end
			for _, v190 in v_u_119 do
				v190.Color = v184
			end
			if v152 >= 0.1 and v_u_126 <= 0 then
				v_u_126 = 0.1
				v_u_10:Fov(v152 / 0.7 * 15 + 70, 0.1)
			end
			debug.profileend()
		end))
		v_u_30:Add((v_u_50(5, 6, function(p191)
			-- upvalues: (ref) v_u_15, (copy) v_u_117, (ref) v_u_22, (copy) v_u_118, (ref) v_u_23
			local v192 = {
				["Value"] = v_u_22
			}
			v_u_15(v_u_117, TweenInfo.new(p191()), v192)
			local v193 = {
				["Value"] = v_u_23
			}
			v_u_15(v_u_118, TweenInfo.new(p191()), v193)
		end)))
		v_u_61.Parent = workspace
		v_u_30:Add(v_u_16.observeTag("HideInBrazil", function(p_u_194)
			local v_u_195 = p_u_194.Parent
			p_u_194.Parent = script
			return function()
				-- upvalues: (copy) p_u_194, (copy) v_u_195
				pcall(function()
					-- upvalues: (ref) p_u_194, (ref) v_u_195
					p_u_194.Parent = v_u_195
				end)
			end
		end, { workspace, script }))
	end
	v_u_30:Add((v_u_50(0, 5, function(p197)
		-- upvalues: (ref) v_u_15, (copy) v_u_59, (ref) v_u_9, (ref) v_u_30, (copy) v_u_196, (copy) v_u_39
		v_u_15(v_u_59, TweenInfo.new(p197(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -1.2
		})
		v_u_9:Run("BrazilEvent", "GrassRecolor")
		v_u_30:Add(function()
			-- upvalues: (ref) v_u_9
			v_u_9:Stop("BrazilEvent", "GrassRecolor")
		end)
		v_u_30:Add(task.delay(p197(), function()
			-- upvalues: (ref) v_u_196, (ref) v_u_15, (ref) v_u_59, (ref) v_u_39
			v_u_196()
			local v198 = v_u_15
			local v199 = v_u_59
			local v200 = TweenInfo.new
			local v201 = v_u_39.startedAt + 6 - workspace:GetServerTimeNow()
			v198(v199, v200(math.max(v201, 0), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				["Brightness"] = 0
			})
		end))
	end)))
	local v202 = v_u_30
	local v203 = task.delay
	local v204 = v_u_39.startedAt + 20 - workspace:GetServerTimeNow()
	v202:Add(v203(math.max(v204, 0), function()
		-- upvalues: (ref) v_u_30, (ref) v_u_16, (ref) v_u_5, (ref) v_u_17, (ref) v_u_60, (ref) v_u_3, (copy) v_u_39, (ref) v_u_20
		v_u_30:Add(v_u_16.observeCharacter(v_u_5.LocalPlayer, function(_, p_u_205)
			-- upvalues: (ref) v_u_17, (ref) v_u_60, (ref) v_u_3, (ref) v_u_39, (ref) v_u_20
			local v_u_206 = v_u_17.new()
			v_u_206:Add(task.spawn(function()
				-- upvalues: (copy) p_u_205, (ref) v_u_60, (copy) v_u_206, (ref) v_u_3, (ref) v_u_39, (ref) v_u_20
				local v_u_207 = p_u_205:WaitForChild("Humanoid")
				if v_u_207 then
					local v208 = v_u_207:WaitForChild("Animator")
					if v208 then
						local v_u_209 = v208:LoadAnimation(script.Dance)
						v_u_209.Priority = Enum.AnimationPriority.Action
						v_u_60 = v_u_209
						local v_u_210 = 0
						v_u_206:Add(v_u_3.PostSimulation:Connect(function(p211)
							-- upvalues: (ref) v_u_39, (copy) v_u_209, (copy) v_u_207, (ref) v_u_20, (ref) v_u_210
							debug.profilebegin("Brazil:Player:Dance")
							workspace:GetServerTimeNow()
							local v212 = v_u_39.startedAt + 55 - workspace:GetServerTimeNow()
							if math.max(v212, 0) > 0 then
								if not v_u_209.IsPlaying then
									v_u_209:Play()
								end
								debug.profileend()
							else
								if v_u_207.MoveDirection ~= Vector3.new(0, 0, 0) or v_u_20:GetAttribute("Stealing") then
									v_u_210 = 0
									if v_u_209.IsPlaying then
										v_u_209:Stop()
									end
								elseif v_u_210 < 3 then
									v_u_210 = v_u_210 + p211
								elseif not v_u_209.IsPlaying then
									v_u_209:Play()
								end
								debug.profileend()
							end
						end))
						v_u_206:Add(function()
							-- upvalues: (copy) v_u_209, (ref) v_u_60
							v_u_209:Stop()
							v_u_209:Destroy()
							v_u_60 = nil
						end)
					end
				else
					return
				end
			end))
			return v_u_206:WrapClean()
		end))
	end))
	v_u_13:Update()
	v_u_11:UpdateOST()
end
function v6.OnStop(_)
	-- upvalues: (copy) v_u_30
	v_u_30:Destroy()
end
function v6.OnLoad(_)
	-- upvalues: (copy) v_u_2
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
end
return v6
