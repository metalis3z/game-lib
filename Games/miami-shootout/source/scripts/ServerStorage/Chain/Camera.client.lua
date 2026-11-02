

local l__LocalPlayer__1 = game.Players.LocalPlayer;
while true do
	wait();
	if l__LocalPlayer__1 ~= nil then
		break;
	end;
end;
local l__Character__2 = l__LocalPlayer__1.Character;
while true do
	wait();
	if l__Character__2 ~= nil then
		break;
	end;
end;
local l__Humanoid__3 = l__Character__2:WaitForChild("Humanoid", 1);
while true do
	wait();
	if l__Humanoid__3 ~= nil then
		break;
	end;
end;
local l__Parent__4 = script.Parent;
local v5 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
local l__TweenService__6 = game:GetService("TweenService");
local l__CurrentCamera__7 = workspace.CurrentCamera;
local v8 = l__TweenService__6:Create(l__CurrentCamera__7, v5, {
	FieldOfView = 70
});
local u1 = l__TweenService__6:Create(l__CurrentCamera__7, v5, {
	FieldOfView = 57
});
l__Parent__4.Equipped:Connect(function()
	u1:Play();
end);
l__Parent__4.Unequipped:Connect(function()
	v8:Play();
end);
