-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:05 2025 ]]
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
v0.OnIntroduction = function(_, v12, _, v14) --[[ Line: 16 ]] --[[ Name: OnIntroduction ]]
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
    task.spawn(v16);
    task.spawn(v23);
end;
return v0;