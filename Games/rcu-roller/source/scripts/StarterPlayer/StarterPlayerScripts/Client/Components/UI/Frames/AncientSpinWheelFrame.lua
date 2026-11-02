-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:52
-- Luau version 6, Types version 3
-- Time taken: 0.005167 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "AncientSpinWheelFrame";
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
local var14_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local MainUI = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local Main = MainUI:WaitForChild("Menus"):WaitForChild("AncientSpinWheelFrame"):WaitForChild("Main")
local Side_upvr = Main:WaitForChild("Canvas"):WaitForChild("Side")
local Spin_upvr = Main:WaitForChild("Spin")
local var20_upvw = false
function any_new_result1.resetRotations(arg1, arg2) -- Line 52
	--[[ Upvalues[1]:
		[1]: Spin_upvr (readonly)
	]]
	Spin_upvr.Rotation = 0.1
	for _, v in Spin_upvr:GetChildren() do
		v.Rotation = 0.1
	end
end
local TweenService_upvr = game:GetService("TweenService")
function any_new_result1.spin(arg1, arg2) -- Line 60
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var14_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: TweenService_upvr (readonly)
		[7]: Spin_upvr (readonly)
		[8]: var10_upvw (read and write)
		[9]: var6_upvw (read and write)
		[10]: var20_upvw (read and write)
	]]
	local var31 = 5 * var14_upvw[var12_upvw.spinSpeed(LocalPlayer_upvr, var4_upvw.data)].speed
	arg1:resetRotations()
	local var32 = (2160) + (var13_upvw[arg2].rotation - Random.new():NextNumber(-27, 27))
	local any_Create_result1 = TweenService_upvr:Create(Spin_upvr, TweenInfo.new(var31), {
		Rotation = var32;
	})
	any_Create_result1:Play()
	for _, v_2 in Spin_upvr:GetChildren() do
		TweenService_upvr:Create(v_2, TweenInfo.new(var31), {
			Rotation = -var32;
		}):Play()
	end
	local var40_upvw = 0
	any_Create_result1.Completed:Wait()
	Spin_upvr:GetPropertyChangedSignal("Rotation"):Connect(function() -- Line 81
		--[[ Upvalues[5]:
			[1]: Spin_upvr (copied, readonly)
			[2]: var10_upvw (copied, read and write)
			[3]: var13_upvw (copied, read and write)
			[4]: var40_upvw (read and write)
			[5]: var6_upvw (copied, read and write)
		]]
		local var41 = math.floor((Spin_upvr.Rotation % 360 + 30) / 60) % var10_upvw.getAmountInTable(var13_upvw) + 1
		if var41 ~= var40_upvw then
			var6_upvw:play("Tick")
			var40_upvw = var41
		end
	end):Disconnect()
	any_Create_result1:Destroy()
	task.delay(0.4, function() -- Line 96
		--[[ Upvalues[1]:
			[1]: var20_upvw (copied, read and write)
		]]
		var20_upvw = false
	end)
end
function any_new_result1.getSpinProgress(arg1) -- Line 101
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var14_upvw (read and write)
	]]
	local data = var4_upvw.data
	local any_spinSpeed_result1_2 = var12_upvw.spinSpeed(LocalPlayer_upvr, data)
	local var45 = var14_upvw[any_spinSpeed_result1_2]
	local var46 = var14_upvw[any_spinSpeed_result1_2 + 1]
	local var47
	if var46 then
		-- var47 = baseline spin count for current speed tier (0 if no current tier)
		if var45 then
			var47 = var45.amount
		else
			var47 = 0
		end
		return (data.stats.ancientWheelSpins - var47) / (var46.amount - var47)
	end
	return 1
end
local AncientTickets_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("AncientTickets")
function any_new_result1.toggleAncientTicketsTop(arg1, arg2) -- Line 117
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: AncientTickets_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: var10_upvw (read and write)
	]]
	AncientTickets_upvr.Visible = arg2
	if not arg2 then
	else
		local ticketItem = var11_upvw.itemUtils.getItemFromName(var4_upvw.data, "ancientTicket")
		local ticketAmount
		if not ticketItem then
			ticketAmount = 0
		else
			ticketAmount = var10_upvw.suffixes(ticketItem:getAmount())
		end
		AncientTickets_upvr.Amount.Text = ticketAmount
	end
end
function any_new_result1.setupFrames(arg1) -- Line 133 (header was missing due to decompiler bug)
	--[[ Upvalues[3]:
		[1]: var13_upvw (readonly)
		[2]: Spin_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	for _, v_3 in var13_upvw do
		local item = v_3.item
		local var54 = Spin_upvr[v_3.rotation]
		var54.Icon.Image = item:getIcon()
		var54.Amount.Text = `{v_3.chance}%`
		var5_upvw:createInfoHoverOnGuiStateChange(var54.Icon, {
			item = item;
			unusable = true;
			ignoreExist = true;
		})
	end
end
function any_new_result1.update(arg1) -- Line 147
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var12_upvw (read and write)
		[5]: LocalPlayer_upvr (readonly)
		[6]: var14_upvw (read and write)
	]]
	local data_2 = var4_upvw.data
	Side_upvr.Spins.After.Text = `Used Spins: {var10_upvw.comma(data_2.stats.ancientWheelSpins)}`
	local any_spinSpeed_result1 = var12_upvw.spinSpeed(LocalPlayer_upvr, data_2)
	Side_upvr.SpinSpeed.Text = `+{var10_upvw.floatingPoint((1 - var14_upvw[any_spinSpeed_result1].speed) * 100)}% Spin Speed`
	local var58 = var14_upvw[any_spinSpeed_result1 + 1]
	if var58 then
		Side_upvr.Progress.Amount.Text = `{var10_upvw.comma(data_2.stats.ancientWheelSpins)}/{var58.amount}`
	else
		Side_upvr.Progress.Amount.Text = "MAX"
	end
	local any_getSpinProgress_result1 = arg1:getSpinProgress()
	Side_upvr.Progress.Bar.Size = UDim2.fromScale(math.min(1, any_getSpinProgress_result1), 1)
	local Progress = Side_upvr.Progress
	local progressBarVisible
	if 0 >= any_getSpinProgress_result1 then
		progressBarVisible = false
	else
		progressBarVisible = true
	end
	Progress.Bar.Visible = progressBarVisible
end
function any_new_result1.buttons(arg1) -- Line 169
	--[[ Upvalues[9]:
		[1]: var9_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var11_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var20_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var6_upvw (read and write)
	]]
	var9_upvw.new(Side_upvr.Spin):buttonUp(function() -- Line 171
		--[[ Upvalues[8]:
			[1]: var4_upvw (copied, read and write)
			[2]: var11_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: var20_upvw (copied, read and write)
			[5]: var7_upvw (copied, read and write)
			[6]: var8_upvw (copied, read and write)
			[7]: arg1 (readonly)
			[8]: var6_upvw (copied, read and write)
		]]
		local any_getItemFromName_result1 = var11_upvw.itemUtils.getItemFromName(var4_upvw.data, "ancientTicket")
		if not any_getItemFromName_result1 or any_getItemFromName_result1:getAmount() <= 0 then
			var5_upvw:createMessagePopup({
				title = "Uh Oh!";
				message = "You need an Ancient Ticket to spin the wheel!";
				reOpen = "AncientSpinWheelFrame";
			})
		else
			if var20_upvw then return end
			var20_upvw = true
			var7_upvw:setCanOverrideDisplay(false)
			local any_ancientWheelSpin_result1, any_ancientWheelSpin_result2 = var8_upvw:ancientWheelSpin()
			if any_ancientWheelSpin_result1 == "success" then
				arg1:spin(any_ancientWheelSpin_result2)
				var7_upvw:setCanOverrideDisplay(true)
				var6_upvw:play("Spin")
				return
			end
			var20_upvw = false
		end
	end)
end
function any_new_result1.onSet(arg1) -- Line 204
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"stats"}, function(arg1_2) -- Line 205
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"inventory", "exclusive"}, function() -- Line 208
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		if var5_upvw:getCurrentFrameOpen() ~= "AncientSpinWheelFrame" then
		else
			arg1:toggleAncientTicketsTop(true)
		end
	end)
end
function any_new_result1.opened(arg1) -- Line 216
	arg1:update()
	arg1:toggleAncientTicketsTop(true)
end
function any_new_result1.closed(arg1) -- Line 221
	arg1:toggleAncientTicketsTop(false)
end
function any_new_result1.Start(arg1) -- Line 225
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:setupFrames()
	arg1:buttons()
	arg1:onSet()
	arg1:opened()
	var5_upvw:listenToOpen("AncientSpinWheelFrame"):Connect(function() -- Line 231
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClosing("AncientSpinWheelFrame"):Connect(function() -- Line 234
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 239
	--[[ Upvalues[13]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: var12_upvw (read and write)
		[12]: var13_upvw (read and write)
		[13]: var14_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.AncientWheel)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.SpinSpeed)
end
return any_new_result1