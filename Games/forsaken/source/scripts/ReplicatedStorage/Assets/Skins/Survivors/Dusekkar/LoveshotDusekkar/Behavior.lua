-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:51:34
-- Luau version 6, Types version 3
-- Time taken: 0.001488 seconds

local module = {}
local PigtailsAnimation_upvr = script.PigtailsAnimation
function module.CreatedPost(arg1, arg2) -- Line 6
	--[[ Upvalues[1]:
		[1]: PigtailsAnimation_upvr (readonly)
	]]
	if game["Run Service"]:IsClient() then
		task.spawn(function() -- Line 8
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: PigtailsAnimation_upvr (copied, readonly)
			]]
			local Rig = arg2.Rig
			if Rig then
				local Pigtails = Rig:FindFirstChild("Pigtails")
				if not Pigtails then return end
				Pigtails:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(PigtailsAnimation_upvr):Play()
			end
		end)
	end
end
return module