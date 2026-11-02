-- Doombringer Behavior (v1.27 - Aeternus Port)
-- 1. [FIX] 'Scan' (Cliente) ahora llama a 'Util:RevealPlayerAura(character, ...)' (con ':') (Línea 818).
-- 2. [FIX] 'Ban-streak' (Cliente) Eliminado el reveal de aura global al inicio (Línea 790).
-- 3. [FIX] 'Ban-streak' (Servidor) Añadido 'RevealPlayerAuraTo' al golpear (Línea 251).
-- 4. [FIX] 'Ban-streak' (Cliente) Raycast de rebote cambiado a *12 (Línea 160).
-- 5. [FIX] 'Ban-wave' (Servidor) Altura de la hitbox aumentada a 16 (Línea 727).
-- 6. [FIX] 'Ban-wave' (Cliente) Offset de pilar cambiado a +1.1 (Línea 297).

-- Required Modules (Aeternus Framework)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris") 
local UserInputService = game:GetService("UserInputService")

-- Game Modules (Aeternus Framework)
local Util = require(ReplicatedStorage.Modules.Util)
local Hitboxes = require(ReplicatedStorage.Modules.Hitboxes)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Statuses = require(ReplicatedStorage.Modules.Statuses) 
local Network = require(ReplicatedStorage.Modules.Network)
local Actors = require(ReplicatedStorage.Modules.Actors)
local Maid = require(ReplicatedStorage.Modules.Misc.Maid)
local Ragdolls = require(ReplicatedStorage.Modules.Ragdolls) 
local Lighting = require(ReplicatedStorage.Modules.Schematics.Lighting)

-- [PORT] Módulos personalizados de Doombringer
local LightningM = require(script.Parent.Config.LightningM)
local BanwavePillarAsset = script.Parent.Config.BanwavePillar -- Arreglo del usuario (ruta correcta)

-- Constants
local IS_SERVER = RunService:IsServer()
local IS_CLIENT = RunService:IsClient()
local LOCAL_PLAYER = IS_CLIENT and Players.LocalPlayer
local CURRENT_CAMERA = IS_CLIENT and workspace.CurrentCamera

local RAYCAST_PARAMS = RaycastParams.new()
RAYCAST_PARAMS.FilterType = Enum.RaycastFilterType.Exclude

-- Module Definition
local DoomBehavior = {}
DoomBehavior.Abilities = {}

--[[
	Funciones de Ayuda (Porteadas de Ban-streak)
]]

-- [CLIENTE]
local Client_BounceFunctions = {}

function Client_BounceFunctions.DisconBounce(p99)
	if p99.Bouncing then
		if p99.Bouncing.Con then
			p99.Bouncing.Con:Disconnect()
			p99.Bouncing.Con = nil
		end
		p99.Bouncing.Seed = nil
	end
	p99.Animations.BounceIdle:Stop(0.05)
end

function Client_BounceFunctions.CancelBounce(p_u_100, p101, p102)
	p_u_100.Bouncing = nil
	Network:FireServerConnection(("%*DB_StreakEnd"):format(p_u_100.Player.Name), "REMOTE_EVENT", p101)
	Network:FireConnection("DisableSprinting", "Bouncing", false)
	if not p102 then
		p_u_100.Animations.BounceEnded:Play(0.05)
	end
	TweenService:Create(p_u_100.Player, TweenInfo.new(0.5), {
		["CameraMaxZoomDistance"] = 12,
		["CameraMinZoomDistance"] = 0.5
	}):Play()
	task.delay(0.25, function()
		if p_u_100.BounceSM then
			TweenService:Create(p_u_100.BounceSM, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
				["Value"] = 1
			}):Play()
			Debris:AddItem(p_u_100.BounceSM, 1)
		end
	end)
end

function Client_BounceFunctions.DoBounce(p_u_72)
	local v_u_73 = p_u_72.Animations
	local v_u_74 = p_u_72.Rig.PrimaryPart
	local v_u_75 = p_u_72.Rig.Humanoid
	local v_u_76 = p_u_72.Bouncing
	if v_u_76 then
		if v_u_76.Bounces >= p_u_72.Config.BanstreakMax then
			Network:FireServerConnection(("%*DB_StreakBounce"):format(p_u_72.Player.Name), "REMOTE_EVENT")
			Client_BounceFunctions.CancelBounce(p_u_72, nil, true)
		else
			v_u_76.Bounces = v_u_76.Bounces + 1
			local v_u_77 = v_u_76.Bounces == p_u_72.Config.BanstreakMax
			local v_u_78 = math.random()
			v_u_76.Seed = v_u_78
			local v79 = v_u_74.CFrame
			local v80 = v79.LookVector + v79.UpVector * (0.65 + 0.01 * v_u_76.Bounces)
			local v_u_81 = v_u_73.BounceStart
			v_u_81:Play(0.05)
			Network:FireServerConnection(("%*DB_StreakBounce"):format(p_u_72.Player.Name), "REMOTE_EVENT", v_u_77)
			v_u_74.AssemblyLinearVelocity = v80.Unit * (p_u_72.Config.BanstreakSpeed + v_u_76.Bounces * 5)
			local v82 = Util:CreateFOVMultiplier(p_u_72.Player, 1.05, "BounceZoom")
			TweenService:Create(v82, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
				["Value"] = 1
			}):Play()
			Debris:AddItem(v82, 0.15)
			task.delay(v_u_81.Length, function()
				if v_u_78 == v_u_76.Seed then
					v_u_81:Stop(0)
					if v_u_77 then
						v_u_73.BounceSlam:Play(0, 1, 1.5)
						return
					end
					v_u_73.BounceIdle:Play(0)
				end
			end)
			v_u_76.Con = RunService.Heartbeat:Connect(function(p_u_83)
				local v91, _ = pcall(function()
					if Util:IsAlive(LOCAL_PLAYER.Character) then
						RAYCAST_PARAMS.FilterDescendantsInstances = { workspace.Players }
						local v84 = v_u_75.MoveDirection
						if v84.Magnitude > 0 then
							local v85 = v84.Unit
							local v86 = v_u_74
							v86.AssemblyLinearVelocity = v86.AssemblyLinearVelocity + v85 * Vector3.new(1, 0, 1) * 0.25
						end
						local v87 = v_u_74.Position
						local v88 = v87 + v_u_74.Velocity * p_u_83

						-- [FIX v1.27] Raycast ajustado a *12
						local v89 = workspace:Raycast(v87, (v88 - v87) * 12, RAYCAST_PARAMS) 

						if v89 and v89.Instance.Transparency < 0.99 then
							local v90 = v_u_73.BounceIdle.IsPlaying or v_u_73.BounceStart.TimePosition >= v_u_73.BounceStart.Length - 0.3
							Client_BounceFunctions.DisconBounce(p_u_72)
							if v90 then
								Client_BounceFunctions.DoBounce(p_u_72)
							else
								Client_BounceFunctions.CancelBounce(p_u_72, true)
							end
						else
							if v_u_74.Velocity.Magnitude < 0.5 then
								Client_BounceFunctions.DisconBounce(p_u_72)
								Client_BounceFunctions.CancelBounce(p_u_72)
							end
							return
						end
					else
						Client_BounceFunctions.DisconBounce(p_u_72)
						Client_BounceFunctions.CancelBounce(p_u_72)
						return
					end
				end)
				if not v91 then
					Client_BounceFunctions.DisconBounce(p_u_72)
					Client_BounceFunctions.CancelBounce(p_u_72)
				end
			end)
		end
	else
		return
	end
end

function Client_BounceFunctions.StartBounce(p_u_92)
	local v_u_93 = p_u_92.Animations.BounceCharge
	v_u_93:Play(0.1)
	p_u_92.Bouncing = {
		["Bounces"] = 0
	}
	TweenService:Create(p_u_92.Player, TweenInfo.new(v_u_93.Length), {
		["CameraMaxZoomDistance"] = 10,
		["CameraMinZoomDistance"] = 10
	}):Play()
	task.delay(v_u_93.Length - 0.05, function()
		if p_u_92.Bouncing then
			v_u_93:Stop(0.05)
			pcall(function()
				Client_BounceFunctions.DoBounce(p_u_92)
			end)
			TweenService:Create(p_u_92.Player, TweenInfo.new(0.5), {
				["CameraMaxZoomDistance"] = 17,
				["CameraMinZoomDistance"] = 17
			}):Play()
			local v_u_94 = p_u_92.Rig.PrimaryPart
			local v_u_95 = nil
			TweenService:Create(p_u_92.Rig.Humanoid, TweenInfo.new(0.25), {
				["CameraOffset"] = Vector3.new(2, 0, 0)
			}):Play()
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			p_u_92.Rig:SetAttribute("DisableShiftLockMovement", true)
			v_u_95 = RunService.RenderStepped:Connect(function(p96)
				local v97 = p96 * 60
				if p_u_92.Bouncing or not v_u_94.Parent then
					local _, v98 = CURRENT_CAMERA.CFrame:ToOrientation()
					v_u_94.CFrame = v_u_94.CFrame:Lerp(CFrame.new(v_u_94.Position) * CFrame.Angles(0, v98, 0), 0.25 * v97)
				else
					v_u_95:Disconnect()
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					p_u_92.Rig:SetAttribute("DisableShiftLockMovement", nil)
					TweenService:Create(p_u_92.Rig.Humanoid, TweenInfo.new(0.25), {
						["CameraOffset"] = Vector3.new(0, 0, 0)
					}):Play()
				end
			end)
		end
	end)
end


--[[
	Lifecycle Functions (Porteadas)
]]

function DoomBehavior.Created(_, killerInfo)
	killerInfo.Maid = Maid.new()
	killerInfo.Meta = {}
	killerInfo.Instances = {}
	killerInfo.NetworkConnections = {} 
	killerInfo.ConnectionDictionary = {} 

	if IS_SERVER then
		killerInfo.State = {
			SwingReady = true,
			BanwaveReady = true,
			BanstreakReady = true,
			ScanReady = true, -- [FIX v1.21] Renombrado
		}

		-- [AETERNUS-SERVER] Escuchar los eventos del cliente para 'Ban-streak'
		local streakBounceName = ("%*DB_StreakBounce"):format(killerInfo.Player.Name)
		Network:SetConnection(streakBounceName, "REMOTE_EVENT", function(player, isFinalSlam)
			if player ~= killerInfo.Player then return end

			Sounds:Play(killerInfo.Config.Sounds.BSlam, { Parent = killerInfo.Rig.PrimaryPart })
			if isFinalSlam then
				Sounds:Play(killerInfo.Config.Sounds.BSlamExtra, { Parent = killerInfo.Rig.PrimaryPart })
			end

			-- [FIX v1.25] HitConnection
			local hitConnection = function(character, isPlayer)
				Ragdolls.EnableRagdoll(character, killerInfo.Config.CraterStunTime)
				Sounds:Play(killerInfo.Config.Sounds.Hit2, { Parent = character.PrimaryPart })

				-- [FIX v1.27] Revelar al superviviente golpeado
				Util:RevealPlayerAuraTo(killerInfo.Player, character, 5)
			end

			-- [FIX v1.25] Eliminada la hitbox "Ball"

			-- [FIX v1.26] Hitbox 1: La "Onda de Choque" en el suelo
			Hitboxes:CreateHitbox(killerInfo.Player, {
				Shape = "Cylinder",
				Radius = killerInfo.Config.CraterRadius, -- [FIX v1.26] Usa el radio del Config (7)
				Height = 3, -- Altura baja para que sea plana
				CFrameOffset = CFrame.new(0, -(killerInfo.Rig.PrimaryPart.Size.Y / 2), 0), -- Posicionada en el suelo
				Damage = killerInfo.Config.CraterDamage,
				Time = 0.2,
				Knockback = killerInfo.Config.CraterForce,
				HitMultiple = true,
				Connections = { Hit = hitConnection }
			})
		end)
		table.insert(killerInfo.NetworkConnections, { streakBounceName, "REMOTE_EVENT" })

		local streakEndName = ("%*DB_StreakEnd"):format(killerInfo.Player.Name)
		Network:SetConnection(streakEndName, "REMOTE_EVENT", function(player, didCollide)
			if player ~= killerInfo.Player then return end

			-- [FIX v1.17] ARREGLO DE SOFTLOCK
			killerInfo.AbilitiesDisabled = false 
			killerInfo.State.BanstreakReady = true
			if didCollide then
				-- Opcional: penalizar si choca
			end
		end)
		table.insert(killerInfo.NetworkConnections, { streakEndName, "REMOTE_EVENT" })


	elseif IS_CLIENT and killerInfo.Player == LOCAL_PLAYER then

		-- [AETERNUS-CLIENT] Listener de 'Ban-wave'
		local pillarEventName = "Doom_ShowPillarEffect"
		Network:SetConnection(pillarEventName, "REMOTE_EVENT", function(pillarPos)
			if not killerInfo.Rig or not killerInfo.Rig.Parent or not BanwavePillarAsset then return end
			local pillarClone = BanwavePillarAsset:Clone()
			pillarClone.Anchored = true

			-- [FIX v1.25] Mover 1.1 studs hacia ARRIBA
			pillarClone.CFrame = pillarPos * CFrame.new(0, 1.1, 0)

			local light = pillarClone:FindFirstChildOfClass("PointLight")
			local emitters = {}
			for _, child in pairs(pillarClone:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					table.insert(emitters, child)
				end
			end

			local originalBrightness = light and light.Brightness or 0
			local originalRates = {}
			if light then light.Brightness = 0 end
			for _, emitter in pairs(emitters) do
				originalRates[emitter] = emitter.Rate
				emitter.Rate = 0
			end

			pillarClone.Parent = workspace.Map.Ingame
			Sounds:Play(killerInfo.Config.Sounds.Banwave, { Position = pillarPos.Position })

			local tweenInInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			if light then
				TweenService:Create(light, tweenInInfo, { Brightness = originalBrightness }):Play()
			end
			for _, emitter in pairs(emitters) do
				TweenService:Create(emitter, tweenInInfo, { Rate = originalRates[emitter] }):Play()
			end

			task.delay(3.0, function()
				if not pillarClone or not pillarClone.Parent then return end
				local tweenOutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				if light then
					TweenService:Create(light, tweenOutInfo, { Brightness = 0 }):Play()
				end
				for _, emitter in pairs(emitters) do
					TweenService:Create(emitter, tweenOutInfo, { Rate = 0 }):Play()
				end
				Debris:AddItem(pillarClone, 0.5)
			end)
			Debris:AddItem(pillarClone, 3.5)
		end)
		table.insert(killerInfo.NetworkConnections, { pillarEventName, "REMOTE_EVENT" })

		-- [FIX v1.25] Eliminado el listener 'Doom_RevealSurvivors'. La lógica ahora está en la habilidad.

		-- [PORT] Lógica de limpieza de mapa de Forsaken
		task.spawn(function()
			local v44, v45 = pcall(function()
				local v27 = workspace.Map.Ingame:WaitForChild("Map", 5)
				if v27 then
					local v28 = v27:FindFirstChild("Generators")
					local function v38(p29)
						local v30 = p29.CFrame
						local v31 = v30.UpVector:Dot(Vector3.new(0, 1, 0))
						local v32 = math.abs(v31)
						local v33 = v30.LookVector:Dot(Vector3.new(0, 1, 0))
						local v34 = math.abs(v33)
						local v35 = v30.RightVector:Dot(Vector3.new(0, 1, 0))
						local v36 = math.abs(v35)
						local v37
						if v36 < v32 then
							v37 = "Y"
						else
							v32 = v36
							v37 = "X"
						end
						return v32 < v34 and "Z" or v37
					end
					for _, v39 in pairs(v27:GetDescendants()) do
						if v39:IsA("BasePart") and (v39.Transparency >= 1 and (not v39:IsA("MeshPart") and v39.CanCollide)) then
							local v40 = false
							local v41 = v39.Size
							if v39.Parent.Name == "Conveyors" or v28 and v39:IsDescendantOf(v28) or not v39:IsA("UnionOperation") and (not v39:IsA("IntersectOperation") and (v39.Shape == Enum.PartType.Wedge or v39.Shape == Enum.PartType.CornerWedge)) then
								v40 = true
							else
								local v42 = v38(v39)
								if v41[v42] > 120 and v41.Magnitude - 50 > v41[v42] then
									v40 = true
								else
									for _, v43 in pairs({ "X", "Y", "Z" }) do
										if v43 ~= v42 and v41[v43] > 120 then
											v40 = true
											break
										end
									end
								end
							end
							if not v40 then
								v39:Destroy()
							end
						end
					end
				end
			end)
			if not v44 then
				warn(v45)
			end
		end)
	end
end

function DoomBehavior.Destroyed(_, killerInfo)
	killerInfo.Maid:Destroy()
	if IS_SERVER then
		for v, connData in pairs(killerInfo.NetworkConnections) do
			if Network and connData then
				Network:RemoveConnection(connData[1], connData[2])
				killerInfo.NetworkConnections[v] = nil
			end
		end
	else 
		-- [PORT] Lógica de limpieza de 'Ban-streak'
		if killerInfo.Player == LOCAL_PLAYER and killerInfo.Bouncing then
			killerInfo.Bouncing = nil
			TweenService:Create(LOCAL_PLAYER, TweenInfo.new(0), {
				["CameraMaxZoomDistance"] = 12,
				["CameraMinZoomDistance"] = 0.5
			}):Play()
		end
		-- [AETERNUS-CLIENT] Limpiar el listener de 'Ban-wave'
		Network:RemoveConnection("Doom_ShowPillarEffect", "REMOTE_EVENT")
		-- [FIX v1.25] Limpiar el listener de 'Scan' (eliminado)
	end
	for _, instance in pairs(killerInfo.Instances) do
		if instance and instance.Parent then
			instance:Destroy()
		end
	end
end

function DoomBehavior.OnIntroduction(_, killerInfo, killerRig, duration)
	-- [PORT] Lógica de Introducción
	local v_u_53 = Util:CreateFOVMultiplier(LOCAL_PLAYER, 0.14, "DBIntro", duration)
	local v_u_54 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v55 = killerRig:FindFirstChild("Eye")
	local v_u_56 = true
	local v_u_57
	if v55 then
		local v58 = v55:FindFirstChild("FX")
		if v58 then
			v58:Destroy()
		end
		v_u_57 = killerInfo.Config.EyeFX:Clone()
		v_u_57.Parent = v55
	else
		v_u_57 = nil
	end
	for _, v59 in pairs(killerRig:GetChildren()) do
		if v59:IsA("Highlight") then
			v59:Destroy()
		end
	end
	task.spawn(function()
		if not v_u_54 then return end
		local v60 = v_u_54:WaitForChild("Storm")
		while v_u_56 and v60 and v60.Parent do
			v60.CFrame = v60.CFrame * CFrame.Angles(0, 0.0008726646259971648, 0)
			task.wait()
		end
	end)
	task.spawn(function()
		if not v_u_54 then return end
		local v61 = v_u_54:WaitForChild("Lightning").Position
		local v_u_62 = v_u_54:WaitForChild("Storm"):WaitForChild("Mesh")
		local v63 = Random.new()
		local function v64()
			if v_u_62 and v_u_62.Parent then
				TweenService:Create(v_u_62, TweenInfo.new(0.05), {["VertexColor"] = Vector3.new(1, 1, 1)}):Play()
				task.wait(0.05)
				TweenService:Create(v_u_62, TweenInfo.new(0.05), {["VertexColor"] = Vector3.new(2, 2, 2)}):Play()
				task.wait(0.05)
				TweenService:Create(v_u_62, TweenInfo.new(1, Enum.EasingStyle.Exponential), {["VertexColor"] = Vector3.new(1, 1, 1)}):Play()
			end
		end
		while task.wait(v63:NextNumber(0.3, 0.5)) and (v_u_56 and v_u_62 and v_u_62.Parent) do
			for _ = 1, math.random(2) do
				local v67 = v61 + Vector3.new(math.random(-150, 150), 0, math.random(-50, 50))
				local v68 = v67 + Vector3.new(0, 400, 0)
				local v71 = v68 + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
				LightningM.new(v71, v67, {
					["bends"] = 5,
					["fork_chance"] = 30,
					["color"] = Color3.fromRGB(103, 55, 55),
					["material"] = Enum.Material.Neon,
					["decay"] = 0.03
				}):Draw(workspace)
				task.spawn(v64)
				task.wait(v63:NextNumber(0.1, 0.3))
			end
		end
	end)
	task.delay(0.1, function()
		TweenService:Create(v_u_53, TweenInfo.new(1, Enum.EasingStyle.Back), {Value = 0.9}):Play()
		task.wait(0.15)
		if v_u_54 and v_u_54.Parent then
			TweenService:Create(v_u_54.Moon.GUI.Glare, TweenInfo.new(1), {Rotation = -110}):Play()
			task.wait(0.75)
			if v_u_54 and v_u_54.Parent then
				v_u_54.Cloud.Beam.Transparency = NumberSequence.new(0.5)
				v_u_54.PrimaryPart.Light.Enabled = true
				v_u_54.PrimaryPart.Smoke:Emit(30)
				task.wait(0.45)
				TweenService:Create(v_u_53, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Value = 0.5}):Play()
				task.wait(1)
				if v_u_57 and v_u_57.Parent then
					v_u_57.Flash:Emit(10)
					v_u_57.Long.Enabled = true
				end
			end
		end
	end)
	task.delay(duration, function()
		v_u_56 = false
		if v_u_53 then v_u_53:Destroy() end
		-- killerRig:Destroy() -- No destruir el rig principal
	end)
end

function DoomBehavior.OnVictory(_, state, killerInfo, _, duration)
	-- [PORT] Lógica de Victoria
	if state == "Start" then
		Lighting:SetCustomLighting(killerInfo.Config.OutroLighting)
		LOCAL_PLAYER:SetAttribute("FOVMultipliersDisabled", true)
		CURRENT_CAMERA.FieldOfView = 7
		TweenService:Create(CURRENT_CAMERA, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["FieldOfView"] = 25
		}):Play()
	elseif state == "End" then
		LOCAL_PLAYER:SetAttribute("FOVMultipliersDisabled", nil)
		Lighting:SetAsCurrentLighting()
	end
end

function DoomBehavior.OnExecution(_, killerInfo, targetCharacter)
	-- [PORT] Lógica de Ejecución
	if not killerInfo.Rig then return end

	local isSpecial = targetCharacter.Name == "007n7"
	local velocity = isSpecial and Vector3.new() or (killerInfo.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200
	local delayTime = isSpecial and 3.6 or 3.5

	task.delay(2.1, function()
		Ragdolls.AddProfile(targetCharacter, {
			["AnchorDelay"] = true,
			["Applied"] = os.clock() + 5,
			["Velocity"] = velocity
		})
		local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.BreakJointsOnDeath = false
			humanoid.Health = 0
		end
	end)
	task.delay(delayTime, function()
		if targetCharacter and targetCharacter.PrimaryPart then
			targetCharacter.PrimaryPart.Anchored = false
		end
	end)
end

function DoomBehavior.OnStunned(killerInfo)
	-- [FIX v1.17] Lógica de 'Counter' eliminada
	return false -- Aturdimiento normal
end


--[[
	Ability Definitions
]]

-- M1: Swing
DoomBehavior.Abilities.Swing = {
	LayoutOrder = 0, KeybindType = "MainAbility",
	Icon = "rbxassetid://114090418086193", 
	Cooldown = function(killerInfo) return killerInfo.Config.SwingCooldown end,
	Callback = function(killerInfo)
		if IS_CLIENT then
			-- [PORT] Lógica del cliente
			local anim = killerInfo.Animations["Swing"]
			if anim then anim:Play(0.05) end

			task.delay(1, function()
				if not killerInfo.Rig then return end
				Util:CreateSpeedMultiplier(killerInfo.Rig, 0.9, "Swinging", killerInfo.Animations.Swing.Length - 1)
			end)
			return 
		end

		-- [AETERNUS-SERVER] Lógica del servidor
		if not killerInfo.State.SwingReady then return end
		killerInfo.State.SwingReady = false 

		Sounds:Play(killerInfo.Config.Sounds.Swing, { Parent = killerInfo.Rig.PrimaryPart })

		task.delay(killerInfo.Config.SwingWindup, function()
			if not killerInfo.Rig then return end
			Hitboxes:CreateHitbox(killerInfo.Player, {
				Size = Vector3.new(5, 6, 9),
				CFrameOffset = CFrame.new(0, 0, -4.5),
				Damage = killerInfo.Config.SwingDamage, 
				Time = killerInfo.Config.SwingLinger,
				Knockback = 2,
				HitMultiple = true,
				ExecuteOnKill = true,
				Connections = {
					Hit = function(character, isPlayer)
						Sounds:Play(killerInfo.Config.Sounds.Hit, { Parent = character.PrimaryPart })
						Statuses:ApplyStatus(character, "Slowness", { Level = 1, Duration = 1.5 })
					end,
				}
			})
		end)

		task.delay(killerInfo.Config.SwingCooldown, function()
			if killerInfo and killerInfo.State then
				killerInfo.State.SwingReady = true 
			end
		end)
	end
}

-- Alt 1: Ban-wave
DoomBehavior.Abilities.Banwave = {
	LayoutOrder = 1, KeybindType = "AltAbility1",
	Icon = "rbxassetid://92330475760678", 
	Cooldown = function(killerInfo) return killerInfo.Config.BanwaveCooldown end,
	Callback = function(killerInfo)
		if IS_CLIENT then
			-- [PORT] Lógica del cliente
			Network:FireConnection("DisableSprinting", "Banwave", true)
			local speedMult = Util:CreateSpeedMultiplier(killerInfo.Rig, 0.01, "Banwave")
			local anim = killerInfo.Animations.Banwave
			anim:Play(0.2)

			task.delay(anim.Length - 0.1, function()
				Network:FireConnection("DisableSprinting", "Banwave", false)
				if speedMult then
					TweenService:Create(speedMult, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { Value = 1 }):Play()
					Debris:AddItem(speedMult, 0.5)
				end
			end)
			return 
		end

		-- [AETERNUS-SERVER] Lógica del servidor
		if not killerInfo.State.BanwaveReady then return end
		killerInfo.State.BanwaveReady = false 

		Sounds:Play(killerInfo.Config.Sounds.Banwave, { Parent = killerInfo.Rig.PrimaryPart })
		local pillarCount = killerInfo.Config.BanwaveAmount
		local interval = killerInfo.Config.BanwaveInterval
		local damage = killerInfo.Config.BanwaveDamage

		local windup = 1.125 -- Arreglo del usuario (timing)

		-- [FIX v1.23] Crear RaycastParams para el rayo hacia el suelo
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = { killerInfo.Rig }

		for i = 1, pillarCount do
			local hitboxTime = windup + (i * interval)
			-- [FIX v1.24] 'visualTime' eliminado

			-- [FIX v1.24] Crear la HITBOX y disparar el VISUAL al MISMO TIEMPO
			task.delay(hitboxTime, function()
				if not killerInfo.Rig or not killerInfo.Rig.PrimaryPart then return end
				local currentCF = killerInfo.Rig.PrimaryPart.CFrame -- Obtener CFrame "en vivo"
				local airPos = (currentCF * CFrame.new(0, 0, -10 - (i * 5))).Position
				local rayResult = workspace:Raycast(airPos + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0), rayParams)

				if rayResult and rayResult.Position then
					local groundPos = CFrame.new(rayResult.Position)

					-- [FIX v1.24] 1. Disparar el visual
					Network:FireAllClientConnection("Doom_ShowPillarEffect", "REMOTE_EVENT", groundPos)

					-- [FIX v1.27] 2. Crear la hitbox (Altura cambiada a 16)
					Hitboxes:CreateHitbox(killerInfo.Player, {
						Size = Vector3.new(8, 16, 8),
						CFrame = groundPos,
						Damage = damage,
						Time = 0.2,
						HitMultiple = true,
						Connections = {
							Hit = function(character, isPlayer)
								Sounds:Play(killerInfo.Config.Sounds.Hit, { Parent = character.PrimaryPart })
								Statuses:ApplyStatus(character, "Burning", { Level = 2, Duration = 4 })
								Statuses:ApplyStatus(character, "Exhaustion", { Level = 1, Duration = 5 })
							end,
						}
					})
				end
			end)
		end

		task.delay(killerInfo.Config.BanwaveCooldown, function()
			if killerInfo and killerInfo.State then
				killerInfo.State.BanwaveReady = true 
			end
		end)
	end
}

-- Alt 2: Ban-streak
DoomBehavior.Abilities.Banstreak = {
	LayoutOrder = 2, KeybindType = "AltAbility2",
	Icon = "rbxassetid://127733946232246", 
	Cooldown = function(killerInfo) return killerInfo.Config.BanstreakCooldown end,
	Callback = function(killerInfo)
		if IS_CLIENT then
			-- [PORT] Lógica del cliente
			Network:FireConnection("DisableSprinting", "Bouncing", true)

			-- [FIX v1.27] Eliminado el bucle de reveal

			killerInfo.BounceSM = Util:CreateSpeedMultiplier(killerInfo.Rig, 0.01, "Bouncing")
			Client_BounceFunctions.StartBounce(killerInfo)
			return
		end

		-- [AETERNUS-SERVER]
		if not killerInfo.State.BanstreakReady then return end
		killerInfo.State.BanstreakReady = false
		killerInfo.AbilitiesDisabled = true -- Deshabilitar otras habilidades

		Sounds:Play(killerInfo.Config.Sounds.BSlamStart, { Parent = killerInfo.Rig.PrimaryPart })

		-- [FIX v1.17] El cooldown se activa, pero 'AbilitiesDisabled' se maneja por el listener 'streakEndName'
		task.delay(killerInfo.Config.BanstreakCooldown, function()
			if killerInfo and killerInfo.State then
				killerInfo.State.BanstreakReady = true 
			end
		end)
	end
}

-- [REEMPLAZO v1.26] 'Alt 3 - Scan'
DoomBehavior.Abilities.Scan = {
	Name = "Scan", 
	LayoutOrder = 3, KeybindType = "AltAbility3",
	Icon = "rbxassetid://126957130715030", 
	Cooldown = function(killerInfo) return killerInfo.Config.ScanCooldown end, -- [FIX v1.21] Lee ScanCooldown
	Callback = function(killerInfo)
		if IS_CLIENT then
			-- [PORT] Lógica del cliente (bloquea, anima Y REVELA)
			Network:FireConnection("DisableSprinting", "Scan", true)
			killerInfo.Rig:SetAttribute("DisableRotation", true) 
			local speedMult = Util:CreateSpeedMultiplier(killerInfo.Rig, 0.01, "Scan") -- [FIX v1.23]

			local anim = killerInfo.Animations["Scan"]
			if anim then anim:Play() end

			-- [FIX v1.26] Lógica de reveal movida al cliente, como 'UnstableEye'
			local detectionDuration = 5 -- Duración (puedes mover esto al Config si quieres)
			task.delay(anim.Length - 0.2, function() -- Revelar justo antes de que termine la anim
				for _, character in pairs(workspace.Players.Survivors:GetChildren()) do
					-- [FIX v1.26] Arreglado para usar ':' (método) y sin pcall
					if Util:IsAlive(character) then
						Util:RevealPlayerAura(character, detectionDuration)
					end
				end
			end)

			task.delay(anim.Length - 0.1, function()
				Network:FireConnection("DisableSprinting", "Scan", false)
				killerInfo.Rig:SetAttribute("DisableRotation", nil) 
				if speedMult then speedMult:Destroy() end -- [FIX v1.23]
			end)
			return 
		end

		-- [AETERNUS-SERVER] Lógica del servidor (Solo Cooldown)
		if not killerInfo.State.ScanReady then return end -- [FIX v1.21]
		killerInfo.State.ScanReady = false -- [FIX v1.21]

		-- [FIX v1.25] Lógica de reveal eliminada del servidor

		-- Cooldown
		task.delay(killerInfo.Config.ScanCooldown, function() -- [FIX v1.21]
			if killerInfo and killerInfo.State then
				killerInfo.State.ScanReady = true -- [FIX v1.21]
			end
		end)
	end
}

return DoomBehavior