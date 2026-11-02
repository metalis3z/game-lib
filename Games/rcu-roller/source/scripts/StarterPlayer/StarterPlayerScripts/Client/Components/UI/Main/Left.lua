-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:40
-- Luau version 6, Types version 3
-- Time taken: 0.005023 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Left";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local Left = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Left")
local Row1_upvr = Left:WaitForChild("Row1")
local Row2_upvr = Left:WaitForChild("Row2")
function any_new_result1.areClansEnabled(arg1) -- Line 43
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	local any_getFFlag_result1 = var6_upvw:getFFlag("clansSystem")
	if any_getFFlag_result1 then
		if table.find(var4_upvw:getData().maps, 6) == nil then
			any_getFFlag_result1 = false
		else
			any_getFFlag_result1 = true
		end
	end
	return any_getFFlag_result1
end
function any_new_result1.update(arg1) -- Line 48
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: Row1_upvr (readonly)
		[4]: var7_upvw (read and write)
		[5]: var11_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: Row2_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getData_result1_2 = var4_upvw:getData()
	local var22 = var9_upvw[any_getData_result1_2.prestige + 1]
	if not var22 then
		var22 = var9_upvw[any_getData_result1_2.prestige]
	end
	if var22 then
		Row1_upvr.Prestige.Main.Icon.Image = var22.icon
	end
	local var23 = var22
	if var23 then
		var23 = false
		if var22.required <= (any_getData_result1_2.prestigeXp or 0) then
			if any_getData_result1_2.prestige == #var9_upvw then
				var23 = false
			else
				var23 = true
			end
		end
	end
	Row1_upvr.Prestige.Main.InfoIndicator.Visible = var23
	local var24 = false
	if 0 < var7_upvw:getNewItems("aura") then
		var24 = true
	elseif 0 < var7_upvw:getNewItems("booths") then
		var24 = true
	elseif 0 < var7_upvw:getNewItems("mount") then
		var24 = true
	end
	Row1_upvr.Profile.Main.InfoIndicator.Visible = var24
	-- Clans button visibility: only show if clans feature is enabled
	Row2_upvr.Clans.Visible = arg1:areClansEnabled()
	-- Tutorial stage visibility: hide Row1 and most Row2 buttons during tutorial
	local tutorialDone = any_getData_result1_2.tutorialStage > #var10_upvw
	Row1_upvr.Visible = tutorialDone
	-- SupporterPack InfoIndicator on Shop button: show if next tier reward is available
	local currentTier = any_getData_result1_2.supporterPackTier or 0
	Row1_upvr.Shop.Main.InfoIndicator.Visible = currentTier < #var11_upvw
end
function any_new_result1.buttons(arg1) -- Line 102
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: Row2_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: Row1_upvr (readonly)
	]]
	var8_upvw.new(Row2_upvr.Pets.Main):buttonUp(function() -- Line 104
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("InventoryFrame")
	end)
	var8_upvw.new(Row2_upvr.Rebirth.Main):buttonUp(function() -- Line 109
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("RebirthFrame")
	end)
	var8_upvw.new(Row1_upvr.Trade.Main):buttonUp(function() -- Line 114
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("TradeListFrame")
	end)
	var8_upvw.new(Row1_upvr.Prestige.Main):buttonUp(function() -- Line 119
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("PrestigeFrame")
	end)
	var8_upvw.new(Row1_upvr.Profile.Main):buttonUp(function() -- Line 124
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ProfileFrame")
	end)
	var8_upvw.new(Row2_upvr.Clans.Main):buttonUp(function() -- Line 129
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ClansFrame")
	end)
	var8_upvw.new(Row1_upvr.Shop.Main):buttonUp(function() -- Line 134
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ShopFrame")
	end)
	if Row1_upvr.Shop.Main:FindFirstChild("Sunburst") then
		var5_upvw.fx.sunburst(Row1_upvr.Shop.Main.Sunburst, 12)
	end
end
function any_new_result1.onSet(arg1) -- Line 140
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"prestige"}, function() -- Line 141
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"tutorialStage"}, function() -- Line 144
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"stats"}, function() -- Line 147
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"supporterPackTier"}, function() -- Line 150
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 155
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	arg1:buttons()
	task.spawn(function() -- Line 158
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: Knit_upvr (copied, readonly)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		Knit_upvr.listenToUpdate:Connect(function() -- Line 163
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
	end)
end
local var42_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var44_upvw
function any_new_result1.Construct(arg1) -- Line 169
	--[[ Upvalues[12]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var42_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var44_upvw (read and write)
		[10]: var9_upvw (read and write)
		[11]: var10_upvw (read and write)
		[12]: var11_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var42_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var44_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Prestige.Prestiges)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Tutorial)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.SupporterPack)
end
return any_new_result1