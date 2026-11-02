-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:31
-- Luau version 6, Types version 3
-- Time taken: 0.012807 seconds

while not _G.ClientDataReady do
	wait()
end
local Parent_5_upvr = script.Parent
local UserInputService = game:GetService("UserInputService")
local CHECK = script.CHECK
CHECK.Parent = Parent_5_upvr
_G.controller = "pc"
if UserInputService.GamepadEnabled == true then
	_G.controller = "console"
elseif UserInputService.TouchEnabled == true then
	wait(2)
	if CHECK.AbsoluteSize.Y < 460 then
		_G.controller = "mobile"
	else
		_G.controller = "tablet"
	end
end
print("_G.controller", _G.controller)
function _G.CloseWindows() -- Line 37
	--[[ Upvalues[1]:
		[1]: Parent_5_upvr (readonly)
	]]
	for _, v in pairs(Parent_5_upvr:GetChildren()) do
		local Windows_2 = v:FindFirstChild("Windows")
		if Windows_2 then
			for _, v_2 in pairs(Windows_2:GetChildren()) do
				v_2.Visible = false
			end
		end
	end
end
function _G.ShowWindow(arg1) -- Line 49
	--[[ Upvalues[1]:
		[1]: Parent_5_upvr (readonly)
	]]
	local Windows_4 = Parent_5_upvr[arg1].Windows
	_G.CloseWindows()
	local var16 = true
	if Windows_4.Orig.Visible == true then
		var16 = false
	end
	Windows_4.Orig.Visible = var16
end
function _G.ShowGui(arg1) -- Line 62
	--[[ Upvalues[1]:
		[1]: Parent_5_upvr (readonly)
	]]
	for _, v_3 in pairs(Parent_5_upvr:GetChildren()) do
		if v_3.ClassName == "Frame" then
			v_3.Visible = false
			for _, v_4 in pairs(arg1) do
				if v_4 == v_3.Name or v_4 == "All" then
					v_3.Visible = true
				end
			end
		end
	end
end
function Scan(arg1) -- Line 78
	for i_5_upvr = 1, #arg1 do
		local children = arg1[i_5_upvr]:GetChildren()
		local var50_upvr
		if var50_upvr == "TextButton" then
			var50_upvr = arg1[i_5_upvr]
			local Parent_2_upvr = var50_upvr.Parent
			if var50_upvr.Name == "Close" then
				var50_upvr.MouseButton1Down:connect(function() -- Line 89
					--[[ Upvalues[2]:
						[1]: arg1 (readonly)
						[2]: i_5_upvr (readonly)
					]]
					local Parent_4 = arg1[i_5_upvr].Parent.Parent
					if Parent_4.Orig.Visible or arg1[i_5_upvr].Parent.Name == "Custom1" or arg1[i_5_upvr].Parent.Name == "Custom2" or arg1[i_5_upvr].Parent.Name == "Msg" then
						_G.CloseWindows()
					else
						for _, v_6 in pairs(Parent_4:GetChildren()) do
							v_6.Visible = false
						end
						Parent_4.Orig.Visible = true
					end
				end)
			end
			if Parent_2_upvr.Name == "Categories" then
				var50_upvr.MouseButton1Down:connect(function() -- Line 103
					--[[ Upvalues[2]:
						[1]: Parent_2_upvr (readonly)
						[2]: var50_upvr (readonly)
					]]
					Parent_2_upvr.Parent.Parent[var50_upvr.Name].Visible = true
					Parent_2_upvr.Parent.Visible = false
				end)
			end
			if var50_upvr.Name == "Button" then
				var50_upvr.MouseButton1Down:connect(function() -- Line 111
					--[[ Upvalues[3]:
						[1]: arg1 (readonly)
						[2]: i_5_upvr (readonly)
						[3]: Parent_2_upvr (readonly)
					]]
					local Windows = arg1[i_5_upvr].Parent.Windows
					if not Windows.Orig.Visible then
						for _, v_5 in pairs(Windows:GetChildren()) do
							v_5.Visible = false
						end
					end
					_G.ShowWindow(Parent_2_upvr.Name)
				end)
			end
		end
		var50_upvr = 1
		Parent_2_upvr = _G.controller
		if Parent_2_upvr == "console" then
			var50_upvr = 1.33
		else
			Parent_2_upvr = _G.controller
			if Parent_2_upvr == "mobile" then
				var50_upvr = 0.8
			end
		end
		if var50_upvr ~= 1 then
			Parent_2_upvr = arg1[i_5_upvr].ClassName
			local function INLINED_2() -- Internal function, doesn't exist in bytecode
				Parent_2_upvr = arg1[i_5_upvr].ClassName
				return Parent_2_upvr == "TextBox"
			end
			if Parent_2_upvr == "TextLabel" or INLINED_2() then
				Parent_2_upvr = arg1[i_5_upvr]
				Parent_2_upvr.TextSize = arg1[i_5_upvr].TextSize * var50_upvr
			end
			Parent_2_upvr = arg1[i_5_upvr].Name
			if Parent_2_upvr ~= "Windows" then
				Parent_2_upvr = arg1[i_5_upvr].Parent.Name
				if Parent_2_upvr ~= "Gui" then
					Parent_2_upvr = arg1[i_5_upvr].ClassName
					if Parent_2_upvr ~= "LocalScript" then
						Parent_2_upvr = arg1[i_5_upvr].ClassName
						if Parent_2_upvr ~= "Sound" then
							Parent_2_upvr = arg1[i_5_upvr]:IsA("GuiObject")
							if Parent_2_upvr then
								Parent_2_upvr = arg1[i_5_upvr]
								Parent_2_upvr.Size = UDim2.new(arg1[i_5_upvr].Size.X.Scale, arg1[i_5_upvr].Size.X.Offset * var50_upvr, arg1[i_5_upvr].Size.Y.Scale, arg1[i_5_upvr].Size.Y.Offset * var50_upvr)
								Parent_2_upvr = arg1[i_5_upvr]
								Parent_2_upvr.Position = UDim2.new(arg1[i_5_upvr].Position.X.Scale, arg1[i_5_upvr].Position.X.Offset * var50_upvr, arg1[i_5_upvr].Position.Y.Scale, arg1[i_5_upvr].Position.Y.Offset * var50_upvr)
							end
						end
					end
				end
			end
		end
		Parent_2_upvr = #children
		if 0 < Parent_2_upvr then
			Parent_2_upvr = Scan
			Parent_2_upvr(children)
		end
	end
end
Scan(script.Parent:GetChildren())