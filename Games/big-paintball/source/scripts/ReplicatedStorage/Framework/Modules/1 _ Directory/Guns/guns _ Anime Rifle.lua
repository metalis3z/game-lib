-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Anime Rifle", 
	description = "ITS OVER 9000!!!", 
	thumbnail = "rbxassetid://6894359633", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 1400000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 280, 
	automatic = true, 
	shotrate = 0.1, 
	zoomAmount = 1, 
	additionalSpeed = 1, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0.75, -0.75, -2), 
			left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.05235987755982989, 0, 0), 
			sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}, 
		thirdPerson = {
			idle = CFrame.new(0.3, 0.5, -1.35), 
			left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}, 
	tracerEffect = function(p1)
		if p1 then
			p1.BrickColor = BrickColor.new("Baby blue");
			p1.Material = Enum.Material.Neon;
		end;
	end
};
local u2 = Random.new();
function v2.killEffect(p2)
	if p2 and p2.PrimaryPart then
		local l__Anime_KillFX__3 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Anime KillFX");
		u1.Audio.Play("rbxassetid://8827287454", p2.PrimaryPart.CFrame, 1 + u2:NextInteger(-10, 10) / 100, 0.55, 350);
		for v4, v5 in ipairs(p2:GetChildren()) do
			if v5.Name == "Head" then
				v5:Destroy();
			elseif not (not v5:IsA("Pants")) or not (not v5:IsA("Shirt")) or v5:IsA("Decal") then
				v5:Destroy();
			elseif v5:IsA("MeshPart") or v5:IsA("BasePart") then
				v5.Material = Enum.Material.Neon;
				v5.Color = Color3.fromRGB(255, 255, 255);
				local v7
				if u2:NextInteger(1, 2) == 1 then
					v7 = 55;
				else
					v7 = -55;
				end;
				local v8
				if u2:NextInteger(1, 2) == 1 then
					v8 = 55;
				else
					v8 = -55;
				end;
				local v9
				if u2:NextInteger(1, 2) == 1 then
					v9 = 55;
				else
					v9 = -55;
				end;
				v5.Velocity = Vector3.new(v7, v8, v9);
				u1.Functions.FastTween(v5, {
					Transparency = 1
				}, { 2, "Quad", "Out" });
			elseif v5:IsA("Accessory") or v5:IsA("Hat") then
				v5:Destroy();
			end;		
		end;
		local l__Magnitude__10 = (u1.Player.Get("Camera").CFrame.p - p2.PrimaryPart.CFrame.p).Magnitude;
		if l__Magnitude__10 <= 75 then
			u1.Shake.Create(1, 0.35 - l__Magnitude__10 / 75 * 0.75, 0.2);
			local v11 = Instance.new("BloomEffect");
			v11.Threshold = 1.2 + l__Magnitude__10 / 80 * 0.8;
			v11.Name = "AnimeBloom";
			v11.Parent = game.Lighting;
			u1.Functions.FastTween(v11, {
				Threshold = 2, 
				Size = 0
			}, { 2, "Quad", "Out" });
			coroutine.wrap(function()
				task.wait(2);
				v11:Destroy();
			end)();
		end;
		local v12, v13 = u1.Functions.CreateParticleHost(p2.PrimaryPart.CFrame);
		v12.Parent = p2;
		local v14 = {};
		for v15, v16 in pairs(l__Anime_KillFX__3:GetChildren()) do
			local v17 = v16:Clone();
			v17.Parent = v13;
			v17:Emit(v17.Rate);
		end;
		u1.Functions.AddDebris(v12, 5);
	end;
end;
v1["70"] = v2;
return v1;
