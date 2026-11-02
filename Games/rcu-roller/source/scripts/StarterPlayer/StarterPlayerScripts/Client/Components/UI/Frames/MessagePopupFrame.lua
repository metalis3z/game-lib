-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:36
-- Luau version 6, Types version 3
-- Time taken: 0.002272 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "MessagePopupFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local MessagePopupFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("MessagePopupFrame")
local Dark_upvr = MessagePopupFrame_upvr:WaitForChild("Dark")
function any_new_result1.createSpinner(arg1) -- Line 37
	--[[ Upvalues[3]:
		[1]: var6_upvw (read and write)
		[2]: MessagePopupFrame_upvr (readonly)
		[3]: Dark_upvr (readonly)
	]]
	local any_new_result1_2 = var6_upvw.new(MessagePopupFrame_upvr)
	any_new_result1_2:run()
	Dark_upvr.Visible = true
	arg1._spinner = any_new_result1_2
end
function any_new_result1.buttonClicked(arg1, arg2) -- Line 46
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if arg2 == "positive" then
		if var4_upvw._messagePopupLoading then
			arg1:createSpinner()
			var4_upvw._messagePopupLoading = nil
		end
		if var4_upvw._messagePopupPositive then
			var4_upvw._messagePopupPositive()
			var4_upvw._messagePopupPositive = nil
			do
				return
			end
		end
	elseif arg2 == "negative" and var4_upvw._messagePopupNegative then
		var4_upvw._messagePopupNegative()
		var4_upvw._messagePopupNegative = nil
		return
	end
	if var4_upvw._messagePopupReopen then
		var4_upvw:closeAllFrames(var4_upvw._messagePopupReopen)
		var4_upvw:openFrame(var4_upvw._messagePopupReopen, true)
		var4_upvw._messagePopupReopen = nil
	else
		var4_upvw:closeAllFrames()
	end
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_new_result1.input(arg1) -- Line 75
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	UserInputService_upvr.InputEnded:Connect(function(arg1_2, arg2) -- Line 76
		--[[ Upvalues[3]:
			[1]: UserInputService_upvr (copied, readonly)
			[2]: var4_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		if UserInputService_upvr:GetFocusedTextBox() then
		else
			if arg1_2.KeyCode ~= Enum.KeyCode.ButtonA then return end
			if var4_upvw:getCurrentFrameOpen() ~= "MessagePopupFrame" then return end
			arg1:buttonClicked("positive")
		end
	end)
end
function any_new_result1.buttons(arg1) -- Line 93
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: MessagePopupFrame_upvr (readonly)
	]]
	var5_upvw.new(MessagePopupFrame_upvr.Button.Positive):buttonUp(function() -- Line 95
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:buttonClicked("positive")
	end)
	var5_upvw.new(MessagePopupFrame_upvr.Button.Negative):buttonUp(function() -- Line 100
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:buttonClicked("negative")
	end)
	var5_upvw.new(MessagePopupFrame_upvr.Button.Countdown):buttonUp(function() -- Line 105
	end)
end
function any_new_result1.closed(arg1) -- Line 110
	--[[ Upvalues[1]:
		[1]: Dark_upvr (readonly)
	]]
	if arg1._spinner then
		arg1._spinner:remove()
	end
	Dark_upvr.Visible = false
end
function any_new_result1.Start(arg1) -- Line 118
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	arg1:input()
	var4_upvw:listenToClose("MessagePopupFrame"):Connect(function() -- Line 122
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var16_upvw
local var17_upvw
function any_new_result1.Construct(arg1) -- Line 127
	--[[ Upvalues[6]:
		[1]: var16_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var17_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	var16_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var17_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = require(Knit_upvr.Modules.Button)
	var6_upvw = require(Knit_upvr.Modules.LoadingSpinner)
end
return any_new_result1