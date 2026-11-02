-- Bat Tool Server Script (Hit Detection)

local Tool = script.Parent
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HIT_RANGE = 8
local HIT_ANGLE = 120

-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local BatSwingRemote = Remotes:FindFirstChild("BatSwingRemote")
if not BatSwingRemote then
	BatSwingRemote = Instance.new("RemoteEvent")
	BatSwingRemote.Name = "BatSwingRemote"
	BatSwingRemote.Parent = Remotes
end

local BatHitConfirm = Remotes:FindFirstChild("BatHitConfirm")
if not BatHitConfirm then
	BatHitConfirm = Instance.new("RemoteEvent")
	BatHitConfirm.Name = "BatHitConfirm"
	BatHitConfirm.Parent = Remotes
end

local BatHitBindable = Remotes:FindFirstChild("BatHitBindable")
if not BatHitBindable then
	BatHitBindable = Instance.new("BindableEvent")
	BatHitBindable.Name = "BatHitBindable"
	BatHitBindable.Parent = Remotes
end

local function getPlayersInFront(character, attacker)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return {} end

	local hitPlayers = {}

	for _, player in ipairs(Players:GetPlayers()) do
		if player == attacker then continue end

		local otherChar = player.Character
		if not otherChar then continue end

		local otherHRP = otherChar:FindFirstChild("HumanoidRootPart")
		if not otherHRP then continue end

		local toTarget = (otherHRP.Position - hrp.Position)
		local distance = toTarget.Magnitude
		if distance > HIT_RANGE then continue end

		local lookDir = hrp.CFrame.LookVector
		local dirToTarget = toTarget.Unit
		local dot = lookDir:Dot(dirToTarget)
		local angleDeg = math.deg(math.acos(math.clamp(dot, -1, 1)))

		if angleDeg <= HIT_ANGLE / 2 then
			table.insert(hitPlayers, player)
		end
	end

	return hitPlayers
end

BatSwingRemote.OnServerEvent:Connect(function(attacker)
	local character = attacker.Character
	if not character then return end

	task.delay(0.15, function()
		local hitPlayers = getPlayersInFront(character, attacker)

		local didHit = #hitPlayers > 0

		-- tell attacker client if hit happened
		BatHitConfirm:FireClient(attacker, didHit)

		for _, victim in ipairs(hitPlayers) do
			BatHitBindable:Fire(attacker, victim)
		end
	end)
end)
