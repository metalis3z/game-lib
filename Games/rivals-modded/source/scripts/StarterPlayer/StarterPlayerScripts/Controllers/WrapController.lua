-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local u1 = CONSTANTS.IS_CLIENT and CONSTANTS.IS_RUNNING and Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("WrapTextures");
local WrapGroupObjects = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WrapGroupObjects");
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 17
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._wrap_group_callbacks = {};
    v3._wrap_group_classes = {};
    v3._wrap_group_objects = {};
    v3._wrap_group_objects_count = {};
    v3._preloaded_wrap_group_objects = {};
    v3._preload_screen_gui = Instance.new("ScreenGui");
    v3:_Init();

    return v3;
end;

function u2.RecordOriginalWrapProperties(p4, p5) -- Line: 36
    local v6 = {};
    local v7;

    if typeof(p5) == "table" then
        v7 = p5;
    else
        v7 = p5:GetDescendants();
        table.insert(v7, p5);
    end;

    for _, v in pairs(v7) do
        if v:HasTag("Wrappable") then
            local v8 = nil;
            local v9;

            if v:IsA("BasePart") then
                v9 = {
                    Material = v.Material,
                    MaterialVariant = v.MaterialVariant,
                    Color = v.Color,
                    Transparency = v.Transparency,
                    Reflectance = v.Reflectance
                };

                if v:IsA("MeshPart") then
                    v9.TextureID = v.TextureID;
                end;
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v9 = {
                    Color3 = v.Color3,
                    Transparency = v.Transparency
                };
            elseif v:IsA("Beam") or (v:IsA("Trail") or v:IsA("ParticleEmitter")) then
                v9 = {
                    Color = v.Color,
                    Transparency = v.Transparency,
                    LightEmission = v.LightEmission
                };
            elseif v:IsA("Frame") then
                v9 = {
                    BackgroundColor3 = v.BackgroundColor3,
                    BackgroundTransparency = v.BackgroundTransparency
                };
            elseif v:IsA("ImageLabel") then
                v9 = {
                    ImageColor3 = v.ImageColor3,
                    ImageTransparency = v.ImageTransparency
                };
            elseif v:IsA("Light") then
                v9 = {
                    Color = v.Color,
                    Brightness = v.Brightness
                };
            else
                v9 = (v:IsA("RopeConstraint") or v:IsA("SpringConstraint")) and {
                    Color = v.Color
                } or v8;
            end;

            if v9 then
                v6[v] = {
                    WrapGroup = v:GetAttribute("WrapGroup"),
                    IgnoreTransparency = v:GetAttribute("IgnoreTransparency"),
                    IgnoreMaterial = v:GetAttribute("IgnoreMaterial"),
                    IgnoreObject = v:GetAttribute("IgnoreObject"),
                    OriginalProperties = v9,
                    OriginalChildren = {},
                    Cleanup = {}
                };
                local v10 = v;

                for _, child in pairs(v:GetChildren()) do
                    if child:IsA("SurfaceAppearance") then
                        table.insert(v6[v10].OriginalChildren, child);
                    end;
                end;

                local v11 = v6[v10].WrapGroup and typeof(v6[v10].WrapGroup) == "number";
                assert(v11, v10:GetFullName());
            end;
        end;
    end;

    return v6;
end;

function u2.ResetWrap(p12, p13) -- Line: 122
    if not p13 then
        return;
    end;

    for i, v in pairs(p13) do
        local v14 = v;
        local u15 = i;

        for i2, v2 in pairs(v.OriginalProperties) do
            u15[i2] = v2;
        end;

        for _, v2 in pairs(v14.OriginalChildren) do
            pcall(function() -- Line: 133
                -- upvalues: v2 (copy), u15 (copy)
                v2.Parent = u15;
            end);
        end;

        for _, v2 in pairs(v14.Cleanup) do
            v2:Destroy();
        end;

        v14.Cleanup = {};
    end;
end;

function u2.ApplyWrap(p16, p17, p18, p19, p20) -- Line: 146
    -- upvalues: CosmeticLibrary (copy), u1 (copy)
    p16:ResetWrap(p17);

    if not p18 or p18.Name == "RANDOM_COSMETIC" then
        return;
    end;

    local v21 = CosmeticLibrary.Cosmetics[p18.Name];
    local Inverted = p18.Inverted;

    for i, v in pairs(p17) do
        if not (p20 and p20[i]) then
            local v22;

            if Inverted then
                v22 = v.WrapGroup == 1 and 2 or (v.WrapGroup == 2 and 1 or v.WrapGroup);
            else
                v22 = v.WrapGroup;
            end;

            local v23 = v21.WrapGroups[v22] or {};
            local v24 = p19 or v.IgnoreTransparency;
            local IgnoreMaterial = v.IgnoreMaterial;
            local IgnoreObject = v.IgnoreObject;
            local v25 = {};
            local v26, v27;

            if i:IsA("BasePart") then
                i.Color = v23.Color or i.Color;
                i.Transparency = not v24 and v23.Transparency or i.Transparency;
                i.Reflectance = v23.Reflectance or i.Reflectance;
                i.Material = not (IgnoreMaterial or v24 and v23.Material == Enum.Material.ForceField) and v23.Material or i.Material;
                i.MaterialVariant = not IgnoreMaterial and v23.MaterialVariant or i.MaterialVariant;

                if i:IsA("MeshPart") then
                    i.TextureID = "";
                end;

                if IgnoreMaterial then
                    v26 = v;
                    v27 = i;
                else
                    v26 = v;
                    v27 = i;

                    for _, v2 in pairs(v23.Textures and (u1[v23.Textures]:GetChildren() or {}) or {}) do
                        local v28 = v2:Clone();
                        v28.LocalTransparencyModifier = v27.LocalTransparencyModifier;
                        v28.Parent = v27;
                        table.insert(v26.Cleanup, v28);
                        table.insert(v25, v28);
                    end;
                end;
            elseif i:IsA("Decal") or i:IsA("Texture") then
                i.Color3 = v23.Color3 or i.Color3;
                i.Transparency = not v24 and v23.Transparency or i.Transparency;
                v26 = v;
                v27 = i;
            elseif i:IsA("Beam") or (i:IsA("Trail") or i:IsA("ParticleEmitter")) then
                i.Color = v23.Color and ColorSequence.new(v23.Color) or i.Color;
                v26 = v;
                v27 = i;
            elseif i:IsA("Frame") then
                i.BackgroundColor3 = v23.Color or i.BackgroundColor3;
                i.BackgroundTransparency = not v24 and v23.Transparency or i.BackgroundTransparency;
                v26 = v;
                v27 = i;
            elseif i:IsA("ImageLabel") then
                i.ImageColor3 = v23.Color or i.ImageColor3;
                i.ImageTransparency = not v24 and v23.Transparency or i.ImageTransparency;
                v26 = v;
                v27 = i;
            elseif i:IsA("Light") then
                i.Color = v23.Color or i.Color;
                i.Brightness = i.Brightness + (0 - i.Brightness) * (v24 and 0 or (v23.Transparency or 0));
                v26 = v;
                v27 = i;
            elseif i:IsA("RopeConstraint") or i:IsA("SpringConstraint") then
                i.Color = v23.Color and BrickColor.new(v23.Color) or i.Color;
                v26 = v;
                v27 = i;
            else
                v26 = v;
                v27 = i;
            end;

            for _, v2 in pairs(v26.OriginalChildren) do
                pcall(function() -- Line: 225
                    -- upvalues: v2 (copy)
                    v2.Parent = nil;
                end);
            end;

            if not IgnoreObject then
                local v29 = p16:_GetWrapGroupObject(v23);

                if v29 then
                    local v30 = v29.new(v23.ObjectName, v27, v25);
                    table.insert(p16._wrap_group_objects, v30);
                    table.insert(v26.Cleanup, v30);
                    p16:_IncrementWrapGroupObjectsCount(v30.Name, 1, v30);
                end;
            end;
        end;
    end;
end;

function u2.Update(p31, p32) -- Line: 243
    -- upvalues: CONSTANTS (copy)
    for i = #p31._wrap_group_objects, 1, -1 do
        local v33 = p31._wrap_group_objects[i];
        local v34;

        if v33.IsDestroyed then
            table.remove(p31._wrap_group_objects, i);
            p31:_IncrementWrapGroupObjectsCount(v33.Name, -1, v33);
            v34 = i;
        elseif v33.Update and v33:IsActive() then
            if CONSTANTS.IS_STUDIO then
                v33:Update(p32);
                v34 = i;
            else
                pcall(v33.Update, v33, p32);
                v34 = i;
            end;
        else
            v34 = i;
        end;
    end;
end;

function u2._IncrementWrapGroupObjectsCount(p35, p36, p37, p38) -- Line: 264
    local v39 = (p35._wrap_group_objects_count[p36] or 0) + p37;
    local v40;

    if v39 <= 0 then
        v40 = nil;
    else
        v40 = v39;
    end;

    p35._wrap_group_objects_count[p36] = v40;

    if v39 ~= 1 then
        if not v39 then
            for _, v in pairs(p35._preloaded_wrap_group_objects[p36] and (p35._preloaded_wrap_group_objects[p36].Textures or {}) or {}) do
                task.defer(v.Destroy, v);
            end;

            p35._preloaded_wrap_group_objects[p36] = nil;
        end;

        return;
    end;

    local v41 = p38.GetPreloadedImageIDs and p38:GetPreloadedImageIDs();

    if not v41 or #v41 == 0 then
        return;
    end;

    p35._preloaded_wrap_group_objects[p36] = p35._preloaded_wrap_group_objects[p36] or {};
    p35._preloaded_wrap_group_objects[p36].Textures = p35._preloaded_wrap_group_objects[p36].Textures or {};

    for i, v in pairs(v41) do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Active = false;
        ImageLabel.Size = UDim2.new(0, 1, 0, 1);
        ImageLabel.ImageTransparency = 0.99;
        ImageLabel.Image = v;
        ImageLabel.Name = p36 .. " - " .. i;
        ImageLabel.Parent = p35._preload_screen_gui;
        table.insert(p35._preloaded_wrap_group_objects[p36].Textures, ImageLabel);
    end;
end;

function u2._GetWrapGroupObject(p42, p43) -- Line: 299
    -- upvalues: WrapGroupObjects (copy)
    if p43.ObjectName then
        if not p42._wrap_group_classes[p43.ObjectName] then
            p42._wrap_group_classes[p43.ObjectName] = require(WrapGroupObjects:WaitForChild(p43.ObjectName));
        end;

        return p42._wrap_group_classes[p43.ObjectName];
    end;
end;

function u2._WrapThis(p44, p45) -- Line: 311
    p44:ApplyWrap(p44:RecordOriginalWrapProperties(p45), {
        Name = p45:GetAttribute("WrapName")
    });
end;

function u2._Setup(p46) -- Line: 315
    -- upvalues: Players (copy)
    p46._preload_screen_gui.Name = "PreloadedWrapTextures";
    p46._preload_screen_gui.ResetOnSpawn = false;
    p46._preload_screen_gui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u2._Init(u47) -- Line: 321
    -- upvalues: RunService (copy), CollectionService (copy)
    RunService:BindToRenderStep("WrapController", Enum.RenderPriority.Camera.Value + 1, function(p48) -- Line: 322
        -- upvalues: u47 (copy)
        u47:Update(p48);
    end);
    CollectionService:GetInstanceAddedSignal("WrapThis"):Connect(function(p49) -- Line: 326
        -- upvalues: u47 (copy)
        u47:_WrapThis(p49);
    end);

    for _, v in pairs(CollectionService:GetTagged("WrapThis")) do
        task.defer(u47._WrapThis, u47, v);
    end;

    u47:_Setup();
end;

return u2._new();