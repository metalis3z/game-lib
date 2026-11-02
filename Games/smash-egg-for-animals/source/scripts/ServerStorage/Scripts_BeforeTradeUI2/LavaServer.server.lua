-- Lave (pièces taguées "Lava") : on s'y enfonce, et dès qu'un joueur (ou son dragon) est dedans, il perd ce qu'il porte
-- et il est renvoyé près des boutiques, comme quand un gardien le touche.
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local binds = ServerStorage:WaitForChild("GameBindables")
local alert = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("BossAlert")
local DEPTH = 1.5 -- on est "dedans" dès qu'on passe à moins de 1,5 stud sous la surface

local function returnPoint()
	local a, b = workspace:FindFirstChild("egg shop"), workspace:FindFirstChild("dragon shop")
	if a and b then
		local mid = (a:GetBoundingBox().Position + b:GetBoundingBox().Position) / 2
		local hit = workspace:Raycast(Vector3.new(mid.X - 22, mid.Y + 60, mid.Z), Vector3.new(0, -200, 0))
		return Vector3.new(mid.X - 22, hit and hit.Position.Y or 0, mid.Z)
	end
	local safe = workspace:FindFirstChild("safe zone")
	return safe and (safe.Position + Vector3.new(0, safe.Size.Y / 2, 0)) or Vector3.new(0, 5, 0)
end

local function inLava(position)
	for _, lava in CollectionService:GetTagged("Lava") do
		if lava:IsA("BasePart") then
			local r = lava.CFrame:PointToObjectSpace(position)
			if math.abs(r.X) <= lava.Size.X / 2 and math.abs(r.Z) <= lava.Size.Z / 2 and r.Y <= lava.Size.Y / 2 - DEPTH + 3 and r.Y >= -lava.Size.Y / 2 - 40 then return true end
		end
	end
	return false
end

while true do
	task.wait(0.15)
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if hrp and inLava(hrp.Position) then
			binds.DropCarried:Fire(player)
			local destination = returnPoint()
			local dragon
			local dragons = workspace:FindFirstChild("Dragons")
			for _, d in dragons and dragons:GetChildren() or {} do
				if d:GetAttribute("Rider") == player.UserId and d.PrimaryPart then dragon = d end
			end
			if dragon then
				dragon:PivotTo(CFrame.new(destination + Vector3.new(0, 3, 0)))
				dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
			else
				hrp.AssemblyLinearVelocity = Vector3.zero
				character:PivotTo(CFrame.new(destination + Vector3.new(0, 5, 0)))
			end
			alert:FireClient(player, "You fell in the lava!", true)
		end
	end
end
