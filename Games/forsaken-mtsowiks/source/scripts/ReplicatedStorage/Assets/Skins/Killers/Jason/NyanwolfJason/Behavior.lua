-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:49 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local function v7(v3, v4) --[[ Line: 7 ]] --[[ Name: createVideoUI ]]
    local l_ScreenGui_0 = Instance.new("ScreenGui");
    l_ScreenGui_0.Name = "IntroVideoUI";
    l_ScreenGui_0.ResetOnSpawn = false;
    l_ScreenGui_0.IgnoreGuiInset = true;
    l_ScreenGui_0.ClipToDeviceSafeArea = false;
    l_ScreenGui_0.Parent = game.Players.LocalPlayer.PlayerGui;
    local l_VideoFrame_0 = Instance.new("VideoFrame");
    l_VideoFrame_0.BackgroundColor3 = Color3.new();
    l_VideoFrame_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_VideoFrame_0.Position = UDim2.fromScale(0.5, 0.5);
    l_VideoFrame_0.Size = UDim2.fromScale(1, 1);
    l_VideoFrame_0.Video = tostring(v3);
    l_VideoFrame_0.Parent = l_ScreenGui_0;
    if v4 then
        if v4.Looped then
            l_VideoFrame_0.Looped = true;
        elseif v4.DestroyOnEnd then
            l_VideoFrame_0.Ended:Connect(function() --[[ Line: 28 ]]
                -- upvalues: l_VideoFrame_0 (copy)
                l_VideoFrame_0:Destroy();
            end);
        end;
    end;
    l_VideoFrame_0:Play();
    return l_ScreenGui_0;
end;
v0.OnIntroduction = function(_, v9, _, v11) --[[ Line: 40 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v7 (copy)
    task.spawn(function() --[[ Line: 41 ]]
        -- upvalues: v7 (ref), v9 (copy), v11 (copy)
        local v12 = v7(v9.Config.Videos.Intro, {
            DestroyOnEnd = true
        });
        game.Debris:AddItem(v12, v11);
    end);
end;
v0.OnVictory = function(_, v14, v15, _, _) --[[ Line: 48 ]] --[[ Name: OnVictory ]]
    -- upvalues: v7 (copy)
    if v14 == "Start" then
        local _ = v7(v15.Config.Videos.Outro, {
            Looped = true
        });
        return;
    else
        if v14 == "End" then
            local l_IntroVideoUI_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("IntroVideoUI");
            if l_IntroVideoUI_0 then
                l_IntroVideoUI_0:Destroy();
            end;
        end;
        return;
    end;
end;
return v0;