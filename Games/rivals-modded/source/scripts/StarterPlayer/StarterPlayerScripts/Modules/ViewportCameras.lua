-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {
    ZOOM_OUT_FACTOR = 3,
    Charm = Instance.new("Camera")
};
u1.Charm.FieldOfView = 25;
u1.CharmZoomedOut = Instance.new("Camera");
u1.CharmZoomedOut.FieldOfView = 25;
u1.Skin = Instance.new("Camera");
u1.Skin.FieldOfView = 25;
u1.SkinZoomedOut = Instance.new("Camera");
u1.SkinZoomedOut.FieldOfView = 25;
u1.Wrap = Instance.new("Camera");
u1.Wrap.FieldOfView = 25;
u1.Wrap.CFrame = CFrame.Angles(0, 3.490658503988659, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 1);
u1.WrapZoomedOut = Instance.new("Camera");
u1.WrapZoomedOut.FieldOfView = 25;
u1.WrapZoomedOut.CFrame = CFrame.Angles(0, 3.490658503988659, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 1 * u1.ZOOM_OUT_FACTOR);
u1.Emote = Instance.new("Camera");
u1.Emote.FieldOfView = 10;
u1.EmoteZoomedOut = Instance.new("Camera");
u1.EmoteZoomedOut.FieldOfView = 10;
RunService.RenderStepped:Connect(function(p2) -- Line: 29
    -- upvalues: u1 (copy)
    u1.Charm.CFrame = CFrame.Angles(0, tick() * 0.5 % 6.283185307179586, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 0.3);
    u1.CharmZoomedOut.CFrame = CFrame.Angles(0, tick() * 0.5 % 6.283185307179586, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 0.3 * u1.ZOOM_OUT_FACTOR);
    u1.Skin.CFrame = CFrame.Angles(0, tick() * 0.5 % 6.283185307179586, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 5);
    u1.SkinZoomedOut.CFrame = CFrame.Angles(0, tick() * 0.5 % 6.283185307179586, 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 5 * u1.ZOOM_OUT_FACTOR);
    local Emote = u1.Emote;
    local CFrame_Angles = CFrame.Angles;
    local v3 = tick() * 0.25 % 6.283185307179586;
    Emote.CFrame = CFrame_Angles(0, 3.141592653589793 + math.sin(v3) * 0.2617993877991494, 0) * CFrame.Angles(-0.4363323129985824, 0, 0) * CFrame.new(0, 0, 40);
    local EmoteZoomedOut = u1.EmoteZoomedOut;
    local CFrame_Angles2 = CFrame.Angles;
    local v4 = tick() * 0.25 % 6.283185307179586;
    EmoteZoomedOut.CFrame = CFrame_Angles2(0, 3.141592653589793 + math.sin(v4) * 0.2617993877991494, 0) * CFrame.Angles(-0.4363323129985824, 0, 0) * CFrame.new(0, 0, 40 * u1.ZOOM_OUT_FACTOR);
end);

return u1;