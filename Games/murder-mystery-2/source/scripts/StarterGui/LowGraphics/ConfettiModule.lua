-- Decompiled with the Synapse X Luau decompiler.

local v1 = Vector2.new(0, 150);
local v2 = {};
local v3 = {};
if script.Parent.IgnoreGuiInset then
	local v4 = game.GuiService:GetGuiInset() or Vector2.new(0, 0);
else
	v4 = Vector2.new(0, 0);
end;
local v5 = Instance.new("Frame");
v5.Size = UDim2.new(0, 0, 0, 0);
v5.ZIndex = 80;
v5.AnchorPoint = Vector2.new(0.5, 0.5);
v5.BorderSizePixel = 0;
local u1 = script.Parent.AbsoluteSize.Y + v4.Y + 100;
local u2 = script.Parent.AbsoluteSize.X;
function updateScreenSize()
	u1 = script.Parent.AbsoluteSize.Y + 100;
	u2 = script.Parent.AbsoluteSize.X;
end;
updateScreenSize();
script.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(updateScreenSize);
for v6 = 1, 8 do
	table.insert(v2, (Color3.fromHSV(v6 / 8, 0.7, 0.9)));
end;
local l__math_random__3 = math.random;
local u4 = math.pi * 2;
local l__math_sin__5 = math.sin;
local l__math_cos__6 = math.cos;
function randomDirection(p1)
	local v7 = l__math_random__3() * u4;
	return Vector2.new(l__math_sin__5(v7), l__math_cos__6(v7)) * (p1 and 1);
end;
local u7 = 0;
local u8 = {};
function createConfetti(p2, p3)
	local v8 = 200 <= u7;
	if v8 then

	end;
	if not v8 then
		u7 = u7 + 1;
		local v9 = v2[l__math_random__3(1, #v2)];
		local v10, v11, v12 = Color3.toHSV(v9);
		local v13 = Color3.fromHSV(v10, v11, v12 * 0.7);
		local v14 = l__math_random__3() * 360;
		local v15 = {
			flickerTime = 0.5 * (0.75 + l__math_random__3() * 0.5), 
			rotVel = (l__math_random__3() * 2 - 1) * 360, 
			rot = v14, 
			color = v9, 
			darkColor = v13, 
			pos = (p2 or Vector2.new(0, 0)) + v4, 
			vel = p3 or Vector2.new(0, 0), 
			scale = (0.5 + l__math_random__3() * 0.5) * 1
		};
		local v16 = v5:Clone();
		v16.Rotation = v14;
		v16.BackgroundColor3 = v15.color;
		u8[v16] = v15;
		v16.Parent = script.Parent;
	end;
end;
function explode(p4, p5, p6)
	local v17 = p5 and 50;
	local v18 = p6 and 300;
	local v19 = 1 - 1;
	while true do
		createConfetti(p4, randomDirection(v18) * l__math_random__3() ^ 0.5);
		if 0 <= 1 then
			if v19 < v17 then

			else
				break;
			end;
		elseif v17 < v19 then

		else
			break;
		end;
		v19 = v19 + 1;	
	end;
end;
function rain(p7, p8)
	local v20 = p7 and 50;
	local v21 = p8 and 20;
	local v22 = 1 - 1;
	while true do
		createConfetti(Vector2.new(l__math_random__3() * u2, l__math_random__3() * -100), randomDirection(v21) * l__math_random__3() ^ 0.5);
		if 0 <= 1 then
			if v22 < v20 then

			else
				break;
			end;
		elseif v20 < v22 then

		else
			break;
		end;
		v22 = v22 + 1;	
	end;
end;
local l__math_abs__9 = math.abs;
game:GetService("RunService").Heartbeat:Connect(function(p9)
	local v23 = tick();
	local v24 = 0.61 ^ p9;
	for v25, v26 in pairs(u8) do
		if v25.Parent then
			local l__scale__27 = v26.scale;
			local v28 = v23 / v26.flickerTime % 1;
			if l__math_random__3() < 4 * p9 then
				v26.rotVel = v26.rotVel + (l__math_random__3() * 2 - 1) * 180;
				v26.vel = v26.vel + Vector2.new(100 * (l__math_random__3() * 2 - 1), 100 * (l__math_random__3() * 0.5));
			end;
			v26.vel = v26.vel * v24 + v1 * p9 * 1;
			v26.pos = v26.pos + v26.vel * p9;
			v26.rotVel = v26.rotVel * v24;
			v26.rot = v26.rot + v26.rotVel * p9;
			v25.BackgroundColor3 = v28 > 0.5 and v26.color or v26.darkColor;
			v25.Position = UDim2.new(0, v26.pos.x, 0, v26.pos.y);
			v25.Size = UDim2.new(0, 40 * l__scale__27, 0, 25 * l__math_abs__9(l__math_sin__5(v28 * u4)) * l__scale__27);
			v25.Rotation = v26.rot;
			if u1 < v25.AbsolutePosition.Y then
				v25:Destroy();
				u7 = u7 - 1;
				u8[v25] = nil;
			end;
		else
			u7 = u7 - 1;
			u8[v25] = nil;
		end;
	end;
end);
v3.CreateConfetti = createConfetti;
v3.Explode = explode;
v3.Rain = rain;
return v3;
