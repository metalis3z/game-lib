-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ProximityPromptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local _ = game:GetService("SoundService");
local _ = game:GetService("TweenService");
local l_HttpService_0 = game:GetService("HttpService");
local _ = game:GetService("RunService");
local _ = game:GetService("StarterGui");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Packages.Serialization);
local v10 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local _ = require(l_ReplicatedStorage_0.Packages.TopbarPlus);
local v13 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v14 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Packages.Moonlite);
local _ = require(l_ReplicatedStorage_0.Packages.Squash);
local v17 = require(l_ReplicatedStorage_0.Packages.Timer);
local v18 = require(l_ReplicatedStorage_0.Packages.Trove);
local v19 = require(l_ReplicatedStorage_0.Packages.Spr);
local v20 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local _ = require(l_ReplicatedStorage_0.Controllers.NewPlayersController);
local v23 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local _ = require(l_ReplicatedStorage_0.Controllers.CharacterController);
local v25 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.PlotController);
local v27 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local v28 = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local v29 = require(l_ReplicatedStorage_0.Shared.VFX);
local v30 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local _ = require(l_ReplicatedStorage_0.Shared.Animals);
local v33 = require(l_ReplicatedStorage_0.Shared.Animals);
local _ = require(l_ReplicatedStorage_0.Shared.Index);
local _ = require(l_ReplicatedStorage_0.Datas.Mutations);
local v36 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v37 = require(l_ReplicatedStorage_0.Datas.Animals);
local v38 = v20:RemoteEvent("CraftingMachineService/CraftNow");
local v39 = v20:RemoteEvent("CraftingMachineService/Update");
local v40 = v20:RemoteEvent("CraftingMachineService/Return");
local v41 = v20:RemoteEvent("CraftingMachineService/Claim");
local v42 = v20:RemoteFunction("CraftingMachineService/Delivery");
local v43 = v20:RemoteFunction("CraftingMachineService/Start");
local v44 = v20:RemoteFunction("CraftingMachineService/Fetch");
local _ = v20:RemoteEvent("ShopService/Purchase");
local _ = workspace:WaitForChild("RenderedMovingAnimals");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CraftingMachine_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("CraftingMachine").CraftingMachine;
local l_Content_0 = l_CraftingMachine_0.Content;
local l_Time_0 = l_Content_0.Time;
local l_Buy_0 = l_Content_0.Buy;
local l_Close_0 = l_CraftingMachine_0.Header.Close;
local l_BrainrotName_0 = l_Content_0.BrainrotName;
local _ = v18.new();
local _ = v18.new();
local v56 = nil;
local v57 = nil;
local v58 = "Epic";
local v59 = nil;
local v60 = false;
local v61 = {};
local function v70() --[[ Line: 103 ]] --[[ Name: updateVFX ]]
    -- upvalues: v10 (copy), l_LocalPlayer_0 (copy), v60 (ref), v29 (copy)
    local v62 = v10:Get(l_LocalPlayer_0);
    if not v62 then
        return;
    elseif v60 then
        return;
    else
        local l_CraftingMachine_1 = workspace:FindFirstChild("CraftingMachine");
        if not l_CraftingMachine_1 then
            return;
        else
            local v64 = v62:Get("CraftingMachine");
            if not v64 then
                return;
            else
                local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                if v64.Rarity and v64.StartTime and v64.FinishTime then
                    local v66 = math.clamp((l_workspace_ServerTimeNow_0 - v64.StartTime) / (v64.FinishTime - v64.StartTime), 0, 1);
                    local v67 = l_CraftingMachine_1.VFX[v64.Rarity];
                    v29.enable(v67.ChargingModel.Charging.Charge);
                    v67.ChargingModel:ScaleTo((math.lerp(0.25, 1, v66)));
                    for _, v69 in v67.ChargingModel.Charging.Charge:GetDescendants() do
                        if v69:IsA("ParticleEmitter") then
                            v69.TimeScale = math.lerp(0.3, 0.7, v66);
                        end;
                    end;
                    if not l_CraftingMachine_1.ChargeSoundPart.Sound.IsPlaying then
                        l_CraftingMachine_1.ChargeSoundPart.Sound:Play();
                        return;
                    end;
                else
                    v29.disable(l_CraftingMachine_1.VFX);
                    if l_CraftingMachine_1.ChargeSoundPart.Sound.IsPlaying then
                        l_CraftingMachine_1.ChargeSoundPart.Sound:Stop();
                    end;
                end;
                return;
            end;
        end;
    end;
end;
local v71 = v18.new();
local function v80() --[[ Line: 150 ]] --[[ Name: updateTimer ]]
    -- upvalues: v71 (copy), v10 (copy), l_LocalPlayer_0 (copy), l_Time_0 (copy), v57 (ref), v58 (ref), v28 (copy)
    v71:Clean();
    local v72 = v10:Get(l_LocalPlayer_0);
    if not v72 then
        return;
    else
        l_Time_0.Visible = false;
        local v73 = v72:Get("CraftingMachine.FinishTime");
        local l_CraftingMachine_2 = workspace:FindFirstChild("CraftingMachine");
        if not l_CraftingMachine_2 then
            return;
        else
            local l_Countdown_0 = l_CraftingMachine_2.Overhead.BillboardGui.Countdown;
            if not l_Countdown_0 then
                return;
            else
                l_Time_0.Visible = true;
                local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
                local v77 = v57 and v58 and v57.List[v58];
                if v77 then
                    l_Time_0.Text = ("Crafting Time (<font color=\"#ffff00\">%*</font>)"):format((v28:E(v77.CraftTime)));
                else
                    l_Time_0.Text = "";
                end;
                if not v73 then
                    local v78 = math.max((v57 and v57.Refresh or 0) - l_workspace_ServerTimeNow_1, 0);
                    l_Countdown_0.Text = ("Refreshes in %*"):format((v28:E(v78)));
                    return;
                else
                    local v79 = math.max(v73 - l_workspace_ServerTimeNow_1, 0);
                    l_Countdown_0.Text = v79 <= 0 and "READY" or v28:E(v79);
                    return;
                end;
            end;
        end;
    end;
end;
local v81 = v18.new();
local function v109() --[[ Line: 194 ]] --[[ Name: updateSelection ]]
    -- upvalues: v59 (ref), v58 (ref), v10 (copy), l_LocalPlayer_0 (copy), v81 (copy), v57 (ref), l_Content_0 (copy), l_BrainrotName_0 (copy), v36 (copy), v13 (copy), v37 (copy), v33 (copy), v30 (copy), v40 (copy), l_Buy_0 (copy), v27 (copy), v43 (copy), v23 (copy), v80 (copy)
    if v59 == v58 then
        return;
    else
        local v82 = v10:Get(l_LocalPlayer_0);
        if not v82 then
            return;
        else
            v81:Clean();
            if not v57 then
                return;
            else
                local v83 = v58 and v57.List[v58];
                if v58 and not v83 then
                    return;
                else
                    v59 = v58;
                    if not v58 then
                        l_Content_0.Visible = false;
                        return;
                    else
                        l_Content_0.Visible = true;
                        l_BrainrotName_0.Title.Text = v83.Name;
                        local v84 = v36[v58];
                        if v84.GradientPreset then
                            l_BrainrotName_0.Title.TextColor3 = Color3.new(1, 1, 1);
                            l_BrainrotName_0.UIStroke.Color = Color3.new(1, 1, 1);
                            v81:Add(v13.apply(l_BrainrotName_0.Title, v84.GradientPreset));
                            v81:Add(v13.apply(l_BrainrotName_0.UIStroke, v84.GradientPreset));
                        else
                            l_BrainrotName_0.Title.TextColor3 = v84.Color;
                            l_BrainrotName_0.UIStroke.Color = v84.Color;
                        end;
                        if v37[v83.Name] then
                            local v85 = v33:AttachOnViewport(v83.Name, l_BrainrotName_0.ViewportFrame, true);
                            if v85 then
                                v81:Add(v85);
                            end;
                        end;
                        local v86 = {};
                        for v87, v88 in v83.Recipe do
                            local v89 = v37[v88];
                            if v89 then
                                local v90 = v36[v89.Rarity];
                                local v91 = v81:Clone(l_Content_0.Brainrots.Template);
                                v91.LayoutOrder = v90.Weight * 100 + v87;
                                v91.Title.Text = v88;
                                v91.Title.TextColor3 = Color3.new(1, 1, 1);
                                if v90.GradientPreset then
                                    v91.UIStroke.Color = Color3.new(1, 1, 1);
                                    v81:Add(v13.apply(v91.UIStroke, v90.GradientPreset));
                                else
                                    v91.UIStroke.Color = v90.Color;
                                end;
                                v91.Visible = true;
                                v91.Return.Visible = false;
                                v91.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0);
                                local v92 = v33:AttachOnViewport(v88, v91.ViewportFrame, true);
                                if v92 then
                                    v81:Add(v92);
                                end;
                                v91.Parent = l_Content_0.Brainrots;
                                if not v86[v88] then
                                    v86[v88] = {};
                                end;
                                table.insert(v86[v88], v91);
                                local v93 = v81:Add(v30.new(v91.Return));
                                v93:Animate();
                                v81:Add(v93.OnActivated:Connect(function() --[[ Line: 284 ]]
                                    -- upvalues: v82 (copy), v88 (copy), v40 (ref)
                                    for v94, v95 in (v82:Get("AnimalPodiums")) do
                                        if type(v95) == "table" and v95.Index == v88 and v95.Machine and v95.Machine.Type == "Crafting" and not v95.Machine.Active then
                                            v40:FireServer(v94);
                                            return;
                                        end;
                                    end;
                                end));
                            end;
                        end;
                        local function v107() --[[ Line: 295 ]] --[[ Name: updateBrainrotFrame ]]
                            -- upvalues: v82 (copy), v86 (copy), l_Buy_0 (ref)
                            local v96 = v82:Get("AnimalPodiums");
                            local v97 = {};
                            for _, v99 in v96 do
                                if type(v99) == "table" and v99.Machine and v99.Machine.Type == "Crafting" and not v99.Machine.Active then
                                    v97[v99.Index] = (v97[v99.Index] or 0) + 1;
                                end;
                            end;
                            local v100 = true;
                            for v101, v102 in v86 do
                                local v103 = v97[v101] or 0;
                                for v104, v105 in v102 do
                                    local v106 = v104 <= v103;
                                    v105.Return.Visible = v106;
                                    v105.ViewportFrame.ImageColor3 = if v106 then Color3.new(1, 1, 1) else Color3.new(0, 0, 0);
                                    if not v106 then
                                        v100 = false;
                                    end;
                                end;
                            end;
                            l_Buy_0.Visible = v100;
                        end;
                        v81:Add(v82:OnChanged("AnimalAddedOrRemoved", v107));
                        v81:Add(task.spawn(v107));
                        l_Buy_0.Price.Text = ("$%*"):format((v27:ToString(v83.Cost)));
                        local v108 = v81:Add(v30.new(l_Buy_0));
                        v108:Animate();
                        v81:Add(v108.OnActivated:Connect(function() --[[ Line: 330 ]]
                            -- upvalues: v43 (ref), v58 (ref), v83 (copy), v23 (ref)
                            if not v43:InvokeServer(v58, v83.Name) then
                                return;
                            else
                                v23:SetState("CraftingMachine", false);
                                return;
                            end;
                        end));
                        v80();
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
local v110 = v18.new();
local function v117() --[[ Line: 346 ]] --[[ Name: updateList ]]
    -- upvalues: v110 (copy), v57 (ref), v36 (copy), l_CraftingMachine_0 (copy), v13 (copy), v30 (copy), v58 (ref), v109 (copy), v37 (copy), v33 (copy)
    v110:Clean();
    if not v57 then
        return;
    else
        for v111, v112 in v57.List do
            local v113 = v36[v111];
            local v114 = v110:Clone(l_CraftingMachine_0.List.Template);
            v114.LayoutOrder = v113 and v113.Weight or 0;
            v114.Title.Text = v112.Name;
            if v113.GradientPreset then
                v114.Title.TextColor3 = Color3.new(1, 1, 1);
                v114.UIStroke.Color = Color3.new(1, 1, 1);
                v110:Add(v13.apply(v114.Title, v113.GradientPreset));
                v110:Add(v13.apply(v114.UIStroke, v113.GradientPreset));
            else
                v114.Title.TextColor3 = v113.Color;
                v114.UIStroke.Color = v113.Color;
            end;
            v114.Visible = true;
            v114.Parent = l_CraftingMachine_0.List;
            local v115 = v110:Add(v30.new(v114));
            v115:Animate();
            v110:Add(v115.OnActivated:Connect(function() --[[ Line: 374 ]]
                -- upvalues: v58 (ref), v111 (copy), v109 (ref)
                v58 = v111;
                v109();
            end));
            if v37[v112.Name] then
                local v116 = v33:AttachOnViewport(v112.Name, v114.ViewportFrame, true);
                if v116 then
                    v110:Add(v116);
                end;
            end;
        end;
        v109();
        return;
    end;
end;
v61.Start = function(_) --[[ Line: 390 ]] --[[ Name: Start ]]
    -- upvalues: l_CraftingMachine_0 (copy), v56 (ref), v23 (copy), l_Close_0 (copy), v10 (copy), l_LocalPlayer_0 (copy), v80 (copy), v17 (copy), v70 (copy), v14 (copy), v18 (copy), v41 (copy), v38 (copy), l_Players_0 (copy), v42 (copy), v25 (copy), l_ReplicatedStorage_0 (copy), l_HttpService_0 (copy), v60 (ref), v29 (copy), v39 (copy), v59 (ref), v57 (ref), v117 (copy), v44 (copy), v28 (copy), v19 (copy)
    l_CraftingMachine_0.Visible = false;
    v56 = v23:Register("CraftingMachine", l_CraftingMachine_0, "TopQuint");
    v56:AttachCloseButton(l_Close_0);
    v56:Close();
    v10:WaitAndCall(l_LocalPlayer_0, function(v119) --[[ Line: 399 ]]
        -- upvalues: v80 (ref)
        local function v120() --[[ Line: 400 ]] --[[ Name: update ]]
            -- upvalues: v80 (ref)
            task.spawn(v80);
        end;
        v119:OnChanged("CraftingMachine", v120);
        v119:OnChanged("CraftingMachine.Brainrot", v120);
        v119:OnChanged("CraftingMachine.Rarity", v120);
        v119:OnChanged("CraftingMachine.FinishTime", v120);
        v119:OnChanged("CraftingMachine.StartTime", v120);
        task.spawn(v120);
    end);
    v17.Simple(1, function() --[[ Line: 412 ]]
        -- upvalues: v70 (ref), v80 (ref)
        task.spawn(v70);
        task.spawn(v80);
    end);
    v14.observeTag("CraftingMachinePrompt", function(v121) --[[ Line: 417 ]]
        -- upvalues: v18 (ref), v10 (ref), l_LocalPlayer_0 (ref), v17 (ref), v41 (ref), v38 (ref), v23 (ref)
        local v122 = v18.new();
        local function v126() --[[ Line: 420 ]] --[[ Name: updatePrompt ]]
            -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v121 (copy)
            local v123 = v10:Wait(l_LocalPlayer_0);
            if not v123 then
                return;
            else
                local v124 = v123:Get("CraftingMachine.StartTime");
                local v125 = v123:Get("CraftingMachine.FinishTime");
                if v125 and v125 ~= 0 and v125 <= workspace:GetServerTimeNow() then
                    v121.ActionText = "Claim";
                    return;
                elseif v124 and v124 ~= 0 then
                    v121.ActionText = "Craft Now";
                    return;
                else
                    v121.ActionText = "Craft Machine";
                    return;
                end;
            end;
        end;
        v122:Add(task.spawn(function() --[[ Line: 437 ]]
            -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v126 (copy), v122 (copy), v17 (ref)
            local v127 = v10:Wait(l_LocalPlayer_0);
            if not v127 then
                return;
            else
                v127:OnChanged("CraftingMachine", v126);
                v122:Add(v17.Simple(1, v126));
                task.spawn(v126);
                return;
            end;
        end));
        v122:Add(v121.Triggered:Connect(function() --[[ Line: 448 ]]
            -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v41 (ref), v38 (ref), v23 (ref)
            local v128 = v10:Get(l_LocalPlayer_0);
            if not v128 then
                return;
            else
                local v129 = v128:Get("CraftingMachine.StartTime");
                local v130 = v128:Get("CraftingMachine.FinishTime");
                if v130 and v130 ~= 0 and v130 <= workspace:GetServerTimeNow() then
                    v41:FireServer();
                    return;
                elseif v129 and v129 ~= 0 then
                    v38:FireServer();
                    return;
                else
                    v23:Toggle("CraftingMachine");
                    return;
                end;
            end;
        end));
        return function() --[[ Line: 465 ]]
            -- upvalues: v122 (copy)
            v122:Destroy();
        end;
    end);
    v14.observeTag("CraftingMachine", function(v131) --[[ Line: 470 ]]
        -- upvalues: v18 (ref), l_Players_0 (ref), l_LocalPlayer_0 (ref), v42 (ref), v25 (ref), l_ReplicatedStorage_0 (ref), v80 (ref)
        local v132 = v18.new();
        for _, v134 in v131.Hitboxes:GetChildren() do
            v132:Add(v134.Touched:Connect(function(v135) --[[ Line: 474 ]]
                -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v42 (ref), v134 (copy), v25 (ref), l_ReplicatedStorage_0 (ref), v80 (ref)
                if v135.Name ~= "HumanoidRootPart" then
                    return;
                else
                    local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v135.Parent);
                    if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0 then
                        return;
                    else
                        if l_l_Players_0_PlayerFromCharacter_0:GetAttribute("StealingIndex") then
                            local v137, _, _ = v42:InvokeServer(v134);
                            if not v137 then
                                return;
                            else
                                task.spawn(function() --[[ Line: 491 ]]
                                    -- upvalues: v25 (ref), l_ReplicatedStorage_0 (ref)
                                    v25:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit);
                                end);
                                v80();
                            end;
                        end;
                        return;
                    end;
                end;
            end));
        end;
        return function() --[[ Line: 501 ]]
            -- upvalues: v132 (copy)
            v132:Destroy();
        end;
    end);
    local v140 = {};
    v38.OnClientEvent:Connect(function(v141) --[[ Line: 507 ]]
        -- upvalues: l_HttpService_0 (ref), v140 (copy), v60 (ref), v29 (ref)
        local l_CraftingMachine_3 = workspace:FindFirstChild("CraftingMachine");
        if not l_CraftingMachine_3 then
            return;
        else
            local v143 = l_HttpService_0:GenerateGUID(false);
            v140[v143] = true;
            v60 = next(v140) ~= nil;
            local v144 = l_CraftingMachine_3.VFX[v141];
            v144.ChargingModel:ScaleTo(1);
            for _, v146 in v144.ChargingModel.Charging.Charge:GetDescendants() do
                if v146:IsA("ParticleEmitter") then
                    v146.TimeScale = 1;
                end;
            end;
            v29.enable(v144);
            v144.SoundPart.Sound:Play();
            if l_CraftingMachine_3.ChargeSoundPart.Sound.IsPlaying then
                l_CraftingMachine_3.ChargeSoundPart.Sound:Stop();
            end;
            task.wait(1.5);
            v29.disable(v144);
            v29.emit(v144.Burst);
            v140[v143] = nil;
            v60 = next(v140) ~= nil;
            return;
        end;
    end);
    v39.OnClientEvent:Connect(function(v147) --[[ Line: 537 ]]
        -- upvalues: v59 (ref), v57 (ref), v117 (ref)
        v59 = nil;
        v57 = v147;
        v117();
    end);
    v57 = v44:InvokeServer() or v57;
    task.spawn(v117);
    v17.Simple(1, function() --[[ Line: 547 ]]
        -- upvalues: v57 (ref), l_CraftingMachine_0 (ref), v28 (ref)
        local v148 = (v57 and v57.Refresh or 0) - workspace:GetServerTimeNow();
        l_CraftingMachine_0.Timer.Text = ("Refreshes in %*"):format((v28:E((math.max(v148, 0)))));
    end, true);
    v10:WaitAndCall(l_LocalPlayer_0, function() --[[ Line: 553 ]]
        -- upvalues: v117 (ref)
        v117();
    end);
    task.spawn(function() --[[ Line: 557 ]]
        -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v19 (ref)
        local v149 = v10:Wait(l_LocalPlayer_0);
        if v149 then
            local v150 = {
                Color3.fromRGB(163, 162, 165), 
                Color3.fromRGB(93, 176, 55), 
                Color3.fromRGB(179, 168, 48), 
                Color3.fromRGB(88, 173, 106)
            };
            local v151 = Random.new();
            while true do
                local v152 = 1;
                local v153 = 3;
                local l_workspace_ServerTimeNow_2 = workspace:GetServerTimeNow();
                local v155 = v149:Get("CraftingMachine.StartTime");
                local v156 = v149:Get("CraftingMachine.FinishTime");
                if v155 and v156 and workspace:GetServerTimeNow() < v156 then
                    local v157 = math.clamp((l_workspace_ServerTimeNow_2 - v155) / (v156 - v155), 0, 1);
                    v152 = math.lerp(0.5, 0.25, v157);
                    v153 = math.lerp(4, 5, v157);
                end;
                task.wait(v152);
                local l_CraftingMachine_4 = workspace:FindFirstChild("CraftingMachine");
                if l_CraftingMachine_4 then
                    local l_Cubes_0 = l_CraftingMachine_4:FindFirstChild("Cubes");
                    if l_Cubes_0 then
                        for _, v161 in l_Cubes_0:GetChildren() do
                            v19.target(v161, 1, v153, {
                                Color = v150[v151:NextInteger(1, #v150)]
                            });
                        end;
                    end;
                end;
            end;
        end;
    end);
end;
return v61;