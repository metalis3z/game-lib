-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:32
-- Luau version 6, Types version 3
-- Time taken: 0.018306 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1_upvr = Knit_upvr.CreateController({
	Name = "UIController";
	_frames = {};
	_initializedFrames = {};
	_isFrameOpen = false;
	_currentFrameOpen = nil;
	_previousPopupDirection = 1;
	_messagePopupReopen = nil;
	_tooltips = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local TweenService_upvr = game:GetService("TweenService")
local Lighting_upvr = game:GetService("Lighting")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GamepadService_upvr = game:GetService("GamepadService")
local GuiService_upvr = game:GetService("GuiService")
local var17_upvw
local var18_upvw
local var19_upvw
local var20_upvw
local var21_upvw
local var22_upvw
local var23_upvw
local var24_upvw
local var25_upvw
local var26_upvw
local var27_upvw
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local MainUI_upvr = PlayerGui:WaitForChild("MainUI")
local Bars_upvr = MainUI_upvr:WaitForChild("HUD"):WaitForChild("Bars")
local Transition_upvr = PlayerGui:WaitForChild("Overlays"):WaitForChild("Transition")
local Purchasing_upvr = MainUI_upvr:WaitForChild("Menus"):WaitForChild("Purchasing")
local CurrentCamera_upvr = workspace.CurrentCamera
local tbl_3_upvr = {}
local tbl_2_upvr = {"MessagePopupFrame", "TradeFrame"}
function any_CreateController_result1_upvr.getComponentName(arg1, arg2) -- Line 86
	return ({
		GoldenMachineFrame = "CraftMachineFrame";
		ToxicMachineFrame = "CraftMachineFrame";
	})[arg2] or arg2
end
function any_CreateController_result1_upvr.initializeFrame(arg1, arg2) -- Line 96
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	local any_getComponentName_result1 = arg1:getComponentName(arg2)
	local SOME = Knit_upvr.components.UI.Frames:FindFirstChild(any_getComponentName_result1)
	if not SOME then
	else
		if arg1._initializedFrames[any_getComponentName_result1] then return end
		arg1._initializedFrames[any_getComponentName_result1] = true
		require(SOME)
	end
end
function any_CreateController_result1_upvr.addFrames(arg1) -- Line 113
	--[[ Upvalues[2]:
		[1]: MainUI_upvr (readonly)
		[2]: var19_upvw (read and write)
	]]
	for _, v in MainUI_upvr.Menus:GetChildren() do
		if v.Name:find("Frame") and not v:GetAttribute("ignoreAddUi") then
			arg1._frames[v.Name] = {
				instance = v;
				size = v.Size;
				position = v.Position;
				opened = var19_upvw.new();
				closed = var19_upvw.new();
				closing = var19_upvw.new();
			}
		end
	end
end
function any_CreateController_result1_upvr.close(arg1) -- Line 133
	--[[ Upvalues[4]:
		[1]: var17_upvw (read and write)
		[2]: tbl_3_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var9_upvw (read and write)
	]]
	for i_2_upvr, v_2_upvr in pairs(arg1._frames) do
		if v_2_upvr.instance:FindFirstChild("Close") then
			var17_upvw.new(v_2_upvr.instance.Close):buttonUp(function() -- Line 140
				--[[ Upvalues[6]:
					[1]: tbl_3_upvr (copied, readonly)
					[2]: i_2_upvr (readonly)
					[3]: var10_upvw (copied, read and write)
					[4]: arg1 (readonly)
					[5]: var9_upvw (copied, read and write)
					[6]: v_2_upvr (readonly)
				]]
				for i_3, v_3 in tbl_3_upvr do
					v_3:deselect(nil, true)
				end
				if i_2_upvr == "UpdateLogFrame" then
					var10_upvw:setUpdateNumber(0)
				elseif i_2_upvr == "FarmingMachineFrame" then
					i_3 = arg1:getFrameInstance("FarmingMachineFrame")
					if i_3.Displays.Farm.Visible then
						v_3 = "FarmingMachineFrame"
						arg1:getFrameInstance(v_3).Displays.Farm.Visible = false
						v_3 = "FarmingMachineFrame"
						arg1:getFrameInstance(v_3).Displays.Main.Visible = true
						do
							return
						end
						-- KONSTANTWARNING: GOTO [171] #117
					end
				elseif i_2_upvr == "ClansFrame" then
					v_3 = arg1:getFrameInstance("ClansFrame")
					i_3 = v_3.Main
					if i_3.List.ChangeClanIcon.Visible then
						if var9_upvw:isCreating() then
							i_3 = arg1:getFrameInstance("ClansFrame")
							i_3.Main.List.CreateClan.Visible = true
						else
							i_3 = arg1:getFrameInstance("ClansFrame")
							i_3.Main.List.ClanSettings.Visible = true
						end
						i_3 = arg1:getFrameInstance("ClansFrame")
						i_3.Main.List.ChangeClanIcon.Visible = false
						return
					end
					v_3 = arg1:getFrameInstance("ClansFrame")
					i_3 = v_3.Main
					if i_3.List.ClanInvites.Visible then
						i_3 = arg1:getFrameInstance("ClansFrame")
						i_3.Main.List.ClanInvites.Visible = false
						i_3 = arg1:getFrameInstance("ClansFrame")
						i_3.Main.List.CheckYourClan.Visible = true
						return
					end
				end
				if v_2_upvr.instance:GetAttribute("openOnClose") then
					v_3 = v_2_upvr
					i_3 = v_3.instance
					arg1:closeAllFrames(i_3.Name)
					i_3 = v_2_upvr
					v_3 = "openOnClose"
					arg1:openFrame(i_3.instance:GetAttribute(v_3))
				else
					arg1:closeAllFrames()
				end
			end)
		end
	end
end
function any_CreateController_result1_upvr.closeFrame(arg1, arg2) -- Line 180
	--[[ Upvalues[3]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: Lighting_upvr (readonly)
	]]
	local var54_upvr = arg1._frames[arg2]
	task.spawn(function() -- Line 183
		--[[ Upvalues[4]:
			[1]: var54_upvr (readonly)
			[2]: TweenService_upvr (copied, readonly)
			[3]: CurrentCamera_upvr (copied, readonly)
			[4]: Lighting_upvr (copied, readonly)
		]]
		local position_2 = var54_upvr.position
		var54_upvr.instance:TweenPosition(UDim2.fromScale(position_2.X.Scale, position_2.Y.Scale + 0.25), "Out", "Quad", 0.1, true)
		var54_upvr.instance:TweenSize(UDim2.fromScale(0, 0), "Out", "Quad", 0.25, true)
		TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.3), {
			FieldOfView = 70;
		}):Play()
		TweenService_upvr:Create(Lighting_upvr.Blur, TweenInfo.new(0.25), {
			Size = 0;
		}):Play()
		var54_upvr.closing:Fire()
		task.delay(0.05, function() -- Line 195
			--[[ Upvalues[1]:
				[1]: var54_upvr (copied, readonly)
			]]
			var54_upvr.instance.Visible = false
			var54_upvr.closed:Fire()
		end)
	end)
end
function any_CreateController_result1_upvr.closeAllFrames(arg1, arg2) -- Line 202
	--[[ Upvalues[1]:
		[1]: GamepadService_upvr (readonly)
	]]
	task.spawn(function() -- Line 203
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: GamepadService_upvr (copied, readonly)
		]]
		for i_4, v_4 in pairs(arg1._frames) do
			if i_4 ~= arg2 and v_4.instance.Visible then
				arg1:closeFrame(i_4)
				arg1._isFrameOpen = false
				arg1._currentFrameOpen = nil
				GamepadService_upvr:DisableGamepadCursor()
			end
		end
	end)
	arg1:removeTooltips()
end
function any_CreateController_result1_upvr.openFrame(arg1, arg2, arg3) -- Line 224
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: tbl_2_upvr (readonly)
		[3]: TweenService_upvr (readonly)
		[4]: CurrentCamera_upvr (readonly)
		[5]: Lighting_upvr (readonly)
	]]
	if not arg3 and not var4_upvw:getData() then return end
	if _G.isTrading and not table.find(tbl_2_upvr, arg2) then return end
	task.spawn(function()
		arg1:closeAllFrames(arg2)
		local var66 = arg1._frames[arg2]
		if not var66 then return end
		local position = var66.position
		local size = var66.size
		var66.instance.Position = UDim2.fromScale(position.X.Scale, position.Y.Scale + 0.05)
		var66.instance.Size = UDim2.fromOffset(size.X.Offset, size.Y.Offset - 100)
		var66.instance.Visible = true
		var66.instance:TweenPosition(position, "Out", Enum.EasingStyle.Quad, 0.1, true)
		var66.instance:TweenSize(size, "Out", Enum.EasingStyle.Quad, 0.1, true)
		TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.3), {
			FieldOfView = 75;
		}):Play()
		TweenService_upvr:Create(Lighting_upvr.Blur, TweenInfo.new(0.25), {
			Size = 16;
		}):Play()
		arg1:initializeFrame(arg2)
		arg1._isFrameOpen = true
		arg1._currentFrameOpen = arg2
		arg1._timeSinceFrameOpened = tick()
		var66.opened:Fire()
	end)
end
function any_CreateController_result1_upvr.listenToOpen(arg1, arg2) -- Line 269
	return arg1._frames[arg2].opened
end
function any_CreateController_result1_upvr.listenToClose(arg1, arg2) -- Line 273
	return arg1._frames[arg2].closed
end
function any_CreateController_result1_upvr.listenToClosing(arg1, arg2) -- Line 277
	return arg1._frames[arg2].closing
end
function any_CreateController_result1_upvr.isFrameOpen(arg1) -- Line 281
	return arg1._isFrameOpen
end
function any_CreateController_result1_upvr.getCurrentFrameOpen(arg1) -- Line 285
	return arg1._currentFrameOpen
end
function any_CreateController_result1_upvr.getFrameInstance(arg1, arg2) -- Line 289
	return arg1._frames[arg2].instance
end
function any_CreateController_result1_upvr.getTimeSinceFrameOpened(arg1) -- Line 293
	return tick() - (arg1._timeSinceFrameOpened or 0)
end
local Notifications_upvr = Bars_upvr:WaitForChild("Notifications")
function any_CreateController_result1_upvr.createNotification(arg1, arg2, arg3, arg4, arg5) -- Line 297
	--[[ Upvalues[5]:
		[1]: var6_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: Notifications_upvr (readonly)
		[4]: var18_upvw (read and write)
		[5]: var5_upvw (read and write)
	]]
	repeat
		task.wait()
	until _G.introFinished and not var6_upvw:isHatching() and not var8_upvw:getIsRolling()
	for _, v_5 in Notifications_upvr.Holder:GetChildren() do
		if v_5:IsA("TextLabel") and v_5:GetAttribute("originalMessage") == arg3 and not v_5:GetAttribute("cantRepeatMessage") then
			v_5:SetAttribute("repeated", v_5:GetAttribute("repeated") + 1)
			v_5:SetAttribute("destroyTick", tick() + (arg4 or 3))
			v_5.Text = v_5:GetAttribute("originalMessage").." (x"..var18_upvw.comma(v_5:GetAttribute("repeated"))..')'
			if not arg5 then
				var5_upvw:play("Notification")
			end
			return
		end
	end
	local clone_upvr_2 = Notifications_upvr[arg2]:Clone()
	clone_upvr_2:SetAttribute("originalMessage", arg3)
	clone_upvr_2:SetAttribute("destroyTick", tick() + (arg4 or 3))
	clone_upvr_2:SetAttribute("repeated", 1)
	clone_upvr_2.Size = UDim2.new()
	clone_upvr_2.Text = arg3
	clone_upvr_2.Visible = true
	clone_upvr_2.Parent = Notifications_upvr.Holder
	if not arg5 then
		var5_upvw:play("Notification")
	end
	task.spawn(function() -- Line 345
		--[[ Upvalues[1]:
			[1]: clone_upvr_2 (readonly)
		]]
		clone_upvr_2:TweenSize(UDim2.new(1, 0, 0.7, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.15, true)
		repeat
			task.wait()
		until clone_upvr_2:GetAttribute("destroyTick") <= tick()
		clone_upvr_2:SetAttribute("cantRepeatMessage", true)
		if not clone_upvr_2 then
		else
			clone_upvr_2:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.1, true)
			task.wait(0.1)
			clone_upvr_2:Destroy()
		end
	end)
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
local Effects_upvr = MainUI_upvr:WaitForChild("Effects")
function any_CreateController_result1_upvr.createPopup(arg1, arg2, arg3, arg4) -- Line 356
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: Assets_upvr (readonly)
		[5]: var25_upvw (read and write)
		[6]: Effects_upvr (readonly)
		[7]: var18_upvw (read and write)
		[8]: TweenService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var81
	local _data = var4_upvw and var4_upvw:getData() or nil
	if _data and (not _data.settings or not _data.settings.hidePopups) then
		if var6_upvw:isHatching() then return end
		if var8_upvw:getIsRolling() then return end
		var81 = Assets_upvr.UI
		local clone_upvr = var81.Popup:Clone()
		local popupData = var25_upvw[arg2]
		if popupData then
			clone_upvr.Amount.UIGradient.Color = popupData.gradient
			clone_upvr.Amount.UIStroke.Color = popupData.stroke
			clone_upvr.Icon.Image = popupData.icon
		end
		var81 = true
		clone_upvr.Visible = var81
		var81 = Effects_upvr:WaitForChild("Popups")
		clone_upvr.Parent = var81
		var81 = clone_upvr.Amount
		var81.Text = `+{var18_upvw.suffixes(arg3, 1)}`
		if not arg4 then
			var81 = arg1._previousPopupDirection
			if var81 == 1 then
				var81 = UDim2.new(0.45, 0, 0.5)
				clone_upvr.Position = var81
			else
				var81 = UDim2.new(0.55, 0, 0.5)
				clone_upvr.Position = var81
			end
		else
			clone_upvr.Position = arg4
		end
		var81 = UDim2.new()
		clone_upvr.Size = var81
		var81 = Random.new():NextNumber(-0.15, -0.16)
		if arg1._previousPopupDirection == 1 then
			var81 = Random.new():NextNumber(0.15, 0.16)
		end
		local any_NextNumber_result1 = Random.new():NextNumber(5, 10)
		if arg1._previousPopupDirection == 1 then
			any_NextNumber_result1 = Random.new():NextNumber(-5, -10)
		end
		TweenService_upvr:Create(clone_upvr, TweenInfo.new(1), {
			Position = UDim2.new(clone_upvr.Position.X.Scale - var81, clone_upvr.Position.X.Offset, clone_upvr.Position.Y.Scale - Random.new():NextNumber(-0.15, 0.15), clone_upvr.Position.Y.Offset);
			Rotation = any_NextNumber_result1;
		}):Play()
		task.delay(0.5, function() -- Line 404
			--[[ Upvalues[2]:
				[1]: TweenService_upvr (copied, readonly)
				[2]: clone_upvr (readonly)
			]]
			TweenService_upvr:Create(clone_upvr.Icon, TweenInfo.new(1), {
				Transparency = 1;
				ImageTransparency = 1;
			}):Play()
			TweenService_upvr:Create(clone_upvr.Amount, TweenInfo.new(1), {
				TextTransparency = 0.2;
			}):Play()
			TweenService_upvr:Create(clone_upvr.Amount.UIStroke, TweenInfo.new(1), {
				Transparency = 1;
			}):Play()
		end)
		TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.2), {
			Size = UDim2.new(0.098, 0, 0.082, 0);
		}):Play()
		if arg1._previousPopupDirection == 1 then
			arg1._previousPopupDirection = -1
		else
			arg1._previousPopupDirection = 1
		end
		task.delay(1, function() -- Line 422
			--[[ Upvalues[2]:
				[1]: TweenService_upvr (copied, readonly)
				[2]: clone_upvr (readonly)
			]]
			TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.1), {
				Size = UDim2.new();
			}):Play()
			task.wait(0.1)
			clone_upvr:Destroy()
		end)
	end
end
function any_CreateController_result1_upvr.createMessagePopup(arg1, arg2) -- Line 431
	--[[ Upvalues[2]:
		[1]: any_CreateController_result1_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	local var102 = arg2
	if not var102 then
		var102 = {}
	end
	local var103 = var102
	if var103.fFlagDisabled then
		var103.title = "Sorry!"
		var103.message = "This is disabled right now, try again later!"
	end
	arg1:closeAllFrames("MessagePopupFrame")
	arg1:openFrame("MessagePopupFrame", nil, true)
	local instance = arg1._frames.MessagePopupFrame.instance
	local List = instance.List
	instance.Title.Text = var103.title or "Hey!"
	List.Message.Text = string.gsub(var103.message or "Message parameter is empty! 😳", "$t", List.Message:GetAttribute("CurrentThicknessText") or 4)
	List.Icon.Image = var103.icon or ""
	instance.Button.Positive.Content.Label.Text = var103.button or "Ok"
	local var106 = true
	if var103.negative == nil then
		if var103.buttonNegative == nil then
			var106 = false
		else
			var106 = true
		end
	end
	instance.Button.Negative.Visible = var106
	instance.Button.Negative.Label.Text = var103.buttonNegative or "No"
	local iconSize = var103.iconSize
	if not iconSize then
		iconSize = UDim2.fromScale()
	end
	List.Icon.Size = iconSize
	iconSize = var103.messageSize
	local var108 = iconSize
	if not var108 then
		var108 = UDim2.fromScale(1, 0.58)
	end
	List.Message.Size = var108
	List.Icon.Visible = var103.icon
	List.Items.Visible = var103.items
	for _, v_6 in List.Items.Holder:GetChildren() do
		if v_6:GetAttribute("isItemUI") then
			v_6:Destroy()
		end
	end
	if var103.items then
		for _, v_7 in var103.items do
			local var112
			if v_7:getClass() == "pet" then
				var112 = arg1.uis.pet(v_7)
			else
				var112 = arg1.uis.item(v_7, {
					defaultIconSize = true;
				})
			end
			var112.Size = UDim2.fromScale(0.168, 0.876)
			var112.Parent = List.Items.Holder
			any_CreateController_result1_upvr:createInfoHoverOnGuiStateChange(var112.Main.Click, {
				item = v_7;
				unusable = true;
				ignoreExist = true;
			})
		end
	end
	if not var103.noSound then
		var5_upvw:play(var103.sound or "Message Popup")
	end
	arg1._messagePopupReopen = var103.reOpen or nil
	arg1._messagePopupPositive = var103.positive or nil
	arg1._messagePopupNegative = var103.negative or nil
	arg1._messagePopupLoading = var103.loading or nil
	if var103.countdown then
		instance.Button.Positive.Visible = false
		instance.Button.Countdown.Visible = true
		for i_8 = var103.countdown * 10, 1, -1 do
			if not instance.Visible then break end
			instance.Button.Countdown.Label.Text = `({i_8 / 10}s)`
			task.wait(0.1)
		end
		instance.Button.Countdown.Visible = false
		instance.Button.Positive.Visible = true
	end
end
function any_CreateController_result1_upvr.createInfoHoverOnGuiStateChange(arg1, arg2, arg3) -- Line 518
	--[[ Upvalues[2]:
		[1]: var20_upvw (read and write)
		[2]: var21_upvw (read and write)
	]]
	local var115_upvw = arg3
	if not var115_upvw then
		var115_upvw = {}
	end
	local var117_upvw
	local var118_upvw
	local var119_upvw = true
	return arg2:GetPropertyChangedSignal("GuiState"):Connect(function() -- Line 526
		--[[ Upvalues[7]:
			[1]: arg2 (readonly)
			[2]: var117_upvw (read and write)
			[3]: var118_upvw (read and write)
			[4]: var119_upvw (read and write)
			[5]: var20_upvw (copied, read and write)
			[6]: var21_upvw (copied, read and write)
			[7]: var115_upvw (read and write)
		]]
		if arg2.GuiState == Enum.GuiState.Hover and var117_upvw == Enum.GuiState.Press and var118_upvw and var118_upvw:hasUI() then
			var118_upvw:remove()
			var119_upvw = false
		else
			if not var119_upvw and arg2.GuiState ~= Enum.GuiState.Idle then return end
			var119_upvw = true
			var117_upvw = arg2.GuiState
			if var20_upvw.Current == "MouseKeyboard" or var20_upvw.Current == "Gamepad" then
				if arg2.GuiState ~= Enum.GuiState.Hover then return end
			end
			if var20_upvw.Current == "Touch" and arg2.GuiState ~= Enum.GuiState.Press then return end
			var118_upvw = var21_upvw.new(arg2, var115_upvw)
		end
	end)
end
function any_CreateController_result1_upvr.createTooltipOnHover(arg1, arg2, arg3) -- Line 558
	--[[ Upvalues[1]:
		[1]: var26_upvw (read and write)
	]]
	local var120_upvw
	arg2.MouseEnter:Connect(function() -- Line 561
		--[[ Upvalues[4]:
			[1]: var120_upvw (read and write)
			[2]: var26_upvw (copied, read and write)
			[3]: arg3 (readonly)
			[4]: arg1 (readonly)
		]]
		var120_upvw = var26_upvw.new()
		var120_upvw:setText(arg3)
		arg1._tooltips[var120_upvw] = true
	end)
	arg2.MouseLeave:Connect(function() -- Line 568
		--[[ Upvalues[2]:
			[1]: var120_upvw (read and write)
			[2]: arg1 (readonly)
		]]
		if var120_upvw then
			var120_upvw:remove()
			arg1._tooltips[var120_upvw] = nil
		end
	end)
end
function any_CreateController_result1_upvr.removeTooltips(arg1) -- Line 576
	for i_9, _ in arg1._tooltips do
		i_9:remove()
	end
end
function any_CreateController_result1_upvr.hideHUD(arg1, arg2) -- Line 582
	local TweenInfo_new_result1 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	-- Bottom bar: hide = move down off screen, show = back to normal
	local bottomY = arg2 and 1.25 or 1
	TweenService_upvr:Create(Bars_upvr.Bottom, TweenInfo_new_result1, {
		Position = UDim2.fromScale(0.5, bottomY);
	}):Play()
	-- Left bar: hide = move left off screen, show = back to normal
	local leftX = arg2 and -0.25 or 0.01
	TweenService_upvr:Create(Bars_upvr.Left, TweenInfo_new_result1, {
		Position = UDim2.fromScale(leftX, 0.5);
	}):Play()
end
function any_CreateController_result1_upvr.animatePurchasing(arg1) -- Line 592
	--[[ Upvalues[2]:
		[1]: Purchasing_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	task.spawn(function() -- Line 593
		--[[ Upvalues[2]:
			[1]: Purchasing_upvr (copied, readonly)
			[2]: TweenService_upvr (copied, readonly)
		]]
		repeat
			Purchasing_upvr.Icon.Rotation = 0
			TweenService_upvr:Create(Purchasing_upvr.Icon, TweenInfo.new(1.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
				Rotation = 360;
			}):Play()
			task.wait(1.75)
		until not _G.isPurchasing
	end)
end
function any_CreateController_result1_upvr.setToIsPurchasing(arg1) -- Line 602
	--[[ Upvalues[3]:
		[1]: Purchasing_upvr (readonly)
		[2]: TweenService_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	_G.isPurchasing = true
	Purchasing_upvr.Icon.Size = UDim2.new()
	Purchasing_upvr.Icon:TweenSize(UDim2.fromScale(0.053, 0.079), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1.1, true)
	TweenService_upvr:Create(Purchasing_upvr.Icon, TweenInfo.new(0.25), {
		ImageTransparency = 0;
	}):Play()
	TweenService_upvr:Create(Purchasing_upvr, TweenInfo.new(0.5), {
		BackgroundTransparency = 0.4;
	}):Play()
	TweenService_upvr:Create(game:GetService("Lighting").Blur, TweenInfo.new(0.5), {
		Size = 16;
	}):Play()
	arg1:animatePurchasing()
	task.wait(0.4)
	var5_upvw:play("Purchase Prompt")
end
function any_CreateController_result1_upvr.cancelIsPurchasing(arg1) -- Line 619
	--[[ Upvalues[3]:
		[1]: TweenService_upvr (readonly)
		[2]: Purchasing_upvr (readonly)
		[3]: Lighting_upvr (readonly)
	]]
	TweenService_upvr:Create(Purchasing_upvr.Icon, TweenInfo.new(0.5), {
		ImageTransparency = 1;
	}):Play()
	TweenService_upvr:Create(Purchasing_upvr, TweenInfo.new(0.5), {
		BackgroundTransparency = 1;
	}):Play()
	TweenService_upvr:Create(Lighting_upvr.Blur, TweenInfo.new(0.5), {
		Size = 0;
	}):Play()
	task.wait(0.5)
	_G.isPurchasing = false
end
function any_CreateController_result1_upvr.purchaseDecision(arg1) -- Line 627
	var11_upvw.purchaseCanceled:Connect(function()
		arg1:cancelIsPurchasing()
	end)
	var11_upvw.purchaseConfirmed:Connect(function()
		arg1:cancelIsPurchasing()
	end)
	-- Client-side fallback: dismiss overlay when ANY product/gamepass prompt closes
	-- PromptProductPurchaseFinished fires on client only (server never gets cancel for products)
	game:GetService("MarketplaceService").PromptProductPurchaseFinished:Connect(function()
		if _G.isPurchasing then
			arg1:cancelIsPurchasing()
		end
	end)
	game:GetService("MarketplaceService").PromptGamePassPurchaseFinished:Connect(function()
		if _G.isPurchasing then
			arg1:cancelIsPurchasing()
		end
	end)
end
function any_CreateController_result1_upvr.transitionIn(arg1) -- Line 636
	--[[ Upvalues[1]:
		[1]: Transition_upvr (readonly)
	]]
	task.spawn(function() -- Line 637
		--[[ Upvalues[1]:
			[1]: Transition_upvr (copied, readonly)
		]]
		Transition_upvr.Visible = true
		Transition_upvr:TweenSize(UDim2.new(1, 0, 275, 0), "Out", "Quad", 0.5, true)
		task.wait(0.5)
		Transition_upvr.border1.Size = UDim2.new(0.5, 0, 1, 0)
		Transition_upvr.border2.Size = UDim2.new(0.5, 0, 1, 0)
	end)
end
function any_CreateController_result1_upvr.transitionOut(arg1) -- Line 649
	--[[ Upvalues[1]:
		[1]: Transition_upvr (readonly)
	]]
	task.spawn(function() -- Line 650
		--[[ Upvalues[1]:
			[1]: Transition_upvr (copied, readonly)
		]]
		Transition_upvr.border1.Size = UDim2.new(0.495, 0, 1, 0)
		Transition_upvr.border2.Size = UDim2.new(0.495, 0, 1, 0)
		Transition_upvr:TweenSize(UDim2.new(220, 0, 275, 0), "Out", "Quad", 0.5, true)
		task.wait(0.5)
		Transition_upvr.Visible = false
	end)
end
function any_CreateController_result1_upvr.transition(arg1) -- Line 662
	--[[ Upvalues[1]:
		[1]: Transition_upvr (readonly)
	]]
	task.spawn(function() -- Line 663
		--[[ Upvalues[1]:
			[1]: Transition_upvr (copied, readonly)
		]]
		local border1 = Transition_upvr.border1
		local border2 = Transition_upvr.border2
		Transition_upvr.Visible = true
		Transition_upvr:TweenSize(UDim2.new(1, 0, 275, 0), "Out", "Quad", 0.5, true)
		task.wait(0.5)
		border1.Size = UDim2.new(0.5, 0, 1, 0)
		border2.Size = UDim2.new(0.5, 0, 1, 0)
		task.wait(0.5)
		border1.Size = UDim2.new(0.495, 0, 1, 0)
		border2.Size = UDim2.new(0.495, 0, 1, 0)
		Transition_upvr:TweenSize(UDim2.new(220, 0, 275, 0), "Out", "Quad", 0.5, true)
		task.wait(0.5)
		Transition_upvr.Visible = false
	end)
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_CreateController_result1_upvr.input(arg1) -- Line 680
	--[[ Upvalues[5]:
		[1]: UserInputService_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: GamepadService_upvr (readonly)
		[5]: any_CreateController_result1_upvr (readonly)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 681
		--[[ Upvalues[4]:
			[1]: var6_upvw (copied, read and write)
			[2]: var7_upvw (copied, read and write)
			[3]: GamepadService_upvr (copied, readonly)
			[4]: any_CreateController_result1_upvr (copied, readonly)
		]]
		if arg2 then
		else
			if var6_upvw:isHatching() then return end
			if arg1_2.KeyCode == Enum.KeyCode.R and var7_upvw:getCurrentEgg() == "" then
				GamepadService_upvr:EnableGamepadCursor(nil)
				any_CreateController_result1_upvr:openFrame("RebirthFrame")
				return
			end
			if arg1_2.KeyCode == Enum.KeyCode.T and var7_upvw:getCurrentEgg() == "" and not _G.isTradingPlaza then
				GamepadService_upvr:EnableGamepadCursor(nil)
				any_CreateController_result1_upvr:openFrame("TeleportFrame")
				return
			end
			if arg1_2.KeyCode == Enum.KeyCode.F or arg1_2.KeyCode == Enum.KeyCode.ButtonY then
				GamepadService_upvr:EnableGamepadCursor(nil)
				any_CreateController_result1_upvr:openFrame("InventoryFrame")
				return
			end
		end
	end)
end
function any_CreateController_result1_upvr.resetButtonCallback(arg1) -- Line 710
	--[[ Upvalues[1]:
		[1]: var18_upvw (read and write)
	]]
	task.spawn(function() -- Line 711
		--[[ Upvalues[1]:
			[1]: var18_upvw (copied, read and write)
		]]
		while task.wait(0.5) do
			local pcall_result1, pcall_result2 = pcall(function() -- Line 714
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
			end)
			if pcall_result1 then return end
			var18_upvw.print(`resetButtonCallback: {pcall_result2}`, warn)
		end
	end)
end
function any_CreateController_result1_upvr.updateIconTransparencies(arg1) -- Line 727
	--[[ Upvalues[2]:
		[1]: GuiService_upvr (readonly)
		[2]: tbl_3_upvr (readonly)
	]]
	local PreferredTransparency = GuiService_upvr.PreferredTransparency
	for _, v_9 in tbl_3_upvr do
		if v_9.modifyTheme then
			v_9:modifyTheme("IconButton", "BackgroundTransparency", 0.3 * PreferredTransparency, "Deselected")
			v_9:modifyTheme("IconButton", "BackgroundTransparency", 0.3 * PreferredTransparency, "Selected")
		end
	end
end
function any_CreateController_result1_upvr.icons(arg1) -- Line 738
	--[[ Upvalues[3]:
		[1]: var27_upvw (read and write)
		[2]: tbl_3_upvr (readonly)
		[3]: GuiService_upvr (readonly)
	]]
	tbl_3_upvr[#tbl_3_upvr + 1] = var27_upvw.new():setName("Update"):setImage(8750406035):setRight():bindEvent("selected", function() -- Line 743
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openFrame("UpdateLogFrame", true)
	end):bindEvent("deselected", function() -- Line 746
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closeAllFrames()
	end)
	arg1:updateIconTransparencies()
	GuiService_upvr:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line 754
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateIconTransparencies()
	end)
end
local CollectionService_upvr = game:GetService("CollectionService")
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1_upvr.uiScales(arg1) -- Line 759
	--[[ Upvalues[3]:
		[1]: CollectionService_upvr (readonly)
		[2]: var20_upvw (read and write)
		[3]: RunService_upvr (readonly)
	]]
	for i_11, v_10 in CollectionService_upvr:GetTagged("UIScaleMobile") do
		local var165
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var165 = v_10:GetAttribute("scale")
			return var165
		end
		if var20_upvw.Current ~= "Touch" or not INLINED() then
			var165 = 1
		end
		v_10.Scale = var165
		var165 = i_11 % 3
		if var165 == 0 then
			var165 = RunService_upvr.RenderStepped.Wait
			var165(RunService_upvr.RenderStepped)
		end
	end
end
function any_CreateController_result1_upvr.KnitStart(arg1) -- Line 768
	--[[ Upvalues[6]:
		[1]: var23_upvw (read and write)
		[2]: var24_upvw (read and write)
		[3]: var22_upvw (read and write)
		[4]: CurrentCamera_upvr (readonly)
		[5]: var20_upvw (read and write)
		[6]: var10_upvw (read and write)
	]]
	arg1.uis = var23_upvw
	arg1.fx = var24_upvw
	arg1:addFrames()
	arg1:close()
	arg1:purchaseDecision()
	arg1:resetButtonCallback()
	arg1:input()
	var22_upvw:modifyUIStrokes()
	for _, v_11 in pairs(workspace:GetDescendants()) do
		var22_upvw:setOriginalThickness(v_11)
	end
	CurrentCamera_upvr:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line 790
		--[[ Upvalues[2]:
			[1]: var22_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var22_upvw:modifyUIStrokes()
		arg1:uiScales()
	end)
	workspace.DescendantAdded:Connect(function(arg1_3) -- Line 794
		--[[ Upvalues[1]:
			[1]: var22_upvw (copied, read and write)
		]]
		var22_upvw:changeUIObject(arg1_3)
	end)
	var20_upvw.Observe(function(arg1_4) -- Line 798
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:uiScales()
	end)
	var10_upvw.notification:Connect(function(...) -- Line 802
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:createNotification(...)
	end)
end
local var175_upvw
function any_CreateController_result1_upvr.KnitInit(arg1) -- Line 807
	--[[ Upvalues[23]:
		[1]: var10_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var9_upvw (read and write)
		[10]: var17_upvw (read and write)
		[11]: var175_upvw (read and write)
		[12]: var18_upvw (read and write)
		[13]: ReplicatedStorage_upvr (readonly)
		[14]: var19_upvw (read and write)
		[15]: var20_upvw (read and write)
		[16]: var21_upvw (read and write)
		[17]: var22_upvw (read and write)
		[18]: var23_upvw (read and write)
		[19]: var24_upvw (read and write)
		[20]: var25_upvw (read and write)
		[21]: var26_upvw (read and write)
		[22]: GuiService_upvr (readonly)
		[23]: var27_upvw (read and write)
	]]
	var10_upvw = Knit_upvr.GetService("PlayerService")
	var11_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("HatchingController")
	var7_upvw = Knit_upvr.GetController("EggController")
	var8_upvw = Knit_upvr.GetController("AuraController")
	var9_upvw = Knit_upvr.GetController("ClanController")
	var17_upvw = require(Knit_upvr.Modules.Button)
	var175_upvw = require(Knit_upvr.Shared.Util)
	var18_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var19_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
	var20_upvw = require(ReplicatedStorage_upvr.Packages.Input).PreferredInput
	var21_upvw = require(Knit_upvr.Modules.InfoHover)
	var22_upvw = require(script.UIStrokes)
	var23_upvw = require(script.UIs)
	var24_upvw = require(script.FX)
	var25_upvw = require(script.Popups)
	var26_upvw = require(Knit_upvr.Modules.Tooltip)
	if 36 < GuiService_upvr.TopbarInset.Height then
		var27_upvw = require(Knit_upvr.Modules.Icon)
	else
		var27_upvw = require(Knit_upvr.Modules.IconOld)
	end
end
return any_CreateController_result1_upvr