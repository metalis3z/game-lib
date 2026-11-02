-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:43
-- Luau version 6, Types version 3
-- Time taken: 0.001296 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Actions";
})
local var4_upvw
local var5_upvw
local var6_upvw
local Actions_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Actions")
function any_new_result1.buttons(arg1) -- Line 35
	--[[ Upvalues[3]:
		[1]: var6_upvw (read and write)
		[2]: Actions_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	var6_upvw.new(Actions_upvr.StopAutoRoll):buttonUp(function() -- Line 37
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: Actions_upvr (copied, readonly)
		]]
		var5_upvw:setIsAutoRolling(false)
		Actions_upvr.StopAutoRoll.Visible = false
	end)
end
function any_new_result1.Start(arg1) -- Line 43
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	task.spawn(function() -- Line 46
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		repeat
			task.wait()
		until var4_upvw.data
	end)
end
local var10_upvw
local var11_upvw
local var12_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 52
	--[[ Upvalues[8]:
		[1]: var10_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var11_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var12_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
	]]
	var10_upvw = Knit_upvr.GetService("ClickService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var11_upvw = Knit_upvr.GetController("ClickController")
	var5_upvw = Knit_upvr.GetController("AuraController")
	var6_upvw = require(script.Parent.Parent.Parent.Parent.Modules.Button)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1