-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["47"] = {
		displayName = "Guass Gun", 
		description = "\226\154\161 PEW PEW PEW ZAP ZAP ZAP \226\154\161", 
		thumbnail = "rbxassetid://4595356441", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 235, 
		automatic = false, 
		shotrate = 0.1, 
		zoomAmount = 1, 
		additionalSpeed = -1, 
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
				u1.Audio.Play(4598002065, p1:FindFirstChild("UpperTorso"), 1, 0.5, 300);
				local v1, v2 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v3, v4 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Guass KillFX"):GetChildren()) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(15);				
				end;
				v1.Parent = p1;
				for v7, v8 in pairs(p1:GetDescendants()) do
					if v8:IsA("BasePart") and v8.Transparency == 0 then
						if v8.ClassName == "MeshPart" then
							v8.TextureID = "";
						end;
						coroutine.wrap(function()
							v8.BrickColor = BrickColor.new("Cyan");
							v8.Material = Enum.Material.Neon;
							wait(0.1);
							v8.BrickColor = BrickColor.new("Black");
							v8.Material = Enum.Material.SmoothPlastic;
						end)();
					elseif v8.ClassName == "SpecialMesh" then
						v8.TextureId = "";
					elseif v8.ClassName == "Shirt" or v8.ClassName == "Pants" or v8.ClassName == "ShirtGraphic" or v8.ClassName == "Decal" or v8.ClassName == "Texture" then
						v8:Destroy();
					end;
				end;
			end;
		end
	}
};
