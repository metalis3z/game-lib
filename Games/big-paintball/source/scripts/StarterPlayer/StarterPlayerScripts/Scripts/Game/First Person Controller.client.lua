-- Decompiled with the Synapse X Luau decompiler.

local v1 = Vector3.new();
local v2 = Instance.new("NumberValue");
v2.Value = 80;
local v3 = Instance.new("NumberValue");
v3.Value = 0;
local v4 = Instance.new("NumberValue");
v4.Value = 0;
local v5 = Instance.new("NumberValue");
v5.Value = 0;
local v6 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v6.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__mouse__7 = game.Players.LocalPlayer:GetMouse();
local v8 = Instance.new("NumberValue");
v8.Value = 1;
local v9 = Instance.new("CFrameValue");
v9.Value = CFrame.new();
local u1 = false;
local u2 = false;
local l__Mobile__3 = v6.GUI.Mobile;
local u4 = v6.Player.Get();
local l__Guns__5 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Guns");
local u6 = 22;
local u7 = v6.Player.Get("Camera");
local l__Scope__8 = v6.GUI.Scope;
local u9 = require(v6.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local l__PlayerOrientationParts__10 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("PlayerOrientationParts");
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = require(v6.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetCameras();
local l__Crosshair__15 = v6.GUI.Crosshair;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
function Equip(p1)
	local v10 = tick();
	if u1 then
		while true do
			v6.Heartbeat();
			if u1 then

			else
				break;
			end;
			if not (5 <= tick() - v10) then

			else
				break;
			end;		
		end;
		if 5 <= tick() - v10 then
			v6.Print("FPC Equip took too long!", true);
			return;
		end;
	end;
	v6.Print(string.format("Starting FPC, Equipped Gun: '%s'", p1));
	u2 = false;
	u1 = true;
	v6.GUI.ToggleCursor(false);
	if v6.Variables.Mobile then
		v6.GUI.Mobile.Gui.Enabled = true;
		l__Mobile__3.ADS.ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0);
	else
		v6.GUI.Mobile.Gui.Enabled = false;
	end;
	local v11 = v6.Directory.Guns[p1];
	if not v11 then
		v6.Print("Could not the directory for that gun!", true);
		return;
	end;
	for v12, v13  in pairs(game.Workspace:WaitForChild("__DEBRIS"):WaitForChild("Guns"):GetChildren()) do

		local v15 = v12
		local v16 = v13

		if v16.Name == u4.Name then
			v16:Destroy();
		end;	
	end;
	local l__idle__17 = v11.offsets.firstPerson.idle;
	local v18 = CFrame.new(0, 0, 0);
	local v19 = CFrame.new(0, 0, 0);
	local v20 = Instance.new("CFrameValue");
	local v21 = Instance.new("CFrameValue");
	v21.Value = CFrame.new(0, 0.35, 0) * CFrame.Angles(0.2617993877991494, 0, 0);
	local v22 = Instance.new("CFrameValue");
	v22.Value = CFrame.new(0, 0, 0);
	local v23 = CFrame.new(0, 0, 0);
	local v24 = l__Guns__5:FindFirstChild(p1):Clone();
	v24:SetPrimaryPartCFrame(v6.Player.Get("Camera").CFrame);
	v24.Name = v6.Player.Get("Name");
	v24.Parent = game.Workspace.__DEBRIS.Guns;
	v6.CollectionService:AddTag(v24.PrimaryPart, "AntiHide");
	for v25, v26 in pairs(v24:GetDescendants()) do

		local v28 = v25
		local v29 = v26

		if v29.Name == "highlights" then
			v6.GUIFX.Rainbow(v29, "Color", 0.1);
		end;	
	end;
	if v11.gunEffect then
		v11.gunEffect(v24);
	end;
	local l__Right__30 = v24.PrimaryPart:WaitForChild("Right");
	local l__Left__31 = v24.PrimaryPart:WaitForChild("Left");
	local l__Barrel__32 = v24.PrimaryPart:WaitForChild("Barrel");
	local l__Barrel2__33 = v24.PrimaryPart:FindFirstChild("Barrel2");
	v6.Functions.FastTween(v21, {
		Value = CFrame.new()
	}, { 0.5, "Back", "Out" });
	v6.Audio.Play(v11.deploySound and v11.deploySound or 4102527950, script);
	local u20 = v6.Player.Get("Character");
	local u21 = v6.Player.Get("HumanoidRootPart");
	local u22 = tick();
	local u23 = tick();
	local function u24()
		local v34 = RaycastParams.new();
		v34.FilterType = Enum.RaycastFilterType.Whitelist;
		v34.FilterDescendantsInstances = { game.Workspace:WaitForChild("__MAP") };
		local v35 = u20:GetModelSize();
		local v36 = false;
		local v37 = -1.5;
		while true do
			local v38 = -1;
			while true do
				if game.Workspace:Raycast(u21.Position, CFrame.new(u21.Position + Vector3.new(v37, 0, v38), u21.Position + Vector3.new(v37, -50, v38)).LookVector * (v35.Y / 2 + 0.1), v34) then
					v36 = true;
				end;
				if v38 < 0.5 then

				else
					break;
				end;
				v38 = v38 + 0.5;			
			end;
			if v37 < 1 then

			else
				break;
			end;
			v37 = v37 + 0.5;		
		end;
		if v36 then
			return true;
		end;
		return false;
	end;
	local u25 = tick();
	local function u26()
		if not u2 then
			return;
		end;
		if 0.25 < tick() - u22 then
			return;
		end;
		if tick() - u23 < 1 then
			return;
		end;
		if not u24() then
			return;
		end;
		u23 = tick();
		u21.Velocity = u21.CFrame.LookVector * 100;
	end;
	local l__p__39 = u7.CFrame.p;
	local u27 = false;
	local u28 = false;
	local u29 = false;
	local u30 = {};
	local u31 = true;
	local u32 = l__idle__17;
	local u33 = v19;
	local u34 = v18;
	local u35 = v23;
	local function u36()
		u27 = true;
		u28 = false;
		if u29 then
			return;
		end;
		u29 = true;
		v6.RunService:UnbindFromRenderStep("UpdateGun");
		v6.Print(string.format("Cleaning up %s connections", tostring(#u30)));
		v6.ContextActionService:UnbindAction("Sprint");
		for v40, v41 in pairs(u30) do

			local v43 = v40
			local v44 = v41


			if v44 then
				if v44.Disconnect then
					v44:Disconnect();
					u30[v43] = nil;
				end;
			end;		
		end;
		if #u30 == 0 then
			v6.Print("Successfully cleaned connections!");
		else
			v6.Print("Failed to clean connections!", true);
		end;
		if v24 then
			v24:Destroy();
		end;
		v3.Value = 0;
		v4.Value = 0;
		v5.Value = 0;
		v2.Value = 80;
		u7.FieldOfView = 80;
		u1 = false;
		l__Scope__8.Gui.Enabled = false;
	end;
	local l__sprint__37 = v11.offsets.firstPerson.sprint;
	local l__left__38 = v11.offsets.firstPerson.left;
	local l__right__39 = v11.offsets.firstPerson.right;
	local u40 = 0;
	local u41 = tick();
	local l__animatedTexture__42 = v11.animatedTexture;
	v6.RunService:BindToRenderStep("UpdateGun", Enum.RenderPriority.Camera.Value, function(p2)
		local v45 = not v6.Variables.Console and u9:GetMoveVector() or v6.Variables.ControllerMoveVector;
		local v46 = v6.UserInputService:GetMouseDelta();
		if v6.Variables.HideGun then
			if u31 then
				u31 = false;
				v6.Functions.FastTween(v22, {
					Value = CFrame.new(0.15, -3.5, 2.5) * CFrame.Angles(0.4363323129985824, 0, 0)
				}, { 0.2, "Quad", "Out" });
			end;
		elseif not u31 then
			u31 = true;
			v6.Functions.FastTween(v22, {
				Value = CFrame.new(0, 0, 0)
			}, { 0.15, "Sine", "Out" });
		end;
		v24:SetPrimaryPartCFrame(v6.Player.Get("Camera").CFrame * u32 * v21.Value * u33 * u34 * v20.Value * v9.Value * v22.Value * u35);
		u34 = u34:Lerp(CFrame.new(math.clamp(v46.X / 100, -0.25, 0.25), 0, 0), 10 * p2);
		if v6.Player.Get("Humanoid").Health <= 0 then
			u36();
			return;
		end;
		if l__PlayerOrientationParts__10:FindFirstChild(u4.Name) then
			local v47, v48, v49 = u7.CFrame:ToOrientation();
			game.Workspace.__THINGS.PlayerOrientationParts:FindFirstChild(u4.Name).CFrame = CFrame.Angles(v47, 0, 0);
		end;
		if u2 then
			u32 = u32:Lerp(l__sprint__37, 10 * p2);
		elseif v45.X < -0.5 then
			u32 = u32:Lerp(l__left__38, 10 * p2);
		elseif 0.5 < v45.X then
			u32 = u32:Lerp(l__right__39, 10 * p2);
		else
			u32 = u32:Lerp(l__idle__17, 10 * p2);
		end;
		u7.FieldOfView = v2.Value + v3.Value + v4.Value + v5.Value;
		if 0.1 < v45.Magnitude then
			u33 = CFrame.new(math.cos(u40 * 10) / 35 / v8.Value, math.cos(u40 * 20) / 35 / v8.Value, 0);
			u40 = u40 + p2;
		else
			u33 = u33:Lerp(CFrame.new(0, 0, 0), 25 * p2);
		end;
		if 0.25 <= tick() - u41 then
			u41 = tick();
			for v50, v51 in pairs(game.Players:GetPlayers()) do

				local v53 = v50
				local v54 = v51

				if v54 ~= u4 then
					if v54 then
						if v54.Character then
							if v54.Character:FindFirstChild("HumanoidRootPart") then
								if v54.Character:FindFirstChild("Head") then
									if not (5 <= v54.Character.HumanoidRootPart.Size.Magnitude) then
										if not (25 <= v54.Character.Head.Size.Magnitude) then
											if v54.Character:FindFirstChild("Hitbox") then
												if 25 <= v54.Character.Hitbox.Size.Magnitude then
													u36();
												end;
											end;
										else
											u36();
										end;
									else
										u36();
									end;
								end;
							end;
						end;
					end;
				end;			
			end;
		end;
		if l__animatedTexture__42 then
			if v24:FindFirstChild("effect") then
				local v55 = math.max(tick() - v10, 0.001);
				local v56 = math.clamp(math.sin(v55 / 2), 0, 1);
				local v57 = math.clamp(math.sin(v55 / 3), 0, 1);
				for v58, v59 in pairs(v24:GetChildren()) do

					local v61 = v58
					local v62 = v59
					if v62.Name == "effect" then
						for v63, v64 in  pairs(v62:GetChildren()) do


							if v64.ClassName == "Texture" then
								if v64.Name == "1" then
									v64.OffsetStudsU = v55 / 3.25;
									v64.OffsetStudsV = -(v55 / -3.5);
									v64.Transparency = 0.2 + v56 * 0.1;
								elseif v64.Name == "2" then
									v64.OffsetStudsU = -(v55 / 1.35);
									v64.OffsetStudsV = v55 / 2.5;
									v64.Transparency = 0.35 + v56 * -0.2;
								elseif v64.Name == "3" then
									v64.OffsetStudsU = -(v55 / 3);
									v64.OffsetStudsV = v55 / 5;
									v64.Transparency = 0.9;
								end;
							end;						
						end;
						if v6.Variables.Killstreak then
							v62.Color = Color3.fromRGB(182, 34, 255):Lerp(Color3.fromRGB(243, 156, 18), math.clamp(v6.Variables.Killstreak / 10, 0, 1));
						end;
					end;				
				end;
			end;
		end;
	end);
	local function u43(p3)
		if v6.Player.Get("Humanoid").Health <= 0 then
			return;
		end;
		v6.Network.Fire("Change Sprint State", p3);
		if p3 then

		else
			v6.Functions.FastTween(v3, {
				Value = 0
			}, { 0.1, "Quad", "Out" });
			v6.Functions.FastTween(v8, {
				Value = 3
			}, { 0.1, "Quad", "Out" });
			u25 = tick();
			u2 = false;
			v6.Signal.Fire("Change Max Walkspeed", 17 + (v11.additionalSpeed and 0));
			return;
		end;
		v6.Functions.FastTween(v3, {
			Value = 10
		}, { 0.1, "Quad", "Out" });
		v6.Functions.FastTween(v8, {
			Value = 1.25
		}, { 0.2, "Quad", "Out" });
		u2 = true;
		u26();
		u22 = tick();
		v6.Signal.Fire("Change Max Walkspeed", u6 + (v11.additionalSpeed and 0));
	end;
	local u44 = 0;
	local u45 = false;
	local l__fire__46 = v11.offsets.firstPerson.fire;
	local u47 = {};
	local u48 = false;
	local function u49(p4, p5)
		if not (v6.Player.Get("Humanoid").Health <= 0) then

		else
			return;
		end;
		if not v6.Variables.HideGun then

		else
			return;
		end;
		if u27 then
			return;
		end;
		if v24 then

		else
			return;
		end;
		if v24.Parent ~= game.Workspace.__DEBRIS.Guns then
			return;
		end;
		local v66 = v6.Shared.getRoundType();
		if v66 ~= "Intermission" then

		else
			return;
		end;
		if v66 == "Voting" then
			return;
		end;
		if u29 then
			return;
		end;
		if u2 then
			u43(false);
			v6.Heartbeat(5);
		end;
		v6.GUI.ToggleCursor(false);
		if not p4 then
			if v11.shotrate < 0.35 then
				if tick() - u44 < v11.shotrate then
					if not u45 then
						u45 = true;
						local v67 = v11.shotrate - (tick() - u44);
						local v68 = tick();
						while true do
							if tick() - v68 < v67 then

							else
								break;
							end;
							v6.RenderStepped();						
						end;
					elseif u45 then
						return;
					end;
				elseif u45 then
					return;
				end;
			elseif not p4 then
				if 0.35 <= v11.shotrate then
					if tick() - u44 < v11.shotrate then
						return;
					end;
				end;
			end;
		end;
		u44 = tick();
		u45 = false;
		if v11.shootSound then
			u11 = 0.55;
		else
			u11 = 0.5;
		end;
		v6.Audio.Play(v11.shootSound and v11.shootSound or 3545263252, script, math.random(95, 105) / 100, u11, 150);
		if v11.shootEffect then
			v11.shootEffect(v24);
		end;
		local v69 = v6.Functions.FastTween(v20, {
			Value = l__fire__46
		}, { 0.05, "Linear", "Out" });
		local u50 = nil;
		u50 = v69.Completed:Connect(function(p6)
			v6.Functions.FastTween(v20, {
				Value = CFrame.new(0, 0, 0)
			}, { 0.15, "Quad", "Out" });
			if u50 then
				u50:Disconnect();
			end;
			for v70, v71 in pairs(u47) do

				local v73 = v70
				local v74 = v71
				if v74 == v69 then
					table.remove(u47, v73);
				end;			
			end;
		end);
		local u51 = v6.Player.Get("Camera").CFrame * u32 * (p5 and l__Barrel2__33 or l__Barrel__32).CFrame;
		coroutine.wrap(function()
			local v75 = v6.Functions.GenerateUID();
			local v76 = u7:ScreenPointToRay(u7.ViewportSize.X / 2, u7.ViewportSize.Y / 2 - 36, 0);
			local v77, v78 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(v76.Origin, v76.Direction * 2500), { game.Workspace:WaitForChild("__MAP") });
			v6.Projectiles.Fire(v6.Player.Get("Player"), CFrame.new(u51.p, v78), v75, math.floor(game.Workspace.DistributedGameTime), true);
			v6.Network.Fire("Projectile", u51, v75, math.floor(game.Workspace.DistributedGameTime));
		end)();
	end;
	local u52 = 1;
	table.insert(u30, v6.UserInputService.InputBegan:Connect(function(p7, p8)
		if p8 then
			return;
		end;
		if v6.Variables.HideGun then
			return;
		end;
		if p7.UserInputType ~= Enum.UserInputType.MouseButton1 then
			if p7.KeyCode == Enum.KeyCode.ButtonR2 then
				if u48 then
					return;
				end;
				u28 = true;
				if v11.burst then
					u48 = true;
					u12 = v11.burstAmount;
					local v79 = 1 - 1;
					while true do
						u13 = v79;
						if v11.doubleShot then
							u49(true);
							if v11.doubleShotDelay then
								v6.Functions.Wait(v11.doubleShotDelay);
							end;
							u49(true, true);
						else
							u49(true);
						end;
						v6.Functions.Wait(v11.shotrate);
						if 0 <= 1 then
							if v79 < u12 then

							else
								break;
							end;
						elseif u12 < v79 then

						else
							break;
						end;
						v79 = v79 + 1;					
					end;
					v6.Functions.Wait(v11.shotrate);
					if v11.burstDelay then
						v6.Functions.Wait(v11.burstDelay);
					end;
					u48 = false;
				elseif v11.automatic then
					u48 = true;
					while true do
						if v11.doubleShot then
							if u52 == 1 then
								u49(true);
								u52 = 2;
							else
								u49(true, true);
								u52 = 1;
							end;
						else
							u49(true);
						end;
						v6.Functions.Wait(v11.shotrate);
						if u28 then

						else
							break;
						end;
						if not u2 then

						else
							break;
						end;					
					end;
					u48 = false;
				else
					u48 = true;
					if v11.doubleShot then
						if u52 == 1 then
							u49(false);
							u52 = 2;
						else
							u49(false, true);
							u52 = 1;
						end;
					else
						u49();
					end;
					u48 = false;
				end;
			end;
		else
			if u48 then
				return;
			end;
			u28 = true;
			if v11.burst then
				u48 = true;
				u12 = v11.burstAmount;
				local v80 = 1 - 1;
				while true do
					u13 = v80;
					if v11.doubleShot then
						u49(true);
						if v11.doubleShotDelay then
							v6.Functions.Wait(v11.doubleShotDelay);
						end;
						u49(true, true);
					else
						u49(true);
					end;
					v6.Functions.Wait(v11.shotrate);
					if 0 <= 1 then
						if v80 < u12 then

						else
							break;
						end;
					elseif u12 < v80 then

					else
						break;
					end;
					v80 = v80 + 1;				
				end;
				v6.Functions.Wait(v11.shotrate);
				if v11.burstDelay then
					v6.Functions.Wait(v11.burstDelay);
				end;
				u48 = false;
			elseif v11.automatic then
				u48 = true;
				while true do
					if v11.doubleShot then
						if u52 == 1 then
							u49(true);
							u52 = 2;
						else
							u49(true, true);
							u52 = 1;
						end;
					else
						u49(true);
					end;
					v6.Functions.Wait(v11.shotrate);
					if u28 then

					else
						break;
					end;
					if not u2 then

					else
						break;
					end;				
				end;
				u48 = false;
			else
				u48 = true;
				if v11.doubleShot then
					if u52 == 1 then
						u49(false);
						u52 = 2;
					else
						u49(false, true);
						u52 = 1;
					end;
				else
					u49();
				end;
				u48 = false;
			end;
		end;
		if p7.UserInputType ~= Enum.UserInputType.MouseButton2 then
			if p7.KeyCode ~= Enum.KeyCode.Q then
				if p7.KeyCode == Enum.KeyCode.ButtonL2 then
					if 0 < v6.Player.Get("Humanoid").Health then
						v6.Functions.FastTween(v2, {
							Value = 55 / v11.zoomAmount
						}, { 0.1, "Quad", "Out" });
						v6.UserInputService.MouseDeltaSensitivity = 0.65 / v11.zoomAmount;
						if v6.Variables.Console then
							if u14.activeCameraController then
								u14.activeCameraController.maxSpeed = 6 / (v11.zoomAmount * 2);
							end;
						end;
						if 2 <= v11.zoomAmount then
							v6.Audio.Play(5732455840, script, 1, 0.5);
							u35 = CFrame.new(0, 100, 0);
							l__Crosshair__15.Gui.Enabled = false;
							l__Scope__8.Gui.Enabled = true;
							l__Scope__8.Frame.blur.ImageTransparency = 0.65;
							l__Scope__8.Frame.Size = UDim2.new(1, 150, 1, 150);
							v6.Functions.FastTween(l__Scope__8.Frame, {
								Size = UDim2.new(0.5, 150, 0.5, 150)
							}, { 0.13, "Sine", "Out" });
							v6.Functions.FastTween(l__Scope__8.Frame.blur, {
								ImageTransparency = 1
							}, { 1, "Quad", "InOut" });
							for v81, v82 in pairs(v6.Variables.ScopeUIToHide) do

								local v84 = v81
								local v85 = v82

								u16 = v6.GUI[v85];
								if u16 then
									v6.Variables.ScopeUICache[v85] = u16.Gui.Enabled;
									u16.Gui.Enabled = false;
								end;							
							end;
							return;
						else
							return;
						end;
					else
						return;
					end;
				else
					return;
				end;
			elseif 0 < v6.Player.Get("Humanoid").Health then
				v6.Functions.FastTween(v2, {
					Value = 55 / v11.zoomAmount
				}, { 0.1, "Quad", "Out" });
				v6.UserInputService.MouseDeltaSensitivity = 0.65 / v11.zoomAmount;
				if v6.Variables.Console then
					if u14.activeCameraController then
						u14.activeCameraController.maxSpeed = 6 / (v11.zoomAmount * 2);
					end;
				end;
				if 2 <= v11.zoomAmount then
					v6.Audio.Play(5732455840, script, 1, 0.5);
					u35 = CFrame.new(0, 100, 0);
					l__Crosshair__15.Gui.Enabled = false;
					l__Scope__8.Gui.Enabled = true;
					l__Scope__8.Frame.blur.ImageTransparency = 0.65;
					l__Scope__8.Frame.Size = UDim2.new(1, 150, 1, 150);
					v6.Functions.FastTween(l__Scope__8.Frame, {
						Size = UDim2.new(0.5, 150, 0.5, 150)
					}, { 0.13, "Sine", "Out" });
					v6.Functions.FastTween(l__Scope__8.Frame.blur, {
						ImageTransparency = 1
					}, { 1, "Quad", "InOut" });
					for v86, v87 in pairs(v6.Variables.ScopeUIToHide) do

						local v89 = v86
						local v90 = v87

						u16 = v6.GUI[v90];
						if u16 then
							v6.Variables.ScopeUICache[v90] = u16.Gui.Enabled;
							u16.Gui.Enabled = false;
						end;					
					end;
					return;
				else
					return;
				end;
			else
				return;
			end;
		elseif 0 < v6.Player.Get("Humanoid").Health then
			v6.Functions.FastTween(v2, {
				Value = 55 / v11.zoomAmount
			}, { 0.1, "Quad", "Out" });
			v6.UserInputService.MouseDeltaSensitivity = 0.65 / v11.zoomAmount;
			if v6.Variables.Console then
				if u14.activeCameraController then
					u14.activeCameraController.maxSpeed = 6 / (v11.zoomAmount * 2);
				end;
			end;
			if 2 <= v11.zoomAmount then
				v6.Audio.Play(5732455840, script, 1, 0.5);
				u35 = CFrame.new(0, 100, 0);
				l__Crosshair__15.Gui.Enabled = false;
				l__Scope__8.Gui.Enabled = true;
				l__Scope__8.Frame.blur.ImageTransparency = 0.65;
				l__Scope__8.Frame.Size = UDim2.new(1, 150, 1, 150);
				v6.Functions.FastTween(l__Scope__8.Frame, {
					Size = UDim2.new(0.5, 150, 0.5, 150)
				}, { 0.13, "Sine", "Out" });
				v6.Functions.FastTween(l__Scope__8.Frame.blur, {
					ImageTransparency = 1
				}, { 1, "Quad", "InOut" });
				for v91, v92 in pairs(v6.Variables.ScopeUIToHide) do
					local v94 = v91
					local v95 = v92
					u16 = v6.GUI[v95];
					if u16 then
						v6.Variables.ScopeUICache[v95] = u16.Gui.Enabled;
						u16.Gui.Enabled = false;
					end;				
				end;
			else
				return;
			end;
		end;
	end));
	table.insert(u30, v6.UserInputService.InputEnded:Connect(function(p9, p10)
		if p10 then
			return;
		end;
		if p9.UserInputType ~= Enum.UserInputType.MouseButton1 then
			if p9.KeyCode == Enum.KeyCode.ButtonR2 then
				u28 = false;
			end;
		else
			u28 = false;
		end;
		if p9.UserInputType ~= Enum.UserInputType.MouseButton2 then
			if p9.KeyCode ~= Enum.KeyCode.Q then
				if p9.KeyCode == Enum.KeyCode.ButtonL2 then
					v6.Functions.FastTween(v2, {
						Value = 80
					}, { 0.15, "Linear", "Out" });
					v6.UserInputService.MouseDeltaSensitivity = 1;
					if v6.Variables.Console then
						if u14.activeCameraController then
							u14.activeCameraController.maxSpeed = 6;
						end;
					end;
					if 2 <= v11.zoomAmount then
						v6.Audio.Play(5732456046, script, 1, 0.5);
						u35 = CFrame.new(0, 0, 0);
						l__Crosshair__15.Gui.Enabled = true;
						l__Scope__8.Gui.Enabled = false;
						for v96, v97 in pairs(v6.Variables.ScopeUIToHide) do

							local v99 = v96
							local v100 = v97

							u17 = v6.GUI[v100];
							if u17 then
								if v6.Variables.ScopeUICache[v100] then
									u17.Gui.Enabled = v6.Variables.ScopeUICache[v100];
								end;
							end;						
						end;
						return;
					else
						return;
					end;
				else
					return;
				end;
			else
				v6.Functions.FastTween(v2, {
					Value = 80
				}, { 0.15, "Linear", "Out" });
				v6.UserInputService.MouseDeltaSensitivity = 1;
				if v6.Variables.Console then
					if u14.activeCameraController then
						u14.activeCameraController.maxSpeed = 6;
					end;
				end;
				if 2 <= v11.zoomAmount then
					v6.Audio.Play(5732456046, script, 1, 0.5);
					u35 = CFrame.new(0, 0, 0);
					l__Crosshair__15.Gui.Enabled = true;
					l__Scope__8.Gui.Enabled = false;
					for v101, v102 in pairs(v6.Variables.ScopeUIToHide) do

						local v104 = v101
						local v105 = v102

						u17 = v6.GUI[v105];
						if u17 then
							if v6.Variables.ScopeUICache[v105] then
								u17.Gui.Enabled = v6.Variables.ScopeUICache[v105];
							end;
						end;					
					end;
					return;
				else
					return;
				end;
			end;
		else
			v6.Functions.FastTween(v2, {
				Value = 80
			}, { 0.15, "Linear", "Out" });
			v6.UserInputService.MouseDeltaSensitivity = 1;
			if v6.Variables.Console then
				if u14.activeCameraController then
					u14.activeCameraController.maxSpeed = 6;
				end;
			end;
			if 2 <= v11.zoomAmount then
				v6.Audio.Play(5732456046, script, 1, 0.5);
				u35 = CFrame.new(0, 0, 0);
				l__Crosshair__15.Gui.Enabled = true;
				l__Scope__8.Gui.Enabled = false;
				for v106, v107 in pairs(v6.Variables.ScopeUIToHide) do

					local v109 = v106
					local v110 = v107

					u17 = v6.GUI[v110];
					if u17 then
						if v6.Variables.ScopeUICache[v110] then
							u17.Gui.Enabled = v6.Variables.ScopeUICache[v110];
						end;
					end;				
				end;
			end;
		end;
	end));
	local u53 = false;
	table.insert(u30, l__Mobile__3.Shoot.MouseButton1Down:Connect(function()
		local v111 = tick();
		if u48 then
			return;
		end;
		if u29 then
			return;
		end;
		u53 = true;
		if u48 then
			return;
		end;
		if v11.burst then
			u48 = true;
			local l__burstAmount__112 = v11.burstAmount;
			local v113 = 1 - 1;
			while true do
				if v11.doubleShot then
					u49(true);
					if v11.doubleShotDelay then
						v6.Functions.Wait(v11.doubleShotDelay);
					end;
					u49(true, true);
				else
					u49(true);
				end;
				v6.Functions.Wait(v11.shotrate);
				if 0 <= 1 then
					if v113 < l__burstAmount__112 then

					else
						break;
					end;
				elseif l__burstAmount__112 < v113 then

				else
					break;
				end;
				v113 = v113 + 1;			
			end;
			v6.Functions.Wait(v11.shotrate);
			if v11.burstDelay then
				v6.Functions.Wait(v11.burstDelay);
			end;
			u48 = false;
			return;
		end;
		if v11.automatic then

		else
			u48 = true;
			if u53 then
				while true do
					if v11.doubleShot then
						if u52 == 1 then
							u49(true);
							u52 = 2;
						else
							u49(true, true);
							u52 = 1;
						end;
					else
						u49(true);
					end;
					v6.Functions.Wait(v11.shotrate * 1.5);
					if u53 then

					else
						break;
					end;
					if not u2 then

					else
						break;
					end;				
				end;
			end;
			u48 = false;
			return;
		end;
		u48 = true;
		if u53 then
			while true do
				if v11.doubleShot then
					if u52 == 1 then
						u49(true);
						u52 = 2;
					else
						u49(true, true);
						u52 = 1;
					end;
				else
					u49(true);
				end;
				v6.Functions.Wait(v11.shotrate);
				if u53 then

				else
					break;
				end;
				if not u2 then

				else
					break;
				end;
				if not u29 then

				else
					break;
				end;			
			end;
		end;
		u48 = false;
	end));
	table.insert(u30, l__Mobile__3.Shoot.MouseButton1Up:Connect(function()
		u53 = false;
	end));
	table.insert(u30, l__Mobile__3.Shoot.MouseLeave:Connect(function()
		u53 = false;
	end));
	local u54 = false;
	table.insert(u30, l__Mobile__3.ADS.MouseButton1Down:Connect(function()
		u54 = not u54;
		if u54 then
			v6.Functions.FastTween(v2, {
				Value = 55 / v11.zoomAmount
			}, { 0.1, "Quad", "Out" });
			if v6.Variables.Console then
				u18 = 0.35;
			else
				u18 = 0.65;
			end;
			v6.UserInputService.MouseDeltaSensitivity = u18 / v11.zoomAmount;
			l__Mobile__3.ADS.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0);
			if 2 <= v11.zoomAmount then
				v6.Audio.Play(5732455840, script, 1, 0.5);
				u35 = CFrame.new(0, 100, 0);
				l__Crosshair__15.Gui.Enabled = false;
				l__Scope__8.Gui.Enabled = true;
				l__Scope__8.Frame.blur.ImageTransparency = 0.65;
				l__Scope__8.Frame.Size = UDim2.new(1, 150, 1, 150);
				v6.Functions.FastTween(l__Scope__8.Frame, {
					Size = UDim2.new(0.5, 150, 0.5, 150)
				}, { 0.13, "Sine", "Out" });
				v6.Functions.FastTween(l__Scope__8.Frame.blur, {
					ImageTransparency = 1
				}, { 1, "Quad", "InOut" });
				for v114, v115 in pairs(v6.Variables.ScopeUIToHide) do

					local v117 = v114
					local v118 = v115

					local v119 = v6.GUI[v118];
					if v119 then
						v6.Variables.ScopeUICache[v118] = v119.Gui.Enabled;
						v119.Gui.Enabled = false;
					end;				
				end;
				return;
			end;
		else
			v6.Functions.FastTween(v2, {
				Value = 80
			}, { 0.15, "Linear", "Out" });
			if v6.Variables.Console then
				u19 = 0.5;
			else
				u19 = 1;
			end;
			v6.UserInputService.MouseDeltaSensitivity = u19;
			l__Mobile__3.ADS.ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0);
			if 2 <= v11.zoomAmount then
				v6.Audio.Play(5732456046, script, 1, 0.5);
				u35 = CFrame.new(0, 0, 0);
				l__Crosshair__15.Gui.Enabled = true;
				l__Scope__8.Gui.Enabled = false;
				for v120, v121 in pairs(v6.Variables.ScopeUIToHide) do

					local v123 = v120
					local v124 = v121

					local v125 = v6.GUI[v124];
					if v125 then
						if v6.Variables.ScopeUICache[v124] then
							v125.Gui.Enabled = v6.Variables.ScopeUICache[v124];
						end;
					end;				
				end;
			end;
		end;
	end));
	local u55 = false;
	v6.ContextActionService:BindAction("Sprint", function(p11, p12, p13)
		if p13.KeyCode == Enum.KeyCode.ButtonL3 then
			if p12 == Enum.UserInputState.Begin then
				u43(not u2);
			end;
			return;
		end;
		if p12 == Enum.UserInputState.Begin then
			u43(true);
			u55 = true;
			return;
		end;
		if p12 == Enum.UserInputState.End then
			u43(false);
			u55 = false;
		end;
	end, false, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonL3);
	local u56 = tick();
	v6.ContextActionService:BindAction("Dash", function(p14, p15, p16)
		if p15 == Enum.UserInputState.Begin then
			if 0.5 < tick() - u56 then
				u56 = tick();
				u26();
			end;
		end;
	end, false, Enum.KeyCode.LeftControl);
	table.insert(u30, u4.CharacterRemoving:Connect(function()
		u36();
	end));
	table.insert(u30, u4.CharacterAdded:Connect(function()
		u36();
	end));
	table.insert(u30, v6.Player.Get("Humanoid").Died:Connect(function()
		u36();
	end));
	table.insert(u30, v6.Signal.Fired("Stop Sprinting"):Connect(function()
		if not v6.Variables.Mobile then
			u43(false);
		end;
	end));
	v6.Signal.Fire("Gun Equipped", u4, p1);
	if u4.Name ~= "Player1" then
		if u4.Name == "Player2" then
			u6 = 75;
		end;
	else
		u6 = 75;
	end;
	if v6.Variables.Mobile then
		v6.Signal.Fire("Change Max Walkspeed", u6 + (v11.additionalSpeed and 0));
	else
		v6.Signal.Fire("Change Max Walkspeed", 17 + (v11.additionalSpeed and 0));
	end;
	v6.Functions.FastTween(v2, {
		Value = 80
	}, { 0.05, "Linear", "Out" });
	v6.UserInputService.MouseDeltaSensitivity = 1;
	if v6.Variables.Console then
		v6.UserInputService.MouseIconEnabled = false;
	end;
end;

v6.Signal.Fired("Change Boost FOV"):Connect(function(p17, p18)
	if p17 then
		v6.Functions.FastTween(v4, {
			Value = p18
		}, { 0.30000000000000004, "Quad", "Out" });
		return;
	end;
	v6.Functions.FastTween(v4, {
		Value = 0
	}, { 0.6000000000000001, "Quad", "Out" });
end);
v6.Signal.Fired("Change Hop Boost FOV"):Connect(function(p19, p20)
	if p19 then
		v6.Functions.FastTween(v5, {
			Value = p20
		}, { 0.30000000000000004, "Quad", "Out" });
		return;
	end;
	v6.Functions.FastTween(v5, {
		Value = 0
	}, { 0.6000000000000001, "Quad", "Out" });
end);
v6.Signal.Fired("Bhop Gun Animation"):Connect(function(p21)
	p21 = p21 and 0.25;
	local v126 = 0.1 + p21 / 50;
	v6.Functions.FastTween(v9, {
		Value = CFrame.new(0, -p21, 0)
	}, { v126, "Quad", "Out" });
	v6.Functions.Wait(v126);
	v6.Functions.FastTween(v9, {
		Value = CFrame.new(0, 0, 0)
	}, { 1, "Quad", "Out" });
end);
function DoesOwnGun(p22)
	local v127 = v6.Save.Get();
	if v127 then

	else
		v6.Print("Failed to get stats", true);
		return;
	end;
	if not v127.Guns then
		v6.Print("Failed to get stats", true);
		return;
	end;
	for v128, v129 in pairs(v127.Guns) do

		local v131 = v128
		local v132 = v129

		if v132.n == p22 then
			return true;
		end;	
	end;
	return false;
end;
local u57 = false;
v6.Signal.Fired("Equip Gun"):Connect(function(p23)
	if u57 then
		return;
	end;
	if not DoesOwnGun(p23) then
		p23 = "1";
	end;
	u57 = true;
	Equip(p23);
	v6.Functions.Wait(1);
	u57 = false;
end);
