-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Royale Sniper", 
	description = "Absolutely perfect precision with a 24 karat golden finish. \240\159\145\145", 
	thumbnail = "rbxassetid://4834466392", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 11500000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 825, 
	automatic = false, 
	shotrate = 0.55, 
	zoomAmount = 2, 
	additionalSpeed = -1, 
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
			fire = CFrame.Angles(0.17453292519943295, 0, 0) * CFrame.new(0, 0, 0.4), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		local u3 = nil;
		local v3, v4 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		for v5, v6 in ipairs((game.ReplicatedStorage.Assets.Particles:FindFirstChild("Royale"):GetChildren())) do
			local v8 = v6:Clone();
			v8.Parent = v4;
			v8:Emit(8);		
		end;
		u1.Audio.Play(4859923977, v3, 1, 0.65, 300);
		u1.Functions.AddDebris(v3, 5);
		for v9 = 1, math.random(5, 10) do
			u3 = p1;
			coroutine.wrap(function()
				local v10 = game.ReplicatedStorage.Assets.Sparkle:Clone();
				u1.PhysicsService:SetPartCollisionGroup(v10, "Present");
				v10.CFrame = u3:GetPrimaryPartCFrame();
				v10.Velocity = Vector3.new(u2:NextNumber(-100, 100), u2:NextNumber(-100, 100), u2:NextNumber(-100, 100));
				v10.Parent = game.Workspace.__DEBRIS;
				wait(1.5);
				v10.Sparkles.Enabled = false;
				wait(1.5);
				v10:Destroy();
			end)();
		end;
		u1.Audio.Play(4102527358, u3:FindFirstChild("UpperTorso"), 1, 0.5, 300);
		local v11, v12 = u1.Functions.CreateParticleHost(u3.PrimaryPart.CFrame);
		for v13, v14 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Golden KillFX"):GetChildren()) do
			local v16 = v14:Clone();
			v16.Parent = v12;
			v16:Emit(10);		
		end;
		v11.Parent = u3;
		for v17, v18 in pairs(u3:GetDescendants()) do
			if v18:IsA("BasePart") and v18.Transparency == 0 then
				if v18.ClassName == "MeshPart" then
					v18.TextureID = "";
				end;
				v18.BrickColor = BrickColor.new("Gold");
			elseif v18.ClassName == "SpecialMesh" then
				v18.TextureId = "";
			elseif v18.ClassName == "Shirt" or v18.ClassName == "Pants" or v18.ClassName == "ShirtGraphic" or v18.ClassName == "Decal" or v18.ClassName == "Texture" then
				v18:Destroy();
			end;
		end;
	end;
end;
v1["48"] = v2;
return v1;
