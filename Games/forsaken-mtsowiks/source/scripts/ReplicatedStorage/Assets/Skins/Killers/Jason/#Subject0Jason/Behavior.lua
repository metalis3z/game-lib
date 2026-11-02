-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:51 2025 ]]
local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Debris");
local l_TweenService_0 = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local _ = require(l_ReplicatedStorage_0.Modules.Statuses);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v10 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v11 = TweenInfo.new(0.3);
local v12 = {
    Head = true, 
    ["Left Arm"] = true, 
    ["Left Leg"] = true, 
    ["Right Arm"] = true, 
    ["Right Leg"] = true, 
    Torso = true, 
    Sword = true, 
    Plate = true, 
    String = true, 
    face = true
};
v0.OnIntroduction = function(_, _, v15, v16) --[[ Line: 30 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v10 (copy), l_TweenService_0 (copy), v12 (copy), v11 (copy)
    v10:SetCustomLighting(script.IntroLighting);
    game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
    workspace.CurrentCamera.FieldOfView = 30;
    local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
    local v18 = script.Subtitles:Clone();
    v18.ResetOnSpawn = false;
    v18.IgnoreGuiInset = true;
    v18.Main.Subtitles.Text = ("Oh mi gawd you really came %*!"):format(game.Players.LocalPlayer);
    v18.Parent = l_PlayerGui_0;
    local function v20(v19) --[[ Line: 43 ]] --[[ Name: tweenSubtitles ]]
        -- upvalues: l_TweenService_0 (ref), v18 (copy)
        l_TweenService_0:Create(v18.Main.Subtitles, TweenInfo.new(0.15), {
            TextTransparency = v19, 
            TextStrokeTransparency = v19
        }):Play();
    end;
    for _, v22 in (v15:GetDescendants()) do
        if v12[tostring(v22)] and (v22:IsA("Decal") or v22:IsA("BasePart")) then
            v22.Transparency = 1;
            l_TweenService_0:Create(v22, v11, {
                Transparency = 0
            }):Play();
        end;
    end;
    task.delay(0.15, function() --[[ Line: 59 ]]
        -- upvalues: v20 (copy)
        v20(0);
    end);
    task.delay(1.45, function() --[[ Line: 64 ]]
        -- upvalues: v20 (copy)
        v20(1);
    end);
    task.delay(2.05, function() --[[ Line: 68 ]]
        -- upvalues: v18 (copy), v20 (copy)
        v18.Main.Subtitles.Text = "Lets put up a fight.";
        v20(0);
    end);
    task.delay(3.5, function() --[[ Line: 73 ]]
        -- upvalues: l_TweenService_0 (ref), v18 (copy)
        l_TweenService_0:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {
            FieldOfView = 29
        }):Play();
        l_TweenService_0:Create(v18.Fade, TweenInfo.new(0.75), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(v16, function() --[[ Line: 79 ]]
        -- upvalues: v10 (ref), v18 (copy)
        v10:SetAsCurrentLighting();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        v18:Destroy();
    end);
end;
v0.EnragedReveal = function(_, v24) --[[ Line: 86 ]] --[[ Name: EnragedReveal ]]
    local l_Rig_0 = v24.Rig;
    if not l_Rig_0 then
        return;
    else
        task.delay(0.25, function() --[[ Line: 90 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.Plate.Transparency = 1;
            l_Rig_0.Plate.String.Transparency = 1;
            l_Rig_0.Plate.plateface.face.Transparency = 1;
        end);
        return;
    end;
end;
v0.EnragedEnd = function(_, v27) --[[ Line: 97 ]] --[[ Name: EnragedEnd ]]
    local l_Rig_1 = v27.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1.Plate.Transparency = 0;
        l_Rig_1.Plate.String.Transparency = 0;
        l_Rig_1.Plate.plateface.face.Transparency = 0;
        return;
    end;
end;
v0.GashingWoundStart = function(_, v30) --[[ Line: 106 ]] --[[ Name: GashingWoundStart ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_Rig_2 = v30.Rig;
    if not l_Rig_2 then
        return;
    else
        local v32 = nil;
        v32 = v30.Cache.GashingWound.KeyframeReached:Connect(function(v33) --[[ Line: 111 ]]
            -- upvalues: l_Rig_2 (copy), l_TweenService_0 (ref), v32 (ref)
            if v33:find("Shot") then
                local v34 = tonumber(v33:sub(5));
                local l_FirstChild_0 = l_Rig_2.PrimaryPart:FindFirstChild(v33);
                l_FirstChild_0.Transparency = 0;
                l_TweenService_0:Create(l_FirstChild_0, TweenInfo.new(0.05), {
                    Size = Vector3.new(1, 1, 75, 0)
                }):Play();
                if v34 == 7 then
                    v32:Disconnect();
                    for v36 = 1, 7 do
                        local v37 = 0.25 + 0.1 * (v36 - 1);
                        local l_FirstChild_1 = l_Rig_2.PrimaryPart:FindFirstChild((("Shot%*"):format(v36)));
                        l_TweenService_0:Create(l_FirstChild_1, TweenInfo.new(v37, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = Vector3.new(1, 1, 1, 0)
                        }):Play();
                        task.delay(v37, function() --[[ Line: 125 ]]
                            -- upvalues: l_Rig_2 (ref), v36 (copy)
                            l_Rig_2.PrimaryPart[("Shot%*"):format(v36)].Transparency = 1;
                        end);
                    end;
                end;
            end;
        end);
        return;
    end;
end;
return v0;