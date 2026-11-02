-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local _ = require(l_Controllers_0.PlayerController);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v6 = require(l_Datas_0.Mutations);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v8 = require(l_Packages_0.Observers);
local v9 = require(l_Packages_0.Signal);
local v10 = require(l_Packages_0.Trove);
local l_Rainbow_0 = v6.Rainbow;
local l_MutationSurfaces_0 = l_ReplicatedStorage_0:WaitForChild("MutationSurfaces");
local l_GameSettings_0 = UserSettings().GameSettings;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Value_0 = Enum.SavedQualitySetting.QualityLevel6.Value;
return {
    Start = function(_) --[[ Line: 33 ]] --[[ Name: Start ]]
        -- upvalues: l_Rainbow_0 (copy), v9 (copy), l_UserInputService_0 (copy), l_GameSettings_0 (copy), l_Value_0 (copy), l_CurrentCamera_0 (copy), l_RunService_0 (copy), v8 (copy), v10 (copy), l_MutationSurfaces_0 (copy)
        local v17 = l_Rainbow_0.Palettes[1];
        local v18 = math.min(#v17, 4);
        local _ = v9.new();
        local _ = {};
        local v21 = nil;
        local v22 = {};
        local v23 = 0.05;
        local function v24() --[[ Line: 62 ]] --[[ Name: updateDevice ]]
            -- upvalues: l_UserInputService_0 (ref), l_GameSettings_0 (ref), l_Value_0 (ref), v23 (ref)
            if l_UserInputService_0.TouchEnabled and not l_UserInputService_0.KeyboardEnabled and not l_UserInputService_0.MouseEnabled and l_GameSettings_0.SavedQualityLevel.Value <= l_Value_0 then
                v23 = 0.1;
                return;
            else
                v23 = 0.05;
                return;
            end;
        end;
        l_UserInputService_0:GetPropertyChangedSignal("TouchEnabled"):Connect(v24);
        l_UserInputService_0:GetPropertyChangedSignal("KeyboardEnabled"):Connect(v24);
        l_UserInputService_0:GetPropertyChangedSignal("MouseEnabled"):Connect(v24);
        task.spawn(v24);
        local v25 = nil;
        local v26 = 0;
        local function v30(v27) --[[ Line: 80 ]] --[[ Name: updateVoxels ]]
            -- upvalues: v26 (ref), v25 (ref), l_CurrentCamera_0 (ref), v22 (copy)
            v26 = v26 + v27;
            if v26 < 0.5 then
                return;
            else
                v26 = 0;
                v25 = l_CurrentCamera_0.CFrame.Position // 25;
                for v28, v29 in v22 do
                    if v29.isPVInstance then
                        v29.voxel = v28:GetPivot().Position // 25;
                    end;
                end;
                return;
            end;
        end;
        local function v50(_) --[[ Line: 97 ]] --[[ Name: updateColors ]]
            -- upvalues: v18 (copy), v21 (ref), v17 (copy), v22 (copy), v23 (ref), v25 (ref)
            local v32 = os.clock();
            local v33 = (v32 % v18 + 1) // 1;
            v21 = v17[v33]:Lerp(v17[v33 % v18 + 1], v32 % 1);
            local v34, v35 = v21:ToHSV();
            local v36 = ColorSequence.new(v21);
            for _, v38 in v22 do
                local l_v23_0 = v23;
                local l_voxel_0 = v38.voxel;
                if l_voxel_0 then
                    l_v23_0 = l_v23_0 * math.clamp((math.abs(l_voxel_0.X - v25.X) + math.abs(l_voxel_0.Z - v25.Z)) / 10 + 1, 1, 2.5);
                end;
                if v32 - v38.lastUpdate >= l_v23_0 then
                    v38.lastUpdate = v32;
                    local l_defaultColor_0 = v38.defaultColor;
                    local v42 = nil;
                    if l_defaultColor_0 then
                        local _, _, v45 = l_defaultColor_0:ToHSV();
                        v42 = Color3.fromHSV(v34, math.max(v35 - 0.4, 0), (math.min(v45 + 0.2, 1)));
                    end;
                    for _, v47 in v38.list do
                        v47.Color = v42 or v21;
                    end;
                    for _, v49 in v38.sequenceList do
                        v49.Color = v36;
                    end;
                end;
            end;
        end;
        l_RunService_0.PreRender:Connect(function(v51) --[[ Line: 141 ]]
            -- upvalues: v30 (copy), v50 (copy)
            debug.profilebegin("rainbow:update");
            debug.profilebegin("rainbow:updateVoxels");
            v30(v51);
            debug.profileend();
            debug.profilebegin("rainbow:updateColors");
            v50(v51);
            debug.profileend();
            debug.profileend();
        end);
        v8.observeTag("RainbowModel", function(v52) --[[ Line: 155 ]]
            -- upvalues: v10 (ref), v8 (ref), l_MutationSurfaces_0 (ref), v22 (copy)
            local v53 = v52:IsA("PVInstance");
            if not v53 then

            end;
            local v54 = v10.new();
            local v55 = {};
            local v56 = {};
            if v52:IsA("BasePart") and (v52.Transparency < 1 or v52:GetAttribute("RainbowIgnoreTransparency")) and not v52:GetAttribute("IgnoreRainbowColor") then
                table.insert(v55, v52);
            elseif (v52:IsA("ParticleEmitter") or v52:IsA("Beam")) and v52:GetAttribute("IncludeParticles") then
                table.insert(v56, v52);
            end;
            v54:Add(v8.observeDescendants(v52, function(v57) --[[ Line: 172 ]]
                -- upvalues: v52 (copy), v56 (copy), v54 (copy), l_MutationSurfaces_0 (ref), v55 (copy)
                if (v57:IsA("ParticleEmitter") or v57:IsA("Beam")) and v52:GetAttribute("IncludeParticles") then
                    table.insert(v56, v57);
                    return function() --[[ Line: 175 ]]
                        -- upvalues: v56 (ref), v57 (copy)
                        local v58 = table.find(v56, v57);
                        if v58 then
                            table.remove(v56, v58);
                        end;
                    end;
                elseif not v57:IsA("BasePart") or v57.Transparency >= 1 and not v52:GetAttribute("RainbowIgnoreTransparency") or v57:GetAttribute("IgnoreRainbowColor") then
                    return;
                else
                    local l_SurfaceAppearance_0 = v57:FindFirstChildOfClass("SurfaceAppearance");
                    if l_SurfaceAppearance_0 then
                        l_SurfaceAppearance_0:Destroy();
                        local v60 = v54:Clone(l_MutationSurfaces_0[v52.Name]);
                        v60.Parent = v57;
                        table.insert(v55, v60);
                        return function() --[[ Line: 195 ]]
                            -- upvalues: v55 (ref), v60 (copy)
                            local v61 = table.find(v55, v60);
                            if v61 then
                                table.remove(v55, v61);
                            end;
                        end;
                    else
                        table.insert(v55, v57);
                        return function() --[[ Line: 204 ]]
                            -- upvalues: v55 (ref), v57 (copy)
                            local v62 = table.find(v55, v57);
                            if v62 then
                                table.remove(v55, v62);
                            end;
                        end;
                    end;
                end;
            end));
            v22[v52] = {
                list = v55, 
                sequenceList = v56, 
                lastUpdate = 0, 
                isPVInstance = v53, 
                defaultColor = if v52:HasTag("RainbowDarken") then v52.Color else nil
            };
            v54:Add(function() --[[ Line: 220 ]]
                -- upvalues: v22 (ref), v52 (copy)
                v22[v52] = nil;
            end);
            return v54:WrapClean();
        end);
    end
};