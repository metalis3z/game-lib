-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ViewportCameras = require(Players.LocalPlayer.PlayerScripts.Modules.ViewportCameras);
local EmoteViewportFrame = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmoteViewportFrame");
local EmoteDummy = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EmoteDummy");
local Emotes = ReplicatedStorage.Modules.Emotes;
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 15
    -- upvalues: CosmeticLibrary (copy), u1 (copy), EmoteViewportFrame (copy)
    assert(CosmeticLibrary.Cosmetics[p2].Type == "Emote");
    local v4 = setmetatable({}, u1);
    v4.Name = p2;
    v4.Frame = EmoteViewportFrame:Clone();
    v4.EmoteGlow = v4.Frame.EmoteGlow;
    v4._destroyed = false;
    v4._world_model = v4.Frame.WorldModel;
    v4._playing_emotes_hash = 0;
    v4._dummy = nil;
    v4._last_emote = nil;
    v4._fade_speed = v4.Name == "MISSING_EMOTE" and (1 / 0) or (p3 or 1);
    v4._is_locked = false;
    v4:_Init();

    return v4;
end;

function u1.SetParent(p5, p6) -- Line: 41
    p5.Frame.Parent = p6;
    p5.EmoteGlow.Parent = p6;
end;

function u1.SetLocked(p7, p8) -- Line: 46
    p7._is_locked = p8;
    p7.Frame.ImageColor3 = p7._is_locked and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p7.Frame.ImageTransparency = p7:_GetImageTransparency();
end;

function u1.HideShadow(p9) -- Line: 52
    p9.EmoteGlow.Visible = false;
end;

function u1.ZoomOut(p10) -- Line: 56
    -- upvalues: ViewportCameras (copy)
    local Size = p10.Frame.Size;
    p10.Frame.Size = UDim2.new(p10.Frame.Size.X.Scale * ViewportCameras.ZOOM_OUT_FACTOR, p10.Frame.Size.X.Offset * ViewportCameras.ZOOM_OUT_FACTOR, p10.Frame.Size.Y.Scale * ViewportCameras.ZOOM_OUT_FACTOR, p10.Frame.Size.Y.Offset * ViewportCameras.ZOOM_OUT_FACTOR);
    p10.Frame.Position = UDim2.new(p10.Frame.Position.X.Scale, p10.Frame.Position.X.Offset, p10.Frame.Position.Y.Scale - Size.Y.Scale * 0.5 + p10.Frame.Size.Y.Scale * 0.5, p10.Frame.Position.Y.Offset - Size.Y.Offset * 0.5 + p10.Frame.Size.Y.Offset * 0.5);
    p10.Frame.CurrentCamera = ViewportCameras.EmoteZoomedOut;
end;

function u1.Destroy(p11) -- Line: 63
    p11._destroyed = true;
    p11._playing_emotes_hash = p11._playing_emotes_hash + 1;
    p11.Frame:Destroy();
    p11:_Clear();
end;

function u1._GetImageTransparency(p12) -- Line: 74
    return p12._is_locked and 0.5 or 0;
end;

function u1._IsActuallyVisible(p13) -- Line: 78
    -- upvalues: Players (copy)
    if not (p13.Frame:IsDescendantOf(workspace) or Players.LocalPlayer:FindFirstChild("PlayerGui") and p13.Frame:IsDescendantOf(Players.LocalPlayer.PlayerGui)) then
        return false;
    end;

    local Frame = p13.Frame;

    while Frame and not Frame:IsA("LayerCollector") do
        Frame = Frame.Parent;
    end;

    if not (Frame and Frame.Enabled) then
        return false;
    end;

    local Frame2 = p13.Frame;

    while Frame2.Visible do
        Frame2 = Frame2.Parent;

        if Frame2 == Frame then
            return true;
        end;
    end;

    return false;
end;

function u1._Clear(p14) -- Line: 110
    if p14._dummy then
        p14._dummy:Destroy();
        p14._dummy = nil;
    end;

    if p14._last_emote then
        p14._last_emote:Destroy();
        p14._last_emote = nil;
    end;
end;

function u1._PlayEmote(u15) -- Line: 122
    -- upvalues: EmoteDummy (copy), CosmeticLibrary (copy), Utility (copy), Emotes (copy)
    if u15._destroyed then
        return;
    end;

    u15._playing_emotes_hash = u15._playing_emotes_hash + 1;
    local _playing_emotes_hash = u15._playing_emotes_hash;
    u15:_Clear();

    while not u15:_IsActuallyVisible() do
        wait(1);

        if u15._playing_emotes_hash ~= _playing_emotes_hash then
            return;
        end;
    end;

    while true do
        local v16 = tick();
        u15._dummy = EmoteDummy:Clone();
        u15._dummy:PivotTo(CosmeticLibrary.Cosmetics[u15.Name].ViewportCFrameOffset);
        u15._dummy.Parent = u15._world_model;
        Utility:RenderstepForLoop(0, 100, 4 * u15._fade_speed, function(p17) -- Line: 147
            -- upvalues: u15 (copy), _playing_emotes_hash (copy)
            if u15._playing_emotes_hash ~= _playing_emotes_hash then
                return true;
            end;

            local v18 = (p17 / 100) ^ 3;
            u15.Frame.ImageTransparency = 1 + (u15:_GetImageTransparency() - 1) * v18;
            u15.EmoteGlow.ImageTransparency = 1 + -0.5 * v18;
        end);

        if u15._playing_emotes_hash ~= _playing_emotes_hash then
            break;
        end;

        if u15._dummy:FindFirstChild("Humanoid") then
            u15._last_emote = require(Emotes[u15.Name]).new(u15._dummy.Humanoid);
            task.defer(u15._last_emote.Simulate, u15._last_emote);
            u15._last_emote.Destroying:Wait();
        end;

        Utility:RenderstepForLoop(0, 100, 4 * u15._fade_speed, function(p19) -- Line: 168
            -- upvalues: u15 (copy), _playing_emotes_hash (copy)
            if u15._playing_emotes_hash ~= _playing_emotes_hash then
                return true;
            end;

            local v20 = 1 - (1 - p19 / 100) ^ 3;
            u15.Frame.ImageTransparency = u15:_GetImageTransparency() + (1 - u15:_GetImageTransparency()) * v20;
            u15.EmoteGlow.ImageTransparency = 0.5 + 0.5 * v20;
        end);

        if u15._playing_emotes_hash ~= _playing_emotes_hash then
            return;
        end;

        u15:_Clear();
        wait(1 - (tick() - v16));

        if u15._playing_emotes_hash ~= _playing_emotes_hash then
            return;
        end;
    end;
end;

function u1._Setup(p21) -- Line: 193
    -- upvalues: ViewportCameras (copy)
    p21.Frame.CurrentCamera = ViewportCameras.Emote;
end;

function u1._Init(u22) -- Line: 197
    u22.Frame.AncestryChanged:Connect(function() -- Line: 198
        -- upvalues: u22 (copy)
        u22:_PlayEmote();
    end);
    u22:_Setup();
    task.spawn(u22._PlayEmote, u22);
end;

return u1;