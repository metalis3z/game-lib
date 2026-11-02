-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:51
-- Luau version 6, Types version 3
-- Time taken: 0.002765 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Tree";
})
local var4_upvw
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var7_upvw
local Billboards_upvr = ReplicatedStorage_upvr.Assets.Billboards
function any_new_result1.createBillboard(arg1) -- Line 37
	--[[ Upvalues[2]:
		[1]: Knit_upvr (readonly)
		[2]: Billboards_upvr (readonly)
	]]
	local class_Model = arg1.Instance:FindFirstChildWhichIsA("Model")
	repeat
		Knit_upvr.listenToUpdate:Wait()
	until class_Model.PrimaryPart
	Billboards_upvr.TreeRespawn:Clone().Parent = class_Model.PrimaryPart
end
function any_new_result1.update(arg1) -- Line 48
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local var11
	if not any_getData_result1.trees[arg1._groupId] then
	else
		var11 = arg1._groupId
		local var12 = any_getData_result1.trees[var11][arg1._treeId]
		if not var12 then return end
		var11 = "Model"
		local instance = arg1.Instance:FindFirstChildWhichIsA(var11)
		if not instance then return end
		if not instance.PrimaryPart then return end
		local class_BillboardGui = instance.PrimaryPart:FindFirstChildWhichIsA("BillboardGui")
		if not class_BillboardGui then return end
		var11 = any_getData_result1.isAxeEquipped
		if var11 then
			var11 = var12.respawn
		end
		if class_BillboardGui.Enabled ~= var11 then
			class_BillboardGui.Enabled = var11
		end
		if not var11 then return end
		local var15 = var12.respawn - workspace:GetServerTimeNow()
		if 0 < var15 then
			class_BillboardGui.Main.Timer.Text = var7_upvw.formatTime(var15)
		end
	end
end
function any_new_result1.setIds(arg1) -- Line 89
	local Instance = arg1.Instance
	arg1._groupId = Instance:GetAttribute("groupId")
	arg1._treeId = Instance:GetAttribute("treeId")
end
local tick_result1_upvw = tick()
function any_new_result1.onDescendantAdded(arg1) -- Line 95
	--[[ Upvalues[2]:
		[1]: tick_result1_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	arg1.Instance.DescendantAdded:Connect(function(arg1_2) -- Line 96
		--[[ Upvalues[3]:
			[1]: tick_result1_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var5_upvw (copied, read and write)
		]]
		if tick() - tick_result1_upvw < 1 then
		else
			if not arg1_2:IsA("BasePart") then return end
			local PrimaryPart = arg1.Instance:FindFirstChildWhichIsA("Model").PrimaryPart
			if not PrimaryPart then return end
			if PrimaryPart:FindFirstChildWhichIsA("BillboardGui") then return end
			arg1:createBillboard()
			var5_upvw:updateModels()
			var5_upvw:updateTransparencies()
			tick_result1_upvw = tick()
		end
	end)
end
function any_new_result1.onSet(arg1) -- Line 122
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"trees"}, function(arg1_3) -- Line 123
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"isAxeEquipped"}, function(arg1_4) -- Line 126
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 131
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 132
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: Knit_upvr (copied, readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		repeat
			task.wait()
		until var4_upvw:getData()
		arg1:setIds()
		arg1:createBillboard()
		arg1:onDescendantAdded()
		arg1:onSet()
		Knit_upvr.listenToUpdate:Connect(function() -- Line 141
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
		var5_upvw:updateModels()
	end)
end
local var26_upvw
local var27_upvw
local var28_upvw
function any_new_result1.Construct(arg1) -- Line 149
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var26_upvw (read and write)
		[4]: var27_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var28_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var26_upvw = Knit_upvr.GetController("UIController")
	var27_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("TreeController")
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var28_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1