-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Communication_0 = l_ReplicatedStorage_0:WaitForChild("Communication");
local l_Inactivity_0 = l_Communication_0:WaitForChild("Inactivity");
local l_ActivePing_0 = l_Communication_0:WaitForChild("ActivePing");
local l_RequestAFKReturnTeleport_0 = l_Communication_0:WaitForChild("RequestAFKReturnTeleport");
local v10 = tick();
local v11 = false;
local v12 = false;
local v13 = true;
local v14 = false;
local v15 = false;
local v16 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_HumanoidRootPart_0 = v16:WaitForChild("HumanoidRootPart");
l_LocalPlayer_0.CharacterAdded:Connect(function(v18) --[[ Line: 43 ]]
    -- upvalues: v16 (ref), l_HumanoidRootPart_0 (ref), v15 (ref)
    v16 = v18;
    l_HumanoidRootPart_0 = v18:WaitForChild("HumanoidRootPart");
    if v15 then
        l_HumanoidRootPart_0.Anchored = true;
    end;
end);
local function _() --[[ Line: 52 ]] --[[ Name: anchorPlayer ]]
    -- upvalues: l_HumanoidRootPart_0 (ref), v15 (ref)
    if l_HumanoidRootPart_0 and not v15 then
        v15 = true;
        l_HumanoidRootPart_0.Anchored = true;
    end;
end;
local function _() --[[ Line: 59 ]] --[[ Name: unanchorPlayer ]]
    -- upvalues: l_HumanoidRootPart_0 (ref), v15 (ref)
    if l_HumanoidRootPart_0 and v15 then
        v15 = false;
        l_HumanoidRootPart_0.Anchored = false;
    end;
end;
local l_Instrumental_0 = script.Instrumental;
local v22 = {
    Speed = 0.8, 
    StartTime = 2, 
    EndOffset = 0.5
};
l_Instrumental_0.TimePosition = v22.StartTime;
l_Instrumental_0.Volume = 0.26;
l_Instrumental_0:Play();
local function v24(v23) --[[ Line: 75 ]] --[[ Name: tweenMusicVolume ]]
    -- upvalues: l_TweenService_0 (copy), l_Instrumental_0 (copy)
    l_TweenService_0:Create(l_Instrumental_0, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
        Volume = v23
    }):Play();
end;
local function v25() --[[ Line: 82 ]] --[[ Name: onInput ]]
    -- upvalues: v10 (ref), v12 (ref), v14 (ref), v13 (ref), v24 (copy), v11 (ref), l_ActivePing_0 (copy), l_HumanoidRootPart_0 (ref), v15 (ref)
    v10 = tick();
    v12 = false;
    if v14 then
        v14 = false;
        if v13 then
            v24(0.26);
        end;
    end;
    if v11 then
        v11 = false;
        l_ActivePing_0:FireServer(true);
    end;
    if l_HumanoidRootPart_0 and v15 then
        v15 = false;
        l_HumanoidRootPart_0.Anchored = false;
    end;
end;
l_UserInputService_0.InputBegan:Connect(v25);
l_UserInputService_0.InputChanged:Connect(v25);
l_UserInputService_0.InputEnded:Connect(v25);
l_UserInputService_0.WindowFocusReleased:Connect(function() --[[ Line: 106 ]]
    -- upvalues: v13 (ref), v24 (copy)
    v13 = false;
    v24(0);
end);
l_UserInputService_0.WindowFocused:Connect(function() --[[ Line: 111 ]]
    -- upvalues: v13 (ref), v14 (ref), v24 (copy)
    v13 = true;
    if v14 then
        v24(0.07);
        return;
    else
        v24(0.26);
        return;
    end;
end);
task.spawn(function() --[[ Line: 121 ]]
    -- upvalues: v10 (ref), l_ActivePing_0 (copy)
    while true do
        task.wait(20);
        if tick() - v10 < 60 then
            l_ActivePing_0:FireServer(false);
        end;
    end;
end);
task.spawn(function() --[[ Line: 130 ]]
    -- upvalues: v10 (ref), v14 (ref), v13 (ref), v24 (copy), v11 (ref), l_Inactivity_0 (copy), l_HumanoidRootPart_0 (ref), v15 (ref), v12 (ref), l_RequestAFKReturnTeleport_0 (copy)
    while true do
        task.wait(1);
        local v26 = tick() - v10;
        if v26 >= 60 and not v14 then
            v14 = true;
            if v13 then
                v24(0.07);
            end;
        end;
        if not v11 and v26 >= 900 then
            v11 = true;
            l_Inactivity_0:FireServer();
            if l_HumanoidRootPart_0 and not v15 then
                v15 = true;
                l_HumanoidRootPart_0.Anchored = true;
            end;
        end;
        if not v12 and v26 >= 1080 then
            v12 = true;
            warn("AFK auto-rejoin triggered");
            task.wait(0.5);
            l_RequestAFKReturnTeleport_0:FireServer();
        end;
    end;
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 164 ]]
    -- upvalues: l_Instrumental_0 (copy), v22 (copy)
    if l_Instrumental_0.TimeLength - v22.EndOffset <= l_Instrumental_0.TimePosition then
        l_Instrumental_0.TimePosition = v22.StartTime;
    end;
end);