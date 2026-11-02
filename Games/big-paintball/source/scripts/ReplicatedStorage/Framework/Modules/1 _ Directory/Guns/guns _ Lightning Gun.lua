-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Lightning Gun", 
	description = "Smite players with bolts of lightning! \240\159\140\169\239\184\143", 
	thumbnail = "rbxassetid://6721353448", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 550000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 280, 
	automatic = true, 
	shotrate = 0.14, 
	zoomAmount = 1, 
	additionalSpeed = 0, 
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
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		u1.Audio.Play("rbxassetid://6814232007", p1.UpperTorso, 1, 1, 300);
		local v3, v4 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		for v5, v6 in ipairs(game.ReplicatedStorage.Assets.Particles:FindFirstChild("Lightning KillFX"):GetChildren()) do
			local v8 = v6:Clone();
			v8.Parent = v4;
			v8:Emit(v6.Rate);		
		end;
		local v9 = {};
		for v10, v11 in pairs(p1:GetDescendants()) do
			if v11:IsA("BasePart") and v11.Transparency == 0 then
				if v11.ClassName == "MeshPart" then
					v11.TextureID = "";
				end;
				table.insert(v9, v11);
				v11.Material = Enum.Material.SmoothPlastic;
				v11.Anchored = true;
			elseif v11.ClassName == "SpecialMesh" then
				v11.TextureId = "";
			elseif v11.ClassName == "Shirt" or v11.ClassName == "Pants" or v11.ClassName == "ShirtGraphic" or v11.ClassName == "Decal" or v11.ClassName == "Texture" then
				v11:Destroy();
			end;
		end;
		local l__UpperTorso__3 = p1:FindFirstChild("UpperTorso");
		(function()
			local v12 = l__UpperTorso__3.CFrame.p + Vector3.new(0, 90, 0);
			local v13 = { v12 };
			for v14 = 1, 9 do
				v13[v14 + 1] = v12 - Vector3.new(0, 10 * v14, 0) + Vector3.new(u2:NextNumber(-2.5, 2.5), 0, u2:NextNumber(-2.5, 2.5));
			end;
			local v15 = Instance.new("Model");
			v15.Name = "Lightning";
			for v16, v17 in ipairs(v13) do
				if v16 ~= 1 then
					local v19 = v13[v16 - 1];
					local v20 = Instance.new("Part");
					v20.Anchored = true;
					v20.CanCollide = false;
					v20.CastShadow = false;
					v20.Color = Color3.fromRGB(206, 255, 252);
					v20.Material = Enum.Material.Neon;
					v20.Size = Vector3.new(1.5, 1.5, (v19 - v17).Magnitude);
					v20.CFrame = CFrame.new(v19:Lerp(v17, 0.5), v17);
					v20.Parent = v15;
				end;			
			end;
			v15.Parent = u1.Debris;
			coroutine.wrap(function()
				local v21 = false;
				while tick() - tick() < 0.2 do
					v21 = not v21;
					for v22, v23 in ipairs(v9) do
						if v23 then
							v23.Color = v21 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1);
						end;					
					end;
					u1.Functions.Wait(0.04);				
				end;
				for v25, v26 in ipairs(v9) do
					if v26 then
						v26.Anchored = false;
						v26.Color = Color3.new(0, 0, 0);
					end;				
				end;
			end)();
			u1.Functions.AddDebris(v15, u2:NextNumber(0.04, 0.075));
		end)();
	end;
end;
v1["59"] = v2;
return v1;
