-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["24"] = {
		displayName = "Toon Gun", 
		description = "Straight out of a cartoon!", 
		thumbnail = "rbxassetid://4352524719", 
		quality = false, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 175000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 205, 
		automatic = false, 
		shotrate = 0.0875, 
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
		}, 
		killEffect = function(p1)
			if p1 and p1.PrimaryPart then
				local v1 = {};
				local v2 = {};
				u1.Audio.Play(4301789492, p1.PrimaryPart, 1, 0.5, 300);
				for v3, v4 in pairs(p1:GetDescendants()) do
					if v4:IsA("BasePart") and v4.Name ~= "Head" then
						v1[v4] = v4.Size;
						u1.Functions.FastTween(v4, {
							Size = v4.Size / 1.5
						}, { 0.2, "Elastic", "Out" });
					end;
					if v4:IsA("Attachment") then
						v2[v4] = v4.Position;
						u1.Functions.FastTween(v4, {
							Position = v4.Position / 1.5
						}, { 0.2, "Elastic", "Out" });
					end;				
				end;
			end;
		end
	}
};
