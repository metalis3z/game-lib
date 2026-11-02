--!nolint
local v1 = require(script.Parent.Main);
local v2 = require(script.Parent.Modules.Spring);
local v3 = require(game:GetService("ReplicatedStorage").ItemDatabase);
local l__UserInputService__4 = game:GetService("UserInputService");
local l__LocalPlayer__5 = game.Players.LocalPlayer;
local l__Humanoid__6 = v1.char:WaitForChild("Humanoid");
local v7 = {
	Auto = {
		angle = 180
	}, 
	Semi = {
		angle = 90
	}
};
for v8, v9 in pairs(v7) do
	print(v9.angle);
end;
local l__ShootyMcGoot__10 = game:GetService("ReplicatedStorage").EntityInfo:WaitForChild("ShootyMcGoot");
function playAnim(p1, p2, p3, p4)
	pcall(function()
		p1:Play(p2, p3, p4);
	end);
end;
function stopAnim(p5, p6)
	pcall(function()
		p5:Stop(p6);
	end);
end;
local u1 = false;
local l__AmmoBar__2 = script.Parent:WaitForChild("MainFrame"):WaitForChild("AmmoBar");
local u3 = {};
local l__TweenService__4 = game:GetService("TweenService");
function ammoupdate()
	pcall(function()
		if v1.fakeTool then
			if u1 == true then
				l__AmmoBar__2.Ammo.Text = v1.tool.CurrentAmmo.Value .. " / " .. u3.Ammo;
				l__AmmoBar__2.TotalAmmo.Text = "999";
				l__TweenService__4:Create(l__AmmoBar__2.Bar.UIGradient, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Offset = Vector2.new(-(0.5 - v1.tool.CurrentAmmo.Value / u3.Ammo), 0)
				}):Play();
			end;
		end;
	end);
end;
function selectfire(p7)
	if p7 then
		local v11 = 1;
		local v12 = {};
		if ci("Mode_Auto") == true then
			table.insert(v12, "Auto");
		end;
		if v1.tool:GetAttribute("Mode_Semi") == true then
			table.insert(v12, "Semi");
		end;
		if v1.tool:GetAttribute("Mode_Burst") == true then
			table.insert(v12, "Burst");
		end;
		local v13, v14, v15 = pairs(v12);
		while true do
			local v16, v17 = v13(v14, v15);
			if v16 then

			else
				break;
			end;
			v15 = v16;
			if v1.tool:GetAttribute("Mode") == v17 then
				v11 = v16;
			end;		
		end;
		local v18, v19, v20 = pairs(v12);
		while true do
			local v21, v22 = v18(v19, v20);
			if v21 then

			else
				break;
			end;
			v20 = v21;
			if not (v11 < v21) then

			else
				v1.tool:SetAttribute("Mode", v22);
				print("mode is now " .. v22);
				break;
			end;
			if #v12 <= v11 then
				if v21 == 1 then
					v1.tool:SetAttribute("Mode", v22);
					print("mode is now " .. v22);
					break;
				end;
			end;		
		end;
	end;
	if v1.fakeTool then
		if v1.fakeTool.Handle:FindFirstChild("Selector") then
			l__TweenService__4:Create(v1.fakeTool.Handle:FindFirstChild("Selector"), TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				C0 = v1.fakeTool.Handle:FindFirstChild("SelectorOrigin").Value * CFrame.Angles(math.rad(v7[v1.tool:GetAttribute("Mode")].angle), 0, 0)
			}):Play();
			print("changed to " .. v7[v1.tool:GetAttribute("Mode")].angle);
		end;
	end;
end;
function makeft()
	local v23, v24, v25 = pairs(v1.viewmodel:GetChildren());
	while true do
		local v26, v27 = v23(v24, v25);
		if v26 then

		else
			break;
		end;
		v25 = v26;
		if v27:IsA("Tool") then
			v27:Destroy();
		end;	
	end;
	v1.fakeTool = v1.tool:Clone();
	v1.fakeTool.Name = "Tool";
	v1.fakeTool.Parent = v1.viewmodel;
	if v1.fakeTool:WaitForChild("Handle", 1) then

	else
		v1.fakeTool:Destroy();
		v1.fakeTool = nil;
		return;
	end;
	local v28 = Instance.new("Motor6D");
	v28.Name = "ToolGrip";
	v28.Part1 = v1.fakeTool.Handle;
	v28.Part0 = v1.viewmodel.UpperTorso;
	v28.C1 = v1.fakeTool.Handle.Attach.CFrame;
	v28.C0 = v1.viewmodel.UpperTorso.ToolAttachment.CFrame;
	v28.Parent = v1.viewmodel.RightHand;
	if v1.fakeTool:FindFirstChild("SightAttachment", true) then
		v1.sightui = v1.fakeTool:FindFirstChild("SightAttachment", true).UI;
		v1.sightui.Enabled = true;
		v1.sightui.Crosshair.ImageTransparency = 1;
	else
		v1.sightui = nil;
	end;
	pcall(function()
		local v29, v30, v31 = pairs(v1.fakeTool:GetDescendants());
		while true do
			local v32, v33 = v29(v30, v31);
			if v32 then

			else
				break;
			end;
			if v33:IsA("SurfaceGui") then
				v33.Enabled = true;
			end;
			if v33:IsA("BasePart") then
				v33.CollisionGroupId = 1;
				v33.Massless = true;
				v33.CastShadow = false;
			end;
			if v33:IsA("Light") then
				if v33.Name == "LightToEnabled" then
					if v1.tool.Name == "Flashlight" then
						delay(0.63, function()
							v33.Enabled = true;
						end);
					else
						v33.Enabled = true;
					end;
					v33.Shadows = false;
				end;
			end;
			if v33:IsA("ParticleEmitter") then
				if v33.Name == "ParticleToEnabled" then
					if v1.tool.Name == "Flashlight" then
						delay(0.63, function()
							v33:Emit(3);
							v33.Enabled = true;
							v1.recoil_spring:Impulse(Vector3.new(3, 5, 3));
						end);
					else
						v33.Enabled = true;
					end;
				end;
			end;		
		end;
	end);
	selectfire();
end;
local u5 = {
	idle = nil, 
	aim = nil, 
	fire = nil, 
	fireAim = nil, 
	reload = nil, 
	reloadempty = nil, 
	holster = nil, 
	select = nil, 
	equip = nil, 
	unequip = nil, 
	live_idle = nil, 
	live_aim = nil, 
	live_fire = nil
};
local u6 = tick();
local u7 = tick();
function reload()
	if v1.fakeTool then
		if u1 == true then
			if v1.tool.Reloading.Value == false then
				local l__tool__34 = v1.tool;
				local l__CurrentAmmo__35 = l__tool__34.CurrentAmmo;
				local v36 = u3.Reload;
				if l__CurrentAmmo__35.Value <= 0 then
					playAnim(u5.reloadempty, 0.1, 1, 1);
					l__CurrentAmmo__35.Value = 0;
				else
					playAnim(u5.reload, 0.1, 1, 1);
					v36 = u3.ReloadPartial;
					if u3.CanChamber == true then
						l__CurrentAmmo__35.Value = 1;
					else
						l__CurrentAmmo__35.Value = 0;
					end;
				end;
				ammoupdate();
				v1.aiming = false;
				stopAnim(u5.aim, 0.2);
				stopAnim(u5.live_aim, 0.2);
				u6 = tick() + v36 + 0.2;
				u7 = tick() + v36 + 0.2;
				l__tool__34.Reloading.Value = true;
				wait(v36);
				if l__tool__34 == v1.tool then
					if l__tool__34.Reloading.Value == true then
						u6 = tick() + 0.4;
						u7 = tick() + 0.4;
						l__CurrentAmmo__35.Value = math.clamp(l__CurrentAmmo__35.Value + u3.Ammo, 0, u3.Ammo + 1);
						l__tool__34.Reloading.Value = false;
						ammoupdate();
						return;
					else
						warn("huh");
					end;
				else
					warn("huh");
				end;
			end;
		end;
	end;
end;
local u8 = false;
function fire()
	if v1.char.Stunned.Value == true then
		return;
	end;
	if v1.tool then
		if v1.tool:GetAttribute("Reloading") == true then
			return;
		end;
	end;
	if v1.fakeTool then
		if u1 == false then
			playAnim(u5.fire, 0.025, 1, 1);
			playAnim(u5.live_fire, 0.05, 1, 1);
			u8 = false;
			v1.playaudio(v1.tool.Handle.Fire);
			v1.recoil_spring:Impulse(Vector3.new(35, -25, 0));
			wait(0.1);
			local v37 = v1.cam.CFrame.p + v1.cam.CFrame.LookVector * 1;
			local v38 = 5;
			local v39 = nil;
			local v40 = nil;
			local v41, v42, v43 = pairs(workspace:FindPartsInRegion3(Region3.new(v37 - Vector3.new(5, 5, 5), v37 + Vector3.new(5, 5, 5)), nil, 100));
			while true do
				local v44, v45 = v41(v42, v43);
				if v44 then

				else
					break;
				end;
				v43 = v44;
				if v45 ~= v1.char.HumanoidRootPart then
					if v45 ~= v1.viewmodel.HumanoidRootPart then
						if v45.Name == "HumanoidRootPart" then
							if v45.Parent:FindFirstChild("Humanoid") then
								if 0.1 < v45.Parent:FindFirstChild("Humanoid").Health then
									if (v37 - v45.Position).Magnitude < v38 then
										v38 = (v37 - v45.Position).Magnitude;
										v39 = v45.Parent;
										v40 = v45.Position;
									end;
								end;
							end;
						end;
					end;
				end;			
			end;
			if v39 then
				if v40 then
					game:GetService("ReplicatedStorage").EntityInfo.Item_MeleeReplication:FireServer(v39, v40);
					wait(0.05);
					v1.spring:Impulse(Vector3.new(-6, 6, 0));
					v1.recoil_spring:Impulse(Vector3.new(-13, 13, 0));
					return;
				end;
			end;
		elseif v1.fakeTool then
			if u1 == true then
				local l__CurrentAmmo__46 = v1.tool.CurrentAmmo;
				if l__CurrentAmmo__46.Value <= 0 then
					reload();
					return;
				end;
				stopAnim(u5.select, 0);
				stopAnim(u5.reload, 0.1);
				stopAnim(u5.reloadempty, 0.1);
				playAnim(u5.fire, 0.1, 1, 1);
				playAnim(u5.live_fire, 0.05, 1, 1);
				local v47 = 1;
				if v1.aiming == false then
					v47 = 1.5;
				end;
				local v48 = v1.cam.CFrame * CFrame.Angles(math.rad(v1.spring.p.Y * -2 + v1.recoil_spring.p.y * 0.666 * v47), math.rad(v1.spring.p.X * -6 + v1.recoil_spring.p.x * 0.666 * v47), 0);
				if v1.aiming == true then
					local v49 = math.ceil(u3.SpreadAim * 100);
					local v50 = math.random(-v49 * 100, v49 * 100) / 100000;
					if v1.sprinting == true then
						v50 = v50 * 4;
					end;
					local v51 = math.rad(v50);
					local v52 = math.ceil(u3.SpreadAim * 100);
					local v53 = math.random(-v52 * 100, v52 * 100) / 100000;
					if v1.sprinting == true then
						v53 = v53 * 4;
					end;
					local v54 = v48 * CFrame.Angles(v51, math.rad(v53), 0);
				else
					local v55 = math.ceil(u3.Spread * 100);
					local v56 = math.random(-v55 * 100, v55 * 100) / 100000;
					if v1.sprinting == true then
						v56 = v56 * 4;
					end;
					local v57 = math.rad(v56);
					local v58 = math.ceil(u3.Spread * 100);
					local v59 = math.random(-v58 * 100, v58 * 100) / 100000;
					if v1.sprinting == true then
						v59 = v59 * 4;
					end;
					v54 = v48 * CFrame.Angles(v57, math.rad(v59), 0);
				end;
				local l__Recoil__60 = u3.Recoil;
				v1.recoil_spring:Impulse(Vector3.new(math.random(-l__Recoil__60, l__Recoil__60) * v47 * 0.5, l__Recoil__60 * v47 * 1, 0));
				script.Parent.Event_FireWeapon:Fire(v1.fakeTool, v1.cam.CFrame.p + v54.LookVector * 500);
				l__CurrentAmmo__46.Value = l__CurrentAmmo__46.Value - 1;
				l__AmmoBar__2.Visible = true;
				ammoupdate();
			end;
		end;
	elseif v1.fakeTool then
		if u1 == true then
			l__CurrentAmmo__46 = v1.tool.CurrentAmmo;
			if l__CurrentAmmo__46.Value <= 0 then
				reload();
				return;
			end;
			stopAnim(u5.select, 0);
			stopAnim(u5.reload, 0.1);
			stopAnim(u5.reloadempty, 0.1);
			playAnim(u5.fire, 0.1, 1, 1);
			playAnim(u5.live_fire, 0.05, 1, 1);
			v47 = 1;
			if v1.aiming == false then
				v47 = 1.5;
			end;
			v48 = v1.cam.CFrame * CFrame.Angles(math.rad(v1.spring.p.Y * -2 + v1.recoil_spring.p.y * 0.666 * v47), math.rad(v1.spring.p.X * -6 + v1.recoil_spring.p.x * 0.666 * v47), 0);
			if v1.aiming == true then
				v49 = math.ceil(u3.SpreadAim * 100);
				v50 = math.random(-v49 * 100, v49 * 100) / 100000;
				if v1.sprinting == true then
					v50 = v50 * 4;
				end;
				v51 = math.rad(v50);
				v52 = math.ceil(u3.SpreadAim * 100);
				v53 = math.random(-v52 * 100, v52 * 100) / 100000;
				if v1.sprinting == true then
					v53 = v53 * 4;
				end;
				v54 = v48 * CFrame.Angles(v51, math.rad(v53), 0);
			else
				v55 = math.ceil(u3.Spread * 100);
				v56 = math.random(-v55 * 100, v55 * 100) / 100000;
				if v1.sprinting == true then
					v56 = v56 * 4;
				end;
				v57 = math.rad(v56);
				v58 = math.ceil(u3.Spread * 100);
				v59 = math.random(-v58 * 100, v58 * 100) / 100000;
				if v1.sprinting == true then
					v59 = v59 * 4;
				end;
				v54 = v48 * CFrame.Angles(v57, math.rad(v59), 0);
			end;
			l__Recoil__60 = u3.Recoil;
			v1.recoil_spring:Impulse(Vector3.new(math.random(-l__Recoil__60, l__Recoil__60) * v47 * 0.5, l__Recoil__60 * v47 * 1, 0));
			script.Parent.Event_FireWeapon:Fire(v1.fakeTool, v1.cam.CFrame.p + v54.LookVector * 500);
			l__CurrentAmmo__46.Value = l__CurrentAmmo__46.Value - 1;
			l__AmmoBar__2.Visible = true;
			ammoupdate();
		end;
	end;
end;
l__UserInputService__4.InputBegan:connect(function(p8)
	if p8.UserInputType == Enum.UserInputType.MouseButton1 then
		v1.holdclick = true;
		if v1.tool ~= nil then
			if u6 < tick() + 0.3 then
				u8 = true;
			end;
			u7 = math.clamp(tick(), u6, tick() + 9999999999);
			if v1.sprinting == true then
				pcall(function()
					if u5.holster.IsPlaying == true then
						u7 = u7 + 0.2;
						u6 = u7;
						u8 = true;
						stopAnim(u5.holster, 0.15, 1, 1);
						delay(3, function()
							if v1.tool and (v1.tool:GetAttribute("Attachment_Underbarrel") == "" and v1.sprinting == true and u5.holster.IsPlaying == false and u5.fire.IsPlaying == false) then
								playAnim(u5.holster, 0.4, 1, 1);
							end;
						end);
					end;
				end);
				return;
			end;
		end;
	elseif p8.UserInputType == Enum.UserInputType.MouseButton2 then
		if v1.tool ~= nil and u1 == true and v1.tool.Reloading.Value == false then
			v1.aiming = true;
			playAnim(u5.aim, 0.2, 1, 1);
			playAnim(u5.live_aim, 0.2, 1, 1);
			return;
		end;
	else
		if p8.KeyCode == Enum.KeyCode.R then
			reload();
			return;
		end;
		if p8.KeyCode == Enum.KeyCode.B and v1.tool and v1.tool.CurrentAmmo.Value > 0 and u5.reload.IsPlaying == false and u5.reloadempty.IsPlaying == false then
			playAnim(u5.select, 0.03, 1, 1.35);
			u8 = false;
			u6 = tick() + 0.3;
			u7 = tick() + 0.3;
			selectfire(true);
		end;
	end;
end);
l__UserInputService__4.InputEnded:connect(function(p9)
	if p9.UserInputType == Enum.UserInputType.MouseButton1 then
		v1.holdclick = false;
		return;
	end;
	if p9.UserInputType == Enum.UserInputType.MouseButton2 then
		v1.aiming = false;
		if v1.tool ~= nil then
			v1.aiming = false;
			stopAnim(u5.aim, 0.2);
			stopAnim(u5.live_aim, 0.2);
		end;
	end;
end);
local u9 = game["Run Service"];
local u10 = nil;
v1.char.ChildAdded:connect(function(p10)
	if p10:IsA("Tool") then
		v1.tool = p10;
		v1.ti = v3[p10.Name];
		for v61, v62 in pairs(v1.viewmodel:GetChildren()) do
			if v62:IsA("Tool") then
				v62:Destroy();
			end;
		end;
		stopAnim(u5.live_aim, 0);
		stopAnim(u5.live_idle, 0);
		stopAnim(u5.live_fire, 0);
		if v1.char:FindFirstChildOfClass("Tool") == nil then
			for v63, v64 in pairs(v1.viewmodel.Bing:GetPlayingAnimationTracks()) do
				v64:Stop(0);
			end;
		end;
		script.Parent.Event_RepositionViewmodel:Fire();
		for v65, v66 in pairs(v1.viewmodel:GetChildren()) do
			if v66:IsA("Tool") then
				v66:Destroy();
			end;
		end;
		u9.RenderStepped:wait();
		u10 = p10.ChildAdded:Connect(function()
			v1.update();
			playAnim(u5.unequip, 0);
			wait(0.2);
			v1.update();
			playAnim(u5.equip, 0);
			makeft();
		end);
		u8 = false;
		u6 = tick() + 0.3;
		u7 = tick() + 0.3;
		if p10:FindFirstChild("Configuration") then
			u1 = true;
			for v67, v68 in pairs(p10:GetAttributes()) do
				u3[v67] = v68;
				if v67 == "Cooldown" then
					u3[v67] = 1 / v68;
				end;
			end;
			l__AmmoBar__2.Visible = true;
		else
			u1 = false;
			v1.aiming = false;
			stopAnim(u5.aim, 0);
			stopAnim(u5.live_aim, 0);
			l__AmmoBar__2.Visible = false;
		end;
		v1.tool:WaitForChild("Animations", 1);
		local l__idle__69 = v1.tool.Animations:FindFirstChild("idle");
		if l__idle__69 then
			local v70 = v1.viewmodel.Bing:LoadAnimation(l__idle__69);
		else
			v70 = nil;
		end;
		u5.idle = v70;
		local l__aim__71 = v1.tool.Animations:FindFirstChild("aim");
		if l__aim__71 then
			local v72 = v1.viewmodel.Bing:LoadAnimation(l__aim__71);
		else
			v72 = nil;
		end;
		u5.aim = v72;
		local l__fire__73 = v1.tool.Animations:FindFirstChild("fire");
		if l__fire__73 then
			local v74 = v1.viewmodel.Bing:LoadAnimation(l__fire__73);
		else
			v74 = nil;
		end;
		u5.fire = v74;
		local l__reload__75 = v1.tool.Animations:FindFirstChild("reload");
		if l__reload__75 then
			local v76 = v1.viewmodel.Bing:LoadAnimation(l__reload__75);
		else
			v76 = nil;
		end;
		u5.reload = v76;
		local l__reloadempty__77 = v1.tool.Animations:FindFirstChild("reloadempty");
		if l__reloadempty__77 then
			local v78 = v1.viewmodel.Bing:LoadAnimation(l__reloadempty__77);
		else
			v78 = nil;
		end;
		u5.reloadempty = v78;
		local l__holster__79 = v1.tool.Animations:FindFirstChild("holster");
		if l__holster__79 then
			local v80 = v1.viewmodel.Bing:LoadAnimation(l__holster__79);
		else
			v80 = nil;
		end;
		u5.holster = v80;
		local l__equip__81 = v1.tool.Animations:FindFirstChild("equip");
		if l__equip__81 then
			local v82 = v1.viewmodel.Bing:LoadAnimation(l__equip__81);
		else
			v82 = nil;
		end;
		u5.equip = v82;
		local l__unequip__83 = v1.tool.Animations:FindFirstChild("unequip");
		if l__unequip__83 then
			local v84 = v1.viewmodel.Bing:LoadAnimation(l__unequip__83);
		else
			v84 = nil;
		end;
		u5.unequip = v84;
		local l__select__85 = v1.tool.Animations:FindFirstChild("select");
		if l__select__85 then
			local v86 = v1.viewmodel.Bing:LoadAnimation(l__select__85);
		else
			v86 = nil;
		end;
		u5.select = v86;
		local l__live_idle__87 = v1.tool.Animations:FindFirstChild("live_idle");
		if l__live_idle__87 then
			local v88 = l__Humanoid__6:LoadAnimation(l__live_idle__87);
		else
			v88 = nil;
		end;
		u5.live_idle = v88;
		local l__live_aim__89 = v1.tool.Animations:FindFirstChild("live_aim");
		if l__live_aim__89 then
			local v90 = l__Humanoid__6:LoadAnimation(l__live_aim__89);
		else
			v90 = nil;
		end;
		u5.live_aim = v90;
		local l__live_fire__91 = v1.tool.Animations:FindFirstChild("live_fire");
		if l__live_fire__91 then
			local v92 = l__Humanoid__6:LoadAnimation(l__live_fire__91);
		else
			v92 = nil;
		end;
		u5.live_fire = v92;
		playAnim(u5.idle, 0.2, 1, 1);
		playAnim(u5.live_idle, 0.2, 1, 1);
		local v93, v94, v95 = pairs(v1.tool:GetDescendants());
		while true do
			local v96, v97 = v93(v94, v95);
			if not v96 then
				break;
			end;
			if v97:IsA("BasePart") then
				v97.CollisionGroupId = 1;
				v97.Massless = true;
				v97.CastShadow = false;
			end;
			if v97:IsA("Light") and v97.Enabled == true then
				v97.Shadows = false;
				v97.Name = "LightToEnabled";
				v97.Enabled = false;
			end;
			if v97:IsA("ParticleEmitter") and v97.Enabled == true then
				v97.Name = "ParticleToEnabled";
				v97.Enabled = false;
			end;		
		end;
		ammoupdate();
		makeft();
	end;
	v1.update();
end);
v1.char.ChildRemoved:connect(function(p11)
	if p11:IsA("Tool") then
		stopAnim(u5.idle);
		v1.tool = nil;
		v1.sightui = nil;
		u1 = false;
		v1.aiming = false;
		if p11:FindFirstChild("Reloading") then
			p11.Reloading.Value = false;
		end;
		for v98, v99 in pairs(v1.viewmodel:GetChildren()) do
			if v99:IsA("Tool") then
				v99:Destroy();
			end;
		end;
		stopAnim(u5.live_aim, 0);
		stopAnim(u5.live_idle, 0);
		stopAnim(u5.live_fire, 0);
		if v1.char:FindFirstChildOfClass("Tool") == nil then
			for v100, v101 in pairs(v1.viewmodel.Bing:GetPlayingAnimationTracks()) do
				v101:Stop(0);
			end;
		end;
		l__AmmoBar__2.Visible = false;
		pcall(function()
			u10:Disconnect();
		end);
	end;
	v1.update();
end);
script.Parent.Event_Sprinting.Event:Connect(function(p12)
	if v1.tool then
		if v1.tool:GetAttribute("Attachment_Underbarrel") ~= "" then
			p12 = false;
			print("Has underbarrel attachment");
		end;
		if p12 ~= true then
			stopAnim(u5.holster, 0.3, 1, 1);
			return;
		end;
	else
		return;
	end;
	playAnim(u5.holster, 0.3, 1, 1);
	print("play holster");
end);
script.Parent.Event_AutoFire.Event:Connect(function()
	u8 = true;
	u7 = math.clamp(tick(), u6, tick() + 999);
end);
script.Parent.Event_Unequip.Event:Connect(function()
	playAnim(u5.unequip, 0, 1, 1);
	u8 = false;
	u6 = tick() + 0.5;
	u7 = tick() + 0.5;
end);
game["Run Service"].RenderStepped:connect(function(p13)
	if v1.sprinting == true then

	end;
	if v1.tool then
		if v1.holdclick == true then
			if (v1.tool:GetAttribute("Mode") == "Auto" or u8 == true) and u1 == true and u7 ~= nil and v1.tool ~= nil and u7 <= tick() then
				local v102 = math.clamp(-(u7 - tick()), 0, 0.03);
				fire();
				u6 = tick() + u3.Cooldown - v102;
				u8 = false;
				u7 = u6;
				return;
			end;
		elseif u8 == true and u1 == true and u7 ~= nil and v1.tool ~= nil and u7 <= tick() then
			v102 = math.clamp(-(u7 - tick()), 0, 0.03);
			fire();
			u6 = tick() + u3.Cooldown - v102;
			u8 = false;
			u7 = u6;
			return;
		end;
		if u8 == true and u1 == false and u7 ~= nil and v1.tool ~= nil and u7 <= tick() then
			u6 = tick() + 0.5 - math.clamp(-(u7 - tick()), 0, 0.03);
			u7 = u6;
			fire();
		end;
	end;
end);
