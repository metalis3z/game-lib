--!native
local FatSammy = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Time = require(ReplicatedStorage.Utils.TimeUtils)

local PlaySpawnSequence = Net:RemoteEvent("EventService/FatSammy/PlaySpawnSequence")
local PlayEatAnimation = Net:RemoteEvent("EventService/FatSammy/PlayEatAnimation")
local Delivery = Net:RemoteEvent("EventService/FatSammy/Delivery")
local FatSammyModel = workspace.Events:WaitForChild("FatSammy"):WaitForChild("Model")

local Max = 1
local InMachine = 0
local FullTriggered = false

local RandomBrainrots = {
	["Tipi Topi Taco"] = {Chance = 80},
	["Bombardini Tortinii"] = {Chance = 60},
	["Los Tipi Tacos"] = {Chance = 40},
	["Capi Taco"] = {Chance = 80},
	["Nooo My Hotspot"] = {Chance = 5},
	["Los Nooo My Hotspotsitos"] = {Chance = 2.5}
}

local function PickRandomBrainrot()
	local totalChance = 0
	for _, info in pairs(RandomBrainrots) do
		totalChance += info.Chance
	end
	local roll = math.random() * totalChance
	local cumulative = 0
	for name, info in pairs(RandomBrainrots) do
		cumulative += info.Chance
		if roll <= cumulative then
			return name
		end
	end
end

local function FullFunction()
	AnimalService:PauseSpawning()
	PlaySpawnSequence:FireAllClients(workspace:GetServerTimeNow())
	task.wait(6.8)
	local mutationList = {"Gold", "Diamond", "Rainbow"}
	local selectedMutation = math.random() < 0.15 and mutationList[math.random(1, #mutationList)] or nil
	local brainrotName = PickRandomBrainrot()
	AnimalService:SpawnNoDelay(Animals[brainrotName], selectedMutation, {}, nil, nil, nil, true)
	task.wait(1.5)
	AnimalService:UnpauseSpawning()
	FullTriggered = false
	InMachine = 0
end

local function UpdateDisplay()
	local scaleValue = math.clamp(InMachine / Max, 0, 1)
	FatSammyModel.Overhead.BillboardGui.Amount.Text = InMachine.."/"..Max
	FatSammyModel.Sammy:SetAttribute("ScaleAlpha", scaleValue)
	if InMachine >= Max and not FullTriggered then
		FullTriggered = true
		FullFunction()
	elseif InMachine < Max and FullTriggered then
		FullTriggered = false
	end
end

local function AddTaco(amount)
	InMachine = math.min(InMachine + amount, Max)
end
function notify(player)
	local playerGui = player:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "FatSammyNotification"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local label = Instance.new("TextLabel")
	label.Parent = screenGui
	label.Size = UDim2.new(1, 0, 0, 50)
	label.Position = UDim2.new(0, 0, 1, -60)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.Font = Enum.Font.SourceSansBold
	label.RichText = true
	label.TextStrokeTransparency = 0
	label.Text = 'Sammy is here and wants <font color="rgb(255,221,0)">Tacos!</font>'
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextTransparency = 1

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(label, tweenInfo, {TextTransparency = 0}):Play()

	task.delay(5, function()
		screenGui:Destroy()
	end)
end

RunService.Heartbeat:Connect(UpdateDisplay)

function FatSammy:GetPivotCFrame()
	if FatSammyModel then
		local pivot
		pcall(function() pivot = FatSammyModel:GetPivot() end)
		if pivot then return pivot end
		for _, v in ipairs(FatSammyModel:GetDescendants()) do
			if v:IsA("BasePart") then return v.CFrame end
		end
	end
	return CFrame.new()
end

function FatSammy:SetPivot(cf)
	if FatSammyModel then
		pcall(function() FatSammyModel:PivotTo(cf) end)
	end
end

function FatSammy:OnStart()
	FatSammy:SetPivot(CFrame.new(-441.17, -5, 30.05))
	local endTime = EventService:GetEndTime("FatSammy")
	if not endTime then return end
	task.spawn(function()
		while workspace:GetServerTimeNow() < endTime do
			local remaining = math.max(0, endTime - workspace:GetServerTimeNow())
			FatSammyModel.Overhead.BillboardGui.Countdown.Text = Time:E(remaining)
			task.wait(1)
		end
	end)
end

function FatSammy:OnStop()
	FatSammy:SetPivot(CFrame.new(0, 100000, 0))
	FullTriggered = false
	InMachine = 0
end

function FatSammy:AutoEat()
	AddTaco(Max - InMachine)
end

Delivery.OnServerEvent:Connect(function(player)
	local Data = Synchronizer:Get(player)
	if not Data then return end
	local StealData = StealService:GetStealData(player)
	if not StealData then return end
	local StolenAnimalData = StealData.StolenAnimalData
	if not StolenAnimalData then return end
	local hasTaco = false
	for _, trait in ipairs(StolenAnimalData.Traits or {}) do
		if trait == "Taco" then
			hasTaco = true
			break
		end
	end
	if hasTaco then
		StealService:CancelSteal(player)
		AddTaco(1)
		PlayEatAnimation:FireAllClients()
		local VictimPlotUID = StealData.VictimPlotUID
		local PlotData = Synchronizer:Get(VictimPlotUID)
		local Owner = Synchronizer:Get(PlotData:Get("Owner"))
		local Podiums = Owner:Get("AnimalPodiums") or {}
		Podiums[StealData.PodiumIndex] = "Empty"
		Owner:Set("AnimalPodiums", Podiums)
		Owner:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	else
		return "No Taco"
	end
end)

return FatSammy
