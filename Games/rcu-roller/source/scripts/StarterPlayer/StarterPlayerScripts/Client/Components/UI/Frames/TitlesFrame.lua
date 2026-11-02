-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:57
-- Luau version 6, Types version 3
-- Time taken: 0.003456 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TitlesFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Holder_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("TitlesFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
function any_new_result1.setSelected(arg1, arg2, arg3) -- Line 40
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	local State = Holder_upvr[arg2].Main.State
	State.Selected.Visible = arg3
	State.Select.Visible = not arg3
end
function any_new_result1.unselectAll(arg1) -- Line 50
	--[[ Upvalues[1]:
		[1]: var10_upvw (read and write)
	]]
	for i, _ in var10_upvw do
		arg1:setSelected(i, false)
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupFrames(arg1) -- Line 56
	--[[ Upvalues[6]:
		[1]: var10_upvw (read and write)
		[2]: Assets_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: var9_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	for i_2_upvr, v_2 in var10_upvw do
		local clone = Assets_upvr.UI.Title:Clone()
		local Main_2 = clone.Main
		local any_ToHSV_result1, _, any_ToHSV_result3 = v_2.chatColor:ToHSV()
		Main_2.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(any_ToHSV_result1, 0.1, any_ToHSV_result3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
		local TitleName = Main_2.TitleName
		TitleName.Text = v_2.title
		TitleName.UIGradient.Color = v_2.gradient
		TitleName.UIStroke.UIGradient.Color = v_2.gradient
		Main_2.Description.Text = v_2.description
		clone:SetAttribute("isTitle", true)
		local var28
		if v_2.category == "progress" then
			var28 = 100
		else
			var28 = 0
		end
		clone.LayoutOrder = i_2_upvr + var28
		clone.Name = i_2_upvr
		clone.Visible = true
		clone.Parent = Holder_upvr
		local ButtonModule = var9_upvw
		local StateFrame = Main_2.State
		ButtonModule.new(StateFrame):buttonUp(function()
			--[[ Upvalues[4]:
				[1]: var7_upvw (copied, read and write)
				[2]: i_2_upvr (readonly)
				[3]: arg1 (readonly)
				[4]: var6_upvw (copied, read and write)
			]]
			if var7_upvw:select(i_2_upvr) == "success" then
				arg1:unselectAll()
				arg1:setSelected(i_2_upvr, true)
				var6_upvw:play("Equip Title")
			end
		end)
	end
	arg1:update()
end
function any_new_result1.update(arg1) -- Line 97
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local data = var4_upvw.data
	for i_3, v_3 in var10_upvw do
		local var39 = Holder_upvr[i_3]
		local Main = var39.Main
		local State_2 = Main.State
		local any_isUnlocked_result1 = v_3.isUnlocked(LocalPlayer_upvr, data)
		-- Fixed: INLINED pattern — isHidden is true only if function exists AND returns truthy
		local isHidden = v_3.isHidden and v_3.isHidden(LocalPlayer_upvr, data)
		var39.Visible = not isHidden
		Main.Description.Visible = not any_isUnlocked_result1
		local isSelected = (data.selectedTitle == i_3)
		State_2.Selected.Visible = isSelected
		State_2.Select.Visible = not isSelected
		State_2.Visible = any_isUnlocked_result1
	end
end
function any_new_result1.removeFrames(arg1) -- Line 121
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_4 in Holder_upvr:GetChildren() do
		if v_4:GetAttribute("isTitle") then
			v_4:Destroy()
		end
	end
end
function any_new_result1.opened(arg1) -- Line 129
	arg1:setupFrames()
end
function any_new_result1.closed(arg1) -- Line 133
	arg1:removeFrames()
end
function any_new_result1.Start(arg1) -- Line 137
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:opened()
	var5_upvw:listenToOpen("TitlesFrame"):Connect(function() -- Line 139
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("TitlesFrame"):Connect(function() -- Line 142
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
	var6_upvw:preloadSounds({"Equip Title"})
end
local var53_upvw
function any_new_result1.Construct(arg1) -- Line 151
	--[[ Upvalues[9]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: var53_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("TitleService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var53_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Titles)
end
return any_new_result1