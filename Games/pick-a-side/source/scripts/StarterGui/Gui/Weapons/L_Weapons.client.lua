-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:33
-- Luau version 6, Types version 3
-- Time taken: 0.006648 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Parent = script.Parent
local Orig_upvr = Parent.Windows.Orig
local Confirm_upvr = Parent.Windows.Confirm
local Weapons_upvr = game:GetService("ReplicatedStorage").Events.Weapons
local var6_upvw
function Beautify(arg1) -- Line 23
	local var7
	repeat
		local string_gsub_result1, string_gsub_result2 = string.gsub(var7, "^(-?%d+)(%d%d%d)", "%1,%2")
		var7 = string_gsub_result1
	until string_gsub_result2 == 0
	return var7
end
Orig_upvr:GetPropertyChangedSignal("Visible"):Connect(function() -- Line 36
	game.ReplicatedStorage.Signals.LogFunnel:FireServer("Weapons")
end)
local children_upvr = game.ReplicatedStorage.Weapons:GetChildren()
table.sort(children_upvr, function(arg1, arg2) -- Line 49
	local var13
	if tonumber(arg1.Price.Value) >= tonumber(arg2.Price.Value) then
		var13 = false
	else
		var13 = true
	end
	return var13
end)
local var14_upvw = 1
local List_upvr = Orig_upvr.List
local Reward_upvr = Orig_upvr.Reward
local ChinaPolicyService_upvr = require(game.ReplicatedStorage.Modules.ChinaPolicyService)
function UpdateRewards() -- Line 51
	--[[ Upvalues[10]:
		[1]: List_upvr (readonly)
		[2]: CLIENT_DATA_upvr (readonly)
		[3]: var14_upvw (read and write)
		[4]: children_upvr (readonly)
		[5]: Reward_upvr (readonly)
		[6]: ChinaPolicyService_upvr (readonly)
		[7]: Confirm_upvr (readonly)
		[8]: Orig_upvr (readonly)
		[9]: Weapons_upvr (readonly)
		[10]: var6_upvw (read and write)
	]]
	List_upvr:ClearAllChildren()
	local data = CLIENT_DATA_upvr.data
	local var20 = 1
	for i = var14_upvw * 8 - 7, var14_upvw * 8 do
		if i <= #children_upvr then
			local var21_upvr = children_upvr[i]
			local floored = math.floor((var20 - 1) / 4)
			local clone_upvr = Reward_upvr:clone()
			local var24 = clone_upvr.Size.X.Offset * 1.11
			clone_upvr.Position = UDim2.new(0, (1) + ((var20 - 1) * var24 - floored * var24 * 4), 0, 1 + clone_upvr.Size.Y.Offset * 1.09 * floored)
			clone_upvr.Parent = List_upvr
			clone_upvr.Img.Image = var21_upvr.TextureId
			clone_upvr.Cost.Text = '$'..Beautify(var21_upvr.Price.Value)
			clone_upvr.Title.Text = var21_upvr.ToolTip
			if data.weapons.owned[var21_upvr.Name] then
				clone_upvr.Cost.TextColor3 = Color3.new(0, 1, 0)
				clone_upvr.Cost.Text = "Owned"
			end
			if data.weapons.equipped == var21_upvr.Name then
				clone_upvr.Cost.TextColor3 = Color3.new(1, 0, 1)
				clone_upvr.Cost.Text = "Equipped"
			end
			clone_upvr.Visible = true
			clone_upvr.MouseButton1Down:connect(function() -- Line 76
				--[[ Upvalues[7]:
					[1]: clone_upvr (readonly)
					[2]: ChinaPolicyService_upvr (copied, readonly)
					[3]: Confirm_upvr (copied, readonly)
					[4]: var21_upvr (readonly)
					[5]: Orig_upvr (copied, readonly)
					[6]: Weapons_upvr (copied, readonly)
					[7]: var6_upvw (copied, read and write)
				]]
				if clone_upvr.Cost.Text ~= "Equipped" and clone_upvr.Cost.Text ~= "Owned" and not ChinaPolicyService_upvr:IsActive() then
					Confirm_upvr.Title.Text = "Are you sure you want to buy "..var21_upvr.ToolTip.." for "..clone_upvr.Cost.Text..'?'
					Confirm_upvr.Visible = true
					Orig_upvr.Visible = false
				else
					Weapons_upvr:FireServer("Select", var21_upvr.Name)
				end
				var6_upvw = var21_upvr.Name
				game.ReplicatedStorage.Signals.LogFunnel:FireServer("Unlock")
			end)
			if ChinaPolicyService_upvr:IsActive() and (var21_upvr.ToolTip == "Zombie Crossbow" or var21_upvr.ToolTip == "Shadow Sword" or var21_upvr.ToolTip == "Korblox Mage Staff" or var21_upvr.ToolTip == "Zombie STOPing Axe" or var21_upvr.ToolTip == "Sword of the Eternal Abyss") then
				clone_upvr.Visible = false
			end
		end
	end
end
Confirm_upvr.Pages.Yes.MouseButton1Down:Connect(function() -- Line 97
	--[[ Upvalues[4]:
		[1]: Weapons_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: Confirm_upvr (readonly)
		[4]: Orig_upvr (readonly)
	]]
	Weapons_upvr:FireServer("Select", var6_upvw)
	Confirm_upvr.Visible = false
	Orig_upvr.Visible = true
end)
Confirm_upvr.Pages.No.MouseButton1Down:Connect(function() -- Line 102
	--[[ Upvalues[2]:
		[1]: Confirm_upvr (readonly)
		[2]: Orig_upvr (readonly)
	]]
	Confirm_upvr.Visible = false
	Orig_upvr.Visible = true
end)
UpdateRewards()
CLIENT_DATA_upvr.change.Event:connect(UpdateRewards)
local Pages = Orig_upvr.Pages
local Page_upvr = Pages.Page
Pages.Next.MouseButton1Down:connect(function() -- Line 115
	--[[ Upvalues[3]:
		[1]: var14_upvw (read and write)
		[2]: children_upvr (readonly)
		[3]: Page_upvr (readonly)
	]]
	if var14_upvw * 8 < #children_upvr then
		var14_upvw += 1
		Page_upvr.Text = var14_upvw
		UpdateRewards()
	end
end)
Pages.Prev.MouseButton1Down:connect(function() -- Line 122
	--[[ Upvalues[2]:
		[1]: var14_upvw (read and write)
		[2]: Page_upvr (readonly)
	]]
	if 1 < var14_upvw then
		var14_upvw -= 1
		Page_upvr.Text = var14_upvw
		UpdateRewards()
	end
end)
local Cant_upvr = Parent.Cant
Weapons_upvr.OnClientEvent:connect(function(arg1, arg2, arg3, arg4, arg5) -- Line 132
	--[[ Upvalues[1]:
		[1]: Cant_upvr (readonly)
	]]
	if arg1 == "Cant" then
		Cant_upvr:Play()
	end
end)