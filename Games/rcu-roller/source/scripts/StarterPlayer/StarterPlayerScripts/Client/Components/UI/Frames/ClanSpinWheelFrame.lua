-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:16
-- Luau version 6, Types version 3
-- Time taken: 0.004931 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ClanSpinWheelFrame";
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
local Main = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ClanSpinWheelFrame"):WaitForChild("Main")
local Side_upvr = Main:WaitForChild("Canvas"):WaitForChild("Side")
local Spin_upvr = Main:WaitForChild("Spin")
local var16_upvw = false
function any_new_result1.resetRotations(arg1, arg2) -- Line 47
	--[[ Upvalues[1]:
		[1]: Spin_upvr (readonly)
	]]
	Spin_upvr.Rotation = 0.1
	for _, v in Spin_upvr:GetChildren() do
		v.Rotation = 0.1
	end
end
function any_new_result1.getSpinSpeed(arg1) -- Line 55
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	local var24
	for i_2 = #var12_upvw, 1, -1 do
		if var4_upvw:getData().stats.clanWheelSpins >= var12_upvw[i_2].amount then
			var24 = i_2
			return var24
		end
	end
	return var24
end
local TweenService_upvr = game:GetService("TweenService")
function any_new_result1.spin(arg1, arg2) -- Line 72
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var11_upvw (read and write)
		[4]: TweenService_upvr (readonly)
		[5]: Spin_upvr (readonly)
		[6]: var10_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var16_upvw (read and write)
	]]
	local var30 = 5 * var12_upvw[arg1:getSpinSpeed()].speed
	arg1:resetRotations()
	local var31 = (2160) + (var11_upvw[arg2].rotation - Random.new():NextNumber(-27, 27))
	local any_Create_result1 = TweenService_upvr:Create(Spin_upvr, TweenInfo.new(var30), {
		Rotation = var31;
	})
	any_Create_result1:Play()
	for _, v_2 in Spin_upvr:GetChildren() do
		TweenService_upvr:Create(v_2, TweenInfo.new(var30), {
			Rotation = -var31;
		}):Play()
	end
	local var39_upvw = 0
	any_Create_result1.Completed:Wait()
	Spin_upvr:GetPropertyChangedSignal("Rotation"):Connect(function() -- Line 93
		--[[ Upvalues[5]:
			[1]: Spin_upvr (copied, readonly)
			[2]: var10_upvw (copied, read and write)
			[3]: var11_upvw (copied, read and write)
			[4]: var39_upvw (read and write)
			[5]: var6_upvw (copied, read and write)
		]]
		local var40 = math.floor((Spin_upvr.Rotation % 360 + 30) / 60) % var10_upvw.getAmountInTable(var11_upvw) + 1
		if var40 ~= var39_upvw then
			var6_upvw:play("Tick")
			var39_upvw = var40
		end
	end):Disconnect()
	any_Create_result1:Destroy()
	var16_upvw = false
end
function any_new_result1.getSpinProgress(arg1) -- Line 111
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	local any_getSpinSpeed_result1 = arg1:getSpinSpeed()
	local var42 = var12_upvw[any_getSpinSpeed_result1]
	local var43 = var12_upvw[any_getSpinSpeed_result1 + 1]
	local var44
	if var43 then
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var44 = var42.amount
			return var44
		end
		if not var42 or not INLINED() then
			var44 = 0
		end
		return (var4_upvw.data.stats.clanWheelSpins - var44) / (var43.amount - var44)
	end
	return 1
end
function any_new_result1.setupFrames(arg1) -- Line 127
	--[[ Upvalues[3]:
		[1]: var11_upvw (read and write)
		[2]: Spin_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	for _, v_3 in var11_upvw do
		local item = v_3.item
		local var48 = Spin_upvr[v_3.rotation]
		var48.Icon.Image = item:getIcon()
		var48.Amount.Text = `{v_3.chance}%`
		var5_upvw:createInfoHoverOnGuiStateChange(var48.Icon, {
			item = item;
			unusable = true;
			ignoreExist = true;
		})
	end
end
function any_new_result1.update(arg1) -- Line 144
	--[[ Upvalues[5]:
		[1]: var5_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: Side_upvr (readonly)
		[4]: var10_upvw (read and write)
		[5]: var12_upvw (read and write)
	]]
	if not var5_upvw:isFrameOpen() then
	else
		if var5_upvw:getCurrentFrameOpen() ~= "ClanSpinWheelFrame" then return end
		local any_getData_result1 = var4_upvw:getData()
		local stats = any_getData_result1.stats
		Side_upvr.Spins.After.Text = `Used Spins: {var10_upvw.comma(stats.clanWheelSpins)}`
		local any_getSpinSpeed_result1_2 = arg1:getSpinSpeed()
		local spinSpeedPct = var10_upvw.floatingPoint((1 - var12_upvw[any_getSpinSpeed_result1_2].speed) * 100)
		Side_upvr.SpinSpeed.Text = `+{spinSpeedPct}% Spin Speed`
		local var53 = var12_upvw[any_getSpinSpeed_result1_2 + 1]
		if var53 then
			Side_upvr.Progress.Amount.Text = `{var10_upvw.comma(any_getData_result1.stats.clanWheelSpins)}/{var53.amount}`
		else
			Side_upvr.Progress.Amount.Text = "MAX"
		end
		local progressValue = math.min(1, arg1:getSpinProgress())
		Side_upvr.Progress.Bar.Size = UDim2.fromScale(progressValue, 1)
		local lastSpinTime = any_getData_result1.clanWheelSpin
		local var54 = workspace:GetServerTimeNow() - lastSpinTime
		local isOnCooldown = (21600 >= var54)
		Side_upvr.State.Spin.Visible = not isOnCooldown
		if var54 > 21600 then
			-- ready to spin, no wait label needed
		end
		Side_upvr.State.Wait.Visible = isOnCooldown
		if isOnCooldown then
			Side_upvr.State.Wait.Label.Text = var10_upvw.formatTime(21600 - var54)
		end
		Side_upvr.NextSpin.Visible = isOnCooldown
	end
end
function any_new_result1.buttons(arg1) -- Line 178
	--[[ Upvalues[8]:
		[1]: var9_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var16_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var6_upvw (read and write)
	]]
	var9_upvw.new(Side_upvr.State):buttonUp(function() -- Line 180
		--[[ Upvalues[7]:
			[1]: var4_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: var16_upvw (copied, read and write)
			[4]: var7_upvw (copied, read and write)
			[5]: var8_upvw (copied, read and write)
			[6]: arg1 (readonly)
			[7]: var6_upvw (copied, read and write)
		]]
		if workspace:GetServerTimeNow() - var4_upvw.data.clanWheelSpin < 21600 then
			var5_upvw:createMessagePopup({
				title = "Uh Oh!";
				message = "You cannot spin the wheel yet!";
				reOpen = "ClanSpinWheelFrame";
			})
		else
			if var16_upvw then return end
			var16_upvw = true
			var7_upvw:setCanOverrideDisplay(false)
			local any_clanWheelSpin_result1, any_clanWheelSpin_result2 = var8_upvw:clanWheelSpin()
			if any_clanWheelSpin_result1 == "success" then
				arg1:spin(any_clanWheelSpin_result2)
				var6_upvw:play("Spin")
				var7_upvw:setCanOverrideDisplay(true)
				return
			end
			var16_upvw = false
		end
	end)
end
function any_new_result1.onSet(arg1) -- Line 213
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"stats"}, function(arg1_2) -- Line 214
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.opened(arg1) -- Line 219
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 223
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	arg1:buttons()
	arg1:setupFrames()
	arg1:onSet()
	arg1:opened()
	var5_upvw:listenToOpen("ClanSpinWheelFrame"):Connect(function() -- Line 229
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	Knit_upvr.listenToUpdate:Connect(function() -- Line 233
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var64_upvw
local var65_upvw
function any_new_result1.Construct(arg1) -- Line 238
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
		[10]: var64_upvw (read and write)
		[11]: var65_upvw (read and write)
		[12]: var11_upvw (read and write)
		[13]: var12_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("ClanService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var64_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var65_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Wheel)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.SpinSpeed)
end
return any_new_result1