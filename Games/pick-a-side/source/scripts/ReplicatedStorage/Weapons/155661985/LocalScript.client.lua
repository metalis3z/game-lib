-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:43
-- Luau version 6, Types version 3
-- Time taken: 0.001240 seconds

local Parent = script.Parent
local Event_upvr = Parent:WaitForChild("Event")
function Equipped(arg1) -- Line 4
	--[[ Upvalues[1]:
		[1]: Event_upvr (readonly)
	]]
	arg1.KeyDown:connect(function(arg1_2) -- Line 5
		--[[ Upvalues[1]:
			[1]: Event_upvr (copied, readonly)
		]]
		if arg1_2:lower() == 'q' then
			Event_upvr:FireServer('q')
		end
	end)
end
Parent.Equipped:connect(Equipped)