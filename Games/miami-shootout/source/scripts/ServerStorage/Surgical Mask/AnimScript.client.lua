local u1 = nil;
local u2 = nil;
local l__Parent__3 = script.Parent;
local u4 = nil;
local u5 = nil;
local u6 = nil;
function onEquipped(p1)
	u2 = l__Parent__3.Parent:FindFirstChild("Humanoid");
	if u2 ~= nil then
		u4 = u2:LoadAnimation(l__Parent__3.Hold);
		u5 = u2:LoadAnimation(l__Parent__3.Pocket);
	end;
	u6 = p1.Button1Down:connect(function()
		onButton1Down(p1);
	end);
	u4:Play();
end;
function onUnequipped(p2)
	u2 = nil;
	if u4 ~= nil then
		u4:Stop();
		u4:remove();
		u4 = nil;
	end;
	if u5 ~= nil then
		u5:remove();
		u5 = nil;
	end;
	if u6 ~= nil then
		u6:disconnect();
	end;
end;
local u7 = false;
function onButton1Down(p3)
	if u7 == false then
		u7 = true;
		u4:Stop();
		u5:Play();
		wait(1);
		u7 = false;
	end;
end;
l__Parent__3.Equipped:connect(onEquipped);
l__Parent__3.Unequipped:connect(onUnequipped);
