-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:32
-- Luau version 6, Types version 3
-- Time taken: 0.002274 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BoothPlayerFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var8_upvw
local var9_upvw
local var10_upvw
local Holder_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BoothPlayerFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local Inventory_upvr = Holder_upvr:WaitForChild("Inventory")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.createOfferFrame(arg1, arg2, arg3) -- Line 42
	--[[ Upvalues[7]:
		[1]: Assets_upvr (readonly)
		[2]: var9_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: Inventory_upvr (readonly)
		[6]: var8_upvw (read and write)
		[7]: var6_upvw (read and write)
	]]
	local clone = Assets_upvr.UI.BoothPlayerOffer:Clone()
	local any_createItemFromData_result1 = var9_upvw.itemUtils.createItemFromData(arg3.item)
	clone.Buy.Price.Label.Text = var10_upvw.suffixes(arg3.tokens)
	local var16
	if any_createItemFromData_result1:getClass() == "pet" then
		var16 = var4_upvw.uis.pet(any_createItemFromData_result1, {
			hideAmount = not any_createItemFromData_result1:getSerial();
			hideTier = true;
		})
	else
		var16 = var4_upvw.uis.item(any_createItemFromData_result1, {
			scribble = false;
			container = true;
			hideAmount = true;
			defaultIconSize = true;
		})
	end
	var4_upvw:createInfoHoverOnGuiStateChange(var16.Main.Click, {
		item = any_createItemFromData_result1;
		unusable = true;
	})
	var16.Parent = clone
	var16.Size = UDim2.fromScale(1, 0.615)
	var16.AnchorPoint = Vector2.new(0.5, 0)
	var16.Position = UDim2.fromScale(0.5, 0)
	clone.Name = arg2
	clone.Visible = true
	clone.Parent = Inventory_upvr
	var8_upvw.new(clone.Buy):buttonUp(function() -- Line 79
		--[[ Upvalues[4]:
			[1]: var6_upvw (copied, read and write)
			[2]: arg2 (readonly)
			[3]: arg3 (readonly)
			[4]: var4_upvw (copied, read and write)
		]]
		var6_upvw._selectedOfferId = arg2
		var6_upvw._selectedOfferData = arg3
		var4_upvw:openFrame("BoothBuyFrame")
	end)
end
function any_new_result1.update(arg1) -- Line 86
	--[[ Upvalues[4]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: Inventory_upvr (readonly)
		[4]: Holder_upvr (readonly)
	]]
	local any_getBoothData_result1, any_getBoothData_result2 = var5_upvw:getBoothData(var6_upvw._openedBoothId)
	if any_getBoothData_result1 ~= "success" then
	else
		for _, v in Inventory_upvr:GetChildren() do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end
		for i_2, v_2 in any_getBoothData_result2.offers do
			arg1:createOfferFrame(i_2, v_2)
		end
		Holder_upvr.Player.Label.Text = `{any_getBoothData_result2.ownerUsername}'s Booth`
	end
end
function any_new_result1.opened(arg1) -- Line 104
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 108
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:opened()
	var4_upvw:listenToOpen("BoothPlayerFrame"):Connect(function() -- Line 111
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var31_upvw
local var32_upvw
function any_new_result1.Construct(arg1) -- Line 116
	--[[ Upvalues[10]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var31_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var32_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var10_upvw (read and write)
	]]
	var5_upvw = Knit_upvr.GetService("TradingPlazaService")
	var6_upvw = Knit_upvr.GetController("TradingPlazaController")
	var31_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var32_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1