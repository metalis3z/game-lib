-- Decompiled with the Synapse X Luau decompiler.

local v1 = UDim2.new(0, 314, 0, 31);
script.Parent.Parent.Size = v1;
script.Parent.Parent.line.BackgroundTransparency = 1;
local u1 = false;
local u2 = false;
local u3 = UDim2.new(0, 314, 0, 169);
script.Parent.MouseButton1Click:Connect(function()
	if u1 == false and u2 == false then
		coroutine.resume(coroutine.create(function()
			script.Parent.Parent:TweenSize(u3, "Out", "Sine", 0.45);
			u1 = true;
			game:GetService("TweenService"):Create(script.Parent.Parent.line, TweenInfo.new(0.45), {
				BackgroundTransparency = 0
			}):Play();
		end));
		spawn(function()
			u2 = true;
			wait(0.45);
			u2 = false;
		end);
		return;
	end;
	if u1 == true and u2 == false then
		coroutine.resume(coroutine.create(function()
			script.Parent.Parent:TweenSize(v1, "Out", "Sine", 0.45);
			u1 = false;
			game:GetService("TweenService"):Create(script.Parent.Parent.line, TweenInfo.new(0.45), {
				BackgroundTransparency = 1
			}):Play();
		end));
		spawn(function()
			u2 = true;
			wait(0.45);
			u2 = false;
		end);
	end;
end);
