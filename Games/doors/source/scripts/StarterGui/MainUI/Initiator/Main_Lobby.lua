-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = script:FindFirstAncestor("MainUI");
v2:WaitForChild("MainFrame").Visible = false;
local v3 = require(v2.Modules.Spring);
while true do
	wait();
	if game.Players.LocalPlayer.Character then
		break;
	end;
end;
task.spawn(function()
	for v4 = 1, 100 do
		for v5, v6 in pairs(script:GetChildren()) do
			if v6:IsA("LocalScript") then
				v6.Disabled = false;
			end;
		end;
		wait(0.1);
	end;
end);
v1.char = game.Players.LocalPlayer.Character;
v1.hum = v1.char:WaitForChild("Humanoid");
workspace.CurrentCamera:Destroy();
wait();
v1.cam = workspace.CurrentCamera;
v1.cam.CameraSubject = v1.char:WaitForChild("Humanoid");
v1.cam.CameraType = Enum.CameraType.Custom;
v1.spring = v3.new(Vector3.new(0, 0, 0));
v1.spring:__newindex("Damper", 0.4);
v1.spring:__newindex("Speed", 6);
v1.recoil_spring = v3.new(Vector3.new(0, 0, 0));
v1.recoil_spring:__newindex("Damper", 0.7);
v1.recoil_spring:__newindex("Speed", 9);
v1.camShakerModule = require(game:GetService("ReplicatedStorage"):WaitForChild("CameraShaker"));
v1.csgo = CFrame.new(0, 0, 0);
v1.remotes = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
v1.camShaker = v1.camShakerModule.new(200, function(p1)
	v1.csgo = p1;
end);
v1.camShaker:Start();
local l__StarterGui__7 = game:GetService("StarterGui");
v1.mouse = game.Players.LocalPlayer:GetMouse();
function v1.playaudio(p2, p3, p4, p5, p6)
	local u1 = p6;
	local u2 = p5;
	local u3 = p2;
	local v8, v9 = pcall(function()
		if not u1 then
			u1 = 1;
		end;
		local v10 = nil;
		if p3 ~= nil then
			if p3:IsA("Attachment") then
				v10 = p3.WorldPosition;
			else
				v10 = p3.Position;
			end;
		end;
		pcall(function()
			if u2 then
				u3.RollOffMaxDistance = u2;
				if not (u2 < 50) then
					return;
				end;
			else
				u2 = u3.RollOffMaxDistance;
				return;
			end;
			u3.RollOffMinDistance = 2;
		end);
		if p3 and u3 and v10 and (v1.cam.CFrame.p - v10).Magnitude < math.clamp(u2, 0, 500) then
			u3 = u3:Clone();
			u3.Parent = p3;
			if p4 and p4 == true then
				local l__Magnitude__11 = (v1.cam.CFrame.p - v10).Magnitude;
				if l__Magnitude__11 > 5 then
					local v12 = RaycastParams.new();
					v12.CollisionGroup = "NoPlayer";
					v12.FilterDescendantsInstances = { p3, v1.char };
					local v13 = workspace:Raycast(v1.cam.CFrame.p, (v10 - v1.cam.CFrame.p).unit * l__Magnitude__11, v12);
					if v13 then
						local l__Position__14 = v13.Position;
						if l__Position__14 and (l__Position__14 - v1.cam.CFrame.p).Magnitude < l__Magnitude__11 - 4 then
							local v15 = l__Magnitude__11 + math.abs(l__Position__14.Y - v1.cam.CFrame.p.y) * 3;
							local v16 = Instance.new("EqualizerSoundEffect");
							v16.HighGain = -l__Magnitude__11 * 0.25 / u1;
							v16.MidGain = -l__Magnitude__11 * 0.125 / u1;
							v16.LowGain = -l__Magnitude__11 * 0.025 / u1;
							v16.Parent = u3;
						end;
					end;
				end;
			end;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 1000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
			return;
		end;
		if u3 and p3 then
			return;
		end;
		if u3 then
			u3 = u3:Clone();
			u3.Parent = v1.char;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 1000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
		end;
	end);
	if v9 then
		warn(v9);
	end;
end;
v2:WaitForChild("LobbyFrame").Visible = true;
return v1;
