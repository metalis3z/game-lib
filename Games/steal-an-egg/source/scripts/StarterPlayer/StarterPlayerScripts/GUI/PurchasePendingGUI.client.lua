-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local MarketplaceService = game:GetService("MarketplaceService")
local Player = require(ReplicatedStorage.Library.Player)
local GIF2 = require(ReplicatedStorage.Library.Client.GUIFX.GIF2)
local Functions = require(ReplicatedStorage.Library.Functions)
local Signal = require(ReplicatedStorage.Library.Signal)
local Network = require(ReplicatedStorage.Library.Client.Network)
local v1 = Player.PlayerGui()
local v2 = false
local v3 = nil
local v4 = nil
local v5 = nil

local function showPurchasePending() --[[ showPurchasePending | Line: 17 | Upvalues: v2 (ref), v5 (ref), v3 (ref), GIF2 (copy), v4 (ref), Lighting (copy), v1 (copy), Functions (copy) ]]
	if not v2 then
		v2 = true

		local v12 = script:FindFirstChild("Purchase Pending"):Clone()

		v5 = v12
		v3 = GIF2.Create(v12.Frame.GIF, { 100, 100 }, { 5, 6 }, 28, 0.65, true)

		local PurchasePendingBlur = Instance.new("BlurEffect")

		v4 = PurchasePendingBlur
		PurchasePendingBlur.Size = 0
		PurchasePendingBlur.Name = "PurchasePendingBlur"
		PurchasePendingBlur.Parent = Lighting
		v12.Frame.BackgroundTransparency = 1
		v12.Parent = v1
		Functions.Tween(PurchasePendingBlur, {
			Size = 20
		}, { 0.25, "Sine", "Out" })
		Functions.Tween(v12.Frame, {
			BackgroundTransparency = 0.5
		}, { 0.2, "Expo", "Out" })
		Functions.Tween(v12.Frame.GIF, {
			ImageTransparency = 0
		}, { 0.2, "Expo", "Out" })
	end
end

local function closePurchasePending() --[[ closePurchasePending | Line: 37 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), Functions (copy) ]]
	if not v2 then
		return
	end

	v2 = false

	local v1 = v3
	local v22 = v4
	local v32 = v5

	v3 = nil
	v5 = nil
	v4 = nil

	if v1 then
		v1()
	end

	if v32 then
		Functions.Tween(v32.Frame.GIF, {
			ImageTransparency = 1
		}, { 0.3, "Expo", "Out" })
		Functions.Tween(v32.Frame, {
			BackgroundTransparency = 1
		}, { 0.3, "Expo", "Out" }).Completed:Connect(function() --[[ Line: 54 | Upvalues: v32 (copy) ]]
			v32:Destroy()
		end)
	end

	if not v22 then
		return
	end

	Functions.Tween(v22, {
		Size = 0
	}, { 0.2, "Expo", "Out" }).Completed:Connect(function() --[[ Line: 59 | Upvalues: v22 (copy) ]]
		v22:Destroy()
	end)
end

Signal.Fired("Prompting Purchase"):Connect(showPurchasePending)
Network.Fired("Prompting Purchase"):Connect(showPurchasePending)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(closePurchasePending)
MarketplaceService.PromptProductPurchaseFinished:Connect(closePurchasePending)
MarketplaceService.PromptPurchaseFinished:Connect(closePurchasePending)
MarketplaceService.PromptPremiumPurchaseFinished:Connect(closePurchasePending)

return {}