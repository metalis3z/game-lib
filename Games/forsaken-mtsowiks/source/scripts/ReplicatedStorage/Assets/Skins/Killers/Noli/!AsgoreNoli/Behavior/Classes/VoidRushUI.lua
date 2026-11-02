-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: VoidRushUI, time of decompilation: Fri Nov 28 21:07:31 2025 ]]
local v0 = {};
v0.__index = v0;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Modules.Misc.RadialImage);
lerp = function(v5, v6, v7) --[[ Line: 13 ]] --[[ Name: lerp ]]
    return v5 + (v6 - v5) * v7;
end;
v0.new = function(v8) --[[ Line: 17 ]] --[[ Name: new ]]
    -- upvalues: l_RunService_0 (copy), v0 (copy), v4 (copy)
    assert(l_RunService_0:IsClient(), "VoidRushUI should not be created on the server.");
    if v8.Behavior.VoidRushUI then
        v8.Behavior.VoidRushUI:Destroy();
    end;
    local v9 = setmetatable({}, v0);
    v9.Frame = script.VoidRushBar:Clone();
    v9.Fill = script.VoidRushBarFill:Clone();
    v9.Text = v9.Frame.Title;
    v9.Radial = v4.new("{\"version\":1,\"size\":121,\"count\":120,\"columns\":8,\"rows\":8,\"images\":[\"rbxassetid://135944191173421\",\"rbxassetid://123902757620598\"]}", v9.Fill);
    v9.Actor = v8;
    v9.Frame.Parent = v8.Player.PlayerGui.TemporaryUI;
    v9.Fill.Parent = v9.Frame.Outline;
    v9.Fill.Visible = true;
    v9.Blinking = false;
    v9.BlinkSpeed = 10;
    v9.CurrentAlpha = 1;
    v9.BlinkingThread = task.spawn(function() --[[ Line: 46 ]]
        -- upvalues: v9 (copy), l_RunService_0 (ref)
        local l_VoidstarGlow_0 = v9.Frame.Outline.VoidstarGlow;
        local l_Voidstar_0 = v9.Frame.Outline.Voidstar;
        local _ = v9.Fill;
        local function _(v13) --[[ Line: 51 ]] --[[ Name: colorAll ]]
            -- upvalues: l_VoidstarGlow_0 (copy), l_Voidstar_0 (copy)
            l_VoidstarGlow_0.ImageColor3 = v13;
            l_Voidstar_0.ImageColor3 = v13;
        end;
        local v15 = 0;
        while v9 and not v9.Dead do
            if v9.Blinking then
                local v16 = (v9.CurrentAlpha + 0.5) / 1.5;
                local l_BlinkSpeed_0 = v9.BlinkSpeed;
                local v18 = v15 % l_BlinkSpeed_0 / l_BlinkSpeed_0;
                local v19 = Color3.fromRGB(255 - 50 * v18, 255 - 220 * v18, 255);
                v15 = v15 + l_RunService_0.RenderStepped:Wait() / v16;
                l_VoidstarGlow_0.ImageColor3 = v19;
                l_Voidstar_0.ImageColor3 = v19;
            else
                local v20 = Color3.new(1, 1, 1);
                l_VoidstarGlow_0.ImageColor3 = v20;
                l_Voidstar_0.ImageColor3 = v20;
                v15 = 0;
                l_RunService_0.RenderStepped:Wait();
            end;
            l_VoidstarGlow_0.ImageTransparency = 1 - v9.CurrentAlpha * 0.9;
        end;
    end);
    return v9;
end;
v0.SetText = function(v21, v22) --[[ Line: 81 ]] --[[ Name: SetText ]]
    v21.Text.Text = v22;
end;
v0.TweenRadial = function(v23, v24, v25, v26) --[[ Line: 85 ]] --[[ Name: TweenRadial ]]
    -- upvalues: l_RunService_0 (copy)
    if v23.Dead then
        return;
    else
        if v23.RadialTweenConnection then
            v23.RadialTweenConnection:Disconnect();
        end;
        v23.Radial:UpdateLabel(v25);
        local v27 = 0;
        v23.RadialTweenConnection = l_RunService_0.Heartbeat:Connect(function(v28) --[[ Line: 95 ]]
            -- upvalues: v27 (ref), v23 (copy), v24 (copy), v25 (copy), v26 (copy)
            if v27 == 1 or not v23 or not v23.Radial or v23.Dead then
                v23.RadialTweenConnection:Disconnect();
            end;
            v27 = math.clamp(v27 + v28 / v24, 0, 1);
            v23.CurrentAlpha = lerp(v25, v26, v27);
            v23.Radial:UpdateLabel(v23.CurrentAlpha);
        end);
        return;
    end;
end;
v0.FadeOut = function(v29, v30, v31) --[[ Line: 107 ]] --[[ Name: FadeOut ]]
    -- upvalues: l_TweenService_0 (copy)
    if v29.Dead then
        return;
    else
        v29.Actor.Behavior.VoidRushUI = nil;
        if v29.RadialTweenConnection then
            v29.RadialTweenConnection:Disconnect();
        end;
        v29.Dead = true;
        local v32 = v31 and Color3.new(0.5, 1, 0.5) or Color3.new(0.8, 0.2, 0.2);
        local l_Frame_0 = v29.Frame;
        local l_Fill_1 = v29.Fill;
        local _ = v29.Radial;
        for _, v37 in ipairs({
            l_Frame_0.Outline, 
            l_Frame_0.Outline.Background, 
            l_Frame_0.Outline.Voidstar, 
            l_Frame_0.Outline.VoidstarGlow, 
            l_Fill_1
        }) do
            l_TweenService_0:Create(v37, TweenInfo.new(v30), {
                BackgroundTransparency = 1, 
                ImageTransparency = 1
            }):Play();
        end;
        l_TweenService_0:Create(l_Frame_0.Title, TweenInfo.new(v30), {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        }):Play();
        l_Frame_0.Title.TextColor3 = v32;
        l_Fill_1.ImageColor3 = v32;
        task.delay(v30 + 0.1, function() --[[ Line: 134 ]]
            -- upvalues: v29 (copy)
            v29:Destroy();
        end);
        return;
    end;
end;
v0.Destroy = function(v38) --[[ Line: 139 ]] --[[ Name: Destroy ]]
    if v38.RadialTweenConnection then
        v38.RadialTweenConnection:Disconnect();
    end;
    if v38.Radial then
        v38.Radial:Destroy();
    end;
    if v38.Frame then
        v38.Frame:Destroy();
    end;
    v38 = nil;
end;
return v0;