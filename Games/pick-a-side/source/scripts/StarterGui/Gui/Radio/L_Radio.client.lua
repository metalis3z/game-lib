-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:40
-- Luau version 6, Types version 3
-- Time taken: 0.007809 seconds

while not _G.ClientDataReady do
	wait()
end
local Parent_upvr = script.Parent
local Orig_2 = Parent_upvr.Windows.Orig
local Radio_3_upvr = game:GetService("ReplicatedStorage").Events.Radio
local Field_upvr_2 = Orig_2.Box.Field
local Confirm_upvr = Orig_2.Confirm
Confirm_upvr.MouseButton1Down:connect(function() -- Line 23
	--[[ Upvalues[3]:
		[1]: Confirm_upvr (readonly)
		[2]: Radio_3_upvr (readonly)
		[3]: Field_upvr_2 (readonly)
	]]
	if Confirm_upvr.Amount.Text == "PLAY" then
		Confirm_upvr.Amount.Text = "STOP"
		Radio_3_upvr:FireServer("Play", Field_upvr_2.Text)
	else
		Confirm_upvr.Amount.Text = "PLAY"
		Radio_3_upvr:FireServer("Stop")
	end
end)
Field_upvr_2.changed:connect(function() -- Line 33
	--[[ Upvalues[1]:
		[1]: Field_upvr_2 (readonly)
	]]
	if 0 < string.len(Field_upvr_2.Text) then
		Field_upvr_2.Placeholder.Visible = false
	else
		Field_upvr_2.Placeholder.Visible = true
	end
end)
Radio_3_upvr.OnClientEvent:connect(function(arg1, arg2, arg3, arg4, arg5) -- Line 42
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	if arg1 == "Show" then
		Parent_upvr.Button.Visible = true
	end
	if arg1 == "Invalid" then
		_G.Status("Invalid ID!")
		_G.ShowWindow("Music")
	end
end)
local var31_upvw = false
Parent_upvr.Mute.MouseButton1Down:connect(function() -- Line 60
	--[[ Upvalues[2]:
		[1]: var31_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	if not var31_upvw then
		var31_upvw = true
		Parent_upvr.Mute.C.Visible = true
	else
		var31_upvw = false
		Parent_upvr.Mute.C.Visible = false
	end
end)
while true do
	for _, v in pairs(game.Players:GetChildren()) do
		local Character_2 = v.Character
		if Character_2 then
			local Radio = Character_2:FindFirstChild("Radio")
			if Radio then
				local Sound = Radio:FindFirstChild("Sound")
				if Sound then
					if var31_upvw then
						Sound.Volume = 0
					else
						Sound.Volume = 0.25
					end
				end
			end
		end
	end
	if var31_upvw then
		workspace.Intermission.Volume = 0
	else
		workspace.Intermission.Volume = 0.25
	end
	wait(1)
end