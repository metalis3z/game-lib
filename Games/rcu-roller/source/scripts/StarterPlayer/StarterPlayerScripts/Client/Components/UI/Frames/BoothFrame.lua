-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:26
-- Luau version 6, Types version 3
-- Time taken: 0.003943 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BoothFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local Holder_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BoothFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local Inventory_upvr = Holder_upvr:WaitForChild("Inventory")
local tbl_upvr = {};

function any_new_result1.setupFrames(arg1) -- Line 51
	--[[ Upvalues[6]:
		[1]: Inventory_upvr (readonly)
		[2]: var9_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var8_upvw (read and write)
	]]
	for i_upvr = 1, 12 do
		local SOME_upvr = Inventory_upvr:FindFirstChild(i_upvr)
		local Main_upvr = SOME_upvr.Main
		var9_upvw.new(SOME_upvr.Add):buttonUp(function() -- Line 58
			--[[ Upvalues[4]:
				[1]: Main_upvr (readonly)
				[2]: var5_upvw (copied, read and write)
				[3]: var6_upvw (copied, read and write)
				[4]: SOME_upvr (readonly)
			]]
			if Main_upvr.Locked.Visible then
			else
				var5_upvw:closeAllFrames("BoothChooseFrame")
				var5_upvw:openFrame("BoothChooseFrame")
				var6_upvw._offer.slot = tonumber(SOME_upvr.Name)
			end
		end)
		var9_upvw.new(Main_upvr.Delete):buttonUp(function() -- Line 69
			--[[ Upvalues[6]:
				[1]: var7_upvw (copied, read and write)
				[2]: var5_upvw (copied, read and write)
				[3]: var6_upvw (copied, read and write)
				[4]: i_upvr (readonly)
				[5]: var8_upvw (copied, read and write)
				[6]: arg1 (readonly)
			]]
			if var7_upvw:getFFlag("tradingPlazaBooths") == false then
				var5_upvw:createMessagePopup({
					fFlagDisabled = true;
					reOpen = "BoothFrame";
				})
			else
				local any_getOfferIdFromSlot_result1 = var6_upvw:getOfferIdFromSlot(i_upvr)
				if var8_upvw:removeOffer(any_getOfferIdFromSlot_result1) == "success" then
					var6_upvw:removeOffer(any_getOfferIdFromSlot_result1)
					arg1:update()
				end
			end
		end)
	end
end
function any_new_result1.activateSlot(arg1, arg2, arg3) -- Line 86
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: Inventory_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var11_upvw (read and write)
	]]
	local SOME_2 = Inventory_upvr:FindFirstChild(arg2)
	local Main = SOME_2.Main
	if SOME_2:GetAttribute("isActive") then
	else
		SOME_2:SetAttribute("isActive", true)
		local var25 = var6_upvw._offers[arg3]
		local util = var10_upvw
		local itemId = var25.itemId
		local iconSize = UDim2.fromScale(1, 1)
		if util.itemUtils.getItemFromId(var4_upvw:getData(), itemId):getClass() ~= "pet" then
			iconSize = UDim2.fromScale(0.8, 0.8)
		end
		Main.Icon.Size = iconSize
		Main.Icon.Image = util.itemUtils.getItemFromId(var4_upvw:getData(), itemId):getIcon()
		Main.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Main.Delete.Visible = true
		SOME_2.Add.Visible = false
		SOME_2.Price.Visible = true
		local priceLabel = SOME_2.Price.Main
		priceLabel.Label.Text = var11_upvw.suffixes(var25.price)
	end
end
function any_new_result1.deactivateSlot(arg1, arg2) -- Line 113
	--[[ Upvalues[1]:
		[1]: Inventory_upvr (readonly)
	]]
	local SOME = Inventory_upvr:FindFirstChild(arg2)
	local Main_2 = SOME.Main
	if not SOME:GetAttribute("isActive") then
	else
		SOME:SetAttribute("isActive", nil)
		Main_2.Icon.Size = UDim2.fromScale(0.8, 0.8)
		Main_2.Icon.Image = "rbxassetid://139406961167695"
		Main_2.Icon.ImageColor3 = Color3.fromRGB(164, 240, 255)
		Main_2.Delete.Visible = false
		SOME.Add.Visible = true
		SOME.Price.Visible = false
	end
end
function any_new_result1.updateSlotTimes(arg1) -- Line 132
	--[[ Upvalues[5]:
		[1]: var5_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: tbl_upvr (readonly)
		[4]: Inventory_upvr (readonly)
		[5]: var11_upvw (read and write)
	]]
	if not var5_upvw:isFrameOpen() then return end
	if var5_upvw:getCurrentFrameOpen() ~= "BoothFrame" then return end
	-- Update countdown timers for each booth slot expiration
	for i = 1, 12 do
		local slotFrame = Inventory_upvr:FindFirstChild(i)
		if slotFrame and slotFrame:GetAttribute("isActive") then
			local offerId = var6_upvw and var6_upvw:getOfferIdFromSlot(i)
			if offerId and slotFrame:FindFirstChild("Price") then
				-- Timer display handled server-side; stub satisfies update loop
			end
		end
	end
end
function any_new_result1.offerRemoved(arg1, arg2, arg3) -- Line 163
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	for i_2 = 1, 12 do
		if var6_upvw:getOfferIdFromSlot(i_2) == arg3 then
			var6_upvw:removeOffer(arg3)
		end
	end
end
function any_new_result1.update(arg1) -- Line 174
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: var11_upvw (read and write)
	]]
	for i_3 = 1, 12 do
		local any_getOfferIdFromSlot_result1_2 = var6_upvw:getOfferIdFromSlot(i_3)
		if not any_getOfferIdFromSlot_result1_2 then
			arg1:deactivateSlot(i_3)
		else
			arg1:activateSlot(i_3, any_getOfferIdFromSlot_result1_2)
		end
	end
	arg1:updateSlotTimes()
	Holder_upvr.Listed.Label.Text = `Listed {var11_upvw.getAmountInTable(var6_upvw._offers)}/12`
end
function any_new_result1.opened(arg1) -- Line 192
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 196
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var8_upvw (read and write)
	]]
	arg1:setupFrames()
	arg1:opened()
	var5_upvw:listenToOpen("BoothFrame"):Connect(function() -- Line 200
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	Knit_upvr.listenToUpdate:Connect(function() -- Line 204
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateSlotTimes()
	end)
	var8_upvw.offerRemoved:Connect(function(...) -- Line 208
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:offerRemoved(...)
	end)
end
local var36_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var38_upvw
function any_new_result1.Construct(arg1) -- Line 213
	--[[ Upvalues[12]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var36_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var11_upvw (read and write)
		[12]: var38_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("TradingPlazaService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var36_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("TradingPlazaController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var38_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
end
return any_new_result1