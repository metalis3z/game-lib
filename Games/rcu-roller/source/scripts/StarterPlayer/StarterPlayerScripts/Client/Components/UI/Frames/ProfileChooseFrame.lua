-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:54
-- Luau version 6, Types version 3
-- Time taken: 0.004775 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ProfileChooseFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local ProfileChooseFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ProfileChooseFrame")
local Inventory_upvr = ProfileChooseFrame_upvr:WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder"):WaitForChild("Inventory")
local TextBox_upvr = ProfileChooseFrame_upvr:WaitForChild("SearchBar"):WaitForChild("TextBox")
function any_new_result1.getClass(arg1) -- Line 47
	return arg1.Instance:GetAttribute("class")
end
function any_new_result1.getEquippedId(arg1, arg2) -- Line 51
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
	]]
	for _, v in {"mount", "aura", "booth"} do
		if arg1:getClass() == v then
			return var4_upvw:getData()[`equipped{var10_upvw.toPascal(arg2:getClass())}`]
		end
	end
end
function any_new_result1.itemUIClicked(arg1, arg2) -- Line 65
	--[[ Upvalues[3]:
		[1]: var7_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	if var7_upvw:profileEquip(arg2) == "success" then
		var5_upvw:openFrame("ProfileFrame")
		var6_upvw:play("Profile Choose Equip")
	end
end
function any_new_result1.createItemUI(arg1, arg2) -- Line 73
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: Inventory_upvr (readonly)
		[5]: var8_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local any_getItemFromId_result1 = var9_upvw.itemUtils.getItemFromId(any_getData_result1, arg2)
	if arg1:getEquippedId(any_getItemFromId_result1) ~= arg2 then
		any_getData_result1 = false
	else
		any_getData_result1 = true
	end
	local tbl_2 = {}
	tbl_2.name = arg2
	tbl_2.searchParams = true
	tbl_2.ignoreAnimateIconHover = true
	tbl_2.hideAmount = any_getData_result1
	tbl_2.showCircle = any_getData_result1
	local any_item_result1 = var5_upvw.uis.item(any_getItemFromId_result1, tbl_2)
	any_item_result1.Parent = Inventory_upvr
	var8_upvw.new(any_item_result1.Main.IconContainer, any_item_result1.Main.Click):buttonUp(function() -- Line 89
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		arg1:itemUIClicked(arg2)
	end)
	local tbl = {}
	tbl.itemId = arg2
	tbl.unusable = true
	var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, tbl)
end
local UIGridLayout_upvr = Inventory_upvr:WaitForChild("UIGridLayout")
function any_new_result1.setupFrames(arg1) -- Line 99
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: UIGridLayout_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- Fixed: inverted if (var35 starts nil so else branch never ran); removed dead inverted guards
	local inventory = var4_upvw:getData().inventory[arg1:getClass()]
	for i_5, _ in inventory do
		arg1:createItemUI(i_5)
	end
	local isBooth = (arg1:getClass() == "booth")
	if isBooth then
		UIGridLayout_upvr.CellSize = UDim2.new(0, 116, 0, 116)
		UIGridLayout_upvr.CellPadding = UDim2.new(0.029, 0, 0, 36)
	else
		UIGridLayout_upvr.CellSize = UDim2.new(0, 96, 0, 96)
		UIGridLayout_upvr.CellPadding = UDim2.new(0.025, 0, 0, 26)
	end
end
function any_new_result1.removeFrames(arg1) -- Line 117
	--[[ Upvalues[1]:
		[1]: Inventory_upvr (readonly)
	]]
	for _, v_2 in Inventory_upvr:GetChildren() do
		if v_2:GetAttribute("isItemUI") then
			v_2:Destroy()
		end
	end
end
function any_new_result1.update(arg1, arg2) -- Line 125
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: ProfileChooseFrame_upvr (readonly)
	]]
	local var41 = var11_upvw[arg2]
	ProfileChooseFrame_upvr.TagIcon.Image = var41.icon
	ProfileChooseFrame_upvr.TagIcon.Shadow.Image = var41.icon
	ProfileChooseFrame_upvr.TagLabel.Text = var41.name
end
function any_new_result1.setCurrentSearch(arg1, arg2) -- Line 133
	--[[ Upvalues[1]:
		[1]: TextBox_upvr (readonly)
	]]
	TextBox_upvr.Text = arg2
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1) -- Line 138
	--[[ Upvalues[3]:
		[1]: TextBox_upvr (readonly)
		[2]: Inventory_upvr (readonly)
		[3]: HttpService_upvr (readonly)
	]]
	local Text = TextBox_upvr.Text
	for _, v_3 in Inventory_upvr:GetDescendants() do
		local searchParams = v_3:GetAttribute("searchParams")
		if searchParams then
			-- Fixed: var55 was always nil so the check block never ran
			local var55 = false
			for _, v_4 in HttpService_upvr:JSONDecode(searchParams) do
				if string.match(string.lower(v_4), string.lower(Text)) then
					var55 = true
				end
			end
			if var55 or Text == nil or Text == "" then
				v_3.Visible = true
			else
				v_3.Visible = false
			end
		end
	end
end
function any_new_result1.search(arg1) -- Line 163
	--[[ Upvalues[2]:
		[1]: TextBox_upvr (readonly)
		[2]: Inventory_upvr (readonly)
	]]
	TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 164
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: Inventory_upvr (copied, readonly)
		]]
		arg1:showFramesOnSearch(Inventory_upvr)
	end)
end
function any_new_result1.opened(arg1) -- Line 169
	arg1:setupFrames()
	arg1:update(arg1:getClass())
	arg1:setCurrentSearch("")
end
function any_new_result1.closed(arg1) -- Line 175
	arg1:removeFrames()
end
function any_new_result1.Start(arg1) -- Line 179
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:search()
	arg1:opened()
	var5_upvw:listenToOpen("ProfileChooseFrame"):Connect(function() -- Line 183
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("ProfileChooseFrame"):Connect(function() -- Line 186
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
	var6_upvw:preloadSounds({"Profile Choose Equip"})
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var61_upvw
function any_new_result1.Construct(arg1) -- Line 195
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
		[10]: var61_upvw (read and write)
		[11]: var11_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("PlayerService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var61_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
	var11_upvw = require(script.Categories)
end
return any_new_result1