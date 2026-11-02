--[[
    Deivy Behavior.lua (v11.1 - Lógica Dusekkar + Retraso 0.75s)
    
    CHANGELOG (v11.1):
    - CORREGIDO (Callback/OnZap): El cliente ya no envía 'mouseHit'.
    - CORREGIDO (OnZap): El SERVIDOR ahora espera 0.75s y LUEGO
      le pregunta al CLIENTE por la posición del mouse usando
      'Network:FireClientConnection(..., "GetMousePosition", ...)'.
    - Esto imita la lógica de Dusekkar.PlasmaBeam (Línea 282)
      mientras mantiene tu 'task.delay(0.75, ...)' para la animación.
    - REQUIERE EL PARCHE DE 'Slowness.lua' (v12.2) PARA FUNCIONAR.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Network = require(ReplicatedStorage.Modules.Network)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Util = require(ReplicatedStorage.Modules.Util)
local Statuses = require(ReplicatedStorage.Modules.Statuses)
local Hitboxes = require(ReplicatedStorage.Modules.Hitboxes)

local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

local LOCAL_PLAYER = IsClient and (Players.LocalPlayer or Players.PlayerAdded:Wait()) or nil

local DeivyBehavior = {}
local SHORT_COOLDOWN = 3.5 -- Cooldown corto por fallo

-- ===================================================================
-- LÓGICA COMPARTIDA
-- ===================================================================

function DeivyBehavior.UpgradeLantern(lantern)
	local levelColors = {
		Color3.fromRGB(0, 174, 255),
		Color3.fromRGB(118, 45, 255)
	}
	local level = lantern:GetAttribute("Level")
	if not level or level < 1 or level > #levelColors then return end
	local newColor = levelColors[level]

	for _, descendant in pairs(lantern:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Material == Enum.Material.Neon then
			descendant.Color = newColor
		elseif descendant:IsA("Light") then
			descendant.Color = newColor
		elseif descendant:IsA("ParticleEmitter") then
			descendant.Color = ColorSequence.new(newColor)
		elseif descendant:IsA("Decal") then
			descendant.Color3 = Color3.new(newColor.R / 3, newColor.G / 3, newColor.B / 3)
		end
	end
end

-- ===================================================================
-- HABILIDADES (Cliente)
-- ===================================================================

DeivyBehavior.Abilities = {
	["Swap"] = {
		["Name"] = "Swap",
		["LayoutOrder"] = 4,
		["KeybindType"] = "AltAbility4",
		["Icon"] = "rbxassetid://86715533828811",
		["Callback"] = function(character)
			if IsClient then
				local lanternFolder = character.Rig:FindFirstChild("_Lanterns")
				if not lanternFolder then return end
				local lanterns = lanternFolder:GetChildren()
				if #lanterns == 0 then return end
				if not character.SelectLantern then return end

				local currentHL = character.SelectionHL 
				local currentLantern = currentHL and currentHL.Parent
				local currentIndex = currentLantern and table.find(lanterns, currentLantern) or 0

				local nextIndex = currentIndex + 1
				if nextIndex > #lanterns then
					nextIndex = 1
				end
				character.SelectLantern(lanterns[nextIndex])
			end
		end
	},
	["Buy"] = {
		["Name"] = "Buy",
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://132289860246962",
		["Callback"] = function(character)
			if IsClient then
				Network:FireServerConnection("Deivy_Buy_"..character.Player.Name, "REMOTE_EVENT")
			end
		end
	},
	["Zap"] = {
		["Name"] = "Zap",
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://125360611591968",
		["Callback"] = function(character)
			if IsClient then
				Network:FireServerConnection("Deivy_Zap_"..character.Player.Name, "REMOTE_EVENT")
			end
		end
	},
	["Upgrade"] = {
		["Name"] = "Upgrade",
		["LayoutOrder"] = 3,
		["KeybindType"] = "AltAbility3",
		["Icon"] = "rbxassetid://72823847058475",
		["Callback"] = function(character)
			if IsClient then
				if not character.SelectionHL or not character.SelectionHL.Parent then
					Util:CreateWarning("DeivyWarning", "No lantern selected", character.Config.WarningTemplate)
				end
				Network:FireServerConnection("Deivy_Upgrade_"..character.Player.Name, "REMOTE_EVENT")
			end
		end
	}
}


-- ===================================================================
-- LÓGICA DEL SERVIDOR
-- ===================================================================

function DeivyBehavior.Created(_, character)
	if IsServer then

		character.State = {
			BuyReady = true,
			UpgradeReady = true,
			ZapReady = true
		}

		-- --- LÓGICA DE HABILIDADES (Servidor) ---

		local function OnBuy(player)
			if not character.State.BuyReady then
				return Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Buy", false, "Ability on cooldown")
			end

			local config = character.Config
			local lanternFolder = character.LanternFolder
			local cost = config.BuyCost
			local maxLanterns = config.MaxLanterns
			local currentPoints = character.Rig:GetAttribute("CurrentPoints") or 0
			local currentLanternCount = #lanternFolder:GetChildren()

			if currentLanternCount >= maxLanterns then
				return Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Buy", false, "Max lanterns reached")
			end
			if currentPoints < cost then
				return Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Buy", false, "Not enough points")
			end

			-- Éxito
			character.State.BuyReady = false
			character.Rig:SetAttribute("CurrentPoints", currentPoints - cost)
			Util:CreateSpeedMultiplier(character.Player, 0.01, "DeivyBuy", 1.5, true)

			task.delay(0.8, function()
				if not character or not character.LanternFolder then return end

				local newLantern = config.LanternTemplate:Clone()
				newLantern:SetAttribute("Level", 0)
				if newLantern.PrimaryPart then
					newLantern.PrimaryPart.Anchored = true
				end
				newLantern.Parent = character.LanternFolder
			end)

			Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Buy", true)
			pcall(Sounds.Play, config.Sounds.Buy, { Parent = character.Rig.PrimaryPart })

			task.delay(config.BuyCooldown, function()
				if character and character.State then
					character.State.BuyReady = true
				end
			end)
		end

		local function OnUpgrade(player)
			if not character.State.UpgradeReady then
				return Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Upgrade", false, "Ability on cooldown")
			end

			character.AbilitiesDisabled = true
			local config = character.Config
			local lantern = character.SelectedLantern

			if not lantern or not lantern.Parent then
				character.AbilitiesDisabled = false
				Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Upgrade", false, "No lantern selected")
				return
			end

			local level = lantern:GetAttribute("Level") or 0
			if level >= 2 then
				character.AbilitiesDisabled = false
				Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Upgrade", false, "Lantern is max level")
				return
			end

			local cost = (level == 0) and config.Level1Cost or config.Level2Cost
			local currentPoints = character.Rig:GetAttribute("CurrentPoints") or 0

			if currentPoints < cost then
				character.AbilitiesDisabled = false
				Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Upgrade", false, "Not enough points")
				return
			end

			-- Éxito
			character.State.UpgradeReady = false
			character.Rig:SetAttribute("CurrentPoints", currentPoints - cost)
			lantern:SetAttribute("Level", level + 1)
			Util:CreateSpeedMultiplier(character.Player, 0.01, "DeivyUpgrade", 1.5, true)

			Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Upgrade", true)
			pcall(Sounds.Play, config.Sounds.Upgrade, { Parent = character.Rig.PrimaryPart })
			Network:FireAllClientConnection("Deivy_UpgradeVisual", "REMOTE_EVENT", lantern)

			task.delay(1.5, function()
				if character then character.AbilitiesDisabled = false end
			end)

			task.delay(config.UpgradeCooldown, function()
				if character and character.State then
					character.State.UpgradeReady = true
				end
			end)
		end

		-- =================================================
		-- INICIO DE LA FUNCIÓN ONZAP MODIFICADA (v12.0)
		-- =================================================
		local function OnZap(player)
			if not character.State.ZapReady then
				return Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Zap", false, "Ability on cooldown")
			end

			local lanternFolder = character.LanternFolder
			local currentLanternCount = #lanternFolder:GetChildren()

			if currentLanternCount == 0 then
				Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Zap", false, "No lanterns available")
				character.State.ZapReady = false
				task.delay(SHORT_COOLDOWN, function()
					if character and character.State then character.State.ZapReady = true end
				end)
				return
			end

			local lantern = character.SelectedLantern
			if not lantern or not lantern.Parent then
				Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Zap", false, "No lantern selected")
				character.State.ZapReady = false
				task.delay(SHORT_COOLDOWN, function()
					if character and character.State then character.State.ZapReady = true end
				end)
				return
			end

			local level = lantern:GetAttribute("Level") or 0
			local effects = character.Config[("Level%sEffects"):format(level)]

			if not effects or not effects.Killer or not effects.Survivor or not effects.Yourself then
				warn("DEIVY ZAP - ADVERTENCIA: Level" .. level .. "Effects está incompleto o falta en el ConfigModule. No se aplicarán efectos.")
				warn("Asegúrate de que 'Killer', 'Survivor' y 'Yourself' estén definidos DENTRO de Level" .. level .. "Effects (incluso si están vacíos: {}).")
				effects = { Killer = {}, Survivor = {}, Yourself = {} } 
			end

			character.State.ZapReady = false
			character.AbilitiesDisabled = true
			Network:FireClientConnection(player, "Deivy_Result", "REMOTE_EVENT", "Zap", true)
			pcall(Sounds.Play, character.Config.Sounds.Zap, { Parent = character.Rig.PrimaryPart })

			Util:CreateSpeedMultiplier(character.Player, 0.01, "DeivyZap", 1.5, true) 

			task.delay(0.75, function()
				if not character or not character.Rig or not character.Player then return end

				local targetPos = Network:FireClientConnection(player, "GetMousePosition", "REMOTE_FUNCTION")

				if not targetPos or typeof(targetPos) ~= "Vector3" then
					targetPos = (character.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position
				end

				local hasAppliedSelfEffects = false
				local zapSize = character.Config.ZapSize or Vector3.new(3, 3, 50)
				local startPos = (character.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3)).Position 
				local zapCFrame = CFrame.lookAt(startPos, targetPos) * CFrame.new(0, 0, -(zapSize.Z / 2))

				Hitboxes:CreateHitbox(character.Player, {
					Size = zapSize,
					CFrame = zapCFrame,          
					Damage = 1,                 
					Time = 0.05,                
					PredictVelocity = false,    
					HitMultiple = true,
					NoLineOfSight = true, 
					FriendlyFire = true,  
					Connections = {
						Hit = function(hitCharacter)
							local _, entityType = Util:GetEntityType(hitCharacter)
							pcall(Sounds.Play, character.Config.Sounds.ZapHit, { Parent = hitCharacter.PrimaryPart })

							local hitValidTarget = false

							-- [Lógica de Slasher/Chance: Pasar el Modelo]
							if entityType == "Humanoid" and hitCharacter.Parent.Name == "Killers" then
								hitValidTarget = true
								if next(effects.Killer) then
									for effect, data in pairs(effects.Killer) do
										-- ¡Pasa el Modelo!
										Statuses:ApplyStatus(hitCharacter, effect, data)
									end
								end
							elseif entityType == "Humanoid" and hitCharacter.Parent.Name == "Survivors" then
								hitValidTarget = true
								if next(effects.Survivor) then
									for effect, data in pairs(effects.Survivor) do
										-- ¡Pasa el Modelo!
										Statuses:ApplyStatus(hitCharacter, effect, data)
									end
								end
							end

							-- [Lógica de Rook/Elliot: Pasar el Jugador]
							if hitValidTarget and not hasAppliedSelfEffects and next(effects.Yourself) then
								hasAppliedSelfEffects = true 
								for effect, data in pairs(effects.Yourself) do
									-- ¡Pasa el Jugador!
									Statuses:ApplyStatus(character.Player, effect, data) 
								end
							end
						end
					}
				})

				if lantern and lantern.Parent then
					lantern:Destroy()
				end
				character.SelectedLantern = nil 
			end)

			task.delay(2.0, function()
				if character then character.AbilitiesDisabled = false end
			end)

			task.delay(character.Config.ZapCooldown, function()
				if character and character.State then
					character.State.ZapReady = true
				end
			end)
		end
		-- =================================================
		-- FIN DE LA FUNCIÓN ONZAP MODIFICADA (v12.0)
		-- =================================================

		local function OnSwap(player, lantern)
			if player.UserId ~= character.Player.UserId then
				return player:Kick("Deivy: Bad Swap")
			end
			if lantern and lantern.Parent and lantern.Parent.Name == "_Lanterns" and lantern:IsDescendantOf(character.Rig) then
				character.SelectedLantern = lantern
			else
				character.SelectedLantern = nil
			end
		end

		-- --- LÓGICA DE PASIVAS (Servidor) ---

		local function OnGeneratorComplete(player)
			if player ~= character.Player then return end
			local currentPoints = character.Rig:GetAttribute("CurrentPoints") or 0
			local reward = character.Config.GeneratorReward or 25
			character.Rig:SetAttribute("CurrentPoints", currentPoints + reward)
		end

		local function StartPassiveIncomeLoop()
			task.spawn(function()
				while character and character.Rig and character.Rig.Parent do
					local survivors = workspace.Players:FindFirstChild("Survivors")
					local reward = 0
					local interval = 15

					if survivors and Util:IsAlive(character.Rig) then
						local count = #survivors:GetChildren()

						if count == 1 then
							reward = character.Config.OvertimeReward or 20
							interval = character.Config.OvertimeInterval or 10
						elseif count > 1 then
							reward = 10
							interval = 15
						end

						if reward > 0 then
							local currentPoints = character.Rig:GetAttribute("CurrentPoints") or 0
							character.Rig:SetAttribute("CurrentPoints", currentPoints + reward)
						end
					end

					task.wait(interval)
				end
			end)
		end

		-- --- INICIALIZACIÓN (Servidor) ---

		character.LanternFolder = Instance.new("Folder")
		character.LanternFolder.Name = "_Lanterns"
		character.LanternFolder.Parent = character.Rig
		character.SelectedLantern = nil
		character.Rig:SetAttribute("CurrentPoints", character.Config.PointsOnSpawn or 0)

		local pName = character.Player.Name
		character.NetConn = {
			Buy = Network:SetConnection("Deivy_Buy_"..pName, "REMOTE_EVENT", function(player) OnBuy(player) end),
			Upgrade = Network:SetConnection("Deivy_Upgrade_"..pName, "REMOTE_EVENT", function(player) OnUpgrade(player) end),
			Zap = Network:SetConnection("Deivy_Zap_"..pName, "REMOTE_EVENT", function(player) OnZap(player) end),
			Swap = Network:SetConnection("Deivy_SwapLantern_"..pName, "REMOTE_EVENT", function(player, lantern) OnSwap(player, lantern) end),
			Gen = Network:SetConnection("Deivy_GeneratorComplete_"..pName, "REMOTE_EVENT", function(player) OnGeneratorComplete(player) end)
		}

		StartPassiveIncomeLoop()
	end
end

-- ===================================================================
-- LÓGICA DEL CLIENTE
-- ===================================================================

function DeivyBehavior.CreatedPost(_, character)
	if IsClient then

		if not character.Player.Character then
			character.Player.CharacterAdded:Wait()
		end
		character.Rig = character.Player.Character

		if character.Rig == LOCAL_PLAYER.Character then
			local lastPoints = nil

			local pointsUI = character.Config.PointsTemplate:Clone()
			pointsUI.Parent = character.Player.PlayerGui.TemporaryUI
			character.PointsUI = pointsUI

			local function UpdatePointsUI()
				local currentPoints = character.Rig:GetAttribute("CurrentPoints") or 0
				pointsUI.Amt.TextColor3 = currentPoints > 0 and Color3.new(1, 1, 1) or Color3.fromRGB(200, 40, 40)
				pointsUI.Amt.Text = "$" .. currentPoints

				if lastPoints ~= nil and lastPoints ~= currentPoints then
					local pointsDiff = currentPoints - lastPoints
					local pointsText = character.Config.AddedTemplate:Clone()
					local existingText = pointsUI:FindFirstChild(pointsText.Name)
					if existingText then existingText:Destroy() end

					pointsText.TextColor3 = pointsDiff > 0 and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25)
					pointsText.Text = (pointsDiff > 0 and "+" or "-") .. "$" .. math.abs(pointsDiff)
					pointsText.Parent = pointsUI

					task.delay(0.5, function()
						if pointsText and pointsText.Parent then
							TweenService:Create(pointsText, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
								Position = pointsText.Position - UDim2.new(0, 0, 0.5, 0),
								TextTransparency = 1
							}):Play()
							game.Debris:AddItem(pointsText, 1)
						end
					end)
					Sounds:Play("switch")
				end
				lastPoints = currentPoints
			end

			UpdatePointsUI()
			character.PointsChangedConn = character.Rig:GetAttributeChangedSignal("CurrentPoints"):Connect(UpdatePointsUI)

			character.ResultConn = Network:SetConnection("Deivy_Result", "REMOTE_EVENT", function(abilityName, success, reason)
				local animName = success and abilityName or abilityName .. "2"
				local anim = character.Animations[animName]

				if anim then
					anim:Play()
				end

				if not success and reason ~= "Ability on cooldown" then
					Util:CreateWarning("DeivyWarning", reason or "Action Failed", character.Config.WarningTemplate)
				end
			end)
		end

		local lanternFolder = character.Rig:WaitForChild("_Lanterns", 30) 
		if not lanternFolder then
			warn("Deivy: _Lanterns folder not found for", character.Name, "after 30s.")
			return 
		end

		local function SetupLanternTracking()
			local function SelectLantern(lantern)
				if character.Rig ~= LOCAL_PLAYER.Character then return end

				local currentHL = character.SelectionHL
				if currentHL and currentHL.Parent then
					currentHL:Destroy()
				end

				if (currentHL and currentHL.Parent == lantern) or not lantern then
					character.SelectionHL = nil
					Network:FireServerConnection("Deivy_SwapLantern_"..character.Player.Name, "REMOTE_EVENT", nil)
					return
				end

				Sounds:Play("switch")
				local newHL = character.Config.HL:Clone()
				newHL.Parent = lantern
				character.SelectionHL = newHL

				if character.Behavior.CustomHL then
					character.Behavior.CustomHL(newHL)
				end

				TweenService:Create(newHL, TweenInfo.new(0.5), {
					FillTransparency = 1
				}):Play()

				Network:FireServerConnection("Deivy_SwapLantern_"..character.Player.Name, "REMOTE_EVENT", lantern)
			end
			return SelectLantern
		end

		local function StartLanternOrbit(lanternFolder)
			character.LanternOrbitConn = RunService.Heartbeat:Connect(function()
				if not character or not character.Rig or not character.Rig.Parent then
					if character.LanternOrbitConn then
						character.LanternOrbitConn:Disconnect()
						character.LanternOrbitConn = nil
					end
					return
				end

				local rootPart = character.Rig:FindFirstChild("HumanoidRootPart")
				if not rootPart then return end

				local lanterns = lanternFolder:GetChildren()
				local totalLanterns = #lanterns
				if totalLanterns == 0 then return end

				local orbitRadius = 3.5
				local orbitSpeed = 2

				for i, lantern in ipairs(lanterns) do
					if lantern and lantern.PrimaryPart then
						local baseAngle = (i * (math.pi * 2 / totalLanterns))
						local orbitAngle = (tick() * orbitSpeed) + baseAngle
						local x = math.cos(orbitAngle) * orbitRadius
						local z = math.sin(orbitAngle) * orbitRadius
						local y = 1.5

						local rootPos = rootPart.Position
						local lanternTargetPos = rootPos + Vector3.new(x, y, z)

						lantern:SetPrimaryPartCFrame(CFrame.lookAt(lanternTargetPos, rootPos))
					end
				end
			end)
		end

		character.SelectLantern = SetupLanternTracking()
		StartLanternOrbit(lanternFolder)

		character.UpgradeVisualConn = Network:SetConnection("Deivy_UpgradeVisual", "REMOTE_EVENT", function(lantern)
			if lantern and lantern.Parent and lantern:IsDescendantOf(character.Rig) then
				DeivyBehavior.UpgradeLantern(lantern)
			end
		end)
	end
end

-- ===================================================================
-- LIMPIEZA
-- ===================================================================

function DeivyBehavior.Destroyed(_, character)
	if IsServer then
		if character.NetConn then
			for _, conn in pairs(character.NetConn) do
				conn:Disconnect()
			end
			character.NetConn = nil
		end

		if character.LanternFolder then
			character.LanternFolder:Destroy()
		end

	elseif IsClient then
		if character.ResultConn then character.ResultConn:Disconnect() end
		if character.UpgradeVisualConn then character.UpgradeVisualConn:Disconnect() end
		if character.PointsUI then character.PointsUI:Destroy() end
		if character.PointsChangedConn then character.PointsChangedConn:Disconnect() end

		if character.LanternOrbitConn then
			character.LanternOrbitConn:Disconnect()
			character.LanternOrbitConn = nil
		end

		if character.SelectionHL and character.SelectionHL.Parent then
			character.SelectionHL:Destroy()
			character.SelectionHL = nil
		end
	end
end

return DeivyBehavior