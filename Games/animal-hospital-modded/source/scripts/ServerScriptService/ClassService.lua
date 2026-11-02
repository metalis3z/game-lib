--[[
	ClassService  (Fase 4 — clases + perks por nivel)

	La clase del jugador vive en Stats.Class (default "Intern"); StatsLocal ya la
	muestra. Cada clase (Data.Classes) tiene Attributes base y LevelPerks[2]/[3] que
	se DESBLOQUEAN al subir de Level (progresión). Aquí:
	  · Calculamos los atributos efectivos = base + todos los LevelPerks hasta tu
	    Level actual, y los ponemos como atributos del Player (los leen SanityService,
	    ShiftService y el cliente). Ej: BonusSanity, BonusCarryItems, HealingRecovery,
	    SanityImpactMultiplier, EventSpeedBoost...
	  · Damos las Tools de arranque de la clase al backpack (además de las curas).
	  · MaxCarry = 1 base + BonusCarryItems (tope de inventario para futuras fases).

	Se re-aplica al spawnear y cuando ShiftService sube de nivel.

	API: ClassService:Init(), :Apply(player), :GetEffectiveAttributes(player),
	     :SetClass(player, className)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Classes = require(ReplicatedStorage.Data.Classes)
local DataService = require(ServerScriptService:WaitForChild("DataService"))

local ClassService = {}

local function classDef(className)
	return Classes.Classes[className] or Classes.Classes[Classes.BASE_CLASS]
end

-- base Attributes + LevelPerks[k] para todo k <= level (fusionados en orden).
function ClassService:GetEffectiveAttributes(player)
	local stats = DataService:GetStats(player)
	local className = stats and stats.Class or Classes.BASE_CLASS
	local level = (stats and stats.Level) or 1
	local def = classDef(className)

	local attrs = {}
	for k, v in pairs(def.Attributes or {}) do
		attrs[k] = v
	end
	if def.LevelPerks then
		for lvl = 2, level do
			local perk = def.LevelPerks[lvl]
			if perk then
				for k, v in pairs(perk) do
					attrs[k] = v
				end
			end
		end
	end
	return attrs, def, className, level
end

-- Da las Tools de arranque de la clase al backpack (una vez por spawn).
local function grantClassTools(player, def)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then return end
	-- limpia tools de clase viejas
	for _, obj in ipairs(backpack:GetChildren()) do
		if obj:IsA("Tool") and obj:GetAttribute("ClassTool") then
			obj:Destroy()
		end
	end
	for _, toolName in ipairs(def.Tools or {}) do
		-- clona el modelo si existe; si no, un Tool básico para que aparezca.
		local template = ReplicatedStorage:FindFirstChild("Tools")
		template = template and template:FindFirstChild(toolName)
		local tool
		if template and template:IsA("Tool") then
			tool = template:Clone()
		else
			tool = Instance.new("Tool")
			tool.Name = toolName
			tool.ToolTip = toolName
			tool.RequiresHandle = false
			tool.CanBeDropped = false
		end
		tool:SetAttribute("ClassTool", true)
		tool.Parent = backpack
	end
end

function ClassService:Apply(player)
	local attrs, def, className = self:GetEffectiveAttributes(player)
	if not def then return end

	-- Limpia atributos de perk previos que ya no apliquen y setea los actuales.
	-- (Set explícito de los conocidos; el resto se copia tal cual.)
	player:SetAttribute("Class", className)
	player:SetAttribute("SanityImpactMultiplier", attrs.SanityImpactMultiplier or 1)
	player:SetAttribute("BonusSanity", attrs.BonusSanity or 0)
	player:SetAttribute("HealingRecovery", attrs.HealingRecovery or 0)
	player:SetAttribute("MaxCarry", 1 + (attrs.BonusCarryItems or 0))
	for k, v in pairs(attrs) do
		-- solo tipos válidos de atributo (numbers/bools/strings)
		local t = type(v)
		if t == "number" or t == "boolean" or t == "string" then
			player:SetAttribute(k, v)
		end
	end

	grantClassTools(player, def)
end

-- Cambia de clase (para una futura UI de selección). Requiere tenerla en OwnedClasses.
function ClassService:SetClass(player, className)
	if not Classes.Classes[className] then return false end
	local data = DataService:Get(player)
	if not data then return false end
	if not (data.OwnedClasses and data.OwnedClasses[className]) then
		return false
	end
	data.Stats.Class = className
	DataService:PushCategory(player, "Stats")
	self:Apply(player)
	return true
end

function ClassService:Init()
	if self._initialized then return end
	self._initialized = true

	local function onCharacter(player)
		task.spawn(function()
			DataService:Get(player) -- espera el perfil
			player:WaitForChild("Backpack", 10)
			self:Apply(player)
		end)
	end

	local function hook(player)
		player.CharacterAdded:Connect(function()
			onCharacter(player)
		end)
		if player.Character then
			onCharacter(player)
		end
	end

	Players.PlayerAdded:Connect(hook)
	for _, player in ipairs(Players:GetPlayers()) do
		hook(player)
	end

	-- print("[ClassService] inicializado — perks de clase por nivel activos")
end

return ClassService
