-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["35"] = {
		displayName = "Poop Gun", 
		description = "\240\159\146\169\240\159\146\169\240\159\146\169\240\159\146\169\240\159\146\169\240\159\146\169\240\159\146\169\240\159\146\169", 
		thumbnail = "rbxassetid://4463016219", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 625000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 290, 
		automatic = false, 
		shotrate = 0.135, 
		zoomAmount = 1, 
		additionalSpeed = 0, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.75, -2), 
				left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}, 
			thirdPerson = {
				idle = CFrame.new(0.3, 0.5, -1.35), 
				left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
				fire = CFrame.new(0, 0, 0.2) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}, 
		killEffect = function(p1)
			if p1 and p1:FindFirstChild("UpperTorso") then
				u1.Audio.Play(4477057448, p1.PrimaryPart.Position, 1, 0.5, 300);
				local v1, v2 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v3, v4 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Poop KillFX"):GetChildren()) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(10);				
				end;
				v1.Parent = p1;
				for v7, v8 in pairs(p1:GetDescendants()) do
					if v8:IsA("BasePart") and v8.Transparency == 0 then
						if v8.ClassName == "MeshPart" then
							v8.TextureID = "";
						end;
						v8.Color = Color3.fromRGB(122, 89, 1);
					elseif v8.ClassName == "SpecialMesh" then
						v8.TextureId = "";
					elseif v8.ClassName == "Shirt" or v8.ClassName == "Pants" or v8.ClassName == "ShirtGraphic" or v8.ClassName == "Decal" or v8.ClassName == "Texture" then
						v8:Destroy();
					end;
				end;
				coroutine.wrap(function()
					local v9 = u1.Audio.Play(4477058173, p1.UpperTorso, 1, 1, 165);
					while p1 and p1.Parent == game.Workspace.__THINGS.Ragdolls and p1:FindFirstChild("UpperTorso") and p1.UpperTorso.Velocity.Magnitude >= 10 do
						local v10, v11 = u1.Functions.QuickRay(CFrame.new(p1.UpperTorso.CFrame.Position + Vector3.new(-1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
						local v12, v13 = u1.Functions.QuickRay(CFrame.new(p1.UpperTorso.CFrame.Position + Vector3.new(1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
						local v14, v15 = u1.Functions.QuickRay(CFrame.new(p1.UpperTorso.CFrame.Position + Vector3.new(-1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
						local v16, v17 = u1.Functions.QuickRay(CFrame.new(p1.UpperTorso.CFrame.Position + Vector3.new(1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
						if v10 and v12 and v14 and v16 then
							local l__unit__18 = (v11 - v15).unit;
							local l__unit__19 = (v17 - v15).unit;
							local v20 = l__unit__19:Cross(l__unit__18);
							local v21 = 0.25 * (v11 + v13 + v15 + v17);
							local v22 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Poop"):Clone();
							v22.CFrame = CFrame.new(v21.X, v21.Y, v21.Z, l__unit__19.X, v20.X, -l__unit__18.X, l__unit__19.Y, v20.Y, -l__unit__18.Y, l__unit__19.Z, v20.Z, -l__unit__18.Z);
							v22.Size = Vector3.new(1, 0.4, 1);
							v22.Parent = game.Workspace.__DEBRIS;
							local v23 = math.random(150, 650) / 100;
							u1.Functions.FastTween(v22, {
								Size = Vector3.new(v23, 0.4, v23)
							}, { 0.35, "Back", "Out" });
							coroutine.wrap(function()
								wait(1);
								u1.Functions.FastTween(v22, {
									Transparency = 1
								}, { 0.5, "Quad", "Out" });
								wait(0.5);
								v22:Destroy();
							end)();
						end;
						wait(math.random(5, 15) / 100);					
					end;
					u1.Functions.FastTween(v9, {
						Volume = 0
					}, { 0.5, "Quad", "Out" });
					wait(0.5);
					v9:Stop();
				end)();
			end;
		end
	}
};
