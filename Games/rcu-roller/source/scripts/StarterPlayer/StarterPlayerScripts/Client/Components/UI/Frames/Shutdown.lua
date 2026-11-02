-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:31
-- Luau version 6, Types version 3
-- Time taken: 0.001108 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Shutdown";
})
local var4_upvw
local Shutdown_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("Shutdown")
function any_new_result1.shutdown(arg1, arg2) -- Line 36
	--[[ Upvalues[1]:
		[1]: Shutdown_upvr (readonly)
	]]
	Shutdown_upvr.Visible = true
	Shutdown_upvr.Reason.Text = `Reason: {arg2.Name}`
end
function any_new_result1.Start(arg1) -- Line 42
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.shutdown:Connect(function(...) -- Line 43
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:shutdown(...)
	end)
end
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var13_upvw
function any_new_result1.Construct(arg1) -- Line 48
	--[[ Upvalues[9]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: var9_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var13_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetService("PlayerService")
	var7_upvw = Knit_upvr.GetController("DataController")
	var8_upvw = Knit_upvr.GetController("UIController")
	var9_upvw = Knit_upvr.GetController("SoundController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1