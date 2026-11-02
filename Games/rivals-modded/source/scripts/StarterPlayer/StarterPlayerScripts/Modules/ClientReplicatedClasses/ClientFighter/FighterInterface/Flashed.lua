-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local FlashbangGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("FlashbangGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 21
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3._default_flash_sound_callback = nil;
    v3._default_ringing_sound_callback = nil;
    v3._flash_objects = {};
    v3:_Init();

    return v3;
end;

function u1.AttemptToFlash(p4, p5, p6, p7, p8, p9, p10) -- Line: 39
    if p4:_IsOccluded(p5, p6) then
        return;
    end;

    p4:Flash(p6, p7, p8, p9, p10);
end;

function u1.Flash(p11, p12, p13, p14, p15, p16) -- Line: 47
    -- upvalues: UILibrary (copy), PlayerDataController (copy), FlashbangGui (copy), Players (copy), BetterDebris (copy), Lighting (copy), ReplicatedStorage (copy), RunService (copy)
    local v17, v18 = workspace.CurrentCamera:WorldToScreenPoint(p12);
    local v19 = UILibrary:ScreenPointToPosition(Vector2.new(v17.X, v17.Y), p11.FighterInterface.Frame.AbsolutePosition);
    local UDim2_new_ret = UDim2.new(0, math.clamp(v19.X, -p11.FighterInterface.Frame.AbsoluteSize.X * 0.5, p11.FighterInterface.Frame.AbsoluteSize.X * 1.5), 0, (math.clamp(v19.Y, -p11.FighterInterface.Frame.AbsoluteSize.Y * 0.5, p11.FighterInterface.Frame.AbsoluteSize.Y * 1.5)));
    local Setting = PlayerDataController:GetSetting("Accessible Flashes");
    local v20 = Setting and -2 or 2;
    local v21 = Setting and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    local v22 = p15 == "Shining Star" and Color3.fromRGB(255, 215, 0) or p15 == "Sol" and Color3.fromRGB(255, 251, 133) or (Setting and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(220, 215, 204));
    local v23 = p15 == "Pixel Flashbang" and "rbxassetid://123806439184095" or "rbxassetid://14796588510";
    local v24 = p15 == "Pixel Flashbang" and 0.75 or 1;
    local v25 = p15 == "Pixel Flashbang" and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default;
    local v26 = FlashbangGui:Clone();
    v26.Background.BackgroundColor3 = v21;
    v26.Center.Skullbang.Visible = false;
    v26.Center.Position = UDim2_new_ret;
    v26.Rays1.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30), 0, math.random(-30, 30));
    v26.Rays2.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30), 0, math.random(-30, 30));
    v26.Rays3.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30), 0, math.random(-30, 30));
    v26.Rays1.ResampleMode = v25;
    v26.Rays2.ResampleMode = v25;
    v26.Rays3.ResampleMode = v25;
    v26.Rays1.Image = v23;
    v26.Rays2.Image = v23;
    v26.Rays3.Image = v23;
    v26.Rays1.Size = UDim2.new(v26.Rays1.Size.X.Scale * v24, v26.Rays1.Size.X.Offset * v24, v26.Rays1.Size.Y.Scale * v24, v26.Rays1.Size.Y.Offset * v24);
    v26.Rays2.Size = UDim2.new(v26.Rays2.Size.X.Scale * v24, v26.Rays2.Size.X.Offset * v24, v26.Rays2.Size.Y.Scale * v24, v26.Rays2.Size.Y.Offset * v24);
    v26.Rays3.Size = UDim2.new(v26.Rays3.Size.X.Scale * v24, v26.Rays3.Size.X.Offset * v24, v26.Rays3.Size.Y.Scale * v24, v26.Rays3.Size.Y.Offset * v24);
    v26.Parent = Players.LocalPlayer.PlayerGui;
    BetterDebris:AddItem(v26, 10);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "Flashbang";
    ColorCorrectionEffect.Parent = Lighting;
    BetterDebris:AddItem(ColorCorrectionEffect, 10);
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(10, 10, 0);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Color = v21;
    Part.Material = Enum.Material.Neon;
    Part.Parent = v18 and workspace or nil;
    BetterDebris:AddItem(Part, 10);
    local v27 = (p16 or p11._default_ringing_sound_callback)();
    local v28 = p13 * (v18 and 1 or (v17.Z > 0 and 0.125 or 0));
    local math_max_ret = math.max(0.5, v28);
    local v29 = tick();
    local v30 = 0;

    if v28 > 0 then
        ReplicatedStorage.Remotes.Replication.Fighter.BlindedEffect:FireServer(p14, v28);
    end;

    local v31 = p11:_RegisterFlashObjects(v28, v26, ColorCorrectionEffect, Part, v27);

    if p15 == "Camera" and v18 then
        local success, result = pcall(p11._CameraSnapshot, p11, p12, UDim2_new_ret, v26, v31);

        if not success then
            warn("Camera Flashbang snapshot failed, error:", result);
        end;
    end;

    p11:_UpdateVisibility();

    while tick() < v29 + math_max_ret do
        local v32 = (tick() - v29) / math_max_ret;
        local math_min_ret = math.min(1, v32);
        local v33 = v28 > 0 and math_min_ret and math_min_ret or math_min_ret * 0.25 + 0.75;
        local v34 = 0.5 + 0.5 * v33;
        local v35;

        if p15 == "Disco Ball" then
            v35 = Color3.fromHSV(tick() * 0.5 % 1, 0.75, 1);
        else
            v35 = v22;
        end;

        local v36 = v35:Lerp(v21, v33);

        if v27 then
            v27.Volume = 1 - v33;
        end;

        ColorCorrectionEffect.Brightness = v20 + (0 - v20) * v33;
        v26.Rays1.ImageTransparency = v34;
        v26.Rays2.ImageTransparency = v34;
        v26.Rays3.ImageTransparency = v34;
        v26.Rays1.ImageColor3 = v36;
        v26.Rays2.ImageColor3 = v36;
        v26.Rays3.ImageColor3 = v36;
        v26.Background.Transparency = not v18 and 1 or v33 ^ 5;
        v26.Polaroid.GroupTransparency = 0.25 + 0.75 * v33 ^ 2;
        Part.Transparency = math.max(0, v33 - 0.25) / 0.75;
        Part.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1);

        if p15 == "Pixel Flashbang" then
            v26.Rays1.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30) * v24, 0, math.random(-30, 30) * v24);
            v26.Rays2.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30) * v24, 0, math.random(-30, 30) * v24);
            v26.Rays3.Position = UDim2_new_ret + UDim2.new(0, math.random(-30, 30) * v24, 0, math.random(-30, 30) * v24);
        else
            local Rays1 = v26.Rays1;
            Rays1.Rotation = Rays1.Rotation + v30 * 0.5 * 60;
            local Rays2 = v26.Rays2;
            Rays2.Rotation = Rays2.Rotation - v30 * 0.25 * 60;
            local Rays3 = v26.Rays3;
            Rays3.Rotation = Rays3.Rotation + v30 * 0.37237 * 60;
        end;

        v30 = RunService.RenderStepped:Wait();
    end;

    Part:Destroy();
    ColorCorrectionEffect:Destroy();
    v26:Destroy();
end;

function u1.Destroy(p37) -- Line: 165
    for _, v in pairs(p37._flash_objects) do
        for _, v2 in pairs(v) do
            v2[1]:Destroy();
        end;
    end;

    p37._flash_objects = {};
end;

function u1._CameraSnapshot(p38, p39, p40, p41, p42) -- Line: 179
    -- upvalues: SpectateController (copy), TweenService (copy)
    local v43 = SpectateController.CurrentSubject and SpectateController.CurrentSubject.Entity and SpectateController.CurrentSubject:CloneFighterModel();

    if v43 then
        local face = v43:FindFirstChild("face", true);

        if face and face:IsA("Decal") then
            face.Texture = "rbxassetid://18983839334";
        end;

        local Camera = Instance.new("Camera");
        Camera.CFrame = CFrame.new(v43.Head.Position + (p39 - v43.Head.Position).Unit * 8, v43.Head.Position);
        Camera.FieldOfView = 35;
        p41.Polaroid.Visible = true;
        p41.Polaroid.Picture.BackgroundColor3 = Color3.fromHSV(math.random(), 0.756, 0.56);
        p41.Polaroid.Picture.ViewportFrame.LightDirection = Camera.CFrame.LookVector;
        p41.Polaroid.Picture.ViewportFrame.CurrentCamera = Camera;
        p41.Polaroid.Rotation = 180;
        p41.Polaroid.Position = UDim2.new(math.random(), 0, 1.5, 0);
        p41.Polaroid:TweenPosition(p40, "Out", "Quint", 1, true);
        TweenService:Create(p41.Polaroid, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Rotation = 1080 + 45 * (math.random() - 0.5)
        }):Play();
        Camera.Parent = p41.Polaroid.Picture.ViewportFrame;
        v43.Parent = p41.Polaroid.Picture.ViewportFrame.WorldModel;

        for _, descendant in pairs(v43:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;

        p38:_RegisterFlashObject(p42, v43);
        p38:_RegisterFlashObject(p42, Camera);

        return v43, Camera;
    end;
end;

function u1._IsOccluded(p44, p45, p46) -- Line: 223
    -- upvalues: Utility (copy), GameplayUtility (copy)
    local v47 = p45 or {};

    if p44.FighterInterface.ClientFighter.Entity then
        table.insert(v47, p44.FighterInterface.ClientFighter.Entity.Model);
    end;

    local v48;

    while true do
        v48 = Utility:Raycast(workspace.CurrentCamera.CFrame.Position, p46, (workspace.CurrentCamera.CFrame.Position - p46).Magnitude, v47, Enum.RaycastFilterType.Exclude);

        if not v48.Instance or (v48.Instance.CanCollide or v48.Instance:HasTag("SmokeCloud")) then
            break;
        end;

        table.insert(v47, v48.Instance);
    end;

    return v48.Instance and true or #GameplayUtility:GetSmokeCloudsInSphere(p46) > 0;
end;

function u1._RegisterFlashObject(p49, p50, p51) -- Line: 251
    table.insert(p50, { p51, p51.Parent });
end;

function u1._RegisterFlashObjects(u52, p53, ...) -- Line: 255
    local u54 = {};

    for _, v in pairs({ ... }) do
        u52:_RegisterFlashObject(u54, v);
    end;

    table.insert(u52._flash_objects, u54);
    task.delay(p53, function() -- Line: 264
        -- upvalues: u52 (copy), u54 (copy)
        local table_find_ret = table.find(u52._flash_objects, u54);

        if table_find_ret then
            table.remove(u52._flash_objects, table_find_ret);
        end;
    end);

    return u54;
end;

function u1._UpdateVisibility(u55) -- Line: 275
    for _, v in pairs(u55._flash_objects) do
        for _, v2 in pairs(v) do
            pcall(function() -- Line: 278
                -- upvalues: v2 (copy), u55 (copy)
                v2[1].Parent = u55.FighterInterface:IsActive() and v2[2] or nil;
            end);
        end;
    end;
end;

function u1._Setup(p56) -- Line: 285
    -- upvalues: Utility (copy)
    function p56._default_ringing_sound_callback() -- Line: 286
        -- upvalues: Utility (ref)
        return Utility:CreateSound("rbxassetid://14778230632", 1, 1, script, true, 10);
    end;
end;

function u1._Init(u57) -- Line: 291
    u57.FighterInterface.ActiveChanged:Connect(function() -- Line: 292
        -- upvalues: u57 (copy)
        u57:_UpdateVisibility();
    end);
    u57:_Setup();
end;

return u1;