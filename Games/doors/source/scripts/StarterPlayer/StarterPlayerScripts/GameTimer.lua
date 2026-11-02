-- Decompiled with the Synapse X Luau decompiler.

local l__LiveClock__1 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("LiveClock");
local u1 = 11;
local u2 = 40;
local u3 = 0;
l__LiveClock__1.OnClientEvent:Connect(function(p1)
	u1 = p1.hours;
	u2 = p1.minutes;
	u3 = p1.seconds;
end);
task.spawn(function()
	for v2 = 1, 10000000000 do
		task.wait(1);
		if not game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("StopTime").Value then
			u3 = u3 + 1;
			if u3 >= 60 then
				l__LiveClock__1:FireServer();
				u2 = u2 + 1;
				u3 = 0;
				if u2 >= 60 then
					u1 = u1 + 1;
					u2 = 0;
					if u1 >= 12 then
						u1 = 0;
					end;
				end;
			end;
		end;
	end;
end);
l__LiveClock__1:FireServer();
return function()
	return u1, u2, u3;
end;
