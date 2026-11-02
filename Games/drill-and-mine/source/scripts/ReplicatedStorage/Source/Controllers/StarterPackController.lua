local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local StarterPackController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")
local PurchaseResultEvent = PurchaseRemotes:WaitForChild("PurchaseResult")

local StoreRemotes = Remotes:WaitForChild("StoreService")
local RequestPackStatusFunc = StoreRemotes:WaitForChild("RequestPackStatus")

local PACK_NAME = "StarterPack"
local CONTEXT = "Pack_" .. PACK_NAME

local HIDE_TWEEN_TIME = 0.45
local HIDE_TILT = 25

local player = Players.LocalPlayer
local packFrame = nil
local originalFrameSize = nil
local buying = false
local hiding = false

local function hidePackInstant()
	if packFrame then
		packFrame.Visible = false
	end
end

local function hidePack()
	if not packFrame or hiding or not packFrame.Visible then
		return
	end
	hiding = true

	local sizeInfo = TweenInfo.new(HIDE_TWEEN_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local fadeInfo = TweenInfo.new(HIDE_TWEEN_TIME * 0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	TweenService:Create(packFrame, sizeInfo, {
		Size = UDim2.new(0, 0, 0, 0),
		Rotation = HIDE_TILT,
	}):Play()

	for _, desc in ipairs(packFrame:GetDescendants()) do
		if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
			TweenService:Create(desc, fadeInfo, { ImageTransparency = 1 }):Play()
		elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
			TweenService:Create(desc, fadeInfo, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
		elseif desc:IsA("UIStroke") then
			TweenService:Create(desc, fadeInfo, { Transparency = 1 }):Play()
		end
	end

	task.delay(HIDE_TWEEN_TIME + 0.05, function()
		if packFrame then
			packFrame.Visible = false
		end
		hiding = false
	end)
end

local function findPriceLabel(rotateIcon)
	for _, child in ipairs(rotateIcon:GetChildren()) do
		if child:IsA("TextLabel") and child.Name == "Title" then
			local text = child.Text or ""
			if tonumber(text) or text:match("^%d") then
				return child
			end
		end
	end
	return nil
end

local function applyPriceLabel(rotateIcon, priceRobux)
	local label = findPriceLabel(rotateIcon)
	if label and priceRobux then
		label.Text = tostring(priceRobux)
	end
end

local function onClick()
	if buying or hiding then
		return
	end
	local packConfig = GameConfig.Packs and GameConfig.Packs[PACK_NAME]
	if not packConfig then
		warn(string.format("[StarterPackController] missing config: %s", PACK_NAME))
		return
	end
	local productId = packConfig.ProductId
	if not productId or productId == 0 then
		warn(string.format("[StarterPackController] ProductId not configured for %s", PACK_NAME))
		return
	end

	buying = true
	task.spawn(function()
		local ok, result = pcall(function()
			return PromptPurchaseFunc:InvokeServer(productId, CONTEXT)
		 end)
		buying = false
		if ok and result then
			hidePack()
		end
	end)
end

local function checkPurchased()
	local ok, packStatus = pcall(function()
		return RequestPackStatusFunc:InvokeServer()
	end)
	if not ok or type(packStatus) ~= "table" then
		return
	end
	local status = packStatus[PACK_NAME]
	if status and (status.Purchased or status.Expired) then
		hidePackInstant()
	end
end

function StarterPackController.Init()
	local playerGui = player:WaitForChild("PlayerGui")
	local gui = playerGui:WaitForChild("GUI", 15)
	if not gui then
		return
	end
	local hud = gui:WaitForChild("HUD", 15)
	if not hud then
		return
	end
	packFrame = hud:WaitForChild("Pack", 15)
	if not packFrame then
		return
	end

	originalFrameSize = packFrame.Size

	local rotateIcon = packFrame:WaitForChild("RotateIcon", 10)
	if not rotateIcon then
		return
	end

	local packConfig = GameConfig.Packs and GameConfig.Packs[PACK_NAME]
	if packConfig and packConfig.PriceRobux then
		applyPriceLabel(rotateIcon, packConfig.PriceRobux)
	end

	rotateIcon.MouseButton1Click:Connect(onClick)

	PurchaseResultEvent.OnClientEvent:Connect(function(status, context)
		if status == "Success" and context == CONTEXT then
			hidePack()
		end
	end)

	task.spawn(checkPurchased)
end

return StarterPackController
