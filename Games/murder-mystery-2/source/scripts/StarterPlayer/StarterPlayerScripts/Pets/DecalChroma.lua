-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__TweenService__1 = game:GetService("TweenService");
	local v2 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
	local v3 = { l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(255, 0, 0)
		}), l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(255, 255, 0)
		}), l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(0, 255, 0)
		}), l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(0, 255, 255)
		}), l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(0, 0, 255)
		}), l__TweenService__1:Create(p1, v2, {
			Color3 = Color3.fromRGB(255, 0, 255)
		}) };
	while wait() do
		for v4, v5 in pairs(v3) do
			v5:Play();
			wait(1);
		end;	
	end;
end;
