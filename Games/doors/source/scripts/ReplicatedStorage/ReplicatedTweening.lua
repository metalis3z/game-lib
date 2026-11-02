-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
if nil == nil and l__RunService__3:IsServer() then
	local v4 = Instance.new("RemoteEvent", script);
	v4.Name = "TweenEvent";
else
	v4 = script:WaitForChild("TweenEvent");
end;
local function u1(p1)
	return { p1.Time and 1, p1.EasingStyle or Enum.EasingStyle.Quad, p1.EasingDirection or Enum.EasingDirection.Out, p1.RepeatCount and 0, p1.Reverses and false, p1.DelayTime and 0 };
end;
local u2 = {};
function v1.GetTweenObject(p2, p3, p4, p5)
	local v5 = {
		DontUpdate = {}
	};
	p4 = u1(p4);
	local function u3(p6, p7, p8)
		local v6 = os.time() + p4[1];
		local v7 = p4[1];
		u2[p3] = u2[p3] or os.time();
		p8 = p8 and false;
		v5.Paused = false;
		if p7 == nil and not p8 then
			u2[p3] = v6;
			v4:FireAllClients("RunTween", p3, p4, p5);
		elseif p8 and p7 == nil then
			v7 = v7 + (u2[p3] - os.time());
			u2[p3] = v6 + (u2[p3] - os.time());
			v4:FireAllClients("QueueTween", p3, p4, p5);
		elseif p8 then
			v4:FireClient("QueueTween", p3, p4, p5);
		else
			v4:FireClient("RunTween", p3, p4, p5);
		end;
		if not p6 or p7 ~= nil then
			if p7 == nil then
				spawn(function()
					local v8 = 0;
					while true do
						task.wait(0.1);
						v8 = v8 + 0.1;
						if v7 <= v8 then
							break;
						end;
						if v5.Stopped then
							break;
						end;					
					end;
					if u2[p3] == u2[p3] then
						u2[p3] = nil;
					end;
					if v5.Paused == nil or v5.Paused == false then
						for v9, v10 in pairs(p5) do
							p3[v9] = v10;
						end;
					end;
				end);
			end;
			return;
		end;
		local v11 = 0;
		while true do
			task.wait(0.1);
			v11 = v11 + 0.1;
			if v7 <= v11 then
				break;
			end;
			if v5.Stopped then
				break;
			end;		
		end;
		if u2[p3] == u2[p3] then
			u2[p3] = nil;
		end;
		if v5.Paused == nil or v5.Paused == false then
			for v12, v13 in pairs(p5) do
				p3[v12] = v13;
			end;
		end;
	end;
	function v5.Play(p9, p10, p11)
		u3(p10, p11);
	end;
	function v5.QueuePlay(p12, p13, p14)
		u3(p13, p14, true);
	end;
	function v5.Pause(p15, p16)
		if p16 == nil then
			v5.Paused = true;
			v4:FireAllClients("PauseTween", p3);
			return;
		end;
		table.insert(v5.DontUpdate, p16);
		v4:FireClient("PauseTween", p3);
	end;
	function v5.Stop(p17, p18)
		if p18 ~= nil then
			v4:FireClient("StopTween", p3);
			return;
		end;
		v5.Stopped = true;
		v4:FireAllClients("StopTween", p3);
	end;
	return v5;
end;
if l__RunService__3:IsClient() then
	local u4 = {};
	v4.OnClientEvent:Connect(function(p19, p20, p21, p22)
		local v14 = nil;
		if p21 ~= nil then
			p21 = TweenInfo.new(unpack(p21));
		end;
		v14 = function(p23)
			local v15 = os.time() + p21.Time;
			u2[p20] = u2[p20] or os.time();
			local v16 = u2[p20];
			if p23 and os.time() <= u2[p20] then
				local v17 = u2[p20] - os.time();
				u2[p20] = v15 + v17;
				v16 = u2[p20];
				wait(v17);
			else
				u2[p20] = v15;
			end;
			if u4[p20] ~= nil then
				u4[p20]:Cancel();
			end;
			local v18 = l__TweenService__2:Create(p20, p21, p22);
			u4[p20] = v18;
			v18:Play();
			wait(p21.Time and 1);
			if u2[p20] == v16 then
				u2[p20] = nil;
			end;
			if u4[p20] == v18 then
				u4[p20] = nil;
			end;
		end;
		if p19 == "RunTween" then
			v14();
		elseif p19 == "QueueTween" then
			v14(true);
		elseif p19 == "StopTween" then
			if u4[p20] ~= nil then
				u4[p20]:Stop();
				u4[p20] = nil;
			else
				warn("Tween being stopped does not exist.");
			end;
		elseif p19 == "PauseTween" then
			if u4[p20] ~= nil then
				u4[p20]:Pause();
			else
				warn("Tween being paused does not exist.");
			end;
		end;
	end);
end;
return v1;
