Fade = function(p1, p2)
	local PlayerData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();
	if not (PlayerData[p1.Name] == nil) then
		if PlayerData[p1.Name].Role == "Murderer" and PlayerData[p1.Name].Perk == "Ghost" then
			coroutine.wrap(function()
				local i = 1;
				while i <= 10 do
					for _, Part in pairs(p1.Character:GetDescendants()) do
						if (Part:IsA("Decal") or Part:IsA("BasePart") or Part:IsA("Texture")) and Part.Name ~= "HumanoidRootPart" then
							Part.Transparency = (p2 and (Part.Transparency + (1/10))) or (Part.Transparency - (1/10));
						end;
						if Part:IsA("ParticleEmitter") or Part:IsA("Fire") or Part:IsA("Sparkles") or Part:IsA("Beam") then
							Part.Enabled = not p2;
						end;
						if Part:IsA('ObjectValue') and Part.Name == 'DisplayRefGun' or Part.Name == 'DisplayRefKnife' then
							Part.Value.Transparency = (p2 and (Part.Value.Transparency + (1/10))) or (Part.Value.Transparency - (1/10));
							for _,v in pairs(Part.Value:GetDescendants()) do
								if (v:IsA("Decal") or v:IsA("BasePart") or v:IsA("Texture")) then
									v.Transparency = (p2 and (v.Transparency + (1/10))) or (v.Transparency - (1/10));
								end;
								if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
									v.Enabled = not p2;
								end;
							end;
						end;
					end;
					game:GetService("RunService").Heartbeat:Wait();
					i = i + 1;
				end;
			end)();
		end;
	end;
end;

game.ReplicatedStorage.Remotes.Gameplay.Stealth.OnServerEvent:Connect(Fade);