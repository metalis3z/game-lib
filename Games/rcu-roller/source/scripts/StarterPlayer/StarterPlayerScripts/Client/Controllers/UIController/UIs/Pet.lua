-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:35
-- Luau version 6, Types version 3
-- Time taken: 0.008097 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local Debris_upvr = game:GetService("Debris")
local Assets_upvr = ReplicatedStorage.Assets
local random_state_upvr = Random.new()
local function _(arg1) -- Line 18, Named "starEffect"
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: Debris_upvr (readonly)
		[3]: random_state_upvr (readonly)
		[4]: TweenService_upvr (readonly)
	]]
	return task.spawn(function() -- Line 19
		--[[ Upvalues[5]:
			[1]: Assets_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: Debris_upvr (copied, readonly)
			[4]: random_state_upvr (copied, readonly)
			[5]: TweenService_upvr (copied, readonly)
		]]
		while true do
			local clone_5_upvr = Assets_upvr.UI.FX.ShinyStar:Clone()
			if not arg1:FindFirstChild("Main") then break end
			clone_5_upvr.Parent = arg1.Main
			Debris_upvr:AddItem(clone_5_upvr, 2.5)
			local any_NextNumber_result1_3 = random_state_upvr:NextNumber(0.75, 1.05)
			local Size_2 = clone_5_upvr.Size
			clone_5_upvr.Size = UDim2.fromScale()
			clone_5_upvr.Position = UDim2.fromScale(random_state_upvr:NextNumber(0.1, 0.9), random_state_upvr:NextNumber(0.1, 0.9))
			local var11_upvr = Size_2.X.Scale * any_NextNumber_result1_3
			local var12_upvr = Size_2.Y.Scale * any_NextNumber_result1_3
			task.spawn(function() -- Line 44
				--[[ Upvalues[4]:
					[1]: TweenService_upvr (copied, readonly)
					[2]: clone_5_upvr (readonly)
					[3]: var11_upvr (readonly)
					[4]: var12_upvr (readonly)
				]]
				TweenService_upvr:Create(clone_5_upvr, TweenInfo.new(1.5), {
					Size = UDim2.fromScale(var11_upvr, var12_upvr);
				}):Play()
				task.wait(1.5)
				TweenService_upvr:Create(clone_5_upvr, TweenInfo.new(1), {
					Size = UDim2.fromScale(0, 0);
				}):Play()
			end)
			task.wait(random_state_upvr:NextNumber(1, 3))
		end
	end)
end
local function _(arg1) -- Line 58, Named "shineEffect"
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	return task.spawn(function() -- Line 59
		--[[ Upvalues[3]:
			[1]: Assets_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: TweenService_upvr (copied, readonly)
		]]
		local clone_4 = Assets_upvr.UI.FX.ShineEffect:Clone()
		clone_4.Parent = arg1.Main
		local ImageLabel_2 = clone_4.ImageLabel
		local udim2_2 = UDim2.fromScale(-0.5, -0.5)
		local any_Create_result1_3 = TweenService_upvr:Create(ImageLabel_2, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(1.5, 1.5);
		})
		while true do
			ImageLabel_2.Position = udim2_2
			any_Create_result1_3:Play()
			any_Create_result1_3.Completed:Wait()
			task.wait(3)
		end
	end)
end
local function _(arg1) -- Line 85, Named "shinyEffect"
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: Debris_upvr (readonly)
		[3]: random_state_upvr (readonly)
		[4]: TweenService_upvr (readonly)
	]]
	local var37_upvw
	local task_spawn_result1_upvr_2 = task.spawn(function() -- Line 19
		--[[ Upvalues[5]:
			[1]: Assets_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: Debris_upvr (copied, readonly)
			[4]: random_state_upvr (copied, readonly)
			[5]: TweenService_upvr (copied, readonly)
		]]
		while true do
			local clone_2_upvr = Assets_upvr.UI.FX.ShinyStar:Clone()
			if not arg1:FindFirstChild("Main") then break end
			clone_2_upvr.Parent = arg1.Main
			Debris_upvr:AddItem(clone_2_upvr, 2.5)
			local any_NextNumber_result1 = random_state_upvr:NextNumber(0.75, 1.05)
			local Size_3 = clone_2_upvr.Size
			clone_2_upvr.Size = UDim2.fromScale()
			clone_2_upvr.Position = UDim2.fromScale(random_state_upvr:NextNumber(0.1, 0.9), random_state_upvr:NextNumber(0.1, 0.9))
			local var26_upvr = Size_3.X.Scale * any_NextNumber_result1
			local var27_upvr = Size_3.Y.Scale * any_NextNumber_result1
			task.spawn(function() -- Line 44
				--[[ Upvalues[4]:
					[1]: TweenService_upvr (copied, readonly)
					[2]: clone_2_upvr (readonly)
					[3]: var26_upvr (readonly)
					[4]: var27_upvr (readonly)
				]]
				TweenService_upvr:Create(clone_2_upvr, TweenInfo.new(1.5), {
					Size = UDim2.fromScale(var26_upvr, var27_upvr);
				}):Play()
				task.wait(1.5)
				TweenService_upvr:Create(clone_2_upvr, TweenInfo.new(1), {
					Size = UDim2.fromScale(0, 0);
				}):Play()
			end)
			task.wait(random_state_upvr:NextNumber(1, 3))
		end
	end)
	local task_spawn_result1_upvr = task.spawn(function() -- Line 59
		--[[ Upvalues[3]:
			[1]: Assets_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: TweenService_upvr (copied, readonly)
		]]
		local clone = Assets_upvr.UI.FX.ShineEffect:Clone()
		clone.Parent = arg1.Main
		local ImageLabel_3 = clone.ImageLabel
		local udim2_3 = UDim2.fromScale(-0.5, -0.5)
		local any_Create_result1 = TweenService_upvr:Create(ImageLabel_3, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(1.5, 1.5);
		})
		while true do
			ImageLabel_3.Position = udim2_3
			any_Create_result1:Play()
			any_Create_result1.Completed:Wait()
			task.wait(3)
		end
	end)
	var37_upvw = arg1:GetPropertyChangedSignal("Parent"):Connect(function() -- Line 90
		--[[ Upvalues[4]:
			[1]: arg1 (readonly)
			[2]: var37_upvw (read and write)
			[3]: task_spawn_result1_upvr_2 (readonly)
			[4]: task_spawn_result1_upvr (readonly)
		]]
		if arg1.Parent then
		else
			var37_upvw:Disconnect()
			task.cancel(task_spawn_result1_upvr_2)
			task.cancel(task_spawn_result1_upvr)
		end
	end)
end
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local Special_upvr = require(ReplicatedStorage.Shared.List.Pets.Special)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local HttpService_upvr = game:GetService("HttpService")
return function(arg1, arg2) -- Line 99
	--[[ Upvalues[8]:
		[1]: Assets_upvr (readonly)
		[2]: Util_upvr (readonly)
		[3]: Special_upvr (readonly)
		[4]: Functions_upvr (readonly)
		[5]: HttpService_upvr (readonly)
		[6]: Debris_upvr (readonly)
		[7]: random_state_upvr (readonly)
		[8]: TweenService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var53 = arg2
	if not var53 then
		var53 = {}
	end
	local var54 = var53
	local clone_6_upvr = Assets_upvr.UI.Pet:Clone()
	local Main = clone_6_upvr.Main
	local Amount = Main.Amount
	local Multiplier = Main.Multiplier
	local ImageLabel_upvr = Main.IconContainer.ImageLabel
	local UIStroke = Main.UIStroke
	local any_getRarityData_result1 = Util_upvr.petUtils.getRarityData(Util_upvr.petUtils.getRarityId(arg1:getRarity()))
	Main.UIGradient.Color = any_getRarityData_result1.gradient
	UIStroke.Color = any_getRarityData_result1.stroke
	UIStroke.Thickness *= var54.uiStrokeThicknessMult or 1
	if any_getRarityData_result1.strokeGradient then
		UIStroke.UIGradient.Color = any_getRarityData_result1.gradient
	end
	local var62
	if arg1:getSpecial() then
		var62 = Special_upvr.tiers[arg1:getTier()] - 1
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var62 = Special_upvr.shiny - 1
			return var62
		end
		if not arg1:isShiny() or not INLINED() then
			var62 = 0
		end
		var62 = `{Functions_upvr.floatingPoint((arg1:getSpecial() + var62 + var62) * 100)}%`
		Multiplier.Text = var62
	else
		local mult = arg1:getMultiplier()
		Multiplier.Text = Functions_upvr.suffixes(mult)
	end
	Multiplier.UIStroke.Thickness = Multiplier.UIStroke.Thickness * (var54.uiStrokeThicknessMult or 1)
	Multiplier.Visible = not var54.hideMult
	clone_6_upvr.LayoutOrder = arg1:getLayoutOrder()
	ImageLabel_upvr.Image = arg1:getIcon()
	Main.Locked.Visible = arg1:getLocked()
	if arg1:getAmount() >= 1000000 or not Functions_upvr.comma(arg1:getAmount()) then
	end
	local formatted = `x{Functions_upvr.suffixes(arg1:getAmount())}`
	local var64
	if arg1:getSerial() then
		formatted = `#{arg1:getSerialNumber()}`
		var64 = Color3.fromRGB(250, 115, 248)
	end
	Amount.Text = formatted
	if not var64 or not var64 then
	end
	Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
	Amount.UIStroke.Thickness = Amount.UIStroke.Thickness * (var54.uiStrokeThicknessMult or 1)
	Amount.Visible = not var54.hideAmount
	for _, v in Main.Tiers:GetChildren() do
		local var68 = false
		if any_getRarityData_result1.name == v.Name then
			var68 = not var54.hideTier
		end
		v.Visible = var68
	end
	clone_6_upvr:SetAttribute("isItemUI", true)
	if var54.searchParams then
		clone_6_upvr:SetAttribute("searchParams", HttpService_upvr:JSONEncode({
			name = arg1:getName();
			shiny = arg1:isShiny() and "shiny";
			rarity = any_getRarityData_result1.name;
			tier = Util_upvr.petUtils.getTierData(arg1:getTier()).name;
			egg = Util_upvr.eggUtils.getEggNameFromPetName(arg1:getName());
		}))
	end
	if not var54.ignoreAnimateIconHover then
		local Scale_upvr = ImageLabel_upvr.Size.X.Scale
		local Scale_upvr_2 = ImageLabel_upvr.Size.X.Scale
		ImageLabel_upvr.MouseEnter:Connect(function() -- Line 180
			--[[ Upvalues[3]:
				[1]: ImageLabel_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ImageLabel_upvr:TweenSize(UDim2.new(Scale_upvr * 1.05, 0, Scale_upvr_2 * 1.05, 0), "Out", "Quad", 0.15, true)
		end)
		ImageLabel_upvr.MouseLeave:Connect(function() -- Line 183
			--[[ Upvalues[3]:
				[1]: ImageLabel_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ImageLabel_upvr:TweenSize(UDim2.new(Scale_upvr, 0, Scale_upvr_2, 0), "Out", "Quad", 0.15, true)
		end)
	end
	Scale_upvr = true
	clone_6_upvr.Visible = Scale_upvr
	Scale_upvr_2 = var54.name
	Scale_upvr = Scale_upvr_2 or "_petUI"
	clone_6_upvr.Name = Scale_upvr
	Scale_upvr = arg1:isShiny()
	if Scale_upvr then
		Scale_upvr_2 = task.spawn
		Scale_upvr_2 = Scale_upvr_2(function() -- Line 19
			--[[ Upvalues[5]:
				[1]: Assets_upvr (copied, readonly)
				[2]: clone_6_upvr (readonly)
				[3]: Debris_upvr (copied, readonly)
				[4]: random_state_upvr (copied, readonly)
				[5]: TweenService_upvr (copied, readonly)
			]]
			while true do
				local clone_7_upvr = Assets_upvr.UI.FX.ShinyStar:Clone()
				if not clone_6_upvr:FindFirstChild("Main") then break end
				clone_7_upvr.Parent = clone_6_upvr.Main
				Debris_upvr:AddItem(clone_7_upvr, 2.5)
				local any_NextNumber_result1_2 = random_state_upvr:NextNumber(0.75, 1.05)
				local Size = clone_7_upvr.Size
				clone_7_upvr.Size = UDim2.fromScale()
				clone_7_upvr.Position = UDim2.fromScale(random_state_upvr:NextNumber(0.1, 0.9), random_state_upvr:NextNumber(0.1, 0.9))
				local var79_upvr = Size.X.Scale * any_NextNumber_result1_2
				local var80_upvr = Size.Y.Scale * any_NextNumber_result1_2
				task.spawn(function() -- Line 44
					--[[ Upvalues[4]:
						[1]: TweenService_upvr (copied, readonly)
						[2]: clone_7_upvr (readonly)
						[3]: var79_upvr (readonly)
						[4]: var80_upvr (readonly)
					]]
					TweenService_upvr:Create(clone_7_upvr, TweenInfo.new(1.5), {
						Size = UDim2.fromScale(var79_upvr, var80_upvr);
					}):Play()
					task.wait(1.5)
					TweenService_upvr:Create(clone_7_upvr, TweenInfo.new(1), {
						Size = UDim2.fromScale(0, 0);
					}):Play()
				end)
				task.wait(random_state_upvr:NextNumber(1, 3))
			end
		end)
		Scale_upvr = Scale_upvr_2
		Scale_upvr_2 = task.spawn(function() -- Line 59
			--[[ Upvalues[3]:
				[1]: Assets_upvr (copied, readonly)
				[2]: clone_6_upvr (readonly)
				[3]: TweenService_upvr (copied, readonly)
			]]
			local clone_3 = Assets_upvr.UI.FX.ShineEffect:Clone()
			clone_3.Parent = clone_6_upvr.Main
			local ImageLabel = clone_3.ImageLabel
			local udim2 = UDim2.fromScale(-0.5, -0.5)
			local any_Create_result1_2 = TweenService_upvr:Create(ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
				Position = UDim2.fromScale(1.5, 1.5);
			})
			while true do
				ImageLabel.Position = udim2
				any_Create_result1_2:Play()
				any_Create_result1_2.Completed:Wait()
				task.wait(3)
			end
		end)
		local var90_upvw
		var90_upvw = clone_6_upvr:GetPropertyChangedSignal("Parent"):Connect(function() -- Line 90
			--[[ Upvalues[4]:
				[1]: clone_6_upvr (readonly)
				[2]: var90_upvw (read and write)
				[3]: Scale_upvr (readonly)
				[4]: Scale_upvr_2 (readonly)
			]]
			if clone_6_upvr.Parent then
			else
				var90_upvw:Disconnect()
				task.cancel(Scale_upvr)
				task.cancel(Scale_upvr_2)
			end
		end)
	end
	return clone_6_upvr
end