-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.WindowService)
local v_u_3 = require(v1.ClientServices.FX.FX_Modules.Tween)
local v_u_4 = require(script.GIF)
local v_u_5 = false
local v_u_6 = nil
local v_u_7 = game.Lighting.PurchasePendingBlur
local v_u_8 = script.Parent
local v_u_9 = script.Sound

function PurchasePending()
	-- upvalues: (ref) v_u_5, (ref) v_u_6, (copy) v_u_4, (copy) v_u_8, (copy) v_u_3, (copy) v_u_7
	if not v_u_5 then
		v_u_5 = true
		v_u_6 = v_u_4.Create(v_u_8.Container.GIF, { 100, 100 }, { 5, 6 }, 28, 0.65, true)
		v_u_8.Container.BackgroundTransparency = 1
		v_u_8.Container.Visible = true
		v_u_9:Play()
		v_u_3(v_u_7, {
			["Size"] = 20
		}, { 0.25, "Sine", "Out" })
		v_u_3(v_u_8.Container, {
			["BackgroundTransparency"] = 0.5
		}, { 0.2, "Expo", "Out" })
		v_u_3(v_u_8.Container.GIF, {
			["ImageTransparency"] = 0
		}, { 0.2, "Expo", "Out" })
	end
end
function Close()
	-- upvalues: (ref) v_u_5, (ref) v_u_6, (copy) v_u_3, (copy) v_u_8, (copy) v_u_7
	if v_u_5 then
		v_u_5 = false
		if v_u_6 then
			v_u_6()
		end
		v_u_3(v_u_8.Container.GIF, {
			["ImageTransparency"] = 1
		}, { 0.3, "Expo", "Out" })
		v_u_3(v_u_8.Container, {
			["BackgroundTransparency"] = 1
		}, { 0.3, "Expo", "Out" })
		v_u_3(v_u_7, {
			["Size"] = 0
		}, { 0.2, "Expo", "Out" }).Completed:Connect(function()
			-- upvalues: (ref) v_u_8
			v_u_8.Container.Visible = false
		end)
		v_u_6 = nil
	end
end
local v_u_9 = v_u_2.ToggleFrame
local v_u_10 = v_u_2.ViewFrame
local function v11(_, _, _)
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_10
	v_u_2.ToggleFrame = v_u_9
	v_u_2.ViewFrame = v_u_10
	Close()
end
v_u_2:RegisterFrame(v_u_8.Container, "ProcessPending", function()
	PurchasePending()
end)
local MarketplaceService = game:GetService("MarketplaceService")

local function OnPurchaseStart(player, productId)
	PurchasePending()
end
local function OnPurchaseFinished(player, productId, wasPurchased)
	Close()
end

MarketplaceService.PromptProductPurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptPurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptBulkPurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptBundlePurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptPremiumPurchaseFinished:Connect(OnPurchaseFinished)
MarketplaceService.PromptSubscriptionPurchaseFinished:Connect(OnPurchaseFinished)
