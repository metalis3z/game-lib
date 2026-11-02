-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local DebugState = require(Players.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local DefaultHeadMesh = Players.LocalPlayer.PlayerScripts.Assets.Misc.DefaultHeadMesh;
local u1 = { "rbxassetid://6686307858", "https://assetdelivery.roblox.com/v1/asset/?id=16673245747" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 15
    -- upvalues: u2 (copy), DefaultHeadMesh (copy)
    local v4 = setmetatable({}, u2);
    v4.ClientFighterCharacter = p3;
    v4._neck_rig_attachment = nil;
    v4._hat_attachment = nil;
    v4._is_head_too_big = nil;
    v4._is_custom_head_blacklisted = nil;
    v4._default_head_mesh = DefaultHeadMesh:Clone();
    v4._default_head_face = v4._default_head_mesh.Decal;
    v4._default_head_weld = nil;
    v4._accessory_meshes = {};
    v4._already_checked_accessory = {};
    v4._deleted_face_controls = false;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6, p7) -- Line: 40
end;

function u2.Destroy(p8) -- Line: 44
    p8._default_head_mesh:Destroy();
end;

function u2._IsLocalPlayer(p9) -- Line: 52
    return p9.ClientFighterCharacter.ClientFighter.IsLocalPlayer;
end;

function u2._IsInTransparencyContext(p10) -- Line: 60
    -- upvalues: DebugState (copy)
    local v11 = not p10:_IsLocalPlayer() and p10.ClientFighterCharacter.ClientFighter:Get("IsInDuel") and not DebugState:Get("DisableTransparentHats");

    return v11;
end;

function u2._IsHeadSizeDimensionTooBig(p12, p13) -- Line: 68
    local v14 = p13 / (p12.ClientFighterCharacter:Get("Scale") or 1) - 1;

    return math.abs(v14) > 0.25;
end;

function u2._DeleteFaceControls(u15) -- Line: 72
    if u15._deleted_face_controls or not u15.ClientFighterCharacter.ClientFighter:Get("IsInDuel") then
        return;
    end;

    u15._deleted_face_controls = true;
    task.spawn(function() -- Line: 79
        -- upvalues: u15 (copy)
        local v16;

        while true do
            v16 = u15.ClientFighterCharacter.Head:FindFirstChildOfClass("FaceControls");

            if v16 then
                break;
            end;

            u15.ClientFighterCharacter.Head.ChildAdded:Wait();
        end;

        task.defer(v16.Destroy, v16);
    end);
end;

function u2._UpdateDefaultHead(p17) -- Line: 96
    -- upvalues: DefaultHeadMesh (copy)
    if not p17.ClientFighterCharacter:IsAlive() then
        return;
    end;

    if p17.ClientFighterCharacter.ClientFighter:Get("IsHiddenByEmotes") or p17.ClientFighterCharacter.ClientFighter:Get("IsHiddenByCutscene") then
        p17._default_head_mesh.Transparency = 1;
        p17._default_head_face.Transparency = 1;

        return;
    end;

    local v18 = p17:_IsInTransparencyContext() and (p17._is_custom_head_blacklisted or (p17:_IsHeadSizeDimensionTooBig(p17.ClientFighterCharacter.Head.Size.X) or p17:_IsHeadSizeDimensionTooBig(p17.ClientFighterCharacter.Head.Size.Y) or (p17:_IsHeadSizeDimensionTooBig(p17.ClientFighterCharacter.Head.Size.Z) or p17:_IsHeadSizeDimensionTooBig((math.abs(p17._hat_attachment.WorldPosition.Y - p17._neck_rig_attachment.WorldPosition.Y))))));
    local v19 = v18 == p17._is_head_too_big;
    p17._is_head_too_big = v18;
    local v20 = p17.ClientFighterCharacter.ClientFighter:IsActuallyFirstPerson();
    p17.ClientFighterCharacter.Head.LocalTransparencyModifier = v20 and 1 or (p17._is_head_too_big and 1 or 0);
    p17._default_head_mesh.Transparency = v20 and 1 or (p17._is_head_too_big and 0 or 1);
    p17._default_head_face.Transparency = p17._default_head_mesh.Transparency;
    p17._default_head_weld.Enabled = false;
    p17._default_head_mesh.Size = DefaultHeadMesh.Size * (p17.ClientFighterCharacter:Get("Scale") or 1);
    p17._default_head_mesh.CFrame = p17._neck_rig_attachment.WorldCFrame * CFrame.new(0, p17._default_head_mesh.Size.Y / 2, 0);
    p17._default_head_weld.Enabled = true;

    if not v19 then
        p17:_BulkUpdateAccessoryMeshes();
    end;
end;

function u2._BulkUpdateAccessoryMeshes(p21) -- Line: 136
    for i in pairs(p21._accessory_meshes) do
        p21:_UpdateAccessoryMesh(i);
    end;
end;

function u2._UpdateAccessoryMesh(p22, p23) -- Line: 142
    local v24 = p22._accessory_meshes[p23];

    if not v24 then
        return;
    end;

    local v25 = 3 * (p22.ClientFighterCharacter:Get("Scale") or 1);
    local v26 = p22._is_head_too_big and not p22._is_custom_head_blacklisted and 0.875 or (((v25 < p23.Size.X or v25 < p23.Size.Y) and true or v25 < p23.Size.Z) and p22:_IsInTransparencyContext() and 0.875 or 0);
    p23.Transparency = v24.OriginalTransparency + (1 - v24.OriginalTransparency) * v26;
end;

function u2._AccessoryMeshAdded(u27, u28) -- Line: 158
    if not u28:IsA("BasePart") then
        return;
    end;

    u27._accessory_meshes[u28] = u27._accessory_meshes[u28] or {
        OriginalTransparency = u28.Transparency
    };
    u28:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 165
        -- upvalues: u27 (copy), u28 (copy)
        u27:_UpdateAccessoryMesh(u28);
    end);
    u27:_UpdateAccessoryMesh(u28);
end;

function u2._AccessoryAdded(u29, p30) -- Line: 172
    if not p30:IsA("Accessory") or u29._already_checked_accessory[p30] then
        return;
    end;

    if u29:_IsLocalPlayer() then
        return;
    end;

    u29._already_checked_accessory[p30] = true;
    p30.ChildAdded:Connect(function(p31) -- Line: 183
        -- upvalues: u29 (copy)
        u29:_AccessoryMeshAdded(p31);
    end);

    for _, child in pairs(p30:GetChildren()) do
        u29:_AccessoryMeshAdded(child);
    end;
end;

function u2._SetupAsync(u32) -- Line: 192
    -- upvalues: u1 (copy), DebugState (copy), CameraController (copy), SpectateController (copy)
    u32.ClientFighterCharacter:WaitUntilIsInWorld();
    u32._neck_rig_attachment = u32.ClientFighterCharacter.Head:WaitForChild("NeckRigAttachment");
    u32._hat_attachment = u32.ClientFighterCharacter.Head:WaitForChild("HatAttachment");
    u32._is_custom_head_blacklisted = table.find(u1, u32.ClientFighterCharacter.Head.MeshId);
    u32._default_head_mesh.Color = u32.ClientFighterCharacter.Head.Color;
    u32._default_head_mesh.Parent = u32.ClientFighterCharacter.Head;
    u32._default_head_weld = Instance.new("WeldConstraint");
    u32._default_head_weld.Part0 = u32.ClientFighterCharacter.Head;
    u32._default_head_weld.Part1 = u32._default_head_mesh;
    u32._default_head_weld.Parent = u32._default_head_mesh;
    u32.ClientFighterCharacter:GetDataChangedSignal("Scale"):Connect(function() -- Line: 208
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32.ClientFighterCharacter.Head:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 212
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32.ClientFighterCharacter.Head:GetPropertyChangedSignal("Transparency"):Connect(function() -- Line: 216
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32.ClientFighterCharacter.Head:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() -- Line: 220
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32._default_head_mesh:GetPropertyChangedSignal("Transparency"):Connect(function() -- Line: 224
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32._default_head_mesh:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() -- Line: 228
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end);
    u32.ClientFighterCharacter.Model.ChildAdded:Connect(function(p33) -- Line: 232
        -- upvalues: u32 (copy)
        if not u32.ClientFighterCharacter:IsAlive() then
            return;
        end;

        u32:_AccessoryAdded(p33);
    end);
    u32.ClientFighterCharacter:AddConnection(DebugState:GetDataChangedSignal("DisableTransparentHats"):Connect(function() -- Line: 240
        -- upvalues: u32 (copy)
        u32:_BulkUpdateAccessoryMeshes();
        u32:_UpdateDefaultHead();
    end));
    u32.ClientFighterCharacter:AddConnection(u32.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 245
        -- upvalues: u32 (copy)
        u32:_BulkUpdateAccessoryMeshes();
        u32:_UpdateDefaultHead();
        u32:_DeleteFaceControls();
    end));
    u32.ClientFighterCharacter:AddConnection(u32.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 251
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end));
    u32.ClientFighterCharacter:AddConnection(u32.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes"):Connect(function() -- Line: 255
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end));
    u32.ClientFighterCharacter:AddConnection(u32.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByCutscenes"):Connect(function() -- Line: 259
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end));
    u32.ClientFighterCharacter:AddConnection(CameraController.StateChanged:Connect(function() -- Line: 263
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end));
    u32.ClientFighterCharacter:AddConnection(SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 267
        -- upvalues: u32 (copy)
        u32:_UpdateDefaultHead();
    end));

    for _, child in pairs(u32.ClientFighterCharacter.Model:GetChildren()) do
        u32:_AccessoryAdded(child);
    end;

    u32:_UpdateDefaultHead();
    u32:_DeleteFaceControls();
end;

function u2._Init(p34) -- Line: 279
    task.spawn(p34._SetupAsync, p34);
end;

return u2;