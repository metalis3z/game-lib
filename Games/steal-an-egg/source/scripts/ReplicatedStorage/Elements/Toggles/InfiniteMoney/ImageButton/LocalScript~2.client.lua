-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local script_Parent = script.Parent;

if not script_Parent:IsA("GuiButton") then
    script_Parent = script_Parent:FindFirstChild("ImageButton", true);
end;

if not script_Parent then
    return;
end;

local Sound = Instance.new("Sound");
Sound.SoundId = "rbxassetid://1567503279";
Sound.Volume = 0.5;
Sound.Parent = script;
local Size = script_Parent.Size;
script_Parent.MouseButton1Down:Connect(function() -- Line: 19
    -- upvalues: Sound (copy), TweenService (copy), script_Parent (ref), Size (copy)
    Sound:Play();
    TweenService:Create(script_Parent, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(Size.X.Scale * 0.9, Size.X.Offset, Size.Y.Scale * 0.9, Size.Y.Offset)
    }):Play();
end);
script_Parent.MouseButton1Up:Connect(function() -- Line: 26
    -- upvalues: TweenService (copy), script_Parent (ref), Size (copy)
    TweenService:Create(script_Parent, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Size
    }):Play();
end);
script_Parent.MouseLeave:Connect(function() -- Line: 32
    -- upvalues: TweenService (copy), script_Parent (ref), Size (copy)
    TweenService:Create(script_Parent, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {
        Size = Size
    }):Play();
end);