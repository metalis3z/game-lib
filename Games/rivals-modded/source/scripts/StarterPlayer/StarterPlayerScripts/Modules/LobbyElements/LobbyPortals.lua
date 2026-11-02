-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 20
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._teleport_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1._ObjectAdded(u4, p5) -- Line: 40
    -- upvalues: CONSTANTS (copy), Players (copy), FighterController (copy), SpectateController (copy), Utility (copy), BetterDebris (copy), PreloadController (copy), RunService (copy), CameraController (copy)
    if CONSTANTS.IS_ARCADE_SERVER then
        return;
    end;

    local Camera = p5:WaitForChild("Camera");
    local Entrance = p5:WaitForChild("Entrance");
    local Exit = p5:WaitForChild("Exit");
    Entrance.Touched:Connect(function(p6) -- Line: 49
        -- upvalues: u4 (copy), Players (ref), FighterController (ref), SpectateController (ref), Utility (ref), Entrance (copy), Exit (copy), BetterDebris (ref), PreloadController (ref), RunService (ref), CameraController (ref), Camera (copy)
        if tick() < u4._teleport_cooldown then
            return;
        end;

        if p6.Parent ~= Players.LocalPlayer.Character then
            return;
        end;

        if not (FighterController.LocalFighter and FighterController.LocalFighter:IsAlive()) then
            return;
        end;

        if SpectateController.CurrentDuelSubject or SpectateController.CurrentSubject ~= FighterController.LocalFighter then
            return;
        end;

        u4._teleport_cooldown = tick() + 5.3 + 1;
        Utility:CreateSound("rbxassetid://86785771664692", 0.5, 1 + 0.1 * math.random(), Entrance, true, 10);
        Utility:CreateSound("rbxassetid://81610952487049", 1, 1 + 0.1 * math.random(), Exit, true, 10);
        local Humanoid = FighterController.LocalFighter.Entity.Humanoid;
        local UpperTorso = FighterController.LocalFighter.Entity.Model:FindFirstChild("UpperTorso");
        local RootPart = FighterController.LocalFighter.Entity.RootPart;
        local RootRigAttachment = RootPart:FindFirstChild("RootRigAttachment");
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.Position = Exit.Position;
        AlignPosition.Attachment0 = RootRigAttachment;
        AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
        AlignPosition.MaxAxesForce = Vector3.new(1, 0, 1) * (1 / 0);
        AlignPosition.Responsiveness = 20;
        AlignPosition.ForceRelativeTo = Enum.ActuatorRelativeTo.World;
        AlignPosition.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        AlignPosition.Parent = RootPart;
        BetterDebris:AddItem(AlignPosition, 5.3);
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Attachment0 = RootRigAttachment;
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.CFrame = Exit.CFrame.Rotation;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.Parent = RootPart;
        BetterDebris:AddItem(AlignOrientation, 5.3);
        local CFrame2 = Exit.CFrame;
        local v7 = math.random() - 0.5;
        local v8 = math.random() - 0.5;
        RootPart.CFrame = CFrame2 + Vector3.new(v7, 0, v8) * Exit.Size;
        Humanoid:LoadAnimation(PreloadController:GetPreloadedAnimation("LobbyPortalFalling")):Play(0);
        RunService:BindToRenderStep("LobbyPortalFalling", CameraController:GetRenderstepPriority() + 1, function(p9) -- Line: 98
            -- upvalues: Camera (ref), UpperTorso (copy), RootPart (copy)
            workspace.CurrentCamera.FieldOfView = 30;
            workspace.CurrentCamera.CFrame = CFrame.new(Camera.Position, (UpperTorso or RootPart).Position);
        end);
        wait(5.3);
        RunService:UnbindFromRenderStep("LobbyPortalFalling");
    end);
end;

function u1._Init(u10) -- Line: 109
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyPortal"):Connect(function(p11) -- Line: 110
        -- upvalues: u10 (copy)
        u10:_ObjectAdded(p11);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyPortal")) do
        task.defer(u10._ObjectAdded, u10, v);
    end;
end;

return u1._new();