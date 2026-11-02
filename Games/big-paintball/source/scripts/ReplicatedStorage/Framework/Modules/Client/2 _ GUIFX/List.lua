-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
return function(p1, p2, p3, p4)
	if p3 == nil then

	end;
	p3 = p3;
	local v2
	if p4 == nil then
		v2 = true;
	else
		v2 = p4;
	end;
	p4 = v2;
	if not u1.Functions.IsArray(p2) then
		local v3 = {};
		for v4, v5 in pairs(p2) do
			table.insert(v3, { v4, v5 });
		end;
		p2 = v3;
	end;
	local u3 = nil;
	local u4 = type(p2[1]) == "table";
	local u5 = nil;
	local u6 = false;
	local u7 = {};
	local u8 = Instance.new("BindableEvent");
	local u9 = false;
	local function u10()
		if not u3 then
			return;
		end;
		u5 = u1.Functions.FastTween(u3, {
			Size = UDim2.new(1, 0, 0, 0)
		}, { 0.1 });
		u5.Completed:Connect(function()
			if not u6 then
				for v6, v7 in ipairs(u7) do
					u7[v6]:Disconnect();				
				end;
				u7 = {};
				u3:Destroy();
				u3 = nil;
			end;
		end);
		u8:Fire(false);
	end;
	local u11 = Instance.new("BindableEvent");
	local function u12()
		if u3 and u4 then
			local l__list__9 = u3:FindFirstChild("list");
			for v10, v11 in ipairs(p2) do
				local v13 = nil;
				v13 = l__list__9:FindFirstChild(v11[1]);
				if v11[2] then
					u1.Functions.FastTween(v13:FindFirstChild("Enabled"), {
						BackgroundTransparency = 0.7
					}, { 0.15, nil, "Out" });
				else
					u1.Functions.FastTween(v13:FindFirstChild("Enabled"), {
						BackgroundTransparency = 1
					}, { 0.15, nil, "Out" });
				end;			
			end;
		end;
	end;
	local function u13()
		if not u3 then
			u3 = l__Assets__2.List.Base:Clone();
			u3.Size = UDim2.new(1, 0, 0, 0);
			u3.AnchorPoint = Vector2.new(0.5, 0);
			u3.Position = UDim2.new(0.5, 0, 1, 0);
			u3.Name = "__LIST";
			u3.ZIndex = p1.ZIndex + 5;
			u3.Parent = p1;
			local v14 = l__Assets__2.List.BaseScroll:Clone();
			v14.AnchorPoint = Vector2.new(0.5, 0.5);
			v14.Position = UDim2.new(0.5, 0, 0.5, 0);
			v14.Size = UDim2.new(1, 0, 1, 0);
			v14.CanvasSize = UDim2.new(1, 0, 1, 0);
			v14.Name = "list";
			v14.ZIndex = u3.ZIndex;
			v14.Parent = u3;
			for v15, v16 in ipairs(p2) do
				local v18 = type(v16) == "table" and v16[1] or v16;
				if type(v16) == "table" then

				end;
				local v19 = l__Assets__2.List.Block:Clone();
				v19.Size = UDim2.new(v19.Size.X.Scale, 0, 0, 1000);
				v19.Text = v18;
				v19.TextScaled = false;
				v19.LayoutOrder = v15;
				v19.TextWrapped = true;
				v19.Name = v18;
				v19.ZIndex = u3.ZIndex;
				v19.Parent = v14;
				u7[#u7 + 1] = v19.Activated:Connect(function()
					if not u9 then
						u9 = true;
						if p4 then
							u10();
						end;
						if not u4 then
							u11:Fire(v18);
						elseif u4 and p3 then
							v16[2] = not v16[2];
							u11:Fire(v18, v16[2]);
						elseif u4 and not v16[2] then
							v16[2] = not v16[2];
							for v20, v21 in ipairs(p2) do
								if v21[1] ~= v16[1] then
									v21[2] = false;
								end;							
							end;
							u11:Fire(v18, v16[2]);
						end;
						u12();
						u9 = false;
					end;
				end);
				coroutine.wrap(function()
					while v19 and u3 and u3.Parent do
						v19.Size = UDim2.new(v19.Size.X.Scale, 0, 0, math.max(v19.TextBounds.Y + 6, 40));
						u1.RenderStepped();					
					end;
				end)();			
			end;
			local v23 = Instance.new("UIListLayout");
			v23.HorizontalAlignment = Enum.HorizontalAlignment.Center;
			v23.SortOrder = Enum.SortOrder.LayoutOrder;
			v23.VerticalAlignment = Enum.VerticalAlignment.Bottom;
			v23.Parent = v14;
			coroutine.wrap(function()
				while u3 and u3.Parent do
					v23:ApplyLayout();
					if u3.AbsoluteSize.Y < 20 then
						v14.CanvasSize = UDim2.new(1, 0, 0, 0);
					else
						v14.CanvasSize = UDim2.new(1, 0, 0, v23.AbsoluteContentSize.Y);
					end;
					if u1.Player.Get("Camera").ViewportSize.Y - 36 <= p1.AbsolutePosition.Y + p1.AbsoluteSize.Y + u3.AbsoluteSize.Y then
						u3.AnchorPoint = Vector2.new(0.5, 1);
						u3.Position = UDim2.new(0.5, 0, 0, 0);
					else
						u3.AnchorPoint = Vector2.new(0.5, 0);
						u3.Position = UDim2.new(0.5, 0, 1, 0);
					end;
					u1.RenderStepped();				
				end;
			end)();
		end;
		u5 = u1.Functions.FastTween(u3, {
			Size = UDim2.new(1, 0, 0, math.min(#p2 * 40, 200))
		}, { 0.1 });
		u8:Fire(true);
		u12();
	end;
	local u14 = nil;
	u14 = p1.Activated:Connect(function()
		u6 = not u6;
		if u6 then
			u13();
			return;
		end;
		u10();
	end);
	return u11, function()
		u14:Disconnect();
		u11:Destroy();
		u8:Destroy();
		if u6 then
			u10();
		end;
	end, u8;
end;
