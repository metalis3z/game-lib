-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:03
-- Luau version 6, Types version 3
-- Time taken: 0.001451 seconds

local any_new_result1 = require(require(game:GetService("ReplicatedStorage").Packages.Knit).Util.Component).new({
	Tag = "TutelBlink";
})
local TweenService_upvr = game:GetService("TweenService")
local var4_upvw
local TweenInfo_new_result1_upvr = TweenInfo.new(0.05)
function any_new_result1.close(arg1) -- Line 32
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: TweenInfo_new_result1_upvr (readonly)
	]]
	TweenService_upvr:Create(arg1.Instance, TweenInfo_new_result1_upvr, {
		Size = Vector3.new(arg1._size.X, 0, arg1._size.Y);
	}):Play()
end
local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.25)
function any_new_result1.open(arg1) -- Line 37
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: TweenInfo_new_result1_upvr_2 (readonly)
	]]
	TweenService_upvr:Create(arg1.Instance, TweenInfo_new_result1_upvr_2, {
		Size = Vector3.new(arg1._size.X, arg1._size.Y, arg1._size.Y);
	}):Play()
end
local random_state_upvr = Random.new()
function any_new_result1.run(arg1) -- Line 42
	--[[ Upvalues[1]:
		[1]: random_state_upvr (readonly)
	]]
	arg1._trove:Add(task.spawn(function() -- Line 43
		--[[ Upvalues[2]:
			[1]: random_state_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		while task.wait(random_state_upvr:NextNumber(0.3, 5)) do
			arg1:close()
			task.wait(0.05)
			arg1:open()
		end
	end))
end
function any_new_result1.Start(arg1) -- Line 54
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1._trove = var4_upvw.new()
	arg1:run()
end
function any_new_result1.Stop(arg1) -- Line 60
	arg1._trove:Destroy()
end
local var11_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 64
	--[[ Upvalues[3]:
		[1]: var11_upvw (read and write)
		[2]: ReplicatedStorage_upvr (readonly)
		[3]: var4_upvw (read and write)
	]]
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var4_upvw = require(ReplicatedStorage_upvr.Packages.Trove)
	arg1._size = arg1.Instance.Size
end
return any_new_result1