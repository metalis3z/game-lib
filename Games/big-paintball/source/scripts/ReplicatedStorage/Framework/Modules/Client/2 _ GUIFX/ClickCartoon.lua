-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__3 = u1.Settings.UIEasingStyle;
return function(p1)
	local v4 = {};
	v4[#v4 + 1] = p1.Activated:Connect(function()
		local v5 = 1 - 1;
		while true do
			local u2 = v5;
			coroutine.wrap(function()
				local v6 = p1.AbsoluteSize.X + 6;
				local v7 = p1.AbsoluteSize.Y + 6;
				local v8 = Instance.new("ImageLabel");
				v8.Image = "rbxassetid://3134005313";
				v8.BackgroundTransparency = 1;
				v8.BorderSizePixel = 0;
				v8.AnchorPoint = Vector2.new(0.5, 0.5);
				v8.Size = UDim2.new(0, v6, 0, v7);
				v8.Rotation = math.random(0, 360);
				v8.Position = UDim2.new(0, p1.AbsolutePosition.X + v6 / 2, 0, p1.AbsolutePosition.Y + v7 / 2);
				v8.Parent = u1.GUIFX.GetHolder();
				local v9 = tick();
				local v10
				if u2 == 1 then
					v10 = 0.1;
				else
					v10 = 0.2;
				end;
				while true do
					local v11 = nil;
					if not v8 then
						break;
					end;
					if not p1 then
						break;
					end;
					if not (tick() - v9 < v10) then
						break;
					end;
					v11 = (tick() - v9) * 50;
					if u2 == 1 then
						local v12 = math.abs(math.sin(v11 / 5) * 15);
						v8.Size = UDim2.new(0, v6 + v12, 0, v7 + v12);
					else
						local v13 = math.abs(math.sin(v11 / 5) * 30);
						v8.Size = UDim2.new(0, v6 + v13, 0, v7 + v13);
						v8.ImageTransparency = v11 / 10;
					end;
					u1.RenderStepped();				
				end;
				v8:Destroy();
			end)();
			if 0 <= 1 then
				if not (u2 < 2) then
					break;
				end;
			elseif not (u2 > 2) then
				break;
			end;
			u2 = u2 + 1;		
		end;
	end);
	local u3 = v4;
	return function()
		for v14, v15 in ipairs(u3) do
			v15:disconnect();		
		end;
		u3 = nil;
	end;
end;
