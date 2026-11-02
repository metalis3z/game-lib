-- CraftingMachineController (Client) — Limited Craft support
-- xenonDev was here

local _ = game:GetService("ProximityPromptService")
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage")
local _ = game:GetService("ContentProvider")
local _ = game:GetService("SoundService")
local _ = game:GetService("TweenService")
local l_HttpService_0 = game:GetService("HttpService")
local _ = game:GetService("RunService")
local _ = game:GetService("StarterGui")
local l_Players_0 = game:GetService("Players")

local _ = require(l_ReplicatedStorage_0.Packages.Serialization)
local v10 = require(l_ReplicatedStorage_0.Packages.Synchronizer)
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween)
local _ = require(l_ReplicatedStorage_0.Packages.TopbarPlus)
local v13 = require(l_ReplicatedStorage_0.Packages.Gradients)
local v14 = require(l_ReplicatedStorage_0.Packages.Observers)
local _ = require(l_ReplicatedStorage_0.Packages.Moonlite)
local _ = require(l_ReplicatedStorage_0.Packages.Squash)
local v17 = require(l_ReplicatedStorage_0.Packages.Timer)
local v18 = require(l_ReplicatedStorage_0.Packages.Trove)
local v19 = require(l_ReplicatedStorage_0.Packages.Spr)
local v20 = require(l_ReplicatedStorage_0.Packages.Net)
local _ = require(l_ReplicatedStorage_0.Controllers.NotificationController)
local _ = require(l_ReplicatedStorage_0.Controllers.NewPlayersController)
local v23 = require(l_ReplicatedStorage_0.Controllers.InterfaceController)
local _ = require(l_ReplicatedStorage_0.Controllers.CharacterController)
local v25 = require(l_ReplicatedStorage_0.Controllers.SoundController)
local _ = require(l_ReplicatedStorage_0.Controllers.PlotController)
local v27 = require(l_ReplicatedStorage_0.Utils.NumberUtils)
local v28 = require(l_ReplicatedStorage_0.Utils.TimeUtils)
local v29 = require(l_ReplicatedStorage_0.Shared.VFX)
local v30 = require(l_ReplicatedStorage_0.Classes.AnimatedButton)
local _ = require(l_ReplicatedStorage_0.Shared.Updates)
local _ = require(l_ReplicatedStorage_0.Shared.Animals)
local v33 = require(l_ReplicatedStorage_0.Shared.Animals)
local _ = require(l_ReplicatedStorage_0.Shared.Index)
local _ = require(l_ReplicatedStorage_0.Datas.Mutations)
local v36 = require(l_ReplicatedStorage_0.Datas.Rarities)
local v37 = require(l_ReplicatedStorage_0.Datas.Animals)

local v38 = v20:RemoteEvent("CraftingMachineService/CraftNow")
local v39 = v20:RemoteEvent("CraftingMachineService/Update")
local v40 = v20:RemoteEvent("CraftingMachineService/Return")
local v41 = v20:RemoteEvent("CraftingMachineService/Claim")
local v42 = v20:RemoteFunction("CraftingMachineService/Delivery")
local v43 = v20:RemoteFunction("CraftingMachineService/Start")
local v44 = v20:RemoteFunction("CraftingMachineService/Fetch")
local ShopPurchase = v20:RemoteEvent("ShopService/Purchase")

-- ===== CRAFT NOW PRODUCT IDs =====
local CRAFT_NOW_PRODUCTS = {
	["Epic"] = 3593483744,
	["Legendary"] = 3593483744,
	["Mythic"] = 3593483744,
	["Brainrot God"] = 3582058537,
	["Secret"] = 3593770893,
	["OG"] = 3593772538,
}

local _ = workspace:WaitForChild("RenderedMovingAnimals")
local l_LocalPlayer_0 = l_Players_0.LocalPlayer

-- ===== VARIABLES DYNAMIQUES POUR L'UI (mises à jour après respawn) =====
local l_CraftingMachine_0 = nil
local l_Content_0 = nil
local l_Time_0 = nil
local l_Buy_0 = nil
local l_Close_0 = nil
local l_BrainrotName_0 = nil

-- Fonction pour mettre à jour les références UI
local function updateUIReferences()
	local playerGui = l_LocalPlayer_0:FindFirstChild("PlayerGui")
	if not playerGui then return false end

	local screenGui = playerGui:FindFirstChild("CraftingMachine")
	if not screenGui then
		-- Essayer de cloner depuis ReplicatedStorage
		local template = l_ReplicatedStorage_0:FindFirstChild("ReplicatedGui")
		if template then
			template = template:FindFirstChild("CraftingMachine")
		end
		if template then
			screenGui = template:Clone()
			screenGui.Parent = playerGui
			screenGui.Enabled = true
		end
	end

	if not screenGui then return false end

	l_CraftingMachine_0 = screenGui:FindFirstChild("CraftingMachine") or screenGui
	if not l_CraftingMachine_0 then return false end

	l_Content_0 = l_CraftingMachine_0:FindFirstChild("Content")
	if l_Content_0 then
		l_Time_0 = l_Content_0:FindFirstChild("Time")
		l_Buy_0 = l_Content_0:FindFirstChild("Buy")
		l_BrainrotName_0 = l_Content_0:FindFirstChild("BrainrotName")
	end
	l_Close_0 = l_CraftingMachine_0:FindFirstChild("Header") and l_CraftingMachine_0.Header:FindFirstChild("Close")

	return true
end

-- Initialiser les références UI
updateUIReferences()

local _ = v18.new()
local _ = v18.new()
local v56 = nil
local v57 = nil  -- craftingList
local v58 = "Epic"  -- selected rarity
local v59 = nil
local v60 = false
local v61 = {}

-- Variable pour éviter les doubles clics sur les limited
local isCraftingLimited = false
local lastLimitedClickTime = 0

-- ===== HELPER : récupérer le stock limité depuis ReplicatedStorage =====
local LIMITED_ATTR_PREFIX = "LimitedStock_"

local function getLimitedStock(rarity: string): number?
	local val = l_ReplicatedStorage_0:GetAttribute(LIMITED_ATTR_PREFIX .. rarity)
	if type(val) == "number" then
		return val
	end
	-- Aussi chercher dans la liste reçue du serveur
	if v57 and v57.List and v57.List[rarity] and v57.List[rarity].LimitedStock ~= nil then
		return v57.List[rarity].LimitedStock
	end
	return nil
end

local function isLimitedSoldOut(rarity: string): boolean
	local stock = getLimitedStock(rarity)
	return stock ~= nil and stock <= 0
end

-- ===== HELPER : récupérer la rareté originale depuis une clé Limited_ =====
local function getOriginalRarity(rarity: string): string
	if string.sub(rarity, 1, 8) == "Limited_" then
		return string.sub(rarity, 9)
	end
	return rarity
end

-- ===== HELPER : vérifier si c'est une recette limitée =====
local function isLimitedRecipe(rarity: string): boolean
	return string.sub(rarity, 1, 8) == "Limited_"
end

-- ===== AFFICHAGE "LIMITED" sur un item de liste =====
local function applyLimitedBadge(frame: Frame, rarity: string, gradientConnection)
	-- Chercher ou créer le label LIMITED
	local existing = frame:FindFirstChild("LimitedLabel")
	local stock = getLimitedStock(rarity)
	local limited = isLimitedRecipe(rarity)

	if stock == nil and not limited then
		-- Pas limité : supprimer le badge si présent
		if existing then existing:Destroy() end
		return
	end

	local label = existing
	if not label then
		label = Instance.new("TextLabel")
		label.Name = "LimitedLabel"
		label.Size = UDim2.new(1, -10, 0, 14)
		label.Position = UDim2.new(0, 5, 1, -16)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.SourceSansBold
		label.TextScaled = true
		label.ZIndex = frame.ZIndex + 1
		label.Parent = frame

		-- Ajouter UIStroke pour le gradient
		local stroke = Instance.new("UIStroke")
		stroke.Name = "GradientStroke"
		stroke.Thickness = 2
		stroke.Parent = label
	end

	if stock ~= nil and stock <= 0 then
		-- SOLD OUT - même style que StockEventController (bordure noire)
		label.Text = "SOLD OUT"
		label.TextColor3 = Color3.fromRGB(255, 0, 0)
		local stroke = label:FindFirstChild("GradientStroke")
		if stroke then 
			stroke.Color = Color3.fromRGB(0, 0, 0)  -- Bordure noire
			stroke.Thickness = 3
		end
	else
		-- LIMITED - Rainbow gradient (comme les animaux Brainrot God)
		label.Text = "LIMITED"
		label.TextColor3 = Color3.new(1, 1, 1)
		-- Appliquer le gradient Rainbow
		local stroke = label:FindFirstChild("GradientStroke")
		if stroke then
			v13.apply(stroke, "Rainbow")
		end
		v13.apply(label, "Rainbow")
	end
end

local function v70()
	local v62 = v10:Get(l_LocalPlayer_0)
	if not v62 then return end
	if v60 then return end
	local l_CraftingMachine_1 = workspace:FindFirstChild("CraftingMachine")
	if not l_CraftingMachine_1 then return end
	local v64 = v62:Get("CraftingMachine")
	if not v64 then return end
	local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
	if v64.Rarity and v64.StartTime and v64.FinishTime then
		local v66 = math.clamp((l_workspace_ServerTimeNow_0 - v64.StartTime) / (v64.FinishTime - v64.StartTime), 0, 1)
		local v67 = l_CraftingMachine_1.VFX:FindFirstChild(v64.Rarity)
		-- Fallback: utiliser ChargeStrike si le VFX pour cette rareté n'existe pas
		if not v67 then
			v67 = l_CraftingMachine_1.VFX:FindFirstChild("ChargeStrike")
		end
		if v67 then
			local cm67 = v67:FindFirstChild("ChargingModel")
			if cm67 then
				v29.enable(cm67.Charging.Charge)
				cm67:ScaleTo((math.lerp(0.25, 1, v66)))
				for _, v69 in cm67.Charging.Charge:GetDescendants() do
					if v69:IsA("ParticleEmitter") then
						v69.TimeScale = math.lerp(0.3, 0.7, v66)
					end
				end
			end
			if not l_CraftingMachine_1.ChargeSoundPart.Sound.IsPlaying then
				l_CraftingMachine_1.ChargeSoundPart.Sound:Play()
				return
			end
		end
	else
		v29.disable(l_CraftingMachine_1.VFX)
		if l_CraftingMachine_1.ChargeSoundPart.Sound.IsPlaying then
			l_CraftingMachine_1.ChargeSoundPart.Sound:Stop()
		end
	end
end

local v71 = v18.new()
local function v80()
	v71:Clean()
	local v72 = v10:Get(l_LocalPlayer_0)
	if not v72 then return end
	l_Time_0.Visible = false
	local v73 = v72:Get("CraftingMachine.FinishTime")
	local l_CraftingMachine_2 = workspace:FindFirstChild("CraftingMachine")
	if not l_CraftingMachine_2 then return end
	local l_Countdown_0 = l_CraftingMachine_2.Overhead.BillboardGui.Countdown
	if not l_Countdown_0 then return end
	l_Time_0.Visible = true
	local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow()
	local v77 = v57 and v58 and v57.List[v58]
	if v77 and v77.CraftTime then
		l_Time_0.Text = ("Crafting Time (<font color=\"#ffff00\">%*</font>)"):format((v28:E(v77.CraftTime)))
	else
		l_Time_0.Text = ""
	end
	if not v73 then
		local v78 = math.max((v57 and v57.Refresh or 0) - l_workspace_ServerTimeNow_1, 0)
		l_Countdown_0.Text = ("Refreshes in %*"):format((v28:E(v78)))
		return
	else
		local v79 = math.max(v73 - l_workspace_ServerTimeNow_1, 0)
		l_Countdown_0.Text = v79 <= 0 and "READY" or v28:E(v79)
		return
	end
end

local v81 = v18.new()
local function v109()
	if v59 == v58 then return end
	local v82 = v10:Get(l_LocalPlayer_0)
	if not v82 then return end
	v81:Clean()
	if not v57 then return end
	local v83 = v58 and v57.List[v58]
	if v58 and not v83 then return end
	v59 = v58
	if not v58 then
		l_Content_0.Visible = false
		return
	end
	l_Content_0.Visible = true
	l_BrainrotName_0.Title.Text = v83.Name

	-- Pour les recettes limitées, utiliser la rareté originale pour le style du contour
	local originalRarity = v83.OriginalRarity or getOriginalRarity(v58)
	local isLimited = isLimitedRecipe(v58)
	local v84 = v36[originalRarity]

	-- Style du nom: Rainbow pour les limited, bordure = gradient OG
	if isLimited then
		-- Nom en Rainbow (comme Brainrot God)
		l_BrainrotName_0.Title.TextColor3 = Color3.new(1, 1, 1)
		v81:Add(v13.apply(l_BrainrotName_0.Title, "Rainbow"))
		-- Bordure = gradient OG (comme la rareté OG)
		l_BrainrotName_0.UIStroke.Color = Color3.new(1, 1, 1)
		v81:Add(v13.apply(l_BrainrotName_0.UIStroke, "OG"))
	elseif v84 and v84.GradientPreset then
		l_BrainrotName_0.Title.TextColor3 = Color3.new(1, 1, 1)
		l_BrainrotName_0.UIStroke.Color = Color3.new(1, 1, 1)
		v81:Add(v13.apply(l_BrainrotName_0.Title, v84.GradientPreset))
		v81:Add(v13.apply(l_BrainrotName_0.UIStroke, v84.GradientPreset))
	elseif v84 then
		l_BrainrotName_0.Title.TextColor3 = v84.Color
		l_BrainrotName_0.UIStroke.Color = v84.Color
	end
	if v37[v83.Name] then
		local v85 = v33:AttachOnViewport(v83.Name, l_BrainrotName_0.ViewportFrame, true)
		if v85 then v81:Add(v85) end
	end

	-- ===== BADGE LIMITED en bas du panneau (sous les animaux) =====
	local detailLimitedLabel = l_Content_0:FindFirstChild("DetailLimitedLabel")
	local stock = getLimitedStock(v58)
	local isLimited = isLimitedRecipe(v58)

	if stock ~= nil or isLimited then
		if not detailLimitedLabel then
			detailLimitedLabel = Instance.new("TextLabel")
			detailLimitedLabel.Name = "DetailLimitedLabel"
			detailLimitedLabel.Size = UDim2.new(1, 0, 0, 24)
			detailLimitedLabel.Position = UDim2.new(0, 0, 1, -28)
			detailLimitedLabel.AnchorPoint = Vector2.new(0, 1)
			detailLimitedLabel.BackgroundTransparency = 1
			detailLimitedLabel.Font = Enum.Font.SourceSansBold
			detailLimitedLabel.TextScaled = true
			detailLimitedLabel.ZIndex = 10
			detailLimitedLabel.Parent = l_Content_0

			-- Ajouter UIStroke pour le gradient
			local stroke = Instance.new("UIStroke")
			stroke.Name = "GradientStroke"
			stroke.Thickness = 2
			stroke.Parent = detailLimitedLabel
		end

		if stock ~= nil and stock <= 0 then
			-- SOLD OUT - même style que StockEventController (bordure noire)
			detailLimitedLabel.Text = "SOLD OUT"
			detailLimitedLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			local stroke = detailLimitedLabel:FindFirstChild("GradientStroke")
			if stroke then 
				stroke.Color = Color3.fromRGB(0, 0, 0)  -- Bordure noire
				stroke.Thickness = 3
			end
		elseif stock ~= nil and stock > 0 then
			-- Afficher le stock restant avec Rainbow gradient
			detailLimitedLabel.Text = "LIMITED • " .. tostring(stock) .. " LEFT"
			detailLimitedLabel.TextColor3 = Color3.new(1, 1, 1)
			local stroke = detailLimitedLabel:FindFirstChild("GradientStroke")
			if stroke then
				v81:Add(v13.apply(stroke, "Rainbow"))
			end
			v81:Add(v13.apply(detailLimitedLabel, "Rainbow"))
		elseif isLimited then
			-- Recette limitée sans stock défini
			detailLimitedLabel.Text = "LIMITED"
			detailLimitedLabel.TextColor3 = Color3.new(1, 1, 1)
			local stroke = detailLimitedLabel:FindFirstChild("GradientStroke")
			if stroke then
				v81:Add(v13.apply(stroke, "Rainbow"))
			end
			v81:Add(v13.apply(detailLimitedLabel, "Rainbow"))
		end
	else
		if detailLimitedLabel then detailLimitedLabel:Destroy() end
	end

	local v86 = {}
	for v87, v88 in v83.Recipe do
		local v89 = v37[v88]
		if v89 then
			local v90 = v36[v89.Rarity]
			local v91 = v81:Clone(l_Content_0.Brainrots.Template)
			v91.LayoutOrder = v90.Weight * 100 + v87
			v91.Title.Text = v88
			v91.Title.TextColor3 = Color3.new(1, 1, 1)
			if v90.GradientPreset then
				v91.UIStroke.Color = Color3.new(1, 1, 1)
				v81:Add(v13.apply(v91.UIStroke, v90.GradientPreset))
			else
				v91.UIStroke.Color = v90.Color
			end
			v91.Visible = true
			v91.Return.Visible = false
			v91.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)
			local v92 = v33:AttachOnViewport(v88, v91.ViewportFrame, true)
			if v92 then v81:Add(v92) end
			v91.Parent = l_Content_0.Brainrots
			if not v86[v88] then v86[v88] = {} end
			table.insert(v86[v88], v91)
			local v93 = v81:Add(v30.new(v91.Return))
			v93:Animate()
			v81:Add(v93.OnActivated:Connect(function()
				for v94, v95 in (v82:Get("AnimalPodiums")) do
					if type(v95) == "table" and v95.Index == v88 and v95.Machine and v95.Machine.Type == "Crafting" and not v95.Machine.Active then
						v40:FireServer(v94)
						return
					end
				end
			end))
		end
	end

	local function v107()
		local v96 = v82:Get("AnimalPodiums")
		local v97 = {}
		for _, v99 in v96 do
			if type(v99) == "table" and v99.Machine and v99.Machine.Type == "Crafting" and not v99.Machine.Active then
				v97[v99.Index] = (v97[v99.Index] or 0) + 1
			end
		end
		local v100 = true
		for v101, v102 in v86 do
			local v103 = v97[v101] or 0
			for v104, v105 in v102 do
				local v106 = v104 <= v103
				v105.Return.Visible = v106
				v105.ViewportFrame.ImageColor3 = if v106 then Color3.new(1, 1, 1) else Color3.new(0, 0, 0)
				if not v106 then v100 = false end
			end
		end
		-- Cacher le bouton Buy si sold out
		local soldOut = isLimitedSoldOut(v58)
		l_Buy_0.Visible = v100 and not soldOut
	end

	v81:Add(v82:OnChanged("AnimalAddedOrRemoved", v107))
	v81:Add(task.spawn(v107))

	-- Écouter les changements de stock limité en temps réel
	v81:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal(LIMITED_ATTR_PREFIX .. v58):Connect(function()
		local newStock = getLimitedStock(v58)
		local detailLabel = l_Content_0:FindFirstChild("DetailLimitedLabel")
		if newStock ~= nil and detailLabel then
			if newStock <= 0 then
				detailLabel.Text = "SOLD OUT"
				detailLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
				local stroke = detailLabel:FindFirstChild("GradientStroke")
				if stroke then 
					stroke.Color = Color3.fromRGB(0, 0, 0)  -- Bordure noire
					stroke.Thickness = 3
				end
				l_Buy_0.Visible = false
			else
				-- Rainbow gradient pour le stock
				detailLabel.Text = tostring(newStock) .. " LEFT"
				detailLabel.TextColor3 = Color3.new(1, 1, 1)
				local stroke = detailLabel:FindFirstChild("GradientStroke")
				if stroke then
					v13.apply(stroke, "Rainbow")
				end
				v13.apply(detailLabel, "Rainbow")
			end
		end
		-- Refresh la liste gauche pour mettre à jour les badges
		v59 = nil  -- forcer re-render
		v109()  -- re-render le panneau de droite
	end))

	l_Buy_0.Price.Text = ("$%*"):format((v27:ToString(v83.Cost)))
	local v108 = v81:Add(v30.new(l_Buy_0))
	v108:Animate()
	v81:Add(v108.OnActivated:Connect(function()
		-- Vérifier sold out côté client avant d'envoyer
		if isLimitedSoldOut(v58) then return end
		local craftResult = v43:InvokeServer(v58, v83.Name)
		if not craftResult then
			-- Rafraîchir le stock affiché
			local newStockVal = game:GetService("ReplicatedStorage"):GetAttribute("LimitedStock_" .. v58)
			if type(newStockVal) == "number" and newStockVal <= 0 then
				l_Buy_0.Visible = false
			end
			return
		end
		v23:SetState("CraftingMachine", false)
	end))
	v80()
end

local v110 = v18.new()
local v117Scheduled = false
local function v117()
	-- Fusionner les appels simultanés en un seul rebuild (evite race condition)
	if v117Scheduled then return end
	v117Scheduled = true
	task.defer(function()
		v117Scheduled = false
		v110:Clean()
		if not v57 then return end
		for v111, v112 in v57.List do
			-- Pour les recettes limitées, utiliser la rareté originale pour le style du contour
			local originalRarity = v112.OriginalRarity or getOriginalRarity(v111)
			local v113 = v36[originalRarity]
			local isLimited = isLimitedRecipe(v111)

			local v114 = v110:Clone(l_CraftingMachine_0.List.Template)
			v114.LayoutOrder = v113 and v113.Weight or 0
			v114.Title.Text = v112.Name

			-- Style du nom: Rainbow pour les limited, bordure = gradient OG
			if isLimited then
				-- Nom en Rainbow (comme Brainrot God)
				v114.Title.TextColor3 = Color3.new(1, 1, 1)
				v110:Add(v13.apply(v114.Title, "Rainbow"))
				-- Bordure = gradient OG (comme la rareté OG)
				v114.UIStroke.Color = Color3.new(1, 1, 1)
				v110:Add(v13.apply(v114.UIStroke, "OG"))
			elseif v113 and v113.GradientPreset then
				v114.Title.TextColor3 = Color3.new(1, 1, 1)
				v114.UIStroke.Color = Color3.new(1, 1, 1)
				v110:Add(v13.apply(v114.Title, v113.GradientPreset))
				v110:Add(v13.apply(v114.UIStroke, v113.GradientPreset))
			elseif v113 then
				v114.Title.TextColor3 = v113.Color
				v114.UIStroke.Color = v113.Color
			end
			v114.Visible = true
			v114.Parent = l_CraftingMachine_0.List

			-- ===== BADGE LIMITED sur chaque item de la liste =====
			applyLimitedBadge(v114, v111)

			-- Mise à jour dynamique du badge quand le stock change
			v110:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal(LIMITED_ATTR_PREFIX .. v111):Connect(function()
				applyLimitedBadge(v114, v111)
			end))

			local v115 = v110:Add(v30.new(v114))
			v115:Animate()
			v110:Add(v115.OnActivated:Connect(function()
				v58 = v111
				v109()
			end))
			if v37[v112.Name] then
				local v116 = v33:AttachOnViewport(v112.Name, v114.ViewportFrame, true)
				if v116 then v110:Add(v116) end
			end
		end
		v109()
	end)
end

v61.Start = function(_)
	-- ===== ÉCOUTER LE RESPAWN DU JOUEUR =====
	l_LocalPlayer_0.CharacterAdded:Connect(function(character)
		task.wait(0.5)  -- Attendre que le PlayerGui soit prêt

		-- Mettre à jour les références UI
		if updateUIReferences() then
			-- Réenregistrer l'interface avec les nouvelles références
			v56 = v23:Register("CraftingMachine", l_CraftingMachine_0, "TopQuint")
			v56:AttachCloseButton(l_Close_0)
			v56:Close()

			-- Re-fetch les données du serveur
			if v44 then
				v57 = v44:InvokeServer() or v57
				task.spawn(v117)
			end

			print("[CraftingMachineController] UI recréée après respawn")
		end
	end)

	l_CraftingMachine_0.Visible = false
	v56 = v23:Register("CraftingMachine", l_CraftingMachine_0, "TopQuint")
	v56:AttachCloseButton(l_Close_0)
	v56:Close()
	v10:WaitAndCall(l_LocalPlayer_0, function(v119)
		local function v120()
			task.spawn(v80)
		end
		v119:OnChanged("CraftingMachine", v120)
		v119:OnChanged("CraftingMachine.Brainrot", v120)
		v119:OnChanged("CraftingMachine.Rarity", v120)
		v119:OnChanged("CraftingMachine.FinishTime", v120)
		v119:OnChanged("CraftingMachine.StartTime", v120)
		task.spawn(v120)
	end)
	v17.Simple(1, function()
		task.spawn(v70)
		task.spawn(v80)
	end)
	v14.observeTag("CraftingMachinePrompt", function(v121)
		local v122 = v18.new()
		local function v126()
			local v123 = v10:Wait(l_LocalPlayer_0)
			if not v123 then return end
			local v124 = v123:Get("CraftingMachine.StartTime")
			local v125 = v123:Get("CraftingMachine.FinishTime")
			if v125 and v125 ~= 0 and v125 <= workspace:GetServerTimeNow() then
				v121.ActionText = "Claim"
				return
			elseif v124 and v124 ~= 0 then
				v121.ActionText = "Craft Now"
				return
			else
				v121.ActionText = "Craft Machine"
				return
			end
		end
		v122:Add(task.spawn(function()
			local v127 = v10:Wait(l_LocalPlayer_0)
			if not v127 then return end
			v127:OnChanged("CraftingMachine", v126)
			v122:Add(v17.Simple(1, v126))
			task.spawn(v126)
		end))
		v122:Add(v121.Triggered:Connect(function()
			local v128 = v10:Get(l_LocalPlayer_0)
			if not v128 then return end
			local v129 = v128:Get("CraftingMachine.StartTime")
			local v130 = v128:Get("CraftingMachine.FinishTime")
			local rarity = v128:Get("CraftingMachine.Rarity")
			if v130 and v130 ~= 0 and v130 <= workspace:GetServerTimeNow() then
				v41:FireServer()
				return
			elseif v129 and v129 ~= 0 then
				-- Acheter le produit "Craft Now" pour la rareté correspondante
				local productId = CRAFT_NOW_PRODUCTS[rarity]
				if productId then
					ShopPurchase:FireServer(productId)
				else
					-- Fallback: juste terminer le craft
					v38:FireServer()
				end
				return
			else
				v23:Toggle("CraftingMachine")
				return
			end
		end))
		return function()
			v122:Destroy()
		end
	end)
	v14.observeTag("CraftingMachine", function(v131)
		local v132 = v18.new()
		for _, v134 in v131.Hitboxes:GetChildren() do
			v132:Add(v134.Touched:Connect(function(v135)
				if v135.Name ~= "HumanoidRootPart" then return end
				local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v135.Parent)
				if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0 then return end
				if l_l_Players_0_PlayerFromCharacter_0:GetAttribute("StealingIndex") then
					local v137, _, _ = v42:InvokeServer(v134)
					if not v137 then return end
					task.spawn(function()
						v25:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit)
					end)
					v80()
				end
			end))
		end
		return function()
			v132:Destroy()
		end
	end)
	local v140 = {}
	v38.OnClientEvent:Connect(function(v141)
		local l_CraftingMachine_3 = workspace:FindFirstChild("CraftingMachine")
		if not l_CraftingMachine_3 then return end
		local v143 = l_HttpService_0:GenerateGUID(false)
		v140[v143] = true
		v60 = next(v140) ~= nil
		local v144 = l_CraftingMachine_3.VFX:FindFirstChild(v141)
		-- Fallback: utiliser ChargeStrike si le VFX pour cette rareté n'existe pas
		if not v144 then
			v144 = l_CraftingMachine_3.VFX:FindFirstChild("ChargeStrike")
		end
		if v144 then
			local chargingModel = v144:FindFirstChild("ChargingModel")
			if chargingModel then
				chargingModel:ScaleTo(1)
				for _, v146 in chargingModel.Charging.Charge:GetDescendants() do
					if v146:IsA("ParticleEmitter") then
						v146.TimeScale = 1
					end
				end
			end
			v29.enable(v144)
			if v144:FindFirstChild("SoundPart") then
				v144.SoundPart.Sound:Play()
			end
			if l_CraftingMachine_3.ChargeSoundPart.Sound.IsPlaying then
				l_CraftingMachine_3.ChargeSoundPart.Sound:Stop()
			end
			task.wait(1.5)
			v29.disable(v144)
			if v144:FindFirstChild("Burst") then
				v29.emit(v144.Burst)
			end
		end
		v140[v143] = nil
		v60 = next(v140) ~= nil
	end)
	v39.OnClientEvent:Connect(function(v147)
		v57 = v147
		v59 = nil
		-- Si la rareté sélectionnée n'existe plus dans la nouvelle liste, reset vers la première dispo
		if not v57 or not v57.List or not next(v57.List) then
			v58 = nil
		elseif v58 == nil or not v57.List[v58] then
			for k in pairs(v57.List) do
				v58 = k
				break
			end
		end
		-- Mettre à jour le timer "Refreshes in" avec le nouveau timestamp
		if v57 and v57.Refresh then
			local v148 = v57.Refresh - workspace:GetServerTimeNow()
			l_CraftingMachine_0.Timer.Text = ("Refreshes in %*"):format((v28:E((math.max(v148, 0)))))
		end
		v117()
	end)
	v57 = v44:InvokeServer() or v57
	task.spawn(v117)
	v17.Simple(1, function()
		local v148 = (v57 and v57.Refresh or 0) - workspace:GetServerTimeNow()
		l_CraftingMachine_0.Timer.Text = ("Refreshes in %*"):format((v28:E((math.max(v148, 0)))))
	end, true)
	v10:WaitAndCall(l_LocalPlayer_0, function()
		v117()
	end)
	task.spawn(function()
		local v149 = v10:Wait(l_LocalPlayer_0)
		if v149 then
			local v150 = {
				Color3.fromRGB(163, 162, 165),
				Color3.fromRGB(93, 176, 55),
				Color3.fromRGB(179, 168, 48),
				Color3.fromRGB(88, 173, 106)
			}
			local v151 = Random.new()
			while true do
				local v152 = 1
				local v153 = 3
				local l_workspace_ServerTimeNow_2 = workspace:GetServerTimeNow()
				local v155 = v149:Get("CraftingMachine.StartTime")
				local v156 = v149:Get("CraftingMachine.FinishTime")
				if v155 and v156 and workspace:GetServerTimeNow() < v156 then
					local v157 = math.clamp((l_workspace_ServerTimeNow_2 - v155) / (v156 - v155), 0, 1)
					v152 = math.lerp(0.5, 0.25, v157)
					v153 = math.lerp(4, 5, v157)
				end
				task.wait(v152)
				local l_CraftingMachine_4 = workspace:FindFirstChild("CraftingMachine")
				if l_CraftingMachine_4 then
					local l_Cubes_0 = l_CraftingMachine_4:FindFirstChild("Cubes")
					if l_Cubes_0 then
						for _, v161 in l_Cubes_0:GetChildren() do
							v19.target(v161, 1, v153, {
								Color = v150[v151:NextInteger(1, #v150)]
							})
						end
					end
				end
			end
		end
	end)
end

return v61