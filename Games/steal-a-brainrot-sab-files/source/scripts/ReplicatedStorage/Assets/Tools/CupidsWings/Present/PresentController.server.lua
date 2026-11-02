local Part = script.Parent.Main
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local CombatService = require(ServerScriptService.Services.CombatService)
local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("SantasSleigh")

local exploded = false

Part.Touched:Connect(function(hit)
	if exploded then return end

	local character = hit:FindFirstAncestorOfClass("Model")
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if humanoid and root and humanoid.Health > 0 then
		local player = Players:GetPlayerFromCharacter(character)
		local ownerId = Part:GetAttribute("OwnerID")

		if player and player.UserId == ownerId then return end

		exploded = true

		local explosionSnd = ToolAssets.PresentExplosionSound:Clone()
		explosionSnd.Parent = root
		explosionSnd:Play()
		Debris:AddItem(explosionSnd, 3)

		local stunnedSnd = ToolAssets.PresentStunnedSound:Clone()
		stunnedSnd.Parent = root
		stunnedSnd:Play()
		Debris:AddItem(stunnedSnd, 5)

		CombatService.ProcessHit(root, nil, nil, nil, nil, {
			Force = 120,
			RagdollDuration = 4
		})

		Part:Destroy()
	end
end)