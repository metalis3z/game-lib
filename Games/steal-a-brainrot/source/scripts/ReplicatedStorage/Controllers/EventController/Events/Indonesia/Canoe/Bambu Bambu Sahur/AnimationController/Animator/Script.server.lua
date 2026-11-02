-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-03-18 09:14:02
-- Luau version 6, Types version 3
-- Time taken: 0.001731 seconds

local any_LoadAnimation_result1_upvr = script.Parent:LoadAnimation(script.BambuDance)
any_LoadAnimation_result1_upvr:Play()
any_LoadAnimation_result1_upvr.Looped = true
local IndonesiaEvent_upvr = workspace:WaitForChild("Sounds"):WaitForChild("IndonesiaEvent")
local any_Connect_result1_upvw = game:GetService("RunService").Heartbeat:Connect(function() -- Line 13, Named "updateAnimation"
	--[[ Upvalues[2]:
		[1]: IndonesiaEvent_upvr (readonly)
		[2]: any_LoadAnimation_result1_upvr (readonly)
	]]
	if script:IsDescendantOf(workspace) then
		any_LoadAnimation_result1_upvr:AdjustSpeed(math.clamp(IndonesiaEvent_upvr.PlaybackLoudness / 1000, 0, 1) * 0.7 + 1.3)
	else
		any_LoadAnimation_result1_upvr:AdjustSpeed(0)
	end
end)
script.Destroying:Connect(function() -- Line 33
	--[[ Upvalues[1]:
		[1]: any_Connect_result1_upvw (read and write)
	]]
	if any_Connect_result1_upvw then
		any_Connect_result1_upvw:Disconnect()
	end
end)