local footsteps = {
	Velocity = Vector3.new(0,0,0)
}
local settings_footsteps = {
	RollOfMaxDistance = 0;
}
local default_pt = game.Players:GetPlayerFromCharacter(script.Parent.Parent)

function footsteps.playaudio(pt,cam, p2, p3, p4, p5, p6)
	local u1 = p6;
	local u2 = settings_footsteps.RollOfMaxDistance;
	local u3 = p2;
	local v34, v35 = pcall(function()
		if not u1 then
			u1 = 1;
		end;
		local v36 = nil;
		if p3 ~= nil then
			if p3:IsA("Attachment") then
				v36 = p3.WorldPosition;
			else
				v36 = p3.Position;
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
			-- u3.RollOffMinDistance = 2;
			u3.RollOfMinDistance = settings_footsteps.RollOfMaxDistance;
		end);
		if p3 and u3 and v36 and (cam.CFrame.p - v36).Magnitude < math.clamp(u2, 0, 500) then
			u3 = u3:Clone();
			u3.Parent = p3;
			if p4 and p4 == true then
				local l__Magnitude__37 = (cam.CFrame.p - v36).Magnitude;
				if l__Magnitude__37 > 5 then
					local v38 = RaycastParams.new();
					v38.CollisionGroup = "NoPlayer";
					v38.FilterDescendantsInstances = { p3, pt.Character };
					local v39 = workspace:Raycast(cam.CFrame.p, (v36 - cam.CFrame.p).unit * l__Magnitude__37, v38);
					if v39 then
						local l__Position__40 = v39.Position;
						if l__Position__40 and (l__Position__40 - cam.CFrame.p).Magnitude < l__Magnitude__37 - 4 then
							local v41 = l__Magnitude__37 + math.abs(l__Position__40.Y - cam.CFrame.p.y) * 3;
							local v42 = Instance.new("EqualizerSoundEffect");
							v42.HighGain = -l__Magnitude__37 * 0.25 / u1;
							v42.MidGain = -l__Magnitude__37 * 0.125 / u1;
							v42.LowGain = -l__Magnitude__37 * 0.025 / u1;
							v42.Parent = u3;
						end;
					end;
				end;
			end;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 4000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
			return;
		end;
		if u3 and p3 then
			return;
		end;
		if u3 then
			u3 = u3:Clone();
			u3.Parent = pt.Character;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 4000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
			game.ReplicatedStorage.EntityInfo.FootstepCreated:FireAllClients(u3)
		end;
	end);
	if not v34 then
		warn(v35);
	end;
end
function footsteps.impulse(velocity)
	footsteps.Velocity = footsteps.Velocity + velocity
end

game:GetService("ReplicatedStorage").ClientBricks.FootStep.OnServerEvent:Connect(function(pt, data, secure_code)
	if secure_code == "code-096b13" and pt.Character and pt.Character:FindFirstChild("HumanoidRootPart") and pt == default_pt then
		local cam = data.camera
		local crouch = data.crouch
		local sound = data.sound
		
		local volume = 5
		
		
		if crouch == true then
			volume /= 2
		end;
		
		sound.Volume = volume
		
		cam = {CFrame = cam}
		footsteps.playaudio(pt, cam, sound);

		footsteps.impulse(Vector3.new(math.random(-10, 10), -35, math.random(-10, 10)).unit * pt.Character.HumanoidRootPart.Velocity.Magnitude * 0.5);
	end
end)
