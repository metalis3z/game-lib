-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:36
-- Luau version 6, Types version 3
-- Time taken: 0.003835 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
local Classes_upvr = require(ReplicatedStorage.Shared.List.Items.Classes)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local HttpService_upvr = game:GetService("HttpService")
return function(arg1, arg2) -- Line 18
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: Classes_upvr (readonly)
		[3]: Functions_upvr (readonly)
		[4]: HttpService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var7 = arg2
	if not var7 then
		var7 = {}
	end
	local var8 = var7
	local clone = Assets_upvr.UI.Item:Clone()
	local Main = clone.Main
	local Amount = Main.Amount
	local IconContainer = Main.IconContainer
	local ImageLabel_upvr = IconContainer.ImageLabel
	local any_getClass_result1 = arg1:getClass()
	local var15 = Classes_upvr[any_getClass_result1]
	if var8.scribble == nil then
		any_getClass_result1 = true
	else
		any_getClass_result1 = var8.scribble
	end
	Main.Scribble.Visible = any_getClass_result1
	Main.Scribble.UIGradient.Color = var15.color
	local any_ToHSV_result1, any_ToHSV_result2, any_ToHSV_result3 = Functions_upvr.evalColorSequence(var15.color, 1):ToHSV()
	Main.Container.Visible = var8.container
	Main.Container.UIStroke.Thickness = Main.Container.UIStroke.Thickness * (var8.uiStrokeThicknessMult or 1)
	Main.Container.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromHSV(any_ToHSV_result1, 0.2, any_ToHSV_result3))})
	clone.LayoutOrder = var15.baseLayoutOrder + (arg1:getLayoutOrder() or 1)
	ImageLabel_upvr.Image = arg1:getIcon()
	if arg1.getSerial and arg1:getSerial() then
		Amount.Text = `#{arg1:getSerialNumber()}`
		Amount.TextColor3 = Color3.fromRGB(250, 115, 248)
	else
		Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
	Amount.UIStroke.Thickness = Amount.UIStroke.Thickness * (var8.uiStrokeThicknessMult or 1)
	Amount.Visible = not var8.hideAmount
	Main.Circle.Visible = var8.showCircle
	local var21
	if arg1:getClass() == "upgrade" then
		local mult = arg1:getShowRealNumber() and 1 or 100
		if not arg1:getHidePercentage() then
			Amount.Text = `+{arg1:getAmount() * mult}{'%'}`
		end
	end
	if not var8.defaultIconSize and var15.iconSize then
		ImageLabel_upvr.Size = var15.iconSize
		IconContainer.ClipsDescendants = false
	end
	clone:SetAttribute("isItemUI", true)
	if var8.searchParams then
		clone:SetAttribute("searchParams", HttpService_upvr:JSONEncode({
			name = arg1:getName();
		}))
	end
	if not var8.ignoreAnimateIconHover then
		local Scale_upvr = ImageLabel_upvr.Size.X.Scale
		local Scale_upvr_2 = ImageLabel_upvr.Size.X.Scale
		ImageLabel_upvr.MouseEnter:Connect(function() -- Line 86
			--[[ Upvalues[3]:
				[1]: ImageLabel_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ImageLabel_upvr:TweenSize(UDim2.new(Scale_upvr * 1.05, 0, Scale_upvr_2 * 1.05, 0), "Out", "Quad", 0.15, true)
		end)
		ImageLabel_upvr.MouseLeave:Connect(function() -- Line 89
			--[[ Upvalues[3]:
				[1]: ImageLabel_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ImageLabel_upvr:TweenSize(UDim2.new(Scale_upvr, 0, Scale_upvr_2, 0), "Out", "Quad", 0.15, true)
		end)
	end
	clone.Visible = true
	clone.Name = var8.name or "_itemUI"
	return clone
end