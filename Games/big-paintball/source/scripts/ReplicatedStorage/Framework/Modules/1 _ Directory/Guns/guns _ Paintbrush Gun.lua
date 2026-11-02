-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Paintbrush Gun", 
	description = "Unlocked for FREE by helping us achieve 1.3 MILLION LIKES!", 
	thumbnail = "rbxassetid://6775453185", 
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
	velocity = 325, 
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
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1:FindFirstChild("UpperTorso") then
		local v3 = tick();
		local v4, v5 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
		for v6, v7 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Paintbrush KillFX"):GetChildren()) do
			local v9 = v7:Clone();
			v9.Parent = v5;
			v9:Emit(5);		
		end;
		v4.Parent = p1;
		for v10, v11 in pairs(p1:GetDescendants()) do
			if v11:IsA("BasePart") and v11.Transparency == 0 then
				if v11.ClassName == "MeshPart" then
					v11.TextureID = "";
				end;
				v11.Color = Color3.fromRGB(122, 89, 1);
			elseif v11.ClassName == "SpecialMesh" then
				v11.TextureId = "";
			elseif v11.ClassName == "Shirt" or v11.ClassName == "Pants" or v11.ClassName == "ShirtGraphic" or v11.ClassName == "Decal" or v11.ClassName == "Texture" then
				v11:Destroy();
			end;
		end;
		for v12, v13 in pairs(p1:GetDescendants()) do
			if v13:IsA("BasePart") then
				v13.Color = Color3.fromHSV(u2:NextInteger(1, 100) / 100, 1, 1);
			end;
		end;
		local l__Position__3 = p1.UpperTorso.CFrame.Position;
		coroutine.wrap(function()
			for v14 = 1, u2:NextInteger(8, 14) do
				local v15 = l__Position__3 + Vector3.new(u2:NextInteger(-300, 300) / 100, 0, u2:NextInteger(-300, 300) / 100);
				local v16, v17 = u1.Functions.QuickRay(CFrame.new(v15 + Vector3.new(-1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v18, v19 = u1.Functions.QuickRay(CFrame.new(v15 + Vector3.new(1, 10, 1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v20, v21 = u1.Functions.QuickRay(CFrame.new(v15 + Vector3.new(-1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				local v22, v23 = u1.Functions.QuickRay(CFrame.new(v15 + Vector3.new(1, 10, -1)), CFrame.new(0, -3500, 0), { game.Workspace:WaitForChild("__MAP") });
				if v16 and v18 and v20 and v22 then
					local l__unit__24 = (v17 - v21).unit;
					local l__unit__25 = (v23 - v21).unit;
					local v26 = l__unit__25:Cross(l__unit__24);
					local v27 = 0.25 * (v17 + v19 + v21 + v23);
					local v28 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("PaintSmear"):Clone();
					v28.CFrame = CFrame.new(v27.X, v27.Y, v27.Z, l__unit__25.X, v26.X, -l__unit__24.X, l__unit__25.Y, v26.Y, -l__unit__24.Y, l__unit__25.Z, v26.Z, -l__unit__24.Z) * CFrame.fromEulerAnglesXYZ(0, u2:NextInteger(1, 360), 0);
					v28.Size = Vector3.new(3, 0.4, 3);
					v28.Parent = game.Workspace.__DEBRIS;
					local v29 = math.random(150, 650) / 95;
					u1.Functions.FastTween(v28, {
						Size = Vector3.new(v29, 0.4, v29)
					}, { u2:NextInteger(175, 350) / 1000, "Back", "Out" });
					v28.Decal.Color3 = Color3.fromHSV(u2:NextInteger(1, 100) / 100, 1, 1);
					coroutine.wrap(function()
						wait(1 + u2:NextInteger(-25, 25) / 100);
						u1.Functions.FastTween(v28.Decal, {
							Transparency = 1
						}, { 0.3, "Sine", "InOut" });
						wait(0.3);
						v28:Destroy();
					end)();
				end;
				if u2:NextInteger(1, 8) == 1 then
					wait();
				end;
			end;
		end)();
	end;
end;
v1["73"] = v2;
return v1;
