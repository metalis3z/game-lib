-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local v2 = {};
local v3 = {
	displayName = "Bubblegum Gun", 
	description = "Sugar free!", 
	thumbnail = "rbxassetid://8760298879", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 750000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 250, 
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
	}
};
local u2 = Random.new();
function v3.killEffect(p1)
	if p1 and p1:FindFirstChild("UpperTorso") and p1:FindFirstChild("Head") then
		coroutine.wrap(function()
			p1.UpperTorso.Velocity = Vector3.new();
			local v4 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Bubblegum"):Clone();
			v4.CFrame = p1.UpperTorso.CFrame * CFrame.new(0, 0, -1);
			v4.Size = Vector3.new(2.5, 2.5, 2.5);
			v4.Parent = p1;
			u1.Functions.FastTween(v4, {
				Size = Vector3.new(8, 8, 8)
			}, { 0.3, "Back", "Out" });
			local v5 = Instance.new("WeldConstraint");
			v5.Part0 = p1.UpperTorso;
			v5.Part1 = v4;
			v5.Parent = v4;
			task.wait(0.1);
			v4.Anchored = false;
			u1.Audio.Play("rbxassetid://8762185472", p1:FindFirstChild("UpperTorso"), 1, 0.75, 300);
			coroutine.wrap(function()
				local v6 = 15;
				while tick() - tick() <= 1.25 do
					u1.Heartbeat();
					v6 = math.clamp(v6 + 1, 0, 45);
					v4.Velocity = Vector3.new(0, v6, 0);				
				end;
				task.wait(0.25);
				u1.Audio.Play("rbxassetid://8762185355", p1:FindFirstChild("UpperTorso"), 1.15 + u2:NextInteger(0, 50) / 100, 0.5, 300);
				local v7, v8 = u1.Functions.CreateParticleHost(v4.CFrame);
				for v9, v10 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Bubblegum KillFX"):GetChildren()) do
					local v12 = v10:Clone();
					v12.Parent = v8;
					v12:Emit(8);				
				end;
				v7.Parent = p1;
				local v13
				if u2:NextInteger(1, 2) == 1 then
					v13 = -75;
				else
					v13 = 75;
				end;
				local v14
				if u2:NextInteger(1, 2) == 1 then
					v14 = -75;
				else
					v14 = 75;
				end;
				p1.UpperTorso.Velocity = Vector3.new(v13, 15, v14);
				v4:Destroy();
			end)();
		end)();
	end;
end;
v2["76"] = v3;
return v2;
