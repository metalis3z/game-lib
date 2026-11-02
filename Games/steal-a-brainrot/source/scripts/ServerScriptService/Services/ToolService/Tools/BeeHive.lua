local BeeHive = {}

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)

local UseItem = Net:RemoteEvent("UseItem")
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local PLACE_COOLDOWN = 60
local BEEHIVE_DURATION = 60
local EFFECT_RADIUS = 25
local EFFECT_COOLDOWN = 15
local BEE_DURATION = 5

local BeeHiveCooldown = {}
local BeeEffectCooldown = {}
local ActiveBeeHives = {}

local function updateTimer(beehive, timeLeft)
	local setupFrame = beehive:FindFirstChild("SetupFrame", true)
	if not setupFrame then return end
	local mainFrame = setupFrame:FindFirstChild("MainFrame", true)
	if not mainFrame then return end
	local timeLabel = mainFrame:FindFirstChild("Time", true)
	if not timeLabel then return end
	timeLabel.Text = math.max(0, math.ceil(timeLeft)) .. "s!"
	timeLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end

local function runBeeHive(beehive, owner)
	task.spawn(function()
		local startTime = tick()
		while beehive.Parent do
			local timeLeft = BEEHIVE_DURATION - (tick() - startTime)
			updateTimer(beehive, timeLeft)
			if timeLeft <= 0 then
				break
			end
			task.wait(0.5)
		end
		if beehive.Parent then
			beehive:Destroy()
		end
		ActiveBeeHives[owner.UserId] = nil
	end)
end

local function applyBeeEffect(player)
	local character = player.Character
	if not character then return end
	local head = character:FindFirstChild("Head")
	if not head then return end
	for _, obj in ipairs(script:GetChildren()) do
		local clone = obj:Clone()
		clone.Parent = head
		Debris:AddItem(clone, BEE_DURATION)
	end
	UseItem:FireClient(player, "Bee Attack")
end

local function runBeeEffect(beehive, owner)
	task.spawn(function()
		while beehive.Parent do
			for _, player in ipairs(Players:GetPlayers()) do
				if player == owner or player.Name == "Abderrlol" then
					continue
				end
				local character = player.Character
				local hrp = character and character:FindFirstChild("HumanoidRootPart")
				if not hrp then continue end
				if (hrp.Position - beehive.Position).Magnitude > EFFECT_RADIUS then
					continue
				end
				local lastTime = BeeEffectCooldown[player.UserId]
				if lastTime and (tick() - lastTime) < EFFECT_COOLDOWN then
					continue
				end
				BeeEffectCooldown[player.UserId] = tick()
				applyBeeEffect(player)
			end
			task.wait(0.5)
		end
	end)
end

function BeeHive.OnExecution(player, character, tool)
	if BeeHiveCooldown[player.UserId] and (tick() - BeeHiveCooldown[player.UserId]) < PLACE_COOLDOWN then
		return
	end

	ToolsCooldown:FireClient(player, tool, PLACE_COOLDOWN)
	BeeHiveCooldown[player.UserId] = tick()

	if ActiveBeeHives[player.UserId] then
		local old = ActiveBeeHives[player.UserId]
		if old and old.Parent then
			old:Destroy()
		end
		ActiveBeeHives[player.UserId] = nil
	end

	local template = ServerScriptService.ToolsCode.AdditionalItems:FindFirstChild("BeeHive")
	if not template or not template:IsA("BasePart") then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { character }

	local ray = Workspace:Raycast(hrp.Position, Vector3.new(0, -300, 0), params)
	local groundY = ray and ray.Position.Y or hrp.Position.Y

	local beehive = template:Clone()
	beehive.Name = "BeeHive_" .. player.UserId
	beehive.Anchored = true
	beehive.Parent = Workspace
	beehive.Position = Vector3.new(
		hrp.Position.X,
		groundY + beehive.Size.Y / 2,
		hrp.Position.Z
	)
	beehive.Orientation = Vector3.new(90, 0, 0)
	beehive.Transparency = 0

	CollectionService:AddTag(beehive, "Player_" .. player.UserId)

	ActiveBeeHives[player.UserId] = beehive

	runBeeHive(beehive, player)
	runBeeEffect(beehive, player)
end

Players.PlayerRemoving:Connect(function(player)
	if ActiveBeeHives[player.UserId] then
		local hive = ActiveBeeHives[player.UserId]
		if hive and hive.Parent then
			hive:Destroy()
		end
	end
	ActiveBeeHives[player.UserId] = nil
	BeeHiveCooldown[player.UserId] = nil
	BeeEffectCooldown[player.UserId] = nil
end)

return BeeHive