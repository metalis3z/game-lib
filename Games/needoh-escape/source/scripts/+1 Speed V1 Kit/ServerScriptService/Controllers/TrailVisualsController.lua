--!strict
-- LOCATION: ServerScriptService/Controllers/TrailVisualsController
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrailConfigurations = require(ReplicatedStorage.Modules.TrailConfigurations)
local TrailVisualsController = {}
local function createAttachments(character: Model)
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	if not rootPart then return nil, nil end
	local halfHeight = rootPart.Size.Y / 2
	local offset = halfHeight
	local att0 = rootPart:FindFirstChild("TrailAtt0") :: Attachment
	if not att0 then
		att0 = Instance.new("Attachment")
		att0.Name = "TrailAtt0"
		att0.Parent = rootPart
	end
	att0.Position = Vector3.new(0, offset, 0)
	local att1 = rootPart:FindFirstChild("TrailAtt1") :: Attachment
	if not att1 then
		att1 = Instance.new("Attachment")
		att1.Name = "TrailAtt1"
		att1.Parent = rootPart
	end
	att1.Position = Vector3.new(0, -offset, 0)
	return att0, att1
end
local function updateTrail(player: Player, trailId: string)
	local character = player.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	if not rootPart then return end
	-- 1. Cleanup old trail
	local oldTrail = rootPart:FindFirstChild("PlayerTrail")
	if oldTrail then oldTrail:Destroy() end
	if trailId == "" then return end
	-- 2. Validate Config
	local info = TrailConfigurations.GetTrailById(trailId)
	if not info then return end
	-- 3. Setup Attachments
	local att0, att1 = createAttachments(character)
	if not att0 or not att1 then return end
	-- 4. Create Visuals
	local trail = Instance.new("Trail")
	trail.Name = "PlayerTrail"
	trail.Attachment0 = att0
	trail.Attachment1 = att1
	trail.FaceCamera = true
	trail.Lifetime = 0.5
	trail.MinLength = 0
	trail.LightEmission = 1
	trail.Transparency = NumberSequence.new(0)
	trail.WidthScale = NumberSequence.new(1)
	if info.Color then 
		trail.Color = info.Color 
	end
	trail.Parent = rootPart
end
local function onPlayerAdded(player: Player)
	local function hook()
		local trails = player:WaitForChild("Trails", 10)
		if not trails then return end
		local equipped = trails:WaitForChild("Equipped") :: StringValue
		equipped.Changed:Connect(function(val)
			updateTrail(player, val)
		end)
		player.CharacterAdded:Connect(function(char)
			task.wait(1) -- Wait for physics/appearance to load
			updateTrail(player, equipped.Value)
		end)
		if player.Character then
			updateTrail(player, equipped.Value)
		end
	end
	task.spawn(hook)
end
function TrailVisualsController:Init()
	print("[TrailVisualsController] Initialized")
end
function TrailVisualsController:Start()
	for _, p in ipairs(Players:GetPlayers()) do
		onPlayerAdded(p)
	end
	Players.PlayerAdded:Connect(onPlayerAdded)
end
return TrailVisualsController