-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local StaticModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel);
local Charm = require(Players.LocalPlayer.PlayerScripts.Modules.Charm);
local Charms = Players.LocalPlayer.PlayerScripts.Modules.Charms;
local ViewModels = Players.LocalPlayer.PlayerScripts.Assets.ViewModels;
local u1 = setmetatable({}, StaticModel);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 18
    -- upvalues: StaticModel (copy), Utility (copy), ViewModels (copy), u1 (copy), CosmeticLibrary (copy), ItemLibrary (copy)
    local v4 = StaticModel.new(Utility:LookThrough(ViewModels, p2):Clone());
    local v5 = setmetatable(v4, u1);
    v5.Name = p2;
    local v6 = CosmeticLibrary.Cosmetics[v5.Name] and CosmeticLibrary.Cosmetics[v5.Name].ItemName;

    if not v6 then
        if ItemLibrary.Items[v5.Name] then
            v6 = v5.Name or nil;
        else
            v6 = nil;
        end;
    end;

    v5.WeaponName = v6;
    v5.Charm = nil;
    v5.Wrap = nil;
    v5._submodel_to_grip_attachment = {};
    v5._grip_attachment_to_limb = {};
    v5._charm_scale_multiplier = 1;
    v5._charm_attachment_model = v5.Model:FindFirstChild("_charm_attachment_model", true);
    v5._charm_attachment_model_parent = v5._charm_attachment_model and v5._charm_attachment_model.Parent;
    v5._charm_pivot_attachment = v5._charm_attachment_model and v5._charm_attachment_model:FindFirstChild("_charm_pivot_attachment", true) or v5.Model:FindFirstChild("_charm_pivot_attachment", true);
    v5._original_wrap_properties = {};
    v5._wrapped_only_objects = {};
    v5._is_locked = false;
    v5._locked_original_properties = {};
    v5._weld_data = {};
    v5._fake_model = v5.Model:FindFirstChild("_fake");
    v5:_Init();

    return v5;
end;

function u1.GetCharmPivotAttachment(p7) -- Line: 48
    return p7._charm_pivot_attachment;
end;

function u1.GetPivot(p8) -- Line: 52
    return p8.Model:GetPivot();
end;

function u1.GetBoundingBox(p9) -- Line: 56
    return p9.Model:GetBoundingBox();
end;

function u1.IsLocked(p10) -- Line: 60
    return p10._is_locked;
end;

function u1.HasGripAttachment(p11) -- Line: 64
    return p11.Model:FindFirstChild("_grip", true);
end;

function u1.DeleteAnimationContextSubModels(p12, p13) -- Line: 68
    local v14 = {};

    for i in pairs(p12._submodel_to_grip_attachment) do
        if i:GetAttribute("AnimationContexts") and not (p13 and i:GetAttribute(p13)) then
            i:Destroy();
            table.insert(v14, i);
        end;
    end;

    for _, v in pairs(v14) do
        p12._submodel_to_grip_attachment[v] = nil;
    end;
end;

function u1.ForceCharmAttachmentModelVisible(p15, p16) -- Line: 89
    p15._is_charm_attachment_model_forced_visible = p16;
    p15:_UpdateCharmAttachmentModelVisibility();
end;

function u1.SetParent(p17, p18) -- Line: 94
    p17.Model.Parent = p18;

    if p17.Charm then
        p17.Charm:SetParent(p18);
    end;
end;

function u1.SetLocked(p19, p20) -- Line: 102
    if p20 == p19._is_locked then
        return;
    end;

    p19._is_locked = p20;

    if p19._is_locked then
        p19:_Lock();
    else
        p19:_Unlock();
    end;

    p19:_UpdateWrap();
end;

function u1.SetCharm(p21, p22) -- Line: 118
    -- upvalues: Charms (copy), Charm (copy)
    if p21.Charm then
        p21.Charm:Destroy();
        p21.Charm = nil;
    end;

    if not (p22 and p21._charm_pivot_attachment) then
        p21:_UpdateCharmAttachmentModelVisibility();

        return;
    end;

    local v23 = Charms:FindFirstChild(p22.Name, true);
    p21.Charm = (v23 and require(v23) or Charm).new(nil, p22, p21._charm_pivot_attachment);
    p21.Charm:ScaleTo(p21.Model:GetScale() / p21._original_scale * p21._charm_scale_multiplier);
    p21.Charm:SetParent(p21.Model.Parent);
    p21:_UpdateCharmAttachmentModelVisibility();
end;

function u1.SetWrap(p24, p25) -- Line: 138
    p24.Wrap = p25;
    p24:_UpdateWrap();
end;

function u1.BreakWeld(p26) -- Line: 143
    for i, _ in pairs(p26._weld_data) do
        i.Anchored = true;
    end;

    for _, v in pairs(p26._weld_data) do
        v:Destroy();
    end;

    p26._weld_data = {};
end;

function u1.WeldTo(p27, p28) -- Line: 155
    p27:BreakWeld();
    local v29 = {};
    local v30;

    if p27.Charm then
        v30 = p27.Charm.Model or nil;
    else
        v30 = nil;
    end;

    v29[1], v29[2] = p27.Model, v30;

    for _, v in pairs(v29) do
        for _, descendant in pairs(v:GetDescendants()) do
            if descendant:IsA("BasePart") then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part1 = p28;
                WeldConstraint.Part0 = descendant;
                WeldConstraint.Parent = descendant;
                p27._weld_data[descendant] = WeldConstraint;
            end;
        end;
    end;

    for i in pairs(p27._weld_data) do
        i.Massless = true;
        i.Anchored = false;
    end;
end;

function u1.ScaleTo(p31, p32, p33) -- Line: 180
    -- upvalues: StaticModel (copy)
    local v34 = {};

    for _, v in pairs(p31._submodel_to_grip_attachment) do
        v34[v] = v.CFrame;
    end;

    StaticModel.ScaleTo(p31, p32);

    for _, v in pairs(p31._submodel_to_grip_attachment) do
        v.CFrame = v34[v];
    end;

    p31._charm_scale_multiplier = p33 or 1;

    if p31.Charm then
        p31.Charm:ScaleTo(p32 * p31._charm_scale_multiplier);
    end;
end;

function u1.PivotTo(p35, p36, p37) -- Line: 200
    -- upvalues: StaticModel (copy)
    if p37 then
        p37 = p35.Model:FindFirstChild(p37, true);
    end;

    if p37 then
        p37 = p37.WorldCFrame;
    end;

    p35:_ParentWrappedOnlyObjects(true);
    StaticModel.PivotTo(p35, p36, p37);
    p35:_ParentWrappedOnlyObjects(p35:_WrapExists());
end;

function u1.InitializeGrip(p38) -- Line: 209
    if p38._fake_model then
        task.defer(p38._fake_model.Destroy, p38._fake_model);
        p38._fake_model = nil;
    end;

    for _, child in pairs(p38.Model:GetChildren()) do
        child.WorldPivot = p38._submodel_to_grip_attachment[child].WorldCFrame;
    end;
end;

function u1.GripPivotTo(p39, p40) -- Line: 220
    for _, child in pairs(p39.Model:GetChildren()) do
        child:PivotTo(p40[p39._grip_attachment_to_limb[p39._submodel_to_grip_attachment[child]]].CFrame);
    end;

    p39:Update(0);
end;

function u1.Update(p41, p42) -- Line: 233
    -- upvalues: StaticModel (copy)
    StaticModel.Update(p41, p42);

    if p41.Charm then
        p41.Charm:Update(p42);
    end;
end;

function u1.Destroy(p43) -- Line: 241
    -- upvalues: StaticModel (copy)
    if p43.Charm then
        p43.Charm:Destroy();
    end;

    StaticModel.Destroy(p43);
end;

function u1._GetWrappedOnlyObjectByName(p44, p45) -- Line: 253
    for i in pairs(p44._wrapped_only_objects) do
        if i.Name == p45 then
            return i;
        end;
    end;
end;

function u1._WrapExists(p46) -- Line: 261
    return p46.Wrap and p46.Wrap.Name ~= "RANDOM_COSMETIC";
end;

function u1._ParentWrappedOnlyObjects(p47, p48) -- Line: 265
    for i, v in pairs(p47._wrapped_only_objects) do
        i.Parent = p48 and v and v or nil;
    end;
end;

function u1._UpdateWrap(p49) -- Line: 271
    -- upvalues: WrapController (copy)
    if p49._is_locked then
        return;
    end;

    WrapController:ApplyWrap(p49._original_wrap_properties, p49.Wrap);
    p49:_UpdateCharmAttachmentModelVisibility();

    if p49._fake_model then
        local v50 = p49:_WrapExists();
        local v51;

        if v50 then
            v51 = p49:_GetWrappedOnlyObjectByName("LeftArmWrapped");
        else
            v51 = v50;
        end;

        local v52;

        if v50 then
            v52 = p49:_GetWrappedOnlyObjectByName("RightArmWrapped");
        else
            v52 = v50;
        end;

        if p49._fake_model:FindFirstChild("LeftArm") then
            p49._fake_model.LeftArm.Transparency = v51 and 1 or 0;
            p49._fake_model.LeftArm.ShirtTexture.Transparency = v51 and 1 or 0;
        end;

        if p49._fake_model:FindFirstChild("RightArm") then
            p49._fake_model.RightArm.Transparency = v52 and 1 or 0;
            p49._fake_model.RightArm.ShirtTexture.Transparency = v52 and 1 or 0;
        end;

        p49:_ParentWrappedOnlyObjects(v50);
    end;
end;

function u1._UpdateCharmAttachmentModelVisibility(p53) -- Line: 298
    local v54 = (p53.Charm or p53._is_charm_attachment_model_forced_visible) and 0 or 1;

    for _, v in pairs(p53._charm_attachment_model and p53._charm_attachment_model:GetDescendants() or {}) do
        if v:IsA("BasePart") or v:IsA("Texture") then
            v.LocalTransparencyModifier = v54;
        end;
    end;
end;

function u1._Unlock(p55) -- Line: 308
    for i, v in pairs(p55._locked_original_properties) do
        local v56 = i;

        for i2, v2 in pairs(v) do
            v56[i2] = v2;
        end;
    end;

    p55._locked_original_properties = {};
end;

function u1._Lock(u57) -- Line: 318
    local function check(p58) -- Line: 319
        -- upvalues: u57 (copy)
        if u57._locked_original_properties[p58] then
            return;
        end;

        local v59 = {};

        if p58:IsA("BasePart") then
            v59.Color = p58.Color;
            p58.Color = Color3.fromRGB(31, 31, 31);
            v59.Material = p58.Material;
            p58.Material = Enum.Material.Neon;

            if p58:IsA("MeshPart") then
                v59.TextureID = p58.TextureID;
                p58.TextureID = "";
            end;
        elseif p58:IsA("Beam") or (p58:IsA("Trail") or p58:IsA("ParticleEmitter")) then
            v59.Color = p58.Color;
            p58.Color = ColorSequence.new(Color3.fromRGB(31, 31, 31));

            if p58:IsA("ParticleEmitter") or p58:IsA("Beam") then
                v59.Brightness = p58.Brightness;
                p58.Brightness = 1;
                v59.LightEmission = p58.LightEmission;
                p58.LightEmission = 0;
                v59.LightInfluence = p58.LightInfluence;
                p58.LightInfluence = 0;
            end;
        end;

        u57._locked_original_properties[p58] = v59;
    end;

    for _, v in pairs({ u57.Model, u57._charm_attachment_model }) do
        check(v);

        for _, descendant in pairs(v:GetDescendants()) do
            check(descendant);
        end;
    end;
end;

function u1._Setup(p60) -- Line: 365
    -- upvalues: CosmeticLibrary (copy), WrapController (copy), Utility (copy), Players (copy)
    if CosmeticLibrary.IGNORE_TRANSPARENCY_WHITELIST[p60.WeaponName] then
        for _, descendant in pairs(p60.Model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant:SetAttribute("IgnoreTransparency", true);
            end;
        end;
    end;

    local v61 = nil;

    for _, child in pairs(p60.Model:GetChildren()) do
        child.PrimaryPart = nil;
        local v62 = child;

        for _, descendant in pairs(child:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CastShadow = true;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
                descendant.Anchored = true;
                descendant.AudioCanCollide = false;
            end;
        end;

        local _grip = v62:FindFirstChild("_grip", true);
        local v63 = _grip and (_grip:GetAttribute("GripTarget") or "RightHand") or nil;

        if _grip then
            _grip:SetAttribute("GripTarget", v63);
            p60._grip_attachment_to_limb[_grip] = v63;
            p60._submodel_to_grip_attachment[v62] = _grip;

            if v63 == "RightHand" then
                v61 = _grip;
            end;
        end;
    end;

    for _, child in pairs(p60.Model:GetChildren()) do
        p60._submodel_to_grip_attachment[child] = p60._submodel_to_grip_attachment[child] or v61;
    end;

    p60.Model.PrimaryPart = nil;
    p60.Model.WorldPivot = p60.Model:FindFirstChild("_center", true).WorldCFrame;
    p60._original_wrap_properties = WrapController:RecordOriginalWrapProperties(p60.Model);

    if p60._fake_model then
        local RightArmWrapped = p60._fake_model:FindFirstChild("RightArmWrapped");
        local LeftArmWrapped = p60._fake_model:FindFirstChild("LeftArmWrapped");
        local ArmsData, v64, v65 = Utility:GetArmsData(Players.LocalPlayer.Character);

        if RightArmWrapped then
            p60._wrapped_only_objects[RightArmWrapped] = p60._fake_model;
        end;

        if LeftArmWrapped then
            p60._wrapped_only_objects[LeftArmWrapped] = p60._fake_model;
        end;

        if ArmsData and (v64 and v65) then
            if p60.Model._fake:FindFirstChild("LeftArm") then
                p60._fake_model.LeftArm.ShirtTexture.Texture = ArmsData;
                p60._fake_model.LeftArm.Color = v64;
            end;

            if p60.Model._fake:FindFirstChild("RightArm") then
                p60._fake_model.RightArm.ShirtTexture.Texture = ArmsData;
                p60._fake_model.RightArm.Color = v65;
            end;

            if RightArmWrapped then
                RightArmWrapped.Color = v65;
            end;

            if LeftArmWrapped then
                LeftArmWrapped.Color = v64;
            end;

            for _, descendant in pairs(p60.Model:GetDescendants()) do
                if descendant:GetAttribute("IsRightHand") then
                    descendant.Color = v65;
                elseif descendant:GetAttribute("IsLeftHand") then
                    descendant.Color = v64;
                end;
            end;

            p60._original_wrap_properties = WrapController:RecordOriginalWrapProperties(p60.Model);
        end;
    end;

    if p60.Name == "Chainsaw" or p60.Name == "Blobsaw" then
        p60.Model.Body.Spikes2:Destroy();

        return;
    end;

    if p60.Name ~= "Handsaws" then
        if p60.Name == "Street Sign" then
            local math_random_ret = math.random(1, 3);

            if math_random_ret ~= 1 then
                p60.Model.Body["Sign" .. 1]:Destroy();
            end;

            if math_random_ret ~= 2 then
                p60.Model.Body["Sign" .. 2]:Destroy();
            end;

            if math_random_ret ~= 3 then
                p60.Model.Body["Sign" .. 3]:Destroy();
            end;
        end;

        return;
    end;

    p60.Model.RightBlade.Spikes2:Destroy();
    p60.Model.LeftBlade.Spikes2:Destroy();
end;

function u1._Init(p66) -- Line: 480
    p66:_Setup();
    p66:SetLocked(false);
    p66:SetCharm(nil);
    p66:SetWrap(nil);
end;

return u1;