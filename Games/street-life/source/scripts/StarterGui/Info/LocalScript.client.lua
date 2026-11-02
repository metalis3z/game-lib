wait(5);
while true do
	wait();
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
		break;
	end;
end;

while true do
	local v1 = math.random(1, 13);
	script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
	if v1 == 1 then
		script.Parent.TextLabel.Text = "ROLEPLAY YOUR TOOLS!";
	elseif v1 == 2 then
		script.Parent.TextLabel.Text = "RESPECT THE LAW AND HAVE COP FEAR!";
	elseif v1 == 3 then
		script.Parent.TextLabel.Text = "To Save Items You Must Own An Apartment And Store The Items In The Safe";
	elseif v1 == 4 then
		script.Parent.TextLabel.Text = "USE COMMON SENSE!";
	elseif v1 == 5 then
		script.Parent.TextLabel.Text = "WALKING IN THE MIDDLE OF THE ROAD WILL GET YOU KILLED!";
	elseif v1 == 6 then
		script.Parent.TextLabel.Text = "MURDER AND GETTING CAUGHT BY THE POLICE WILL GET YOU ARRESTED!";
	elseif v1 == 7 then
		script.Parent.TextLabel.Text = "STORE YOUR CASH IN YOUR SAFE TO NOT LOSE IT WHEN YOU DIE!";
	elseif v1 == 8 then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4);
		script.Parent.TextLabel.Text = "DO NOT RANDOM KILL OR FAIL ROLEPLAY, THIS WILL 90% LIKELY LEAVE YOU BANNED/KICKED";
	elseif v1 == 9 then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4);
		script.Parent.TextLabel.Text = "REMEMBER TO HAVE GUN FEAR!";
	elseif v1 == 10 then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4);
		script.Parent.TextLabel.Text = "REMEMBER TO HAVE POLICE FEAR, RESPECT THEIR WORDS OR YOU MIGHT GET BANNED FOR FRP!";
	elseif v1 == 11 then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4);
		script.Parent.TextLabel.Text = "DO NOT LOOT RANDOM BODIES!";
	else
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4);
		script.Parent.TextLabel.Text = "EXPLOITING IS A PERMA BAN! NO UNBAN!";
	end;
	for v2 = 1, 25 do
		wait();
		script.Parent.TextLabel.TextTransparency = script.Parent.TextLabel.TextTransparency - 0.05;
	end;
	wait(10);
	for v3 = 1, 25 do
		wait();
		script.Parent.TextLabel.TextTransparency = script.Parent.TextLabel.TextTransparency + 0.05;
	end;
end;