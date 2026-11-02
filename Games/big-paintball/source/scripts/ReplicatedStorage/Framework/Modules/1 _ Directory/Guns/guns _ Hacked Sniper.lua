-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["62"] = {
	displayName = "Hacked Sniper", 
	description = "01001000 01000001 01011000 00110000 01010010", 
	thumbnail = "rbxassetid://6738852869", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 1010101, 
	gamepassId = 0, 
		productId = 0, 
		hacked = true,
	damage = 100, 
	velocity = 800, 
	automatic = false, 
	shotrate = 0.7, 
	zoomAmount = 2, 
	additionalSpeed = 0, 
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
			local v3 = tick() - 1;
			while p1 and p1.Parent do
				local v4 = tick() - v3;
				p1.gun.Transparency = 0.1 + math.sin(v4) * 0.1;
				for v5, v6 in ipairs(p1.gun:GetChildren()) do
					if v6.ClassName == "Texture" then
						v6.OffsetStudsV = v4 / 1.5;
					end;				
				end;
				u1.RenderStepped();			
			end;
		end)();
		end
		}
};