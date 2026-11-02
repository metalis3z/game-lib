-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:18
-- Luau version 6, Types version 3
-- Time taken: 0.009723 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "TradingPlazaController";
	_offer = {};
	_offers = {};
	_connections = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local CollectionService_upvr = game:GetService("CollectionService")
local var10_upvw
local var11_upvw
local var12_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local PlayerGui_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.getBoothFromId(arg1, arg2) -- Line 45
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	for _, v in CollectionService_upvr:GetTagged("Booth") do
		if v.Name == arg2 then
			return v
		end
	end
end
function any_CreateController_result1.boothChanged(arg1, arg2, arg3) -- Line 55
	--[[ Upvalues[3]:
		[1]: Assets_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: PlayerGui_upvr (readonly)
	]]
	local any_getBoothFromId_result1_3 = arg1:getBoothFromId(arg2)
	if not any_getBoothFromId_result1_3 then
	else
		any_getBoothFromId_result1_3:FindFirstChildWhichIsA("Model"):Destroy()
		local clone_3 = Assets_upvr.Booths[var11_upvw.toPascal(arg3.equippedBooth)]:Clone()
		clone_3.Parent = any_getBoothFromId_result1_3
		clone_3:PivotTo(any_getBoothFromId_result1_3.Primary.CFrame)
		clone_3.BoothInfo.SurfaceGui.Player.Text = arg3.ownerUsername
		PlayerGui_upvr.BoothOffers[arg2].Adornee = clone_3.BoothUI
	end
end
function any_CreateController_result1.boothClaimed(arg1, arg2, arg3) -- Line 75
	--[[ Upvalues[8]:
		[1]: Assets_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: CollectionService_upvr (readonly)
		[7]: PlayerGui_upvr (readonly)
		[8]: var6_upvw (read and write)
	]]
	local any_getBoothFromId_result1_4 = arg1:getBoothFromId(arg2)
	if arg3.equippedBooth then
		any_getBoothFromId_result1_4:FindFirstChildWhichIsA("Model"):Destroy()
		local clone_4 = Assets_upvr.Booths[var11_upvw.toPascal(arg3.equippedBooth)]:Clone()
		clone_4.Parent = any_getBoothFromId_result1_4
		clone_4:PivotTo(any_getBoothFromId_result1_4.Primary.CFrame)
	end
	local ProximityPrompt_2 = any_getBoothFromId_result1_4.Primary.ProximityPrompt
	if LocalPlayer_upvr.userId == arg3.ownerUserId then
		var5_upvw:play("Claim Booth", {
			volume = 0.3;
		})
		for _, v_2 in CollectionService_upvr:GetTagged("Booth") do
			if not var7_upvw:getAllBooths()[v_2.Name] then
				v_2.Primary.ProximityPrompt.Enabled = false
			end
		end
		ProximityPrompt_2.Enabled = true
		ProximityPrompt_2.ActionText = "Add Items!"
		ProximityPrompt_2.ObjectText = "Your Booth"
		arg1._hasBooth = true
	else
		ProximityPrompt_2.Enabled = true
		ProximityPrompt_2.ActionText = "View Items!"
		ProximityPrompt_2.ObjectText = arg3.ownerDisplayName.."'s Booth"
	end
	local class_Model_2 = any_getBoothFromId_result1_4:FindFirstChildWhichIsA("Model")
	local SurfaceGui = class_Model_2.BoothInfo.SurfaceGui
	SurfaceGui.Player.Text = arg3.ownerUsername
	SurfaceGui.Enabled = true
	local clone = Assets_upvr.UI.BoothSurfaceGui:Clone()
	clone.Adornee = class_Model_2.BoothUI
	clone.Name = arg2
	clone.Parent = PlayerGui_upvr:WaitForChild("BoothOffers")
	arg1._connections["_proximityTriggered"..arg2] = ProximityPrompt_2.Triggered:Connect(function() -- Line 125
		--[[ Upvalues[5]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: arg3 (readonly)
			[3]: var6_upvw (copied, read and write)
			[4]: arg1 (readonly)
			[5]: arg2 (readonly)
		]]
		if LocalPlayer_upvr.userId == arg3.ownerUserId then
			var6_upvw:openFrame("BoothFrame")
		else
			arg1._openedBoothId = arg2
			var6_upvw:openFrame("BoothPlayerFrame")
		end
	end)
	var11_upvw.print(`Uppdatera booth (boothId: {arg2}, ownerUserId: {arg3.ownerUserId})`)
end
function any_CreateController_result1.boothRemoved(arg1, arg2) -- Line 137
	--[[ Upvalues[3]:
		[1]: Assets_upvr (readonly)
		[2]: PlayerGui_upvr (readonly)
		[3]: var6_upvw (read and write)
	]]
	local any_getBoothFromId_result1_5 = arg1:getBoothFromId(arg2)
	any_getBoothFromId_result1_5:FindFirstChildWhichIsA("Model"):Destroy()
	local clone_6 = Assets_upvr.Booths.DefaultBooth:Clone()
	clone_6.Parent = any_getBoothFromId_result1_5
	clone_6:PivotTo(any_getBoothFromId_result1_5.Primary.CFrame)
	local ProximityPrompt = any_getBoothFromId_result1_5.Primary.ProximityPrompt
	if arg1._hasBooth then
		ProximityPrompt.Enabled = false
	else
		ProximityPrompt.Enabled = true
		ProximityPrompt.ActionText = "Claim!"
		ProximityPrompt.ObjectText = "Booth"
	end
	local SOME_3 = PlayerGui_upvr.BoothOffers:FindFirstChild(arg2)
	if SOME_3 then
		SOME_3:Destroy()
	end
	if arg1._connections["_proximityTriggered"..arg2] then
		arg1._connections["_proximityTriggered"..arg2]:Disconnect()
		arg1._connections["_proximityTriggered"..arg2] = nil
	end
	local currentFrame = var6_upvw:getCurrentFrameOpen()
	if arg1._openedBoothId == arg2 and (currentFrame == "BoothPlayerFrame" or currentFrame == "BoothBuyFrame") then
		var6_upvw:closeAllFrames()
	end
end
function any_CreateController_result1.offerCreated(arg1, arg2, arg3, arg4) -- Line 174
	--[[ Upvalues[6]:
		[1]: PlayerGui_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: var11_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var12_upvw (read and write)
	]]
	local any_createItemFromData_result1 = var10_upvw.itemUtils.createItemFromData(arg4.item)
	local clone_5 = Assets_upvr.UI.BoothOffer:Clone()
	clone_5.Buy.Price.Label.Text = var11_upvw.suffixes(arg4.tokens)
	local var43
	if any_createItemFromData_result1:getClass() == "pet" then
		var43 = var6_upvw.uis.pet(any_createItemFromData_result1, {
			hideAmount = not any_createItemFromData_result1:getSerial();
			hideTier = true;
		})
	else
		var43 = var6_upvw.uis.item(any_createItemFromData_result1, {
			scribble = false;
			container = true;
			hideAmount = true;
			defaultIconSize = true;
		})
	end
	var6_upvw:createInfoHoverOnGuiStateChange(var43.Main.Click, {
		item = any_createItemFromData_result1;
		unusable = true;
	})
	var43.Parent = clone_5
	var43.Size = UDim2.fromScale(0.9, 0.638)
	var43.AnchorPoint = Vector2.new(0.5, 0)
	var43.Position = UDim2.fromScale(0.5, 0.05)
	clone_5.Name = arg3
	clone_5.Visible = true
	clone_5.Parent = PlayerGui_upvr.BoothOffers:FindFirstChild(arg2).List.Holder
	var12_upvw.new(clone_5.Buy):buttonUp(function() -- Line 217
	end)
	clone_5.Buy.Click.MouseButton1Click:Connect(function() -- Line 221
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: var6_upvw (copied, read and write)
		]]
		arg1._openedBoothId = arg2
		var6_upvw:openFrame("BoothPlayerFrame")
	end)
end
local Debris_upvr = game:GetService("Debris")
function any_CreateController_result1.offerRemoved(arg1, arg2, arg3, arg4) -- Line 227
	--[[ Upvalues[5]:
		[1]: PlayerGui_upvr (readonly)
		[2]: Assets_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: Debris_upvr (readonly)
		[5]: var11_upvw (read and write)
	]]
	local SOME_2 = PlayerGui_upvr.BoothOffers:FindFirstChild(arg2).List.Holder:FindFirstChild(arg3)
	if SOME_2 then
		SOME_2:Destroy()
	end
	if arg1._connections["_buyOffer"..arg3] then
		arg1._connections["_buyOffer"..arg3]:Disconnect()
		arg1._connections["_buyOffer"..arg3] = nil
	end
	if arg4 then
		local any_getBoothFromId_result1 = arg1:getBoothFromId(arg2)
		if any_getBoothFromId_result1 then
			local class_Model = any_getBoothFromId_result1:FindFirstChildWhichIsA("Model")
			if class_Model then
				local clone_2_upvr = Assets_upvr.VFX.BoothSell:Clone()
				clone_2_upvr.Parent = class_Model.Primary
				var5_upvw:play("Offer Purchased", {
					parent = class_Model.Primary;
					volume = 6;
					rollOffMaxDistance = 75;
					rollOffMinDistance = 1;
					rollOffMode = Enum.RollOffMode.Inverse;
				})
				task.delay(2, function() -- Line 256
					--[[ Upvalues[1]:
						[1]: clone_2_upvr (readonly)
					]]
					clone_2_upvr.Enabled = false
				end)
				Debris_upvr:AddItem(clone_2_upvr, 5)
			end
		end
	end
	local logMsg = `Offer borttaget (offerId: {arg3})`
	var11_upvw.print(logMsg)
end
function any_CreateController_result1.teleportToBooth(arg1, arg2) -- Line 267
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local any_getBoothFromId_result1_2 = arg1:getBoothFromId(arg2)
	if not any_getBoothFromId_result1_2 then
	else
		local any_getHRP_result1 = var11_upvw.getHRP(LocalPlayer_upvr)
		if not any_getHRP_result1 then return end
		any_getHRP_result1:PivotTo((any_getBoothFromId_result1_2.Primary.CFrame - any_getBoothFromId_result1_2.Primary.CFrame.RightVector * 5) * CFrame.Angles(0, (-math.pi/2), 0))
	end
end
function any_CreateController_result1.getBoothsOnJoin(arg1) -- Line 281
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: CollectionService_upvr (readonly)
	]]
	local any_getAllBooths_result1 = var7_upvw:getAllBooths()
	for _, v_3 in CollectionService_upvr:GetTagged("Booth") do
		local Name = v_3.Name
		local ProximityPrompt_3 = v_3:WaitForChild("Primary"):WaitForChild("ProximityPrompt")
		ProximityPrompt_3.Enabled = true
		if any_getAllBooths_result1[Name] then
			arg1:boothClaimed(Name, any_getAllBooths_result1[Name])
			for i_4, v_4 in any_getAllBooths_result1[Name].offers do
				arg1:offerCreated(Name, i_4, v_4)
			end
		else
			ProximityPrompt_3.ActionText = "Claim!"
			ProximityPrompt_3.ObjectText = "Booth"
		end
	end
end
function any_CreateController_result1.addOffer(arg1, arg2, arg3, arg4, arg5) -- Line 304
	local tbl = {}
	tbl.itemId = arg3
	tbl.price = arg4
	tbl.slot = arg5
	arg1._offers[arg2] = tbl
end
function any_CreateController_result1.removeOffer(arg1, arg2, arg3, arg4, arg5) -- Line 312
	arg1._offers[arg2] = nil
end
function any_CreateController_result1.getOfferIdFromSlot(arg1, arg2) -- Line 316
	for i_5, v_5 in arg1._offers do
		if v_5.slot == arg2 then
			return i_5
		end
	end
end
function any_CreateController_result1.createScreenGui(arg1) -- Line 324
	--[[ Upvalues[1]:
		[1]: PlayerGui_upvr (readonly)
	]]
	local ScreenGui = Instance.new("ScreenGui", PlayerGui_upvr)
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Name = "BoothOffers"
end
local TradeTokens_upvr = PlayerGui_upvr:WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("TradeTokens")
function any_CreateController_result1.setTradeTokensTop(arg1) -- Line 330
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: TradeTokens_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var11_upvw (read and write)
	]]
	TradeTokens_upvr.Visible = true
	local tokenCount = 0
	local data = var4_upvw.data
	if data and data.inventory and data.inventory.exclusive then
		for _, itemData in data.inventory.exclusive do
			if type(itemData) == "table" and itemData.nm == "tradeTokens" then
				tokenCount = itemData.am or 0
				break
			end
		end
	end
	TradeTokens_upvr.Amount.Text = var11_upvw.suffixes(tokenCount)
	TradeTokens_upvr.Amount.Text = var85
end
function any_CreateController_result1.onSet(arg1) -- Line 339
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"inventory", "exclusive"}, function() -- Line 340
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setTradeTokensTop()
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 345
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var5_upvw (read and write)
	]]
	if not workspace:GetAttribute("isTradingPlaza") then
	else
		_G.isTradingPlaza = true
		arg1:createScreenGui()
		task.spawn(function() -- Line 354
			--[[ Upvalues[3]:
				[1]: var4_upvw (copied, read and write)
				[2]: arg1 (readonly)
				[3]: var7_upvw (copied, read and write)
			]]
			var4_upvw:waitForData()
			arg1:onSet()
			arg1:getBoothsOnJoin()
			arg1:setTradeTokensTop()
			var7_upvw.boothClaimed:Connect(function(...) -- Line 362
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:boothClaimed(...)
			end)
			var7_upvw.boothRemoved:Connect(function(...) -- Line 365
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:boothRemoved(...)
			end)
			var7_upvw.boothChanged:Connect(function(...) -- Line 368
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:boothChanged(...)
			end)
			var7_upvw.offerCreated:Connect(function(...) -- Line 372
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:offerCreated(...)
			end)
			var7_upvw.offerRemoved:Connect(function(...) -- Line 375
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:offerRemoved(...)
			end)
			var7_upvw.teleportToBooth:Connect(function(...) -- Line 379
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:teleportToBooth(...)
			end)
		end)
		var5_upvw:preloadSounds({"Claim Booth", "Offer Purchased"})
	end
end
function any_CreateController_result1.KnitInit(arg1) -- Line 390
	--[[ Upvalues[9]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var11_upvw (read and write)
		[9]: var12_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("TradingPlazaService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var12_upvw = require(script.Parent.Parent.Modules.Button)
end
return any_CreateController_result1