local l__Parent__1 = script.Parent;
local v2 = TweenInfo.new(2);
local v3 = game:GetService("TweenService"):Create(l__Parent__1, v2, {
	Rotation = 15
});
local v4 = game:GetService("TweenService"):Create(l__Parent__1, v2, {
	Rotation = -5
});
v3:Play();
v3.Completed:Connect(function()
	v4:Play();
end);
v4.Completed:Connect(function()
	v3:Play();
end);
