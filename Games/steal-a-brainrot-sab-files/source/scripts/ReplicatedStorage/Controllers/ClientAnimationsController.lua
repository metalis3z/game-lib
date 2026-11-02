-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj


local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Observers__3 = require(l__ReplicatedStorage__1.Packages.Observers);
local l__StringUtils__4 = require(l__ReplicatedStorage__1.Utils.StringUtils);
return {
	Start = function(_)
		l__Observers__3.observeTag("ClientLoadAnimation", function(u1)
			return l__Observers__3.observeAttribute(u1, "Animation", function(p2)
				local v3 = l__StringUtils__4:ReadPath(l__ReplicatedStorage__1, p2);
				if typeof(v3) ~= "Instance" or not v3:IsA("Animation") then
					return nil;
				end;
				local u4 = u1:LoadAnimation(v3);
				u4.Looped = true;
				u4:Play();
				return function()
					u4:Stop(0);
					u4:Destroy();
				end;
			end);
		end);
		l__Observers__3.observeTag("ClientFloat", function(p5)
			if not p5:IsA("BasePart") then
				return nil;
			end;
			local u6 = p5:FindFirstChildWhichIsA("Motor6D");
			local u7;
			if u6 then
				u7 = false;
			else
				local v8 = p5:FindFirstChildWhichIsA("Weld");
				if not (v8 and (v8.Part0 and v8.Part1)) then
					return nil;
				end;
				u6 = Instance.new("Motor6D");
				u6.Name = "ClientFloatMotor";
				u6.Part0 = v8.Part0;
				u6.Part1 = v8.Part1;
				u6.C0 = v8.C0;
				u6.C1 = v8.C1;
				u6.Parent = p5;
				v8:Destroy();
				u7 = true;
			end;
			local v9 = p5:GetAttribute("FloatBobAmplitude");
			local u10 = typeof(v9) ~= "number" and 0.35 or v9;
			local v11 = p5:GetAttribute("FloatBobSpeed");
			local u12 = typeof(v11) ~= "number" and 1.75 or v11;
			local v13 = p5:GetAttribute("FloatNodAmplitude");
			local u14 = typeof(v13) ~= "number" and 0.12 or v13;
			local v15 = p5:GetAttribute("FloatNodSpeed");
			local u16 = typeof(v15) ~= "number" and 1.2 or v15;
			local u18 = l__RunService__2.PreRender:Connect(function()
				local v17 = os.clock();
				u6.Transform = CFrame.new(0, math.sin(v17 * u12) * u10, 0) * CFrame.Angles(math.sin(v17 * u16) * u14, 0, 0);
			end);
			return function()
				u18:Disconnect();
				if u6.Parent then
					if u7 then
						u6:Destroy();
						return;
					end;
					u6.Transform = CFrame.identity;
				end;
			end;
		end);
	end
};