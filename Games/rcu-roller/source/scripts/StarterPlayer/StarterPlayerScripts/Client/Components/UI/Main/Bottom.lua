-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:37
-- Luau version 6, Types version 3
-- Time taken: 0.002020 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Bottom";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local Bottom = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Bottom")
local Mounts_upvr = Bottom:WaitForChild("Mounts")
function any_new_result1.update(arg1) -- Line 40
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: Mounts_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local any_getItemFromId_result1 = var9_upvw.itemUtils.getItemFromId(any_getData_result1, any_getData_result1.equippedMount)
	if not any_getItemFromId_result1 then
		Mounts_upvr.Icon.Size = UDim2.fromScale(0.952, 0.952)
	else
		Mounts_upvr.Icon.Size = UDim2.fromScale(1, 1)
		Mounts_upvr.Icon.Image = any_getItemFromId_result1:getIcon()
	end
end
local Click_upvr = Bottom:WaitForChild("Click")
local Auto_upvr = Bottom:WaitForChild("Auto")
function any_new_result1.buttons(arg1) -- Line 53
	--[[ Upvalues[8]:
		[1]: var10_upvw (read and write)
		[2]: Click_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: Auto_upvr (readonly)
		[6]: var7_upvw (read and write)
		[7]: Mounts_upvr (readonly)
		[8]: var6_upvw (read and write)
	]]
	var10_upvw.new(Click_upvr):buttonUp(function() -- Line 55
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: var8_upvw (copied, read and write)
		]]
		if not var5_upvw:canClick() then
		else
			var5_upvw:setLastClickType(1)
			var5_upvw:setDebounce()
			var8_upvw.click:Fire()
		end
	end)
	local any_new_result1_2 = var10_upvw.new(Auto_upvr, Auto_upvr.Click, {
		disableEnter = true;
	})
	any_new_result1_2:buttonUp(function() -- Line 67
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:setAutoClicker(not var5_upvw:getAutoClicker())
	end)
	any_new_result1_2:buttonEnter(function() -- Line 70
		--[[ Upvalues[1]:
			[1]: var7_upvw (copied, read and write)
		]]
		var7_upvw:preloadSounds({"Auto Clicker On"})
	end)
	var10_upvw.new(Mounts_upvr):buttonUp(function() -- Line 75
		--[[ Upvalues[1]:
			[1]: var6_upvw (copied, read and write)
		]]
		var6_upvw:toggleMount()
	end)
end
function any_new_result1.onSet(arg1) -- Line 80
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"equippedMount"}, function() -- Line 81
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 86
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	task.spawn(function() -- Line 89
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:update()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 96
	--[[ Upvalues[9]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
	]]
	var8_upvw = Knit_upvr.GetService("ClickService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("ClickController")
	var6_upvw = Knit_upvr.GetController("MountController")
	var7_upvw = Knit_upvr.GetController("SoundController")
	var10_upvw = require(script.Parent.Parent.Parent.Parent.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1