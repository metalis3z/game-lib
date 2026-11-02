-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:30
-- Luau version 6, Types version 3
-- Time taken: 0.002944 seconds

local ContextActionService_upvr = game:GetService("ContextActionService")
local UserInputService_upvr = game:GetService("UserInputService")
script.Parent.Equipped:connect(function(arg1) -- Line 3
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: ContextActionService_upvr (readonly)
	]]
	arg1.Button1Down:connect(function() -- Line 4
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		script.Parent.Input:FireServer("Mouse1", true, arg1.Hit)
	end)
	arg1.KeyDown:connect(function(arg1_2) -- Line 5
		script.Parent.Input:FireServer("Key", true, arg1_2)
	end)
	if UserInputService_upvr.TouchEnabled then
		ContextActionService_upvr:BindActionToInputTypes("Finnster_DualWield", function(arg1_3, arg2, arg3) -- Line 10
			if arg2 == Enum.UserInputState.Begin then
				script.Parent.Input:FireServer("Key", true, 'q')
			end
		end, true, "")
		ContextActionService_upvr:SetTitle("Finnster_DualWield", "Dual Wield")
	end
end)
script.Parent.Unequipped:connect(function(arg1) -- Line 22
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: ContextActionService_upvr (readonly)
	]]
	if UserInputService_upvr.TouchEnabled then
		ContextActionService_upvr:UnbindAction("Finnster_DualWield")
	end
end)