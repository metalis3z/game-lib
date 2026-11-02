-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:10
-- Luau version 6, Types version 3
-- Time taken: 0.010586 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "TreeController";
	_selectedTree = nil;
	_currentTree = nil;
	_highlights = {};
	_debounce = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local CollectionService_upvr = game:GetService("CollectionService")
local RunService_upvr = game:GetService("RunService")
local var12_upvw
local var13_upvw
local var14_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local TreeHealth_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Bottom"):WaitForChild("TreeHealth")
local mouse_upvr = LocalPlayer_upvr:GetMouse()
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.updateTreeHealth(arg1) -- Line 56
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: TreeHealth_upvr (readonly)
		[4]: var13_upvw (read and write)
	]]
	if not arg1._selectedTree and not arg1._currentTree then
	else
		local _currentTree = arg1._currentTree
		if not _currentTree then
			_currentTree = arg1._selectedTree
		end
		if not _currentTree then return end
		local groupId_3 = _currentTree:GetAttribute("groupId")
		local var21 = var4_upvw:getData().trees[groupId_3][_currentTree:GetAttribute("treeId")]
		local var22 = var14_upvw[groupId_3].trees[var21.id]
		TreeHealth_upvr.Health.Text = `{var13_upvw.suffixes(var21.hp)}/{var13_upvw.suffixes(var22.hp)}`
		TreeHealth_upvr.Bar:TweenSize(UDim2.fromScale(var21.hp / var22.hp, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
	end
end
function any_CreateController_result1.updateModels(arg1) -- Line 78
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: CollectionService_upvr (readonly)
		[3]: Assets_upvr (readonly)
		[4]: var13_upvw (read and write)
	]]
	local any_getData_result1_3 = var4_upvw:getData()
	for _, v in CollectionService_upvr:GetTagged("Tree") do
		local class_Model_2 = v:FindFirstChildWhichIsA("Model")
		if not class_Model_2 then continue end
		if not class_Model_2:FindFirstChildWhichIsA("BasePart", true) then continue end
		local groupId_4 = v:GetAttribute("groupId")
		if not any_getData_result1_3.trees[groupId_4] then continue end
		local var33 = any_getData_result1_3.trees[groupId_4][v:GetAttribute("treeId")]
		if not var33 then continue end
		local currentId = v:GetAttribute("currentId")
		if not currentId then
			v:SetAttribute("currentId", var33.id)
			if var33.id == 1 then continue end
			currentId = var33.id
		end
		if currentId ~= var33.id then
			local SOME = Assets_upvr.Trees[var13_upvw.toPascal(groupId_4)]:FindFirstChild(var33.id)
			if not SOME then
				SOME = Assets_upvr.Trees[var13_upvw.toPascal(groupId_4)]:FindFirstChildWhichIsA("Model")
			end
			local clone = SOME:Clone()
			clone:PivotTo(class_Model_2:GetPivot())
			clone:ScaleTo(class_Model_2:GetScale())
			clone.Name = var33.id
			class_Model_2:Destroy()
			clone.Parent = v
			v:SetAttribute("currentId", var33.id)
		end
	end
end
function any_CreateController_result1.updateTransparencies(arg1) -- Line 130
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: CollectionService_upvr (readonly)
	]]
	local any_getData_result1_2 = var4_upvw:getData()
	for _, v_2 in CollectionService_upvr:GetTagged("Tree") do
		local class_Model = v_2:FindFirstChildWhichIsA("Model")
		if class_Model then
			local groupId_2 = v_2:GetAttribute("groupId")
			if any_getData_result1_2.trees[groupId_2] then
				local var86 = any_getData_result1_2.trees[groupId_2][v_2:GetAttribute("treeId")]
				if var86 then
					for _, v_3 in class_Model:GetChildren() do
						if v_3:IsA("BasePart") and v_3.Transparency ~= 1 then
							v_3.Transparency = 0
						end
					end
				end
			end
		end
	end
end
function any_CreateController_result1.playCharacterTreeAnimation(arg1) -- Line 168
	--[[ Upvalues[3]:
		[1]: Assets_upvr (readonly)
		[2]: var13_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	LocalPlayer_upvr.Character.Humanoid.Animator:LoadAnimation(Assets_upvr.Animations.Tree):Play()
end
function any_CreateController_result1.stopAnimation(arg1, arg2) -- Line 178
	--[[ Upvalues[2]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	for _, v_4 in var13_upvw.getHumanoid(LocalPlayer_upvr):GetPlayingAnimationTracks() do
		if v_4.Name == arg2 then
			v_4:Stop()
			v_4:Destroy()
		end
	end
end
function any_CreateController_result1.cancelAutoDamageTree(arg1) -- Line 191
	--[[ Upvalues[2]:
		[1]: TreeHealth_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	arg1._currentTree = nil
	arg1._selectedTree = nil
	TreeHealth_upvr.Visible = false
	RunService_upvr:UnbindFromRenderStep("autoDamageTree")
	arg1:stopAnimation("Tree")
end
local random_state_upvr = Random.new()
function any_CreateController_result1.autoDamageTree(arg1) -- Line 201
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: RunService_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: random_state_upvr (readonly)
	]]
	local _currentTree_2_upvr = arg1._currentTree
	if not _currentTree_2_upvr then
	else
		local any_getData_result1_4_upvr = var4_upvw:getData()
		local groupId_upvr = _currentTree_2_upvr:GetAttribute("groupId")
		local treeId_upvr = _currentTree_2_upvr:GetAttribute("treeId")
		RunService_upvr:BindToRenderStep("autoDamageTree", 1, function() -- Line 212
			--[[ Upvalues[8]:
				[1]: any_getData_result1_4_upvr (readonly)
				[2]: groupId_upvr (readonly)
				[3]: treeId_upvr (readonly)
				[4]: arg1 (readonly)
				[5]: _currentTree_2_upvr (readonly)
				[6]: var8_upvw (copied, read and write)
				[7]: var5_upvw (copied, read and write)
				[8]: random_state_upvr (copied, readonly)
			]]
			if any_getData_result1_4_upvr.trees[groupId_upvr][treeId_upvr].hp <= 0 then
				arg1:cancelAutoDamageTree()
			else
				if arg1._debounce[treeId_upvr] then return end
				arg1._debounce[treeId_upvr] = true
				task.delay(1, function() -- Line 224
					--[[ Upvalues[2]:
						[1]: arg1 (copied, readonly)
						[2]: treeId_upvr (copied, readonly)
					]]
					arg1._debounce[treeId_upvr] = nil
				end)
				arg1:playCharacterTreeAnimation()
				task.wait(0.7)
				if arg1._currentTree ~= _currentTree_2_upvr then return end
				var8_upvw.damage2:Fire(groupId_upvr, treeId_upvr)
				var5_upvw:play("Tree Hit", {
					playbackSpeed = random_state_upvr:NextNumber(0.95, 1.1);
				})
			end
		end)
	end
end
function any_CreateController_result1.moveToTree(arg1, arg2) -- Line 244
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TreeHealth_upvr (readonly)
		[5]: var7_upvw (read and write)
	]]
	local class_Model_3 = arg2:FindFirstChildWhichIsA("Model")
	if not class_Model_3 then
	else
		local any_getHumanoid_result1_2 = var13_upvw.getHumanoid(LocalPlayer_upvr)
		local any_getHRP_result1 = var13_upvw.getHRP(LocalPlayer_upvr)
		if not any_getHumanoid_result1_2 then return end
		local Position = any_getHRP_result1.Position
		local PrimaryPart = class_Model_3.PrimaryPart
		local Position_2 = PrimaryPart.Position
		if arg1._selectedTree == arg2 or arg1._currentTree == arg2 then return end
		if arg1._currentTree then
			arg1:cancelAutoDamageTree()
		end
		arg1._selectedTree = arg2
		TreeHealth_upvr.Visible = true
		if ((Position) - (Position_2 - Vector3.new(0, any_getHumanoid_result1_2.HipHeight + -Position.Y, 0))).Magnitude <= 6 then
			arg1._currentTree = arg2
			arg1:autoDamageTree()
			return
		end
		if var4_upvw:getData().isMountEquipped then
			var7_upvw:toggleMount()
		end
		any_getHumanoid_result1_2:MoveTo(Position_2 - (Position_2 - Position).Unit * 5 - Vector3.new(0, PrimaryPart.Size.Y / 2, 0) + Vector3.new(0, any_getHRP_result1.Size.Y, 0))
	end
end
function any_CreateController_result1.getTreeFromRayResult(arg1, arg2) -- Line 293
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	local any_getParentUntilFolder_result1 = var13_upvw.getParentUntilFolder(arg2)
	if not any_getParentUntilFolder_result1 then return end
	if not table.find(any_getParentUntilFolder_result1:GetTags(), "Tree") then return end
	return any_getParentUntilFolder_result1
end
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.getRay(arg1, arg2, arg3) -- Line 307
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvr (readonly)
	]]
	local any_ScreenPointToRay_result1 = CurrentCamera_upvr:ScreenPointToRay(arg2, arg3, 0)
	local workspace_FindPartOnRayWithIgnoreList_result1, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(any_ScreenPointToRay_result1.Origin, any_ScreenPointToRay_result1.Direction * 200), {})
	return workspace_FindPartOnRayWithIgnoreList_result1
end
function any_CreateController_result1.removeHighlights(arg1) -- Line 316
	for _, v_5 in arg1._highlights do
		v_5:Destroy()
	end
end
function any_CreateController_result1.createHoverHighlight(arg1, arg2) -- Line 322
	local class_Model_4 = arg2:FindFirstChildWhichIsA("Model")
	if not class_Model_4 then
	else
		if class_Model_4:FindFirstChildWhichIsA("Highlight") then return end
		arg1:removeHighlights()
		local Highlight = Instance.new("Highlight")
		Highlight.Name = "_highlight"
		Highlight.Parent = class_Model_4
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		Highlight.FillColor = Color3.fromRGB(255, 255, 255)
		Highlight.FillTransparency = 0.6
		Highlight.OutlineTransparency = 1
		arg1._highlights[#arg1._highlights + 1] = Highlight
	end
end
function any_CreateController_result1.setMouseIcon(arg1, arg2) -- Line 346
	--[[ Upvalues[1]:
		[1]: mouse_upvr (readonly)
	]]
	local var119
	if arg2 then
		var119 = "rbxassetid://11273739555"
	else
		var119 = ""
	end
	mouse_upvr.Icon = var119
end
function any_CreateController_result1.hoverOnTree(arg1) -- Line 350
	--[[ Upvalues[2]:
		[1]: RunService_upvr (readonly)
		[2]: mouse_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep("hoverOnTree", 1, function() -- Line 351
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: mouse_upvr (copied, readonly)
		]]
		local any_getRay_result1_2 = arg1:getRay(mouse_upvr.X, mouse_upvr.Y)
		if not any_getRay_result1_2 then
		else
			local any_getTreeFromRayResult_result1 = arg1:getTreeFromRayResult(any_getRay_result1_2)
			if not any_getTreeFromRayResult_result1 then
				arg1:removeHighlights()
				arg1:setMouseIcon()
				return
			end
			arg1:createHoverHighlight(any_getTreeFromRayResult_result1)
			arg1:setMouseIcon(any_getTreeFromRayResult_result1)
		end
	end)
end
function any_CreateController_result1.getCurrentAxe(arg1) -- Line 370
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	for i_6, v_6 in var4_upvw:getData().inventory.exclusive do
		local any_createItemFromData_result1 = var12_upvw.itemUtils.createItemFromData(v_6)
		if any_createItemFromData_result1:getName():lower():find("axe") then
			return i_6, any_createItemFromData_result1:directory()[any_createItemFromData_result1:getName()].index
		end
	end
end
function any_CreateController_result1.isStrongEnough(arg1, arg2) -- Line 384
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if not arg2 then
		return true
	end
	local groupId = arg2:GetAttribute("groupId")
	if not groupId then
		return true
	end
	local any_getCurrentAxe_result1, any_getCurrentAxe_result2 = arg1:getCurrentAxe()
	if not any_getCurrentAxe_result1 then
		return true
	end
	if groupId == "kingdom" and any_getCurrentAxe_result2 == 1 then return end
	return true
end
function any_CreateController_result1.sendRayFromInput(arg1, arg2, arg3) -- Line 408
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	local any_getRay_result1 = arg1:getRay(arg2, arg3)
	if not any_getRay_result1 then
	else
		local any_getTreeFromRayResult_result1_2 = arg1:getTreeFromRayResult(any_getRay_result1)
		if not any_getTreeFromRayResult_result1_2 then return end
		if var4_upvw:getData().trees[any_getTreeFromRayResult_result1_2:GetAttribute("groupId")][any_getTreeFromRayResult_result1_2:GetAttribute("treeId")].hp <= 0 then return end
		if not arg1:isStrongEnough(any_getTreeFromRayResult_result1_2) then
			var6_upvw:createMessagePopup({
				message = "Your axe is too weak for this tree! Go to spawn and get wood to upgrade your axe!";
			})
			return
		end
		arg1:moveToTree(any_getTreeFromRayResult_result1_2)
		arg1:updateTreeHealth()
	end
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_CreateController_result1.onInput(arg1) -- Line 440
	--[[ Upvalues[3]:
		[1]: UserInputService_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	UserInputService_upvr.InputEnded:Connect(function(arg1_2, arg2) -- Line 441
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: LocalPlayer_upvr (copied, readonly)
		]]
		if not var4_upvw:getData().isAxeEquipped then
		else
			if arg2 then return end
			local UserInputType = arg1_2.UserInputType
			if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
				arg1:sendRayFromInput(arg1_2.Position.X, arg1_2.Position.Y)
				return
			end
			if UserInputType == Enum.UserInputType.Gamepad1 and arg1_2.KeyCode == Enum.KeyCode.ButtonR2 then
				local mouse = LocalPlayer_upvr:GetMouse()
				arg1:sendRayFromInput(mouse.X, mouse.Y)
			end
		end
	end)
end
function any_CreateController_result1.toggledAxe(arg1) -- Line 462
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: RunService_upvr (readonly)
	]]
	arg1:updateModels()
	arg1:updateTransparencies()
	if var4_upvw:getData().isAxeEquipped then
		arg1:hoverOnTree()
	else
		RunService_upvr:UnbindFromRenderStep("hoverOnTree")
		if arg1._currentTree then
			arg1:cancelAutoDamageTree()
		end
	end
end
function any_CreateController_result1.valuesChanged(arg1) -- Line 478
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"isAxeEquipped"}, function(arg1_3) -- Line 479
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:toggledAxe()
	end)
	var4_upvw.replica:OnSet({"trees"}, function(arg1_4) -- Line 482
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateModels()
		arg1:updateTransparencies()
		arg1:updateTreeHealth()
	end)
end
function any_CreateController_result1.moveToFinished(arg1) -- Line 489
	--[[ Upvalues[2]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local any_getHumanoid_result1 = var13_upvw.getHumanoid(LocalPlayer_upvr)
	if not any_getHumanoid_result1 then
	else
		any_getHumanoid_result1.MoveToFinished:Connect(function(arg1_5) -- Line 495
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1_5 then
				arg1._currentTree = arg1._selectedTree
				arg1:autoDamageTree()
			end
		end)
	end
end
function any_CreateController_result1.moveDirectionChanged(arg1) -- Line 503
	--[[ Upvalues[3]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: TreeHealth_upvr (readonly)
	]]
	local any_getHumanoid_result1_3 = var13_upvw.getHumanoid(LocalPlayer_upvr)
	if not any_getHumanoid_result1_3 then
	else
		any_getHumanoid_result1_3:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line 509
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: TreeHealth_upvr (copied, readonly)
			]]
			if arg1._currentTree == nil and arg1._selectedTree == nil then
			else
				TreeHealth_upvr.Visible = false
				arg1:cancelAutoDamageTree()
			end
		end)
	end
end
function any_CreateController_result1.characterAdded(arg1, arg2) -- Line 520
	arg2:WaitForChild("Humanoid")
	arg1:moveToFinished()
	arg1:moveDirectionChanged()
end
function any_CreateController_result1.KnitStart(arg1) -- Line 527
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	task.spawn(function() -- Line 528
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		repeat
			task.wait()
		until var4_upvw:getData()
		arg1:onInput()
		arg1:valuesChanged()
		arg1:updateModels()
		arg1:updateTransparencies()
		-- Connect treeFelled: cancel auto-damage if the felled tree is the current one
		var8_upvw.treeFelled:Connect(function(groupId, treeId)
			if arg1._currentTree then
				local cGroupId = arg1._currentTree:GetAttribute("groupId")
				local cTreeId = arg1._currentTree:GetAttribute("treeId")
				if tostring(cGroupId) == tostring(groupId) and tostring(cTreeId) == tostring(treeId) then
					arg1:cancelAutoDamageTree()
				end
			end
			arg1:updateModels()
			arg1:updateTransparencies()
		end)
		-- Connect treeRespawned: refresh visuals when a tree comes back
		var8_upvw.treeRespawned:Connect(function(groupId, treeId)
			arg1:updateModels()
			arg1:updateTransparencies()
		end)
	end)
	if LocalPlayer_upvr.Character then
		arg1:characterAdded(LocalPlayer_upvr.Character)
	end
	LocalPlayer_upvr.CharacterAdded:Connect(function(...) -- Line 540
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:characterAdded(...)
	end)
end
function any_CreateController_result1.KnitInit(arg1) -- Line 545
	--[[ Upvalues[10]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var12_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var13_upvw (read and write)
		[10]: var14_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("TreeService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("MountController")
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Trees)
end
return any_CreateController_result1