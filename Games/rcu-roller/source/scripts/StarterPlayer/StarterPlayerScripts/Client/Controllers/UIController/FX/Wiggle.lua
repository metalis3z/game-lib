-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:44
-- Luau version 6, Types version 3
-- Time taken: 0.001201 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1, arg2) -- Line 14
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local var4_upvr
	if not var4_upvr then
		var4_upvr = {}
	end
	local var5_upvw = var4_upvr
	if var5_upvw.infinite then
		var4_upvr = math.huge
	else
		var4_upvr = 1
	end
	local TweenInfo_new_result1_upvr_2 = TweenInfo.new(var5_upvw.timeIn or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local TweenInfo_new_result1_upvr = TweenInfo.new(var5_upvw.timeOut or 1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
	task.spawn(function() -- Line 22
		--[[ Upvalues[6]:
			[1]: var4_upvr (readonly)
			[2]: TweenService_upvr (copied, readonly)
			[3]: arg1 (readonly)
			[4]: TweenInfo_new_result1_upvr_2 (readonly)
			[5]: TweenInfo_new_result1_upvr (readonly)
			[6]: var5_upvw (read and write)
		]]
		for _ = 1, var4_upvr do
			local any_Create_result1 = TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr_2, {
				Rotation = 3;
			})
			any_Create_result1:Play()
			any_Create_result1.Completed:Wait()
			local any_Create_result1_2 = TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr, {
				Rotation = 0;
			})
			any_Create_result1_2:Play()
			any_Create_result1_2.Completed:Wait()
			task.wait(var5_upvw.timeUntilNext or 0)
		end
	end)
end