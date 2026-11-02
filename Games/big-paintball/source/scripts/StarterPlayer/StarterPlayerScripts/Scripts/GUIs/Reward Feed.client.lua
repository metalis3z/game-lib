-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local u1 = 0;
local u2 = {
	gui = nil, 
	total = nil, 
	t = nil, 
	label = nil, 
	labelt = nil
};
local v6
local v13
local u3 = Color3.fromRGB(239, 255, 58);
local l__RewardFeed__4 = v1.GUI.RewardFeed;
function AddFeedItem(p1, p2, p3, p4)
	local v2 = tick();
	local v3 = false;
	p2 = tonumber(p2);
	p1 = tostring(p1);
	u1 = u1 + 1;
	local v4 = script.Feed:Clone();
	local l__UIScale__5 = v4:WaitForChild("UIScale");
	v4.Label.Text = p1;
	v4.Amount.Text = v1.Functions.Commas(p2);
	v4.LayoutOrder = 999999999 - u1;
	if u2.gui then
		if 3 < tick() - u2.t then
			u2.gui = v4;
			u2.total = p2;
			u2.label = p1;
			u2.t = tick();
			u2.labelt = tick();
			v4.Amount.TextColor3 = u3;
			v4.Icon.ImageColor3 = u3;
			v4.Size = UDim2.new(1, 0, 0.05, 15);
			v4.LayoutOrder = 0;
			v3 = true;
		elseif u2.gui then
			if p4 then
				v6 = 0;
			else
				v6 = p2;
			end;
			u2.total = u2.total + v6;
			u2.t = tick();
			if p3 then
				u2.label = p1;
				u2.labelt = tick();
			end;
		end;
	else
		u2.gui = v4;
		u2.total = p2;
		u2.label = p1;
		u2.t = tick();
		u2.labelt = tick();
		v4.Amount.TextColor3 = u3;
		v4.Icon.ImageColor3 = u3;
		v4.Size = UDim2.new(1, 0, 0.05, 15);
		v4.LayoutOrder = 0;
		v3 = true;
	end;
	if p3 then
		coroutine.wrap(function()
			local l__labelt__7 = u2.labelt;
			while true do
				if u2.gui then

				else
					break;
				end;
				if u2.labelt == l__labelt__7 then

				else
					break;
				end;
				if tick() - u2.t <= 3 then

				else
					break;
				end;
				v1.RenderStepped();			
			end;
			if u2.labelt ~= l__labelt__7 then
				AddFeedItem(p1, p2, false, true);
			end;
		end)();
		if not v3 then
			return;
		end;
	end;
	v4.Parent = l__RewardFeed__4.Frame;
	l__RewardFeed__4.Frame:WaitForChild("UIListLayout"):ApplyLayout();
	v4:WaitForChild("UIListLayout"):ApplyLayout();
	coroutine.wrap(function()
		local l__TextColor3__8 = v4.Amount.TextColor3;
		while true do
			if v4 then

			else
				break;
			end;
			if v4.Parent then

			else
				break;
			end;
			local v9 = v3 and tick() - u2.t or tick() - v2;
			local v10 = Color3.new(1, 1, 1):Lerp(l__TextColor3__8, (v1.Functions.Easing(math.clamp(v9 / 0.7, 0, 1), "Back", "Out")));
			v4.Amount.TextColor3 = v10;
			v4.Icon.ImageColor3 = v10;
			if v3 then
				l__UIScale__5.Scale = 1 + (1 - v1.Functions.Easing(math.clamp(v9 / 0.2, 0, 1), "Expo", "Out")) * 2.5;
			end;
			v1.RenderStepped();		
		end;
		if v4 then
			if v4.Parent then
				v4.Amount.TextColor3 = l__TextColor3__8;
			end;
		end;
	end)();
	coroutine.wrap(function()
		while true do
			if v4 then

			else
				break;
			end;
			if v4.Parent then

			else
				break;
			end;
			if v3 then
				if u2.gui == v4 then
					if not (tick() - u2.t <= 3) then
						if tick() - v2 <= 3 then

						else
							break;
						end;
					end;
				elseif tick() - v2 <= 3 then

				else
					break;
				end;
			elseif tick() - v2 <= 3 then

			else
				break;
			end;
			local v11 = v1.Functions.Easing(math.clamp((v3 and tick() - u2.t or tick() - v2) / 3, 0, 1), "Expo", "In");
			v4.Amount.TextTransparency = v11;
			v4.Icon.ImageTransparency = v11;
			v4.Label.TextTransparency = v11;
			if v3 then
				local v12 = 1 + math.max(string.len(v4.Amount.Text) - 4, 0) / 4;
				v4.Amount.Size = UDim2.new(0.1 * v12, 40 * v12, 1, 0);
				v4.Amount.Text = v1.Functions.Commas(u2.total);
				v4.Label.Text = u2.label;
			end;
			v1.RenderStepped();		
		end;
		if v4 then
			if v4.Parent then
				v4:Destroy();
			end;
		end;
	end)();
end;
v1.Network.Fired("Killed Player"):Connect(function(p5, p6, p7)
	if game.Workspace:WaitForChild("__VARIABLES"):WaitForChild("DoubleCredits").Value == true then
		v13 = 2;
	else
		v13 = 1;
	end;
	if not p6 then
		AddFeedItem(string.format("Tagged %s!", p5.DisplayName), v1.Shared.getKillReward(v1.Variables.Killstreak) * v13, true);
		return;
	end;
	AddFeedItem(string.format("Tagged %s with a %s!", p5.DisplayName, p7 and p7 or "gadget"), v1.Shared.getKillReward(v1.Variables.Killstreak) * v13, true);
end);
v1.Network.Fired("New Reward Item"):Connect(function(...)
	AddFeedItem(...);
end);
v1.Signal.Fired("New Reward Item"):Connect(function(...)
	AddFeedItem(...);
end);
