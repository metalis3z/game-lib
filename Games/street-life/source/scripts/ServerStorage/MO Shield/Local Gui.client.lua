

while true do
	wait();
	if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
		break;
	end;
end;
enabled = true;
function onButton1Down(p1)
	if not enabled then
		return;
	end;
	enabled = false;
	p1.Icon = "http://www.roblox.com/asset/?id=1386173173";
	wait(0);
	p1.Icon = "http://www.roblox.com/asset/?id=1386173173";
	enabled = true;
end;
function onEquippedLocal(p2)
	if p2 == nil then
		print("Mouse not found");
		return;
	end;
	p2.Icon = "http://www.roblox.com/asset/?id=1386173173";
	p2.Button1Down:connect(function()
		onButton1Down(p2);
	end);
end;
script.Parent.Equipped:connect(onEquippedLocal);
