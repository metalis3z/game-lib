local rs = game:GetService("ReplicatedStorage")
local DataStore = game:GetService("DataStoreService")
local ds = DataStore:GetDataStore("LeaderStatSave")

local CollectionService = game:GetService("CollectionService")

local stageObjects = {}

local stageDebounce = false

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end

	table.insert(stageObjects[stage], cp)
end

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local productFunctions = {}

productFunctions[1668829119] = function(receipt, player)
	game.Lighting.Red.TintColor = Color3.new(1,0,0)
	game.Lighting.Red.Brightness = 0.5
	rs.Sounds.MCHit:Play()
	
	local tweenInf = TweenInfo.new(1)
	local tweenInf2 = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenInf3 = TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf, {Brightness = 0}):Play()
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf, {TintColor = Color3.new(1,1,1)}):Play()
	
	for i, v in pairs(Players:GetChildren()) do
		if game:GetService("Players"):FindFirstChild(player.Name) then
			local stage = player.leaderstats.Stage.Value
			
			if stageObjects[stage] then
				for i, v in pairs(stageObjects[stage]) do
					local label = player.PlayerGui.GameGUI.Frame.PlayerWhoKilled:Clone()
					label.Parent = player.PlayerGui.GameGUI.Frame
					label.Text = player.Name .. " has killed all! :O"
					game:GetService("TweenService"):Create(label, tweenInf2, {Position = UDim2.new(0.214, 0,0.2, 0)}):Play()
					game:GetService("TweenService"):Create(label, tweenInf3, {TextTransparency = 1}):Play()
					if v.Name == "Checkpoint" then
						local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
						FakeChar.Velocity = Vector3.new(0,0,0)
						FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
					end
				end
			end
		end
	end
end

local function processReceipt(receiptInfo)
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId

	local player = Players:GetPlayerByUserId(userId)
	if player then
		local handler = productFunctions[productId]
		local success, result = pcall(handler, receiptInfo, player)
		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("Failed to process receipt:", receiptInfo, result)
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end

MarketplaceService.ProcessReceipt = processReceipt