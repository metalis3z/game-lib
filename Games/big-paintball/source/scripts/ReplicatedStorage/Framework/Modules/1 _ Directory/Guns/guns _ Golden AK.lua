-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
return {
	["54"] = {
		displayName = "Golden AK", 
		description = "Awarded to those who completed the 2020 Winter Event!", 
		thumbnail = "rbxassetid://6054124260", 
		quality = true, 
		premium = false, 
		offsale = true, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 315, 
		automatic = true, 
		shotrate = 0.125, 
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
		killEffect = function(p1)
			if p1 and p1:FindFirstChild("UpperTorso") then
				u1.Audio.Play(4102527358, p1:FindFirstChild("UpperTorso"), 1, 0.5, 300);
				local v2, v3 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v4, v5 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Golden KillFX"):GetChildren()) do
					local v7 = v5:Clone();
					v7.Parent = v3;
					v7:Emit(10);				
				end;
				v2.Parent = p1;
				for v8, v9 in pairs(p1:GetDescendants()) do
					if v9:IsA("BasePart") and v9.Transparency == 0 then
						if v9.ClassName == "MeshPart" then
							v9.TextureID = "";
						end;
						v9.BrickColor = BrickColor.new("Gold");
					elseif v9.ClassName == "SpecialMesh" then
						v9.TextureId = "";
					elseif v9.ClassName == "Shirt" or v9.ClassName == "Pants" or v9.ClassName == "ShirtGraphic" or v9.ClassName == "Decal" or v9.ClassName == "Texture" then
						v9:Destroy();
					end;
				end;
			end;
		end
	}
};
