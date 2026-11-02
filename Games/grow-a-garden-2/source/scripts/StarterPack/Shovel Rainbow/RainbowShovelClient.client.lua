--credit to prince games studio
--[[
	RainbowShovelClient (LocalScript dentro del Tool "Shovel Rainbow")
	------------------------------------------------------------------
	- El tool lo tiene TODO el mundo en la mochila (fondo rainbow vía atributo
	  RainbowItem que lee el InventoryController). Lo que se "compra" es el
	  PERMISO de usarlo:
	    • Gamepass 1875843847  -> acceso PERMANENTE
	    • 50M sheckles         -> acceso de SESIÓN (se pierde al salir)
	  El permiso por sheckles lo marca el server con el atributo del jugador
	  "RainbowShovelAccess".
	- Al usar (clic) apunta a CUALQUIER planta de CUALQUIER plot y la borra.
	  Cooldown de 30s entre borrados; si está en cooldown muestra un aviso en el
	  ScreenGui "Message" (MessagePrompt).
	- Reproduce la MISMA animación de cavar que la pala normal.
	- El borrado real + persistencia + validación de acceso/cooldown lo hace el
	  server (PlantService, evento ReplicatedStorage.RainbowShovelDelete).
]]

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local GAMEPASS_ID = 1875843847
local COOLDOWN = 30
local DIG_ANIM_ID = "rbxassetid://78592768207309" -- misma animación que la pala normal (ShovelController)

local tool = script.Parent
local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("RainbowShovelDelete")
local mouse = player:GetMouse()
local MessagePrompt = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("MessagePrompt"))

local owns = false
local lastUse = -math.huge
local equipped = false
local IS_STUDIO = RunService:IsStudio()

----------------------------------------------------------------------
-- Acceso: gamepass (permanente), compra con sheckles (atributo), o Studio
----------------------------------------------------------------------
local function refreshAccess(): boolean
	if owns then
		return true
	end
	-- En Studio no se puede verificar gamepass (es simulado): permitir para probar.
	if IS_STUDIO then
		owns = true
		return true
	end
	-- Compra con sheckles: el server marca este atributo (no persiste).
	if player:GetAttribute("RainbowShovelAccess") then
		owns = true
		return true
	end
	local ok, res = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)
	if ok and res then
		owns = true
	end
	return owns
end

player:GetAttributeChangedSignal("RainbowShovelAccess"):Connect(function()
	if player:GetAttribute("RainbowShovelAccess") then
		owns = true
	end
end)

----------------------------------------------------------------------
-- Animación de cavar (idéntica a la pala normal)
----------------------------------------------------------------------
local digTrack: AnimationTrack? = nil
local function playDigAnimation()
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		return
	end
	if not digTrack then
		local anim = Instance.new("Animation")
		anim.AnimationId = DIG_ANIM_ID
		digTrack = animator:LoadAnimation(anim)
		digTrack.Looped = false
		digTrack.Priority = Enum.AnimationPriority.Action4
	end
	digTrack:Play()
end

----------------------------------------------------------------------
-- Buscar la planta apuntada (atributos PlantId + UserId del visualizer)
----------------------------------------------------------------------
local function findPlant(inst: Instance?)
	local node = inst
	while node and node ~= workspace do
		if node:GetAttribute("PlantId") and node:GetAttribute("UserId") then
			return node
		end
		node = node.Parent
	end
	return nil
end

local function findPlantNear(point: Vector3)
	local best, bestDist = nil, 14
	for _, m in workspace:GetDescendants() do
		if m:GetAttribute("PlantId") and m:GetAttribute("UserId") then
			local ok, cf = pcall(function()
				return m:GetPivot()
			end)
			if ok then
				local d = (cf.Position - point).Magnitude
				if d < bestDist then
					best, bestDist = m, d
				end
			end
		end
	end
	return best
end

----------------------------------------------------------------------
-- Equipar: gate de acceso
----------------------------------------------------------------------
tool.Equipped:Connect(function()
	equipped = true
	if not refreshAccess() then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
	end
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(plr, id, purchased)
	if id == GAMEPASS_ID and purchased then
		owns = true
	end
end)

----------------------------------------------------------------------
-- Usar: borrar la planta apuntada
----------------------------------------------------------------------
tool.Activated:Connect(function()
	if not refreshAccess() then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
		return
	end
	local remaining = COOLDOWN - (os.clock() - lastUse)
	if remaining > 0 then
		MessagePrompt.Prompt({
			titleOverride = "Rainbow Shovel",
			message = string.format(
				"Tienes que esperar <b>%d s</b> para borrar otra planta de otro plot.",
				math.ceil(remaining)
			),
			duration = 2,
			hideClose = true,
		})
		return
	end
	local target = mouse.Target
	local plant = findPlant(target)
	if not plant then
		plant = findPlantNear(mouse.Hit.Position)
	end
	if not plant then
		return
	end
	lastUse = os.clock()
	playDigAnimation()
	remote:FireServer(plant:GetAttribute("UserId"), plant:GetAttribute("PlantId"))
end)

-- Si el server rechaza (cooldown desincronizado), re-sincronizar
remote.OnClientEvent:Connect(function(kind, value)
	if kind == "cooldown" and typeof(value) == "number" then
		lastUse = os.clock() - (COOLDOWN - value)
	end
end)

----------------------------------------------------------------------
-- Mango arcoíris mientras está equipado
----------------------------------------------------------------------
task.spawn(function()
	local hue = 0
	while true do
		RunService.Heartbeat:Wait()
		if equipped then
			hue = (hue + 0.01) % 1
			local color = Color3.fromHSV(hue, 1, 1)
			for _, p in tool:GetChildren() do
				if p:IsA("BasePart") and p.Transparency < 1 then
					p.Color = color
				end
			end
		end
	end
end)
