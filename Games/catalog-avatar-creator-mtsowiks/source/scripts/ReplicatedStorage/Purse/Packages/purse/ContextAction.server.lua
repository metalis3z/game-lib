-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local Parent = require(script.Parent);
ContextActionService:BindAction("BackpackToggle", function(p1, p2, p3) -- Line: 8, Name: handleAction
    -- upvalues: Parent (copy)
    if p1 == "BackpackToggle" and p2 == Enum.UserInputState.Begin then
        Parent.OpenClose();
    end;
end, false, Enum.KeyCode.Backquote);