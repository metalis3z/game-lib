local Halloween = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local Net = require(ReplicatedStorage.Packages.Net)

local Name = script.Name
local DigStart = Net:RemoteEvent(("EventService/%s/DigStart"):format(Name))
local DigEnd = Net:RemoteEvent(("EventService/%s/DigEnd"):format(Name))
local PlayGraveyardAnimation = Net:RemoteEvent(("EventService/%s/PlayGraveyardAnimation"):format(Name))
local DigCollectVFX = Net:RemoteEvent(("EventService/%s/DigCollectVFX"):format(Name))
local Burst = Net:RemoteEvent(("EventService/%s/Burst"):format(Name))
local NotificationService = require(ServerScriptService.Services.NotificationService)

local BrainrotGravestones = script:WaitForChild("BrainrotGravestones")

local PlayerDigging = {}
local ActiveGraves = {}
local GraveFolderInWorkspace

function Halloween.OnStart()
	local clone = BrainrotGravestones:Clone()
	clone.Parent = workspace
	GraveFolderInWorkspace = clone
	for _, Player in pairs(Players:GetPlayers()) do
		NotificationService.Notify(Player, "You got a  <font color='#8B4513'>Agarrini Shovel</font>!", 15, "Sounds.Sfx.Success")
		local tool = ReplicatedStorage.Items:FindFirstChild("Agarrini Shovel")
		if tool then
			local c = tool:Clone()
			c.Parent = Player:FindFirstChildOfClass("Backpack") or Player
		end
	end
end

function Halloween.OnStop()
	if GraveFolderInWorkspace and GraveFolderInWorkspace.Parent then
		GraveFolderInWorkspace:Destroy()
		GraveFolderInWorkspace = nil
	end
	for _, Player in pairs(Players:GetPlayers()) do
		local backpack = Player:FindFirstChildOfClass("Backpack")
		if backpack then
			local t = backpack:FindFirstChild("Agarrini Shovel")
			if t then t:Destroy() end
		end
		local char = Player.Character
		if char then
			local t = char:FindFirstChild("Agarrini Shovel")
			if t then t:Destroy() end
		end
	end
end

DigStart.OnServerEvent:Connect(function(Player, Grave)
	if not Player or not Player.Parent then return end
	if PlayerDigging[Player] then return end
	if not Grave or not Grave:IsDescendantOf(workspace) then return end
	if not Grave.Name:match("^BrainrotGrave%d+$") then return end
	PlayerDigging[Player] = Grave
	local digsRequired = 1
	local sizeFactor = 1
	local primary = Grave:FindFirstChildWhichIsA("BasePart", true)
	if primary then
		local volume = primary:GetExtentsSize().X * primary:GetExtentsSize().Y * primary:GetExtentsSize().Z
		sizeFactor = math.clamp(volume / 1000, 0.5, 2)
		digsRequired = math.clamp(math.floor(6 * sizeFactor), 3, 12)
	end
	DigStart:FireClient(Player, Grave, digsRequired)
	PlayGraveyardAnimation:FireAllClients("GraveInteract", nil)
end)

DigEnd.OnServerEvent:Connect(function(Player, Grave)
	if not Player or not Player.Parent then return end
	if not PlayerDigging[Player] or PlayerDigging[Player] ~= Grave then return end
	PlayerDigging[Player] = nil
	if not Grave or not Grave:IsDescendantOf(workspace) then return end
	if ActiveGraves[Grave] then return end
	ActiveGraves[Grave] = true
	DigEnd:FireClient(Player)
	local pivotCFrame
	local primary = Grave:FindFirstChildWhichIsA("BasePart", true)
	if primary then
		pivotCFrame = primary.CFrame
	else
		pivotCFrame = Grave:GetPivot()
	end
	DigCollectVFX:FireAllClients(pivotCFrame, "DirtPop")
	local roll = math.random(1,100)
	if roll <= 70 then
		NotificationService.Notify(Player, "You dug up <font color='#FFD700'>Candy!</font>", 10, "Sounds.Sfx.Collect")
	elseif roll <= 95 then
		NotificationService.Notify(Player, "You found <font color='#00FFFF'>a Rare Token!</font>", 10, "Sounds.Sfx.Success")
	else
		NotificationService.Notify(Player, "You awakened a <font color='#FF0000'>Brainrot Spirit!</font>", 10, "Sounds.Sfx.Alert")
		Burst:FireAllClients(nil)
	end
	task.spawn(function()
		task.wait(1.2)
		if Grave and Grave.Parent then
			Grave:Destroy()
		end
		ActiveGraves[Grave] = nil
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	PlayerDigging[player] = nil
end)

return Halloween
