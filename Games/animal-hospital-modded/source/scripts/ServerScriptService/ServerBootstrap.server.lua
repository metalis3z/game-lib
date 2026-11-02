--[[
	ServerBootstrap — punto de entrada del server side (reconstrucción por fases).
	Fase 1: DataService, CharacterService.
	Fase 2: SanityService, DoorService (entrada), DoorsService (puertas interiores),
	        PatientService (NPCs), CheckInService (estación), MiscService (props Misc).
	Próximas slices (economía/tienda/herramientas, enfermedades, curar, rondas) aquí.
]]

local ServerScriptService = game:GetService("ServerScriptService")

local DataService = require(ServerScriptService:WaitForChild("DataService"))
local CharacterService = require(ServerScriptService:WaitForChild("CharacterService"))
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))
local DoorService = require(ServerScriptService:WaitForChild("DoorService"))
local DoorsService = require(ServerScriptService:WaitForChild("DoorsService"))
local PatientService = require(ServerScriptService:WaitForChild("PatientService"))
local CheckInService = require(ServerScriptService:WaitForChild("CheckInService"))
local MiscService = require(ServerScriptService:WaitForChild("MiscService"))
-- Fase 3: backpack (curas) + loop de curar pacientes
local ToolService = require(ServerScriptService:WaitForChild("ToolService"))
-- Grip generico: hace que CUALQUIER Tool con Handle (Gun, M4, espada, boombox,
-- tools de clase...) se pueda equipar y se vea bien tambien estando morfeado.
local ToolGripService = require(ServerScriptService:WaitForChild("ToolGripService"))
-- Red anti-congelamiento: destraba a cualquier jugador que quede clavado
-- (WalkSpeed 0/NaN, PlatformStand, Humanoid trabado, morph anclado).
local AntiFreezeService = require(ServerScriptService:WaitForChild("AntiFreezeService"))
local MinigameService = require(ServerScriptService:WaitForChild("MinigameService"))
local PatientCareService = require(ServerScriptService:WaitForChild("PatientCareService"))
local SupplyService = require(ServerScriptService:WaitForChild("SupplyService"))
-- Fase 4: clases (perks por nivel) + turnos/rondas + progresión (cash/XP/level)
local ClassService = require(ServerScriptService:WaitForChild("ClassService"))
local ShiftService = require(ServerScriptService:WaitForChild("ShiftService"))
-- Fase 5: núcleo terror — skinwalkers + foto + rechazo (+ cirugías vía MinigameService)
local AnomalyService = require(ServerScriptService:WaitForChild("AnomalyService"))
local RejectionService = require(ServerScriptService:WaitForChild("RejectionService"))
local PhotoService = require(ServerScriptService:WaitForChild("PhotoService"))
-- Fase 8: sustos ambientales (jumpscares + props de terror por cordura baja)
local AnomalyEventService = require(ServerScriptService:WaitForChild("AnomalyEventService"))
-- Fase 9: director de anomalías físicas (spawnea los modelos de NPCs.Anomalies)
local AnomalyDirector = require(ServerScriptService:WaitForChild("AnomalyDirector"))
-- Fase 10: arma de fuego comprable (DevProduct) + dueño de ProcessReceipt
local GunService = require(ServerScriptService:WaitForChild("GunService"))
-- Fase 11: consumibles de cordura (Coffee/Chocolate/Brain, handle Tools)
local ConsumableService = require(ServerScriptService:WaitForChild("ConsumableService"))
-- Fase 13: NPCs baleados -> cargar a Emergency (downed/Sleep + Counter 50s)
local EmergencyService = require(ServerScriptService:WaitForChild("EmergencyService"))
-- Fase 14: skinwalker monster customizado (cara/ojos EasyAssets + color Textures) que patrulla
local SkinwalkerService = require(ServerScriptService:WaitForChild("SkinwalkerService"))

DataService:Init()
CharacterService:Init()
SanityService:Init()
DoorService:Init()
DoorsService:Init()
PatientService:Init()
CheckInService:Init()
MiscService:Init()
ToolService:Init()
ToolGripService:Init()   -- antes que Gun/Consumable: engancha toda Tool que llegue al jugador
AntiFreezeService:Init() -- vigila que nada deje al jugador clavado en el sitio
MinigameService:Init()
PatientCareService:Init() -- después de PatientService (setea su CareHandler)
SupplyService:Init()
ClassService:Init()
AnomalyService:Init()
-- RejectionService:Init()   -- DESACTIVADO: sin decisión Admit/Reject; tras "Talk" el NPC auto-rutea (paciente->sala, impostor->se va). Reactivar quitando el comentario.
PhotoService:Init()
ShiftService:Init()       -- después de Class/Patient/Care/Rejection (engancha sus eventos)
AnomalyEventService:Init() -- sustos ambientales
AnomalyDirector:Init()     -- anomalías físicas (Shadow/TallMonster/EyeMass/Ghost/Hider/BedMonster/Stalker/Figure)
GunService:Init()          -- arma comprable + ProcessReceipt (DevProducts)
ConsumableService:Init()   -- consumibles de cordura (café/chocolate/brain)
EmergencyService:Init()    -- carry de NPCs baleados a Emergency
SkinwalkerService:Init()   -- skinwalkers customizados que patrullan (cámara/foto los revelan)

-- print("[ServerBootstrap] Fase 1-4 (backpack + curar + clases + turnos) listas")
