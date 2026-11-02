-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:58
-- Luau version 6, Types version 3
-- Time taken: 0.001678 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "LikeBoard";
})
local var4_upvw
local var5_upvw
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
function any_new_result1.update(arg1, arg2) -- Line 36
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local var8 = math.floor(arg2 / 1000) * 1000
	local var9 = (math.floor(arg2 / 1000) + 1) * 1000
	arg1.Instance.Progress.Frame.Counter.Text = `{Functions_upvr.comma(arg2)}/{Functions_upvr.comma(var9)}`
	arg1.Instance.Progress.Frame.Bar.Actual.Frame.Size = UDim2.new((arg2 - var8) / (var9 - var8), 0, 1, 0)
end
local Trove_upvr = require(ReplicatedStorage.Packages.Trove)
function any_new_result1.Start(arg1) -- Line 44
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Trove_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 45
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: Trove_upvr (copied, readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1._trove = Trove_upvr.new()
		arg1._trove:Add(var5_upvw.votes:Observe(function(...) -- Line 50
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update(...)
		end))
	end)
end
function any_new_result1.Stop(arg1) -- Line 58
	arg1._trove:Destroy()
end
local var13_upvw
local var14_upvw
function any_new_result1.Construct(arg1) -- Line 62
	--[[ Upvalues[5]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var13_upvw (read and write)
		[5]: var14_upvw (read and write)
	]]
	var5_upvw = Knit_upvr.GetService("APIService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var13_upvw = Knit_upvr.GetController("UIController")
	var14_upvw = Knit_upvr.GetController("SoundController")
end
return any_new_result1