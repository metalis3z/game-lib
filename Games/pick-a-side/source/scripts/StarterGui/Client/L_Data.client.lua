-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:27
-- Luau version 6, Types version 3
-- Time taken: 0.002147 seconds

_G.CLIENT_DATA = {
	data = nil;
	change = Instance.new("BindableEvent");
}
_G.ClientDataReady = false
local HttpService_upvr = game:GetService("HttpService")
function DecodeJSON(arg1) -- Line 12
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	return HttpService_upvr:JSONDecode(arg1)
end
profiles = game.Workspace.Profiles -- Setting global
local SOME_upvr = profiles:WaitForChild(game.Players.LocalPlayer.UserId)
function UpdatePlayerProfileData() -- Line 25
	--[[ Upvalues[1]:
		[1]: SOME_upvr (readonly)
	]]
	local var4_upvw
	pcall(function() -- Line 27
		--[[ Upvalues[2]:
			[1]: var4_upvw (read and write)
			[2]: SOME_upvr (copied, readonly)
		]]
		var4_upvw = DecodeJSON(SOME_upvr.Value)
	end)
	if var4_upvw ~= nil then
		_G.CLIENT_DATA.data = var4_upvw
		_G.CLIENT_DATA.change:Fire()
	end
end
SOME_upvr.Changed:connect(UpdatePlayerProfileData)
UpdatePlayerProfileData()
_G.ClientDataReady = true