-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local v2 = math.random(9783831755, 9783831920);
local l__AnimationController__3 = script.Parent:FindFirstChild("AnimationController");
local v4 = {};
local v5 = {
	displayName = "Aquarium AK", 
	description = "Seems fishy... \240\159\144\159", 
	thumbnail = "rbxassetid://9784547433", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 4125000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 300, 
	automatic = true, 
	shotrate = 0.12, 
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
			if p1 and p1:FindFirstChild("gun") and p1.gun:FindFirstChild("fish") then
				local v6 = Instance.new("Animation");
				v6.AnimationId = "http://www.roblox.com/asset/?id=9783378688";
				p1.gun.fish:WaitForChild("AnimationController"):LoadAnimation(v6):Play();
			end;
		end)();
	end
};
local u2 = Random.new();
function v5.killEffect(p2)
	if p2 and p2:FindFirstChild("UpperTorso") and p2:FindFirstChild("Head") then
		coroutine.wrap(function()
			p2.UpperTorso.Velocity = Vector3.new();
			local v7 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Bubblegum"):Clone();
			v7.CFrame = p2.UpperTorso.CFrame * CFrame.new(0, 0, -1);
			v7.Size = Vector3.new(2.5, 2.5, 2.5);
			v7.Parent = p2;
			u1.Functions.FastTween(v7, {
				Size = Vector3.new(8, 8, 8)
			}, { 0.3, "Back", "Out" });
			local v8 = Instance.new("WeldConstraint");
			v8.Part0 = p2.UpperTorso;
			v8.Part1 = v7;
			v8.Parent = v7;
			task.wait(0.1);
			v7.Anchored = false;
			u1.Audio.Play("rbxassetid://9783831755", p2:FindFirstChild("UpperTorso"), 1, 0.75, 300);
			coroutine.wrap(function()
				local v9 = 15;
				while tick() - tick() <= 1.25 do
					u1.Heartbeat();
					v9 = math.clamp(v9 + 1, 0, 45);
					v7.Velocity = Vector3.new(0, v9, 0);				
				end;
				task.wait(0.25);
				u1.Audio.Play("rbxassetid://9783831920", p2:FindFirstChild("UpperTorso"), 1.15 + u2:NextInteger(0, 50) / 100, 0.5, 300);
				local v10, v11 = u1.Functions.CreateParticleHost(v7.CFrame);
				for v12, v13 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Aquarium AK"):GetChildren()) do
					local v15 = v13:Clone();
					v15.Parent = v11;
					v15:Emit(u2:NextInteger(5, 8));				
				end;
				v10.Parent = p2;
				local v16
				if u2:NextInteger(1, 2) == 1 then
					v16 = -75;
				else
					v16 = 75;
				end;
				local v17
				if u2:NextInteger(1, 2) == 1 then
					v17 = -75;
				else
					v17 = 75;
				end;
				p2.UpperTorso.Velocity = Vector3.new(v16, 15, v17);
				v7:Destroy();
			end)();
		end)();
	end;
end;
v4["82"] = v5;
return v4;
