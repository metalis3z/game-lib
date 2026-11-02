local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local Net = require(ReplicatedStorage.Packages.Net)
local CombatService = require(script.Parent.CombatService)

local DestroyGear = Net:RemoteEvent("PinataService/DestroyGear")
local SpawnGear = Net:RemoteEvent("PinataService/SpawnGear")
local PickGear = Net:RemoteEvent("PinataService/PickGear")
local Blink = Net:RemoteEvent("PinataService/Blink")
local Burst = Net:RemoteEvent("PinataService/Burst")
local Hit = Net:RemoteEvent("PinataService/Hit")
local ApplyImpulse = Net:RemoteEvent("CombatService/ApplyImpulse")

local PinataService = {}

local ActivePinata: Model? = nil
local ActiveGears: {[string]: BasePart} = {}
local PinataHealth = 0
local MaxHealth = 100
local IsDestroyed = false

function PinataService:PinataSpawn()
	if ActivePinata and ActivePinata.Parent then
		ActivePinata:Destroy()
	end
	local clone = script.Pinata:Clone()
	clone.Name = "Pinata"
	clone.Parent = workspace
	ActivePinata = clone.Pinata
	PinataHealth = MaxHealth
	IsDestroyed = false
end

function PinataService:HitPinata(player: Player)
	if not ActivePinata or IsDestroyed then return end
	PinataHealth -= 10

	local hrp = ActivePinata:FindFirstChild("HumanoidRootPart") or ActivePinata.PrimaryPart
	if hrp then
		local attackerHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local attackerPos = attackerHRP and attackerHRP.Position or nil
		CombatService.Fling(hrp, 100, attackerPos)
	end

	local hitPos = hrp and hrp.Position or ActivePinata:GetPivot().Position
	Hit:FireAllClients(hitPos)

	if PinataHealth <= 0 then
		IsDestroyed = true
		PinataService:BreakPinata(hitPos)
	end
end

function PinataService:BreakPinata(position: Vector3)
	if not ActivePinata then return end
	Burst:FireAllClients(position)
	for i = 1, 5 do
		local id = "Gear_" .. i
		local startPos = position
		local endPos = position + Vector3.new(math.random(-10,10), math.random(5,10), math.random(-10,10))
		self:SpawnGear(id, "Gear", startPos, endPos, 1.5)
	end
	ActivePinata:Destroy()
	ActivePinata = nil
end

function PinataService:SpawnGear(id: string, gearName: string, startPos: Vector3, endPos: Vector3, duration: number)
	if ActiveGears[id] then ActiveGears[id]:Destroy() ActiveGears[id] = nil end
	local gearPart = Instance.new("Part")
	gearPart.Name = id
	gearPart.Anchored = true
	gearPart.CanCollide = false
	gearPart.Transparency = 1
	gearPart.CFrame = CFrame.new(startPos)
	gearPart.Parent = workspace
	ActiveGears[id] = gearPart
	local startTime = workspace:GetServerTimeNow()
	SpawnGear:FireAllClients(id, gearName, startPos, endPos, startTime, duration, tick())
end

function PinataService:DestroyGear(id: string)
	if ActiveGears[id] then
		ActiveGears[id]:Destroy()
		ActiveGears[id] = nil
	end
	DestroyGear:FireAllClients(id)
end

function PinataService:PickGear(player: Player, id: string)
	if not ActiveGears[id] then return end
	ActiveGears[id]:Destroy()
	ActiveGears[id] = nil
	DestroyGear:FireAllClients(id)
	PickGear:FireClient(player, id)
end

PickGear.OnServerEvent:Connect(function(player, id)
	PinataService:PickGear(player, id)
end)


return PinataService
