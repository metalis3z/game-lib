-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:42
-- Luau version 6, Types version 3
-- Time taken: 0.001960 seconds

local Report_upvr = game:GetService("ReplicatedStorage").Events.Report
local Parent = script.Parent
local Button_upvr = Parent.Button
local Orig_upvr = Parent.Windows.Orig
local Add_upvr = Orig_upvr.Add
local Confirm_upvr = Orig_upvr.Confirm
local var8_upvw = {"Michael Jackson", "Justin Bieber", game.Players.LocalPlayer}
Report_upvr.OnClientEvent:connect(function(arg1, arg2) -- Line 13
	--[[ Upvalues[5]:
		[1]: var8_upvw (read and write)
		[2]: Orig_upvr (readonly)
		[3]: Button_upvr (readonly)
		[4]: Add_upvr (readonly)
		[5]: Confirm_upvr (readonly)
	]]
	if arg1 == "Show" then
		var8_upvw = arg2
		local Side = Orig_upvr.Side
		Side.Blue.Label.Text = var8_upvw[1]
		Side.Red.Label.Text = var8_upvw[2]
		Orig_upvr.Plr.Text = "Added by: "..var8_upvw[3].Name
		Button_upvr.Visible = true
		wait(120)
		Button_upvr.Visible = false
		Add_upvr.Visible = false
		Confirm_upvr.Check.Visible = false
	end
end)
local Msg_upvr = Parent.Windows.Msg
Add_upvr.MouseButton1Down:connect(function() -- Line 30
	--[[ Upvalues[5]:
		[1]: Report_upvr (readonly)
		[2]: var8_upvw (read and write)
		[3]: Button_upvr (readonly)
		[4]: Orig_upvr (readonly)
		[5]: Msg_upvr (readonly)
	]]
	Report_upvr:FireServer(var8_upvw)
	Button_upvr.Visible = false
	Orig_upvr.Visible = false
	Msg_upvr.Visible = true
end)
Confirm_upvr.MouseButton1Down:connect(function() -- Line 39
	--[[ Upvalues[2]:
		[1]: Confirm_upvr (readonly)
		[2]: Add_upvr (readonly)
	]]
	Confirm_upvr.Check.Visible = true
	Add_upvr.Visible = true
end)