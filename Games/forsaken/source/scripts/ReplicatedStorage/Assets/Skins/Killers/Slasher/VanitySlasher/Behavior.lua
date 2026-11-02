-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local _ = game:GetService("InsertService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("ContentProvider");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = require(l_ReplicatedStorage_0.Modules.Util);
local v25 = {
    EnragedReveal = function(_, v8) --[[ Line: 15 ]] --[[ Name: EnragedReveal ]]
        -- upvalues: l_TweenService_0 (copy)
        local l_Rig_0 = v8.Rig;
        v8.Cache = v8.Cache or {};
        v8.Cache.tempRetextured = {};
        for _, v11 in ipairs({
            "Chainsaw", 
            "Machete"
        }) do
            local l_l_Rig_0_FirstChild_0 = l_Rig_0:FindFirstChild(v11);
            if l_l_Rig_0_FirstChild_0 and not l_l_Rig_0_FirstChild_0:GetAttribute("OGSize") and l_l_Rig_0_FirstChild_0:FindFirstChild("Enraged") then
                l_l_Rig_0_FirstChild_0.Enraged.Size = l_l_Rig_0_FirstChild_0.Size;
                l_l_Rig_0_FirstChild_0:SetAttribute("OGSize", l_l_Rig_0_FirstChild_0.Size);
                l_l_Rig_0_FirstChild_0.Size = Vector3.new(0, 0, 0, 0);
                table.insert(v8.Cache.tempRetextured, l_l_Rig_0_FirstChild_0);
            end;
        end;
        local l_Vanity_0 = l_Rig_0:FindFirstChild("Vanity");
        if not l_Vanity_0 then
            return;
        else
            for _, v15 in ipairs(l_Vanity_0:GetChildren()) do
                if not v15:GetAttribute("OGSize") and v15:FindFirstChild("Enraged") then
                    v15.Enraged.Size = v15.Size;
                    v15:SetAttribute("OGSize", v15.Size);
                    v15.Size = Vector3.new(0, 0, 0, 0);
                    table.insert(v8.Cache.tempRetextured, v15);
                end;
            end;
            local l_Mask_0 = l_Vanity_0:FindFirstChild("Mask");
            if l_Mask_0 then
                l_TweenService_0:Create(l_Mask_0, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
            return;
        end;
    end, 
    EnragedEnd = function(_, v18) --[[ Line: 52 ]] --[[ Name: EnragedEnd ]]
        -- upvalues: l_TweenService_0 (copy)
        local l_Rig_1 = v18.Rig;
        v18.Cache = v18.Cache or {};
        if v18.Cache.tempRetextured then
            for _, v21 in ipairs(v18.Cache.tempRetextured) do
                local l_v21_Attribute_0 = v21:GetAttribute("OGSize");
                if l_v21_Attribute_0 then
                    v21.Size = l_v21_Attribute_0;
                    if v21:FindFirstChild("Enraged") then
                        v21.Enraged.Size = Vector3.new(0, 0, 0, 0);
                    end;
                    v21:SetAttribute("OGSize", nil);
                end;
            end;
        end;
        v18.Cache.tempRetextured = nil;
        local l_Vanity_1 = l_Rig_1:FindFirstChild("Vanity");
        if not l_Vanity_1 then
            return;
        else
            local l_Mask_1 = l_Vanity_1:FindFirstChild("Mask");
            if l_Mask_1 then
                l_TweenService_0:Create(l_Mask_1, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 0
                }):Play();
            end;
            return;
        end;
    end
};
local function v30(v26, v27) --[[ Line: 83 ]] --[[ Name: createVideoUI ]]
    local v28 = script.ScreenGui:Clone();
    v28.Name = "IntroVideoUI";
    v28.Parent = game.Players.LocalPlayer.PlayerGui;
    local l_VideoFrame_0 = v28:FindFirstChildOfClass("VideoFrame");
    l_VideoFrame_0.Video = tostring(v26);
    if v27 then
        if v27.Looped then
            l_VideoFrame_0.Looped = true;
        elseif v27.DestroyOnEnd then
            l_VideoFrame_0.Ended:Connect(function() --[[ Line: 95 ]]
                -- upvalues: v28 (copy)
                v28:Destroy();
            end);
        end;
    end;
    l_VideoFrame_0:Play();
    return v28;
end;
v25.CreatedPost = function(_, v32) --[[ Line: 106 ]] --[[ Name: CreatedPost ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_Rig_2 = v32.Rig;
    if not l_Rig_2 and not l_Rig_2.Parent then
        return;
    else
        local l_Highlight_0 = l_Rig_2:FindFirstChildOfClass("Highlight");
        local l_CurrentReplicatedLighting_0 = l_ReplicatedStorage_0:FindFirstChild("CurrentReplicatedLighting");
        local v36 = l_CurrentReplicatedLighting_0 and l_CurrentReplicatedLighting_0:FindFirstChildOfClass("Atmosphere");
        if not v36 then
            l_Highlight_0.Enabled = false;
            return;
        else
            if l_Highlight_0 then
                local v37, v38, v39 = v36.Color:ToHSV();
                local v40 = v39 * 0.5;
                l_Highlight_0.OutlineColor = Color3.fromRGB(v37, v38, v40);
            end;
            return;
        end;
    end;
end;
v25.OnIntroduction = function(_, v42, _, v44) --[[ Line: 127 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v30 (copy)
    task.spawn(function() --[[ Line: 128 ]]
        -- upvalues: v30 (ref), v42 (copy), v44 (copy)
        local v45 = v30(v42.Config.Videos.Intro, {
            DestroyOnEnd = true
        });
        game.Debris:AddItem(v45, v44);
    end);
end;
v25.OnVictory = function(_, v47, v48, _, _) --[[ Line: 135 ]] --[[ Name: OnVictory ]]
    -- upvalues: v30 (copy)
    if v47 == "Start" then
        local _ = v30(v48.Config.Videos.Outro);
        return;
    else
        if v47 == "End" then
            local l_IntroVideoUI_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("IntroVideoUI");
            if l_IntroVideoUI_0 then
                l_IntroVideoUI_0:Destroy();
            end;
        end;
        return;
    end;
end;
return v25;