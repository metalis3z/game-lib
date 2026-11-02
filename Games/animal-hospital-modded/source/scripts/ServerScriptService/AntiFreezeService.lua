--[[
	AntiFreezeService — que NADA deje al jugador clavado en el sitio

	Reportado: "hay una anomalía que congela a los players". Sea cual sea la que
	lo provoca (susto, anomalía de mundo, skinwalker, un piso con SpeedMod, un
	Humanoid que se cuelga en FallingDown al caer raro con el morph...), el
	síntoma siempre es el mismo y se puede deshacer: WalkSpeed en 0/NaN,
	PlatformStand encendido, el Humanoid trabado en un estado del que no sale, o
	el HumanoidRootPart anclado.

	Este servicio vigila a TODOS los jugadores (morfeados o no) una vez por
	segundo y los destraba. Con LOG = true avisa en el Output QUÉ los tenía
	congelados, para poder atacar la causa exacta.

	RESPETA los bloqueos legítimos:
	  · atributo "_Frozen" en el Character  -> freeze de admin (TrollActionServer)
	  · Humanoid.Sit                        -> sentado a propósito
	  · Humanoid muerto
	  · anclado en un personaje NORMAL      -> así es como congela HD Admin;
	    solo se desancla si el personaje es un MORPH (atributo IsMorph), que es
	    donde no hay ningún sistema legítimo que ancle.

	API: AntiFreezeService:Init()
]]

local Players = game:GetService("Players")

local AntiFreezeService = {}

local CHECK_INTERVAL = 1
local NORMAL_WALKSPEED = 16
local LOG = true       -- avisa en el Output cada vez que destraba a alguien
local STUCK_SECONDS = 3  -- s queriendo caminar sin avanzar antes del empujón
local UNSTICK_LIFT = 2   -- studs que sube el empujón para despegarlo del piso/pared

local stuckFor = {}      -- [player] = segundos seguidos atascado
local lastPos = {}       -- [player] = posición del chequeo anterior

local function badNumber(n)
	return type(n) ~= "number" or n ~= n or n <= 0   -- n ~= n -> NaN
end

local function log(player, what)
	if LOG then
		warn(("[AntiFreeze] %s estaba congelado: %s -> destrabado"):format(player.Name, what))
	end
end

local function watch(player, char)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	task.spawn(function()
		while char.Parent and player.Parent and player.Character == char do
			task.wait(CHECK_INTERVAL)

			if hum.Health <= 0 then break end
			-- bloqueos a propósito: no tocar
			if char:GetAttribute("_Frozen") or hum.Sit then continue end

			if badNumber(hum.WalkSpeed) then
				log(player, ("WalkSpeed = %s"):format(tostring(hum.WalkSpeed)))
				hum.WalkSpeed = NORMAL_WALKSPEED
			end

			if hum.PlatformStand then
				log(player, "PlatformStand encendido")
				hum.PlatformStand = false
			end

			local state = hum:GetState()
			if state == Enum.HumanoidStateType.PlatformStanding
				or state == Enum.HumanoidStateType.FallingDown
				or state == Enum.HumanoidStateType.Ragdoll
			then
				log(player, "Humanoid trabado en " .. tostring(state))
				hum:ChangeState(Enum.HumanoidStateType.GettingUp)
			end

			-- Anclado: en el morph nadie tiene por qué anclarte; en un personaje
			-- normal es como congela HD Admin, así que ahí se respeta.
			local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
			if char:GetAttribute("IsMorph") and root and root.Anchored then
				log(player, "HumanoidRootPart anclado")
				root.Anchored = false
			end

			-- LA CAUSA REAL DEL CONGELAMIENTO DEL MORPH (confirmada con MoveDebug:
			-- MoveDir=1.00, WalkSpeed=16, sin anclaje... y Vel=0.04):
			-- la asamblea la simula el SERVIDOR, no el jugador. El cliente mueve
			-- su Humanoid pero esa física no es la autoritativa y se descarta, así
			-- que el personaje se queda vibrando en el sitio. Se le devuelve la
			-- propiedad al jugador.
			if root and not root.Anchored then
				local ok, owner = pcall(function() return root:GetNetworkOwner() end)
				if ok and owner ~= player then
					log(player, ("la fisica la simulaba %s en vez del jugador (network owner)")
						:format(owner and owner.Name or "el SERVIDOR"))
					pcall(function() root:SetNetworkOwner(player) end)
				end
			end

			-- Último recurso: tiene la propiedad, quiere caminar (MoveDirection) y
			-- aun así no avanza -> está ATASCADO en la geometría. Se lo empuja un
			-- par de studs hacia arriba para despegarlo.
			if root and not root.Anchored and hum.MoveDirection.Magnitude > 0.05 then
				-- Se mide el DESPLAZAMIENTO real entre chequeos (no la velocidad):
				-- así efectos que empujan al jugador (el "hielo" del admin pack,
				-- knockbacks, cintas) no cuentan como atascado si de verdad se
				-- está moviendo.
				local pos = root.Position
				local last = lastPos[player]
				lastPos[player] = pos
				if last and (pos - last).Magnitude < 1 then
					stuckFor[player] = (stuckFor[player] or 0) + CHECK_INTERVAL
					if stuckFor[player] >= STUCK_SECONDS then
						stuckFor[player] = 0
						log(player, "atascado en la geometria -> empujon hacia arriba")
						root.CFrame = root.CFrame + Vector3.new(0, UNSTICK_LIFT, 0)
					end
				else
					stuckFor[player] = 0
				end
			else
				stuckFor[player] = 0
			end
		end
	end)
end

local function hookPlayer(player)
	player.CharacterAdded:Connect(function(char)
		watch(player, char)
	end)
	if player.Character then
		watch(player, player.Character)
	end
end

function AntiFreezeService:Init()
	if self._initialized then return end
	self._initialized = true

	Players.PlayerAdded:Connect(hookPlayer)
	for _, player in ipairs(Players:GetPlayers()) do
		hookPlayer(player)
	end

	Players.PlayerRemoving:Connect(function(player)
		stuckFor[player] = nil
		lastPos[player] = nil
	end)

	-- print("[AntiFreezeService] listo — vigilando congelamientos")
end

return AntiFreezeService
