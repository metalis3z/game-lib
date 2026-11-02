-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Inferno Rifle", 
	description = "Fused with the power of the sun to unleash hell and fury on those who are unfortunate enough to get hit by it. \240\159\148\165\240\159\152\136", 
	thumbnail = "rbxassetid://6242906653", 
	quality = true, 
	premium = true, 
	offsale = true, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 0, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 280, 
	automatic = true, 
	shotrate = 0.1, 
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
	}, 
	gunEffect = function(p1)
		coroutine.wrap(function()
			while p1 and p1.Parent do
				p1.gun.Reflectance = -2 + math.cos(tick() * 2);
				u1.RenderStepped();			
			end;
		end)();
	end
};
local u2 = Random.new();
function v2.killEffect(p2)
	if p2 and p2.PrimaryPart then
		u1.Audio.Play(6245540389, p2.UpperTorso, 1, 0.75, 300);
		for v3, v4 in pairs(p2:GetDescendants()) do
			if v4:IsA("BasePart") and v4.Transparency == 0 then
				if v4.ClassName == "MeshPart" then
					v4.TextureID = "";
				end;
				u1.Functions.FastTween(v4, {
					Color = Color3.new(1, 0.835294, 0)
				}, { 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out });
				v4.Material = Enum.Material.Neon;
			elseif v4.ClassName == "SpecialMesh" then
				v4.TextureId = "";
			elseif v4.ClassName == "Shirt" or v4.ClassName == "Pants" or v4.ClassName == "ShirtGraphic" or v4.ClassName == "Decal" or v4.ClassName == "Texture" then
				v4:Destroy();
			end;
		end;
		local v5, v6 = u1.Functions.CreateParticleHost(p2.PrimaryPart.CFrame);
		for v7, v8 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Inferno KillFX"):GetChildren()) do
			local v10 = v8:Clone();
			v10.Parent = v6;
			v10:Emit(10);		
		end;
		v5.Parent = p2;
		for v11, v12 in pairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Fire"):GetChildren()) do
			v12:Clone().Parent = p2.UpperTorso;
		end;
		coroutine.wrap(function()
			local v13 = u1.Audio.Play(6245540445, p2.UpperTorso, 1, 1, 135);
			while p2 and p2.Parent == game.Workspace.__THINGS.Ragdolls and p2:FindFirstChild("UpperTorso") and p2.UpperTorso.Velocity.Magnitude >= 10 do
				local v14, v15 = u1.Functions.QuickRay(CFrame.new(p2.UpperTorso.CFrame.Position + Vector3.new(-1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v16, v17 = u1.Functions.QuickRay(CFrame.new(p2.UpperTorso.CFrame.Position + Vector3.new(1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v18, v19 = u1.Functions.QuickRay(CFrame.new(p2.UpperTorso.CFrame.Position + Vector3.new(-1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v20, v21 = u1.Functions.QuickRay(CFrame.new(p2.UpperTorso.CFrame.Position + Vector3.new(1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				if v14 and v16 and v18 and v20 then
					local l__unit__22 = (v15 - v19).unit;
					local l__unit__23 = (v21 - v19).unit;
					local v24 = l__unit__23:Cross(l__unit__22);
					local v25 = 0.25 * (v15 + v17 + v19 + v21);
					local v26 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Lava"):Clone();
					v26.CFrame = CFrame.new(v25.X, v25.Y, v25.Z, l__unit__23.X, v24.X, -l__unit__22.X, l__unit__23.Y, v24.Y, -l__unit__22.Y, l__unit__23.Z, v24.Z, -l__unit__22.Z);
					v26.Size = Vector3.new(1, 0.4, 1);
					v26.Parent = game.Workspace.__DEBRIS;
					local v27 = u2:NextInteger(150, 600) / 100;
					u1.Functions.FastTween(v26, {
						Size = Vector3.new(v27, 0.4, v27)
					}, { u2:NextNumber(0.4, 0.8), "Sine", "Out" });
					coroutine.wrap(function()
						wait(0.33);
						u1.Functions.FastTween(v26, {
							Color = Color3.fromRGB(134, 67, 0)
						}, { 1, "Quad", "In" }).Completed:Wait();
						u1.Functions.FastTween(v26, {
							Transparency = 1
						}, { 0.33, "Sine", "Out" }).Completed:Wait();
						v26:Destroy();
					end)();
				end;
				wait(math.random(5, 15) / 100);			
			end;
			u1.Functions.FastTween(v13, {
				Volume = 0
			}, { 0.5, "Quad", "Out" });
			wait(0.5);
			v13:Stop();
		end)();
	end;
end;
v1["55"] = v2;
return v1;
