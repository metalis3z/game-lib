-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Spring = require(ReplicatedStorage.Modules.Spring);
require(ReplicatedStorage.Modules.Signal);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local MouseCrosshair = require(script:WaitForChild("MouseCrosshair"));
local Scope = require(script:WaitForChild("Scope"));
local MouseCooldownSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MouseCooldownSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 22
    -- upvalues: u1 (copy), MouseCrosshair (copy), Scope (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.ItemInterface = p2;
    v3.Frame = v3.ItemInterface.Frame:WaitForChild("Mouse");
    v3.CooldownsFrame = v3.Frame:WaitForChild("Cooldowns");
    v3.MouseCrosshair = MouseCrosshair.new(v3);
    v3.Scope = Scope.new(v3);
    v3._connections = {};
    v3._slide_spring = Spring.new(0, 0.875, 20);
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 44
    p4.Frame.Visible = p5;
end;

function u1.Refresh(p6) -- Line: 48
    -- upvalues: UserInputService (copy), CameraController (copy), CONSTANTS (copy)
    local v7 = UserInputService.MouseIconEnabled and CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse;
    local v8;

    if CONSTANTS.DEVICE == "VR" then
        v8 = false;
    else
        v8 = not v7;
    end;

    p6.MouseCrosshair.Crosshair:SetVisible(v8);
    p6.CooldownsFrame.Visible = CONSTANTS.DEVICE ~= "VR";
    p6.Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
end;

function u1.Update(p9, p10, p11, p12) -- Line: 56
    -- upvalues: CameraController (copy), UILibrary (copy)
    if not p11.IsSpectating then
        return;
    end;

    p9._slide_spring.Target = p11.IsSliding and (p11.IsFirstPerson and not p9.MouseCrosshair.Crosshair:IsStatic()) and 1 or 0;
    p9._slide_spring.Value = p9._slide_spring.Target > p9._slide_spring.Value and p9._slide_spring.Target or p9._slide_spring.Value;
    local Value = p9._slide_spring.Value;
    local UDim2_new_ret = UDim2.new();
    local v13 = CameraController.ViewModelOffsetCFrame * CameraController.ShakeCFrame;

    if p11.IsFirstPerson and (v13 ~= CFrame.identity and not p9.MouseCrosshair.Crosshair:IsStatic()) then
        local v14 = workspace.CurrentCamera.CFrame * v13:Inverse() * CFrame.new(0, 0, -100);
        local v15 = workspace.CurrentCamera:WorldToScreenPoint(v14.Position);
        UDim2_new_ret = UDim2.new(0, v15.X - p11.MouseLocation.X, 0, v15.Y - p11.MouseLocation.Y);
    end;

    local v16 = UILibrary:ScreenPointToPosition(p11.MouseLocation, p9.ItemInterface.Frame.AbsolutePosition);
    p9.Frame.Position = UDim2.new(0, v16.X, 0, v16.Y) + UDim2_new_ret;
    p9.Frame.Rotation = math.floor(Value * 20 + 0.5);
    p9.MouseCrosshair:Update(p10, p11, p12);
    p9.Scope:Update(p10, p11, p12);
end;

function u1.Destroy(p17) -- Line: 82
    for _, v in pairs(p17._connections) do
        v:Disconnect();
    end;

    p17.MouseCrosshair:Destroy();
    p17.Scope:Destroy();
end;

function u1._CooldownEffect(p18, p19) -- Line: 95
    -- upvalues: MouseCooldownSlot (copy), BetterDebris (copy), TweenService (copy)
    local Variables, v20, v21 = p19.GetVariables();
    local v22 = MouseCooldownSlot:Clone();
    v22.Icon.Image = p19.Image;
    v22.Icon.Container.Icon.Image = p19.Image;
    v22.Icon.Container.Size = UDim2.new(v20, 0, 1, 0);
    v22.Bar.Bar.Size = UDim2.new(v20, 0, 1.5, 0);
    v22.Parent = p18.CooldownsFrame;
    table.insert(p19.Cleanup, v22);
    BetterDebris:AddItem(v22, Variables);
    TweenService:Create(v22.Icon.Container, TweenInfo.new(Variables, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Size = UDim2.new(v21, 0, 1, 0)
    }):Play();
    TweenService:Create(v22.Bar.Bar, TweenInfo.new(Variables, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Size = UDim2.new(v21, 0, 1.5, 0)
    }):Play();
end;

function u1._Init(u23) -- Line: 111
    u23.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 112
        -- upvalues: u23 (copy)
        u23:Refresh();
    end);
    table.insert(u23._connections, u23.ItemInterface.ClientItem.Cooldowns.CooldownAdded:Connect(function(p24) -- Line: 116
        -- upvalues: u23 (copy)
        u23:_CooldownEffect(p24);
    end));

    for _, v in pairs(u23.ItemInterface.ClientItem.Cooldowns.Cooldowns) do
        task.spawn(u23._CooldownEffect, u23, v);
    end;
end;

return u1;