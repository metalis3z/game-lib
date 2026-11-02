-- BanHammerServer.lua (MADE BY TVMM!!!)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local CombatService = require(ServerScriptService.Services.CombatService)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)

local SlamEvent = Net:RemoteEvent("BanHammer/Slam")
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown") 
local StartCooldownEvent = Net:RemoteEvent("BanHammer/StartCooldown") 

local MAX_PUSH = 3000 
local MAX_UP = 120
local MAX_RAGDOLL = 5

StartCooldownEvent.OnServerEvent:Connect(function(player, chargePercent)
	if type(chargePercent) ~= "number" then return end

	local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
	if tool and tool.Name == "Ban Hammer" then
		local cooldownTime = (chargePercent >= 1) and 4 or (chargePercent < 0.2 and 0.5 or 1)
		ToolsCooldown:FireClient(player, tool, cooldownTime)
	end
end)

SlamEvent.OnServerEvent:Connect(function(player, hitCenter, radius, _, _, chargePercent)
	if typeof(hitCenter) ~= "Vector3" or type(radius) ~= "number" then return end

	radius = math.clamp(radius, 0, 35)
	chargePercent = math.clamp(chargePercent or 0.1, 0.1, 1)

	local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")

	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Exclude
	if player.Character then
		overlapParams.FilterDescendantsInstances = {player.Character} 
	end

	local partsInRadius = workspace:GetPartBoundsInRadius(hitCenter, radius, overlapParams)
	local hitModels = {} 

	for _, part in ipairs(partsInRadius) do
		local character = part.Parent
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")

		if humanoid and root and character ~= player.Character and not hitModels[character] and humanoid.Health > 0 then
			hitModels[character] = true 

			local force = MAX_PUSH * chargePercent
			CombatService.ProcessHit(root, player, player.Character, nil, tool, {
				Force = force,
				RagdollDuration = MAX_RAGDOLL * chargePercent
			})
		end
	end
end)