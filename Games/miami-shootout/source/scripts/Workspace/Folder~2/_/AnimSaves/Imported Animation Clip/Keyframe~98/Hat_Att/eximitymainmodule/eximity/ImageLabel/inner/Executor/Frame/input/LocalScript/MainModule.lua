-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = {
	background = "255, 255, 255", 
	text = "0, 0, 0", 
	builtin = "0, 0, 127", 
	keyword = "0, 0, 127", 
	number = "0, 127, 127", 
	string = "127, 0, 127", 
	comment = "0, 127, 9"
};
local u2 = {
	background = "37, 37, 37", 
	text = "204, 204, 204", 
	builtin = "132, 214, 247", 
	keyword = "248, 109, 124", 
	number = "255, 198, 0", 
	string = "173, 241, 149", 
	comment = "102, 102, 102"
};
local l__HttpService__3 = game:GetService("HttpService");
local u4 = require(script.Lexer);
local l__UserInputService__5 = game:GetService("UserInputService");
function v1.SetTextBox(p1, p2)
	if not p1 or not p1:IsA("TextBox") then
		return;
	end;
	if p2 == true then
		p2 = u1;
	elseif not p2 then
		p2 = u2;
	else
		p2 = p2;
	end;
	local v2 = Instance.new("Folder", p1.Parent);
	local v3 = Instance.new("ScrollingFrame", v2);
	local v4 = Instance.new("ScrollingFrame", v2);
	local v5 = Instance.new("TextLabel", p1);
	local v6 = Instance.new("TextLabel", v4);
	local v7 = Instance.new("StringValue", p1);
	v2.Name = p1.Name;
	v3.Name = "Scroller";
	v3.Size = UDim2.new(p1.Size.X.Scale - 0, p1.Size.X.Offset - 15, p1.Size.Y.Scale, p1.Size.Y.Offset);
	v3.Position = UDim2.new(p1.Position.X.Scale + 0, p1.Position.X.Offset + 15, p1.Position.Y.Scale, p1.Position.Y.Offset);
	v3.CanvasSize = UDim2.new(0, 0, 0, 0);
	v3.BackgroundColor3 = p1.BackgroundColor3;
	v3.BorderColor3 = p1.BorderColor3;
	v3.ScrollBarImageColor3 = p1.TextColor3;
	v3.BackgroundTransparency = 1;
	v4.Name = "LineScroller";
	v4.Size = UDim2.new(0, 15, p1.Size.Y.Scale, p1.Size.Y.Offset);
	v4.Position = p1.Position;
	v4.CanvasSize = UDim2.new(0, 0, 0, 0);
	v4.BackgroundColor3 = p1.BackgroundColor3;
	v4.BorderColor3 = p1.BorderColor3;
	v4.ScrollBarThickness = 0;
	v4.LayoutOrder = 1;
	v4.ScrollingEnabled = false;
	v4.BackgroundTransparency = 1;
	p1.Parent = v3;
	p1.Size = UDim2.new(100, 0, 100, 0);
	p1.Position = UDim2.new(0, 5, 0, 0);
	p1.BackgroundTransparency = 1;
	p1.MultiLine = true;
	p1.ClearTextOnFocus = false;
	p1.Font = Enum.Font.Code;
	p1.TextWrapped = false;
	p1.TextScaled = false;
	p1.TextXAlignment = Enum.TextXAlignment.Left;
	p1.TextYAlignment = Enum.TextYAlignment.Top;
	v5.Name = "Visual";
	v5.Size = p1.Size;
	v5.Position = UDim2.new(0, -2, 0, 0);
	v5.BackgroundTransparency = 1;
	v5.Font = p1.Font;
	v5.TextColor3 = p1.TextColor3;
	v5.TextSize = p1.TextSize;
	v5.TextStrokeColor3 = p1.BackgroundColor3;
	v5.TextXAlignment = Enum.TextXAlignment.Left;
	v5.TextYAlignment = Enum.TextYAlignment.Top;
	v5.RichText = true;
	v6.Name = "LineCount";
	v6.Size = UDim2.new(1, 0, p1.Size.Y.Scale, p1.Size.Y.Offset);
	v6.Position = UDim2.new(0, 0, 0, 0);
	v6.BackgroundColor3 = p1.BackgroundColor3;
	v6.BorderColor3 = p1.BorderColor3;
	v6.Font = Enum.Font.Code;
	v6.Text = "1";
	v6.TextColor3 = p1.TextColor3;
	v6.TextSize = p1.TextSize;
	v6.TextYAlignment = Enum.TextYAlignment.Top;
	v6.TextWrapped = false;
	v6.BackgroundTransparency = 1;
	v7.Name = "Settings";
	v7.Value = l__HttpService__3:JSONEncode(p2);
	local u6 = 0;
	local u7 = 0;
	local u8 = tostring((math.floor(p1.BackgroundColor3.R * 255))) .. ", " .. tostring((math.floor(p1.BackgroundColor3.R * 255))) .. ", " .. tostring((math.floor(p1.BackgroundColor3.R * 255)));
	local u9 = p2;
	local function u10()
		if v6 then
			v6.Text = "";
			for v8 = 1, v5.TextBounds.Y / v5.TextSize do
				v6.Text = v6.Text .. tostring(v8);
				if v8 ~= v5.TextBounds.Y / v5.TextSize then
					v6.Text = v6.Text .. "\n";
				end;
			end;
		end;
		v3.CanvasSize = UDim2.new(0, p1.TextBounds.X + 15 + 5, 0, p1.TextBounds.Y);
		v4.CanvasSize = UDim2.new(0, 0, v3.CanvasSize.Y.Scale, v3.CanvasSize.Y.Offset);
		v4.CanvasPosition = Vector2.new(0, v3.CanvasPosition.Y);
		if v3.CanvasSize.X.Offset ~= u6 then
			v3.CanvasPosition = Vector2.new(v3.CanvasSize.X.Offset, v3.CanvasPosition.Y);
		end;
		if v3.CanvasSize.Y.Offset ~= u7 then
			v3.CanvasPosition = Vector2.new(v3.CanvasPosition.X, v3.CanvasSize.Y.Offset);
		end;
		u6 = v3.CanvasSize.X.Offset;
		u7 = v3.CanvasSize.Y.Offset;
	end;
	local u11 = false;
	local u12 = false;
	local u13 = nil;
	local u14 = nil;
	local u15 = nil;
	local u16 = nil;
	local u17 = nil;
	local u18 = nil;
	local u19 = nil;
	local u20 = nil;
	local u21 = {
		Size = p1.Size, 
		Position = p1.Position, 
		BackgroundTransparency = 1, 
		MultiLine = p1.MultiLine, 
		ClearTextOnFocus = p1.ClearTextOnFocus, 
		Font = p1.Font, 
		TextWrapped = p1.TextWrapped, 
		TextScaled = p1.TextScaled, 
		TextXAlignment = p1.TextXAlignment, 
		TextYAlignment = p1.TextYAlignment, 
		BackgroundColor3 = p1.BackgroundColor3, 
		TextColor3 = p1.TextColor3
	};
	local function u22()
		local v9 = "<font color=\"rgb(" .. u8 .. ")\">\226\128\134</font>";
		u9 = l__HttpService__3:JSONDecode(v7.Value);
		p1.BackgroundColor3 = Color3.fromRGB(tonumber(u9.background:split(",")[1]), tonumber(u9.background:split(",")[2]), tonumber(u9.background:split(",")[3]));
		p1.TextColor3 = Color3.fromRGB(tonumber(u9.text:split(",")[1]), tonumber(u9.text:split(",")[2]), tonumber(u9.text:split(",")[3]));
		v3.BackgroundColor3 = p1.BackgroundColor3;
		v6.BackgroundColor3 = v3.BackgroundColor3;
		v6.TextColor3 = p1.TextColor3;
		v5.TextColor3 = p1.TextColor3;
		v5.TextStrokeColor3 = p1.BackgroundColor3;
		if p1.Text:find("\t") then
			p1.Text = p1.Text:gsub("\t", "    ");
			p1.CursorPosition = p1.CursorPosition + 3;
		end;
		local v10, v11, v12 = u4.scan(p1.Text);
		while true do
			local v13, v14 = v10(v11, v12);
			if not v13 then
				break;
			end;
			local v15 = false;
			for v16, v17 in pairs(u9) do
				if v13 == v16 then
					v9 = v9 .. "<font color=\"rgb(" .. v17 .. ")\">" .. v14 .. "</font>";
					v15 = true;
				end;
			end;
			if not v15 then
				v9 = v9 .. v14;
			end;		
		end;
		v5.Text = v9:gsub("\n", "\n<font color=\"rgb(" .. u8 .. ")\">\226\128\140\226\128\139</font>");
		u10();
	end;
	u22();
	u13 = p1.Changed:Connect(function(p3)
		local v18 = true;
		local v19, v20, v21 = ipairs({ "Text", "Size", "Position", "Parent" });
		while true do
			v19(v20, v21);
			if not v19 then
				break;
			end;
			v21 = v19;
			if p3 == v20 then
				v18 = false;
			end;		
		end;
		if v18 then
			pcall(function()
				v3[p3] = p1[p3];
			end);
			pcall(function()
				v4[p3] = p1[p3];
			end);
			pcall(function()
				v5[p3] = p1[p3];
			end);
			pcall(function()
				v6[p3] = p1[p3];
			end);
		end;
	end);
	u14 = p1:GetPropertyChangedSignal("Text"):Connect(u22);
	u15 = v3:GetPropertyChangedSignal("CanvasPosition"):Connect(u10);
	u16 = v7:GetPropertyChangedSignal("Value"):Connect(function()
		local v22 = l__HttpService__3:JSONDecode(v7.Value);
		if v22 == true then
			local v23 = u1;
		elseif not v22 then
			v23 = u2;
		else
			v23 = v22;
		end;
		if not v23.Revert or v23.Revert ~= true then
			for v24, v25 in pairs(v23) do
				for v26, v27 in pairs(u9) do
					if v24 == v26 then
						u9[v24] = v25;
					end;
				end;
			end;
			u22();
			return;
		end;
		u13:Disconnect();
		u14:Disconnect();
		u15:Disconnect();
		u16:Disconnect();
		u17:Disconnect();
		u18:Disconnect();
		u19:Disconnect();
		u20:Disconnect();
		p1.Parent = v2.Parent;
		for v28, v29 in pairs(u21) do
			pcall(function()
				p1[v28] = v29;
			end);
		end;
		v7:Destroy();
		v5:Destroy();
		v2:Destroy();
	end);
	u17 = l__UserInputService__5.InputBegan:Connect(function(p4)
		if p4.UserInputType == Enum.UserInputType.Keyboard and p4.KeyCode == Enum.KeyCode.LeftControl then
			u11 = true;
		end;
	end);
	u18 = l__UserInputService__5.InputChanged:Connect(function(p5)
		if p5.UserInputType == Enum.UserInputType.MouseWheel and u11 and u12 then
			if p5.Position.Z > 0 and p1.TextSize < 21 then
				p1.TextSize = p1.TextSize + 1;
				return;
			end;
			if p5.Position.Z < 1 and p1.TextSize > 2 then
				p1.TextSize = p1.TextSize - 1;
			end;
		end;
	end);
	u19 = l__UserInputService__5.InputEnded:Connect(function(p6)
		if p6.UserInputType == Enum.UserInputType.Keyboard and p6.KeyCode == Enum.KeyCode.LeftControl then
			u11 = false;
		end;
	end);
	u20 = p1.MouseEnter:Connect(function()
		u12 = true;
	end);
	u20 = p1.MouseLeave:Connect(function()
		u12 = false;
	end);
end;
function v1.ModifyTextBox(p7, p8)
	if not p7 or not p7:IsA("TextBox") then
		return;
	end;
	if not p7:FindFirstChild("Settings") then
		return;
	end;
	if p8 == true then
		local v30 = u1;
	elseif not p8 then
		v30 = u2;
	else
		v30 = p8;
	end;
	p7.Settings.Value = l__HttpService__3:JSONEncode(v30);
end;
function v1.RevertTextBox(p9)
	if not p9 or not p9:IsA("TextBox") then
		return;
	end;
	if not p9:FindFirstChild("Settings") then
		return;
	end;
	p9.Settings.Value = l__HttpService__3:JSONEncode({
		Revert = true
	});
end;
return v1;
