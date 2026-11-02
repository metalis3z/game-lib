-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.Utility);
local StatusTextOverlay = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StatusTextOverlay");
local u1 = { "Text", "RichText", "FontFace", "TextXAlignment", "TextYAlignment", "TextTransparency" };
local u2 = { "ImageTransparency", "ScaleType", "Image" };
local ColorSequence_new_ret = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 255, 114)),
    ColorSequenceKeypoint.new(0.384, Color3.fromRGB(252, 251, 108)),
    ColorSequenceKeypoint.new(0.768, Color3.fromRGB(237, 186, 14)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 177, 2))
});
local ColorSequence_new_ret2 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(154, 114, 255)),
    ColorSequenceKeypoint.new(0.384, Color3.fromRGB(149, 108, 252)),
    ColorSequenceKeypoint.new(0.768, Color3.fromRGB(77, 14, 237)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 2, 235))
});
local Color3_fromRGB_ret = Color3.fromRGB(64, 64, 64);
local Color3_fromRGB_ret2 = Color3.fromRGB(127, 127, 127);
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 29
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4._connections = {};
    v4:_Init();

    return v4;
end;

function u3.ApplyItemStatusToText(p5, p6, p7) -- Line: 43
    -- upvalues: ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy)
    if p7 ~= "Prime" then
        if p7 == "Contraband" then
            local v8 = p5:_CreateTextOverlay(p6, ColorSequence_new_ret2);
            v8.Highlight:AddTag("UIGlitchEffect");
            v8.Shine.TextColor3 = Color3.fromRGB(0, 0, 0);
            v8.Shine:SetAttribute("IsDoubleFlash", true);
            v8.Shine:AddTag("UIShinyText");
        end;

        return;
    end;

    local v9 = p5:_CreateTextOverlay(p6, ColorSequence_new_ret);
    v9.Cover:Destroy();
    v9.Shine:AddTag("UISparkleEffect");
    v9.Shine:AddTag("UIShinyText");
end;

function u3.ApplyItemStatusToBackground(p10, p11, p12, p13) -- Line: 58
    p10:_RecolorBackground(p11, p12, p13);

    if p13 == "Prime" then
        p11:AddTag("UISparkleEffect");

        return;
    end;

    if p13 == "Contraband" then
        p11:AddTag("UIGlitchEffect");
    end;
end;

function u3.ApplyItemStatusToImage(p14, p15, p16) -- Line: 68
    -- upvalues: ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy)
    if p16 == "Prime" then
        p14:_CreateImageOverlay(p15, ColorSequence_new_ret):AddTag("UISparkleEffect");

        return;
    end;

    if p16 == "Contraband" then
        p14:_CreateImageOverlay(p15, ColorSequence_new_ret2):AddTag("UIGlitchEffect");
    end;
end;

function u3.ClearStatusElements(p17, p18) -- Line: 78
    for _, child in pairs(p18:GetChildren()) do
        if child:HasTag("WeaponStatusElement") then
            child:Destroy();
        end;
    end;
end;

function u3._CreateTextOverlay(p19, p20, p21) -- Line: 90
    -- upvalues: StatusTextOverlay (copy), u1 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local v22 = StatusTextOverlay:Clone();
    v22.Highlight.UIGradient.Color = p21;
    p19:_CopyElement(v22.Cover, p20, u1);
    p19:_CopyElement(v22.Highlight, p20, u1);
    p19:_CopyElement(v22.Shine, p20, u1);
    p19:_TagStatusElement(v22);
    v22.Parent = p20;
    local Highlight = v22.Highlight;
    local UIStroke = Highlight.UIStroke;

    local function update() -- Line: 102
        -- upvalues: UIStroke (copy), Highlight (copy), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref)
        UIStroke.Transparency = Highlight.TextTransparency;
        UIStroke.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, (math.clamp(Highlight.TextTransparency / 0.25, 0, 1)));
    end;

    Highlight:GetPropertyChangedSignal("TextTransparency"):Connect(update);
    UIStroke.Transparency = Highlight.TextTransparency;
    UIStroke.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, (math.clamp(Highlight.TextTransparency / 0.25, 0, 1)));

    return v22;
end;

function u3._CreateImageOverlay(p23, p24, p25) -- Line: 113
    -- upvalues: u2 (copy)
    local Instance_fromExisting_ret = Instance.fromExisting(p24);
    Instance_fromExisting_ret.Size = UDim2.new(1, 0, 1, 0);
    Instance_fromExisting_ret.AnchorPoint = Vector2.new(0.5, 0.5);
    Instance_fromExisting_ret.Position = UDim2.new(0.5, 0, 0.5, 0);
    Instance_fromExisting_ret.Active = false;
    Instance_fromExisting_ret.Interactable = false;
    Instance_fromExisting_ret.Selectable = false;
    Instance_fromExisting_ret.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    Instance_fromExisting_ret.ImageColor3 = Color3.fromRGB(255, 255, 255);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Color = p25;
    UIGradient.Parent = Instance_fromExisting_ret;
    p23:_CopyElement(Instance_fromExisting_ret, p24, u2);
    p23:_TagStatusElement(Instance_fromExisting_ret);
    Instance_fromExisting_ret.Parent = p24;

    return Instance_fromExisting_ret;
end;

function u3._RecolorBackground(p26, p27, p28, p29) -- Line: 137
    -- upvalues: ItemLibrary (copy)
    local v30 = ItemLibrary.Statuses[p29];

    if not v30 then
        return;
    end;

    if p27:IsA("ImageLabel") then
        p27.ImageColor3 = v30.Color;
    end;

    p27.BackgroundColor3 = v30.Color;
    p28.Color = v30.Color;
end;

function u3._TagStatusElement(p31, p32) -- Line: 152
    p32:AddTag("WeaponStatusElement");
    p32.Name = "_ITEMSTATUSCLONE";
end;

function u3._CopyElement(u33, u34, u35, p36) -- Line: 157
    if not u33._connections[u34] then
        u33._connections[u34] = {};
        table.insert(u33._connections[u34], u34.Destroying:Connect(function() -- Line: 161
            -- upvalues: u33 (copy), u34 (copy)
            for _, v in pairs(u33._connections[u34] or {}) do
                v:Disconnect();
            end;

            u33._connections[u34] = nil;
        end));
    end;

    for _, v in pairs(p36) do
        local v37 = u33._connections[u34];
        local PropertyChangedSignal = u35:GetPropertyChangedSignal(v);
        table.insert(v37, PropertyChangedSignal:Connect(function() -- Line: 171, Name: update
            -- upvalues: u34 (copy), v (copy), u35 (copy)
            u34[v] = u35[v];
        end));
        u34[v] = u35[v];
    end;
end;

function u3._ObjectAdded(p38, p39) -- Line: 180
    -- upvalues: ItemLibrary (copy)
    local Attribute = p39:GetAttribute("Status");
    assert(ItemLibrary.Statuses[Attribute] ~= nil, p39:GetFullName());
    p38:ClearStatusElements(p39);

    if p39:IsA("TextLabel") then
        p38:ApplyItemStatusToText(p39, Attribute);

        return;
    end;

    assert(false, p39:GetFullName());
end;

function u3._Init(u40) -- Line: 194
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("ApplyWeaponStatus"):Connect(function(p41) -- Line: 195
        -- upvalues: u40 (copy)
        u40:_ObjectAdded(p41);
    end);

    for _, v in pairs(CollectionService:GetTagged("ApplyWeaponStatus")) do
        task.defer(u40._ObjectAdded, u40, v);
    end;
end;

return u3._new();