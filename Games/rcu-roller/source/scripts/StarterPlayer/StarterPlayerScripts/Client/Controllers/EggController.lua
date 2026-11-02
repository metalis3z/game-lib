-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:53
-- Luau version 6, Types version 3
-- Time taken: 0.016263 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "EggController";
	_currentEgg = "";
	currentEggChanged = nil;
	_isAutoHatching = false;
	_luckyEggs = {};
	_globalLuckEventAmount = 0;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local CollectionService_upvr = game:GetService("CollectionService")
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local var19_upvw
local var20_upvw
local var21_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local EggDisplayFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("EggDisplayFrame")
local Main_upvr_2 = EggDisplayFrame_upvr:WaitForChild("Main")
local Buttons_upvr = Main_upvr_2:WaitForChild("Buttons")
local Pity_upvr = Main_upvr_2:WaitForChild("Pity")
function any_CreateController_result1.getGlobalLuckEventAmount(arg1) -- Line 72
	return arg1._globalLuckEventAmount
end
function any_CreateController_result1.getCurrentEgg(arg1) -- Line 76
	return arg1._currentEgg
end
function any_CreateController_result1.getOpenParams(arg1) -- Line 80
	local module = {}
	if arg1._luckyEggId then
		module.luckyEggId = arg1._luckyEggId
	end
	if not next(module) then return end
	return module
end
function any_CreateController_result1.getClosestEgg(arg1, arg2) -- Line 94
	local closest
	local closestDist = math.huge
	local hrp = LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	for _, v in pairs(arg2) do
		local egg = v:FindFirstChild("Egg")
		if egg and egg.PrimaryPart then
			local dist = (egg.PrimaryPart.Position - hrp.Position).Magnitude
			if dist < closestDist then
				closestDist = dist
				closest = v
			end
		end
	end
	return closest
end
function any_CreateController_result1.rainbowChance(arg1, arg2) -- Line 105
	task.spawn(function() -- Line 106
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		repeat
			arg2.Main.Percentage.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			task.wait()
		until not arg2.Parent
	end)
end
function any_CreateController_result1.updateButtons(arg1) -- Line 115
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Buttons_upvr (readonly)
		[3]: var14_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
	]]
	if arg1._currentEgg == "" then
	else
		Buttons_upvr.Open3.Label.Text = `Open {var14_upvw.eggUtils.getMaxAffordable(LocalPlayer_upvr, var4_upvw:getData(), arg1._currentEgg)}`
	end
end
function any_CreateController_result1.hasIndex(arg1, arg2) -- Line 125
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var21_upvw (read and write)
		[3]: var17_upvw (read and write)
		[4]: var14_upvw (read and write)
	]]
	for i_2 = 1, #var21_upvw do
		local var41
		for i_3 = 1, 2 do
			if i_3 ~= 1 then
				var41 = false
			else
				var41 = true
			end
			if var4_upvw:getData().index[var14_upvw.petUtils.getPetDescriptor(var17_upvw.pet(arg2:getName()):setTier(i_2):setShiny(var41))] then
				return true
			end
		end
	end
end
function any_CreateController_result1.updateView(arg1)
	if arg1._currentEgg == "" then return end

	arg1:updateButtons()

	for _, v in Main_upvr_2.Holder:GetChildren() do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	local data = var4_upvw:getData()
	if not data then return end

	local eggConfig = var15_upvw[arg1._currentEgg]
	if not eggConfig then return end

	Main_upvr_2.Currency.Label.Text = var13_upvw.suffixes(eggConfig.cost)
	Main_upvr_2.Size = UDim2.new()
	Main_upvr_2:TweenSize(UDim2.fromScale(1, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.15, true)

	local petList = {}
	for petName, _ in pairs(eggConfig.pets) do
		petList[#petList + 1] = {
			name = petName,
			settings = var16_upvw[petName],
		}
	end

	table.sort(petList, function(a, b)
		return a.settings.multiplier < b.settings.multiplier
	end)

	for i = 1, math.min(#petList, 6) do
		local petSettings = petList[i].settings
		if not petSettings.hide then
			local petItem = var17_upvw.pet(petList[i].name)
			local petCard = var6_upvw.uis.pet(petItem, {
				hideTier = true,
			})
			local cardMain = petCard.Main

			cardMain.Amount.Visible = false
			cardMain.Multiplier.Visible = false
			cardMain.Percentage.Visible = true

			local luckyBonus = arg1._luckyEggId and 2.5 or 0
			local chance = var14_upvw.petUtils.getPetChance(LocalPlayer_upvr, data, petList[i].name, luckyBonus)
			local rarityId = var14_upvw.petUtils.getRarityId(petItem:getRarity())
			local rarityData = var14_upvw.petUtils.getRarityData(rarityId)

			local chanceText
			if rarityData and rarityData.name == "Secret" then
				chanceText = "???%"
				arg1:rainbowChance(petCard)
			elseif chance <= 0.1 then
				chanceText = `1/{var13_upvw.suffixes(math.floor(var13_upvw.floatingPoint(1 / chance) * 100))}`
			else
				chanceText = `{var13_upvw.floatingPoint(chance, 2)}%`
			end

			cardMain.Percentage.Text = chanceText
			petCard.LayoutOrder = i
			petCard.Parent = EggDisplayFrame_upvr.Main.Holder

			if data.autoArchive then
				cardMain.Archive.Visible = data.autoArchive[petItem:getName()] or false
			else
				cardMain.Archive.Visible = false
			end

			if arg1:hasIndex(petItem) then
				cardMain.IconContainer.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
			else
				cardMain.IconContainer.ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			end

			local mapData = var18_upvw[#data.maps + 1]
			if mapData and (mapData.unlocksAt or 0) <= os.time() then
				for qi, quest in mapData.quests do
					if quest.quest == "hatchPet" and quest.name == petItem:getName() and data.mapQuests[qi] < quest.amount then
						cardMain.Quest.Visible = true
					end
				end
			end

			var19_upvw.new(petCard.Main, petCard.Main.Click, {
				up = 1.025,
				hover = 1.025,
			}):buttonUp(function()
				local result, isArchived = var9_upvw:autoArchive(petItem:getName())
				if result == "success" then
					cardMain.Archive.Visible = isArchived
				end
			end)
		end
	end

	if var20_upvw.Current == "Touch" then
		Buttons_upvr.Open1.Touch.Visible = true
		Buttons_upvr.Open3.Touch.Visible = true
		Buttons_upvr.Auto.Touch.Visible = true
	end
	if var20_upvw.Current == "MouseKeyboard" then
		Buttons_upvr.Open1.Input.Visible = true
		Buttons_upvr.Open3.Input.Visible = true
		Buttons_upvr.Auto.Input.Visible = true
	end
end
local PityShadow_upvr = Pity_upvr:WaitForChild("PityShadow")
function any_CreateController_result1.setPityVisible(arg1, arg2) -- Line 253
	--[[ Upvalues[2]:
		[1]: Pity_upvr (readonly)
		[2]: PityShadow_upvr (readonly)
	]]
	Pity_upvr.Visible = arg2
	PityShadow_upvr.Visible = arg2
end
function any_CreateController_result1.updatePityProgress(arg1) -- Line 258
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: var15_upvw (read and write)
		[4]: var13_upvw (read and write)
		[5]: Pity_upvr (readonly)
	]]
	local data = var4_upvw.data
	local _currentEgg_2 = arg1._currentEgg
	if var14_upvw.upgradeUtils.getAchievementMultiplier(data, "mythicalPity") == 0 then
		arg1:setPityVisible(false)
	else
		if _currentEgg_2 == "" then return end
		local any_getPityPet_result1 = var14_upvw.eggUtils.getPityPet(_currentEgg_2)
		if not any_getPityPet_result1 then
			arg1:setPityVisible(false)
			return
		end
		local var98 = data.pity[_currentEgg_2]
		if not var98 then
			arg1:setPityVisible(false)
			return
		end
		Pity_upvr.Label.Text = `Mythical Pity {var13_upvw.suffixes(var98)}/{var13_upvw.suffixes(1 / var15_upvw[_currentEgg_2].pets[any_getPityPet_result1] * 50)}`
		Pity_upvr.Bar:TweenSize(UDim2.fromScale(var14_upvw.eggUtils.getPityProgress(data, _currentEgg_2), 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		arg1:setPityVisible(true)
	end
end
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.view(arg1) -- Line 296
	--[[ Upvalues[10]:
		[1]: RunService_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var13_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var6_upvw (read and write)
		[6]: EggDisplayFrame_upvr (readonly)
		[7]: var5_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: CurrentCamera_upvr (readonly)
		[10]: CollectionService_upvr (readonly)
	]]
	RunService_upvr.Heartbeat:Connect(function() -- Line 297
		--[[ Upvalues[10]:
			[1]: var4_upvw (copied, read and write)
			[2]: var13_upvw (copied, read and write)
			[3]: LocalPlayer_upvr (copied, readonly)
			[4]: var6_upvw (copied, read and write)
			[5]: EggDisplayFrame_upvr (copied, readonly)
			[6]: var5_upvw (copied, read and write)
			[7]: var8_upvw (copied, read and write)
			[8]: CurrentCamera_upvr (copied, readonly)
			[9]: CollectionService_upvr (copied, readonly)
			[10]: arg1 (readonly)
		]]
		if not var13_upvw.getHRP(LocalPlayer_upvr) then
		else
			if var6_upvw:isFrameOpen() then
				EggDisplayFrame_upvr.Visible = false
				return
			end
			if var5_upvw:isHatching() then
				EggDisplayFrame_upvr.Visible = false
				return
			end
			if var8_upvw:getIsRolling() or var8_upvw:getIsAutoRolling() then
				EggDisplayFrame_upvr.Visible = false
				return
			end
			local tbl_2 = {}
			for i_10, v_6 in CollectionService_upvr:GetTagged("Egg") do
				if v_6:FindFirstChild("Egg") and v_6.Egg.PrimaryPart and (v_6.Egg.PrimaryPart.Position - LocalPlayer_upvr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
					tbl_2[#tbl_2 + 1] = v_6
				end
			end
			if 1 <= #tbl_2 then
			local any_getClosestEgg_result1 = arg1:getClosestEgg(tbl_2)
				if not any_getClosestEgg_result1 or not any_getClosestEgg_result1:FindFirstChild("Egg") then return end
				v_6 = any_getClosestEgg_result1.Egg.PrimaryPart.Position
				i_10 = v_6 + Vector3.new(0, 1, 0)
				local any_WorldToViewportPoint_result1 = CurrentCamera_upvr:WorldToViewportPoint(i_10)
				i_10 = UDim2.fromScale
				v_6 = any_WorldToViewportPoint_result1.X / CurrentCamera_upvr.ViewportSize.X
				i_10 = i_10(v_6, any_WorldToViewportPoint_result1.Y / CurrentCamera_upvr.ViewportSize.Y)
				EggDisplayFrame_upvr.Position = i_10
				i_10 = true
				EggDisplayFrame_upvr.Visible = i_10
				if arg1._currentEgg ~= any_getClosestEgg_result1.Name then
					arg1._currentEgg = any_getClosestEgg_result1.Name
					arg1._luckyEggId = any_getClosestEgg_result1:GetAttribute("luckyEggId")
					arg1:updateView()
					arg1.currentEggChanged:Fire()
				end
				arg1:updatePityProgress()
			else
				EggDisplayFrame_upvr.Visible = false
				arg1._currentEgg = ""
				arg1._luckyEggId = nil
			end
			if 0 < LocalPlayer_upvr.Character:WaitForChild("Head").LocalTransparencyModifier then
				EggDisplayFrame_upvr.Visible = false
			end
			EggDisplayFrame_upvr.UIScale.Scale = 1 / (CurrentCamera_upvr.CFrame.Position - CurrentCamera_upvr.Focus.Position).Magnitude * 13
		end
	end)
end
function any_CreateController_result1.autoHatch(arg1, arg2) -- Line 365
	--[[ Upvalues[8]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var14_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: RunService_upvr (readonly)
		[8]: var5_upvw (read and write)
	]]
	if not var13_upvw.isInGroup(LocalPlayer_upvr) then
		var6_upvw:createMessagePopup({
			message = "Join our group <font color='#c636ff'>Powerful Studio</font> to Auto Hatch!";
			icon = "rbxassetid://88485788176729";
			messageSize = UDim2.fromScale(1, 0.45);
			iconSize = UDim2.fromScale(0.77, 0.41);
		})
		return
	end
	var9_upvw.setIsAutoHatching:Fire(arg1._currentEgg)
	arg1._isAutoHatching = true
	task.spawn(function()
	repeat
		if not var5_upvw._isHatching then
			local currentData = var4_upvw:getData()
			if currentData then
				local amount = var14_upvw.eggUtils.getAmountFromOpenType(LocalPlayer_upvr, currentData, arg1._currentEgg, arg2)
				if var14_upvw.eggUtils.hasEnoughToOpen(currentData, arg1._currentEgg, amount) or (currentData.isAutoRebirthing) then
					var9_upvw.openEgg:Fire(arg1._currentEgg, amount)
				end
			end
		end
		task.wait(0.5)
		until not arg1._isAutoHatching or arg1._currentEgg == ""
		arg1._isAutoHatching = false
		var9_upvw.setIsAutoHatching:Fire("")
	end)
end
local random_state_upvr = Random.new()
function any_CreateController_result1.openEgg(arg1, arg2, arg3) -- Line 421
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var14_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var15_upvw (read and write)
		[8]: random_state_upvr (readonly)
		[9]: var13_upvw (read and write)
		[10]: var9_upvw (read and write)
	]]
	local data_4 = var4_upvw.data
	if var7_upvw:getFFlag("openEggs") == false then
		var6_upvw:createMessagePopup({
			title = "Sorry!";
			message = "This is disabled right now, try again later!";
		})
	else
		if var5_upvw._isHatching then return end
		if arg1._pendingEgg then return end
		if arg1._currentEgg == "" then return end
		if arg1._isAutoHatching then return end
		local _currentEgg = arg1._currentEgg
		local any_getAmountFromOpenType_result1 = var14_upvw.eggUtils.getAmountFromOpenType(LocalPlayer_upvr, data_4, _currentEgg, arg2)
		if not var14_upvw.eggUtils.hasEnoughToOpen(data_4, _currentEgg, any_getAmountFromOpenType_result1) then
			local any_getCurrency_result1 = var14_upvw.eggUtils.getCurrency(_currentEgg)
			local var118 = "Uh Oh!"
			if random_state_upvr:NextNumber() < 0.01 then
				var118 = "Oopsie daisy!"
			end
			var6_upvw:createMessagePopup({
				title = var118;
				message = `You need {var13_upvw.suffixes(var15_upvw[_currentEgg].cost * any_getAmountFromOpenType_result1 - data_4[any_getCurrency_result1])} more {any_getCurrency_result1} to open this egg!`;
			})
			return
		end
		if arg3 then
			arg1:autoHatch(arg2)
			return
		end
		arg1._pendingEgg = true
		var9_upvw.openEgg:Fire(arg1._currentEgg, any_getAmountFromOpenType_result1, arg1:getOpenParams())
	end
end
function any_CreateController_result1.tweenInputButton(arg1, arg2, arg3, arg4) -- Line 473
	local any_getOriginalSizes_result1, any_getOriginalSizes_result2 = arg2:getOriginalSizes()
	local var122 = arg4
	if not var122 then
		var122 = arg2:getButtonMultiplier(arg3)
	end
	arg2:tween(arg2._button, {
		x = any_getOriginalSizes_result1;
		y = any_getOriginalSizes_result2;
		multiplier = var122;
	})
	arg2:playButtonSound(arg3)
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_CreateController_result1.inputs(arg1) -- Line 481
	--[[ Upvalues[5]:
		[1]: var19_upvw (read and write)
		[2]: Buttons_upvr (readonly)
		[3]: UserInputService_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
	]]
	local any_new_result1_upvr_2 = var19_upvw.new(Buttons_upvr.Open1)
	any_new_result1_upvr_2:buttonUp(function() -- Line 483
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openEgg(1)
	end)
	local any_new_result1_upvr_3 = var19_upvw.new(Buttons_upvr.Open3)
	any_new_result1_upvr_3:buttonUp(function() -- Line 487
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openEgg(2)
	end)
	local any_new_result1_upvr = var19_upvw.new(Buttons_upvr.Auto)
	any_new_result1_upvr:buttonUp(function() -- Line 491
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openEgg(2, true)
	end)
	UserInputService_upvr.InputBegan:Connect(function(arg1_3, arg2) -- Line 495
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
			[4]: any_new_result1_upvr_2 (readonly)
			[5]: any_new_result1_upvr_3 (readonly)
			[6]: any_new_result1_upvr (readonly)
		]]
		if arg1._currentEgg == "" then
		else
			if var5_upvw:isHatching() then return end
			if var6_upvw:isFrameOpen() then return end
			if arg2 then return end
			if arg1_3.KeyCode == Enum.KeyCode.E or arg1_3.KeyCode == Enum.KeyCode.ButtonL1 then
				arg1:tweenInputButton(any_new_result1_upvr_2, "down", 0.9)
				return
			end
			if arg1_3.KeyCode == Enum.KeyCode.R or arg1_3.KeyCode == Enum.KeyCode.ButtonR1 then
				arg1:tweenInputButton(any_new_result1_upvr_3, "down", 0.9)
				return
			end
			if arg1_3.KeyCode == Enum.KeyCode.T or arg1_3.KeyCode == Enum.KeyCode.ButtonX then
				arg1:tweenInputButton(any_new_result1_upvr, "down", 0.9)
			end
		end
	end)
	UserInputService_upvr.InputEnded:Connect(function(arg1_4, arg2) -- Line 520
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
			[4]: any_new_result1_upvr_2 (readonly)
			[5]: any_new_result1_upvr_3 (readonly)
			[6]: any_new_result1_upvr (readonly)
		]]
		if arg1._currentEgg == "" then
		else
			if var5_upvw:isHatching() then return end
			if var6_upvw:isFrameOpen() then return end
			if arg2 then return end
			if arg1_4.KeyCode == Enum.KeyCode.E or arg1_4.KeyCode == Enum.KeyCode.ButtonL1 then
				arg1:openEgg(1)
				arg1:tweenInputButton(any_new_result1_upvr_2, "up")
				return
			end
			if arg1_4.KeyCode == Enum.KeyCode.R or arg1_4.KeyCode == Enum.KeyCode.ButtonR1 then
				arg1:openEgg(2)
				arg1:tweenInputButton(any_new_result1_upvr_3, "up")
				return
			end
			if arg1_4.KeyCode == Enum.KeyCode.T or arg1_4.KeyCode == Enum.KeyCode.ButtonX then
				arg1:openEgg(2, true)
				arg1:tweenInputButton(any_new_result1_upvr, "up")
			end
		end
	end)
end
function any_CreateController_result1.isAutoHatchingOnJoin(arg1)
	if _G.isTradingPlaza then return end
	local data = var4_upvw:getData()
	if not data or not data.autoHatching or data.autoHatching == "" then return end
	arg1:teleportToEgg(data.autoHatching)
end
function any_CreateController_result1.getEggModel(arg1, arg2) -- Line 563
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	for _, v_2 in CollectionService_upvr:GetTagged("Egg") do
		if v_2.Name == arg2 then
			return v_2
		end
	end
end
function any_CreateController_result1.teleportToEgg(arg1, arg2) -- Line 573
	--[[ Upvalues[2]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local any_getEggModel_result1 = arg1:getEggModel(arg2)
	if not any_getEggModel_result1 then warn("[EggController] Egg model not found for:", arg2) return end
	var13_upvw.print("RequestStreamAroundAsync...")
	LocalPlayer_upvr:RequestStreamAroundAsync(any_getEggModel_result1:GetPivot().Position)
	var13_upvw.print("Teleportera!")
	local PrimaryPart = any_getEggModel_result1:FindFirstChild("Egg").PrimaryPart
	if PrimaryPart then
		var13_upvw.getHRP(LocalPlayer_upvr):PivotTo(PrimaryPart.CFrame + PrimaryPart.CFrame.LookVector * 6)
	else
		var13_upvw.getHRP(LocalPlayer_upvr):PivotTo(any_getEggModel_result1:GetPivot() - Vector3.new(3, 4, 0))
		var13_upvw.print("Laddade inte")
	end
	task.wait(1)
	if arg1._currentEgg == "" then
	else
		arg1:autoHatch(2)
	end
end
function any_CreateController_result1.getBestEgg(arg1) -- Line 599
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var18_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local var142 = var18_upvw[#any_getData_result1.maps]
	if var142.getBestEgg then
		return var142.getBestEgg(any_getData_result1)
	end
	return var142.name
end
function any_CreateController_result1.getLuckyEggPosition(arg1, arg2, arg3) -- Line 611
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.RespectCanCollide = true
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterDescendantsInstances = {LocalPlayer_upvr.Character, workspace.Debris}
	local cframe = CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
	local workspace_Raycast_result1 = workspace:Raycast(arg3, Vector3.new(-0, -10, -0), RaycastParams_new_result1)
	if workspace_Raycast_result1 then
		return CFrame.new(workspace_Raycast_result1.Position) * cframe + Vector3.new(0, arg2.PrimaryPart.Size.Y / 2, 0)
	end
	return CFrame.new(arg3) * cframe
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.spawnLuckyEgg(arg1, arg2, arg3) -- Line 627
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: var13_upvw (read and write)
	]]
	local clone_upvr = Assets_upvr.Other.LuckyEgg:Clone()
	local spawnedAt_upvr = arg3.spawnedAt
	local position = arg3.position
	local class_BillboardGui_upvr = clone_upvr.PrimaryPart:FindFirstChildWhichIsA("BillboardGui")
	class_BillboardGui_upvr.Holder.Spawned.Text = `Spawned by @{arg3.username}`
	clone_upvr:PivotTo(arg1:getLuckyEggPosition(clone_upvr, Vector3.new(position.x, position.y, position.z)))
	clone_upvr:SetAttribute("luckyEggId", arg2)
	clone_upvr:AddTag("Egg")
	clone_upvr.Name = arg1:getBestEgg()
	clone_upvr.Parent = workspace.Debris
	arg1._luckyEggs[arg2] = true
	local var153_upvr = workspace:GetServerTimeNow() - spawnedAt_upvr
	task.spawn(function() -- Line 652
		--[[ Upvalues[7]:
			[1]: var153_upvr (readonly)
			[2]: class_BillboardGui_upvr (readonly)
			[3]: var13_upvw (copied, read and write)
			[4]: spawnedAt_upvr (readonly)
			[5]: arg1 (readonly)
			[6]: arg2 (readonly)
			[7]: clone_upvr (readonly)
		]]
		for _ = 1, 900 - var153_upvr do
			class_BillboardGui_upvr.Holder.Timer.Text = `Remaining: {var13_upvw.formatTime(spawnedAt_upvr - os.time() + 900)}`
			task.wait(1)
		end
		arg1._luckyEggs[arg2] = nil
		clone_upvr:Destroy()
	end)
	var13_upvw.print(`Spawn lucky egg (luckyEggId: {arg2})`)
end
function any_CreateController_result1.globalLuckyEggsChanged(arg1, arg2) -- Line 665
	local luckyEggId = arg2.luckyEggId
	if not luckyEggId then
	else
		if arg1._luckyEggs[luckyEggId] then return end
		arg1:spawnLuckyEgg(luckyEggId, arg2)
	end
end
function any_CreateController_result1.onSet(arg1) -- Line 678
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"index"}, function() -- Line 679
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateView()
	end)
	var4_upvw.replica:OnSet({"mapQuests"}, function() -- Line 682
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateView()
	end)
	var4_upvw.replica:OnSet({"clicks"}, function() -- Line 685
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateButtons()
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 690
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
	]]
	task.spawn(function() -- Line 691
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var9_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:view()
		arg1:inputs()
		arg1.currentEggChanged:Connect(function() -- Line 697
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:updateView()
		end)
		arg1:isAutoHatchingOnJoin()
		var9_upvw.globalLuckyEggs:Observe(function(...) -- Line 703
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:globalLuckyEggsChanged(...)
		end)
	end)
	var9_upvw.globalLuckEventAmount:Observe(function(arg1_5) -- Line 708
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1._globalLuckEventAmount = arg1_5
	end)
end
local var166_upvw
local var167_upvw
local var168_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 713
	--[[ Upvalues[20]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var166_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var13_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var14_upvw (read and write)
		[12]: var167_upvw (read and write)
		[13]: var168_upvw (read and write)
		[14]: var15_upvw (read and write)
		[15]: var16_upvw (read and write)
		[16]: var17_upvw (read and write)
		[17]: var18_upvw (read and write)
		[18]: var19_upvw (read and write)
		[19]: var20_upvw (read and write)
		[20]: var21_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("EggService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var166_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("HatchingController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("FFlagController") or { getFFlag = function() return true end }
	var8_upvw = Knit_upvr.GetController("AuraController")
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var167_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var168_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Eggs)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Pets)
	var17_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var18_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
	var19_upvw = require(Knit_upvr.Modules.Button)
	var20_upvw = require(ReplicatedStorage_upvr.Packages.Input).PreferredInput
	var21_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Tiers)
	arg1.currentEggChanged = var168_upvw.new()
end
return any_CreateController_result1