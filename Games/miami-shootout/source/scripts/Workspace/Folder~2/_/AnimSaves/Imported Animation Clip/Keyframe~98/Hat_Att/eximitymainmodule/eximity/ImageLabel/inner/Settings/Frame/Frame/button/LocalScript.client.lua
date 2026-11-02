-- Decompiled with the Synapse X Luau decompiler.

function tweenBack(p1, p2, p3)
	game:GetService("TweenService"):Create(p1, TweenInfo.new(0.5), {
		BackgroundColor3 = p2
	}):Play();
end;
function tweenText(p4, p5, p6)
	game:GetService("TweenService"):Create(p4, TweenInfo.new(0.5), {
		TextColor3 = p5
	}):Play();
end;
function tweenImage(p7, p8, p9)
	game:GetService("TweenService"):Create(p7, TweenInfo.new(0.5), {
		ImageColor3 = p8
	}):Play();
end;
function setCOLOR(p10, p11, p12)
	local v1 = string.split(p11, ",");
	local v2 = Color3.fromRGB(tonumber(v1[1]), tonumber(v1[2]), tonumber(v1[3]));
	if p10:IsA("Frame") then
		if p10.BackgroundColor3 == p12 then
			tweenBack(p10, v2);
			return;
		end;
	end;
	if p10:IsA("TextLabel") then
		if p10.TextColor3 == p12 then
			tweenText(p10, v2);
			return;
		end;
	end;
	if p10:IsA("TextBox") then
		if p10.TextColor3 == p12 then
			tweenText(p10, v2);
			return;
		end;
	end;
	if p10:IsA("TextButton") then
		if p10.TextColor3 == p12 then
			tweenText(p10, v2);
			return;
		end;
	end;
	if p10:IsA("ImageLabel") then
		if p10.ImageColor3 == p12 then
			tweenImage(p10, v2);
		end;
	end;
end;
script.Parent.MouseButton1Click:Connect(function()
	local l__Parent__1 = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent;
	local l__Text__2 = script.Parent.Parent.input.Text;
	local l__ColorVa__3 = script.Parent.Parent.Parent.ColorVa;
	coroutine.resume(coroutine.create(function()
		for v3, v4 in pairs(l__Parent__1:GetDescendants()) do
			setCOLOR(v4, l__Text__2, l__ColorVa__3.Value);
		end;
	end));
	local v5 = string.split(l__Text__2, ",");
	l__ColorVa__3.Value = Color3.fromRGB(tonumber(v5[1]), tonumber(v5[2]), tonumber(v5[3]));
end);
