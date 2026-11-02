-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:49
-- Luau version 6, Types version 3
-- Time taken: 0.005539 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "FarmingMachineFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Displays = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("FarmingMachineFrame"):WaitForChild("Displays")
local Main_upvr = Displays:WaitForChild("Main")
local Farm_upvr = Displays:WaitForChild("Farm")
local Holder_upvr = Farm_upvr:WaitForChild("List"):WaitForChild("Holder")
local Holder_upvr_2 = Main_upvr:WaitForChild("List"):WaitForChild("Holder")
local Side_upvr = Main_upvr:WaitForChild("Canvas"):WaitForChild("Side")
local Assets_upvr = ReplicatedStorage_upvr.Assets
local CurrentCamera_upvr = workspace.CurrentCamera
function any_new_result1.createUpgrades(arg1, arg2) -- Line 58
	--[[ Upvalues[9]:
		[1]: var12_upvw (read and write)
		[2]: Assets_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: Holder_upvr (readonly)
		[5]: var10_upvw (read and write)
		[6]: var4_upvw (read and write)
		[7]: var5_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var6_upvw (read and write)
	]]
	for i, v in var12_upvw[arg2].upgrades do
		local clone = Assets_upvr.UI.FarmUpgrade:Clone()
		clone.UpgradeIcon.Image = var12_upvw[arg2].farmIcon
		clone.UIGradient.Color = var12_upvw[arg2].farmBackgroundColor
		clone.UpgradeCount.Text = i
		clone.UpgradeName.Text = v.title
		clone.UpgradeDescription.Text = v.description
		clone.Buy.GemsPrice.Label.Text = var11_upvw.suffixes(v.price)
		clone:SetAttribute("isUpgrade", true)
		clone.Name = i
		clone.Visible = true
		clone.Parent = Holder_upvr
		var10_upvw.new(clone.Buy):buttonUp(function() -- Line 77
			--[[ Upvalues[7]:
				[1]: var4_upvw (copied, read and write)
				[2]: arg2 (readonly)
				[3]: var12_upvw (copied, read and write)
				[4]: var5_upvw (copied, read and write)
				[5]: var11_upvw (copied, read and write)
				[6]: var7_upvw (copied, read and write)
				[7]: var6_upvw (copied, read and write)
			]]
			local any_getData_result1 = var4_upvw:getData()
			local var29 = any_getData_result1.farms[arg2]
			if not var29 then
				var29 = {}
			end
			local var30 = var12_upvw[arg2].upgrades[(var29.stage or 0) + 1]
			if any_getData_result1.gems < var30.price then
				var5_upvw:createMessagePopup({
					message = `You need {var11_upvw.suffixes(var30.price - any_getData_result1.gems)} more gems to buy this upgrade!`;
					reOpen = "FarmingMachineFrame";
				})
			elseif var7_upvw:upgrade(arg2) == "success" then
				var6_upvw:play("Upgrade")
			end
		end)
	end
end
function any_new_result1.removeUpgrades(arg1) -- Line 102
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_2 in Holder_upvr:GetChildren() do
		if v_2:GetAttribute("isUpgrade") then
			v_2:Destroy()
		end
	end
end
function any_new_result1.toggleDisplay(arg1, arg2) -- Line 110
	--[[ Upvalues[3]:
		[1]: Holder_upvr (readonly)
		[2]: Main_upvr (readonly)
		[3]: Farm_upvr (readonly)
	]]
	local zero = Vector2.zero
	Holder_upvr.CanvasPosition = zero
	if arg2 ~= "main" then
		zero = false
	else
		zero = true
	end
	Main_upvr.Visible = zero
	if arg2 ~= "farm" then
		zero = false
	else
		zero = true
	end
	Farm_upvr.Visible = zero
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_new_result1.addBeam(arg1, arg2) -- Line 117
	--[[ Upvalues[4]:
		[1]: CollectionService_upvr (readonly)
		[2]: Assets_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var11_upvw (read and write)
	]]
	for _, v_3_upvr in CollectionService_upvr:GetTagged("Farm") do
		if v_3_upvr:GetAttribute("farmId") == arg2 then
			local clone_upvr = Assets_upvr.Other.TutorialBeam:Clone()
			clone_upvr.Parent = LocalPlayer_upvr.Character.PrimaryPart
			local Attachment_upvr_2 = Instance.new("Attachment", LocalPlayer_upvr.Character.PrimaryPart)
			local Attachment_upvr = Instance.new("Attachment", v_3_upvr.Proximity)
			clone_upvr.Attachment0 = Attachment_upvr
			clone_upvr.Attachment1 = Attachment_upvr_2
			task.spawn(function() -- Line 132
				--[[ Upvalues[6]:
					[1]: var11_upvw (copied, read and write)
					[2]: LocalPlayer_upvr (copied, readonly)
					[3]: v_3_upvr (readonly)
					[4]: clone_upvr (readonly)
					[5]: Attachment_upvr_2 (readonly)
					[6]: Attachment_upvr (readonly)
				]]
				repeat
					task.wait(0.25)
					local any_getHRP_result1 = var11_upvw.getHRP(LocalPlayer_upvr)
					if not any_getHRP_result1 then
					end
				until (any_getHRP_result1.Position - v_3_upvr.Proximity.Position).Magnitude < 10
				clone_upvr:Destroy()
				Attachment_upvr_2:Destroy()
				Attachment_upvr:Destroy()
			end)
		end
	end
end
function any_new_result1.setupFrames(arg1) -- Line 149
	--[[ Upvalues[8]:
		[1]: var12_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Holder_upvr_2 (readonly)
		[4]: var10_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var6_upvw (read and write)
	]]
	for i_4_upvr, v_4_upvr in var12_upvw do
		if not v_4_upvr.isNotFarm then
			local var51 = Holder_upvr_2[var11_upvw.toPascal(i_4_upvr)]
			var10_upvw.new(var51.Buy):buttonUp(function() -- Line 158
				--[[ Upvalues[8]:
					[1]: var4_upvw (copied, read and write)
					[2]: v_4_upvr (readonly)
					[3]: var5_upvw (copied, read and write)
					[4]: var11_upvw (copied, read and write)
					[5]: var7_upvw (copied, read and write)
					[6]: i_4_upvr (readonly)
					[7]: var6_upvw (copied, read and write)
					[8]: arg1 (readonly)
				]]
				local data = var4_upvw.data
				if data.gems < v_4_upvr.price then
					var5_upvw:createMessagePopup({
						message = `You need {var11_upvw.suffixes(v_4_upvr.price - data.gems)} more gems to buy this farm!`;
						reOpen = "FarmingMachineFrame";
					})
				elseif var7_upvw:buy(i_4_upvr) == "success" then
					var6_upvw:play("Upgrade")
					arg1:addBeam(i_4_upvr)
				end
			end)
			var10_upvw.new(var51.Upgrade):buttonUp(function() -- Line 177
				--[[ Upvalues[3]:
					[1]: var4_upvw (copied, read and write)
					[2]: i_4_upvr (readonly)
					[3]: arg1 (readonly)
				]]
				if not var4_upvw.data.farms[i_4_upvr] then
				else
					arg1._currentFarmId = i_4_upvr
					arg1:createUpgrades(i_4_upvr)
					arg1:updateUpgrades(i_4_upvr)
					arg1:toggleDisplay("farm")
				end
			end)
		end
	end
end
function any_new_result1.updateUpgrades(arg1) -- Line 193
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: CurrentCamera_upvr (readonly)
	]]
	-- CF ANALYSIS FAILED stub: update buy button states for all upgrade frames
	local _currentFarmId = arg1._currentFarmId
	if not _currentFarmId then return end
	local farmData = var4_upvw.data.farms[_currentFarmId]
	local currentStage = (farmData and farmData.stage) or 0
	for _, v in Holder_upvr:GetChildren() do
		if v:GetAttribute("isUpgrade") then
			local upgradeIndex = tonumber(v.Name)
			if upgradeIndex then
				v.Buy.Visible = upgradeIndex == currentStage + 1
			end
		end
	end
end
function any_new_result1.updateFarms(arg1) -- Line 224
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var11_upvw (read and write)
		[4]: Holder_upvr_2 (readonly)
		[5]: var13_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: Side_upvr (readonly)
		[8]: CurrentCamera_upvr (readonly)
	]]
	-- CF ANALYSIS FAILED stub: update farm frame states based on player data
	local data = var4_upvw.data
	for i_4_upvr, v_4_upvr in var12_upvw do
		if not v_4_upvr.isNotFarm then
			local var51 = Holder_upvr_2:FindFirstChild(var11_upvw.toPascal(i_4_upvr))
			if var51 then
				local owned = data.farms and data.farms[i_4_upvr] ~= nil
				var51.Buy.Visible = not owned
				var51.Upgrade.Visible = owned
				if owned then
					local farmData = data.farms[i_4_upvr]
					local stage = (farmData and farmData.stage) or 0
					local upgradeData = v_4_upvr.upgrades[stage + 1]
					if upgradeData then
						var51.Upgrade.GemsPrice.Label.Text = var11_upvw.suffixes(upgradeData.price)
					else
						var51.Upgrade.Visible = false
					end
				end
			end
		end
	end
end
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function any_new_result1.buttons(arg1) -- Line 264
	--[[ Upvalues[8]:
		[1]: var10_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: MarketplaceService_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var14_upvw (read and write)
		[8]: var8_upvw (read and write)
	]]
	var10_upvw.new(Side_upvr.Upgrade):buttonUp(function() -- Line 266
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1._currentFarmId = "farmer"
		arg1:createUpgrades("farmer")
		arg1:updateUpgrades()
		arg1:toggleDisplay("farm")
	end)
	local any_new_result1_upvr = var10_upvw.new(Holder_upvr.Special.InsaneFarmer.Buy)
	any_new_result1_upvr:buttonUp(function() -- Line 276
		--[[ Upvalues[6]:
			[1]: any_new_result1_upvr (readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: MarketplaceService_upvr (copied, readonly)
			[4]: LocalPlayer_upvr (copied, readonly)
			[5]: var14_upvw (copied, read and write)
			[6]: var8_upvw (copied, read and write)
		]]
		any_new_result1_upvr:setToOriginalSize()
		var5_upvw:setToIsPurchasing()
		MarketplaceService_upvr:PromptGamePassPurchase(LocalPlayer_upvr, var14_upvw.insaneFarmer.gamePassId)
		var8_upvw.setLocation:Fire(4, 2)
	end)
end
function any_new_result1.valuesChanged(arg1) -- Line 284
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"farms"}, function(arg1_2) -- Line 285
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateFarms()
		arg1:updateUpgrades()
	end)
end
function any_new_result1.opened(arg1) -- Line 291
	arg1:toggleDisplay("main")
	arg1:updateFarms()
	arg1:removeUpgrades()
end
function any_new_result1.Start(arg1) -- Line 298
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: Farm_upvr (readonly)
	]]
	arg1:buttons()
	arg1:setupFrames()
	arg1:valuesChanged()
	arg1:opened()
	var5_upvw:listenToOpen("FarmingMachineFrame"):Connect(function() -- Line 304
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	Farm_upvr:GetPropertyChangedSignal("Visible"):Connect(function() -- Line 308
		--[[ Upvalues[2]:
			[1]: Farm_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		if Farm_upvr.Visible then
		else
			arg1:removeUpgrades()
		end
	end)
end
function any_new_result1.Construct(arg1) -- Line 316
	--[[ Upvalues[12]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: var11_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var12_upvw (read and write)
		[11]: var13_upvw (read and write)
		[12]: var14_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("FarmService")
	var8_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Farms)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
end
return any_new_result1