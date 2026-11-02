--credit to prince games studio
--[[
	BanHammerToolServer (MODDED)
	Va DENTRO del BanHammerTool. Corre en el servidor cuando el tool está en la
	Backpack/Character del jugador. Al activar (clic con el tool equipado):
	  1) Aparece BanHammerParticle en la posición del jugador (emite y desaparece).
	  2) Detecta jugadores dentro de la hitbox (mismo tamaño que Assets...BanHammer.Hitbox)
	     y al primero válido lo banea vía GameServerAPI.BanPlayer.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local GameServerAPI = require(ServerScriptService:WaitForChild("GameServerAPI"))

local tool = script.Parent
local BanHammerFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("BanHammer")
local ParticleTemplate = BanHammerFolder:WaitForChild("BanHammerParticle")
local HitboxTemplate = BanHammerFolder:WaitForChild("BanHammer"):WaitForChild("Hitbox")
local HITBOX_SIZE = HitboxTemplate.Size
local SoundTemplate = HitboxTemplate:FindFirstChild("Sound") -- se reproduce al usar el tool

local COOLDOWN = 1.5
local lastUse = 0

local function emitParticles(cf: CFrame)
	local fx = ParticleTemplate:Clone()
	fx.Anchored = true
	fx.CanCollide = false
	fx.CanQuery = false
	fx.CFrame = cf
	fx.Parent = workspace
	-- Los emitters ya vienen Enabled=true: solo aparece un momento y se va.
	Debris:AddItem(fx, 2)
end

-- Crea un HITBOX REAL (Part invisible) enfrente del jugador, con el tamaño de
-- Assets.BanHammer.BanHammer.Hitbox, y devuelve el jugador objetivo más cercano
-- que esté dentro de él (GetPartsInPart sobre la geometría del hitbox).
local function findTarget(wielder: Player, char: Model): Player?
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return nil
	end

	local hitbox = Instance.new("Part")
	hitbox.Name = "BanHitbox"
	hitbox.Size = HITBOX_SIZE
	-- justo enfrente del jugador (la caja se extiende hacia adelante)
	hitbox.CFrame = hrp.CFrame * CFrame.new(0, 0, -(HITBOX_SIZE.Z / 2 + 1.5))
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.CanQuery = true
	hitbox.CanTouch = true
	hitbox.Transparency = 1
	hitbox.Parent = workspace

	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { char, hitbox }
	local parts = workspace:GetPartsInPart(hitbox, params)
	local center = hitbox.Position
	Debris:AddItem(hitbox, 0.2)

	local best, bestDist = nil, math.huge
	for _, part in parts do
		local model = part:FindFirstAncestorOfClass("Model")
		if model then
			local other = Players:GetPlayerFromCharacter(model)
			local hum = model:FindFirstChildOfClass("Humanoid")
			if other and other ~= wielder and hum and hum.Health > 0 then
				local d = (model:GetPivot().Position - center).Magnitude
				if d < bestDist then
					best, bestDist = other, d
				end
			end
		end
	end
	return best
end

tool.Activated:Connect(function()
	local now = os.clock()
	if now - lastUse < COOLDOWN then
		return
	end
	lastUse = now

	local char = tool.Parent
	local wielder = Players:GetPlayerFromCharacter(char)
	if not wielder then
		return
	end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	-- 1) partículas + sonido en el lugar del jugador
	emitParticles(hrp.CFrame)
	if SoundTemplate then
		local s = SoundTemplate:Clone()
		s.Parent = hrp
		s:Play()
		Debris:AddItem(s, 5)
	end

	-- 2) detectar y banear
	local target = findTarget(wielder, char)
	if target then
		GameServerAPI.WaitFor("BanPlayer")(target, wielder)
	end
end)
