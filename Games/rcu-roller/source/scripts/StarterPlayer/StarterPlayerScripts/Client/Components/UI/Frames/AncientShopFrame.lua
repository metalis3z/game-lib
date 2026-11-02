-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:51
-- Luau version 6, Types version 3
-- Time taken: 0.003427 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "AncientShopFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local MainUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local Holder_upvr = MainUI:WaitForChild("Menus"):WaitForChild("AncientShopFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
function any_new_result1.setupFrames(arg1) -- Line 47
	--[[ Upvalues[9]:
		[1]: var11_upvw (read and write)
		[2]: Holder_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var5_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var6_upvw (read and write)
	]]
	for i_upvr, v_upvr in var11_upvw do
		var8_upvw.new(Holder_upvr[var9_upvw.toPascal(i_upvr)].Main.Buy):buttonUp(function() -- Line 52
			--[[ Upvalues[8]:
				[1]: var4_upvw (copied, read and write)
				[2]: var10_upvw (copied, read and write)
				[3]: v_upvr (readonly)
				[4]: var5_upvw (copied, read and write)
				[5]: var9_upvw (copied, read and write)
				[6]: var7_upvw (copied, read and write)
				[7]: i_upvr (readonly)
				[8]: var6_upvw (copied, read and write)
			]]
			local var18
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var18 = var10_upvw.itemUtils.getItemFromName(var4_upvw.data, "ancientTicket"):getAmount()
				return var18
			end
			if not var10_upvw.itemUtils.getItemFromName(var4_upvw.data, "ancientTicket") or not INLINED() then
				var18 = 0
			end
			if var18 < v_upvr then
				var5_upvw:createMessagePopup({
					title = "Uh Oh!";
					message = `You need {var9_upvw.suffixes(v_upvr - var18)} more Ancient Tickets to buy this!`;
					reOpen = "AncientShopFrame";
				})
			elseif var7_upvw:buyAncientShop(i_upvr) == "success" then
				var6_upvw:play("Ancient Shop Buy")
			end
		end)
	end
end
local AncientTickets_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("AncientTickets")
function any_new_result1.toggleAncientTicketsTop(arg1, arg2) -- Line 75
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: AncientTickets_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var9_upvw (read and write)
	]]
	AncientTickets_upvr.Visible = arg2
	if not arg2 then
	else
		local ticketItem = var10_upvw.itemUtils.getItemFromName(var4_upvw.data, "ancientTicket")
		local ticketAmount
		if not ticketItem then
			ticketAmount = 0
		else
			ticketAmount = var9_upvw.suffixes(ticketItem:getAmount())
		end
		AncientTickets_upvr.Amount.Text = ticketAmount
	end
end
function any_new_result1.isOwned(arg1, arg2) -- Line 88
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	if arg2 == "autoClickerGamepass" then
		return any_getData_result1.passes.autoClicker
	end
	if arg2 == "autoRebirthGamepass" then
		return any_getData_result1.passes.autoRebirth
	end
	if arg2 == "petsEquippedGamepass" then
		return any_getData_result1.passes.petEquip2
	end
	return any_getData_result1.ancientShop[arg2]
end
function any_new_result1.update(arg1) -- Line 102
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: var9_upvw (read and write)
	]]
	for i_2, v_2 in var11_upvw do
		local Main = Holder_upvr[var9_upvw.toPascal(i_2)].Main
		Main.AncientTickets.Visible = not arg1:isOwned(i_2)
		Main.Buy.Visible = not arg1:isOwned(i_2)
		Main.Bought.Visible = arg1:isOwned(i_2)
		Main.AncientTickets.Label.Text = var9_upvw.suffixes(v_2)
	end
end
function any_new_result1.onSet(arg1) -- Line 117
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"ancientShop"}, function(arg1_2) -- Line 118
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"inventory", "exclusive"}, function() -- Line 121
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		if var5_upvw:getCurrentFrameOpen() ~= "AncientShopFrame" then
		else
			arg1:toggleAncientTicketsTop(true)
		end
	end)
end
function any_new_result1.opened(arg1) -- Line 129
	arg1:update()
	arg1:toggleAncientTicketsTop(true)
end
function any_new_result1.closed(arg1) -- Line 134
	arg1:toggleAncientTicketsTop(false)
end
function any_new_result1.Start(arg1) -- Line 138
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:setupFrames()
	arg1:onSet()
	arg1:opened()
	var5_upvw:listenToOpen("AncientShopFrame"):Connect(function() -- Line 143
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClosing("AncientShopFrame"):Connect(function() -- Line 146
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
	var6_upvw:preloadSounds({"Ancient Shop Buy"})
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var35_upvw
function any_new_result1.Construct(arg1) -- Line 155
	--[[ Upvalues[11]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
		[10]: var35_upvw (read and write)
		[11]: var11_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var35_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.AncientShop)
end
return any_new_result1