--!strict
-- LOCATION: ServerScriptService/LaboratorioServer
-- ================================================================
-- SISTEMA DO LABORATORIO - Aplicacao de Ingredientes em Brainrots
-- Flow:
-- 1. Player coloca brainrot no BrainrotSlot (LaboratorioN)
-- 2. Player coloca ingrediente no IngredientsPart (IngredientesN) - da mao equipada
-- 3. O icon do ingrediente aparece na UI do IngredientsPart (IconThing)
-- 4. Aparece o prompt "Iniciar Mutacao" no IngredientsPart
-- 5. Pressionar E -> inicia animacao de 4s (gira rapido, muda cor, diminui)
-- 6. Apos 4s: mostra "Colete seu Brainrot" e player pode coletar
-- ================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- [ MODULOS ]
local LaboratorioConfig = require(ReplicatedStorage.Modules.LaboratorioConfig)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- [ ASSETS ]
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local IngredientsFolder = ReplicatedStorage:WaitForChild("Ingredients")
local Events = ReplicatedStorage:FindFirstChild("Events")

-- Cache dos icons de mutacao do Brainrot_UI
local MutationIcons: {[string]: string} = {}
do
	local brainrotUITemplate = ReplicatedStorage:FindFirstChild("Templates")
		and ReplicatedStorage.Templates:FindFirstChild("Brainrot_UI")
	if brainrotUITemplate then
		local frame = brainrotUITemplate:FindFirstChild("Frame")
		local mutations = frame and frame:FindFirstChild("Mutations")
		if mutations then
			for _, icon in ipairs(mutations:GetChildren()) do
				if icon:IsA("ImageLabel") then
					MutationIcons[icon.Name] = icon.Image
				end
			end
		end
	end
end

-- [ ESTADO DAS MAQUINAS ]
type MachineState = "Idle" | "HasBrainrot" | "Ready" | "Processing" | "Complete"

type MachineData = {
	id: number,
	model: Model,
	ingredientModel: Model,
	state: MachineState,
	brainrot: {
		player: Player?,
		name: string,
		mutation: string,
		rarity: string,
		level: number,
		tool: Tool?,
		ingredientBonus: number,
		appliedIcons: {string},
	},
	ingredient: {
		name: string?,
		tool: Tool?,
	},
	visualBrainrot: Instance?,
	BrainrotSlot: BasePart,
	IngredientsPart: BasePart,
	InsertBrainrotPrompt: ProximityPrompt,
	InsertIngredientPrompt: ProximityPrompt,
	StartMutationPrompt: ProximityPrompt,
	CollectPrompt: ProximityPrompt,
	StatusGUI: BillboardGui?,
	StatusText: TextLabel?,
	IngredientIcon: ImageLabel?,
}

local machines: {[number]: MachineData} = {}

-- ============================================================
-- HELPERS
-- ============================================================

local function getModelFromItem(item: Instance): Model?
	if item:IsA("Model") then return item end
	if item:IsA("Folder") then
		return item:FindFirstChildOfClass("Model")
	end
	return nil
end

local function findItemTemplate(mutation: string, itemName: string): Instance?
	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	if not mutationFolder then return nil end
	return mutationFolder:FindFirstChild(itemName) or ItemsFolder.Normal:FindFirstChild(itemName)
end

local function notify(player: Player, message: string, msgType: string?)
	if not Events then return end
	local notif = Events:FindFirstChild("ShowNotification")
	if notif then
		notif:FireClient(player, message, msgType or "Info")
	end
end

-- ============================================================
-- INGREDIENT ICON UI (usa o IconThing existente no IngredientsPart.UI)
-- ============================================================

local function showIngredientIcon(machine: MachineData, ingredientName: string)
	if not machine.IngredientIcon then return end
	local effect = LaboratorioConfig.GetEffect(ingredientName)
	if not effect then return end

	local iconImage = MutationIcons[effect.IconName]
	if iconImage and iconImage ~= "" then
		machine.IngredientIcon.Image = iconImage
		machine.IngredientIcon.Visible = true
	end
end

local function hideIngredientIcon(machine: MachineData)
	if machine.IngredientIcon then
		machine.IngredientIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
		machine.IngredientIcon.Visible = false
	end
end

-- ============================================================
-- STATUS TEXT
-- ============================================================

local function updateStatus(machine: MachineData, text: string)
	if machine.StatusText then
		machine.StatusText.Text = text
	end
end

-- ============================================================
-- VISUAL BRAINROT
-- ============================================================

local function spawnVisualBrainrot(machine: MachineData)
	if machine.visualBrainrot then
		machine.visualBrainrot:Destroy()
		machine.visualBrainrot = nil
	end

	local template = findItemTemplate(machine.brainrot.mutation, machine.brainrot.name)
	if not template then return end

	local clone = template:Clone()
	clone.Name = "VisualBrainrot"

	local innerModel = getModelFromItem(clone)
	if not innerModel then
		warn("[LaboratorioServer] Model nao encontrado dentro do template: " .. machine.brainrot.name)
		clone:Destroy()
		return
	end

	for _, part in clone:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
		end
	end

	local _, size = innerModel:GetBoundingBox()
	innerModel:PivotTo(machine.BrainrotSlot.CFrame + Vector3.new(0, size.Y / 2 + 1, 0))

	-- Attach Brainrot_UI template
	local brainrotUITemplate = ReplicatedStorage.Templates:FindFirstChild("Brainrot_UI")
	if brainrotUITemplate then
		local existingUI = clone:FindFirstChild("Brainrot_UI", true)
		if existingUI then existingUI:Destroy() end

		local ui = brainrotUITemplate:Clone()
		ui.Name = "Brainrot_UI"

		local rootPart = innerModel.PrimaryPart or innerModel:FindFirstChildWhichIsA("BasePart")
		if rootPart then
			ui.Adornee = rootPart
			-- Recompute bounding box AFTER PivotTo so positions are consistent
			local newCf, newSize = innerModel:GetBoundingBox()
			local modelTopOffset = newCf.Position.Y + newSize.Y / 2 - rootPart.Position.Y
			ui.StudsOffset = Vector3.new(0, modelTopOffset + 2, 0)
		end

		ui.Parent = innerModel
		print("[DEBUG spawnVisual] Brainrot_UI attached to innerModel: " .. tostring(innerModel.Name) .. ", Adornee: " .. tostring(ui.Adornee))
	else
		print("[DEBUG spawnVisual] brainrotUITemplate NOT found in ReplicatedStorage.Templates!")
	end

	clone.Parent = machine.model
	machine.visualBrainrot = clone
	print("[DEBUG spawnVisual] VisualBrainrot created. visualBrainrot parent: " .. tostring(clone.Parent and clone.Parent.Name))
end

local function removeVisualBrainrot(machine: MachineData)
	if machine.visualBrainrot then
		machine.visualBrainrot:Destroy()
		machine.visualBrainrot = nil
	end
end

-- ============================================================
-- BRAINROT UI - MOSTRAR ICONS DE INGREDIENTES APLICADOS
-- ============================================================

local function updateBrainrotMutationIcons(machine: MachineData)
	if not machine.visualBrainrot then
		print("[DEBUG updateIcons] visualBrainrot is nil!")
		return
	end
	local brainrotUI = machine.visualBrainrot:FindFirstChild("Brainrot_UI", true)
	if not brainrotUI then
		print("[DEBUG updateIcons] Brainrot_UI not found in visualBrainrot!")
		return
	end

	local frame = brainrotUI:FindFirstChild("Frame")
	if not frame then
		print("[DEBUG updateIcons] Frame not found in Brainrot_UI!")
		return
	end

	local mutationsFrame = frame:FindFirstChild("Mutations")
	if not mutationsFrame then
		print("[DEBUG updateIcons] Mutations frame not found!")
		return
	end

	print("[DEBUG updateIcons] Found Mutations frame. Hiding all icons...")
	for _, icon in ipairs(mutationsFrame:GetChildren()) do
		if icon:IsA("ImageLabel") then
			icon.Visible = false
		end
	end

	if machine.brainrot.mutation and machine.brainrot.mutation ~= "Normal" then
		local mutIcon = mutationsFrame:FindFirstChild(machine.brainrot.mutation)
		if mutIcon and mutIcon:IsA("ImageLabel") then
			mutIcon.Visible = true
			print("[DEBUG updateIcons] Showed mutation icon: " .. machine.brainrot.mutation)
		else
			print("[DEBUG updateIcons] Mutation icon NOT found: " .. machine.brainrot.mutation)
		end
	end

	print("[DEBUG updateIcons] appliedIcons count: " .. #machine.brainrot.appliedIcons)
	for _, iconName in ipairs(machine.brainrot.appliedIcons) do
		local icon = mutationsFrame:FindFirstChild(iconName)
		if icon and icon:IsA("ImageLabel") then
			icon.Visible = true
			print("[DEBUG updateIcons] Showed applied icon: " .. iconName)
		else
			print("[DEBUG updateIcons] Applied icon NOT found in Mutations: " .. iconName)
		end
	end
end

-- ============================================================
-- ESTADO DA MAQUINA
-- ============================================================

local function updateMachineState(machine: MachineData)
	if machine.state == "Processing" or machine.state == "Complete" then return end

	local hasBrainrot = machine.brainrot.player ~= nil
	local hasIngredient = machine.ingredient.name ~= nil

	if not hasBrainrot then
		machine.state = "Idle"
	elseif hasIngredient then
		machine.state = "Ready"
	else
		machine.state = "HasBrainrot"
	end

	-- InsertBrainrotPrompt: sempre ativo (toggle inserir/remover)
	machine.InsertBrainrotPrompt.Enabled = true
	if hasBrainrot then
		machine.InsertBrainrotPrompt.ActionText = "Remover Brainrot"
	else
		machine.InsertBrainrotPrompt.ActionText = "Colocar Brainrot"
	end

	-- InsertIngredientPrompt: so aparece se tem brainrot e nao tem ingrediente
	-- Toggle off first then on next frame to force PromptShown event
	local shouldShowIngredient = hasBrainrot and not hasIngredient
	if shouldShowIngredient and not machine.InsertIngredientPrompt.Enabled then
		machine.InsertIngredientPrompt.Enabled = false
		task.defer(function()
			machine.InsertIngredientPrompt.Enabled = true
		end)
	elseif not shouldShowIngredient then
		machine.InsertIngredientPrompt.Enabled = false
	end

	-- StartMutationPrompt (E para Iniciar Mutacao): so aparece quando tem brainrot E ingrediente
	machine.StartMutationPrompt.Enabled = (machine.state == "Ready")
	machine.StartMutationPrompt.ActionText = "Iniciar Mutacao"

	-- CollectPrompt: desativado durante o fluxo normal
	machine.CollectPrompt.Enabled = false

	if machine.state == "Idle" then
		updateStatus(machine, "Coloque um Brainrot")
	elseif machine.state == "HasBrainrot" then
		updateStatus(machine, "Coloque um Ingrediente")
	elseif machine.state == "Ready" then
		updateStatus(machine, "Inicie a Mutacao")
	end
end

-- ============================================================
-- RESET MAQUINA
-- ============================================================

local function resetMachine(machine: MachineData)
	if machine.brainrot.tool and machine.brainrot.player then
		local backpack = machine.brainrot.player:FindFirstChild("Backpack")
		if backpack and not machine.brainrot.tool.Parent then
			machine.brainrot.tool.Parent = backpack
		end
	end

	if machine.ingredient.tool and machine.brainrot.player then
		local backpack = machine.brainrot.player:FindFirstChild("Backpack")
		if backpack and not machine.ingredient.tool.Parent then
			machine.ingredient.tool.Parent = backpack
		end
	end

	machine.state = "Idle"
	machine.brainrot = {
		player = nil :: Player?,
		name = "",
		mutation = "Normal",
		rarity = "Common",
		level = 1,
		tool = nil :: Tool?,
		ingredientBonus = 1,
		appliedIcons = {},
	}
	machine.ingredient = {
		name = nil :: string?,
		tool = nil :: Tool?,
	}

	removeVisualBrainrot(machine)
	hideIngredientIcon(machine)
	updateMachineState(machine)
end

-- ============================================================
-- APLICAR INGREDIENTE (MUTACAO)
-- ============================================================

local MUTATION_DURATION = 4 -- segundos de animacao de mutacao

local function applyIngredient(machine: MachineData)
	local ingredientName = machine.ingredient.name
	if not ingredientName then return end

	local effect = LaboratorioConfig.GetEffect(ingredientName)
	if not effect then return end

	-- Estado Processing: bloqueia tudo durante a animacao
	machine.state = "Processing"
	machine.InsertBrainrotPrompt.Enabled = false
	machine.StartMutationPrompt.Enabled = false
	machine.InsertIngredientPrompt.Enabled = false
	machine.CollectPrompt.Enabled = false

	updateStatus(machine, "Mutando...")

	-- Sinalizar para o client que esta mutando (girar rapido)
	if machine.visualBrainrot then
		machine.visualBrainrot:SetAttribute("IsMutating", true)
	end

	-- Destruir o tool do ingrediente (consumido)
	if machine.ingredient.tool then
		machine.ingredient.tool:Destroy()
	end

	machine.ingredient = {
		name = nil :: string?,
		tool = nil :: Tool?,
	}
	hideIngredientIcon(machine)

	-- Animacao de mutacao no servidor: mudar cor e diminuir
	local visualBrainrot = machine.visualBrainrot
	local innerModel = visualBrainrot and getModelFromItem(visualBrainrot)
	if not innerModel then return end

	-- Guardar cores originais e cor base
	local originalColors = {}
	for _, part in innerModel:GetDescendants() do
		if part:IsA("BasePart") then
			originalColors[part] = part.Color
		end
	end

	-- Guardar CFrame base (posicao, sem rotacao pois o client controla rotacao)
	local basePosition = innerModel:GetPivot().Position

	-- Cores para ciclar durante a mutacao
	local mutationColors = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(0, 255, 0),
		Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(255, 255, 0),
		Color3.fromRGB(255, 0, 255),
		Color3.fromRGB(0, 255, 255),
	}

	-- Animacao por MUTATION_DURATION segundos
	local startTime = os.clock()
	local colorIndex = 1
	local lastColorChange = startTime

	while os.clock() - startTime < MUTATION_DURATION do
		local elapsed = os.clock() - startTime
		local progress = elapsed / MUTATION_DURATION

		-- Mudar cor a cada 0.15s
		if os.clock() - lastColorChange >= 0.15 then
			colorIndex = (colorIndex % #mutationColors) + 1
			for _, part in innerModel:GetDescendants() do
				if part:IsA("BasePart") then
				part.Color = mutationColors[colorIndex]
				end
			end
			lastColorChange = os.clock()
		end

		-- Diminuir gradualmente ate 50% do tamanho, depois voltar
		local scaleProgress
		if progress < 0.5 then
			scaleProgress = 1 - (progress * 2 * 0.5) -- de 1 a 0.5
		else
			scaleProgress = 0.5 + ((progress - 0.5) * 2 * 0.5) -- de 0.5 a 1
		end

		-- Aplicar escala via ScaleTo
		innerModel:ScaleTo(scaleProgress)

		task.wait()
	end

	-- Restaurar cores originais
	for part, color in pairs(originalColors) do
		part.Color = color
	end

	-- Restaurar tamanho
	innerModel:ScaleTo(1)

	-- Sinalizar para o client que terminou a mutacao
	if visualBrainrot then
		visualBrainrot:SetAttribute("IsMutating", false)
	end

	-- Aplicar bonus
	local bonusMultiplier = 1 + (effect.Percentage / 100)
	machine.brainrot.ingredientBonus = machine.brainrot.ingredientBonus * bonusMultiplier

	-- Adicionar icon da mutacao aplicada
	if effect.IconName then
		local alreadyHas = false
		for _, name in ipairs(machine.brainrot.appliedIcons) do
			if name == effect.IconName then
				alreadyHas = true
				break
			end
		end
		if not alreadyHas then
			table.insert(machine.brainrot.appliedIcons, effect.IconName)
		end
	end

	-- Atualizar icons de mutacao no visual do brainrot
	updateBrainrotMutationIcons(machine)

	-- Atualizar o texto de income no Brainrot_UI
	if machine.visualBrainrot then
		local brainrotUI = machine.visualBrainrot:FindFirstChild("Brainrot_UI", true)
		if brainrotUI then
			local frame = brainrotUI:FindFirstChild("Frame")
			local lblEarn = frame and frame:FindFirstChild("Earn") :: TextLabel
			if lblEarn then
				local itemData = ItemConfigurations.GetItemData(machine.brainrot.name)
				local baseIncome = itemData and itemData.Income or 0
				local totalIncome = baseIncome * machine.brainrot.ingredientBonus
				lblEarn.Text = "$" .. NumberFormatter.Format(totalIncome) .. "/s"
			end
		end
	end

	if machine.brainrot.player then
		notify(machine.brainrot.player, "Mutacao aplicada! +" .. effect.Percentage .. "% de valor!", "Success")
	end

	-- Apos aplicar, o player pode coletar o brainrot ou colocar outro ingrediente
	machine.state = "Complete"
	machine.InsertBrainrotPrompt.Enabled = false
	machine.StartMutationPrompt.Enabled = false
	machine.InsertIngredientPrompt.Enabled = true

	-- Toggle CollectPrompt off then on next frame to force PromptShown event
	machine.CollectPrompt.Enabled = false
	task.defer(function()
		machine.CollectPrompt.Enabled = true
		machine.CollectPrompt.ActionText = "Coletar Brainrot"
	end)

	updateStatus(machine, "Colete seu Brainrot")

	print(string.format("[Laboratorio %d] Ingrediente %s aplicado em %s! Bonus total: %.2f",
		machine.id, ingredientName, machine.brainrot.name, machine.brainrot.ingredientBonus))
end

-- ============================================================
-- COLETAR BRAINROT
-- ============================================================

local function collectBrainrot(machine: MachineData)
	if not machine.brainrot.player or not machine.brainrot.tool then return end

	local player = machine.brainrot.player
	local tool = machine.brainrot.tool

	tool:SetAttribute("IngredientBonus", machine.brainrot.ingredientBonus)
	local appliedIconsStr = table.concat(machine.brainrot.appliedIcons, ",")
	tool:SetAttribute("AppliedIngredients", appliedIconsStr)

	local backpack = player:FindFirstChild("Backpack")
	if backpack and not tool.Parent then
		tool.Parent = backpack
	end

	notify(player, "Brainrot coletado com sucesso!", "Success")

	machine.brainrot.tool = nil
	removeVisualBrainrot(machine)
	hideIngredientIcon(machine)

	machine.state = "Idle"
	machine.brainrot = {
		player = nil :: Player?,
		name = "",
		mutation = "Normal",
		rarity = "Common",
		level = 1,
		tool = nil :: Tool?,
		ingredientBonus = 1,
		appliedIcons = {},
	}
	machine.ingredient = {
		name = nil :: string?,
		tool = nil :: Tool?,
	}

	updateMachineState(machine)
	print(string.format("[Laboratorio %d] Brainrot coletado por %s", machine.id, player.Name))
end

-- ============================================================
-- INICIALIZAR MAQUINA
-- ============================================================

local function initMachine(labModel: Model, ingredientModel: Model, labId: number): MachineData?
	-- BrainrotSlot (no model LaboratorioN)
	local brainrotSlot = labModel:FindFirstChild("BrainrotSlot")
	if not brainrotSlot or not brainrotSlot:IsA("BasePart") then return nil end

	local insertBrainrotPrompt = brainrotSlot:FindFirstChild("InsertBrainrotPrompt")
	if not insertBrainrotPrompt then
		warn("[LaboratorioServer] InsertBrainrotPrompt nao encontrado em " .. labModel.Name)
		return nil
	end

	-- CollectPrompt fica no BrainrotSlot
	local collectPrompt = brainrotSlot:FindFirstChild("CollectPrompt")

	if not collectPrompt then
		warn("[LaboratorioServer] CollectPrompt faltando no BrainrotSlot de " .. labModel.Name)
		return nil
	end

	-- IngredientsPart (no model IngredientesN)
	local ingredientsPart = ingredientModel:FindFirstChild("IngredientsPart")
	if not ingredientsPart or not ingredientsPart:IsA("BasePart") then
		warn("[LaboratorioServer] IngredientsPart nao encontrado em " .. ingredientModel.Name)
		return nil
	end

	local insertIngredientPrompt = ingredientsPart:FindFirstChild("InsertIngredientPrompt")
	if not insertIngredientPrompt then
		warn("[LaboratorioServer] InsertIngredientPrompt nao encontrado em " .. ingredientModel.Name)
		return nil
	end

	local startMutationPrompt = ingredientsPart:FindFirstChild("StartMutationPrompt")
	if not startMutationPrompt then
		warn("[LaboratorioServer] StartMutationPrompt nao encontrado em " .. ingredientModel.Name)
		return nil
	end

	-- Status GUI (procura direto no modelo do laboratorio)
	local statusGUI: BillboardGui? = nil
	local statusText: TextLabel? = nil
	for _, child in ipairs(labModel:GetChildren()) do
		if child:IsA("BasePart") then
			local gui = child:FindFirstChildOfClass("BillboardGui")
			if gui then
				statusGUI = gui
				statusText = gui:FindFirstChildOfClass("TextLabel")
				break
			end
		end
	end

	-- Ingredient icon: usar o IconThing existente no IngredientsPart.UI
	local ingredientUI = ingredientsPart:FindFirstChild("UI")
	local ingredientList = ingredientUI and ingredientUI:FindFirstChild("List")
	local ingredientIcon = ingredientList and ingredientList:FindFirstChild("IconThing")
	if ingredientIcon and ingredientIcon:IsA("ImageLabel") then
		ingredientIcon.Visible = false
		ingredientIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end

	local data: MachineData = {
		id = labId,
		model = labModel,
		ingredientModel = ingredientModel,
		state = "Idle" :: MachineState,
		brainrot = {
			player = nil :: Player?,
			name = "",
			mutation = "Normal",
			rarity = "Common",
			level = 1,
			tool = nil :: Tool?,
			ingredientBonus = 1,
			appliedIcons = {},
		},
		ingredient = {
			name = nil :: string?,
			tool = nil :: Tool?,
		},
		visualBrainrot = nil :: Instance?,
		BrainrotSlot = brainrotSlot :: BasePart,
		IngredientsPart = ingredientsPart :: BasePart,
		InsertBrainrotPrompt = insertBrainrotPrompt :: ProximityPrompt,
		InsertIngredientPrompt = insertIngredientPrompt :: ProximityPrompt,
		StartMutationPrompt = startMutationPrompt :: ProximityPrompt,
		CollectPrompt = collectPrompt :: ProximityPrompt,
		StatusGUI = statusGUI :: BillboardGui?,
		StatusText = statusText :: TextLabel?,
		IngredientIcon = ingredientIcon :: ImageLabel?,
	}

	startMutationPrompt.Enabled = false
	collectPrompt.Enabled = false
	collectPrompt.MaxActivationDistance = 7.5
	startMutationPrompt.HoldDuration = 0
	startMutationPrompt.ActionText = "Iniciar Mutacao"

	updateMachineState(data)
	return data
end

-- ============================================================
-- HANDLERS DOS PROMPTS
-- ============================================================

-- Inserir Brainrot (da mao do jogador - tool equipada)
local function onInsertItem(player: Player, machine: MachineData)
	if machine.state ~= "Idle" and machine.state ~= "HasBrainrot" then return end
	if machine.brainrot.player ~= nil then return end

	local character = player.Character
	if not character then return end

	local foundTool: Tool? = nil
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Tool") then
			local originalName = child:GetAttribute("OriginalName")
			if originalName then
				local isIngredient = false
				for _, ing in ipairs(IngredientsFolder:GetChildren()) do
					if child.Name == ing.Name then
						isIngredient = true
						break
					end
				end
				if not isIngredient then
					foundTool = child :: Tool
					break
				end
			end
		end
	end

	if not foundTool then
		notify(player, "Equipe um Brainrot na mao!", "Error")
		return
	end

	foundTool.Parent = nil

	local ingredientBonus = foundTool:GetAttribute("IngredientBonus") or 1
	local appliedIconsStr = foundTool:GetAttribute("AppliedIngredients") or ""
	local appliedIcons = {}
	if appliedIconsStr ~= "" then
		for icon in string.gmatch(appliedIconsStr, "[^,]+") do
			table.insert(appliedIcons, icon)
		end
	end

	machine.brainrot = {
		player = player,
		name = foundTool:GetAttribute("OriginalName") or "",
		mutation = foundTool:GetAttribute("Mutation") or "Normal",
		rarity = foundTool:GetAttribute("Rarity") or "Common",
		level = foundTool:GetAttribute("Level") or 1,
		tool = foundTool,
		ingredientBonus = ingredientBonus,
		appliedIcons = appliedIcons,
	}

	spawnVisualBrainrot(machine)
	updateBrainrotMutationIcons(machine)

	if machine.visualBrainrot then
		local brainrotUI = machine.visualBrainrot:FindFirstChild("Brainrot_UI", true)
		if brainrotUI then
			local frame = brainrotUI:FindFirstChild("Frame")
			local lblEarn = frame and frame:FindFirstChild("Earn") :: TextLabel
			if lblEarn then
				local itemData = ItemConfigurations.GetItemData(machine.brainrot.name)
				local baseIncome = itemData and itemData.Income or 0
				local totalIncome = baseIncome * machine.brainrot.ingredientBonus
				lblEarn.Text = "$" .. NumberFormatter.Format(totalIncome) .. "/s"
			end
		end
	end

	updateMachineState(machine)
	print(string.format("[Laboratorio %d] Brainrot %s inserido por %s", machine.id, machine.brainrot.name, player.Name))
end

-- Inserir Ingrediente (da mao do jogador - tool equipada)
local function onInsertIngredient(player: Player, machine: MachineData)
	if machine.state ~= "HasBrainrot" and machine.state ~= "Ready" and machine.state ~= "Complete" then return end
	if machine.brainrot.player ~= player then return end
	if machine.ingredient.name ~= nil then return end

	local character = player.Character
	if not character then return end

	local foundTool: Tool? = nil
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Tool") then
			local isIngredient = false
			for _, ing in ipairs(IngredientsFolder:GetChildren()) do
				if child.Name == ing.Name then
					isIngredient = true
					break
				end
			end
			if isIngredient then
				foundTool = child :: Tool
				break
			end
		end
	end

	if not foundTool then
		notify(player, "Equipe um Ingrediente na mao!", "Error")
		return
	end

	local effect = LaboratorioConfig.GetEffect(foundTool.Name)
	if not effect then
		notify(player, "Este ingrediente nao pode ser aplicado!", "Error")
		return
	end

	foundTool.Parent = nil

	machine.ingredient = {
		name = foundTool.Name,
		tool = foundTool,
	}

	-- Mostrar o icon do ingrediente na UI do IngredientsPart
	showIngredientIcon(machine, foundTool.Name)

	-- Se estava em estado Complete (ja aplicou um ingrediente), volta para Ready
	if machine.state == "Complete" then
		machine.state = "Ready"
		machine.CollectPrompt.Enabled = false
		machine.InsertBrainrotPrompt.Enabled = true
	end

	updateMachineState(machine)
	print(string.format("[Laboratorio %d] Ingrediente %s inserido por %s", machine.id, foundTool.Name, player.Name))
end

-- Remover Brainrot e devolver
local function onRemoveBrainrot(player: Player, machine: MachineData)
	if machine.state == "Processing" then return end
	if machine.brainrot.player ~= player then return end

	if machine.ingredient.tool then
		local backpack = player:FindFirstChild("Backpack")
		if backpack and not machine.ingredient.tool.Parent then
			machine.ingredient.tool.Parent = backpack
		end
	end

	if machine.brainrot.tool then
		machine.brainrot.tool:SetAttribute("IngredientBonus", machine.brainrot.ingredientBonus)
		local appliedIconsStr = table.concat(machine.brainrot.appliedIcons, ",")
		machine.brainrot.tool:SetAttribute("AppliedIngredients", appliedIconsStr)

		local backpack = player:FindFirstChild("Backpack")
		if backpack and not machine.brainrot.tool.Parent then
			machine.brainrot.tool.Parent = backpack
		end
	end

	resetMachine(machine)
	print(string.format("[Laboratorio %d] Brainrot removido por %s", machine.id, player.Name))
end

-- Debounce por maquina para evitar duplo trigger
local promptDebounce: {[number]: boolean} = {}

-- ============================================================
-- INICIALIZACAO
-- ============================================================

-- Mapeamento correto: LaboratorioN -> IngredientesM baseado na proximidade fisica
-- Os modelos Ingredientes nao estao numerados na mesma ordem que Laboratorio
local LAB_TO_INGREDIENT_MAP: {[number]: number} = {
	[1] = 3, -- Laboratorio1 -> Ingredientes3
	[2] = 2, -- Laboratorio2 -> Ingredientes2
	[3] = 1, -- Laboratorio3 -> Ingredientes1
	[4] = 4, -- Laboratorio4 -> Ingredientes4
	[5] = 7, -- Laboratorio5 -> Ingredientes7
	[6] = 6, -- Laboratorio6 -> Ingredientes6
	[7] = 5, -- Laboratorio7 -> Ingredientes5
	[8] = 8, -- Laboratorio8 -> Ingredientes8
}

local function init()
	local labFolder = Workspace:FindFirstChild("Laboratorio")
	if not labFolder then
		warn("[LaboratorioServer] Pasta Laboratorio nao encontrada no Workspace!")
		return
	end

	for i = 1, 8 do
		local labModel = labFolder:FindFirstChild("Laboratorio" .. i)
		local ingIdx = LAB_TO_INGREDIENT_MAP[i] or i
		local ingredientModel = labFolder:FindFirstChild("Ingredientes" .. ingIdx)

		if labModel and ingredientModel then
			local id = i
			if not machines[id] then
				local machine = initMachine(labModel, ingredientModel, id)
				if machine then
					machines[id] = machine
					print("[LaboratorioServer] Maquina registrada: Laboratorio" .. i .. " + Ingredientes" .. ingIdx .. " (ID: " .. id .. ")")
				end
			end
		else
			warn("[LaboratorioServer] Laboratorio" .. i .. " ou Ingredientes" .. ingIdx .. " nao encontrados")
		end
	end

	local count = 0
	for _ in pairs(machines) do count += 1 end
	print("[LaboratorioServer] Sistema iniciado com " .. count .. " maquinas")
end

-- Conectar prompts de todas as maquinas
local function connectPrompts()
	for _, machine in pairs(machines) do
		machine.InsertBrainrotPrompt.Triggered:Connect(function(player)
			if promptDebounce[machine.id] then return end
			promptDebounce[machine.id] = true
			task.delay(1, function() promptDebounce[machine.id] = false end)

			if machine.brainrot.player == player then
				onRemoveBrainrot(player, machine)
			else
				onInsertItem(player, machine)
			end
		end)

		machine.InsertIngredientPrompt.Triggered:Connect(function(player)
			onInsertIngredient(player, machine)
		end)

		machine.StartMutationPrompt.Triggered:Connect(function(player)
			if machine.brainrot.player ~= player then return end
			if machine.state ~= "Ready" then return end
			applyIngredient(machine)
		end)

		machine.CollectPrompt.Triggered:Connect(function(player)
			if machine.brainrot.player ~= player then return end
			collectBrainrot(machine)
		end)
	end
end

-- PlayerRemoving - devolver itens
Players.PlayerRemoving:Connect(function(player)
	for _, machine in pairs(machines) do
		if machine.brainrot.player == player then
			resetMachine(machine)
		end
	end
end)

init()
connectPrompts()
