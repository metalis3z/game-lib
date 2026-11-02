local l__Value__1 = script.Parent.Bike.Value;
local l__UserInputService__1 = game:GetService("UserInputService");
local u2 = false;
local u3 = false;
local u4 = 0;
local u5 = { 11516301995, 11516303190, 11516303803, 11516304733, 11516305971};


local Key = Enum.KeyCode.LeftShift

function DealWithInput(p1)
	if l__UserInputService__1:GetFocusedTextBox() == nil then
		if not u2 then
			
			
			if p1.KeyCode == Key then
				if p1.UserInputState == Enum.UserInputState.Begin then
					
					if script.Parent.Bike.Value.DriveSeat.Throttle == 1 then	
					u3 = true;
					u4 = 1;
					script.wheelie.AnimationId = "rbxassetid://" .. u5[math.random(1, 5)];
					anim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.wheelie);
						anim:Play();
						
						end
					return;
				elseif p1.KeyCode == Key then
					if p1.UserInputState == Enum.UserInputState.End then
						u3 = false;
						u4 = 0;
						anim:Stop();
						anim:Destroy();
						return;
					end;
				end;
			elseif p1.KeyCode == Key then
				if p1.UserInputState == Enum.UserInputState.End then
					u3 = false;
					u4 = 0;
					anim:Stop();
					anim:Destroy();
				end;
			end;
			
			
		end;
	end;
end;
l__UserInputService__1.InputBegan:connect(DealWithInput);
l__UserInputService__1.InputChanged:connect(DealWithInput);
l__UserInputService__1.InputEnded:connect(DealWithInput);
if not l__Value__1.Body.Weight:FindFirstChild("wheelie") then
	gyro = Instance.new("BodyGyro");
	gyro.Name = "wheelie";
	gyro.Parent = l__Value__1.Body.Weight;
else
	gyro = l__Value__1.Body.Weight.wheelie;
end;
l__Value__1.Body.Weight:WaitForChild("wheelie");
l__Value__1.DriveSeat.ChildRemoved:connect(function(p2)
	gyro.D = 0;
	gyro.MaxTorque = Vector3.new(0, 0, 0);
	gyro.P = 0;
	gyro.cframe = CFrame.new(l__Value__1.Body.Weight.CFrame.p, l__Value__1.Body.Weight.CFrame.p + l__Value__1.Body.Weight.CFrame.lookVector) * CFrame.Angles(0, 0, 0);
	anim:Stop();
	anim:Destroy();

end);
local v2 = math.max(1, 0.1);
while wait(0.0667) do
	u2 = script.Parent.ControlsOpen.Value;
	if u3 then
		WheelieOutput = -u4 * (script.Parent.Values.Throttle.Value - script.Parent.Values.Brake.Value);
	else
		WheelieOutput = u4;
	end;
	gyro.D = 3.3 * (-math.min(WheelieOutput, 0) * script.Parent.Values.Throttle.Value);
	gyro.MaxTorque = Vector3.new(180 * (-math.min(WheelieOutput, 0) * script.Parent.Values.Throttle.Value), 0, 0);
	gyro.P = 12.5 * (-math.min(WheelieOutput, 0) * script.Parent.Values.Throttle.Value);
	gyro.cframe = CFrame.new(l__Value__1.Body.Weight.CFrame.p, l__Value__1.Body.Weight.CFrame.p + l__Value__1.Body.Weight.CFrame.lookVector) * CFrame.Angles(-(math.min(WheelieOutput, 0) * 0.905 / v2) * script.Parent.Values.Throttle.Value - l__Value__1.Body.Weight.CFrame.lookVector.Y, 0, 0);
end;
