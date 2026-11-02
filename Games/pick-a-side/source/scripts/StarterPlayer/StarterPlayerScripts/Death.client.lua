-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:54
-- Luau version 6, Types version 3
-- Time taken: 0.001647 seconds

while not _G.ClientDataReady do
	wait()
end
local LocalPlayer_upvr = game.Players.LocalPlayer
local Death_upvr = workspace.Death
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Signals_upvr = game.ReplicatedStorage.Signals
Death_upvr.HumanoidRootPart.ProximityPrompt.Triggered:Connect(function() -- Line 11
	--[[ Upvalues[3]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Signals_upvr (readonly)
	]]
	if CLIENT_DATA_upvr.data.revives == 0 then
		LocalPlayer_upvr.PlayerGui.Gui.Revives.Windows.Orig.Visible = true
	else
		Signals_upvr.Revive:FireServer()
	end
end)
if LocalPlayer_upvr:GetAttribute("Death") and not LocalPlayer_upvr:GetAttribute("Revive") then
	Death_upvr.Parent = workspace
else
	Death_upvr.Parent = nil
end
LocalPlayer_upvr:GetAttributeChangedSignal("Death"):Connect(function() -- Line 20, Named "Update"
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: Death_upvr (readonly)
	]]
	if LocalPlayer_upvr:GetAttribute("Death") and not LocalPlayer_upvr:GetAttribute("Revive") then
		Death_upvr.Parent = workspace
	else
		Death_upvr.Parent = nil
	end
end)