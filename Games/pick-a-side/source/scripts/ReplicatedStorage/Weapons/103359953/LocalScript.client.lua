-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:51
-- Luau version 6, Types version 3
-- Time taken: 0.001993 seconds

sp = script.Parent -- Setting global
function waitfor(arg1, arg2) -- Line 7
	while arg1:FindFirstChild(arg2) == nil do
		arg1.ChildAdded:wait()
	end
	return arg1:FindFirstChild(arg2)
end
animspeed = 0.8 -- Setting global
equipspeed = 0.8 -- Setting global
local Event_upvr = sp:WaitForChild("Event")
function Equipped(arg1) -- Line 24
	--[[ Upvalues[1]:
		[1]: Event_upvr (readonly)
	]]
	if arg1 ~= nil then
		arg1.KeyDown:connect(function(arg1_2) -- Line 28
			--[[ Upvalues[1]:
				[1]: Event_upvr (copied, readonly)
			]]
			if arg1_2:lower() == 'q' then
				Event_upvr:FireServer('q')
			end
		end)
	end
end
sp.Equipped:connect(Equipped)