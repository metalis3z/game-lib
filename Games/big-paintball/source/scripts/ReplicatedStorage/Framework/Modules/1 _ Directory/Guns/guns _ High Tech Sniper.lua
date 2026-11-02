-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["15"] = {
		displayName = "High Tech Sniper", 
		description = "A super sniper from the future. It glows, too! \240\159\140\159", 
		thumbnail = "rbxassetid://4352527138", 
		quality = true, 
		premium = true, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		shootSound = 4102528547, 
		price = 9999999, 
		gamepassId = 7334433, 
		productId = 0, 
		damage = 100, 
		velocity = 925, 
		automatic = false, 
		shotrate = 0.475, 
		zoomAmount = 2, 
		additionalSpeed = -2, 
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
				idle = CFrame.new(0.3, 0.5, -2), 
				left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
				fire = CFrame.Angles(0.3490658503988659, 0, 0) * CFrame.new(0, 0, 0.4), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}, 
		killEffect = function(p1)
			if p1 and p1.PrimaryPart then
				u1.Audio.Play(4301885804, p1.PrimaryPart, 1, 1, 300);
				local v1, v2 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v3, v4 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("High Tech KillFX"):GetChildren()) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(3);				
				end;
				v1.Parent = p1;
				for v7, v8 in pairs(p1:GetDescendants()) do
					if v8:IsA("BasePart") and v8.Transparency == 0 then
						if v8.ClassName == "MeshPart" then
							v8.TextureID = "";
						end;
						v8.Material = Enum.Material.SmoothPlastic;
						u1.GUIFX.Rainbow(v8, "Color");
					elseif v8.ClassName == "SpecialMesh" then
						v8.TextureId = "";
					elseif v8.ClassName == "Shirt" or v8.ClassName == "Pants" or v8.ClassName == "ShirtGraphic" or v8.ClassName == "Decal" or v8.ClassName == "Texture" then
						v8:Destroy();
					end;
				end;
				coroutine.wrap(function()
					local v9 = {};
					for v10, v11 in pairs(p1:GetDescendants()) do
						if v11:IsA("BasePart") and v11.Transparency == 0 then
							local v12 = v11:Clone();
							for v13, v14 in ipairs(v12:GetChildren()) do
								if v14.ClassName ~= "SpecialMesh" then
									v14:Destroy();
								end;							
							end;
							v12.Anchored = true;
							v12.CanCollide = false;
							v12.CastShadow = false;
							v12.Transparency = 0.5;
							v12.Name = v12.Name .. "-TRAIL";
							table.insert(v9, {
								og = v11, 
								fake = v12
							});
						end;
					end;
					local l__UpperTorso__16 = p1:FindFirstChild("UpperTorso");
					while p1 and p1.PrimaryPart and l__UpperTorso__16 do
						if u1.Player.Get():DistanceFromCharacter(p1:GetPrimaryPartCFrame().p) < 300 and l__UpperTorso__16.Velocity.Magnitude >= 4 then
							for v17, v18 in ipairs(v9) do
								if v18 then
									local v20 = v18.fake:Clone();
									v20.CFrame = v18.og.CFrame;
									v20.Parent = game.Workspace.__DEBRIS;
									u1.Functions.FastTween(v20, {
										Transparency = 1
									}, { 0.65, "Quad", "Out" }).Completed:Connect(function()
										v20:Destroy();
									end);
								end;							
							end;
						end;
						u1.Functions.Wait(0.4);					
					end;
				end)();
			end;
		end
	}
};
