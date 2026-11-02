-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:43
-- Luau version 6, Types version 3
-- Time taken: 0.000977 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1, arg2) -- Line 20
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local var4 = arg2
	if not var4 then
		var4 = {}
	end
	local var5_upvw = var4
	local TweenInfo_new_result1_upvr = TweenInfo.new(var5_upvw.time or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local Position_upvr = arg1.Position
	task.spawn(function() -- Line 27
		--[[ Upvalues[5]:
			[1]: TweenService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: TweenInfo_new_result1_upvr (readonly)
			[4]: Position_upvr (readonly)
			[5]: var5_upvw (read and write)
		]]
		while true do
			TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr, {
				Position = UDim2.fromScale(Position_upvr.X.Scale, Position_upvr.Y.Scale * 1.05);
			}):Play()
			task.wait(var5_upvw.time or 0.5)
			TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr, {
				Position = UDim2.fromScale(Position_upvr.X.Scale, Position_upvr.Y.Scale * 0.95);
			}):Play()
			task.wait(var5_upvw.timeUntilNext or 0.5)
		end
	end)
end