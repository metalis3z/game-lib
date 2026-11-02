-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 10
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._UpdateCoreGuiBackground(p3, p4) -- Line: 28
    -- upvalues: UILibrary (copy)
    if p4:IsA("Frame") then
        p4.BackgroundColor3 = UILibrary.BUTTON_BACKGROUND_COLOR;
        p4.BackgroundTransparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;

        return;
    end;

    if not p4:IsA("ImageLabel") then
        if p4:IsA("UIStroke") then
            p4.Color = UILibrary.BUTTON_BACKGROUND_COLOR;
            p4.Transparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;
        end;

        return;
    end;

    p4.ImageColor3 = UILibrary.BUTTON_BACKGROUND_COLOR;
    p4.ImageTransparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;
end;

function u1._UpdateElementSimple(p5, p6) -- Line: 41
    -- upvalues: GuiService (copy)
    local PreferredTransparency = GuiService.PreferredTransparency;
    local v7 = p6:GetAttribute("BaseTransparency") or 1;
    p6[p6:IsA("Frame") and "BackgroundTransparency" or "ImageTransparency"] = 0 + (v7 - 0) * PreferredTransparency;
    local Attribute = p6:GetAttribute("TransparentColor");
    local Attribute2 = p6:GetAttribute("OpaqueColor");

    if Attribute and Attribute2 then
        p6[p6:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = Attribute2:Lerp(Attribute, PreferredTransparency);
    end;
end;

function u1._UpdateElement(p8, p9) -- Line: 55
    -- upvalues: GuiService (copy)
    local UIGradient = p9:WaitForChild("UIGradient");
    local PreferredTransparency = GuiService.PreferredTransparency;
    p9.ImageTransparency = 0 + 0.25 * PreferredTransparency;
    p9.ImageColor3 = Color3.fromRGB(31, 31, 31):Lerp(Color3.fromRGB(0, 0, 0), PreferredTransparency);
    UIGradient.Transparency = NumberSequence.new(0, 0 + 0.5 * PreferredTransparency);
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(127, 127, 127):Lerp(Color3.fromRGB(255, 255, 255), PreferredTransparency), Color3.fromRGB(255, 255, 255));
end;

function u1._UpdateAllElements(p10) -- Line: 65
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("UIBackground")) do
        p10:_UpdateElement(v);
    end;

    for _, v in pairs(CollectionService:GetTagged("UIBackgroundSimple")) do
        p10:_UpdateElementSimple(v);
    end;
end;

function u1._Init(u11) -- Line: 75
    -- upvalues: CollectionService (copy), GuiService (copy)
    CollectionService:GetInstanceAddedSignal("UIBackground"):Connect(function(p12) -- Line: 76
        -- upvalues: u11 (copy)
        u11:_UpdateElement(p12);
    end);
    CollectionService:GetInstanceAddedSignal("UIBackgroundSimple"):Connect(function(p13) -- Line: 80
        -- upvalues: u11 (copy)
        u11:_UpdateElementSimple(p13);
    end);
    CollectionService:GetInstanceAddedSignal("CoreGuiBackground"):Connect(function(p14) -- Line: 84
        -- upvalues: u11 (copy)
        u11:_UpdateCoreGuiBackground(p14);
    end);
    GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 88
        -- upvalues: u11 (copy)
        u11:_UpdateAllElements();
    end);

    for _, v in pairs(CollectionService:GetTagged("CoreGuiBackground")) do
        u11:_UpdateCoreGuiBackground(v);
    end;

    task.defer(u11._UpdateAllElements, u11);
end;

return u1._new();