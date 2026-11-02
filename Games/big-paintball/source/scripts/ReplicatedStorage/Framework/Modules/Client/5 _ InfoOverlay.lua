local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:FindFirstChild("PlayerGui");
local l__InfoOverlay__2 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("InfoOverlay");
local u2 = nil;
local u3 = {};
local l__Blocks__4 = l__InfoOverlay__2:WaitForChild("Blocks");
local u5 = {};
local u6 = nil;
local u7 = game:GetService("GuiService"):GetGuiInset();
local u8 = {};
function u3.Add(p1, ...)
	if u2 then
		u3.Remove();
	end;
	local v3 = l__InfoOverlay__2:FindFirstChild("Base"):Clone();
	local v4 = 0;
	for v5, v6 in ipairs({ ... }) do
		local v8 = v6[1];
		local v9 = l__Blocks__4:FindFirstChild(v8):Clone();
		local l__settings__10 = v9:FindFirstChild("settings");
		if l__settings__10 and l__settings__10:FindFirstChild("code") then
			coroutine.wrap(function()
				(u5[v8] or require(l__settings__10:FindFirstChild("code")))(v9, unpack(v6));
			end)();
		end;
		if l__settings__10 and l__settings__10:FindFirstChild("sort") then
			v9.LayoutOrder = v5 * 100 + l__settings__10:FindFirstChild("sort").Value;
		else
			v9.LayoutOrder = v5 * 100;
		end;
		if l__settings__10 then
			local l__Value__11 = l__settings__10:FindFirstChild("minSizeX").Value;
			local l__Value__12 = l__settings__10:FindFirstChild("maxSizeX").Value;
			local v13 = 0;
			local v14 = 0;
			local v15 = 0;
			for v16, v17 in ipairs(v9:GetChildren()) do
				if v17.ClassName == "TextLabel" or v17.ClassName == "TextButton" then
					if v17.Size.X.Scale ~= 0 then
						local v19 = u1.TextService:GetTextSize(string.gsub(v17.Text, "<.->", function(p2)
							return "";
						end), v17.TextSize, v17.Font, (Vector2.new(l__Value__12 * v17.Size.X.Scale, 1000))) + Vector2.new(6, 1);
						v13 = v13 < v19.X and v19.X or v13;
						v14 = v14 + v19.Y;
						v17.Size = UDim2.new(0, v19.X, 0, v19.Y);
					end;
				elseif v17:IsA("GuiObject") and v17.Size.X.Scale ~= 0 then
					v15 = v15 + v17.AbsoluteSize.Y;
				end;			
			end;
			v9.Size = UDim2.new(1, 0, 0, v14 + v15);
			local v20 = math.clamp(v13, l__Value__11, l__Value__12);
			v4 = v4 < v20 and v20 or v4;
		end;
		v9.Parent = v3.Frame.Blocks;	
	end;
	local l__UIListLayout__21 = v3.Frame.Blocks.UIListLayout;
	l__UIListLayout__21:ApplyLayout();
	v3.Size = UDim2.new(0, v4 + 10, 0, l__UIListLayout__21.AbsoluteContentSize.Y + 10);
	v3.UIScale.Scale = 1 - (1 - u1.Functions.ResolutionScale()) / 2;
	if not u6 then
		u6 = Instance.new("ScreenGui");
		u6.DisplayOrder = 100;
		u6.ZIndexBehavior = Enum.ZIndexBehavior.Global;
		u6.ResetOnSpawn = false;
		u6.Name = "InfoOverlay";
		u6.Parent = u1.Player.Get("PlayerGui");
	end;
	v3.Parent = u6;
	u2 = v3;
	u1.GUI.ToggleCursor(false);
	coroutine.wrap(function()
		local v22 = tick();
		local v23 = v3.Frame:Clone();
		v23:ClearAllChildren();
		v23.Size = UDim2.new(1, 0, 1, 0);
		v23.Position = UDim2.new(0.5, 0, 0.5, 0);
		v23.AnchorPoint = Vector2.new(0.5, 0.5);
		v23.ImageTransparency = 0.5;
		v23.ImageColor3 = Color3.new(1, 1, 1);
		v23.ZIndex = 99;
		v23.Name = "FLASH-FX";
		v23.Parent = v3.Frame;
		local v24 = v3.pointer:Clone();
		v24:ClearAllChildren();
		v24.Size = UDim2.new(1, 0, 1, 0);
		v24.Position = UDim2.new(0.5, 0, 0.5, 0);
		v24.AnchorPoint = Vector2.new(0.5, 0.5);
		v24.ImageTransparency = 0.5;
		v24.ImageColor3 = Color3.new(1, 1, 1);
		v24.ZIndex = 99;
		v24.Name = "FLASH-FX";
		v24.Parent = v3.pointer;
		while tick() - v22 < 0.15 and v3 and v3.Parent do
			if u2 ~= v3 then
				break;
			end;
			local v25 = math.clamp((tick() - v22) / 0.15, 0, 1) / 2 + 0.5;
			local v26 = u1.Functions.Easing(0.15, "Quad", "Out");
			v23.ImageTransparency = v25;
			v24.ImageTransparency = v25;
			u1.RenderStepped();		
		end;
		if v23 and v24 then
			v23:Destroy();
			v24:Destroy();
		end;
	end)();
	local u9 = "Right";
	local u10 = "Down";
	coroutine.wrap(function()
		while v3 and v3.Parent do
			local v27 = u1.Player.Get("Mouse").X;
			local v28 = u1.Player.Get("Mouse").Y;
			local l__X__29 = v3.AbsoluteSize.X;
			local l__Y__30 = v3.AbsoluteSize.Y;
			if u1.Variables.Console then
				v27 = p1.AbsolutePosition.X + p1.AbsoluteSize.X / 1.5;
				v28 = p1.AbsolutePosition.Y + p1.AbsoluteSize.Y / 1.5;
			end;
			if v27 + l__X__29 + 10 < game.Workspace.CurrentCamera.ViewportSize.X - u7.X then
				u9 = "Right";
			elseif v27 - l__X__29 - 10 > 0 then
				u9 = "Left";
			end;
			if v28 + l__Y__30 + 10 < game.Workspace.CurrentCamera.ViewportSize.Y - u7.Y then
				u10 = "Down";
			elseif v28 - l__Y__30 - 10 > 0 then
				u10 = "Up";
			end;
			local v31
			if u9 == "Right" then
				v31 = 0;
			else
				v31 = 1;
			end;
			local v32
			if u10 == "Down" then
				v32 = 0;
			else
				v32 = 1;
			end;
			v3.AnchorPoint = Vector2.new(v31, v32);
			local v33
			if u9 == "Right" then
				v33 = 10;
			else
				v33 = -10;
			end;
			local v34
			if u10 == "Down" then
				v34 = 10;
			else
				v34 = -10;
			end;
			v3.Position = UDim2.new(0, v27 + v33, 0, v28 + v34);
			local v35
			if u9 == "Right" then
				v35 = 1;
			else
				v35 = 0;
			end;
			local v36 
			if u10 == "Down" then
				v36 = 1;
			else
				v36 = 0;
			end;
			v3.pointer.AnchorPoint = Vector2.new(v35, v36);
			local v37
			if u9 == "Right" then
				v37 = 0;
			else
				v37 = 1;
			end;
			local v38
			if u9 == "Right" then
				v38 = 10;
			else
				v38 = -10;
			end;
			local v39 
			if u10 == "Down" then
				v39 = 0;
			else
				v39 = 1;
			end;
			local v40
			if u10 == "Down" then
				v40 = 10;
			else
				v40 = -10;
			end;
			v3.pointer.Position = UDim2.new(v37, v38, v39, v40);
			if u9 == "Right" and u10 == "Down" then
				v3.pointer.Rotation = 0;
			elseif u9 == "Left" and u10 == "Down" then
				v3.pointer.Rotation = 90;
			elseif u9 == "Right" and u10 == "Up" then
				v3.pointer.Rotation = -90;
			else
				v3.pointer.Rotation = -180;
			end;
			u1.RenderStepped();		
		end;
	end)();
	coroutine.wrap(function()
		while v3 and v3.Parent do
			local l__X__41 = u1.Player.Get("Mouse").X;
			local l__Y__42 = u1.Player.Get("Mouse").Y;
			local l__X__43 = p1.AbsolutePosition.X;
			local l__Y__44 = p1.AbsolutePosition.Y;
			if not u1.Variables.Console then
				if l__X__43 + p1.AbsoluteSize.X < l__X__41 or l__X__41 < l__X__43 or l__Y__44 + p1.AbsoluteSize.Y < l__Y__42 or l__Y__42 < l__Y__44 then
					u3.Remove();
				end;
			elseif u1.GuiService.SelectedObject ~= p1 then
				u3.Remove();
			end;
			u1.RenderStepped();		
		end;
	end)
	if u1.Variables.Mobile then
		local u11 = nil;
		local u12 = tick();
		u11 = p1.MouseButton1Up:Connect(function()
			u11:Disconnect();
			if tick() - u12 < 0.5 then
				u3.Remove();
			end;
		end);
		u8[#u8 + 1] = u11;
	end;
end;
function u3.Remove()
	if u2 then
		for v45, v46 in ipairs(u8) do
			v46:Disconnect();		
		end;
		u8 = {};
		u2:Destroy();
		u1.GUI.ToggleCursor(true);
		u2 = nil;
	end;
end;
table.freeze(u3);
return u3;
