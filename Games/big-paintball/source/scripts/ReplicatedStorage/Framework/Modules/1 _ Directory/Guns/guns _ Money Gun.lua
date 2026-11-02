-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
return {
	["46"] = {
		displayName = "Money Gun", 
		description = "It's raining money!", 
		thumbnail = "rbxassetid://4597787724", 
		quality = true, 
		premium = true, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		gamepassId = 8015593, 
		productId = 0, 
		damage = 100, 
		velocity = 250, 
		automatic = true, 
		shotrate = 0.085, 
		zoomAmount = 1, 
		additionalSpeed = 2.5, 
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
				u1.Audio.Play(4598002166, p1.UpperTorso.Position, 1, 0.65, 300);
				local v3, v4 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v5, v6, v7 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Money Gun KillFX"):GetChildren()) do
					local v8 = v6:Clone();
					v8.Parent = v4;
					v8:Emit(8);				
				end;
				v3.Parent = p1;
			end;
		end
	}
};
