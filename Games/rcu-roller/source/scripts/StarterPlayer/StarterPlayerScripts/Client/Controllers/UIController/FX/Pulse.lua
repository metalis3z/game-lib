-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:40
-- Luau version 6, Types version 3
-- Time taken: 0.000958 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1, arg2) -- Line 14
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local var4 = arg2
	if not var4 then
		var4 = {}
	end
	local var5 = var4
	local TweenInfo_new_result1_upvr = TweenInfo.new(var5.timeIn or 0.66, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local Scale_upvr = arg1.Size.X.Scale
	local Scale_upvr_2 = arg1.Size.Y.Scale
	local TweenInfo_new_result1_upvr_2 = TweenInfo.new(var5.timeOut or 0.66, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	task.spawn(function() -- Line 23
		--[[ Upvalues[6]:
			[1]: TweenService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: TweenInfo_new_result1_upvr (readonly)
			[4]: Scale_upvr (readonly)
			[5]: Scale_upvr_2 (readonly)
			[6]: TweenInfo_new_result1_upvr_2 (readonly)
		]]
		local any_Create_result1_2 = TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr, {
			Size = UDim2.fromScale(Scale_upvr * 1.1, Scale_upvr_2 * 1.1);
		})
		any_Create_result1_2:Play()
		any_Create_result1_2.Completed:Wait()
		local any_Create_result1 = TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr_2, {
			Size = UDim2.fromScale(Scale_upvr, Scale_upvr_2);
		})
		any_Create_result1:Play()
		any_Create_result1.Completed:Wait()
	end)
end