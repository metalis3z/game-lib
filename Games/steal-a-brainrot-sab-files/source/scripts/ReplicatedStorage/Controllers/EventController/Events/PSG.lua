-- Concert Event - Client Script
-- Lumières ROUGE et BLEU uniquement, clignotement style gyrophare

local u1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = game:GetService("Lighting")
local u4 = game:GetService("Players")
require(u1.Shared.EventTypes)
local v5 = {}
local u6 = require(u1.Controllers.EncryptedAssetsController)
local u7 = require(u1.Controllers.AnimalController)
local u8 = require(u1.Controllers.EffectController)
local u9 = require(u1.Controllers.CameraController)
local u10 = require(u1.Controllers.SoundController)
local u11 = require(u1.Controllers.EventController)
local u12 = require(u1.Controllers.CycleController)
local u13 = require(u1.Packages.CreateTween)
require(u1.Shared.TweenPivot)
local u14 = require(u1.Packages.Observers)
local u15 = require(u1.Utils.MathUtils)
local u16 = require(u1.Packages.Signal)
require(u1.Packages.Spring)
local u17 = require(u1.Packages.Trove)
require(u1.Packages.Shake)
local v18 = require(u1.Packages.Net)
local u19 = require(u1.Shared.VFX)
local u20 = u4.LocalPlayer
local u21 = workspace.CurrentCamera
local u22 = script.Name
local u23 = workspace.Sounds.PSG
local u24 = v18:RemoteEvent("EventService/Concert/Shoot")
local u25 = u17.new()
local u26 = nil

-- ═══════════════════════════════════════════════
-- COULEURS : SEULEMENT ROUGE ET BLEU
-- Alternance rapide pour effet gyrophare/clignotant
-- ═══════════════════════════════════════════════
local LIGHT_COLORS = {
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
	Color3.fromRGB(255, 0, 0),   -- Rouge
	Color3.fromRGB(0, 0, 255),   -- Bleu
}

function v5.OnStart(_)
	local u27 = u11:GetActiveEventData(u22)
	assert(u27)

	local function u38(p28, u29, u30)
		local function u33()
			local v31 = u29
			local v32 = u27.startedAt + v31 - workspace:GetServerTimeNow()
			return math.max(v32, 0)
		end
		local function v34()
			u30(u33)
		end
		local u35 = nil
		local v36 = u27.startedAt + p28 - workspace:GetServerTimeNow()
		local v37 = math.max(v36, 0)
		if v37 > 0 then
			u35 = task.delay(v37, v34)
		else
			u30(u33)
		end
		return function()
			if u35 and coroutine.status(u35) == "suspended" then
				pcall(task.cancel, u35)
			end
		end
	end

	u25:Add(function()
		u8:Activate("Blink")
		u12:Update()
		u10:UpdateOST()
	end)

	local u39 = u3:FindFirstChild("Atmosphere")
	if u39 then
		u39.Parent = u1
		u25:Add(function()
			u39.Parent = u3
		end)
	end
	u25:Clone(script.Atmosphere).Parent = u3

	local u40 = u3:FindFirstChild("Cartoon")
	if u40 then
		u40.Parent = u1
		u25:Add(function()
			u40.Parent = u3
		end)
	end

	local u41 = nil
	local u42 = u25:Clone(Instance.new("ColorCorrectionEffect"))
	u42.Parent = u21

	local function u180()
		u3.Ambient = Color3.new(0, 0, 0)
		u3.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
		u3.EnvironmentDiffuseScale = 0
		u3.EnvironmentSpecularScale = 0

		u25:Add(function()
			u3.Ambient = Color3.fromRGB(241, 241, 241)
			u3.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
			u3.EnvironmentDiffuseScale = 1
			u3.EnvironmentSpecularScale = 0.5
		end)

		u25:Add(function()
			u23:Stop()
		end)

		u25:Add(task.spawn(function()
			while not u23.IsLoaded do
				task.wait()
			end
			local v43 = u23
			local v44 = u23.TimePosition
			local v45 = workspace:GetServerTimeNow() - (u27.startedAt + 5)
			v43.TimePosition = math.max(v44, v45)
			u23:Play()
		end))

		-- ═══════════════════════════════════════════════
		-- TABLEAU DE COULEURS : ROUGE / BLEU UNIQUEMENT
		-- ═══════════════════════════════════════════════
		local u46 = LIGHT_COLORS

		u25:Clone(script.Night_Sky).Parent = u3
		local u47 = u25:Clone(script.Stage)
		local u48 = u25:Clone(script.VFX)
		local u49 = u48.SmokeStage
		u25:Add(u49)
		u49.Parent = workspace
		u48.Parent = u47
		u19.disable(u48)

		local u50 = u47.SpotLights:GetChildren()
		local _ = #u50
		local u51 = {}
		local u52 = {}
		local u53 = {}
		local u54 = {}
		local u55 = {}
		local u56 = false
		local u57 = false
		local u58 = {}
		local u59 = {}
		local u60 = false
		local u61 = false
		local u62 = {}
		local u63 = {}

		for _, v64 in u50 do
			u51[v64] = v64:GetPivot()
			u52[v64] = 0
			u53[v64] = 0
			u54[v64] = 25
			v64.Rotate.Neon["1"].LightBeam:Destroy()
			local v65 = script.lightbeambig.Beams:Clone()
			for _, v66 in v65:GetChildren() do
				v66.Attachment0 = v64.Rotate.Neon["1"]
				v66.Attachment1 = v64.Rotate.Neon["2"]
				v66.Parent = v64.Rotate.Neon
				table.insert(u55, v66)
			end
			v65:Destroy()
		end

		u47.Parent = workspace
		local u67 = { u47.Rigs.TungTung, u47.Rigs.Tralalero, u47.Rigs.Chimpanzini }
		local u68 = {}

		for _, v69 in u67 do
			if v69.Name ~= "TungTung" then
				for _, v70 in v69:GetChildren() do
					if v70:IsA("BasePart") then
						v70.Transparency = 1
					end
				end
			end
			local v71 = {}
			local v72 = v69.Throw
			local v73 = v69.AnimationController.Animator:LoadAnimation(v72)
			u25:Add(v73, "Stop")
			u25:Add(v73)
			v71.Throw = v73
			local v74 = v69.Shuffle
			local v75 = v69.AnimationController.Animator:LoadAnimation(v74)
			u25:Add(v75, "Stop")
			u25:Add(v75)
			v71.Shuffle = v75
			u68[v69] = v71
		end

		local u76 = u25:Add(Instance.new("Color3Value"))
		u76.Value = Color3.fromRGB(0, 0, 0)

		for _, v77 in u68 do
			v77.Shuffle:Play()
		end

		local u78 = true
		u25:Add(function()
			u78 = false
		end)

		-- ═══════════════════════════════════════════════
		-- GESTION DES PROJECTILES (SHOOT)
		-- ═══════════════════════════════════════════════
		u25:Add(u24.OnClientEvent:Connect(function(p79, p80, u81)
			local u82 = u7:GetAnimals()[p80]
			if u82 then
				local v83 = u67[p79] or u67[1]
				if v83 then
					u68[v83].Throw:Play()
					task.wait(0.25)
					if u78 then
						local u84 = v83:FindFirstChild("SHOOT", true).WorldPosition
						task.spawn(function()
							u10:PlaySound(u1.Sounds.Events.Concert.Shoot, u84)
						end)
						local u85 = script.DiscoProjectile:Clone()
						u85.Part.CFrame = CFrame.new(u84)
						u85.Parent = workspace
						local u86 = nil
						u86 = u2.PreRender:Connect(function()
							debug.profilebegin("Concert Disco Shoot")
							local v87 = u82.AnimalModel
							local v88
							if v87.PrimaryPart then
								v88 = v87.PrimaryPart.CFrame
							else
								v88 = v87:GetPivot()
							end
							local u89 = v88.Position
							local v90 = u84 + (u89 - u84) * 0.5 + Vector3.new(0, 90, 0)
							local v91 = 1 - (u81 + 3 - workspace:GetServerTimeNow()) / 3
							local v92 = u15.quadBezier(math.clamp(v91, 0, 1), u84, v90, u89)
							u85.Part.CFrame = CFrame.new(v92)
							if v91 >= 1 then
								u86:Disconnect()
								task.spawn(function()
									u10:PlaySound(u1.Sounds.Events.Concert.Hit, u89)
								end)
								u85:Destroy()
								local u93 = script.DiscoExplosion:Clone()
								u93:PivotTo(CFrame.new(u89))
								u93.Anchored = false
								local v94 = Instance.new("WeldConstraint")
								v94.Part0 = u93
								v94.Part1 = u82.AnimalModel.PrimaryPart
								v94.Parent = u93
								u93.Parent = workspace
								u19.emit(u93)
								task.delay(3, function()
									u93:Destroy()
								end)
								u24:FireServer(p79, p80, u81)
							end
							debug.profileend()
						end)
					end
				end
			end
		end))

		-- ═══════════════════════════════════════════════
		-- BOUCLE PRINCIPALE : EFFETS LUMIÈRES
		-- ═══════════════════════════════════════════════
		u25:Add((u38(10, 15, function(u96)
			u19.enable(u48)
			local u97 = 1
			local u98 = 0
			local u99 = 0
			local u100 = 0
			local u101 = 0
			local u102 = {}
			local u103 = Color3.new(0, 0, 0)
			local u104 = ColorSequence.new(u103)

			task.delay(u96(), function()
				for _, v105 in u55 do
					v105.Enabled = true
				end
			end)

			u25:Add(function()
				workspace.Gravity = 196.2
			end)

			u25:Add(u2.PostSimulation:Connect(function(p106)
				workspace.Gravity = 29.429999999999996
				u99 = u99 - p106
				u98 = u98 - p106
				u101 = u101 - p106
				u100 = u100 - p106

				local v107 = u23.TimePosition
				local v108
				if v107 >= 20 and v107 <= 25 then
					v108 = true
				elseif v107 >= 70 then
					v108 = v107 <= 94.5
				else
					v108 = false
				end

				local v109 = (u23.PlaybackLoudness - 100) / 900
				local v110 = math.clamp(v109, 0, 1)

				for _, v111 in u58 do
					local v112 = v110 / 0.05
					v111.TimeScale = math.clamp(v112, 1, 2) * u62[v111]
				end

				for v113, v114 in u68 do
					if v113.Name == "TungTung" then
						local v115 = v114.Shuffle
						local v116 = v110 * 0.5 / 0.13
						v115:AdjustSpeed((math.clamp(v116, 0.25, 1)))
					else
						local v117 = v114.Shuffle
						local v118 = v110 / 0.13
						v117:AdjustSpeed((math.clamp(v118, 0.5, 1.5)))
					end
				end

				if u41 then
					local v119 = u41
					local v120
					if v108 then
						v120 = 3
					else
						local v121 = v110 / 0.06
						v120 = math.clamp(v121, 1, 3)
					end
					v119:AdjustSpeed(v120)
				end

				local v122
				if v107 >= 70 and v107 <= 94.5 then
					if v107 >= 85 then
						v122 = 0.05
					else
						local v123 = (v107 - 70) / 12
						local v124 = math.min(v123, 1)
						v122 = math.lerp(0.5, 0.2, v124)
					end
				else
					-- ═══════════════════════════════════
					-- CLIGNOTEMENT RAPIDE ROUGE/BLEU
					-- Intervalle réduit pour effet stroboscopique
					-- ═══════════════════════════════════
					v122 = v108 and 0.05 or 0.1
				end

				if (v110 >= 0.11 or v108) and (u100 <= 0 and u96() <= 0) then
					u100 = v122
					u97 = u97 % #u46 + 1
					-- Transition instantanée pour un vrai effet clignotant
					u13(u76, TweenInfo.new(0.05), {
						["Value"] = u46[u97]
					})
				end

				local v125 = u76.Value
				if v107 >= 94.3 and v107 <= 97.7 then
					v125 = u103
				end

				local v126 = ColorSequence.new(v125)
				for _, v127 in u59 do
					local v128
					if u102[v127] then
						v128 = u104
					else
						v128 = v126
					end
					v127.Color = v128
				end

				for _, v129 in u63 do
					local v130
					if u102[v129] then
						v130 = u103
					else
						v130 = v125
					end
					v129.Color = v130
				end

				local v131
				if v108 then
					v131 = 1.5
				else
					local v132 = v110 / 0.25
					v131 = math.clamp(v132, 0.05, 1)
				end

				local v133 = p106 * v131
				for _, v134 in u50 do
					local v135 = u53[v134] or 0
					local v136 = u54[v134] or 0
					local v137 = (u52[v134] or 0) + v133
					local v138 = math.clamp(v137, 0, 1)
					u52[v134] = v138
					if v138 >= 1 then
						u52[v134] = 0
						u53[v134] = v136
						local v139 = u54
						v139[v134] = v139[v134] * -1
					else
						local v140 = math.lerp(v135, v136, v138)
						local v141 = math.rad(v140)
						v134:PivotTo(u51[v134] * CFrame.Angles(0, v141, not u60 and 0 or v141))
						if u60 then
							for _, v142 in v134.Rotate.Neon:GetChildren() do
								if v142.Name == "CustomAttachment_-1" or (v142.Name == "2" or v142.Name == "CustomAttachment_2") then
									local v143 = v142.Position.X
									local v144 = v138 * 3.141592653589793
									local v145 = math.sin(v144) * 100
									v142.Position = Vector3.new(v143, v145, 300)
								end
							end
						end
					end
				end

				-- ═══════════════════════════════════════════════
				-- FLASH STROBOSCOPIQUE ROUGE/BLEU
				-- ═══════════════════════════════════════════════
				if v108 and u99 <= 0 then
					local v146 = math.random(60, 150) -- Plus rapide pour effet clignotant
					u99 = v146 / 1000
					local v147 = {}
					for _, u148 in u55 do
						v147[u148] = true
						local v149 = u148.Width0 - 0.5
						u148.Width0 = math.max(v149, 0.5)
						local v150 = u148.Width1 - 2.5
						u148.Width1 = math.max(v150, 1)
						local v151 = u148.Brightness + 0.5
						u148.Brightness = math.min(v151, 13)
						u148.Enabled = false
						task.delay(math.random(30, v146) / 1000, function()
							u148.Enabled = true
						end)
					end
					for _, u152 in u59 do
						if not v147[u152] then
							u102[u152] = true
							task.delay(math.random(30, v146) / 1000, function()
								u102[u152] = nil
							end)
						end
					end
					for _, u153 in u63 do
						u102[u153] = true
						task.delay(math.random(30, v146) / 1000, function()
							u102[u153] = nil
						end)
					end
				end

				if v107 >= 25 and not u56 then
					u56 = true
					for _, v154 in u50 do
						local v155 = v154.Rotate.Neon["1"]
						local v156 = v154.Rotate.Neon["2"]
						local v157 = v156:Clone()
						v157.Name = "CustomAttachment_1"
						v157.Parent = v154.Rotate.Neon
						u13(v156, TweenInfo.new(5), {
							["Position"] = v156.Position + Vector3.new(15, 0, 0)
						})
						u13(v157, TweenInfo.new(5), {
							["Position"] = v156.Position - Vector3.new(15, 0, 0)
						})
						local v158 = script.lightbeambig.Beams:Clone()
						for _, v159 in v158:GetChildren() do
							v159.Width0 = 0.5
							v159.Width1 = 1
							v159.Brightness = 13
							v159.Attachment0 = v155
							v159.Attachment1 = v157
							v159.Parent = v154.Rotate.Neon
							table.insert(u55, v159)
							table.insert(u59, v159)
						end
						v158:Destroy()
					end
				end

				if v107 >= 71 and not u60 then
					u19.enable(u49)
					task.delay(5, function()
						u19.disable(u49)
					end)
					u60 = true
					for _, v162 in u50 do
						local v163 = v162.Rotate.Neon["1"]
						local v164 = v162.Rotate.Neon["2"]
						local v165 = v164.Position - Vector3.new(15, 0, 0)
						u13(v164, TweenInfo.new(5), {
							["Position"] = v165
						})
						for v166 = -2, 2 do
							if v166 ~= 0 then
								local v167 = v164:Clone()
								v167.Name = ("CustomAttachment_%*"):format(v166)
								v167.Parent = v162.Rotate.Neon
								u13(v167, TweenInfo.new(5), {
									["Position"] = v165 + Vector3.new(v166 * 30, 0, 0)
								})
								local v172 = script.lightbeambig.Beams:Clone()
								for _, v173 in v172:GetChildren() do
									v173.Width0 = 0.5
									v173.Width1 = 1
									v173.Brightness = 13
									v173.Attachment0 = v163
									v173.Attachment1 = v167
									v173.Parent = v162.Rotate.Neon
									table.insert(u55, v173)
									table.insert(u59, v173)
								end
								v172:Destroy()
							end
						end
					end
				end

				if v107 >= 36 and not u61 then
					u61 = true
					for _, v176 in u47.Rigs.Tralalero:GetChildren() do
						if v176:IsA("BasePart") then
							u13(v176, TweenInfo.new(1), {
								["Transparency"] = 0
							})
						end
					end
				end

				if v107 >= 61.5 and not u57 then
					u57 = true
					for _, v177 in u47.Rigs.Chimpanzini:GetChildren() do
						if v177:IsA("BasePart") then
							u13(v177, TweenInfo.new(1), {
								["Transparency"] = 0
							})
						end
					end
				end

				if (v110 >= 0.2 or v108) and u98 <= 0 then
					u98 = v108 and 0.2 or 0.1
					u9:Fov((v110 - 0.2) * 15 + 70, 0.1)
				end
			end))
		end)))

		for _, v178 in u47:GetDescendants() do
			if v178:IsA("BasePart") and v178.Name == "Neon" or v178:IsA("SpotLight") then
				table.insert(u63, v178)
			elseif v178:IsA("ParticleEmitter") or v178:IsA("Beam") then
				table.insert(u59, v178)
				if v178:IsA("ParticleEmitter") then
					u62[v178] = v178.TimeScale
					table.insert(u58, v178)
				end
			end
		end

		u25:Add((u38(10, 15, function(p179)
			u13(u76, TweenInfo.new(p179()), {
				["Value"] = u46[1]
			})
		end)))
	end

	u25:Add((u38(0, 5, function(p181)
		u13(u42, TweenInfo.new(p181(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -1
		})
		task.delay(p181(), u180)
		u8:Run("ConcertEvent", "GrassRecolor")
		u25:Add(function()
			u8:Stop("ConcertEvent", "GrassRecolor")
		end)
		u8:Run("ConcertEvent", "WallRecolor")
		u25:Add(function()
			u8:Stop("ConcertEvent", "WallRecolor")
		end)
		u8:Run("ConcertEvent", "WallBottomRecolor")
		u25:Add(function()
			u8:Stop("ConcertEvent", "WallBottomRecolor")
		end)
	end)))

	u25:Add((u38(10, 15, function(p182)
		u13(u42, TweenInfo.new(p182(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = -0.05
		})
	end)))

	local v183 = u25
	local v184 = task.delay
	local v185 = u27.startedAt + 24.5 - workspace:GetServerTimeNow()
	v183:Add(v184(math.max(v185, 0), function()
		u25:Add(u16.new())
		u25:Add(u14.observeCharacter(u4.LocalPlayer, function(_, u186)
			local u187 = u17.new()
			u187:Add(task.spawn(function()
				local u188 = u186:WaitForChild("Humanoid")
				if u188 then
					local v189 = u188:WaitForChild("Animator")
					if v189 then
						local u190 = v189:LoadAnimation(script.Dance)
						u190.Priority = Enum.AnimationPriority.Action
						u41 = u190
						local u191 = 0
						u187:Add(u2.PostSimulation:Connect(function(p192)
							workspace:GetServerTimeNow()
							local v193 = u27.startedAt + 84.5 - workspace:GetServerTimeNow()
							if math.max(v193, 0) > 0 then
								if not u190.IsPlaying then
									u190:Play()
								end
							elseif u188.MoveDirection ~= Vector3.new(0, 0, 0) or u20:GetAttribute("Stealing") then
								u191 = 0
								if u190.IsPlaying then
									u190:Stop()
								end
							else
								if u191 < 3 then
									u191 = u191 + p192
									return
								end
								if not u190.IsPlaying then
									u190:Play()
									return
								end
							end
						end))
						u187:Add(function()
							u190:Stop()
							u190:Destroy()
							u41 = nil
						end)
					end
				else
					return
				end
			end))
			return u187:WrapClean()
		end))
	end))

	u12:Update()
	u10:UpdateOST()
end

function v5.OnStop(_)
	u25:Destroy()
	u26 = nil
end

function v5.OnLoad(_) end

return v5