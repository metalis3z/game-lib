-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local v2 = math.random(9783831755, 9783831920);
local l__AnimationController__3 = script.Parent:FindFirstChild("AnimationController");
local v4 = {};
return {
	["432"] = {
	displayName = "Aquarium Minigun", 
	description = "Under the seaaa \240\159\142\181", 
	thumbnail = "rbxassetid://9961307498", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 385000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 175, 
	automatic = true, 
	shotrate = 0.075, 
	zoomAmount = 1, 
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
};
