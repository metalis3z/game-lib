-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local v1 = {};
local l_delay_0 = task.delay;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Debris");
local l_TweenService_0 = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local _ = require(l_ReplicatedStorage_0.Modules.Statuses);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v12 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v13 = TweenInfo.new(0.3);
local v14 = {
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
v1.OnIntroduction = function(_, _, v17, v18) --[[ Line: 34 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v12 (copy), l_TweenService_0 (copy), v14 (copy), v13 (copy), l_delay_0 (copy)
    v12:SetCustomLighting(script.IntroLighting);
    game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
    workspace.CurrentCamera.FieldOfView = 30;
    local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
    local v20 = script.Subtitles:Clone();
    v20.ResetOnSpawn = false;
    v20.IgnoreGuiInset = true;
    v20.Main.Subtitles.Text = ("Oh mi gawd you really came %*!"):format(game.Players.LocalPlayer);
    v20.Parent = l_PlayerGui_0;
    local v21 = TweenInfo.new(0.15);
    local function _(v22) --[[ Line: 48 ]] --[[ Name: tweenSubtitles ]]
        -- upvalues: l_TweenService_0 (ref), v20 (copy), v21 (copy)
        l_TweenService_0:Create(v20.Main.Subtitles, v21, {
            TextTransparency = v22, 
            TextStrokeTransparency = v22
        }):Play();
    end;
    for _, v25 in (v17:GetDescendants()) do
        if v14[tostring(v25)] and (v25:IsA("Decal") or v25:IsA("BasePart")) then
            v25.Transparency = 1;
            l_TweenService_0:Create(v25, v13, {
                Transparency = 0
            }):Play();
        end;
    end;
    l_delay_0(0.15, function() --[[ Line: 64 ]]
        -- upvalues: l_TweenService_0 (ref), v20 (copy), v21 (copy)
        l_TweenService_0:Create(v20.Main.Subtitles, v21, {
            TextTransparency = 0, 
            TextStrokeTransparency = 0
        }):Play();
    end);
    l_delay_0(1.45, function() --[[ Line: 69 ]]
        -- upvalues: l_TweenService_0 (ref), v20 (copy), v21 (copy)
        l_TweenService_0:Create(v20.Main.Subtitles, v21, {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        }):Play();
    end);
    l_delay_0(2.05, function() --[[ Line: 73 ]]
        -- upvalues: v20 (copy), l_TweenService_0 (ref), v21 (copy)
        v20.Main.Subtitles.Text = "Lets put up a fight.";
        l_TweenService_0:Create(v20.Main.Subtitles, v21, {
            TextTransparency = 0, 
            TextStrokeTransparency = 0
        }):Play();
    end);
    l_delay_0(3.5, function() --[[ Line: 78 ]]
        -- upvalues: l_TweenService_0 (ref), v20 (copy)
        l_TweenService_0:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {
            FieldOfView = 29
        }):Play();
        l_TweenService_0:Create(v20.Fade, TweenInfo.new(0.75), {
            BackgroundTransparency = 0
        }):Play();
    end);
    l_delay_0(v18, function() --[[ Line: 84 ]]
        -- upvalues: v12 (ref), v20 (copy)
        v12:SetAsCurrentLighting();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        v20:Destroy();
    end);
end;
v1.EnragedReveal = function(_, v27) --[[ Line: 91 ]] --[[ Name: EnragedReveal ]]
    -- upvalues: l_delay_0 (copy)
    local l_Rig_0 = v27.Rig;
    if not l_Rig_0 then
        return;
    else
        l_delay_0(0.25, function() --[[ Line: 95 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.Plate.Transparency = 1;
            l_Rig_0.Plate.String.Transparency = 1;
            l_Rig_0.Plate.plateface.face.Transparency = 1;
        end);
        return;
    end;
end;
v1.EnragedEnd = function(_, v30) --[[ Line: 102 ]] --[[ Name: EnragedEnd ]]
    local l_Rig_1 = v30.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1.Plate.Transparency = 0;
        l_Rig_1.Plate.String.Transparency = 0;
        l_Rig_1.Plate.plateface.face.Transparency = 0;
        return;
    end;
end;
v1.GashingWoundStart = function(_, v33) --[[ Line: 111 ]] --[[ Name: GashingWoundStart ]]
    -- upvalues: l_TweenService_0 (copy), l_delay_0 (copy)
    local l_Rig_2 = v33.Rig;
    if not l_Rig_2 then
        return;
    else
        local v35 = nil;
        v35 = v33.Cache.GashingWound.KeyframeReached:Connect(function(v36) --[[ Line: 116 ]]
            -- upvalues: l_Rig_2 (copy), l_TweenService_0 (ref), v35 (ref), l_delay_0 (ref)
            if v36:find("Shot") then
                local v37 = tonumber(v36:sub(5));
                local l_FirstChild_0 = l_Rig_2.PrimaryPart:FindFirstChild(v36);
                l_FirstChild_0.Transparency = 0;
                l_TweenService_0:Create(l_FirstChild_0, TweenInfo.new(0.05), {
                    Size = Vector3.new(1, 1, 75, 0)
                }):Play();
                if v37 == 7 then
                    v35:Disconnect();
                    for v39 = 1, 7 do
                        local v40 = 0.25 + 0.1 * (v39 - 1);
                        local l_FirstChild_1 = l_Rig_2.PrimaryPart:FindFirstChild((("Shot%*"):format(v39)));
                        l_TweenService_0:Create(l_FirstChild_1, TweenInfo.new(v40, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = Vector3.new(1, 1, 1, 0)
                        }):Play();
                        l_delay_0(v40, function() --[[ Line: 130 ]]
                            -- upvalues: l_Rig_2 (ref), v39 (copy)
                            l_Rig_2.PrimaryPart[("Shot%*"):format(v39)].Transparency = 1;
                        end);
                    end;
                end;
            end;
        end);
        return;
    end;
end;
v1.LastManStanding = function(_, v43, _) --[[ Line: 139 ]] --[[ Name: LastManStanding ]]
    if not game["Run Service"]:IsServer() then
        return;
    else
        local l_Rig_3 = v43.Rig;
        if l_Rig_3 and l_Rig_3.Parent then
            local l_Angel_0 = l_Rig_3:FindFirstChild("Angel");
            if not l_Angel_0 then
                return;
            else
                game.TweenService:Create(l_Angel_0.Handle, TweenInfo.new(10), {
                    Transparency = 0
                }):Play();
            end;
        end;
        return;
    end;
end;
return v1;