-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:39
-- Luau version 6, Types version 3
-- Time taken: 0.015945 seconds

while not _G.ClientDataReady do
	wait()
end
local Orig_upvr = script.Parent.Windows.Orig
function percentToColor(arg1) -- Line 20
	arg1 = 100 - arg1
	local var2 = arg1
	if var2 == 100 then
		var2 = 99
	end
	local var3
	local var4
	if var2 < 50 then
		var3 = math.floor((255) * (var2 / 50))
		var4 = 255
	else
		var3 = 255
		var4 = math.floor((255) * ((50 - var2 % 50) / 50))
	end
	return Color3.new(var3 / 255, var4 / 255, 0 / 255)
end
function tableLen(arg1) -- Line 39
	local var9 = 0
	for _, _ in pairs(arg1) do
		var9 += 1
	end
	return var9
end
local LocalPlayer_upvr = game.Players.LocalPlayer
local List_upvr = Orig_upvr.List
local Reward_upvr = Orig_upvr.Reward
game:GetService("ReplicatedStorage").Events.Friends.OnClientEvent:connect(function(arg1) -- Line 50
	--[[ Upvalues[4]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: Orig_upvr (readonly)
		[3]: List_upvr (readonly)
		[4]: Reward_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local _2 = arg1[tostring(LocalPlayer_upvr.UserId)][2]
	if 5 <= tableLen(_2) then
		Orig_upvr.Title.Visible = true
		Orig_upvr.List.Visible = true
		Orig_upvr.Placeholder.Visible = false
	else
		Orig_upvr.Placeholder.Text = "PICK "..(5 - tableLen(_2)).." MORE SIDES TO SEE WHO YOU HAVE THE MOST IN COMMON WITH"
	end
	List_upvr:ClearAllChildren()
	for i_2, v_2 in pairs(arg1) do
		local var88
		if i_2 ~= tostring(LocalPlayer_upvr.UserId) then
			var88 = 0
			for i_3, v_3 in pairs(_2) do
				if v_2[2][i_3] then
					var88 += 1
					if v_2[2][i_3] == v_3 then
						local var92 = 0 + 1
					end
				end
			end
			if 2 <= var88 then
				local clone_2 = Reward_upvr:clone()
				clone_2.Parent = List_upvr
				i_3 = "https://www.roblox.com/headshot-thumbnail/image?userId="
				v_3 = v_2[1]
				clone_2.Img.Image = i_3..v_3.."&width=420&height=420&format=png"
				clone_2.Title.Text = v_2[1]
				i_3 = var92 / var88
				local floored_2 = math.floor(i_3 * 100)
				clone_2.Name = floored_2
				v_3 = floored_2
				i_3 = v_3.."% Similarity ("..var92..'/'..var88..')'
				clone_2.Cost.Text = i_3
				i_3 = percentToColor
				v_3 = floored_2
				i_3 = i_3(v_3)
				clone_2.Cost.TextColor3 = i_3
			end
		end
	end
	local children = List_upvr:GetChildren()
	table.sort(children, function(arg1_3, arg2) -- Line 86
		local var97
		if tonumber(arg2.Name) >= tonumber(arg1_3.Name) then
			var97 = false
		else
			var97 = true
		end
		return var97
	end)
	local var98 = 0
	for _, v_4 in pairs(children) do
		local var102 = v_4.Size.Y.Offset * 1.2
		v_4.Position = UDim2.new(0, 1, 0, 1 + var102 * var98)
		v_4.Visible = true
		if 3 < var98 then
			List_upvr.CanvasSize = UDim2.new(0, 0, 0, 1 + var102 * (var98 + 1))
		end
	end
end)