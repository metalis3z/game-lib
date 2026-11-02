local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__UserInputService__1 = game:GetService("UserInputService");
local l__GuiService__2 = game:GetService("GuiService");
local l__RunService__3 = game:GetService("RunService");
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
function module(p1)
	local v2 = "pc";
	local v3 = v2;
	({})[1] = Enum.UserInputType.Gamepad1;
	if l__UserInputService__1.TouchEnabled then
		if not l__UserInputService__1.AccelerometerEnabled then
			if l__UserInputService__1.GyroscopeEnabled then
				v2 = "mobile";
				v3 = v2;
				if l__UserInputService__1.GamepadEnabled then
					v3 = "console";
				end;
			end;
		else
			v2 = "mobile";
			v3 = v2;
			if l__UserInputService__1.GamepadEnabled then
				v3 = "console";
			end;
		end;
	end;
	if l__GuiService__2:IsTenFootInterface() then
		v2 = "console";
		v3 = v2;
	end;
	if not l__GuiService__2:IsTenFootInterface() then
		if l__UserInputService__1.GamepadEnabled then
			if l__UserInputService__1.MouseEnabled then
				if l__UserInputService__1.KeyboardEnabled then
					if l__UserInputService__1:GetLastInputType() == Enum.UserInputType.Gamepad1 then
						v3 = "console";
					end;
				end;
			end;
		end;
	end;
	if l__UserInputService__1.TouchEnabled then
		v2 = "mobile";
		v3 = v2;
	end;
	--print("GetPlatform Returned")
	--print(v2, v3)
	return v2, v3; 
end;
return module;
