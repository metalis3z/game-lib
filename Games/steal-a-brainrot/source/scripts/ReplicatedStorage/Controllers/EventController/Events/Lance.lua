--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
local v5 = game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = require(v_u_1.Controllers.CycleController)
local v_u_13 = require(v_u_1.Shared.SharedEventUtils)
local v_u_14 = require(v_u_1.Packages.CreateTween)
local v_u_15 = require(v_u_1.Shared.TweenPivot)
local v_u_16 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_17 = require(v_u_1.Packages.Timer)
local v18 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_19 = require(v_u_1.Packages.Spr)
local v20 = require(v_u_1.Packages.Net)
local v_u_21 = require(v_u_1.Shared.VFX)
local v_u_22 = v5.LocalPlayer
local v_u_23 = workspace.CurrentCamera
local v_u_24 = script.Name
local v_u_25 = { workspace.Sounds.LanceEvent1, workspace.Sounds.LanceEvent2 }
local v_u_26 = v20:RemoteEvent((("EventService/%*/Burst"):format(v_u_24)))
local _ = workspace.RenderedMovingAnimals
local v_u_27 = v18.new()

-- ===================== HELPER: chargement son robuste =====================
local function loadSoundSafe(trove, encController, assetId, soundObj, startTime, maxDuration, volume)
	trove:Add(task.spawn(function()
		-- Étape 1 : WaitForAssetId avec timeout + pcall
		local encOk = false
		task.spawn(function()
			local ok, err = pcall(function()
				encController:WaitForAssetId(assetId)
			end)
			if ok then
				encOk = true
			else
				warn("[LanceEvent] WaitForAssetId échoué :", err, assetId)
			end
		end)
		local e1 = 0
		while not encOk and e1 < 10 do
			task.wait(0.1)
			e1 += 0.1
		end
		if not encOk then
			warn("[LanceEvent] WaitForAssetId timeout pour", assetId, "- tentative quand même")
		end

		-- Étape 2 : assigner le SoundId proprement
		soundObj.SoundId = ""
		task.wait()
		soundObj.SoundId = assetId

		-- Étape 3 : attendre chargement avec timeout
		local e2 = 0
		while not soundObj.IsLoaded and e2 < 15 do
			task.wait(0.1)
			e2 += 0.1
		end
		if not soundObj.IsLoaded then
			warn("[LanceEvent] Son non chargé après 15s :", assetId)
			return
		end

		-- Étape 4 : calculer position temporelle
		local timePos = workspace:GetServerTimeNow() - startTime
		if timePos >= maxDuration then
			warn("[LanceEvent] Trop tard pour jouer le son :", assetId, "timePos =", timePos)
			return
		end

		soundObj.TimePosition = math.max(timePos, 0)
		soundObj.Volume = volume
		soundObj:Play()
		warn("[LanceEvent] Son lancé :", assetId, "à TimePosition =", soundObj.TimePosition)

		trove:Add(function()
			soundObj:Stop()
		end)
	end))
end
-- =========================================================================

function v6.OnStart(_)
	local v_u_28 = v_u_11:GetActiveEventData(v_u_24)
	assert(v_u_28)
	local function v39(p29, p_u_30, p_u_31)
		local function v_u_34()
			local v32 = p_u_30
			local v33 = v_u_28.startedAt + v32 - workspace:GetServerTimeNow()
			return math.max(v33, 0)
		end
		local function v35()
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
			if v_u_36 and coroutine.status(v_u_36) == "suspended" then
				pcall(task.cancel, v_u_36)
			end
		end
	end
	local function v_u_44(p40, p41, ...)
		local v42 = v_u_28.startedAt + p40 - workspace:GetServerTimeNow()
		local v43 = math.max(v42, 0)
		if v43 <= 0 then
			v_u_27:Add(task.spawn(p41, ...))
		else
			v_u_27:Add(task.delay(v43, p41, ...))
		end
	end
	v_u_27:Add(function()
		v_u_9:Activate("Blink")
		v_u_12:Update()
		v_u_10:UpdateOST()
	end)
	v_u_27:Add(v_u_26.OnClientEvent:Connect(function(p45)
		local v46 = v_u_8:GetAnimals()[p45]
		if v46 then
			local v47 = v46.AnimalModel
			local v48
			if v47.PrimaryPart then
				v48 = v47.PrimaryPart.CFrame
			else
				v48 = v47:GetPivot()
			end
			local v_u_49 = v48.Position
			task.spawn(function()
				v_u_10:PlaySound(v_u_1.Sounds.Events.Lance.Hit, v_u_49)
			end)
			local v_u_50 = script.Burst:Clone()
			v_u_50:PivotTo(CFrame.new(v_u_49))
			v_u_50.Anchored = false
			local v51 = Instance.new("WeldConstraint")
			v51.Part0 = v_u_50
			v51.Part1 = v46.AnimalModel.PrimaryPart
			v51.Parent = v_u_50
			v_u_50.Parent = workspace
			v_u_21.emit(v_u_50)
			task.delay(5, function()
				v_u_50:Destroy()
			end)
		end
	end))
	local v_u_52 = v_u_4:FindFirstChild("Cartoon")
	if v_u_52 then
		v_u_52.Parent = v_u_1
		v_u_27:Add(function()
			v_u_52.Parent = v_u_4
		end)
	end
	local v_u_53 = v_u_27:Clone(Instance.new("ColorCorrectionEffect"))
	v_u_53.Parent = v_u_23
	local v_u_54 = v_u_27:Clone(script.Stage)
	local v_u_55 = require(v_u_54.Stage.LightSequences)
	local v_u_56 = require(v_u_54.Stage.StageRotate)
	local v_u_57 = Color3.fromRGB(255, 245, 192)
	local v_u_58 = Color3.fromRGB(195, 128, 89)
	local v_u_59 = Color3.fromRGB(90, 192, 217)
	local v_u_60 = Color3.fromRGB(186, 0, 0)
	local v_u_61 = Color3.fromRGB(0, 0, 0)
	local function v_u_71(p62, p_u_63)
		local v_u_64 = {}
		local v_u_70 = v_u_27:Add(v_u_16.observeTag(p62, function(p_u_65)
			local v66 = v_u_64
			table.insert(v66, p_u_65)
			local v_u_67 = p_u_63(p_u_65)
			return function()
				local v68 = table.find(v_u_64, p_u_65)
				if v68 then
					table.remove(v_u_64, v68)
				end
				local v69 = v_u_67
				if typeof(v69) == "function" then
					v_u_67()
				end
			end
		end))
		return v_u_64, function()
			v_u_27:Remove(v_u_70)
		end
	end
	local v_u_72 = v_u_61
	local v_u_74 = v_u_71("LanceStageLight", function(p73)
		p73.Color = v_u_72
		return nil
	end)
	local v_u_76 = v_u_71("LanceTargetLight", function(p75)
		if (v_u_72.R > 0.0392156862745098 or v_u_72.G > 0.0392156862745098) and true or v_u_72.B > 0.0392156862745098 then
			p75.Color = v_u_72
		end
		return nil
	end)
	local v_u_77 = v_u_54.Pavillion.Lights:GetChildren()
	local v_u_78 = v_u_72
	local v_u_79 = {}
	local v_u_80 = true
	for _, v81 in v_u_54.Lights:GetDescendants() do
		if v81:IsA("SpotLight") then
			table.insert(v_u_77, v81)
		end
	end
	local function v_u_87(p82)
		v_u_78 = p82
		for _, v83 in v_u_74 do
			v_u_19.target(v83, 1, 7, {
				["Color"] = p82
			})
		end
		if v_u_80 then
			for _, v84 in v_u_79 do
				v_u_19.target(v84, 1, 7, {
					["Color"] = p82
				})
			end
		end
		if (v_u_78.R > 0.0392156862745098 or v_u_78.G > 0.0392156862745098) and true or v_u_78.B > 0.0392156862745098 then
			for _, v85 in v_u_76 do
				v_u_19.target(v85, 1, 7, {
					["Color"] = p82
				})
			end
		end
		for _, v86 in v_u_77 do
			v_u_19.target(v86, 1, 7, {
				["Color"] = p82
			})
		end
	end
	local v_u_88 = Random.new()
	local function v_u_104(p89)
		v_u_78 = p89
		for _, v90 in v_u_74 do
			v_u_19.target(v90, 1, 7, {
				["Color"] = p89
			})
		end
		if (v_u_78.R > 0.0392156862745098 or v_u_78.G > 0.0392156862745098) and true or v_u_78.B > 0.0392156862745098 then
			for _, v91 in v_u_76 do
				v_u_19.target(v91, 1, 7, {
					["Color"] = p89
				})
			end
		end
		for v92 = 1, v_u_88:NextInteger(1, #v_u_77) do
			local v93 = v_u_88:NextInteger(1, #v_u_77)
			local v94 = v_u_77
			local v95 = v_u_77
			local v96 = v_u_77[v93]
			local v97 = v_u_77[v92]
			v94[v92] = v96
			v95[v93] = v97
			v_u_19.target(v_u_77[v92], 1, 7, {
				["Color"] = p89
			})
		end
		if v_u_80 then
			for v98 = 1, v_u_88:NextInteger(1, #v_u_79) do
				local v99 = v_u_88:NextInteger(1, #v_u_79)
				local v100 = v_u_79
				local v101 = v_u_79
				local v102 = v_u_79[v99]
				local v103 = v_u_79[v98]
				v100[v98] = v102
				v101[v99] = v103
				v_u_19.target(v_u_79[v98], 1, 7, {
					["Color"] = p89
				})
			end
		end
	end
	local v_u_112 = {
		["CRAZY_SEQUENCE"] = function()
			local v_u_105 = { Color3.fromRGB(218, 173, 145), Color3.fromRGB(255, 167, 116), (Color3.fromRGB(90, 180, 90)) }
			local v_u_106 = Random.new()
			local v_u_107 = v_u_17.Simple(0.15, function()
				v_u_104(v_u_105[v_u_106:NextInteger(1, #v_u_105)])
			end, true)
			return function()
				v_u_107:Disconnect()
			end
		end,
		["EXTRA_CRAZY_SEQUENCE"] = function()
			local v108 = Color3.fromRGB(223, 146, 101)
			local v_u_109 = { Color3.fromRGB(40, 93, 180), Color3.fromRGB(255, 0, 0), v108 }
			local v_u_110 = Random.new()
			local v_u_111 = v_u_17.Simple(0.15, function()
				v_u_104(v_u_109[v_u_110:NextInteger(1, #v_u_109)])
			end, true)
			return function()
				v_u_111:Disconnect()
			end
		end
	}
	local v_u_113 = nil
	local function v_u_115(p114)
		if v_u_113 then
			v_u_27:Remove(v_u_113)
			v_u_113 = nil
		end
		if v_u_112[p114] then
			v_u_113 = v_u_27:Add(v_u_112[p114]())
		else
			v_u_87(p114)
		end
	end
	local v_u_116 = 1
	local function v_u_133(p117, p_u_118, p_u_119, p_u_120)
		for _, v121 in p_u_118 do
			v121.Looped = true
			v121.Name = v121.Animation.Name
			v121:AdjustWeight(0.01)
		end
		local v_u_122 = {}
		for _, v123 in p_u_118 do
			if v123.Animation then
				local v124 = v_u_13.loadAnimation(v_u_27, p117, v123.Animation)
				v124.Name = v123.Animation.Name .. "Copy"
				v124.Looped = true
				v124:AdjustWeight(0.01)
				v_u_122[v123] = v124
				v_u_122[v124] = v123
			end
		end
		local v_u_125 = nil
		local v_u_126 = nil
		return {
			["setPlayingTrack"] = function(p_u_127)
				if v_u_125 then
					pcall(task.cancel, v_u_125)
					v_u_125 = nil
				end
				if v_u_126 then
					v_u_126:AdjustWeight(0.01, 0.4)
					v_u_126 = nil
				end
				v_u_126 = p_u_127
				for _, v128 in p_u_118 do
					if v128 == p_u_127 then
						if not v128.IsPlaying then
							v128:Play(0.1, 0.01, v_u_116)
						end
						v128:AdjustWeight(1, 0.25)
						if v_u_122[v128] then
							v_u_122[v128]:AdjustWeight(0.01, 0.4)
						end
					elseif v128.IsPlaying then
						v128:AdjustWeight(0.01, 0.4)
						if v_u_122[v128] then
							v_u_122[v128]:AdjustWeight(0.01, 0.4)
						end
					end
				end
				v_u_125 = task.spawn(function()
					local v129 = p_u_127
					if not v129 or p_u_119[v129] then
						return
					end
					local v130 = p_u_127
					assert(v130)
					local v131 = p_u_120[p_u_127]
					if not v131 then
						v131 = p_u_120[v_u_122[p_u_127]]
						if not v131 then
							v131 = 1.1
						end
					end
					while true do
						if not v129.IsPlaying then
							v129:Play(0, 0.01, v_u_116)
						end
						local v132 = v_u_122[v129]
						if not v132.IsPlaying then
							v132:Play(0, 0.01, v_u_116)
						end
						v_u_126 = v129
						v129.TimePosition = 0
						v129:AdjustWeight(1, 0.3)
						v132:AdjustWeight(0, 0.3)
						task.wait((v129.Length or v131 + 0.5) - v131)
						v132.TimePosition = v129.TimePosition
						v129:AdjustWeight(0.01, 0.4)
						v132:AdjustWeight(1, 0.4)
						v129 = v132
					end
				end)
			end,
			["trackPointers"] = v_u_122,
			["tracks"] = p_u_118
		}
	end
	local function v_u_446()
		local v_u_134 = v_u_44
		local function v137(p135, p136, ...)
			return v_u_134(p135 + 220.5, p136, ...)
		end
		v_u_27:Add(function()
			v_u_25[1]:Stop()
			v_u_25[2]:Stop()
		end)

		-- ==================== FIX SON 2 (Heaven - Locked Out) ====================
		-- Son 2 : rbxassetid://74828828901820, commence à startedAt + 220.5, durée max ~228s
		loadSoundSafe(v_u_27, v_u_7, "rbxassetid://78832211240703", v_u_25[2], v_u_28.startedAt + 220.5, 228, 0.25)
		-- ==================== FIN FIX SON 2 ====================

		local v139 = v_u_61
		if v_u_113 then
			v_u_27:Remove(v_u_113)
			v_u_113 = nil
		end
		if v_u_112[v139] then
			v_u_113 = v_u_27:Add(v_u_112[v139]())
		else
			v_u_87(v139)
		end
		local v140 = v_u_27:Clone(script.SpotLights)
		v_u_21.disable(v140)
		v140.Parent = v_u_54
		local v_u_141 = {}
		local v_u_142 = {}
		local v_u_143 = {}
		for _, v144 in v140:GetChildren() do
			local v145
			if v144:GetAttribute("Outside") then
				v145 = v_u_141
			else
				v145 = v_u_143
			end
			local v146 = {
				["model"] = v144,
				["beam"] = v144.Rotate.Neon["1"].LightBeam,
				["light"] = v144.Rotate.Neon.LightSource.SpotLight,
				["neon"] = v144.Rotate.Neon,
				["pivot"] = v144.Rotate:GetPivot(),
				["side"] = v144:GetAttribute("Side"),
				["beams"] = {}
			}
			table.insert(v145, v146)
			table.insert(v_u_142, v146)
		end
		v_u_54.Pavillion.Marquee.NowPlayingSign.Gui:FindFirstChild("Text").Text = "NOW PLAYING... <br /> LOCKED OUT OF HEAVEN"
		v_u_25[2]:Play()
		local v147 = v_u_54.Stage.Rotate.Heaven.MainLance
		v147.Parent = v_u_54.Stage
		v147:PivotTo(v_u_54.Stage.HeavenMainLancePivot:GetPivot())
		v_u_15(v147, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v147:GetPivot() + Vector3.new(0, 22, 0)):Play()
		local v148 = v_u_13.loadAnimation(v_u_27, v147.Humanoid.Animator, script.Lance2_1)
		local v149 = v_u_13.loadAnimation(v_u_27, v147.Humanoid.Animator, script.Lance2_3)
		local v150 = v_u_13.loadAnimation(v_u_27, v147.Humanoid.Animator, script.Lance2_4)
		local v151 = v_u_13.loadAnimation(v_u_27, v147.Humanoid.Animator, script.Lance2_4_Loop)
		local v_u_152 = v_u_133(v147.Humanoid.Animator, {
			v148,
			v149,
			v150,
			v151
		}, {
			[v148] = true,
			[v149] = true,
			[v150] = true,
			[v151] = true
		}, {})
		local v_u_153 = v_u_152.tracks
		local v_u_154 = { Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 139, 6) }
		local v_u_155 = { Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 158, 105) }
		local v_u_156 = { Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 255, 0) }
		local v_u_157 = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0) }
		local v_u_158 = { ColorSequence.new(v_u_157[1]), ColorSequence.new(v_u_157[2]) }
		local v_u_159 = v_u_54.Stage.HeavenBackwalls
		local v_u_160 = 7
		local v_u_161 = 9
		local v_u_162 = 1
		local v_u_164 = v_u_71("LanceFogLightColor", function(p163)
			p163.Color = v_u_78
			return nil
		end)
		local v_u_166 = v_u_71("LanceTargetLight", function(p165)
			p165.Color = v_u_78
			return nil
		end)
		local function v168(p167)
			v_u_162 = p167
		end
		local v_u_169 = v_u_54.Pavillion.Lights:GetChildren()
		local v_u_170 = v_u_162
		local v_u_171 = 0
		local v_u_172 = 0
		for _, v173 in v_u_54.Lights:GetDescendants() do
			if v173:IsA("SpotLight") then
				table.insert(v_u_169, v173)
			end
		end
		local v_u_174 = false
		local v_u_175 = true
		local v_u_176 = false
		local function v_u_197()
			v_u_171 = v_u_171 % #v_u_154 + 1
			local v177 = v_u_171
			local v178 = v_u_154[v177]
			local v179 = v177 % #v_u_154 + 1
			local v180 = v_u_154[v179]
			v_u_19.target(v_u_159.NeonDeepYellow, 1, v_u_160, {
				["Color"] = v178
			})
			v_u_19.target(v_u_159.NeonRed, 1, v_u_160, {
				["Color"] = v180
			})
			v_u_19.target(v_u_159.NeonYellow, 1, v_u_160, {
				["Color"] = v_u_155[v_u_171]
			})
			local v181 = v_u_156[v_u_171]
			for _, v182 in v_u_164 do
				v_u_19.target(v182, 1, v_u_160, {
					["Color"] = v181
				})
			end
			if v_u_80 then
				for _, v183 in v_u_79 do
					v_u_19.target(v183, 1, v_u_160, {
						["Color"] = v181
					})
				end
			end
			for _, v184 in v_u_166 do
				v_u_19.target(v184, 1, v_u_160, {
					["Color"] = v181
				})
			end
			for _, v185 in v_u_169 do
				local v186 = v_u_19.target
				local v187 = 1
				local v188 = v_u_160
				local v189 = {}
				local v190
				if v_u_88:NextInteger(1, 2) == 1 then
					v190 = v181
				else
					v190 = v_u_156[v179]
				end
				v189.Color = v190
				v186(v185, v187, v188, v189)
			end
			v_u_174 = not v_u_174
			for _, v191 in v_u_142 do
				local v192 = not v191.model:GetAttribute("Outside")
				if not (v_u_175 and v192 or v_u_176 and v192) then
					local v193 = v_u_88:NextInteger(1, 2)
					local v194
					if v193 == 1 then
						v194 = v_u_157[v_u_171]
					else
						v194 = v_u_157[v179]
					end
					local v195
					if v193 == 1 then
						v195 = v_u_158[v177]
					else
						v195 = v_u_158[v179]
					end
					v_u_19.target(v191.neon, 1, v_u_161, {
						["Color"] = v194
					})
					v_u_19.target(v191.light, 1, v_u_161, {
						["Color"] = v194
					})
					v_u_19.target(v191.beam, 1, v_u_161, {
						["Color"] = v195
					})
					for _, v196 in v191.beams do
						v196.beam.Enabled = v_u_174
						v_u_19.target(v196.beam, 1, v_u_161, {
							["Color"] = v195
						})
					end
				end
			end
			v_u_172 = 0
		end
		local v_u_199 = v_u_27:Add(v_u_3.PostSimulation:Connect(function(p198)
			v_u_172 = v_u_172 + p198
			if v_u_170 <= v_u_172 then
				v_u_197()
			end
		end))
		local v_u_200 = 0
		local function v241(p201)
			if p201 == 0 then
				local v202 = v_u_200
				local v203
				if v202 == 1 then
					v203 = v202 - 1
				else
					local v204 = v202 / 2
					v203 = math.floor(v204)
					local v205 = v202 / 2
					v202 = math.ceil(v205)
				end
				v_u_200 = p201
				for _, v206 in v_u_143 do
					for v207 = -v203, v202 do
						local v_u_208 = v206.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(v207)))
						if v_u_208 then
							for _, v209 in v_u_208:GetChildren() do
								local v210 = table.find(v206.beams, v209)
								if v210 then
									table.remove(v206.beams, v210)
								end
								v_u_19.target(v209, 0.9, 5, {
									["Width0"] = 0,
									["Width1"] = 0
								})
							end
							task.delay(1, function()
								v_u_208:Destroy()
							end)
						end
					end
				end
			else
				local v211, v212
				if p201 == 1 then
					v211 = p201 - 1
					v212 = p201
				else
					local v213 = p201 / 2
					v211 = math.floor(v213)
					local v214 = p201 / 2
					v212 = math.ceil(v214)
				end
				local v215 = v_u_200
				local v216, v217
				if v215 == 1 then
					v216 = v215 - 1
					v217 = v215
				else
					local v218 = v215 / 2
					v216 = math.floor(v218)
					local v219 = v215 / 2
					v217 = math.ceil(v219)
				end
				if v215 ~= 0 then
					for v220 = -v216, v217 do
						if -v211 > v220 or v220 > v212 then
							for _, v221 in v_u_143 do
								local v_u_222 = v221.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(v220)))
								if v_u_222 then
									for _, v223 in v_u_222:GetChildren() do
										local v224 = table.find(v221.beams, v223)
										if v224 then
											table.remove(v221.beams, v224)
										end
										v_u_19.target(v223, 0.9, 5, {
											["Width0"] = 0,
											["Width1"] = 0
										})
									end
									task.delay(1, function()
										v_u_222:Destroy()
									end)
								end
							end
						end
					end
				end
				v_u_200 = p201
				for _, v225 in v_u_143 do
					local v226 = v225.model.Rotate.Neon["1"]
					local v227 = v225.model.Rotate.Neon["2"]
					local v228 = v227.Position - Vector3.new(7.5, 0, 0)
					for v229 = -v211, v212 do
						if not v225.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(v229))) then
							local v230 = v227:Clone()
							v230.Name = ("CustomAttachment_%*"):format(v229)
							if v215 ~= 0 then
								local v231
								if v229 < 0 then
									v231 = -v216
								else
									v231 = v217
								end
								local v232 = v231 * 15
								v230.Position = v228 + Vector3.new(v232, 0, 0)
							end
							v230.Parent = v225.model.Rotate.Neon
							local v233 = v_u_19.target
							local v234 = {}
							local v235 = v229 * 15
							v234.Position = v228 + Vector3.new(v235, 0, 0)
							v233(v230, 0.9, 5, v234)
							local v236 = script.lightbeambig.Beams:Clone()
							for _, v237 in v236:GetChildren() do
								v237.Color = v225.beam.Color
								v237.Width0 = 0.25
								v237.Width1 = 0.5
								v237.Brightness = 13
								v237.Attachment0 = v226
								v237.Attachment1 = v230
								v237.Parent = v225.model.Rotate.Neon
								local v238 = v225.beams
								local v239 = {
									["beam"] = v237,
									["attachment"] = v230,
									["defaultPosition"] = v228
								}
								local v240 = v229 * 15
								v239.targetPosition = v228 + Vector3.new(v240, 0, 0)
								v239.index = v229
								table.insert(v238, v239)
							end
							v236:Destroy()
						end
					end
				end
			end
		end
		local function v_u_246(p242)
			local v243 = ColorSequence.new(p242)
			for _, v244 in v_u_143 do
				v_u_19.target(v244.neon, 1, v_u_161, {
					["Color"] = p242
				})
				v_u_19.target(v244.light, 1, v_u_161, {
					["Color"] = p242
				})
				v_u_19.target(v244.beam, 1, v_u_161, {
					["Color"] = v243
				})
				for _, v245 in v244.beams do
					v_u_19.target(v245.beam, 1, v_u_161, {
						["Color"] = v243
					})
				end
			end
		end
		local v_u_247 = table.create(#v_u_143, 0)
		local v_u_248 = table.create(#v_u_143, 0.8796459430051422)
		local v_u_249 = Random.new()
		local v_u_250 = table.create(#v_u_143, 0)
		local v_u_251 = v_u_176
		local v_u_252 = v_u_175
		local v253 = 0
		local v254 = 0
		local v_u_255 = false
		local v_u_256 = false
		local v_u_257 = -1
		local v_u_258 = {
			49.9,
			129.6,
			163,
			176.8
		}
		local v_u_259 = {
			6.91,
			13.44,
			20.14,
			26.92,
			33.64,
			40.21,
			86.85,
			93.55,
			100.31,
			106.94,
			113.54,
			120.23,
			220.33,
			226.84
		}
		local v_u_260 = 0
		local function v_u_264(p261)
			for _, v262 in v_u_143 do
				v262.light.Enabled = p261
				v262.beam.Enabled = p261
				for _, v263 in v262.beams do
					v263.beam.Enabled = p261
				end
			end
		end
		local function v_u_269()
			for v265, v266 in v_u_143 do
				local v267 = v_u_249:NextNumber(-0.6911503837897545, 0.6911503837897545) * v266.side
				local v268 = v_u_249:NextNumber(0.6911503837897545, 1.0681415022205298)
				v_u_247[v265] = v267
				v_u_248[v265] = v268
			end
		end
		for _, v270 in v_u_143 do
			v253 = v253 + v270.pivot.Position.Z
			v254 = v254 + 1
		end
		if v254 > 0 then
			v253 = v253 / v254
		end
		for v271, v272 in v_u_143 do
			local v273 = v253 < v272.pivot.Position.Z
			local v274 = ((not v273 or v272.side ~= -1) and true or false) and not v273
			if v274 then
				v274 = v272.side == 1
			end
			v_u_250[v271] = v274 and 0 or 1.5707963267948966
		end
		local function v_u_285(p275, _, p276)
			for v277, v278 in v_u_143 do
				local v279 = p275 + v_u_250[v277]
				local v280 = math.sin(v279)
				local v281 = v279 * 2
				local v282 = math.sin(v281)
				local v283 = v280 * 3.141592653589793 * 0.13 * v278.side + -v278.side * 0.15707963267948966
				local v284 = 3.141592653589793 * (p276 * 0.05 * v282 + 0.225)
				v278.model.Rotate:PivotTo(v278.pivot * CFrame.Angles(v284, v283, 0))
			end
		end
		local v_u_286 = nil
		local v_u_287 = nil
		task.spawn(function()
			if v_u_3:IsStudio() then
				local v288 = v_u_22:WaitForChild("PlayerGui")
				v_u_286 = Instance.new("ScreenGui")
				v_u_286.ResetOnSpawn = false
				v_u_286.IgnoreGuiInset = true
				v_u_287 = Instance.new("TextLabel")
				v_u_287.AnchorPoint = Vector2.new(0.5, 1)
				v_u_287.Position = UDim2.new(0.5, 0, 1, 0)
				v_u_287.Size = UDim2.new(0.25, 0, 0, 25)
				v_u_287.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				v_u_287.BackgroundTransparency = 0.35
				v_u_287.BorderSizePixel = 0
				v_u_287.TextColor3 = Color3.fromRGB(255, 255, 255)
				v_u_287.TextStrokeTransparency = 0.6
				v_u_287.TextSize = 16
				v_u_287.Font = Enum.Font.BuilderSansMedium
				v_u_287.TextXAlignment = Enum.TextXAlignment.Left
				v_u_287.TextYAlignment = Enum.TextYAlignment.Center
				v_u_287.Text = ""
				v_u_287.Parent = v_u_286
				local v289 = Instance.new("UIPadding")
				v289.PaddingLeft = UDim.new(0, 10)
				v289.PaddingRight = UDim.new(0, 10)
				v289.Parent = v_u_287
				v_u_286.Parent = v288
				v_u_27:Add(v_u_286)
			end
		end)
		local v_u_290 = 0
		local v_u_291 = 0
		local v_u_292 = false
		local v_u_293 = 0
		local v_u_294 = 0
		local v_u_295 = 0
		v_u_27:Add(v_u_3.PostSimulation:Connect(function(p296)
			local v297 = v_u_25[2].TimePosition
			local v298 = v_u_25[2].PlaybackLoudness / 750
			local v299 = math.clamp(v298, 0, 1)
			local v300, v302
			if v297 < 5 then
				v300 = 0
				v302 = 0
			elseif v297 < 45 then
				v300 = 1
				v302 = 5
			else
				for _, v302 in v_u_258 do
					if v302 <= v297 and v297 < v302 + 7.1 then
					end
				end
				v302 = nil
				if v302 then
					v300 = 2
				else
					v302 = v_u_258[1] + 7.1
					if v302 <= v297 and v297 < 85 then
						v300 = 3
					elseif v297 < 86 then
						v300 = 0
						v302 = 85
					elseif v297 < 123 then
						v300 = 1
						v302 = 86
					else
						v302 = v_u_258[2] + 7.1
						if v302 <= v297 and v297 < 162 then
							v300 = 3
						elseif v297 < 187 then
							v300 = 0
							v302 = 162
						else
							v300 = 4
							v302 = 187
						end
					end
				end
			end
			if v300 ~= v_u_290 then
				v_u_290 = v300
				v_u_291 = v302
				v_u_252 = v_u_290 ~= 4
				if v_u_290 == 0 then
					v_u_246(v_u_61)
					v_u_264(false)
					v_u_292 = false
					v_u_256 = false
				elseif v_u_290 == 1 then
					v_u_246(v_u_157[1])
					v_u_264(false)
					v_u_256 = false
				elseif v_u_290 == 2 then
					v_u_246(v_u_157[2])
					v_u_264(true)
					v_u_292 = true
				elseif v_u_290 == 3 then
					v_u_246(v_u_157[2])
					v_u_264(true)
					v_u_257 = -1
				elseif v_u_290 == 4 then
					v_u_264(true)
				end
			end
			v_u_295 = v_u_295 + p296
			if v_u_287 and v_u_295 >= 0.1 then
				v_u_295 = v_u_295 - 0.1
				local v303 = ""
				local v304
				if v_u_290 == 0 then
					v304 = "OFF"
				elseif v_u_290 == 1 then
					v304 = v_u_256 and "Red sweep" or "RED - Off"
				else
					v304 = v_u_290 == 2 and "YELLOW - pan" or (v_u_290 == 3 and "YELLOW - beat flash" or (v_u_290 == 4 and "Figure8" or v303))
				end
				local v305 = v297 / 60
				local v306 = math.floor(v305)
				local v307 = v297 - v306 * 60
				v_u_287.Text = string.format("%s  |  %s", string.format("%d:%05.2f", v306, v307), v304)
			end
			v_u_293 = v_u_293 + p296 * (1 / v_u_170)
			local v308 = v_u_293
			local v309 = math.sin(v308)
			local v310 = v_u_293
			local v311 = math.cos(v310)
			for _, v312 in v_u_141 do
				v312.model.Rotate:PivotTo(v312.pivot * CFrame.Angles(v309 * v312.side * 3.141592653589793 * 0.125, v311 * v312.side * 3.141592653589793 * 0.125, 0))
				v_u_19.target(v312.beam, 1, 5, {
					["Width1"] = 1 / v_u_170 * 20 * (math.lerp(0.25, 1, v299) * 0.5)
				})
			end
			local v313 = v_u_170
			local v314 = (1 / math.max(v313, 0.001)) ^ 0.35 * 2
			local v315
			if v_u_290 == 4 then
				for _, v316 in v_u_259 do
					if v316 <= v297 and v297 <= v316 + 2.5 then
						v315 = true
					end
				end
				v315 = false
			else
				v315 = false
				v_u_251 = v315
				if v_u_290 ~= 1 then
					if v_u_290 == 2 then
						local v317 = v297 - v_u_291
						local v318, v319
						if v317 < 3.5 then
							local v320 = v317 / 3.5
							v318 = math.clamp(v320, 0, 1)
							v319 = true
						elseif v317 < 3.6 or v317 >= 7.1 then
							v319 = false
							v318 = 0
						else
							local v321 = (v317 - 3.6) / 3.5
							if v321 >= 0.75 then
								v319 = false
								v318 = 0
							else
								v318 = math.clamp(v321, 0, 1)
								v319 = true
							end
						end
						if v319 ~= v_u_292 then
							v_u_292 = v319
							v_u_264(v319)
							local v322 = v_u_246
							local v323
							if v319 then
								v323 = v_u_157[2]
							else
								v323 = v_u_61
							end
							v322(v323)
						end
						if v319 then
							local v324 = math.lerp(1.5707963267948966, 0.4398229715025711, v318)
							for _, v325 in v_u_143 do
								local v326 = -v325.side * 0.15707963267948966
								v325.model.Rotate:PivotTo(v325.pivot * CFrame.Angles(v324, v326, 0))
								v325.beam.Brightness = math.lerp(6, 10, v299)
							end
						end
					elseif v_u_290 == 3 then
						local v327 = (v297 - 57) / 0.4166666666666667
						local v328 = math.floor(v327)
						if v328 ~= v_u_257 then
							v_u_257 = v328
							v_u_260 = v_u_260 + 0.26179938779914946
							local v329 = v328 % 2 == 0
							for _, v330 in v_u_143 do
								local v331 = v330.side == -1
								if not v329 then
									v331 = not v331
								end
								v330.light.Enabled = v331
								v330.beam.Enabled = v331
								for _, v332 in v330.beams do
									v332.beam.Enabled = v331
								end
							end
							v_u_285(v_u_260, 0.8, 0.8)
						end
						for _, v333 in v_u_143 do
							v333.beam.Brightness = 10
						end
					elseif v_u_290 == 4 then
						for _, v334 in v_u_259 do
							if v334 <= v297 and v297 <= v334 + 2.5 then
								v344 = true
								if v344 then
									if not v_u_255 then
										v_u_255 = true
										v_u_269()
										v_u_264(true)
										v_u_246(v_u_157[1])
									end
									local v335 = (v297 - 57) / 0.4166666666666667 * 3.141592653589793 * 2 * 1
									local v336 = math.sin(v335)
									for v337, v338 in v_u_143 do
										local v339 = v_u_247[v337] + v336 * 0.5654866776461628 * v338.side
										local v340 = v_u_248[v337]
										v338.model.Rotate:PivotTo(v338.pivot * CFrame.Angles(v340, v339, 0))
										v338.beam.Brightness = math.lerp(6, 10, v299)
									end
								else
									if v_u_255 then
										v_u_255 = false
									end
									v_u_294 = v_u_294 + p296 * v314
									v_u_285(v_u_294, 1, 1)
									for _, v341 in v_u_143 do
										local v342 = v341.beam
										local v343 = 1 / v_u_170 * v299
										v342.Brightness = math.lerp(5, 10, v343)
									end
								end
							end
						end
						local v344 = false
					end
				end
				for _, v345 in v_u_259 do
					if v345 <= v297 and v297 <= v345 + 2.5 then
						v364 = true
						if v364 and not v_u_256 then
							v_u_256 = true
							v_u_269()
							v_u_264(true)
						elseif not v364 and v_u_256 then
							v_u_256 = false
							v_u_264(false)
						end
						if v_u_256 then
							local v346 = (v297 - 57) / 0.4166666666666667 * 3.141592653589793 * 2 * 1
							local v347 = math.sin(v346)
							for v348, v349 in v_u_143 do
								local v350 = v_u_247[v348] + v347 * 0.5654866776461628 * v349.side
								local v351 = v_u_248[v348]
								v349.model.Rotate:PivotTo(v349.pivot * CFrame.Angles(v351, v350, 0))
								v349.beam.Brightness = math.lerp(6, 10, v299)
							end
						end
						for _, v352 in v_u_141 do
							local v353 = v352.beam
							local v354 = 1 / v_u_170 * v299
							v353.Brightness = math.lerp(5, 10, v354)
						end
						for _, v355 in v_u_143 do
							for _, v356 in v355.beams do
								local v357 = v_u_19.target
								local v358 = v356.attachment
								local v359 = {}
								local v360 = v356.targetPosition.X
								local v361 = v356.index
								local v362 = v309 * (math.abs(v361) % 2 == 0 and -1 or 1) * 15
								local v363 = v356.targetPosition.Z
								v359.Position = Vector3.new(v360, v362, v363)
								v357(v358, 0.9, 5, v359)
							end
						end
						return
					end
				end
				local v364 = false
			end
		end))
		local v_u_365 = {}
		local function v_u_369()
			for _, v366 in v_u_365 do
				if v366 then
					pcall(task.cancel, v366)
				end
			end
			table.clear(v_u_365)
			for _, v367 in v_u_79 do
				local v368 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v367, 1, v_u_160, v368)
			end
		end
		local v_u_370 = table.clone(v_u_79)
		table.sort(v_u_370, function(p371, p372)
			return p371.Position.Z < p372.Position.Z
		end)
		local v_u_373 = {}
		for v374, v375 in v_u_370 do
			if v374 % 2 == 0 then
				local v376 = { v_u_370[v374 - 1], v375 }
				table.insert(v_u_373, v376)
			end
		end
		local function v394(p_u_377, p_u_378, p_u_379)
			local v380 = v_u_365
			local v381 = task.spawn
			local function v393()
				local v382 = p_u_378 / 98
				local v383 = 0
				for v384, v_u_385 in v_u_370 do
					local v386 = {
						["Color"] = p_u_377
					}
					v_u_19.target(v_u_385, 1, v_u_160, v386)
					if p_u_379 then
						local v387 = v_u_365
						local v388 = task.delay
						local v389 = p_u_379
						local function v391()
							local v390 = {
								["Color"] = v_u_61
							}
							v_u_19.target(v_u_385, 1, v_u_160, v390)
						end
						table.insert(v387, v388(v389, v391))
					end
					if v384 % 2 == 0 then
						while v383 < v382 do
							v383 = v383 + v_u_3.PostSimulation:Wait()
						end
						v383 = v383 - v382
					end
				end
				local v392 = table.find(v_u_365, coroutine.running())
				if v392 then
					table.remove(v_u_365, v392)
				end
			end
			table.insert(v380, v381(v393))
		end
		local function v406(p_u_395, p_u_396)
			v_u_369()
			local v397 = v_u_365
			local v398 = task.spawn
			local function v405()
				local v399 = 0
				while true do
					for v400, v401 in v_u_373 do
						local v402
						if (v400 + v399) % 2 == 0 then
							v402 = p_u_396
						else
							v402 = v_u_61
						end
						for _, v403 in v401 do
							v_u_19.target(v403, 1, v_u_160, {
								["Color"] = v402
							})
						end
					end
					local v404 = p_u_395()
					task.wait(v404)
					v399 = v399 + 1
				end
			end
			table.insert(v397, v398(v405))
		end
		v_u_116 = 1
		for _, v407 in v_u_153 do
			v407:AdjustSpeed(v_u_172)
			if v_u_152.trackPointers[v407] then
				v_u_152.trackPointers[v407]:AdjustSpeed(v_u_172)
			end
		end
		v_u_152.setPlayingTrack(v148)
		v137(18.5, v_u_152.setPlayingTrack, v149)
		v137(20.8, v_u_152.setPlayingTrack, v148)
		v137(44.5, v_u_152.setPlayingTrack, v150)
		v137(49, v_u_152.setPlayingTrack, v151)
		v137(84, v_u_152.setPlayingTrack, v148)
		v137(97, v_u_152.setPlayingTrack, v149)
		v137(99.3, v_u_152.setPlayingTrack, v148)
		v137(124, v_u_152.setPlayingTrack, v150)
		v137(128.5, v_u_152.setPlayingTrack, v151)
		v137(162, v_u_152.setPlayingTrack, v149)
		v137(164.3, v_u_152.setPlayingTrack, v151)
		v137(190, v_u_152.setPlayingTrack, v148)
		v137(201, v_u_152.setPlayingTrack, v150)
		v137(205.5, v_u_152.setPlayingTrack, v151)
		v137(226, v_u_152.setPlayingTrack, v148)
		local function v_u_408()
			return v_u_170
		end
		v_u_162 = 0.75
		v_u_21.enable(v140)
		v_u_80 = false
		local v_u_409 = v_u_156[2]
		v_u_369()
		local v410 = task.spawn
		local function v417()
			local v411 = 0
			while true do
				for v412, v413 in v_u_373 do
					local v414
					if (v412 + v411) % 2 == 0 then
						v414 = v_u_409
					else
						v414 = v_u_61
					end
					for _, v415 in v413 do
						v_u_19.target(v415, 1, v_u_160, {
							["Color"] = v414
						})
					end
				end
				local v416 = v_u_408()
				task.wait(v416)
				v411 = v411 + 1
			end
		end
		table.insert(v_u_365, v410(v417))
		v137(3.8, v_u_369)
		for _, v418 in {
			{ 4, 8, 2 },
			{ 11, 15, 2 },
			{ 18, 22, 2 },
			{ 24, 28, 2 },
			{ 31, 35, 2 },
			{ 37, 48, 2 },
			{ 50, 58, 1.25 },
			{ 84, 86, 2 },
			{ 90, 94, 2 },
			{ 96, 96, 2 },
			{ 102.5, 106.5, 2 },
			{ 109.5, 113.5, 2 },
			{ 116, 120, 2 },
			{ 122, 126, 2 },
			{ 214, 218, 2 },
			{ 220, 224, 2 },
			{ 226, 228, 2 }
			} do
			for v419 = v418[1] - 0, v418[2] - 0, v418[3] do
				v137(v419, v394, v_u_156[2], 0.3, 0.3)
				v137(v419 + 0.6, v394, v_u_156[2], 0.3, 0.3)
			end
		end
		v137(57, v406, v_u_408, v_u_156[2])
		v137(83, v_u_369)
		v137(83, v394, v_u_156[2], 0.3, 0.5)
		v137(130, v406, v_u_408, v_u_156[2])
		v137(160, v_u_369)
		v137(162, v406, v_u_408, v_u_156[2])
		v137(188, v_u_369)
		v137(202, v406, v_u_408, v_u_156[2])
		v137(214, v_u_369)
		local v420 = 3 + 1
		v137(57, v241, v420)
		local v421 = v420 + 1
		v137(60, v241, v421)
		local v422 = v421 + 1
		v137(63, v241, v422)
		v137(66, v241, v422 + 1)
		v137(4, v168, 0.3)
		v137(44, v168, 0.2)
		v137(57, v168, 0.15)
		v137(70, v168, 0.125)
		v137(79, v168, 0.3)
		v137(84, v168, 0.15)
		v137(84.5, v241, 0)
		v137(135, v168, 0.2)
		v137(149, v168, 0.175)
		v137(161, v168, 0.2)
		v137(187.5, v168, 0.5)
		v137(202, v168, 0.2)
		v137(215, v168, 0.25)
		v137(230.5, function()
			v_u_27:Remove(v_u_199)
			v_u_160 = 1
			v_u_161 = 2
			local v423 = ColorSequence.new(v_u_61)
			local v424 = {
				["Color"] = v_u_61
			}
			v_u_19.target(v_u_159.NeonDeepYellow, 1, v_u_160, v424)
			local v425 = {
				["Color"] = v_u_61
			}
			v_u_19.target(v_u_159.NeonRed, 1, v_u_160, v425)
			local v426 = {
				["Color"] = v_u_61
			}
			v_u_19.target(v_u_159.NeonYellow, 1, v_u_160, v426)
			for _, v427 in v_u_164 do
				local v428 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v427, 1, v_u_160, v428)
			end
			for _, v429 in v_u_166 do
				local v430 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v429, 1, v_u_160, v430)
			end
			for _, v431 in v_u_74 do
				local v432 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v431, 1, v_u_160, v432)
			end
			for _, v433 in v_u_79 do
				local v434 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v433, 1, v_u_160, v434)
			end
			for _, v435 in v_u_169 do
				local v436 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v435, 1, v_u_160, v436)
			end
			for _, v437 in v_u_142 do
				v_u_19.target(v437.beam, 0.9, 5, {
					["Width0"] = 0,
					["Width1"] = 0
				})
				local v438 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v437.neon, 1, v_u_161, v438)
				local v439 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v437.light, 1, v_u_161, v439)
				v_u_19.target(v437.beam, 1, v_u_161, {
					["Color"] = v423
				})
				for _, v440 in v437.beams do
					v_u_19.target(v440.beam, 1, v_u_161, {
						["Color"] = v423
					})
				end
			end
			local v441 = v_u_28.startedAt + 231.5 - workspace:GetServerTimeNow()
			if math.max(v441, 0) <= 0 then
				return
			else
				local v442 = os.clock()
				while true do
					local v443 = (os.clock() - v442) / 0.5
					local v444 = math.lerp(1, 0, v443)
					v_u_116 = v444
					for _, v445 in v_u_153 do
						v445:AdjustSpeed(v444)
						if v_u_152.trackPointers[v445] then
							v_u_152.trackPointers[v445]:AdjustSpeed(v444)
						end
					end
					if v443 >= 1 then
						return
					end
					v_u_3.PreRender:Wait()
				end
			end
		end)
		v137(228, function()
			v_u_21.disable(v_u_54.Stage)
		end)
	end
	local function v_u_496()
		v_u_27:Add(function()
			v_u_25[1]:Stop()
			v_u_25[2]:Stop()
		end)

		-- ==================== FIX SON 1 (I Just Might) ====================
		-- Son 1 : rbxassetid://77682996767501, commence à startedAt + 5, durée max ~209.5s
		loadSoundSafe(v_u_27, v_u_7, "rbxassetid://77682996767501", v_u_25[1], v_u_28.startedAt + 5, 209.5, 0.25)
		-- ==================== FIN FIX SON 1 ====================

		v_u_27:Clone(script.Night_Sky).Parent = v_u_4
		local v_u_448 = v_u_4:FindFirstChild("Atmosphere")
		if v_u_448 then
			v_u_448.Parent = script
			v_u_27:Add(function()
				v_u_448.Parent = v_u_4
			end)
		end
		v_u_27:Clone(script.AtmosphereLance).Parent = v_u_4
		local v449 = v_u_27:Clone(script.CarpetLights)
		v_u_79 = v449:GetChildren()
		v449.Parent = v_u_54
		v_u_54.Parent = workspace
		v_u_54.Pavillion.Marquee.NowPlayingSign.Gui:FindFirstChild("Text").Text = "NOW PLAYING... <br /> I JUST MIGHT"
		v_u_27:Add(v_u_16.observeTag("HideInLance", function(p_u_450)
			local v_u_451 = p_u_450.Parent
			p_u_450.Parent = script
			return function()
				pcall(function()
					p_u_450.Parent = v_u_451
				end)
			end
		end, { workspace, script, v_u_4 }))
		local v_u_452 = v_u_44
		local function v454(p453, ...)
			return v_u_452(p453 + 5, ...)
		end
		local v_u_455 = {}
		local function v458(p456)
			if not v_u_455[p456] and p456:FindFirstChild("Animation") then
				local v457 = v_u_13.loadAnimation(v_u_27, p456.AnimationController.Animator, p456.Animation)
				v457.Looped = true
				v457:Play()
				v_u_455[p456] = v457
			end
		end
		local function v_u_461(p459)
			local v460 = v_u_455[p459]
			if not v460 and p459:FindFirstChild("Animation") then
				v460 = v_u_13.loadAnimation(v_u_27, p459.AnimationController.Animator, p459.Animation)
				assert(v460)
				v460.Looped = false
				v_u_455[p459] = v460
			end
			if v460 then
				v460:Stop()
				v460:Play()
			end
		end
		local v_u_462 = v_u_54.Stage.Rotate.TheRomantic.Instruments
		v454(2, v458, v_u_462.DrumKit.TomDrum1)
		v454(2, v458, v_u_462.DrumKit.TomDrum2)
		local v463 = v_u_54.Stage.Rotate.TheRomantic.MainLance
		local v_u_464 = v_u_13.loadAnimation(v_u_27, v_u_54.Stage.Rotate.TheRomantic.CongaLance.Humanoid.Animator, script.LanceConga)
		v_u_464.Looped = true
		v_u_464:Play()
		v_u_27:Add(v_u_464:GetMarkerReachedSignal("Conga1"):Connect(function()
			v_u_461(v_u_462.Conga1)
		end))
		v_u_27:Add(v_u_464:GetMarkerReachedSignal("Conga2"):Connect(function()
			v_u_461(v_u_462.Conga2)
		end))
		local v_u_465 = v_u_13.loadAnimation(v_u_27, v_u_54.Stage.Rotate.TheRomantic.DrumsLance.Humanoid.Animator, script.LanceDrums)
		v_u_465.Looped = true
		v_u_465:Play()
		v_u_27:Add(v_u_465:GetMarkerReachedSignal("Drum1"):Connect(function()
			v_u_461(v_u_462.DrumKit.Drum1)
		end))
		v_u_27:Add(v_u_465:GetMarkerReachedSignal("Drum2"):Connect(function()
			v_u_461(v_u_462.DrumKit.Drum2)
		end))
		v_u_27:Add(v_u_465:GetMarkerReachedSignal("Drum3"):Connect(function()
			v_u_461(v_u_462.DrumKit.Drum3)
		end))
		local v_u_466 = v_u_13.loadAnimation(v_u_27, v_u_54.Stage.Rotate.TheRomantic.GuitarLance1.Humanoid.Animator, script.LanceGuitar)
		v_u_466.Looped = true
		v_u_466:Play()
		local v_u_467 = v_u_13.loadAnimation(v_u_27, v_u_54.Stage.Rotate.TheRomantic.GuitarLance2.Humanoid.Animator, script.LanceGuitar)
		v_u_467.Looped = true
		v_u_467:Play()
		local v468 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance1)
		local v469 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance2)
		local v470 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance4)
		local v471 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance5)
		local v472 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance6)
		local v473 = v_u_13.loadAnimation(v_u_27, v463.Humanoid.Animator, script.Lance8)
		local v474 = v_u_133(v463.Humanoid.Animator, {
			v468,
			v469,
			v470,
			v471,
			v472,
			v473
		}, {
			[v470] = true
		}, {
			[v470] = 1.5,
			[v469] = 0.95,
			[v471] = 0.3,
			[v472] = 0.5,
			[v473] = 0.8
		})
		local v475 = v474.setPlayingTrack
		local v_u_476 = v474.trackPointers
		local v_u_477 = v474.tracks
		v470:AdjustWeight(1)
		v454(0, v475, v470)
		v454(5, v475, v468)
		v454(14, v475, v469)
		v454(27, v475, v470)
		v454(36, v475, v469)
		v454(64, v475, v472)
		v454(97, v475, v469)
		v454(117, v475, v473)
		v454(135, v475, v471)
		v454(161, v475, v473)
		v454(180, v475, v468)
		v_u_55.Play("WhitePlain")
		local v478 = v_u_61
		if v_u_113 then
			v_u_27:Remove(v_u_113)
			v_u_113 = nil
		end
		if v_u_112[v478] then
			v_u_113 = v_u_27:Add(v_u_112[v478]())
		else
			v_u_87(v478)
		end
		v454(1.8, v_u_55.Stop)
		v454(2, v_u_55.Play, "RowSpinWhite")
		v454(2, v_u_115, v_u_57)
		v454(2.5, v_u_55.Stop)
		v454(2.5, v_u_115, v_u_61)
		v454(3, v_u_55.Play, "OrangePlain")
		v454(3, v_u_115, v_u_58)
		v454(3.5, v_u_55.Stop)
		v454(3.5, v_u_115, v_u_61)
		v454(4, v_u_55.Play, "OrangePlain")
		v454(4, v_u_115, v_u_58)
		v454(4.5, v_u_55.Stop)
		v454(4.5, v_u_115, v_u_61)
		v454(5, v_u_55.Play, "Mirage")
		v454(5, v_u_115, v_u_58)
		v454(9.2, v_u_55.Stop)
		v454(9.2, v_u_115, v_u_61)
		v454(9.5, v_u_55.Play, "Spiral")
		v454(9.5, v_u_115, v_u_57)
		v454(13, v_u_55.Play, "OrangePlain")
		v454(13, v_u_115, v_u_58)
		v454(13.3, v_u_55.Play, "RedPlain")
		v454(13.3, v_u_115, v_u_60)
		v454(13.5, v_u_55.Play, "OrangePlain")
		v454(13.5, v_u_115, v_u_58)
		v454(13.7, v_u_55.Stop)
		v454(13.7, v_u_115, v_u_61)
		v454(14, v_u_55.Play, "BackAndForth")
		v454(14, v_u_115, v_u_58)
		v454(23, v_u_55.Stop)
		v454(23, v_u_115, v_u_61)
		v454(23.5, v_u_55.Play, "BackAndForth")
		v454(23.5, v_u_115, v_u_58)
		v454(31.5, v_u_55.Stop)
		v454(31.5, v_u_115, v_u_61)
		v454(32, v_u_55.Play, "OrangePlain")
		v454(32, v_u_115, v_u_58)
		v454(32.5, v_u_55.Play, "Crazy")
		v454(32.5, v_u_115, "CRAZY_SEQUENCE")
		v454(36.4, v_u_55.Stop)
		v454(36.4, v_u_115, v_u_61)
		v454(36.7, v_u_55.Play, "Mirage")
		v454(36.7, v_u_115, v_u_57)
		v454(39.6, v_u_55.Stop)
		v454(39.6, v_u_115, v_u_61)
		v454(41, v_u_55.Play, "WhitePlain")
		v454(41, v_u_115, v_u_57)
		v454(41.8, v_u_55.Play, "BackAndForth")
		v454(41.8, v_u_115, v_u_58)
		v454(50, v_u_55.Play, "WhitePlain")
		v454(50, v_u_115, v_u_57)
		v454(50.5, v_u_55.Stop)
		v454(50.5, v_u_115, v_u_61)
		v454(51, v_u_55.Play, "WhitePlain")
		v454(51, v_u_115, v_u_57)
		v454(51.5, v_u_55.Play, "ExtraCrazy")
		v454(51.5, v_u_115, "EXTRA_CRAZY_SEQUENCE")
		v454(62.5, v_u_55.Stop)
		v454(62.5, v_u_115, v_u_61)
		v454(63, v_u_55.Play, "WhitePlain")
		v454(63, v_u_115, v_u_57)
		v454(63.5, v_u_55.Stop)
		v454(63.5, v_u_115, v_u_61)
		v454(64, v_u_55.Play, "WhitePlain")
		v454(64, v_u_115, v_u_57)
		v454(64.5, v_u_55.Stop)
		v454(64.5, v_u_115, v_u_61)
		v454(65, v_u_55.Play, "RowSpinWhite")
		v454(65, v_u_115, v_u_57)
		v454(67, v_u_55.Play, "RowSpinRed")
		v454(67, v_u_115, v_u_60)
		v454(74, v_u_55.Play, "WhitePlain")
		v454(74, v_u_115, v_u_57)
		v454(74.3, v_u_55.Play, "OrangePlain")
		v454(74.3, v_u_115, v_u_58)
		v454(74.6, v_u_55.Play, "WhitePlain")
		v454(74.6, v_u_115, v_u_57)
		v454(74.8, v_u_55.Stop, true)
		v454(74.8, v_u_115, v_u_61)
		v454(75, v_u_55.Play, "RowSpinRed")
		v454(75, v_u_115, v_u_60)
		v454(78, v_u_55.Stop, true)
		v454(78, v_u_115, v_u_61)
		v454(78.5, v_u_55.Play, "WhitePlain")
		v454(78.5, v_u_115, v_u_57)
		v454(84, v_u_55.Play, "OrangePlain")
		v454(84, v_u_115, v_u_58)
		v454(85.5, v_u_55.Play, "WhitePlain")
		v454(85.5, v_u_115, v_u_57)
		v454(88.5, v_u_55.Play, "OrangePlain")
		v454(88.5, v_u_115, v_u_58)
		v454(88.8, v_u_55.Stop, true)
		v454(88.8, v_u_115, v_u_61)
		v454(89.3, v_u_55.Play, "WhitePlain")
		v454(89.3, v_u_115, v_u_57)
		v454(97, v_u_55.Stop, true)
		v454(97, v_u_115, v_u_61)
		v454(98, v_u_55.Play, "Crazy")
		v454(98, v_u_115, "CRAZY_SEQUENCE")
		v454(102.5, v_u_55.Play, "MirageRed")
		v454(102.5, v_u_115, v_u_60)
		v454(106, v_u_55.Play, "OrangePlain")
		v454(106, v_u_115, v_u_58)
		v454(106.4, v_u_55.Play, "WhitePlain")
		v454(106.4, v_u_115, v_u_57)
		v454(107, v_u_55.Stop, true)
		v454(107, v_u_115, v_u_61)
		v454(107.5, v_u_55.Play, "Crazy")
		v454(107.5, v_u_115, "CRAZY_SEQUENCE")
		v454(111.5, v_u_55.Play, "BackAndForthOrange")
		v454(111.5, v_u_115, v_u_58)
		v454(116, v_u_55.Play, "WhitePlain")
		v454(116, v_u_115, v_u_57)
		v454(116.3, v_u_55.Stop, true)
		v454(116.3, v_u_115, v_u_61)
		v454(116.5, v_u_55.Play, "WhitePlain")
		v454(116.5, v_u_115, v_u_57)
		v454(116.8, v_u_55.Stop, true)
		v454(116.8, v_u_115, v_u_61)
		v454(117, v_u_55.Play, "ExtraCrazy")
		v454(117, v_u_115, "EXTRA_CRAZY_SEQUENCE")
		v454(128, v_u_55.Stop, true)
		v454(128, v_u_115, v_u_61)
		v454(128.5, v_u_55.Play, "ExtraCrazy")
		v454(128.5, v_u_115, "EXTRA_CRAZY_SEQUENCE")
		v454(129, v_u_55.Stop)
		v454(129, v_u_115, v_u_61)
		v454(129.5, v_u_55.Play, "WhitePlain")
		v454(129.5, v_u_115, v_u_57)
		v454(129.8, v_u_55.Stop)
		v454(129.8, v_u_115, v_u_61)
		v454(130.3, v_u_55.Play, "WhitePlain")
		v454(130.3, v_u_115, v_u_57)
		v454(130.6, v_u_55.Stop)
		v454(130.6, v_u_115, v_u_61)
		v454(131, v_u_55.Play, "RowSpinWhite")
		v454(131, v_u_115, v_u_57)
		v454(132.5, v_u_55.Play, "RowSpinRed")
		v454(132.5, v_u_115, v_u_60)
		v454(135, v_u_55.Stop)
		v454(135, v_u_115, v_u_61)
		v454(135.5, v_u_55.Play, "BluePlain")
		v454(135.5, v_u_115, v_u_59)
		v454(136, v_u_55.Play, "BackAndForthBlue")
		v454(136, v_u_115, v_u_59)
		v454(157, v_u_55.Play, "WhitePlain")
		v454(157, v_u_115, v_u_57)
		v454(157.5, v_u_55.Stop)
		v454(157.5, v_u_115, v_u_61)
		v454(158, v_u_55.Play, "WhitePlain")
		v454(158, v_u_115, v_u_57)
		v454(158.5, v_u_55.Stop)
		v454(158.5, v_u_115, v_u_61)
		v454(159, v_u_55.Play, "RowSpinWhite")
		v454(159, v_u_115, v_u_57)
		v454(160.5, v_u_55.Play, "RowSpinRed")
		v454(160.5, v_u_115, v_u_60)
		v454(161.7, v_u_55.Stop)
		v454(161.7, v_u_115, v_u_61)
		v454(162.3, v_u_55.Play, "WhitePlain")
		v454(162.3, v_u_115, v_u_57)
		v454(162.6, v_u_55.Stop)
		v454(162.6, v_u_115, v_u_61)
		v454(162.8, v_u_55.Play, "WhitePlain")
		v454(162.8, v_u_115, v_u_57)
		v454(163.2, v_u_55.Play, "ExtraCrazy")
		v454(163.2, v_u_115, "EXTRA_CRAZY_SEQUENCE")
		v454(176, v_u_55.Stop)
		v454(176, v_u_115, v_u_61)
		v454(176.5, v_u_55.Play, "WhitePlain")
		v454(176.5, v_u_115, v_u_57)
		v454(176.7, v_u_55.Stop)
		v454(176.7, v_u_115, v_u_61)
		v454(177, v_u_55.Play, "RowSpinWhite")
		v454(177, v_u_115, v_u_57)
		v454(179, v_u_55.Play, "RowSpinRed")
		v454(179, v_u_115, v_u_60)
		v454(181, v_u_55.Play, "OrangePlain")
		v454(181, v_u_115, v_u_58)
		v454(181.3, v_u_55.Stop)
		v454(181.3, v_u_115, v_u_61)
		v454(181.6, v_u_55.Play, "WhitePlain")
		v454(181.6, v_u_115, v_u_57)
		v454(181.6, v_u_55.Play, "Mirage")
		v454(181.6, v_u_115, v_u_58)
		v454(187.5, v_u_55.Play, "ExtraCrazy")
		v454(187.5, v_u_115, "EXTRA_CRAZY_SEQUENCE")
		v454(193.9, v_u_55.Stop)
		v454(193.9, v_u_115, v_u_61)
		v454(194.4, v_u_55.Play, "WhitePlain")
		v454(194.4, v_u_115, v_u_57)
		v454(194.8, v_u_55.Stop)
		v454(194.8, v_u_115, v_u_61)
		v454(195, v_u_55.Play, "WhitePlain")
		v454(195, v_u_115, v_u_57)
		v454(195.3, v_u_55.Stop)
		v454(195.3, v_u_115, v_u_61)
		v454(195.6, v_u_55.Play, "RowSpinWhite")
		v454(195.6, v_u_115, v_u_57)
		v454(198, v_u_55.Play, "RowSpinRed")
		v454(198, v_u_115, v_u_60)
		v454(200, v_u_55.Play, "Crazy")
		v454(200, v_u_115, "CRAZY_SEQUENCE")
		v454(204, v_u_55.Play, "OrangePlain")
		v454(204, v_u_115, v_u_58)
		v454(204.3, v_u_55.Play, "WhitePlain")
		v454(204.3, v_u_115, v_u_57)
		v454(204.6, v_u_55.Stop)
		v454(204.6, v_u_115, v_u_61)
		v454(205, v_u_55.Play, "Crazy")
		v454(205, v_u_115, "CRAZY_SEQUENCE")
		v454(208, v_u_55.Stop)
		v454(208, v_u_115, v_u_61)
		v454(208.5, v_u_55.Play, "Mirage")
		v454(208.5, v_u_115, v_u_58)
		v454(209, function()
			local v479 = os.clock()
			while true do
				local v480 = (os.clock() - v479) / 0.5
				local v481 = math.lerp(1, 0, v480)
				v_u_116 = v481
				for _, v482 in v_u_477 do
					v482:AdjustSpeed(v481)
					if v_u_476[v482] then
						v_u_476[v482]:AdjustSpeed(v481)
					end
				end
				v_u_466:AdjustSpeed(v481)
				v_u_467:AdjustSpeed(v481)
				v_u_464:AdjustSpeed(v481)
				v_u_465:AdjustSpeed(v481)
				if v480 >= 1 then
					return
				end
				v_u_3.PreRender:Wait()
			end
		end)
		v454(209.5, v_u_55.Stop)
		v454(209.5, v_u_115, v_u_61)
		v454(209.5, function()
			for _, v483 in v_u_76 do
				local v484 = {
					["Color"] = v_u_61
				}
				v_u_19.target(v483, 1, 3, v484)
			end
			local v485 = v_u_27
			local v486 = v_u_14
			local v487 = v_u_25[1]
			local v488 = TweenInfo.new
			local v489 = v_u_28.startedAt + 215.5 - workspace:GetServerTimeNow()
			local v490 = math.max(v489, 0)
			v485:Add(v486(v487, v488((math.max(v490, 0.05))), {
				["Volume"] = 0
			})).Completed:Wait()
			v_u_56.Play(function(p491)
				local v492 = TweenInfo.new
				local v493 = p491 * 2 + 215.5
				local v494 = v_u_28.startedAt + v493 - workspace:GetServerTimeNow()
				return v492(math.max(v494, 0), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			end)
		end)
		v454(216.5, function()
			for _, v495 in v_u_477 do
				v_u_27:Add(task.delay(5, v495.Stop, v495, 0))
			end
			v_u_446()
		end)
	end
	v_u_27:Add((v39(0, 5, function(p497)
		v_u_27:Add(v_u_14(v_u_53, TweenInfo.new(p497(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -1.2
		}))
		v_u_9:Run("LanceEvent", "GrassRecolor")
		v_u_27:Add(function()
			v_u_9:Stop("LanceEvent", "GrassRecolor")
		end)
		v_u_27:Add(task.delay(p497(), function()
			v_u_496()
			v_u_4.Brightness = 1
			v_u_4.Ambient = Color3.fromRGB(0, 0, 0)
			v_u_4.GlobalShadows = false
			v_u_4.OutdoorAmbient = Color3.fromRGB(20, 20, 20)
			v_u_4.ExposureCompensation = 1.5
			v_u_53.Saturation = 0.15
			v_u_53.Contrast = -0.1
			v_u_27:Add(function()
				v_u_4.Brightness = 2
				v_u_4.GlobalShadows = true
				v_u_4.Ambient = Color3.fromRGB(241, 241, 241)
				v_u_4.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
				v_u_4.ExposureCompensation = 0
			end)
			local v498 = v_u_27
			local v499 = v_u_14
			local v500 = v_u_53
			local v501 = TweenInfo.new
			local v502 = v_u_28.startedAt + 6 - workspace:GetServerTimeNow()
			v498:Add(v499(v500, v501(math.max(v502, 0), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				["Brightness"] = -0.1
			}))
		end))
	end)))
	v_u_12:Update()
	v_u_10:UpdateOST()
end
function v6.OnStop(_)
	v_u_27:Destroy()
end
function v6.OnLoad(_)
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	-- ==================== FIX ONLOAD ====================
	-- Son 1 : ID corrigé -> 77682996767501
	task.spawn(pcall, function()
		local ok, err = pcall(function()
			v_u_7:WaitForAssetId("rbxassetid://77682996767501")
		end)
		if not ok then
			warn("[LanceEvent] OnLoad Son1 WaitForAssetId échoué :", err)
		end
		v_u_25[1].SoundId = "rbxassetid://77682996767501"
		v_u_2:PreloadAsync({ v_u_25[1] })
	end)
	-- Son 2 : ID corrigé -> 74828828901820 (était 78832211240703 dans l'original - BUG CORRIGÉ)
	task.spawn(pcall, function()
		local ok, err = pcall(function()
			v_u_7:WaitForAssetId("rbxassetid://78832211240703")
		end)
		if not ok then
			warn("[LanceEvent] OnLoad Son2 WaitForAssetId échoué :", err)
		end
		v_u_25[2].SoundId = "rbxassetid://78832211240703"
		v_u_2:PreloadAsync({ v_u_25[2] })
	end)
	-- ==================== FIN FIX ONLOAD ====================
end
return v6