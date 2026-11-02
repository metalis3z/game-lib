
	local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
	local l_Lighting_0 = game:GetService("Lighting");
	local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
	local v3 = {};
	local v4 = require(l_ReplicatedStorage_0.Controllers.EffectController);
	local v5 = require(l_ReplicatedStorage_0.Controllers.SoundController);
	local v6 = require(l_ReplicatedStorage_0.Controllers.EventController);
	local v7 = require(l_ReplicatedStorage_0.Controllers.CycleController);
	local v8 = require(l_ReplicatedStorage_0.Packages.Observers);
	local v9 = require(l_ReplicatedStorage_0.Datas.ServerData);
	local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
	local v11 = require(l_ReplicatedStorage_0.Packages.Net);
	local v12 = require(l_ReplicatedStorage_0.Packages.CreateTween);
	local v13 = require(l_ReplicatedStorage_0.Shared.VFX);
	local v14 = Color3.fromRGB(70, 210, 255);
	local l_Name_0 = script.Name;
	local v16 = v10.new();
	local v17 = nil;
	v3.OnStart = function(_)
	    assert((v6:GetActiveEventData(l_Name_0)));
	    v4:Activate("Blink");
	    v16:Add(function()
	        v4:Activate("Blink");
	    end);
	    v4:Run("CyberEvent", "GrassRecolor");
	    v16:Add(function()
	        v4:Stop("CyberEvent", "GrassRecolor");
	    end);
	    v4:Run("CyberEvent", "WallRecolor");
	    v16:Add(function()
	        v4:Stop("CyberEvent", "WallRecolor");
	    end);
	    v4:Run("CyberEvent", "WallBottomRecolor");
	    v16:Add(function()
	        v4:Stop("CyberEvent", "WallBottomRecolor");
	    end);
	    local v19 = nil;
	    if v9.IsBiggerServer() then
	        v19 = v16:Clone(script.BiggerCyberMap);
	        v19.Parent = workspace;
	    else
	        v19 = v16:Clone(script.CyberMap);
	        v19.Parent = workspace;
	    end;
	    local l_BeaconAnimation_0 = script.BeaconAnimation;
	    local l_Animator_0 = v19.Beacon.AnimationController.Animator;
	    local v22 = l_Animator_0:LoadAnimation(l_BeaconAnimation_0);
	    v16:Add(function()
	        v22:Stop();
	        v22:Destroy();
	    end);
	    local v23 = 0;
	    v16:Add(v11:RemoteEvent("GameService/CyberBeaconAnimation").OnClientEvent:Connect(function(_, _, v26)
	        if not v26 and l_Animator_0:IsDescendantOf(workspace) then
	            v22:Stop(0);
	            v22:Play();
	            v5:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx.CyberSpawn, v19.Beacon:GetPivot().Position, false);
	            v13.emit(v19.Beacon);
	        end;
	        v23 = v23 + 1;
	        local l_v23_0 = v23;
	        task.spawn(function()
	            local l_Map_0 = workspace:FindFirstChild("Map");
	            local v29 = l_Map_0 and l_Map_0:FindFirstChild("Cave");
	            local v30 = v29 and v29:FindFirstChild("Collisions");
	            if not v30 then
	                return;
	            else
	                local v31 = v30:QueryDescendants("BasePart");
	                if #v31 == 0 then
	                    return;
	                else
	                    if not v17 then
	                        local v32 = {};
	                        for _, v34 in v31 do
	                            v32[v34] = v34.Color;
	                        end;
	                        v17 = v32;
	                    end;
	                    assert(v17);
	                    local function _()
	                        return l_v23_0 == v23;
	                    end;
	                    for _, v37 in v31 do
	                        v12(v37, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.5), {
	                            Color = v14
	                        });
	                    end;
	                    task.wait(1.7);
	                    if not (l_v23_0 == v23) then
	                        return;
	                    else
	                        for _ = 1, 2 do
	                            if not (l_v23_0 == v23) then
	                                return;
	                            else
	                                for _, v40 in v31 do
	                                    v40.Color = v17[v40];
	                                end;
	                                task.wait(0.1);
	                                if not (l_v23_0 == v23) then
	                                    return;
	                                else
	                                    for _, v42 in v31 do
	                                        v42.Color = v14;
	                                    end;
	                                    task.wait(0.1);
	                                end;
	                            end;
	                        end;
	                        if not (l_v23_0 == v23) then
	                            return;
	                        else
	                            for _, v44 in v31 do
	                                v12(v44, TweenInfo.new(0.5), {
	                                    Color = v17[v44]
	                                });
	                            end;
	                            return;
	                        end;
	                    end;
	                end;
	            end;
	        end);
	    end));
	    local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
	    if l_Atmosphere_0 then
	        l_Atmosphere_0.Parent = script;
	        v16:Add(function()
	            l_Atmosphere_0.Parent = l_Lighting_0;
	        end);
	    end;
	    v16:Clone(script.AtmosphereCyber).Parent = l_Lighting_0;
	    local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
	    if l_Cartoon_0 then
	        l_Cartoon_0.Parent = script;
	        v16:Add(function()
	            l_Cartoon_0.Parent = l_Lighting_0;
	        end);
	    end;
	    v16:Clone(script.SkyCyber).Parent = l_Lighting_0;
	    v16:Add(v8.observeTag("HideInCyber", function(v47)
	        local l_Parent_0 = v47.Parent;
	        v47.Parent = script;
	        return function()
	            pcall(function()
	                v47.Parent = l_Parent_0;
	            end);
	        end;
	    end, {
	        workspace, 
	        script
	    }));
	    v16:Add(v8.observeTag("ShowInCyber", function(v49)
	        local l_Parent_1 = v49.Parent;
	        local v51 = false;
	        local v52 = l_Parent_1.Destroying:Once(function()
	            v51 = true;
	            v49:Destroy();
	        end);
	        v49.Parent = script;
	        return function()
	            v52:Disconnect();
	            if not v51 then
	                pcall(function()
	                    v49.Parent = l_Parent_1;
	                end);
	            end;
	        end;
	    end, {
	        workspace, 
	        script
	    }));
	    v7:Update();
	    v5:UpdateOST();
	end;
	v3.OnStop = function(_)
	    v16:Destroy();
	end;
	v3.OnLoad = function(_)

	end;
	return v3;
