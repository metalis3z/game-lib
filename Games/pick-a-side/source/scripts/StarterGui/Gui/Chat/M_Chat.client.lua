-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:41
-- Luau version 6, Types version 3
-- Time taken: 0.003335 seconds

function PushMessages(arg1, arg2) -- Line 9
	for _, v in pairs(arg1:GetChildren()) do
		v.Position -= UDim2.new(0, 0, 0, arg2)
		if v.Position.Y.Offset + 2 < -1 * arg1.AbsoluteSize.Y then
			v:Destroy()
		end
	end
end
local Messages_upvr = script.Parent.Messages
local var7_upvw = 0
local Messager_upvr = script.Parent.Messager
function createMessage(arg1, arg2, arg3) -- Line 20
	--[[ Upvalues[3]:
		[1]: Messages_upvr (readonly)
		[2]: var7_upvw (read and write)
		[3]: Messager_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 31 start (CF ANALYSIS FAILED)
	for i_2, v_2 in pairs(Messages_upvr:GetChildren()) do
		v_2.Visible = true
	end
	var7_upvw += 1
	if 1000 <= var7_upvw then
		var7_upvw = 0
	end
	local clone = Messager_upvr:clone()
	if not arg1 then
		clone.Text = arg2
		i_2 = 0
		v_2 = 1
		clone.TextColor3 = Color3.new(i_2, v_2, 0)
		-- KONSTANTWARNING: GOTO [93] #69
	end
	-- KONSTANTERROR: [0] 1. Error Block 31 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [39] 31. Error Block 29 start (CF ANALYSIS FAILED)
	if arg3 == "qa" then
		i_2 = "[QA] "
		v_2 = arg1.DisplayName
		clone.Text = i_2..v_2..':'
		i_2 = 1
		v_2 = 0.3
		clone.TextColor3 = Color3.new(i_2, v_2, 1)
	elseif arg3 == "vip" then
		i_2 = "[VIP] "
		v_2 = arg1.DisplayName
		clone.Text = i_2..v_2..':'
		i_2 = 1
		v_2 = 1
		clone.TextColor3 = Color3.new(i_2, v_2, 0)
	else
		i_2 = arg1.DisplayName
		v_2 = ':'
		clone.Text = i_2..v_2
		i_2 = 0.7
		v_2 = 0.7
		clone.TextColor3 = Color3.new(i_2, v_2, 0.7)
	end
	clone.Message.Text = arg2
	clone.Parent = Messages_upvr
	clone.Message.Position = UDim2.new(0, clone.TextBounds.X + clone.TextBounds.Y * 0.36, 0, 0)
	clone.Message.Size = UDim2.new(1, -1 * clone.Message.Position.X.Offset, 0, 36)
	PushMessages(Messages_upvr, clone.Message.TextBounds.Y * 1.05)
	wait(20)
	if var7_upvw == var7_upvw then
		for _, v_3 in pairs(Messages_upvr:GetChildren()) do
			v_3.Visible = false
		end
	end
	-- KONSTANTERROR: [39] 31. Error Block 29 end (CF ANALYSIS FAILED)
end
game:GetService("ReplicatedStorage").Events.Chat.OnClientEvent:connect(function(arg1, arg2, arg3) -- Line 65
	createMessage(arg1, arg2, arg3)
end)