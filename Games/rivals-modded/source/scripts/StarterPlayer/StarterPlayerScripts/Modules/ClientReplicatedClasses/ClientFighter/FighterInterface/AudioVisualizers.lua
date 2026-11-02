-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local AudioVisualizerIcon = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("AudioVisualizerIcon");
local u1 = { "rbxassetid://131616644976154", "rbxassetid://101856596290673", "rbxassetid://78940013186909" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 20
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.FighterInterface = p3;
    v4.Frame = v4.FighterInterface.Frame:WaitForChild("AudioVisualizers");
    v4._current_visualizers = {};
    v4:_Init();

    return v4;
end;

function u2.Create(u5, u6, u7, u8) -- Line: 38
    -- upvalues: AudioVisualizerIcon (copy), BetterDebris (copy), Spring (copy), u1 (copy), Utility (copy)
    if not u5.FighterInterface:IsActive() then
        return;
    end;

    local v9 = u5:_GetSourcePosition(u6);

    if not v9 then
        return;
    end;

    if u5.FighterInterface.ClientFighter.Entity and (v9 - u5.FighterInterface.ClientFighter.Entity.RootPart.Position).Magnitude <= 4 or u5:_GetEffectiveVolume(v9, u7, u8) <= 0 then
        return;
    end;

    for i, v in pairs(u5._current_visualizers) do
        if v.Source == u6 or v.Source2 == u6 then
            i:Destroy();
            u5._current_visualizers[i] = nil;
        end;
    end;

    local u10 = AudioVisualizerIcon:Clone();
    u10.Parent = u5.Frame;
    BetterDebris:AddItem(u10, 30);
    local u11 = false;
    local _ = workspace.CurrentCamera.CFrame;
    local u12 = v9;
    local u13 = Spring.new(0, 1, 40);
    local u14 = Spring.new(0.5, 1, 40);
    local u15 = nil;
    local u16 = 0;
    local u17 = 0;
    local u18 = false;

    local function update(p19) -- Line: 79
        -- upvalues: u5 (copy), u6 (copy), u18 (ref), u12 (ref), u10 (copy), u13 (copy), u14 (copy), u15 (ref), u11 (ref), AudioVisualizerIcon (ref), u7 (copy), u8 (copy), u17 (ref), u16 (ref), u1 (ref)
        local v20 = u5:_GetSourcePosition(u6);

        if v20 then
            u12 = u12;
        else
            u18 = true;
            v20 = u12;
        end;

        local CFrame = workspace.CurrentCamera.CFrame;
        local v21 = (v20 - CFrame.Position) * Vector3.new(1, 0, 1);
        local v22 = CFrame.LookVector * Vector3.new(1, 0, 1);
        local v23 = v22.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v22.Unit;

        if v21 ~= v21 or v21.Magnitude == 0 then
            u10.Visible = false;

            return;
        end;

        u10.Visible = true;
        local v24 = v21:Dot(v23) / v21.Magnitude;
        local math_acos_ret = math.acos(v24);
        local Y = v23:Cross(v21).Y;

        if math.sign(Y) == 1 then
            math_acos_ret = 6.283185307179586 - math_acos_ret or math_acos_ret;
        end;

        u13.Target = math_acos_ret + 1.5707963267948966;
        local v25 = 0.5 / math.max(1, (v21.Magnitude - 5) / 25);
        u14.Target = math.max(0.125, v25);

        if p19 then
            if u15 then
                local v26 = u13.Target - u15;

                if v26 > 3.141592653589793 then
                    local v27 = u13;
                    v27.Value = v27.Value + 6.283185307179586;
                elseif v26 < -3.141592653589793 then
                    local v28 = u13;
                    v28.Value = v28.Value - 6.283185307179586;
                end;
            end;
        else
            u14.Value = u14.Target;
            u13.Value = u13.Target;
        end;

        local v29 = Vector2.new(0.5, 0.5) - Vector2.new(math.cos(u13.Value), (math.sin(u13.Value))) * 0.75 / 2;
        u10.Position = UDim2.new(v29.X, 0, v29.Y, 0);
        u10.Rotation = math.deg(u13.Value - 1.5707963267948966);
        u10.Size = UDim2.new(u14.Value, 0, u14.Value, 0);

        if not u11 then
            u10.ImageTransparency = AudioVisualizerIcon.ImageTransparency + (1 - AudioVisualizerIcon.ImageTransparency) * (1 - u5:_GetEffectiveVolume(v20, u7, u8));
        end;

        u15 = u13.Target;

        if u17 < tick() then
            u17 = tick() + 0.04;
            u16 = u16 + 1;
            u10.Image = u1[u16 % #u1 + 1];
        end;
    end;

    local _current_visualizers = u5._current_visualizers;
    local v30 = {
        Source = u6,
        Update = update
    };
    local v31;

    if typeof(u6) == "Instance" then
        v31 = u6:IsA("Sound") and u6.Parent;
    else
        v31 = false;
    end;

    v30.Source2 = v31;
    _current_visualizers[u10] = v30;
    update(nil);
    wait(0);
    u11 = true;
    local ImageTransparency = u10.ImageTransparency;
    Utility:RenderstepForLoop(0, 100, 4, function(p32) -- Line: 167
        -- upvalues: u10 (copy), ImageTransparency (copy)
        u10.ImageTransparency = ImageTransparency + (1 - ImageTransparency) * (1 - (1 - p32 / 100) ^ 4);
    end);
    u10:Destroy();
    u5._current_visualizers[u10] = nil;
end;

function u2.Update(p33, p34, p35) -- Line: 175
    for _, v in pairs(p33._current_visualizers) do
        pcall(v.Update, p34);
    end;
end;

function u2.Clear(p36) -- Line: 181
    for i in pairs(p36._current_visualizers) do
        i:Destroy();
    end;

    p36._current_visualizers = {};
end;

function u2.Destroy(p37) -- Line: 189
    p37:Clear();
end;

function u2._GetSourcePosition(p38, p39) -- Line: 197
    if typeof(p39) == "Vector3" then
        return p39;
    end;

    if p39:IsA("BasePart") then
        return p39.Position;
    end;

    if p39.Parent and p39.Parent:IsA("BasePart") then
        return p39.Parent.Position;
    end;
end;

function u2._GetEffectiveVolume(p40, p41, p42, p43) -- Line: 207
    return (1 - math.clamp(((workspace.CurrentCamera.CFrame.Position - p41).Magnitude - p42) / (p43 - p42), 0, 1)) ^ 2;
end;

function u2._Init(p44) -- Line: 211
end;

return u2;