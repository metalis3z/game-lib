-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:58
-- Luau version 6, Types version 3
-- Time taken: 0.006551 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ItemController";
	_newItems = {};
	_itemsDisplaying = {};
	_queue = {};
	_isProcessingQueue = false;
	_canIgnoreUIOpen = true;
	newItems = Knit_upvr.signal.new();
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var10_upvw
local var11_upvw
local Bars = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars")
local tbl_4_upvr = {
	inventory = {"pet", "potion", "fruit", "auraDice", "mapItem", "activeEvent", "exclusive", "box", "exclusiveEgg"};
	inventoryPets = {"pet"};
	inventoryExclusiveEggs = {"exclusiveEgg"};
	inventoryItems = {"pet", "potion", "fruit", "auraDice", "mapItem", "activeEvent", "exclusive", "box"};
	mount = {"mount"};
	aura = {"aura"};
	booth = {"booth"};
}
function any_CreateController_result1.getNewItems(arg1, arg2) -- Line 65
	--[[ Upvalues[1]:
		[1]: var11_upvw (read and write)
	]]
	local var21
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var21 = var11_upvw.getAmountInTable(arg1._newItems[arg2])
		return var21
	end
	if not arg1._newItems[arg2] or not INLINED() then
		var21 = 0
	end
	return var21
end
function any_CreateController_result1.setNewItems(arg1, arg2, arg3) -- Line 69
	--[[ Upvalues[2]:
		[1]: tbl_4_upvr (readonly)
		[2]: var11_upvw (read and write)
	]]
	for _, v in arg3 do
		if not arg1._newItems[v] then
			arg1._newItems[v] = {}
		end
		for _, v_2 in tbl_4_upvr[v] do
			for _, v_3 in arg2 do
				if v_3:getClass() == v_2 then
					arg1._newItems[v][var11_upvw.id()] = v_3
				end
			end
		end
	end
	arg1:update()
	arg1.newItems:Fire()
end
function any_CreateController_result1.resetNewItems(arg1, arg2) -- Line 92
	if not arg1._newItems[arg2] then
	else
		arg1._newItems[arg2] = {}
		arg1:update()
	end
end
function any_CreateController_result1.getCanOverrideDisplay(arg1) -- Line 101
	return arg1._canIgnoreUIOpen
end
function any_CreateController_result1.setCanOverrideDisplay(arg1, arg2) -- Line 104
	arg1._canIgnoreUIOpen = arg2
end
function any_CreateController_result1.addItemToDisplaying(arg1, arg2, arg3) -- Line 108
	local tbl = {}
	tbl.frame = arg3
	tbl.addedAt = tick()
	arg1._itemsDisplaying[arg2] = tbl
end
function any_CreateController_result1.removeItemFromDisplaying(arg1, arg2) -- Line 115
	arg1._itemsDisplaying[arg2] = nil
end
function any_CreateController_result1.removeOverflowItems(arg1) -- Line 119
	--[[ Upvalues[1]:
		[1]: var11_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if var11_upvw.getAmountInTable(arg1._itemsDisplaying) <= 3 then
	else
		local tbl_2 = {}
		for i_4, v_4 in arg1._itemsDisplaying do
			tbl_2[#tbl_2 + 1] = {
				displayId = i_4;
				frame = v_4.frame;
				addedAt = v_4.addedAt;
			}
		end
		table.sort(tbl_2, function(arg1_2, arg2) -- Line 133
			local var41
			if arg2.addedAt >= arg1_2.addedAt then
				var41 = false
			else
				var41 = true
			end
			return var41
		end)
		tbl_2[1].frame:Destroy()
		arg1:removeItemFromDisplaying(tbl_2[1].displayId)
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
local TweenService_upvr = game:GetService("TweenService")
local Items_upvr = Bars:WaitForChild("Items")
function any_CreateController_result1.displayNewItem(arg1, arg2, arg3, arg4) -- Line 145
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: var11_upvw (read and write)
		[4]: Assets_upvr (readonly)
		[5]: TweenService_upvr (readonly)
		[6]: Items_upvr (readonly)
		[7]: var5_upvw (read and write)
		[8]: tbl_4_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getItemFromId_result1 = var10_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg2)
	if not any_getItemFromId_result1 then
		var11_upvw.print(`displayNewItem(): invalid itemId: {arg2}`, warn)
	else
		local clone_upvr = Assets_upvr.UI.NewItem:Clone()
		local Main_upvr = clone_upvr.Main
		local var56
		local var57
		if any_getItemFromId_result1:getClass() == "pet" then
			var57 = var10_upvw.petUtils.getRarityData(var10_upvw.petUtils.getRarityId(any_getItemFromId_result1:getRarity()))
			var56 = any_getItemFromId_result1:getName()
		else
			var57 = var10_upvw.itemUtils.getRarityData(var10_upvw.itemUtils.getRarityId(any_getItemFromId_result1:getRarity()))
			var56 = any_getItemFromId_result1:getRealName()
		end
		Main_upvr.UIGradient.Color = var57.gradient
		Main_upvr.NewItem.Text = `{var56} (x{arg3})`
		Main_upvr.IconContainer.ImageLabel.Image = any_getItemFromId_result1:getIcon()
		if any_getItemFromId_result1:getClass() == "pet" then
			Main_upvr.IconContainer.ImageLabel.Size = UDim2.fromScale(1, 1)
		end
		Main_upvr.Position = UDim2.fromScale(10, 0.5)
		TweenService_upvr:Create(Main_upvr, TweenInfo.new(0.3), {
			Position = UDim2.fromScale(0.5, 0.5);
		}):Play()
		clone_upvr.LayoutOrder = -arg1:getNewItems("inventory")
		clone_upvr.Parent = Items_upvr
		local any_id_result1_upvr = var11_upvw.id()
		task.delay(2.5, function() -- Line 188
			--[[ Upvalues[5]:
				[1]: TweenService_upvr (copied, readonly)
				[2]: Main_upvr (readonly)
				[3]: clone_upvr (readonly)
				[4]: arg1 (readonly)
				[5]: any_id_result1_upvr (readonly)
			]]
			TweenService_upvr:Create(Main_upvr, TweenInfo.new(0.3), {
				Position = UDim2.fromScale(10, 0.5);
			}):Play()
			task.wait(0.3)
			clone_upvr:Destroy()
			arg1:removeItemFromDisplaying(any_id_result1_upvr)
		end)
		if not arg4.noSound then
			var5_upvw:play("New Item")
		end
		arg1:removeOverflowItems()
		arg1:addItemToDisplaying(any_id_result1_upvr, clone_upvr)
		for i_5, _ in tbl_4_upvr do
			arg1:setNewItems({any_getItemFromId_result1}, {i_5})
		end
	end
end
function any_CreateController_result1.waitUntilProcessable(arg1) -- Line 208
	--[[ Upvalues[2]:
		[1]: var6_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	if not _G.introFinished then
		repeat
			task.wait(0.1)
		until _G.introFinished
	end
	repeat
		task.wait(0.05)
	until (var6_upvw:isFrameOpen() or not var7_upvw:isHatching()) and arg1:getCanOverrideDisplay()
end
function any_CreateController_result1.processQueue(arg1) -- Line 220
	--[[ Upvalues[1]:
		[1]: var11_upvw (read and write)
	]]
	if arg1._isProcessingQueue then
	else
		arg1._isProcessingQueue = true
		repeat
			arg1:waitUntilProcessable()
			for i_6, v_6 in arg1._queue do
				local params = v_6.params
				if not params then
					params = {}
				end
				arg1._queue[i_6] = nil
				arg1:displayNewItem(v_6.itemId, v_6.amount, params)
				task.wait(0.15)
			end
		until var11_upvw.getAmountInTable(arg1._queue) == 0
		arg1:setCanOverrideDisplay(true)
		arg1._isProcessingQueue = false
	end
end
function any_CreateController_result1.addNewItemToQueue(arg1, arg2, arg3, arg4) -- Line 247
	--[[ Upvalues[1]:
		[1]: var11_upvw (read and write)
	]]
	local tbl_3 = {}
	tbl_3.itemId = arg2
	tbl_3.amount = arg3
	tbl_3.params = arg4
	arg1._queue[var11_upvw.id()] = tbl_3
	arg1:processQueue()
end
local InfoIndicator_upvr = Bars:WaitForChild("Left"):WaitForChild("Row2"):WaitForChild("Pets"):WaitForChild("Main"):WaitForChild("InfoIndicator")
function any_CreateController_result1.update(arg1) -- Line 259
	--[[ Upvalues[1]:
		[1]: InfoIndicator_upvr (readonly)
	]]
	local newItemCount = arg1:getNewItems("inventory")
	local visible
	if 0 >= newItemCount then
		visible = false
	else
		visible = true
	end
	InfoIndicator_upvr.Visible = visible
end
function any_CreateController_result1.KnitStart(arg1) -- Line 266
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	var8_upvw.newItem:Connect(function(...) -- Line 267
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:addNewItemToQueue(...)
	end)
end
local var73_upvw
local var74_upvw
local var75_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 272
	--[[ Upvalues[12]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var73_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: var74_upvw (read and write)
		[12]: var75_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("InventoryService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var73_upvw = Knit_upvr.GetController("AuraController")
	var7_upvw = Knit_upvr.GetController("HatchingController")
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var74_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Classes)
	var75_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
end
return any_CreateController_result1