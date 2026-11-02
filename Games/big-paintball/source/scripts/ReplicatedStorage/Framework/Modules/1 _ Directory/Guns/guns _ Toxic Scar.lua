-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["86"] = {
	displayName = "Toxic Scar", 
		description = "%%random", 
	thumbnail = "rbxassetid://10026933952", 
	quality = true, 
	premium = false, 
	offsale = true, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "Toxic", 
	price = 2500000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 170, 
	automatic = true, 
	shotrate = 0.2, 
	zoomAmount = 1, 
	additionalSpeed = 3, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0.75, -0.8, -1.75), 
			left = CFrame.new(0.75, -0.8, -1.75) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0.75, -0.8, -1.75) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0.45) * CFrame.Angles(0.03490658503988659, 0, 0), 
			sprint = CFrame.new(0.75, -1.2, -1.75) * CFrame.Angles(-0.2617993877991494, 0, 0)
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
			while p1 and p1.Parent do
				p1.gun.Reflectance = -2 + math.cos(tick() * 2);
				u1.RenderStepped();			
			end;
		end)();
	end, 
	tracerEffect = function(p2)
		if p2 then
			p2.Color = Color3.fromRGB(0, 255, 0);
			p2.Material = Enum.Material.Neon;
		end;
	end
	}
}