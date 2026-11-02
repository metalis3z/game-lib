-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:13
-- Luau version 6, Types version 3
-- Time taken: 0.002781 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ClansConfirmFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local ClansConfirmFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ClansConfirmFrame")
function any_new_result1.update(arg1) -- Line 40
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: ClansConfirmFrame_upvr (readonly)
	]]
	local any_getConfirmData_result1 = var5_upvw:getConfirmData()
	local confirmType = any_getConfirmData_result1.confirmType
	local var13 = var9_upvw[confirmType]
	ClansConfirmFrame_upvr.Title.Text = var13.title
	if confirmType == "kick" then
		ClansConfirmFrame_upvr.List.Message.Text = var13.message:format(any_getConfirmData_result1.username, any_getConfirmData_result1.tag)
	else
		ClansConfirmFrame_upvr.List.Message.Text = var13.message
	end
	ClansConfirmFrame_upvr.Confirm.Label.Text = var13.positive
end
function any_new_result1.leaveClanAction(arg1) -- Line 56
	--[[ Upvalues[3]:
		[1]: var6_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var4_upvw (read and write)
	]]
	local any_leaveClan_result1 = var6_upvw:leaveClan()
	if any_leaveClan_result1 == "success" then
		var5_upvw:setForceUpdate("topClans")
		var4_upvw:openFrame("ClansFrame")
	else
		var4_upvw:createMessagePopup({
			message = `Something went wrong, please try again! ({any_leaveClan_result1})`;
			reOpen = "ClansFrame";
		})
	end
end
local Dark_upvr = ClansConfirmFrame_upvr:WaitForChild("Dark")
function any_new_result1.buttons(arg1) -- Line 69
	--[[ Upvalues[7]:
		[1]: var7_upvw (read and write)
		[2]: ClansConfirmFrame_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: Dark_upvr (readonly)
		[7]: var6_upvw (read and write)
	]]
	var7_upvw.new(ClansConfirmFrame_upvr.Confirm):buttonUp(function() -- Line 71
		--[[ Upvalues[7]:
			[1]: var5_upvw (copied, read and write)
			[2]: var8_upvw (copied, read and write)
			[3]: ClansConfirmFrame_upvr (copied, readonly)
			[4]: var4_upvw (copied, read and write)
			[5]: arg1 (readonly)
			[6]: Dark_upvr (copied, readonly)
			[7]: var6_upvw (copied, read and write)
		]]
		local any_getConfirmData_result1_2 = var5_upvw:getConfirmData()
		local confirmType_2 = any_getConfirmData_result1_2.confirmType
		if confirmType_2 == "leave" then
			if var5_upvw:getClanRank() == 1 then
				var4_upvw:createMessagePopup({
					message = "Leaving will result in the clan being permanently deleted. Are you sure?";
					reOpen = "ClansFrame";
					loading = true;
					countdown = 10;
					button = "Yes";
					buttonNegative = "No";
					messageSize = UDim2.fromScale(1, 0.67);
					positive = function() -- Line 91, Named "positive"
						--[[ Upvalues[1]:
							[1]: arg1 (copied, readonly)
						]]
						arg1:leaveClanAction()
					end;
				})
			else
				var8_upvw.new(ClansConfirmFrame_upvr):run()
				Dark_upvr.Visible = true
				arg1:leaveClanAction()
			end
		elseif confirmType_2 == "kick" then
			var8_upvw.new(ClansConfirmFrame_upvr):run()
			Dark_upvr.Visible = true
			local any_kickPlayer_result1 = var6_upvw:kickPlayer(any_getConfirmData_result1_2.userId)
			if any_kickPlayer_result1 == "success" then
				var5_upvw:setForceUpdate("yourClan")
				var4_upvw:openFrame("ClansFrame")
			else
				var4_upvw:createMessagePopup({
					message = `Something went wrong, please try again! ({any_kickPlayer_result1})`;
					reOpen = "ClansProfileFrame";
				})
			end
		end
		Dark_upvr.Visible = false
		var8_upvw.new(ClansConfirmFrame_upvr):remove()
	end)
	var7_upvw.new(ClansConfirmFrame_upvr.Cancel):buttonUp(function() -- Line 122
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		var4_upvw:openFrame("ClansFrame")
	end)
end
function any_new_result1.Start(arg1) -- Line 127
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	arg1:update()
	var4_upvw:listenToOpen("ClansConfirmFrame"):Connect(function() -- Line 131
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
local var25_upvw
local var26_upvw
local var27_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 136
	--[[ Upvalues[11]:
		[1]: var6_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var25_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var26_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var27_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var9_upvw (read and write)
	]]
	var6_upvw = Knit_upvr.GetService("ClanService")
	var25_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var26_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("ClanController")
	var7_upvw = require(Knit_upvr.Modules.Button)
	var8_upvw = require(Knit_upvr.Modules.LoadingSpinner)
	var27_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(script.ConfirmTypes)
end
return any_new_result1