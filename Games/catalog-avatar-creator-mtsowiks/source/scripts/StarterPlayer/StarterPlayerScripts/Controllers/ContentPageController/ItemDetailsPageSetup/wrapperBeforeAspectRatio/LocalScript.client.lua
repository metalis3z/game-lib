-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

if script:IsDescendantOf(game.StarterGui) then
    return;
end;

local Parent = script.Parent;
local UIListLayout = Parent:WaitForChild("UIListLayout");
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 6
    -- upvalues: Parent (copy), UIListLayout (copy)
    Parent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y);
end);
Parent.AutomaticSize = Enum.AutomaticSize.Y;