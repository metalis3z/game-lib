-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Firework Gun", 
	description = "The best way to start off your new year... \240\159\152\142\240\159\142\134", 
	thumbnail = "rbxassetid://8481489342", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 900000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 255, 
	automatic = true, 
	shotrate = 0.125, 
	zoomAmount = 1, 
	additionalSpeed = -1, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0.75, -0.75, -2), 
			left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0.5) * CFrame.Angles(0.05235987755982989, 0, 0), 
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
	shootEffect = function(p1)
		if p1 and p1:FindFirstChild("gun") and p1.gun:FindFirstChild("fireworks") then
			p1.gun.fireworks.CFrame = p1.gun.fireworks.CFrame * CFrame.Angles(0, 0, 0.2617993877991494);
		end;
	end, 
	projectileHitEffect = function(p2, p3, p4)
		coroutine.wrap(function()
			wait();
			if p2 and p2.Parent then
				local v3 = p2:Clone();
				v3.CFrame = CFrame.new(p3);
				v3.Size = Vector3.new(2, 2, 2);
				v3.Transparency = 0.5;
				v3.Material = Enum.Material.Neon;
				v3.Color = Color3.fromRGB(255, 255, 255);
				v3.Shape = Enum.PartType.Ball;
				v3.Parent = game.Workspace:WaitForChild("__DEBRIS");
				u1.Functions.FastTween(v3, {
					Size = Vector3.new(0, 0, 0)
				}, { 0.25, "Sine", "InOut" });
				u1.Functions.FastTween(v3, {
					Transparency = 1
				}, { 0.3, "Quad", "Out" });
				u1.Functions.AddDebris(v3, 5);
			end;
		end)();
	end
};
local u2 = Random.new();
local u3 = { 8481375042, 8481374735, 8481374878 };
function v2.killEffect(p5)
	if p5 and p5.PrimaryPart then
		for v4 = 1, u2:NextInteger(8, 16) do
			local v5
			if u2:NextInteger(1, 2) == 1 then
				v5 = "whitespark";
			else
				v5 = "redspark";
			end;
			local v6 = game.ReplicatedStorage.Assets:FindFirstChild(v5):Clone();
			v6.CFrame = CFrame.new(p5.PrimaryPart.CFrame.Position);
			v6.Anchored = false;
			v6.Parent = game.Workspace:WaitForChild("__DEBRIS");
			v6.Velocity = Vector3.new(u2:NextInteger(-1, 1), u2:NextInteger(50, 250) / 25, u2:NextInteger(-1, 1)) * u2:NextInteger(4, 8);
			u1.Functions.AddDebris(v6, 4);
		end;
		u1.Audio.Play(u3[u2:NextInteger(1, #u3)], p5.PrimaryPart, 1, 4, 300);
	end;
end;
v1["75"] = v2;
return v1;
