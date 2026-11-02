-- Decompiled with the Synapse X Luau decompiler.

local u1 = tick() - 5;
return function(p1)
	if tick() < u1 + 4 then
		return;
	end;
	u1 = tick();
	local l__CollectionService__1 = game:GetService("CollectionService");
	local l__TweenService__2 = game:GetService("TweenService");
	for v3, v4 in pairs(game.Workspace:GetDescendants()) do
		local v7 = v4
		if v7.Name == "Skybox" then
			l__TweenService__2:Create(v7, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, true, 0), {
				Color = Color3.fromRGB(72, 70, 85)
			}):Play();
		end;
		if v7.Name == "Lightning" and v7:IsA("Light") then
			v7.Enabled = true
			local v8, v9 = pcall(function()
				task.spawn(function()
					for v10 = 1, 15 do
						task.wait(0.01639344262295082);
						v7.Brightness = 2 - math.clamp(v10 / 15 + math.random(-5, 5) / 10, 0, 1) * 2;
					end;
					v7.Brightness = 1.5;
					l__TweenService__2:Create(v7, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {
						Brightness = 0
					}):Play();
				end);
			end);
			if v9 then
				warn(v9);
			end;
		end;
		if v7.Name == "Thunder" and v7:IsA("Sound") then
			v7.Pitch = 1 + math.random(-100, 100) / 1000;
			v7:Play();
		end;	
	end;
	if game.ReplicatedStorage.GameData.Floor.Value ~= "Garden" then
		for v11 = 1, 15 do
			task.wait(0.01639344262295082);
			game.Lighting.Brightness = 3 - math.clamp(v11 / 15 + math.random(-5, 5) / 10, 0, 1) * 3;
		end;
		l__TweenService__2:Create(game.Lighting, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {
			Brightness = 0
		}):Play();
		return;
	end;
	local v12 = game.ReplicatedStorage.Sounds.ThunderStrike:Clone();
	v12.Parent = workspace;
	v12:Play();
	game.Debris:AddItem(v12, 15);
	for v13 = 1, 15 do
		task.wait(0.01639344262295082);
		local v14 = math.clamp(v13 / 15 + math.random(-5, 5) / 10, 0, 1);
		game.Lighting.FogColor = Color3.fromRGB(71, 69, 85):Lerp(Color3.fromRGB(14, 13, 18), v14);
		game.Lighting.Brightness = 6 - v14 * 6;
		game.Lighting.Ambient = Color3.fromRGB(119, 115, 140):Lerp(Color3.fromRGB(0, 0, 0), v14);
	end;
	l__TweenService__2:Create(game.Lighting, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {
		FogColor = Color3.fromRGB(14, 13, 18), 
		Brightness = 0, 
		Ambient = Color3.fromRGB(0, 0, 0)
	}):Play();
end;
