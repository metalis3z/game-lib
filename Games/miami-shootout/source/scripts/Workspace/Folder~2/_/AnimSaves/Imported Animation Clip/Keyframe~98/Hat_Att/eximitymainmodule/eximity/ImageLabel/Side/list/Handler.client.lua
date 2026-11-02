-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
for v2, v3 in pairs(script.Parent:GetChildren()) do
	if v3:IsA("ImageButton") then
		table.insert(v1, v3);
	end;
end;
wait(0.01);
function changePage(p1, p2, p3)
	local l__TweenService__4 = game:GetService("TweenService");
	local v5 = TweenInfo.new(p3, Enum.EasingStyle.Sine);
	local l__fade__6 = script.Parent.Parent.Parent.fade;
	local v7 = l__TweenService__4:Create(l__fade__6, v5, {
		BackgroundTransparency = 1
	});
	l__TweenService__4:Create(l__fade__6, v5, {
		BackgroundTransparency = 0
	}):Play();
	wait(p3);
	script.Parent.Parent.Parent.inner[p1].Visible = false;
	script.Parent.Parent.Parent.inner[p2].Visible = true;
	script.Parent.openPage.Value = p2;
	v7:Play();
end;
for v8, v9 in pairs(v1) do
	v9.MouseButton1Down:Connect(function()
		changePage(script.Parent.openPage.Value, v9.Name, 0.5);
	end);
end;
