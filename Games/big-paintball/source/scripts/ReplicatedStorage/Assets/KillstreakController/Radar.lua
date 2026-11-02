-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__Assets__3 = game.ReplicatedStorage:WaitForChild("Assets");
local v8
return function()
	local v2 = Instance.new("BindableEvent");
	local v3 = tick();
	u1.Audio.Play(4380394215, script);
	local u4 = {};
	local u5 = {
		InUse = true, 
		Completed = v2.Event
	};
	local v4 = tick();
	u1.Network.Fire("Activate Radar");
	u1.Signal.Fire("New Item", "Message", "Radar activated!");
	local u6 = v4;
	local function u7(p1, p2)
		u1.Audio.Play(4380506356, script, 1, 0.2);
		local v5 = l__Assets__3:WaitForChild("RadarPing"):Clone();
		v5.Size = UDim2.new(0, 1, 0, 1);
		v5.Frame.BackgroundColor3 = v5.Frame.BackgroundColor3:Lerp(Color3.fromRGB(145, 0, 145), p2 * 100 / 350 / 100);
		v5.Parent = p1;
		u1.Functions.FastTween(v5, {
			Size = v5.Size
		}, { 0.2, "Quad", "Out" });
		coroutine.wrap(function()
			wait(1);
			u1.Functions.FastTween(v5:WaitForChild("Frame"), {
				BackgroundTransparency = 1
			}, { 1, "Quad", "Out" }).Completed:Connect(function()
				v5:Destroy();
			end);
		end)();
	end;
	u1.RunService:BindToRenderStep("Radar Killstreak", Enum.RenderPriority.Last.Value, function(p3)
		if tick() - u6 <= 2.5 then
			return;
		end;
		u6 = tick();
		for v6, v7 in pairs(game.Players:GetPlayers()) do
			if v7 and v7 ~= l__LocalPlayer__2 and v7.Character and v7.Character.Parent == game.Workspace and v7.Character:FindFirstChild("Head") then
				if u1.Shared.isFFA() or v7.Team ~= l__LocalPlayer__2.Team then
					v8 = true;
				else
					v8 = false;
				end;
				if v8 then
					local v9 = l__LocalPlayer__2:DistanceFromCharacter(v7.Character.Head.Position);
					if v9 <= 350 then
						u7(v7.Character.Head, v9);
					end;
				end;
			end;
		end;
	end);
	local function u8()
		pcall(function()
			u1.RunService:UnbindFromRenderStep("Radar Killstreak");
		end);
		for v10, v11 in pairs(u4) do
			v11:Disconnect();
		end;
		v2:Fire();
		u5.InUse = false;
	end;
	u4.died = u1.Player.Get("Humanoid").Died:Connect(function()
		u8();
	end);
	local l__Character__9 = l__LocalPlayer__2.Character;
	coroutine.wrap(function()
		while tick() - v3 <= 10 and l__LocalPlayer__2.Character == l__Character__9 do
			u1.Heartbeat();		
		end;
		u8();
	end)();
	return u5;
end;
