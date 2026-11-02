-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:32
-- Luau version 6, Types version 3
-- Time taken: 0.001946 seconds

local module = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
function module.Interacted(arg1) -- Line 10
	arg1:CreateDialog({
		Text = "hi im frosty :D";
	})
	arg1:GetUserResponse({{
		Choice = "hi frosty!";
	}})
	arg1:CreateDialog({
		Text = "hello!!!";
	})
	arg1:GetUserResponse({{
		Choice = "you look a bit sad frosty D:";
	}})
	arg1:CreateDialog({
		Text = "oh.. well..my friends make fun of me for having a black tophat :((";
	})
	arg1:GetUserResponse({{
		Choice = "aw thats so sad ;(";
	}})
	arg1:CreateDialog({
		Text = "yes but i moved on and i am now enjoying my winter wonderland!";
	})
end
return module