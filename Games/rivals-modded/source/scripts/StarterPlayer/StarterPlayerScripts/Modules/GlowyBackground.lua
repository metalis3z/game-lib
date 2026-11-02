-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local RenderstepForLoop = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Utility"):WaitForChild("RenderstepForLoop"));
local EventLibrary = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("EventLibrary"));
local GlowyBackground = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("UserInterface"):WaitForChild("GlowyBackground");
local u1 = { "Black", "Yellow", "Purple", "Purple2" };
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 24
    -- upvalues: u2 (copy), GlowyBackground (copy)
    local v4 = setmetatable({}, u2);
    v4.Frame = GlowyBackground:Clone();
    v4._name = p3;
    v4._backdrop_transparency = 0;
    v4._elements = {};
    v4._blur = Instance.new("BlurEffect");
    v4._colorcorrection = Instance.new("ColorCorrectionEffect");
    v4._is_enabled = false;
    v4._current_hash = 0;
    v4._start = tick();
    v4._start_transparencies = {};
    v4._connection = nil;
    v4._fade_in_alpha = 1;
    v4:_Init();

    return v4;
end;

function u2.SetParent(p5, p6) -- Line: 50
    p5.Frame.Parent = p6;
end;

function u2.SetBlurEnabled(p7, p8) -- Line: 54
    p7._blur.Enabled = p8;

    if not p7._blur.Enabled then
        p7._blur.Size = 0;
    end;
end;

function u2.SetBackdropTransparency(p9, p10) -- Line: 62
    p9._backdrop_transparency = p10;
    p9:_UpdateElementsTransparency();
end;

function u2.DisableElement(p11, p12, p13) -- Line: 67
    p11._elements[p12].IsDisabled = p13;
    p11:_UpdateElementsTransparency();
end;

function u2.SetEnabled(p14, p15, p16) -- Line: 72
    if p14._is_enabled == p15 and not p16 then
        return;
    end;

    p14._is_enabled = p15;
    task.spawn(p14._Update, p14, p16);
    p14:_UpdateElementsTransparency();
end;

function u2.SetColor(p17, p18, p19) -- Line: 82
    if not p17._elements[p18] then
        return;
    end;

    p17._elements[p18].Object.ImageColor3 = p19 or p17._elements[p18].OriginalColor;
end;

function u2.Destroy(p20) -- Line: 92
    p20.Frame:Destroy();
    p20._blur:Destroy();
    p20._colorcorrection:Destroy();
    p20._current_hash = p20._current_hash + 1;
end;

function u2._GetTransparency(p21, p22, p23, p24) -- Line: 103
    p21._start_transparencies[p22] = p21._start_transparencies[p22] or p22[p23];
    local v25 = p21._start_transparencies[p22];

    return v25 + ((not p21._is_enabled and 1 or p24) - v25) * (1 - (1 - p21._fade_in_alpha) ^ 4);
end;

function u2._UpdateElementsTransparency(p26) -- Line: 115
    p26.Frame.BackgroundTransparency = p26:_GetTransparency(p26.Frame, "BackgroundTransparency", p26._backdrop_transparency);

    for _, v in pairs(p26._elements) do
        v.Object.ImageTransparency = p26:_GetTransparency(v.Object, "ImageTransparency", v.IsDisabled and 1 or v.OriginalTransparency);
    end;
end;

function u2._Update(u27, p28) -- Line: 123
    -- upvalues: RunService (copy), RenderstepForLoop (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    for _, v in pairs(u27._elements) do
        v.Direction = Vector2.new(math.random() - 0.5, math.random() - 0.5).Unit;
        v.Speed = 0.0125 + 0.025 * math.random();
    end;

    u27._start_transparencies = {};
    u27._current_hash = u27._current_hash + 1;
    local _current_hash = u27._current_hash;
    local v29 = {};

    for _, v in pairs(u27._elements) do
        v29[v.Object] = v.Object.ImageTransparency;
    end;

    if u27._is_enabled and not u27._connection then
        u27._connection = RunService.RenderStepped:Connect(function() -- Line: 142
            -- upvalues: u27 (copy)
            local v30 = tick() - u27._start;

            for _, v in pairs(u27._elements) do
                local v31 = v.Direction * v30;
                v.Object.Position = UDim2.new(0.5, v.Object.TileSize.X.Offset * v31.X * v.Speed % v.Object.TileSize.X.Offset, 0.5, v.Object.TileSize.Y.Offset * v31.Y % 1 * v.Speed % v.Object.TileSize.Y.Offset);
            end;
        end);
    elseif not u27._is_enabled and u27._connection then
        u27._connection:Disconnect();
        u27._connection = nil;
    end;

    if p28 then
        u27._fade_in_alpha = 1;
        u27:_UpdateElementsTransparency();
    else
        task.spawn(RenderstepForLoop, (1 - u27._fade_in_alpha) * 100, 100, u27._is_enabled and 0.5 or 1, function(p32) -- Line: 165
            -- upvalues: _current_hash (copy), u27 (copy)
            if _current_hash ~= u27._current_hash then
                return true;
            end;

            u27._fade_in_alpha = p32 / 100;
            u27:_UpdateElementsTransparency();
        end);
    end;

    local TintColor = u27._colorcorrection.TintColor;
    local Contrast = u27._colorcorrection.Contrast;
    local Brightness = u27._colorcorrection.Brightness;
    local Size = u27._blur.Size;
    local u33 = u27._is_enabled and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
    local u34 = u27._is_enabled and -0.3 or 0;
    local _ = u27._is_enabled;
    local u35 = 0;
    local u36 = u27._is_enabled and 24 or 0;

    local function set(p37) -- Line: 186
        -- upvalues: u27 (copy), Size (copy), u36 (copy), Brightness (copy), u34 (copy), Contrast (copy), u35 (copy), TintColor (copy), u33 (copy)
        local math_clamp_ret = math.clamp(1 - (1 - p37) ^ 5, 0, 1);
        u27._blur.Size = not u27._blur.Enabled and 0 or Size + (u36 - Size) * math_clamp_ret;
        u27._colorcorrection.Brightness = Brightness + (u34 - Brightness) * math_clamp_ret;
        u27._colorcorrection.Contrast = Contrast + (u35 - Contrast) * math_clamp_ret;
        u27._colorcorrection.TintColor = TintColor:Lerp(u33, math_clamp_ret);
    end;

    if not p28 then
        task.spawn(RenderstepForLoop, 0, 100, 2, function(p38) -- Line: 198
            -- upvalues: _current_hash (copy), u27 (copy), set (copy)
            if _current_hash ~= u27._current_hash then
                return true;
            end;

            set(p38 / 100);
        end);

        return;
    end;

    u27._blur.Size = not u27._blur.Enabled and 0 or Size + (u36 - Size) * 1;
    u27._colorcorrection.Brightness = Brightness + (u34 - Brightness) * 1;
    u27._colorcorrection.Contrast = Contrast + (u35 - Contrast) * 1;
    u27._colorcorrection.TintColor = TintColor:Lerp(u33, 1);
end;

function u2._Setup(p39) -- Line: 208
    -- upvalues: Lighting (copy), u1 (copy), EventLibrary (copy)
    p39._blur.Size = 0;
    p39._blur.Name = "GlowyBackgroundBlur - " .. p39._name;
    p39._blur.Parent = Lighting;
    p39._colorcorrection.Name = "GlowyBackgroundColorCorrection - " .. p39._name;
    p39._colorcorrection.Parent = Lighting;
    p39.Frame.BackgroundTransparency = 1;

    for _, v in pairs(u1) do
        local v40 = p39.Frame:WaitForChild(v);
        p39._elements[v] = {
            Direction = nil,
            Speed = nil,
            IsDisabled = false,
            Object = v40,
            OriginalColor = v40.ImageColor3,
            OriginalTransparency = v40.ImageTransparency
        };
        v40.ImageTransparency = 1;
    end;

    for i, v in pairs(EventLibrary.IS_ACTIVE and EventLibrary.EVENT_DETAILS.GLOWY_BACKGROUND_COLOR_OVERRIDES or {}) do
        p39:SetColor(i, v);
    end;
end;

function u2._Init(p41) -- Line: 238
    p41:_Setup();
    p41:_UpdateElementsTransparency();
    p41:SetEnabled(false, true);
    p41:SetBackdropTransparency(0);
end;

return u2;