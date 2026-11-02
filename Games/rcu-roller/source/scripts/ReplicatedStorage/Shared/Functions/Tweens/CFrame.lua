-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:32
-- Luau version 6, Types version 3
-- Time taken: 0.001305 seconds

local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
return function(arg1, arg2) -- Line 13
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	local CFrameValue_upvr = Instance.new("CFrameValue")
	CFrameValue_upvr.Value = arg2.initialCFrame
	local easingStyle = arg2.easingStyle
	if not easingStyle then
		easingStyle = Enum.EasingStyle.Quad
	end
	local easingDirection = arg2.easingDirection
	if not easingDirection then
		easingDirection = Enum.EasingDirection.Out
	end
	TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(arg2.time or 1, easingStyle, easingDirection), {
		Value = arg2.finalCFrame;
	}):Play()
	local any_Connect_result1_upvr = RunService_upvr.RenderStepped:Connect(function() -- Line 22
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: CFrameValue_upvr (readonly)
		]]
		arg1:PivotTo(CFrameValue_upvr.Value)
	end)
	task.delay(arg2.time, function() -- Line 26
		--[[ Upvalues[2]:
			[1]: any_Connect_result1_upvr (readonly)
			[2]: CFrameValue_upvr (readonly)
		]]
		any_Connect_result1_upvr:Disconnect()
		CFrameValue_upvr:Destroy()
	end)
end