-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:37
-- Luau version 6, Types version 3
-- Time taken: 0.009187 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Custom_upvr = ReplicatedStorage.Events.Custom
local Windows = script.Parent.Windows
local Orig = Windows.Orig
local Custom1_upvr = Windows.Custom1
local Field_upvr_2 = Custom1_upvr.Search.Field
local Add_upvr_2 = Custom1_upvr.Add
local Pages_upvr = Custom1_upvr.Pages
local Side = Custom1_upvr.Side
local Label_upvr_2 = Side.Blue.Label
local Label_upvr = Side.Red.Label
local tbl_upvw = {}
local var13_upvw = 1
local Questions_upvr = require(ReplicatedStorage.Questions)
local ChinaPolicyService_upvr = require(game.ReplicatedStorage.Modules.ChinaPolicyService)
function Update(arg1) -- Line 38
	--[[ Upvalues[8]:
		[1]: tbl_upvw (read and write)
		[2]: Questions_upvr (readonly)
		[3]: ChinaPolicyService_upvr (readonly)
		[4]: Add_upvr_2 (readonly)
		[5]: Pages_upvr (readonly)
		[6]: Label_upvr_2 (readonly)
		[7]: Label_upvr (readonly)
		[8]: var13_upvw (read and write)
	]]
	tbl_upvw = {}
	for i, v in pairs(Questions_upvr) do
		if string.lower(v[1]):match(arg1) or string.lower(v[2]):match(arg1) or not ChinaPolicyService_upvr:IsActive() or i ~= 28 and i ~= 31 and i ~= 38 and i ~= 56 and i ~= 109 and i ~= 110 and i ~= 111 and i ~= 112 and i ~= 200 and i ~= 237 and i ~= 235 and i ~= 541 and i ~= 743 and i ~= 807 and i ~= 333 and i ~= 365 and i ~= 354 and i ~= 386 and i ~= 756 and i ~= 371 and i ~= 607 and i ~= 405 and i ~= 460 and i ~= 384 and i ~= 364 and i ~= 252 and i ~= 391 and i ~= 392 and i ~= 488 and i ~= 494 and i ~= 751 and i ~= 784 and i ~= 801 then
			table.insert(tbl_upvw, {i, v})
		end
	end
	if 0 < #tbl_upvw then
		Add_upvr_2.Visible = true
		Pages_upvr.Visible = true
		v = tbl_upvw
		i = v[1]
		Label_upvr_2.Text = i[2][1]
		v = tbl_upvw
		i = v[1]
		Label_upvr.Text = i[2][2]
		i = " ("
		v = #tbl_upvw
		Pages_upvr.Num.Text = var13_upvw..i..v..')'
	else
		Label_upvr_2.Text = ""
		Label_upvr.Text = ""
		Add_upvr_2.Visible = false
		Pages_upvr.Visible = false
	end
end
Pages_upvr.Next.MouseButton1Down:connect(function() -- Line 64
	--[[ Upvalues[5]:
		[1]: var13_upvw (read and write)
		[2]: tbl_upvw (read and write)
		[3]: Label_upvr_2 (readonly)
		[4]: Label_upvr (readonly)
		[5]: Pages_upvr (readonly)
	]]
	var13_upvw += 1
	if #tbl_upvw < var13_upvw then
		var13_upvw = 1
	end
	Label_upvr_2.Text = tbl_upvw[var13_upvw][2][1]
	Label_upvr.Text = tbl_upvw[var13_upvw][2][2]
	Pages_upvr.Num.Text = var13_upvw.." ("..(#tbl_upvw)..')'
end)
Pages_upvr.Prev.MouseButton1Down:connect(function() -- Line 73
	--[[ Upvalues[5]:
		[1]: var13_upvw (read and write)
		[2]: tbl_upvw (read and write)
		[3]: Label_upvr_2 (readonly)
		[4]: Label_upvr (readonly)
		[5]: Pages_upvr (readonly)
	]]
	var13_upvw -= 1
	if var13_upvw < 1 then
		var13_upvw = #tbl_upvw
	end
	Label_upvr_2.Text = tbl_upvw[var13_upvw][2][1]
	Label_upvr.Text = tbl_upvw[var13_upvw][2][2]
	Pages_upvr.Num.Text = var13_upvw.." ("..(#tbl_upvw)..')'
end)
Field_upvr_2.changed:connect(function() -- Line 84
	--[[ Upvalues[1]:
		[1]: Field_upvr_2 (readonly)
	]]
	if 0 < string.len(Field_upvr_2.Text) then
		if 3 < string.len(Field_upvr_2.Text) then
			Update(string.lower(Field_upvr_2.Text))
		end
		Field_upvr_2.Placeholder.Visible = false
	else
		Field_upvr_2.Placeholder.Visible = true
	end
end)
Add_upvr_2.MouseButton1Down:connect(function() -- Line 96
	--[[ Upvalues[4]:
		[1]: Add_upvr_2 (readonly)
		[2]: Custom_upvr (readonly)
		[3]: tbl_upvw (read and write)
		[4]: var13_upvw (read and write)
	]]
	Add_upvr_2.Visible = false
	Custom_upvr:FireServer("Search", tbl_upvw[var13_upvw][1])
end)
Orig.Categories.Custom1.MouseButton1Down:connect(function() -- Line 102
	--[[ Upvalues[1]:
		[1]: Field_upvr_2 (readonly)
	]]
	Field_upvr_2:CaptureFocus()
end)
local Custom2_upvr = Windows.Custom2
local Field_upvr_3 = Custom2_upvr.Blue.Field
local Field_upvr = Custom2_upvr.Red.Field
local Add_upvr = Custom2_upvr.Add
local Error_upvr = Custom2_upvr.Error
Add_upvr.MouseButton1Down:connect(function() -- Line 123
	--[[ Upvalues[4]:
		[1]: Add_upvr (readonly)
		[2]: Custom_upvr (readonly)
		[3]: Field_upvr_3 (readonly)
		[4]: Field_upvr (readonly)
	]]
	Add_upvr.Visible = false
	Custom_upvr:FireServer("Write", Field_upvr_3.Text, Field_upvr.Text)
end)
Field_upvr_3.changed:connect(function() -- Line 129
	--[[ Upvalues[1]:
		[1]: Field_upvr_3 (readonly)
	]]
	if 0 < string.len(Field_upvr_3.Text) then
		Field_upvr_3.Placeholder.Visible = false
	else
		Field_upvr_3.Placeholder.Visible = true
	end
end)
Field_upvr.changed:connect(function() -- Line 138
	--[[ Upvalues[1]:
		[1]: Field_upvr (readonly)
	]]
	if 0 < string.len(Field_upvr.Text) then
		Field_upvr.Placeholder.Visible = false
	else
		Field_upvr.Placeholder.Visible = true
	end
end)
Orig.Categories.Custom2.MouseButton1Down:connect(function() -- Line 146
	--[[ Upvalues[3]:
		[1]: Field_upvr_3 (readonly)
		[2]: Field_upvr (readonly)
		[3]: Error_upvr (readonly)
	]]
	Field_upvr_3.Text = ""
	Field_upvr.Text = ""
	Field_upvr.Placeholder.Visible = true
	Field_upvr_3.Placeholder.Visible = true
	Error_upvr.Text = ""
	Field_upvr:CaptureFocus()
end)
Custom_upvr.OnClientEvent:connect(function(arg1, arg2) -- Line 161
	--[[ Upvalues[5]:
		[1]: Error_upvr (readonly)
		[2]: Add_upvr_2 (readonly)
		[3]: Add_upvr (readonly)
		[4]: Custom1_upvr (readonly)
		[5]: Custom2_upvr (readonly)
	]]
	if arg1 == "success" then
		if arg2 then
			Error_upvr.TextColor3 = Color3.new(1, 0, 0)
			Error_upvr.Text = arg2
		else
			Error_upvr.TextColor3 = Color3.new(0, 1, 0)
			Error_upvr.Text = "Your sides have been added to the queue!"
		end
		wait(2)
		Add_upvr_2.Visible = true
		Add_upvr.Visible = true
		if not arg2 then
			Custom1_upvr.Visible = false
			Custom2_upvr.Visible = false
		end
	end
	if arg1 == "update" then
		updateCost()
	end
end)
local Custom_Multiplier_upvr = ReplicatedStorage.Custom_Multiplier
function updateCost() -- Line 184
	--[[ Upvalues[3]:
		[1]: Custom2_upvr (readonly)
		[2]: Custom_Multiplier_upvr (readonly)
		[3]: Add_upvr_2 (readonly)
	]]
	Custom2_upvr.Add.Amount.Text = '$'..math.ceil(100 * Custom_Multiplier_upvr.Value)
	Add_upvr_2.Amount.Text = '$'..math.ceil(50 * Custom_Multiplier_upvr.Value)
end
updateCost()