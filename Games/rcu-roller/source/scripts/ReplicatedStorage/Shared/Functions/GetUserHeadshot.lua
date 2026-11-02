-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:13
-- Luau version 6, Types version 3
-- Time taken: 0.000514 seconds

local Players_upvr = game:GetService("Players")
return function(arg1) -- Line 13
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local any_GetUserThumbnailAsync_result1, any_GetUserThumbnailAsync_result2 = Players_upvr:GetUserThumbnailAsync(arg1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	local var5
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var5 = any_GetUserThumbnailAsync_result1
		return var5
	end
	if not any_GetUserThumbnailAsync_result2 or not INLINED() then
		var5 = "rbxassetid://112951947643512"
	end
	return var5
end