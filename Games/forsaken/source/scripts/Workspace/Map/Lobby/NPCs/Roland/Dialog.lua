-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:14
-- Luau version 6, Types version 3
-- Time taken: 0.006288 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://95263724367762";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
local Sounds_upvr = require(game.ReplicatedStorage.Modules.Sounds)
function module_upvr.Interacted(arg1) -- Line 14
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Sounds_upvr (readonly)
	]]
	if not module_upvr.TimesInteracted then
		module_upvr.TimesInteracted = 0
	end
	local var8 = module_upvr
	var8.TimesInteracted += 1
	if module_upvr.TimesInteracted == 9 then
		script.Parent.Name = "Roland?"
	elseif module_upvr.TimesInteracted == 10 then
		script.Parent.Name = "Roland Cosplayer"
	end
	local var9
	if module_upvr.TimesInteracted < var9 then
		local any_Play_result1 = Sounds_upvr:Play("rbxassetid://73136812934449", {
			PlaybackSpeed = math.clamp((10 - module_upvr.TimesInteracted / 2 + 2) / 10, 0.5, 1);
		})
		var9 = ".."
		for _ = 1, module_upvr.TimesInteracted do
			var9 = var9..'.'
		end
		arg1:CreateDialog({
			Text = var9;
		})
		game.TweenService:Create(any_Play_result1, TweenInfo.new(0.25), {
			Volume = 0;
		}):Play()
		game.Debris:AddItem(any_Play_result1, 0.25)
	else
		if module_upvr.TimesInteracted == 10 then
			arg1:CreateDialog({
				Text = "i dont rlly know how i got here to be honest with you";
			})
			return
		end
		arg1:CreateDialog({
			Text = "i wanna go back to the cosplay contest";
		})
	end
end
return module_upvr