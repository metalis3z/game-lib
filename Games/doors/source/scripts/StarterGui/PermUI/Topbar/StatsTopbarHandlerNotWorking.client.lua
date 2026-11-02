-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__TweenService__2 = game:GetService("TweenService");
local l__TextService__3 = game:GetService("TextService");
local v4 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("NumberConvert"));
local v5, v6 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"))();
if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("InGame").Value == false then
	script.Parent:WaitForChild("UIPadding").PaddingRight = UDim.new(0, 72);
end;
for v7, v8 in pairs(script:WaitForChild("StatModules"):GetChildren()) do
	local v9 = Instance.new("IntValue");
	v9.Name = v8.Name .. "Val";
	v9.Parent = v8;
	v9.Value = 0;
	local u1 = require(v8);
	local u2 = v5;
	local u3 = v6;
	local u4 = 0;
	local u5 = script.Parent:FindFirstChild(v8.Name);
	local function v10(p1)
		if p1 ~= nil then
			p1 = tonumber(p1);
		else
			p1 = u1.value;
		end;
		if type(p1) ~= "number" then
			return;
		end;
		local v11, v12 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"))();
		u2 = v11;
		u3 = v12;
		if u2 == "console" then
			script.Parent.UIScale.Scale = 1.5;
		else
			script.Parent.UIScale.Scale = 1;
		end;
		if not u4 then
			return;
		end;
		u4 = p1;
		u5.Size = UDim2.new(0, l__TextService__3:GetTextSize(tostring(p1), 40, "Oswald", Vector2.new(999, 999)).X, 1.5, 0);
		u5.TextSize = 40;
		if u4 < p1 then
			u5.TextColor3 = u5:GetAttribute("FadeIncrease");
			u5.SoundIncrease:Play();
		elseif p1 < u4 then
			u5.TextColor3 = u5:GetAttribute("FadeDecrease");
			u5.SoundDecrease:Play();
			if v8.Name == "Boosts" then
				script.Parent.BoostActive.Visible = true;
				u5.Visible = false;
			end;
		end;
		l__TweenService__2:Create(u5, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0, l__TextService__3:GetTextSize(tostring(p1), 30, "Oswald", Vector2.new(999, 999)).X, 1, 0), 
			TextSize = 30, 
			TextColor3 = Color3.new(1, 1, 1)
		}):Play();
		l__TweenService__2:Create(u5, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.new(1, 1, 1)
		}):Play();
		l__TweenService__2:Create(v9, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Value = tonumber(p1)
		}):Play();
		if p1 <= 0 then
			task.delay(0.4, function()
				u5.Visible = false;
			end);
		else
			u5.Visible = true;
			task.delay(0.41, function()
				u5.Visible = true;
			end);
		end;
		if v8.Name == "Boosts" and p1 < u4 then
			script.Parent.BoostActive.Visible = true;
			task.delay(0.5, function()
				u5.Visible = false;
			end);
		end;
	end;
	v9.Changed:Connect(function(p2)
		u5.Text = v4(p2);
	end);
	if v8.Name == "Gold" then
		local u6 = tick();
		game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("GetGold").OnClientEvent:Connect(function(p3, p4)
			u6 = tick() + 0.6;
			local l__CurrentCamera__13 = workspace.CurrentCamera;
			for v14 = 1, math.ceil(math.clamp(p4 / 6, 1, 25)) do
				task.delay(v14 / 60, function()
					local v15, v16 = l__CurrentCamera__13:WorldToScreenPoint(p3);
					local v17 = script.Parent.Parent.Gold:Clone();
					v17.Visible = true;
					v17.Name = "GoldLive";
					v17.Position = UDim2.new(0, v15.X, 0, v15.Y);
					v17.Parent = script.Parent.Parent;
					v17.Sound.Pitch = 1 + math.random(-100, 100) / 1000;
					v17.Sound:Play();
					u5.Visible = true;
					local l__AbsolutePosition__18 = u5.Icon.AbsolutePosition;
					local l__AbsoluteSize__19 = u5.Icon.AbsoluteSize;
					l__TweenService__2:Create(v17, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
						Size = UDim2.new(0, l__AbsoluteSize__19.X, 0, l__AbsoluteSize__19.Y), 
						Position = UDim2.new(0, l__AbsolutePosition__18.X + l__AbsoluteSize__19.X / 2, 0, l__AbsolutePosition__18.Y + l__AbsoluteSize__19.Y), 
						AnchorPoint = Vector2.new(0, 0)
					}):Play();
					local v20 = (Vector2.new(math.random(-25, 25), math.random(-25, 25)) + Vector2.new(0, 0.00123)).unit * (math.random(1, 25) / 25);
					l__TweenService__2:Create(v17, TweenInfo.new(0.24875621890547267, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Position = UDim2.new(0.5 + v20.X, 0, 0.5 + v20.Y, 0)
					}):Play();
					v17.Sound.Pitch = 1 + math.random(-100, 100) / 1000;
					v17.Sound:Play();
					task.wait(0.25);
					l__TweenService__2:Create(v17, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						Position = UDim2.new(0.8, 0, 0.01, 0), 
						ImageTransparency = 1
					}):Play();
					task.wait(0.25);
					v17:Destroy();
				end);
			end;
		end);
		u1.event.Event:Connect(function(p5)
			task.wait(0.2);
			task.wait((math.max(u6 - tick(), 0)));
			if u6 ~= u6 then
				return;
			end;
			v10();
		end);
	else
		u1.event.Event:Connect(v10);
	end;
	v10();
	wait(5);
	v10();
end;
