-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Spring = require(ReplicatedStorage.Modules.Spring);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local CFrame_new_ret = CFrame.new(0, 0, 35);
local CFrame_new_ret2 = CFrame.new(0, -2, 0);
local UDim2_new_ret = UDim2.new(0.5, 0, -2.5, 0);
local UDim2_new_ret2 = UDim2.new(0.5, 0, 3.5, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 33
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.FinishedOpenEffect = Signal.new();
    v3.Equipment = p2;
    v3._frame = UILibrary:GetTo("MainFrame", "Equipment", "CameraFade");
    v3._look_at_attachment = nil;
    v3._look_at_offset = Vector3.new(0, 0, 0);
    v3._fov_spring = Spring.new(15, 0.875, 5);
    v3._equipment_open_hash = 0;
    v3._equipment_open_start_cframe = CFrame.identity;
    v3._equipment_open_start = 0;
    v3._equipment_open_finished = true;
    v3._equipment_open_is_closing = false;
    v3._controls_connections = {};
    v3._scroll_fov_spring = Spring.new(0, 1, 20);
    v3._fov_zoom_direction = Vector2.zero;
    v3:_Init();

    return v3;
end;

function u1.IsOpenEffectDone(p4) -- Line: 62
    return p4._equipment_open_finished;
end;

function u1.IsClosing(p5) -- Line: 66
    return p5._equipment_open_is_closing;
end;

function u1.SetFocus(p6, p7, p8, p9, p10) -- Line: 70
    p6._look_at_attachment = p7 or nil;
    p6._look_at_offset = p8 or Vector3.new(0, 0, 0);
    p6._fov_spring.Target = p9 or 15;
    p6._fov_spring.Speed = p10 or 5;
end;

function u1.Update(p11, p12) -- Line: 77
    -- upvalues: CFrame_new_ret2 (copy), CFrame_new_ret (copy), CameraController (copy)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    p11:_IncrementFOVSpringFromInput((p11._fov_zoom_direction.X - p11._fov_zoom_direction.Y) * p12 * 60 * 0.25);
    local v13 = (tick() - p11._equipment_open_start) / 0.375;
    local math_clamp_ret = math.clamp(v13, 0, 1);

    if math_clamp_ret < 1 then
        local v14 = math_clamp_ret ^ 2;

        if p11._equipment_open_is_closing then
            workspace.CurrentCamera.CFrame = p11._equipment_open_start_cframe * CFrame.identity:Lerp(CFrame_new_ret2, v14);

            return;
        end;

        workspace.CurrentCamera.CFrame = p11._equipment_open_start_cframe * CFrame.new(0, v14 * 25, 0);

        return;
    end;

    local CustomizingType = p11.Equipment:GetCustomizingType();
    local v15 = p11.Equipment.Scene:GetCFrame() * CFrame_new_ret;
    local v16;

    if p11._equipment_open_finished then
        v16 = workspace.CurrentCamera.CFrame;
    else
        v16 = v15 * (p11:_IsOpenEffectDisabled() and CFrame.identity or CFrame_new_ret2);
    end;

    if CustomizingType == "Finisher" and true or CustomizingType == "Emote" then
        v15 = CFrame.new(v15.Position + Vector3.new(0, 5, 0), p11.Equipment.Scene:GetHumanoidCFrame().Position);
    elseif p11._look_at_attachment then
        v15 = CFrame.new(v15.Position, p11._look_at_attachment.WorldPosition + p11._look_at_offset);
    end;

    local CFrame_Angles = CFrame.Angles;
    local v17 = tick() * 0.23983 % 6.283185307179586;
    local v18 = math.sin(v17) * 0.00017453292519943296;
    local v19 = tick() * 0.372721 % 6.283185307179586;
    local v20 = math.sin(v19) * 0.00017453292519943296;
    local v21 = tick() * 0.43123 % 6.283185307179586;
    local v22 = CFrame_Angles(v18, v20, math.sin(v21) * 0.00017453292519943296);
    local v23 = p11.Equipment:IsCustomizing() and 0.025 or 0.05;
    workspace.CurrentCamera.FieldOfView = p11._fov_spring.Value + p11._scroll_fov_spring.Value + CameraController:GetExternalFOVOffset();
    workspace.CurrentCamera.CFrame = CFrame.new(v16.Position:Lerp(v15.Position, 0.1)) * v16.Rotation:Lerp(v15.Rotation, v23) * v22;

    if not p11._equipment_open_finished then
        p11._equipment_open_finished = true;
        p11.FinishedOpenEffect:Fire();
    end;
end;

function u1.OnStateChanged(p24) -- Line: 121
    p24.Equipment:IsCustomizing();
end;

function u1.OnOpen(p25) -- Line: 127
    -- upvalues: CameraController (copy), UDim2_new_ret (copy), UDim2_new_ret2 (copy), Utility (copy)
    task.spawn(CameraController.CameraState.SetCustomFreecamEnabled, CameraController.CameraState, false);
    CameraController:Freeze(p25.Equipment.IsOpen);
    p25:_VerifyControls();

    if p25.Equipment.IsOpen then
        p25._scroll_fov_spring.Target = 0;
        p25._scroll_fov_spring.Value = 0;

        if p25:_IsOpenEffectDisabled() then
            p25._equipment_open_hash = p25._equipment_open_hash + 1;
            p25._equipment_open_is_closing = false;
            p25._equipment_open_start_cframe = CFrame.identity;
            p25._equipment_open_start = 0;
            p25._equipment_open_finished = false;
            p25.FinishedOpenEffect:Fire();

            return;
        end;

        p25._equipment_open_hash = p25._equipment_open_hash + 1;
        p25._equipment_open_is_closing = false;
        p25._equipment_open_start_cframe = workspace.CurrentCamera.CFrame;
        p25._equipment_open_start = tick();
        p25._equipment_open_finished = false;
        p25.FinishedOpenEffect:Fire();
        p25._frame.Position = UDim2_new_ret;
        p25._frame:TweenPosition(UDim2_new_ret2, "InOut", "Quint", 0.9375, true);
        Utility:CreateSound("rbxassetid://106551800007995", 1.5, 1 + 0.2 * math.random(), script, true, 5);
    end;
end;

function u1.CloseEffect(p26) -- Line: 159
    -- upvalues: UDim2_new_ret2 (copy), UDim2_new_ret (copy), Utility (copy)
    if p26:_IsOpenEffectDisabled() then
        p26._equipment_open_hash = p26._equipment_open_hash + 1;
        p26._equipment_open_is_closing = true;
        p26._equipment_open_start_cframe = CFrame.identity;
        p26._equipment_open_start = 0;
        p26._equipment_open_finished = true;
        p26.FinishedOpenEffect:Fire();

        return;
    end;

    p26._equipment_open_hash = p26._equipment_open_hash + 1;
    p26._equipment_open_is_closing = true;
    p26._equipment_open_start_cframe = workspace.CurrentCamera.CFrame;
    p26._equipment_open_start = tick();
    p26._equipment_open_finished = false;
    p26.FinishedOpenEffect:Fire();
    p26._frame.Position = UDim2_new_ret2;
    p26._frame:TweenPosition(UDim2_new_ret, "InOut", "Quint", 0.75, true);
    Utility:CreateSound("rbxassetid://106551800007995", 1.25, 0.8 + 0.2 * math.random(), script, true, 5);
    local _equipment_open_hash = p26._equipment_open_hash;
    wait(0.375);

    if _equipment_open_hash ~= p26._equipment_open_hash then
        return;
    end;

    if not p26._equipment_open_finished then
        p26._equipment_open_finished = true;
        p26.FinishedOpenEffect:Fire();
    end;
end;

function u1._IsOpenEffectDisabled(p27) -- Line: 200
    -- upvalues: GuiService (copy)
    return GuiService.ReducedMotionEnabled;
end;

function u1._IncrementFOVSpringFromInput(p28, p29) -- Line: 204
    p28._scroll_fov_spring.Target = math.clamp(p28._scroll_fov_spring.Target + p29, -10, 10);
end;

function u1._VerifyControls(u30) -- Line: 208
    -- upvalues: UserInputService (copy), Pages (copy), UILibrary (copy)
    for _, v in pairs(u30._controls_connections) do
        v:Disconnect();
    end;

    u30._controls_connections = {};
    u30._fov_zoom_direction = Vector2.zero;

    if not u30.Equipment.IsOpen then
        return;
    end;

    table.insert(u30._controls_connections, UserInputService.TouchPinch:Connect(function(p31, p32, p33, p34, p35) -- Line: 220
        -- upvalues: u30 (copy)
        if p35 then
            return;
        end;

        u30:_IncrementFOVSpringFromInput(p33 * -0.25);
    end));
    table.insert(u30._controls_connections, UserInputService.InputChanged:Connect(function(p36, p37) -- Line: 228
        -- upvalues: Pages (ref), UILibrary (ref), u30 (copy)
        if Pages.PageSystem.CurrentPage or p36.UserInputType ~= Enum.UserInputType.MouseWheel then
            return;
        end;

        if UILibrary:IsMouseWithinBounds(u30.Equipment.Interface.Left.Frame.AbsolutePosition, u30.Equipment.Interface.Left.Frame.AbsoluteSize) then
            return;
        end;

        if UILibrary:IsMouseWithinBounds(u30.Equipment.Interface.Right.Frame.AbsolutePosition, u30.Equipment.Interface.Right.Frame.AbsoluteSize) then
            return;
        end;

        if UILibrary:IsMouseWithinBounds(u30.Equipment.Interface.Customize.Cosmetics.List.AbsolutePosition, u30.Equipment.Interface.Customize.Cosmetics.List.AbsoluteSize) then
            return;
        end;

        u30:_IncrementFOVSpringFromInput(p36.Position.Z * -1);
    end));
    table.insert(u30._controls_connections, UserInputService.InputBegan:Connect(function(p38, p39) -- Line: 248
        -- upvalues: u30 (copy)
        if p38.KeyCode == Enum.KeyCode.ButtonL2 then
            u30._fov_zoom_direction = Vector2.new(1, u30._fov_zoom_direction.Y);

            return;
        end;

        if p38.KeyCode == Enum.KeyCode.ButtonR2 then
            u30._fov_zoom_direction = Vector2.new(u30._fov_zoom_direction.X, 1);
        end;
    end));
    table.insert(u30._controls_connections, UserInputService.InputEnded:Connect(function(p40, p41) -- Line: 256
        -- upvalues: u30 (copy)
        if p40.KeyCode == Enum.KeyCode.ButtonL2 then
            u30._fov_zoom_direction = Vector2.new(0, u30._fov_zoom_direction.Y);

            return;
        end;

        if p40.KeyCode == Enum.KeyCode.ButtonR2 then
            u30._fov_zoom_direction = Vector2.new(u30._fov_zoom_direction.X, 0);
        end;
    end));
end;

function u1._UpdateFocus(p42) -- Line: 265
    -- upvalues: Pages (copy)
    local CustomizingType = p42.Equipment:GetCustomizingType();
    p42._look_at_offset = CustomizingType == "Charm" and Vector3.new(0, -0.075, 0) or Vector3.new(0, 0, 0);
    local v43;

    if CustomizingType == "Charm" and p42.Equipment.FloatingModel then
        v43 = p42.Equipment.FloatingModel:GetCharmPivotAttachment() or nil;
    else
        v43 = nil;
    end;

    p42._look_at_attachment = v43;
    p42._fov_spring.Speed = Pages.PageSystem.CurrentPage and 15 or 5;
    p42._fov_spring.Target = CustomizingType == "Finisher" and 40 or (CustomizingType == "Emote" and 25 or (CustomizingType == "Charm" and 5 or (CustomizingType and 12.5 or (Pages.PageSystem.CurrentPage and 20 or 15))));
end;

function u1._Setup(p44) -- Line: 280
    -- upvalues: UILibrary (copy)
    p44._frame.Parent = UILibrary.MainGui;
end;

function u1._Init(u45) -- Line: 284
    -- upvalues: Pages (copy)
    u45.Equipment.CustomizingChanged:Connect(function() -- Line: 285
        -- upvalues: u45 (copy)
        u45:_UpdateFocus();
    end);
    u45.Equipment.CharmAttachmentVisibleChanged:Connect(function() -- Line: 289
        -- upvalues: u45 (copy)
        u45:_UpdateFocus();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 293
        -- upvalues: u45 (copy)
        u45:_UpdateFocus();
    end);
    u45:_Setup();
    u45:_UpdateFocus();
end;

return u1;