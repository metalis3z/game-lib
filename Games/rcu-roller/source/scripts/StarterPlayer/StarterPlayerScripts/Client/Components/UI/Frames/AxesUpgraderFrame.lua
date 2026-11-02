-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:33
-- Luau version 6, Types version 3
-- Time taken: 0.005039 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "AxesUpgraderFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local Main_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("AxesUpgraderFrame"):WaitForChild("Main")
local Right_upvr = Main_upvr:WaitForChild("Right")
function any_new_result1.buttons(arg1) -- Line 45
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: var6_upvw (read and write)
	]]
	var8_upvw.new(Main_upvr.Price.Button):buttonUp(function() -- Line 47
		--[[ Upvalues[3]:
			[1]: var7_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var6_upvw (copied, read and write)
		]]
		if var7_upvw:upgradeAxe() == "success" then
			arg1:update()
			var6_upvw:play("Upgrade")
		end
	end)
end
function any_new_result1.getTotalAxes(arg1) -- Line 56
	--[[ Upvalues[1]:
		[1]: var11_upvw (read and write)
	]]
	local var21 = 0
	for i, _ in var11_upvw do
		if i:lower():find("axe") then
			var21 += 1
		end
	end
	return var21
end
function any_new_result1.getAxeFromIndex(arg1, arg2) -- Line 70
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	for i_2, v_2 in var11_upvw do
		if i_2:lower():find("axe") and v_2.index == arg2 then
			return var12_upvw.exclusive(i_2)
		end
	end
end
function any_new_result1.getCurrentAxeIndex(arg1) -- Line 84
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
	]]
	for _, v_3 in var4_upvw:getData().inventory.exclusive do
		local any_createItemFromData_result1 = var9_upvw.itemUtils.createItemFromData(v_3)
		if any_createItemFromData_result1:getName():lower():find("axe") then
			return any_createItemFromData_result1:directory()[any_createItemFromData_result1:getName()].index
		end
	end
end
function any_new_result1.setAxeData(arg1, arg2, arg3) -- Line 99
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: Right_upvr (readonly)
		[4]: var11_upvw (read and write)
		[5]: var10_upvw (read and write)
		[6]: var13_upvw (read and write)
		[7]: var5_upvw (read and write)
		[8]: var9_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getAxeFromIndex_result1 = arg1:getAxeFromIndex(arg2)
	local var44 = "Coming soon..."
	local var45 = ""
	if any_getAxeFromIndex_result1 then
		var44 = any_getAxeFromIndex_result1:getRealName()
		var45 = any_getAxeFromIndex_result1:getIcon()
	end
	arg3.Damage.Visible = any_getAxeFromIndex_result1
	Main_upvr.Price.Button.Visible = Right_upvr and any_getAxeFromIndex_result1
	arg3.AxeIcon.Image = var45
	arg3.AxeName.Text = var44
	if not any_getAxeFromIndex_result1 then
	else
		local var46 = var11_upvw
		local multiplier = var46[any_getAxeFromIndex_result1:getName()].multiplier
		if 0 >= multiplier then
			var46 = false
		else
			var46 = true
		end
		arg3.Damage.Visible = var46
		arg3.Damage.Text = `Deals {var10_upvw.comma(multiplier)} HP!`
		if arg3 == Right_upvr then
			local children = Main_upvr.Price:GetChildren()
			for _, v_4 in children do
				if v_4:GetAttribute("isItemUI") then
					v_4:Destroy()
				end
			end
			children = true
			for _, v_5 in var13_upvw[any_getAxeFromIndex_result1:getName()].required do
				local any_item_result1 = var5_upvw.uis.item(v_5)
				any_item_result1.Size = UDim2.fromScale(0.1, 0.8)
				any_item_result1.Parent = Main_upvr.Price
				local var54
				local function INLINED() -- Internal function, doesn't exist in bytecode
					var54 = var9_upvw.itemUtils.getItemFromName(var4_upvw:getData(), v_5:getName()):getAmount()
					return var54
				end
				if not var9_upvw.itemUtils.getItemFromName(var4_upvw:getData(), v_5:getName()) or not INLINED() then
					var54 = 0
				end
				local Main = any_item_result1.Main
				Main.Amount.Text = `{var54}/{v_5:getAmount()}`
				if v_5:getAmount() > var54 or not Color3.fromRGB(39, 255, 28) then
				end
				Main.Amount.TextColor3 = Color3.fromRGB(255, 47, 47)
				if children and var54 < v_5:getAmount() then
					children = false
				end
				var5_upvw:createInfoHoverOnGuiStateChange(Main, {
					item = v_5;
					unusable = true;
				})
			end
			Main_upvr.Price.Button.Locked.Visible = not children
		end
	end
end
local Left_upvr = Main_upvr:WaitForChild("Left")
function any_new_result1.update(arg1) -- Line 160
	--[[ Upvalues[3]:
		[1]: Left_upvr (readonly)
		[2]: Right_upvr (readonly)
		[3]: Main_upvr (readonly)
	]]
	local any_getCurrentAxeIndex_result1 = arg1:getCurrentAxeIndex()
	if not any_getCurrentAxeIndex_result1 then
	else
		arg1:setAxeData(any_getCurrentAxeIndex_result1, Left_upvr)
		arg1:setAxeData(any_getCurrentAxeIndex_result1 + 1, Right_upvr)
		Main_upvr.AxesCounter.Text = `Axes ({any_getCurrentAxeIndex_result1}/{arg1:getTotalAxes()})`
	end
end
function any_new_result1.valuesChanged(arg1) -- Line 172
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"inventory.exclusive"}, function(arg1_2) -- Line 173
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.opened(arg1) -- Line 178
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 182
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:valuesChanged()
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("AxesUpgraderFrame"):Connect(function() -- Line 187
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var63_upvw
function any_new_result1.Construct(arg1) -- Line 192
	--[[ Upvalues[13]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
		[10]: var63_upvw (read and write)
		[11]: var11_upvw (read and write)
		[12]: var12_upvw (read and write)
		[13]: var13_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("AxeService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var63_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Exclusive)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Axes)
end
return any_new_result1