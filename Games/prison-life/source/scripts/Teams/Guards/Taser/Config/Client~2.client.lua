-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__GunRemote__2 = game.ReplicatedStorage.GunRemote;
local v3 = require(script.Parent);
local l__Parent__4 = script.Parent.Parent;
local l__Handle__5 = script.Parent.Parent.Handle
local v6 = Instance.new("Part");

local v7 = Instance.new("BlockMesh");
function raycursive(p1, p2, p3)
	local v8, v9 = workspace:FindPartOnRay(Ray.new(p1, p2 * 600), l__LocalPlayer__1.Character);
	return v8, v9;
end;
local u1 = {
	sound = l__GunRemote__2:WaitForChild("Sound"), 
	fire = l__GunRemote__2:WaitForChild("Fire"), 
	tag = l__GunRemote__2:WaitForChild("Tag")
};
local u2 = v3.GetConfig("BaseDamage");
function fire(p4, p5)
	local v10, v11 = raycursive(p5, (p4 - p5).unit);
	local l__magnitude__12 = (p5 - v11).magnitude;
	u1.fire:FireServer(l__magnitude__12, v11, p5, l__Handle__5);
	spawn(function()
	
	end);
	if v10 ~= nil then
		local v14 = v10.Parent:FindFirstChild("Humanoid") or (v10.Parent:findFirstChild("Zombie") or v10.Parent.Parent:FindFirstChild("Humanoid"));
		if v14 ~= nil then
			local v15 = math.random(u2 - u2 * 0.25, u2 + u2 * 0.25);
			if v10.Name == "Head" then
				v15 = v15 * 1.25;
			elseif v10.Name == "Torso" then

			else
				v15 = v15 * 0.75;
			end;
			if 0 < v14.Health then
				local v16 = game.Players:playerFromCharacter(v14.Parent);
				local v17 = game.Players:playerFromCharacter(l__Parent__4.Parent);
				if v16 ~= nil then
					if v17 ~= nil then
						if v16.TeamColor == v17.TeamColor then
							if not v16.Neutral then
								if v17.Neutral then
									u1.tag:FireServer(v14, v15);
									return;
								end;
							else
								u1.tag:FireServer(v14, v15);
								return;
							end;
						else
							u1.tag:FireServer(v14, v15);
							return;
						end;
					else
						u1.tag:FireServer(v14, v15);
					end;
				else
					u1.tag:FireServer(v14, v15);
				end;
			end;
		end;
	end;
end;
local fireanim = 11265308758


repeat wait() until game.Players.LocalPlayer.Character
local lp = game.Players.LocalPlayer
local sp = script.Parent

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. fireanim
local holdtrack = lp.Character.Humanoid:LoadAnimation(anim)
--
local Reload = 11265293524


repeat wait() until game.Players.LocalPlayer.Character
local lp = game.Players.LocalPlayer
local sp = script.Parent

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. Reload
local Reloadanim = lp.Character.Humanoid:LoadAnimation(anim)
--
local equoparm = 11265293524


repeat wait() until game.Players.LocalPlayer.Character
local lp = game.Players.LocalPlayer
local sp = script.Parent

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. equoparm
local equoparmanim = lp.Character.Humanoid:LoadAnimation(anim)



local u3 = v3.GetConfig("mouseIcon");
local u4 = l__Handle__5.EquipArm
local u5 = false;
local u6 = false;
local l__Ammos__7 = l__Parent__4:WaitForChild("Ammos");
local l__Reloading__8 = l__Parent__4:WaitForChild("Reloading");
local u9 = v3.GetConfig("ShotGunMode");
local l__Muzzle__10 = l__Parent__4:WaitForChild("Muzzle");
local u11 = v3.GetConfig("maxspread");
local u12 = l__Handle__5.Shot
local u13 = l__Handle__5.Reload2H
local u14 = v3.GetConfig("reloadtime");
local u15 = v3.GetConfig("maxammos");
local u16 = v3.GetConfig("maxspeedrate");
local u17 = v3.GetConfig("automatic");
local u18 = nil;
local l__UserInputService__19 = game:GetService("UserInputService");
l__Parent__4.Equipped:Connect(function(p6)
	
	p6.Icon = u3;
	equoparmanim:Play();
	p6.Button1Down:Connect(function()
		u5 = true;
		if l__LocalPlayer__1.Character.Humanoid.Health < 1 then
			return;
		end;
		if u6 == false then
			u6 = true;
			while u5 == true do
				if l__Ammos__7.Value == 0 then
					if l__Ammos__7.Value == 0 and l__Reloading__8.Value == false then
						l__Reloading__8.Value = true;
						u1.sound:FireServer(l__Handle__5.Reload, false, l__Handle__5);
						Reloadanim:Play()
						wait(u14);
						if l__Ammos__7.Value < u15 then
							l__Ammos__7.Value = u15;
						end;
						l__Reloading__8.Value = false;
					end;
					break;
				end;
				if l__Reloading__8.Value ~= false then
					if l__Ammos__7.Value == 0 and l__Reloading__8.Value == false then
						l__Reloading__8.Value = true;
						u1.sound:FireServer(l__Handle__5.Reload, false, l__Handle__5);
						
						wait(u14);
						if l__Ammos__7.Value < u15 then
							l__Ammos__7.Value = u15;
						end;
						l__Reloading__8.Value = false;
					end;
					break;
				end;
				if u9 == true then
				
					local l__Position__18 = l__Muzzle__10.Position;
					local l__magnitude__19 = (p6.Hit.p - l__Position__18).magnitude;
					for v20 = 1, 10 do
						fire(p6.Hit.p + Vector3.new(math.random(-(u11 / 10) * l__magnitude__19, u11 / 10 * l__magnitude__19), math.random(-(u11 / 10) * l__magnitude__19, u11 / 10 * l__magnitude__19), math.random(-(u11 / 10) * l__magnitude__19, u11 / 10 * l__magnitude__19)), l__Position__18);
					end;
					u1.sound:FireServer(l__Handle__5.Fire, true, l__Handle__5);
					holdtrack:Play()
				else
					
					local l__Position__21 = l__Muzzle__10.Position;
					local l__magnitude__22 = (p6.Hit.p - l__Position__21).magnitude;
					fire(p6.Hit.p + Vector3.new(math.random(-(u11 / 10) * l__magnitude__22, u11 / 10 * l__magnitude__22), math.random(-(u11 / 10) * l__magnitude__22, u11 / 10 * l__magnitude__22), math.random(-(u11 / 10) * l__magnitude__22, u11 / 10 * l__magnitude__22)), l__Position__21);
					u1.sound:FireServer(l__Handle__5.Fire, true, l__Handle__5);
					holdtrack:Play()
				end;
				wait(u16);
				if u17 == false then
					break;
				end;			
			end;
			u6 = false;
		end;
	end);
	p6.Button1Up:Connect(function()
		u5 = false;
	end);
	p6.KeyDown:Connect(function(p7)
		if p7:lower() == "r" and l__Reloading__8.Value == false then
			l__Reloading__8.Value = true;
			u1.sound:FireServer(l__Handle__5.Reload, false, l__Handle__5);
			Reloadanim:Play()
			wait(u14);
			if l__Ammos__7.Value < u15 then
				l__Ammos__7.Value = u15;
			end;
			l__Reloading__8.Value = false;
		end;
	end);
	u18 = l__UserInputService__19.InputBegan:Connect(function(p8)
		if p8.KeyCode == Enum.KeyCode.ButtonX and l__Reloading__8.Value == false then
			l__Reloading__8.Value = true;
			u1.sound:FireServer(l__Handle__5.Reload, false, l__Handle__5);
		
			wait(u14);
			if l__Ammos__7.Value < u15 then
				l__Ammos__7.Value = u15;
			end;
			l__Reloading__8.Value = false;
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
			Reloadanim:Stop()
		end;
	end);
end);
l__Parent__4.Unequipped:Connect(function()
	
	equoparmanim:Stop();
	holdtrack:Stop()
	Reloadanim:Stop();
end);
game.Workspace.ChildAdded:Connect(function(p9)
	if p9.Name == l__LocalPlayer__1.Name .. "Bullet" then
		p9.Transparency = 1;
	end;
end);
