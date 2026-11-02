-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:35
-- Luau version 6, Types version 3
-- Time taken: 0.004302 seconds

local Parent_upvr = script.Parent
local List_upvr = Parent_upvr.List
function PushMessages(arg1) -- Line 7
	--[[ Upvalues[1]:
		[1]: List_upvr (readonly)
	]]
	for _, v in pairs(List_upvr:GetChildren()) do
		v.Position -= UDim2.new(0, 0, 0, arg1)
	end
end
function _G.message(arg1, arg2, arg3, arg4, arg5) -- Line 14
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: List_upvr (readonly)
	]]
	spawn(function() -- Line 15
		--[[ Upvalues[7]:
			[1]: Parent_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: arg3 (readonly)
			[4]: arg2 (read and write)
			[5]: arg4 (read and write)
			[6]: arg5 (readonly)
			[7]: List_upvr (copied, readonly)
		]]
		local clone = Parent_upvr.Message:Clone()
		local Reward = clone.Reward
		local Shadow = Reward.Shadow
		local __2 = clone['1']
		local Shadow_3 = __2.Shadow
		local __3 = clone['2']
		local Shadow_2 = __3.Shadow
		if arg1 == "Reward" then
			if arg3 then
				clone.Reward.TextColor3 = arg3
			end
			Reward.Text = arg2
			Shadow.Text = clone.Reward.Text
		elseif arg1 == "Message" then
			Reward.Text = arg2
		elseif arg1 == "Death" then
			clone.Icon.Visible = true
			if 9 < string.len(arg2) then
				arg2 = string.sub(arg2, 0, -2)..".."
			end
			if 9 < string.len(arg4) then
				arg4 = string.sub(arg4, 0, -2)..".."
			end
			__2.Text = arg2
			__2.TextColor3 = arg3
			Shadow_3.Text = __2.Text
			__3.Text = arg4
			__3.TextColor3 = arg5
			Shadow_2.Text = __3.Text
		end
		clone.Parent = List_upvr
		PushMessages(clone.Size.Y.Offset * 1.2)
		wait(4)
		for i_2 = 0, 10 do
			wait(0.06)
			if arg1 == "Reward" then
				Reward.TextTransparency = i_2 / 10
				Reward.TextStrokeTransparency = i_2 / 10
				Shadow.TextTransparency = i_2 / 10
				Shadow.TextStrokeTransparency = i_2 / 10
			elseif arg1 == "Death" then
				__2.TextTransparency = i_2 / 10
				__2.TextStrokeTransparency = i_2 / 10
				Shadow_3.TextTransparency = i_2 / 10
				Shadow_3.TextStrokeTransparency = i_2 / 10
				__3.TextTransparency = i_2 / 10
				__3.TextStrokeTransparency = i_2 / 10
				Shadow_2.TextTransparency = i_2 / 10
				Shadow_2.TextStrokeTransparency = i_2 / 10
				clone.Icon.ImageTransparency = i_2 / 10
			end
		end
		clone:destroy()
	end)
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage.Events.Death.OnClientEvent:connect(function(arg1, arg2, arg3) -- Line 77
	local Color3_new_result1 = Color3.new(1, 0.4, 0.4)
	local Color3_new_result1_2 = Color3.new(0.4, 0.7, 1)
	if arg3.Name == "Blue" then
		Color3_new_result1 = Color3.new(0.4, 0.7, 1)
		Color3_new_result1_2 = Color3.new(1, 0.4, 0.4)
	end
	_G.message("Death", arg1, Color3_new_result1, arg2, Color3_new_result1_2)
end)
ReplicatedStorage.Events.Message.OnClientEvent:connect(function(arg1, arg2, arg3) -- Line 89
	_G.message("Message", arg1)
end)