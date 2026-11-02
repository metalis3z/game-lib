-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:39
-- Luau version 6, Types version 3
-- Time taken: 0.000498 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1, arg2) -- Line 14
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	TweenService_upvr:Create(arg1, TweenInfo.new(arg2 or 6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
		Rotation = 360;
	}):Play()
end