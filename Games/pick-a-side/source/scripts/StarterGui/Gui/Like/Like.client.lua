-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:43
-- Luau version 6, Types version 3
-- Time taken: 0.001835 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Topbar_upvr = game.Players.LocalPlayer.PlayerGui:WaitForChild("Topbar")
local Signals_upvr = game.ReplicatedStorage.Signals
if not CLIENT_DATA_upvr.data.claimedLike then
else
	Topbar_upvr.Holder.Like.Visible = false
end
CLIENT_DATA_upvr.change.Event:connect(function() -- Line 10, Named "Update"
	--[[ Upvalues[2]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: Topbar_upvr (readonly)
	]]
	if not CLIENT_DATA_upvr.data.claimedLike then
	else
		Topbar_upvr.Holder.Like.Visible = false
	end
end)
local Orig_upvr = script.Parent.Windows.Orig
script.Parent.Windows.Orig.Claim.Activated:Connect(function() -- Line 20
	--[[ Upvalues[2]:
		[1]: Orig_upvr (readonly)
		[2]: Signals_upvr (readonly)
	]]
	Orig_upvr.Visible = false
	task.wait(1)
	Signals_upvr.ClaimLike:FireServer()
end)
Signals_upvr.ClaimLike.OnClientEvent:Connect(function(arg1) -- Line 26
	if arg1 then
		_G.message("Message", "Success!")
	else
		_G.message("Message", "You must join the Roblox Group!")
	end
end)