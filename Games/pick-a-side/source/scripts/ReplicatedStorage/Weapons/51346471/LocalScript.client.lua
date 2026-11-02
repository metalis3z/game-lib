-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:12
-- Luau version 6, Types version 3
-- Time taken: 0.002350 seconds

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
		script.Parent.Input:FireServer("Mouse1", true, arg1.Hit.p)
	end)
	arg1.Button1Up:connect(function() -- Line 5
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		script.Parent.Input:FireServer("Mouse1", false, arg1.Hit.p)
	end)
	arg1.KeyDown:connect(function(arg1_2) -- Line 6
		script.Parent.Input:FireServer("KeyDown", arg1_2)
	end)
	if UserInputService_upvr.TouchEnabled then
		ContextActionService_upvr:BindActionToInputTypes("TwinKodachi_DualWeild", function(arg1_3, arg2, arg3) -- Line 11
			if arg2 == Enum.UserInputState.Begin then
				script.Parent.Input:FireServer("KeyDown", 'q')
			end
		end, true, "")
		ContextActionService_upvr:SetTitle("TwinKodachi_DualWeild", "Dual Weild")
	end
end)
script.Parent.Unequipped:connect(function() -- Line 23
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: ContextActionService_upvr (readonly)
	]]
	if UserInputService_upvr.TouchEnabled then
		ContextActionService_upvr:UnbindAction("TwinKodachi_DualWeild")
	end
end)