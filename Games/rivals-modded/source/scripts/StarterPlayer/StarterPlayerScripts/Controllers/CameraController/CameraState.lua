-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
require(ReplicatedStorage.Modules.DebugLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PrivateServerController = require(Players.LocalPlayer.PlayerScripts.Controllers.PrivateServerController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CustomFreecam = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CustomFreecam");
local u1 = {
    FirstPerson = "FirstPerson",
    ThirdPerson = "ThirdPerson",
    ThirdPersonMirrored = "ThirdPersonMirrored",
    ThirdPersonUnlockedMouse = "ThirdPersonUnlockedMouse",
    CustomFreecam = "CustomFreecam"
};
local u2 = {};
u2.__index = u2;
u2.States = u1;
u2.POVStates = { "FirstPerson", "ThirdPerson", "ThirdPersonMirrored", "ThirdPersonUnlockedMouse" };

function u2.new(p3) -- Line: 22
    -- upvalues: u2 (copy), Signal (copy), CustomFreecam (copy)
    local v4 = setmetatable({}, u2);
    v4.StateChanged = Signal.new();
    v4.FreecamAccessChanged = Signal.new();
    v4.CameraController = p3;
    v4._public_state = nil;
    v4._pov_state = nil;
    v4._is_active = false;
    v4._custom_freecam_enabled = false;
    v4._custom_freecam = CustomFreecam:Clone();
    v4._custom_freecam_script = v4._custom_freecam:WaitForChild("LocalScript");
    v4:_Init();

    return v4;
end;

function u2.GetPublicState(p5) -- Line: 46
    return p5._public_state;
end;

function u2.HasFreecamAccess(p6) -- Line: 50
    -- upvalues: CONSTANTS (copy), PrivateServerController (copy), Players (copy), PermissionsLibrary (copy), PlayerDataController (copy)
    return CONSTANTS.IS_STUDIO or CONSTANTS.IS_TESTING_SERVER or (PrivateServerController:Get("FreecamEnabled") == "Everyone" and true or (PrivateServerController:Get("FreecamEnabled") == "Server Owner" and CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId) or PermissionsLibrary:HasPermission("permission_freecam", PlayerDataController:Get("PermissionsRoles"))));
end;

function u2.SetActive(p7, p8) -- Line: 57
    if p8 == p7._is_active then
        return;
    end;

    p7._is_active = p8;
    p7:_UpdateState();
end;

function u2.SetCustomFreecamEnabled(p9, p10) -- Line: 66
    -- upvalues: Players (copy)
    if p10 == p9._custom_freecam_enabled then
        return;
    end;

    p9._custom_freecam_enabled = p10;
    p9:_UpdateState();
    p9._custom_freecam_script.Disabled = false;
    p9._custom_freecam.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
    task.defer(p9._custom_freecam.LocalScript.Toggle.Fire, p9._custom_freecam.LocalScript.Toggle, p9._custom_freecam_enabled);
end;

function u2.TogglePOV(p11) -- Line: 80
    local v12 = p11.CameraController:HasThirdPersonAccess();
    local v13;

    if v12 then
        v13 = p11.CameraController:HasUnlockedMouseAccess();
    else
        v13 = v12;
    end;

    if p11._pov_state == p11.States.FirstPerson and v12 then
        p11:_SetPOVState(p11.States.ThirdPerson);

        return;
    end;

    if p11._pov_state == p11.States.ThirdPerson and v12 then
        p11:_SetPOVState(p11.States.ThirdPersonMirrored);

        return;
    end;

    if p11._pov_state == p11.States.ThirdPersonMirrored and v13 then
        p11:_SetPOVState(p11.States.ThirdPersonUnlockedMouse);

        return;
    end;

    if p11.CameraController:IsSubjectEmoting() then
        p11:_SetPOVState(p11.States.ThirdPerson);

        return;
    end;

    p11:_SetPOVState(p11.States.FirstPerson);
end;

function u2.VerifyPOV(p14) -- Line: 99
    local v15;

    if p14._pov_state == p14.States.FirstPerson then
        v15 = false;
    else
        v15 = not p14.CameraController:HasThirdPersonAccess();
    end;

    local v16;

    if p14._pov_state == p14.States.ThirdPersonUnlockedMouse then
        v16 = not p14.CameraController:HasUnlockedMouseAccess();
    else
        v16 = false;
    end;

    if not v16 then
        if v15 then
            p14:_SetPOVState(p14.States.FirstPerson);
        end;

        return;
    end;

    if v15 then
        p14:_SetPOVState(p14.States.FirstPerson);

        return;
    end;

    p14:_SetPOVState(p14.States.ThirdPerson);
end;

function u2._SetState(p17, p18) -- Line: 118
    -- upvalues: u1 (copy)
    assert(not p18 or u1[p18], p18);

    if p18 == p17._public_state then
        return;
    end;

    local _public_state = p17._public_state;
    p17._public_state = p18;
    p17.StateChanged:Fire(p17._public_state, _public_state);
end;

function u2._UpdateState(p19) -- Line: 131
    p19.CameraController:GetCurrentSubject();
    local v20;

    if p19._custom_freecam_enabled then
        v20 = p19.States.CustomFreecam;
    elseif p19._is_active then
        v20 = p19._pov_state;
    else
        v20 = nil;
    end;

    p19:_SetState(v20);
end;

function u2._SetPOVState(p21, p22) -- Line: 140
    -- upvalues: u1 (copy)
    assert(not p22 or u1[p22], p22);

    if p22 == p21._pov_state then
        return;
    end;

    p21._pov_state = p22;
    p21:_UpdateState();
end;

function u2._SetupEmoteLogic(u23) -- Line: 151
    local u24 = nil;
    local u25 = {};

    local function check() -- Line: 155
        -- upvalues: u23 (copy), u24 (ref)
        task.defer(function() -- Line: 156
            -- upvalues: u23 (ref), u24 (ref)
            if u23.CameraController:IsSubjectEmoting() then
                u24 = u24 or u23._pov_state;
                u23:_SetPOVState(u23.States.ThirdPersonUnlockedMouse);

                return;
            end;

            if u24 then
                u23:_SetPOVState(u24);
                u24 = nil;
            end;

            u23:VerifyPOV();
        end);
    end;

    local function subject_changed() -- Line: 171
        -- upvalues: u25 (ref), u23 (copy), check (copy), u24 (ref)
        for _, v in pairs(u25) do
            v:Disconnect();
        end;

        u25 = {};
        local CurrentSubject = u23.CameraController:GetCurrentSubject();

        if not CurrentSubject then
            return;
        end;

        table.insert(u25, CurrentSubject.EntityRemoved:Connect(check));
        table.insert(u25, CurrentSubject.EntityAdded:Connect(function(p26) -- Line: 186, Name: entity_added
            -- upvalues: u25 (ref), check (ref), u23 (ref), u24 (ref)
            table.insert(u25, p26.EmoteStatusChanged:Connect(check));
            task.defer(function() -- Line: 156
                -- upvalues: u23 (ref), u24 (ref)
                if u23.CameraController:IsSubjectEmoting() then
                    u24 = u24 or u23._pov_state;
                    u23:_SetPOVState(u23.States.ThirdPersonUnlockedMouse);

                    return;
                end;

                if u24 then
                    u23:_SetPOVState(u24);
                    u24 = nil;
                end;

                u23:VerifyPOV();
            end);
        end));

        if CurrentSubject.Entity then
            table.insert(u25, CurrentSubject.Entity.EmoteStatusChanged:Connect(check));
            task.defer(function() -- Line: 156
                -- upvalues: u23 (ref), u24 (ref)
                if u23.CameraController:IsSubjectEmoting() then
                    u24 = u24 or u23._pov_state;
                    u23:_SetPOVState(u23.States.ThirdPersonUnlockedMouse);

                    return;
                end;

                if u24 then
                    u23:_SetPOVState(u24);
                    u24 = nil;
                end;

                u23:VerifyPOV();
            end);
        end;
    end;

    u23.CameraController.SubjectChanged:Connect(subject_changed);
    subject_changed();
end;

function u2._SetupFreecam(u27) -- Line: 202
    -- upvalues: Players (copy), UserInputService (copy)
    task.spawn(function() -- Line: 204
        -- upvalues: Players (ref)
        Players.LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(function(p28) -- Line: 205, Name: child_added
            if p28:IsA("ScreenGui") and p28.Name == "Freecam" then
                task.defer(p28.Destroy, p28);
            end;
        end);

        for _, child in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
            if child:IsA("ScreenGui") and child.Name == "Freecam" then
                task.defer(child.Destroy, child);
            end;
        end;
    end);
    UserInputService.InputBegan:Connect(function(p29, p30) -- Line: 218
        -- upvalues: UserInputService (ref), u27 (copy)
        if p29.KeyCode == Enum.KeyCode.P and (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u27:HasFreecamAccess()) then
            u27:SetCustomFreecamEnabled(not u27._custom_freecam_enabled);
        end;
    end);
end;

function u2._Setup(p31) -- Line: 227
    if p31.CameraController:HasThirdPersonAccess() then
        p31:_SetPOVState(p31.States.FirstPerson);
    end;
end;

function u2._Init(u32) -- Line: 233
    -- upvalues: ControlsController (copy), PrivateServerController (copy), PlayerDataController (copy)
    ControlsController.ControlsChanged:Connect(function() -- Line: 234
        -- upvalues: u32 (copy)
        u32:VerifyPOV();
    end);
    PrivateServerController:GetDataChangedSignal("FreecamEnabled"):Connect(function() -- Line: 238
        -- upvalues: u32 (copy)
        u32.FreecamAccessChanged:Fire();
    end);
    PlayerDataController:GetDataChangedSignal("PermissionsRoles"):Connect(function() -- Line: 242
        -- upvalues: u32 (copy)
        u32.FreecamAccessChanged:Fire();
    end);
    u32:_Setup();
    u32:_UpdateState();
    task.defer(u32._SetupFreecam, u32);
    task.defer(u32._SetupEmoteLogic, u32);
end;

return u2;