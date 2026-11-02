-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local l_TweenService_0 = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
local v5 = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local _ = require(l_ReplicatedStorage_0.Modules.Statuses);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local _ = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
v0.OnIntroduction = function(_, v12, v13, v14) --[[ Line: 16 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v5 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    local function v16() --[[ Line: 17 ]] --[[ Name: fov ]]
        -- upvalues: v5 (ref), l_Debris_0 (ref), v14 (copy), l_TweenService_0 (ref)
        local l_v5_FOVMultiplier_0 = v5:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35714285714285715, "PursuerCool");
        l_Debris_0:AddItem(l_v5_FOVMultiplier_0, v14 + 0.3);
        task.wait(v14);
        l_TweenService_0:Create(l_v5_FOVMultiplier_0, TweenInfo.new(0.25), {
            Value = 1
        }):Play();
    end;
    local function v23() --[[ Line: 26 ]] --[[ Name: playDummyAnims ]]
        -- upvalues: v5 (ref), v12 (copy), v14 (copy)
        local v17 = v5:PlayDummyCutsceneAnimations(v12, v14, "Introduction");
        local v18 = {};
        for v19, v20 in pairs(v17) do
            table.insert(v18, v20:GetMarkerReachedSignal("ripbozo"):Connect(function() --[[ Line: 31 ]]
                -- upvalues: v19 (copy)
                v19.FHead.face.Texture = "rbxassetid://109721549384734";
            end));
        end;
        task.wait(v14);
        for _, v22 in ipairs(v18) do
            v22:Disconnect();
        end;
    end;
    local function v30() --[[ Line: 43 ]] --[[ Name: footsteps ]]
        -- upvalues: v12 (copy), v14 (copy)
        local v24 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
        if v24 then
            local l_Footprints_0 = v24.Footprints;
            local v27 = v12.Cache.IntroductionCameraTrack:GetMarkerReachedSignal("footstep"):Connect(function(v26) --[[ Line: 49 ]]
                -- upvalues: l_Footprints_0 (copy)
                if not l_Footprints_0:FindFirstChild((tostring(v26))) then
                    return;
                else
                    l_Footprints_0[tostring(v26)].Transparency = 1;
                    return;
                end;
            end);
            for _, v29 in ipairs(l_Footprints_0:GetChildren()) do
                if v29:IsA("BasePart") then
                    v29.Transparency = 1;
                end;
            end;
            task.wait(v14);
            v27:Disconnect();
        end;
    end;
    local function v36() --[[ Line: 65 ]] --[[ Name: spookyFade ]]
        -- upvalues: v13 (copy), l_TweenService_0 (ref)
        local v31 = {};
        for _, v33 in ipairs(v13:GetDescendants()) do
            if (v33:IsA("BasePart") or v33:IsA("Decal") or v33:IsA("Texture")) and v33.Transparency < 1 then
                v31[v33] = v33.Transparency;
                v33.Transparency = 1;
            end;
        end;
        task.wait(2.69);
        for v34, v35 in pairs(v31) do
            l_TweenService_0:Create(v34, TweenInfo.new(1), {
                Transparency = v35
            }):Play();
        end;
    end;
    task.spawn(v30);
    task.spawn(v16);
    task.spawn(v23);
    task.spawn(v36);
end;
return v0;