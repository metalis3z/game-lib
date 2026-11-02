-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Spring = require(ReplicatedStorage.Modules.Spring);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local PageSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PageSystem"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: u1 (copy), PageSystem (copy), Spring (copy)
    local v2 = setmetatable({}, u1);
    v2.Part = Instance.new("Part");
    v2.SurfaceGui = Instance.new("SurfaceGui");
    v2.PagesFrame = Instance.new("Frame");
    v2.PageSystem = PageSystem.new(v2.PagesFrame);
    v2._previous_part_offset = CFrame.identity;
    v2._part_offset = nil;
    v2._offset_spring = Spring.new(1, 1, 15);
    v2._raycast_params = RaycastParams.new();
    v2._next_raycast = 0;
    v2:_Init();

    return v2;
end;

function u1._Debug(u3) -- Line: 47
    -- upvalues: RunService (copy), Pages (copy)
    RunService.RenderStepped:Connect(function() -- Line: 48
        -- upvalues: u3 (copy)
        u3:_Update();
    end);
    Pages.Frame.Visible = false;
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 54
        -- upvalues: u3 (copy), Pages (ref)
        u3.PageSystem:OpenPage(Pages.PageSystem.CurrentPage.Name);
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 58
        -- upvalues: u3 (copy)
        u3.PageSystem:CloseCurrentPage();
    end);
end;

function u1._Update(p4) -- Line: 63
    -- upvalues: CameraController (copy)
    local CameraCFrame = CameraController:GetCameraCFrame();

    if p4._offset_spring.Value >= 0.75 and not (p4._part_offset and (tick() <= p4._next_raycast or workspace:Raycast(CameraCFrame.Position, CameraCFrame.LookVector * 20, p4._raycast_params))) then
        p4._previous_part_offset = p4._previous_part_offset:Lerp(p4._part_offset or CFrame.identity, p4._offset_spring.Value);
        p4._part_offset = workspace.CurrentCamera.CFrame.Rotation * CFrame.new(0, 0, -7);
        p4._offset_spring.Value = 0;
        p4._next_raycast = tick() + 0.25;
    end;

    p4.Part.CFrame = CFrame.new(CameraCFrame.Position) * p4._previous_part_offset:Lerp(p4._part_offset, p4._offset_spring.Value);
end;

function u1._Setup(p5) -- Line: 76
    -- upvalues: Players (copy)
    p5.Part.Color = Color3.fromRGB(0, 0, 0);
    p5.Part.Transparency = 1;
    p5.Part.Size = Vector3.new(16, 9, 1);
    p5.Part.Anchored = true;
    p5.Part.CastShadow = false;
    p5.Part.CanCollide = false;
    p5.Part.CanTouch = false;
    p5.Part.CanQuery = true;
    p5.Part.Name = "Panel";
    p5.Part.Parent = workspace;
    p5.SurfaceGui.MaxDistance = 100;
    p5.SurfaceGui.Adornee = p5.Part;
    p5.SurfaceGui.AlwaysOnTop = false;
    p5.SurfaceGui.LightInfluence = 0;
    p5.SurfaceGui.Brightness = 2;
    p5.SurfaceGui.Name = "PanelsGui";
    p5.SurfaceGui.Face = Enum.NormalId.Back;
    p5.SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    p5.SurfaceGui.PixelsPerStud = 100;
    p5.SurfaceGui.ResetOnSpawn = false;
    p5.SurfaceGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
    p5.PagesFrame.Size = UDim2.new(1, 0, 1, 0);
    p5.PagesFrame.BackgroundTransparency = 1;
    p5.PagesFrame.Name = "Pages";
    p5.PagesFrame.Parent = p5.SurfaceGui;
    p5._raycast_params = RaycastParams.new();
    p5._raycast_params.FilterType = Enum.RaycastFilterType.Include;
    p5._raycast_params.FilterDescendantsInstances = { p5.Part };
    p5._raycast_params.BruteForceAllSlow = true;
    p5._raycast_params.IgnoreWater = true;
end;

function u1._Init(u6) -- Line: 112
    u6.PageSystem.PageOpened:Connect(function(p7) -- Line: 113
        -- upvalues: u6 (copy)
        local v8 = p7.PageFrame:FindFirstChildOfClass("UIAspectRatioConstraint");
        u6.Part.Size = Vector3.new(8, 8 / (v8 and v8.AspectRatio or p7.PageFrame.Size.X.Scale / p7.PageFrame.Size.Y.Scale), 1);
        p7.PageFrame.Size = UDim2.new(0, 0, 0, 0);
        p7.PageFrame.Position = UDim2.new(0.5, 0, 1, 0);
        p7.PageFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.5, true);
        p7.PageFrame:TweenSize(UDim2.new(0.75, 0, 0.75, 0), "Out", "Quint", 0.25, true);
    end);
    u6:_Setup();
end;

return u1._new();