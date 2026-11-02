--[[
	AnomalyEventService  (Fase 8 — sustos ambientales / anomalías)

	Durante el juego, cada CHECK_INTERVAL segundos evalúa a cada jugador vivo y,
	con una probabilidad que SUBE cuando su cordura baja, le dispara un SUSTO:
	  · Jumpscare de pantalla -> FireClient(plr,"JumpscareShadowWithEyesIMG")
	    (AnomalyEvents.Local.Jumpscares ya lo maneja: imagen + estática + sonido).
	  · Prop de terror (Skull/Tendril/PhotoDummy/Slime de ReplicatedStorage.Misc)
	    que APARECE unos segundos frente al jugador y se desvanece (Debris).
	Cada susto drena cordura (SanityService). Se puede apagar con :SetEnabled(false)
	(p.ej. fuera del turno; ShiftService puede engancharlo).

	API: :Init(), :SetEnabled(on), :Scare(player)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))

local MiscFolder = ReplicatedStorage:WaitForChild("Misc")

-- Frecuencia BAJADA a pedido: el jumpscare de pantalla salia demasiado seguido
-- (cada 22 s se tiraba un 18%-73% de susto y la mitad de esos sustos era
-- jumpscare -> uno cada ~1-2 min). Ahora los chequeos son mas espaciados, la
-- probabilidad es mucho menor, la mayoria de los sustos son props, y ADEMAS hay
-- un cooldown global por jugador (JUMPSCARE_COOLDOWN) que comparte el
-- AnomalyDirector, asi que ninguna otra fuente puede encadenar jumpscares.
local CHECK_INTERVAL      = 45   -- s entre chequeos (antes 22)
local BASE_CHANCE         = 0.06 -- prob. base por chequeo, cordura llena (antes 0.18)
local LOW_BONUS           = 0.25 -- prob. extra cuando la cordura llega a 0 (antes 0.55)
local JUMPSCARE_CHANCE    = 0.2  -- de los sustos, cuantos son jumpscare (antes 0.5; el resto = prop)
local JUMPSCARE_COOLDOWN  = 300  -- s minimos entre jumpscares de pantalla POR JUGADOR
local SANITY_SCARE        = 8    -- cordura perdida por susto
local PROP_LIFETIME       = 5    -- s que el prop queda visible
local PROP_NAMES          = { "Skull", "Tendril", "PhotoDummy", "Slime" }

local JUMPSCARE_CHANNEL = "JumpscareShadowWithEyesIMG"

local lastJumpscare = {}   -- [player] = os.clock() del ultimo jumpscare

local AnomalyEventService = {}
AnomalyEventService.Enabled = true

Players.PlayerRemoving:Connect(function(player)
	lastJumpscare[player] = nil
end)

local function alivePlayers()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hum and hrp and hum.Health > 0 then
			list[#list + 1] = p
		end
	end
	return list
end

-- Aparece un prop de terror ~7 studs frente al jugador, mirándolo, y lo borra.
local function spawnProp(player)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local template = MiscFolder:FindFirstChild(PROP_NAMES[math.random(1, #PROP_NAMES)])
	if not template then return end

	local prop = template:Clone()
	for _, d in ipairs(prop:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ProximityPrompt") then d:Destroy() end
	end

	local base = hrp.CFrame
	local front = base.Position + base.LookVector * 7
	local groundY = hrp.Position.Y - 2.5
	local look = Vector3.new(hrp.Position.X, groundY, hrp.Position.Z)
	local cf = CFrame.lookAt(Vector3.new(front.X, groundY, front.Z), look)

	prop.Parent = workspace:FindFirstChild("Misc") or workspace
	pcall(function() prop:PivotTo(cf) end)
	for _, d in ipairs(prop:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
		end
	end
	Debris:AddItem(prop, PROP_LIFETIME)
end

-- ¿Le toca jumpscare a este jugador o todavía está en cooldown?
function AnomalyEventService:CanJumpscare(player)
	local last = lastJumpscare[player]
	return (not last) or (os.clock() - last) >= JUMPSCARE_COOLDOWN
end

-- Dispara el jumpscare de pantalla SOLO si pasó el cooldown. Devuelve true si
-- salió. Lo usa también AnomalyDirector para no encadenar sustos de pantalla.
function AnomalyEventService:TryJumpscare(player)
	if not player or not player.Parent then return false end
	if not self:CanJumpscare(player) then return false end
	lastJumpscare[player] = os.clock()
	Network:FireClient(player, JUMPSCARE_CHANNEL)
	return true
end

-- Un susto a un jugador concreto: drena cordura + jumpscare o prop.
-- El jumpscare es la minoría de los casos y si está en cooldown se cae al prop.
function AnomalyEventService:Scare(player)
	if not player or not player.Parent then return end
	SanityService:LoseSanity(player, SANITY_SCARE, "Anomaly")
	if math.random() < JUMPSCARE_CHANCE and self:TryJumpscare(player) then
		return
	end
	spawnProp(player)
end

function AnomalyEventService:SetEnabled(on)
	self.Enabled = on and true or false
end

function AnomalyEventService:Init()
	if self._initialized then return end
	self._initialized = true

	task.spawn(function()
		while true do
			task.wait(CHECK_INTERVAL)
			if self.Enabled then
				for _, player in ipairs(alivePlayers()) do
					local sanity = player:GetAttribute("Sanity") or 100
					local chance = BASE_CHANCE + (1 - sanity / 100) * LOW_BONUS
					if math.random() < chance then
						self:Scare(player)
					end
				end
			end
		end
	end)

	-- print("[AnomalyEventService] inicializado — sustos ambientales")
end

return AnomalyEventService
