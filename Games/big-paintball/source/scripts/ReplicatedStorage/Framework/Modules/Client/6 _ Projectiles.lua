--[[
                                                                        ....= = = .          
                                                    ....= = = = = -----===============          
                                 ....= = = = -----===================================          
            .....= = = = -----======================================================-         
       .-=======================================================================-         
       -=========================================================================         
       -============================================================-= ..    ..= ===         
       = ==================================--= = = ====== .       .-=====     ...     --        
       .=============---=== = = .=====-    -==     ====     .= = .    = ===     -===== = = --=        
        ==....          ==    -====-    = =-    -==     -====== --===.   = ===========.       
        -=         ..= = = ==.   = =====    .=-    = =.   .============.   .======-= = = -.       
        -======.   -=======     ..       .==    .==     ======== -= -==     -====-    ==        
        = =======    .======-              ==    .=-    = =====.   = ===     .= = .    = ==        
        .======-    ======-    --====    ===    .==-.    ...    = ====-= .      .= -==-       
         =======    -======    ======.   -==    ====-= .     .= ===========--========       
         -======.   = ======.   -====== ...-=== = = -===================================.      
         = =======  ..= ======----=====================================================       
         .========================================================================-       
         .=======================================================-----= = = = = ....           
          ===================================----= = = = = = .....       .    .= = ---= .          
          -===============-----= = = ......           .= = = .   --=======.  -==-= = = -=.         
           .= = .....            .= = = .     .====-    ====-   -==..      .==== ..             
                 = -====-=       =====.     ======   -==-==   -=== = = = = .   = -========          
               .==-= ..= =-=     .=== = ==.    -== = ==. === = ==.  = ===-= = = .        ..-==.        
               -==.           = ==. -=-    -=- = ==.==..==.  .==-        = =-= ..= -==         
               -==.  = ----=    -=== = -==-   = ==  -====  ===   .===-----==  .--====-= .         
               -===   ..= ==-  = ==--= = = ==-  = ==. .===-  -==    --= = = = = ...                    
                -==-= = = -===  ===.    = --=   = = .  ...                                       
                 .= ----. = =   ..                                                     
                 
                     
    Aimee's rbx.lua Framework [2022] - [2023]
    Written by Aimee - aimee@alyocord.com
    Developed with keyboards and pixie dust.
	
	-+-+-+- SPECIFICS -+-+-+-
	_L.Projectiles
	===========
	Stores projectile information!
	===========
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------|       Top       |--------
local Projectiles = {}

--------|     Setting     |--------

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------
local Assets = game.ReplicatedStorage:WaitForChild("Assets")
local paintDrop = Assets:WaitForChild("PaintDrop")
local tracerTrail = Assets:WaitForChild("TracerTrail")
local isStudio = _L.RunService:IsStudio()
local Debris = game.Workspace:WaitForChild("__DEBRIS")
local userGameSettings = UserSettings():GetService("UserGameSettings")
--------|    Variables    |--------
local bulletThreshold = 0.005
local gunTick = 0.035
local currentCamera = game.Workspace.CurrentCamera
local v9
local v6
local v7
local v43
local v59
local v66
local v83
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function bulletModel(bullet, p2, p3, p4, p5, p6)
	if bullet.Material == Enum.Material.Neon then

	end;
	bullet.CFrame = CFrame.new(p3);
	bullet.Size = Vector3.new(0.2, 0.2, 0.2);
	bullet.Shape = Enum.PartType.Ball;
	bullet.Transparency = -99999999;
	if p4 and p4.Parent and p4.Anchored == false then
		bullet.Anchored = false;
		_L.Functions.Weld(bullet, p4);
	end;
	if bullet.BrickColor ~= BrickColor.new("Institutional white") then
		v6 = 3701092266;
	else
		v6 = 4537510732;
	end;
	if p2 then
		v7 = 0.1;
	else
		v7 = 0.15;
	end;
	_L.Audio.Play(v6, p3, math.random(85, 115) / 100, v7);
	local v8 = math.random(-15, 15) / 100;
	_L.Functions.FastTween(bullet, {
		Size = Vector3.new(0.5 + v8, 0.5 + v8, 0.5 + v8), 
		CFrame = CFrame.new(p3)
	}, { 0.15, "Back", "Out" });
	if p5 then
		p5(bullet, p3, p4);
	end;
	coroutine.wrap(function()
		wait(6);
		bullet:Destroy();
	end)();
end;
local function u8(p7)
	if p7 and p7.Parent and p7.Parent.Parent and p7.Parent.Parent.Parent and (p7.Parent.Parent == game.Workspace.__THINGS.Sentries or p7.Parent.Parent.Parent == game.Workspace.__THINGS.Sentries) then
		if p7.Parent.Parent == game.Workspace.__THINGS.Sentries then
			if not v9 then
				v9 = false;
				if p7.Parent.Parent.Parent == game.Workspace.__THINGS.Sentries then
					v9 = p7.Parent.Parent;
				end;
			end;
		else
			v9 = false;
			if p7.Parent.Parent.Parent == game.Workspace.__THINGS.Sentries then
				v9 = p7.Parent.Parent;
			end;
		end;
		return v9;
	end;
end;
local function u9(p8)
	if p8 ~= nil and p8.Parent ~= nil and p8.Parent.Parent ~= nil and p8.Parent.Parent.Parent ~= nil and (p8.Parent.Parent == game.Workspace.__THINGS["Mini Sentries"] or p8.Parent.Parent.Parent == game.Workspace.__THINGS["Mini Sentries"]) then
		if p8.Parent.Parent == game.Workspace.__THINGS["Mini Sentries"] then
			local v10 = p8.Parent;
			if not v10 then
				local v10 = p8.Parent;
				v10 = false;
				if p8.Parent.Parent.Parent == game.Workspace.__THINGS["Mini Sentries"] then
					v10 = p8.Parent.Parent;
				end;
			end;
		else
			local v10 = p8.Parent;
			v10 = false;
			if p8.Parent.Parent.Parent == game.Workspace.__THINGS["Mini Sentries"] then
				v10 = p8.Parent.Parent;
			end;
		end;
		local v10 = p8.Parent;
		return v10;
	end;
end;
local function u10(p9)
	if p9 ~= nil and p9.Parent ~= nil and p9.Parent.Parent ~= nil and p9.Parent.Parent.Parent ~= nil and (p9.Parent.Parent == game.Workspace.__THINGS["Dark Matter Sentries"] or p9.Parent.Parent.Parent == game.Workspace.__THINGS["Dark Matter Sentries"]) then
		if p9.Parent.Parent == game.Workspace.__THINGS["Dark Matter Sentries"] then
			local v11 = p9.Parent;
			if not v11 then
				v11 = false;
				if p9.Parent.Parent.Parent == game.Workspace.__THINGS["Dark Matter Sentries"] then
					v11 = p9.Parent.Parent;
				end;
			end;
		else
			local v11 = p9.Parent;
			v11 = false;
			if p9.Parent.Parent.Parent == game.Workspace.__THINGS["Dark Matter Sentries"] then
				v11 = p9.Parent.Parent;
			end;
		end;
		local v11 = p9.Parent;
		return v11;
	end;
end;
local function u11(p10)
	if p10 and p10.Parent and p10.Parent.Parent and p10.Parent.Parent.Parent and (p10.Parent.Parent == game.Workspace.__THINGS.Drones or p10.Parent.Parent.Parent == game.Workspace.__THINGS.Drones) then
		if p10.Parent.Parent == game.Workspace.__THINGS.Drones then
			local v12 = p10.Parent;
			if not v12 then
				v12 = false;
				if p10.Parent.Parent.Parent == game.Workspace.__THINGS.Drones then
					v12 = p10.Parent.Parent;
				end;
			end;
		else
			local v12 = p10.Parent;
			v12 = false;
			if p10.Parent.Parent.Parent == game.Workspace.__THINGS.Drones then
				v12 = p10.Parent.Parent;
			end;
		end;
		local v12 = p10.Parent;
		return v12;
	end;
end;
local u12 = {};
local function u13(p11)
	if p11 ~= nil and p11.Parent ~= nil and p11.Parent.Parent ~= nil and p11.Parent.Parent.Parent ~= nil and (p11.Parent.Parent == game.Workspace.__THINGS["Armored Sentries"] or p11.Parent.Parent.Parent == game.Workspace.__THINGS["Armored Sentries"]) then
		if p11.Parent.Parent == game.Workspace.__THINGS["Armored Sentries"] then
			local v13 = p11.Parent;
			if not v13 then
				v13 = false;
				if p11.Parent.Parent.Parent == game.Workspace.__THINGS["Armored Sentries"] then
					v13 = p11.Parent.Parent;
				end;
			end;
		else
			local v13 = p11.Parent;
			v13 = false;
			if p11.Parent.Parent.Parent == game.Workspace.__THINGS["Armored Sentries"] then
				v13 = p11.Parent.Parent;
			end;
		end;
		local v13 = p11.Parent;
		return v13;
	end;
end;
function Projectiles.Fire(p12, p13, p14, p15, p16, p17, p18)
	local v14 = p12 == game.Players.LocalPlayer;
	if not v14 and math.clamp(100 * userGameSettings.SavedQualityLevel.Value, 250, 1000) <= #Debris.Projectiles:GetChildren() then
		_L.Print("Too many projectiles in world!");
		return;
	end;
	if not (not _L.Variables.Console) or not (not _L.Variables.Mobile) or userGameSettings.SavedQualityLevel.Value <= 1 then
		bulletThreshold = 0.015;
		gunTick = 0.1;
	end;
	local v15, v16 = _L.GunCmds.GetEquipped(p12);
	local l__Position__17 = p13.Position;
	if p16 then
		_L.Signal.Fire("Do Third Person Shoot", p12);
	end;
	local u14 = _L.Entity.Get(p12);
	(function()
		local v18 = tick();
		local v19 = Instance.new("Part");
		v19.Anchored = true;
		v19.CanCollide = false;
		v19.Size = Vector3.new(0.1, 0.1, 4);
		if p12.Team ~= nil and not _L.Shared.isFFA() then
			v19.BrickColor = p12.TeamColor;
		elseif p12 ~= nil and u14 and u14.Color then
			v19.Color = Color3.new(unpack(u14.Color));
		else
			v19.BrickColor = BrickColor.Random();
		end;
		v19.CFrame = p13;
		v19.TopSurface = Enum.SurfaceType.Smooth;
		v19.BottomSurface = Enum.SurfaceType.Smooth;
		v19.Material = Enum.Material.ForceField;
		v19.Transparency = -99999999;
		v19.CastShadow = false;
		--if v16.tracerEffect then
		--	coroutine.wrap(function()
		--		v16.tracerEffect(v19);
		--	end)();
		--end;
		v19.Parent = Debris.Projectiles;
		local v20 = _L.Functions.GenerateUID();
		local v21 = { game.Workspace:WaitForChild("__MAP") };
		for v22, v23 in pairs(game.Players:GetPlayers()) do
			if v23.Character and v23:FindFirstChild("__SPAWNED") and v23 ~= p12 and (v23.Team ~= p12.Team or _L.Shared.isFFA()) then
				for v24, v25 in pairs(v23.Character:GetChildren()) do
					if v25:IsA("BasePart") then
						table.insert(v21, v25);
					end;
				end;
			end;
		end;
		for v26, v27 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Sentries"):GetChildren()) do
			local v28 = game.Players:FindFirstChild(v27.Name);
			if v27.Name ~= p12.Name and v28 and (v28.Team ~= p12.Team or _L.Shared.isFFA()) then
				table.insert(v21, v27);
			end;
		end;
		for v29, v30 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Mini Sentries"):GetChildren()) do
			local v31 = game.Players:FindFirstChild(v30.Name);
			if v30.Name ~= p12.Name and v31 and (v31.Team ~= p12.Team or _L.Shared.isFFA()) then
				table.insert(v21, v30);
			end;
		end;
		for v32, v33 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Armored Sentries"):GetChildren()) do
			local v34 = game.Players:FindFirstChild(v33.Name);
			if v33.Name ~= p12.Name and v34 and (v34.Team ~= p12.Team or _L.Shared.isFFA()) then
				table.insert(v21, v33);
			end;
		end;
		for v35, v36 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Dark Matter Sentries"):GetChildren()) do
			local v37 = game.Players:FindFirstChild(v36.Name);
			if v36.Name ~= p12.Name and v37 and (v37.Team ~= p12.Team or _L.Shared.isFFA()) then
				table.insert(v21, v36);
			end;
		end;
		for v38, v39 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Drones"):GetChildren()) do
			local v40 = game.Players:FindFirstChild(v39.Name);
			if v39.Name ~= p12.Name and v40 and (v40.Team ~= p12.Team or _L.Shared.isFFA()) then
				table.insert(v21, v39);
			end;
		end;
		for v41, v42 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Shields"):GetChildren()) do
			table.insert(v21, v42);
		end;
		if not p16 then
			if p17 and p17 == "DarkMatterSentry" then
				v43 = 400;
			else
				v43 = 175;
			end;
		else
			v43 = 400; --v16.velocity;
		end;
		local v44 = tick();
		local v45 = tick();
		local v46 = nil;
		local v47 = nil;
		if p16 and v14 then
			local l__p__48 = currentCamera.CFrame.p;
			local v49, v50 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(l__p__48, p13.p - l__p__48), v21);
			v46 = v49;
			v47 = v50;
		end;
		if not v46 then
			local v51 = nil;
			local v52 = nil;
			local v53 = nil;
			local v54 = nil;
			v51, v52, v54 = p13:toOrientation();
			v53 = p13.p;
			if not v14 then
				u12[v19] = {
					c = tick(), 
					s = p13, 
					p = p12, 
					u = p14, 
					l = p13, 
					v = v43, 
					rx = v51, 
					ry = v52, 
					lrT = tick(), 
					lrP = v53, 
					wl = v21
				};
				return;
			else
				local u15 = 0;
				local u16 = p13;
				local u17 = 0;
				local u18 = v53;
				local u19 = v21;
				_L.RunService:BindToRenderStep("Update Bullet" .. v20, Enum.RenderPriority.Camera.Value - 1, function()
					if not v14 and tick() - u15 <= 0.004 then
						return;
					end;
					u15 = tick();
					local v55 = tick() - v18;
					local v56 = CFrame.new(p13.p) * CFrame.fromOrientation(0, v52, 0) * CFrame.new(0, v43 * math.sin(v51) * v55 - 23.099999999999994 * v55 ^ 2, -(v43 * math.cos(v51) * v55));
					v19.CFrame = CFrame.new(u16.p, v56.p) * CFrame.new(0, 0, -v19.Size.Z / 2);
					u16 = v56;
					if not v14 and tick() - u17 <= 0.08 then
						return;
					end;
					local v57, v58 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(u18, v56.p - u18), u19);
					u18 = v56.p;
					u17 = tick();
					if not (v55 >= 10) and not v57 and not v46 then
						return;
					end;
					_L.RunService:UnbindFromRenderStep("Update Bullet" .. v20);
					bulletModel(v19, v14, v46 and v47 or v58, v46 and v57, p16 and (v16 and v16.projectileHitEffect));
					if v57 and v57.Parent and v57.Parent.Parent then
						v59 = v57.Parent:FindFirstChildOfClass("Humanoid") or v57.Parent.Parent:FindFirstChildOfClass("Humanoid");
					else
						v59 = nil;
					end;
					local v60 = u8(v57);
					local v61 = u9(v57);
					local v62 = u13(v57);
					local v63 = u10(v57);
					local v64 = u11(v57);
					if v59 then
						local v65 = game.Players:GetPlayerFromCharacter(v59.Parent);
						if p16 then
							if v59.Health > 0 and p12.Character.Humanoid.Health > 0 and v65 ~= p12 and v14 then
								coroutine.wrap(function()
									_L.Network.Fire("Do Damage", v59, p14, v16.velocity, v59.Parent.HumanoidRootPart.Position, not p16, p18, p17);
								end)();
							end;
						elseif v14 then
							coroutine.wrap(function()
								_L.Network.Fire("Do Damage", v59, p14, v16.velocity, v59.Parent.HumanoidRootPart.Position, not p16, p18, p17);
							end)();
						end;
						v19:Destroy();
					elseif v60 then
						if v14 and v60.Name ~= p12.Name and (not v60:FindFirstChild("Health") or not (v60.Health.Value <= 0)) then
							coroutine.wrap(function()
								_L.Network.Fire("Do Sentry Damage", v60, v16.velocity / 25, p14);
							end)();
						end;
						v19:Destroy();
					elseif v61 then
						if v14 and v61.Name ~= p12.Name and (not v61:FindFirstChild("Health") or not (v61.Health.Value <= 0)) then
							coroutine.wrap(function()
								_L.Network.Fire("Do Mini Sentry Damage", v61, v16.velocity / 25, p14);
							end)();
						end;
						v19:Destroy();
					elseif v62 then
						if v14 and v62.Name ~= p12.Name and (not v62:FindFirstChild("Health") or not (v62.Health.Value <= 0)) then
							coroutine.wrap(function()
								_L.Network.Fire("Do Armored Sentry Damage", v62, v16.velocity / 25, p14);
							end)();
						end;
						v19:Destroy();
					elseif v63 then
						if v14 and v63.Name ~= p12.Name and (not v63:FindFirstChild("Health") or not (v63.Health.Value <= 0)) then
							coroutine.wrap(function()
								_L.Network.Fire("Do Dark Matter Sentry Damage", v63, v16.velocity / 25, p14);
							end)();
						end;
						v19:Destroy();
					elseif v64 then
						if v14 and v64.Name ~= p12.Name and (not v64:FindFirstChild("Health") or not (v64.Health.Value <= 0)) then
							coroutine.wrap(function()
								_L.Network.Fire("Do Drone Damage", v64, v16.velocity / 25, p14);
							end)();
						end;
						v19:Destroy();
					end;
					coroutine.wrap(function()
						wait(4);
						v19:Destroy();
						u19 = {};
					end)();
				end);
				return;
			end;
		end;
		bulletModel(v19, v14, v47, v46, p16 and (v16 and v16.projectileHitEffect));
		if v46 and v46.Parent and v46.Parent.Parent then
			v66 = v46.Parent:FindFirstChildOfClass("Humanoid") or v46.Parent.Parent:FindFirstChildOfClass("Humanoid");
		else
			v66 = nil;
		end;
		local v67 = u8(v46);
		local v68 = u9(v46);
		local v69 = u9(v46);
		local v70 = u10(v46);
		local v71 = u11(v46);
		if v66 then
			local v72 = game.Players:GetPlayerFromCharacter(v66.Parent);
			local l__Parent__73 = v66.Parent;
			if p16 then
				if v72 ~= nil and l__Parent__73:FindFirstChild("HumanoidRootPart") and v66.Health > 0 and p12.Character.Humanoid.Health > 0 and v72 ~= p12 and v14 then
					coroutine.wrap(function()
						_L.Network.Fire("Do Damage", v66, p14, v16.velocity, l__Parent__73.HumanoidRootPart.Position, not p16, p18, p17);
					end)();
				end;
			elseif v14 then
				coroutine.wrap(function()
					_L.Network.Fire("Do Damage", v66, p14, v16.velocity, l__Parent__73.HumanoidRootPart.Position, not p16, p18, p17);
				end)();
			end;
			v19:Destroy();
		elseif v67 then
			if v14 and v67.Name ~= p12.Name and (not v67:FindFirstChild("Health") or not (v67.Health.Value <= 0)) then
				coroutine.wrap(function()
					_L.Network.Fire("Do Sentry Damage", v67, v16.velocity / 25, p14);
				end)();
			end;
			v19:Destroy();
		elseif v68 then
			if v14 and v68.Name ~= p12.Name and (not v68:FindFirstChild("Health") or not (v68.Health.Value <= 0)) then
				coroutine.wrap(function()
					_L.Network.Fire("Do Mini Sentry Damage", v68, v16.velocity / 25, p14);
				end)();
			end;
			v19:Destroy();
		elseif v69 then
			if v14 and v69.Name ~= p12.Name and (not v69:FindFirstChild("Health") or not (v69.Health.Value <= 0)) then
				coroutine.wrap(function()
					_L.Network.Fire("Do Armored Sentry Damage", v69, v16.velocity / 25, p14);
				end)();
			end;
			v19:Destroy();
		elseif v70 then
			if v14 and v70.Name ~= p12.Name and (not v70:FindFirstChild("Health") or not (v70.Health.Value <= 0)) then
				coroutine.wrap(function()
					_L.Network.Fire("Do Dark Matter Sentry Damage", v70, v16.velocity / 25, p14);
				end)();
			end;
			v19:Destroy();
		elseif v71 then
			if v14 and v67.Name ~= p12.Name and v68.Name ~= p12.Name and (not v71:FindFirstChild("Health") or not (v71.Health.Value <= 0)) then
				coroutine.wrap(function()
					_L.Network.Fire("Do Drone Damage", v71, v16.velocity / 25, p14);
				end)();
			end;
			v19:Destroy();
		end;
	end)();
end;
local u20 = tick();
_L.RunService:BindToRenderStep("Update Other Bullets", Enum.RenderPriority.Last.Value + 1, function()
	if tick() - u20 <= bulletThreshold then
		return;
	end;
	debug.profilebegin("update other projectiles");
	local v74 = {};
	local v75 = {};
	for v76, v77 in pairs(u12) do
		local l__v__78 = v77.v;
		local v79 = tick() - v77.c;
		local v80 = CFrame.new(v77.s.p) * CFrame.fromOrientation(0, v77.ry, 0) * CFrame.new(0, l__v__78 * math.sin(v77.rx) * v79 - 23.099999999999994 * v79 ^ 2, -(l__v__78 * math.cos(v77.rx) * v79));
		table.insert(v74, v76);
		table.insert(v75, CFrame.new(v77.l.p, v80.p) * CFrame.new(0, 0, -v76.Size.Z / 2));
		v77.l = v80;
		if gunTick <= tick() - v77.lrT then
			local v81, v82 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(v77.lrP, v80.p - v77.lrP), v77.wl);
			v77.lrP = v80.p;
			v77.lrT = tick();
			if v79 >= 5 or v81 then
				bulletModel(v76, false, v82, v81);
				if v81 and v81.Parent and v81.Parent.Parent then
					v83 = v81.Parent:FindFirstChildOfClass("Humanoid") or v81.Parent.Parent:FindFirstChildOfClass("Humanoid");
				else
					v83 = nil;
				end;
				if not (not v83) or not (not u8(v81)) or not (not u9(v81)) or not (not u13(v81)) or not (not u10(v81)) or u11(v81) then
					v76:Destroy();
				end;
				u12[v76] = nil;
				coroutine.wrap(function()
					if not (game.Players.LocalPlayer:DistanceFromCharacter(v82) <= 125) then
						v76:Destroy();
						return;
					end;
					wait(3);
					v76.Transparency = 1;
					wait(0.1);
					v76:Destroy();
				end)();
			end;
		end;
	end;
	game.Workspace:BulkMoveTo(v74, v75);
	debug.profileend();
end);
return Projectiles;
