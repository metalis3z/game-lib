-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:01
-- Luau version 6, Types version 3
-- Time taken: 0.001453 seconds

local Parent_upvr = script.Parent
local Event_upvr = Parent_upvr:WaitForChild("Event")
function Equipped(arg1) -- Line 4
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: Event_upvr (readonly)
	]]
	local Humanoid_upvr = Parent_upvr.Parent:FindFirstChild("Humanoid")
	if Humanoid_upvr then
		arg1.KeyDown:connect(function(arg1_2) -- Line 8
			--[[ Upvalues[2]:
				[1]: Event_upvr (copied, readonly)
				[2]: Humanoid_upvr (readonly)
			]]
			if arg1_2:lower() == 'q' then
				Event_upvr:FireServer('q', Humanoid_upvr.TargetPoint)
			end
		end)
	end
end
Parent_upvr.Equipped:connect(Equipped)