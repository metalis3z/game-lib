-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent);
local u1 = require(script.Parent.Parent.topbarplus).new();
u1:setCaption("Inventory");
u1:setImage("rbxassetid://77083814877669", "Selected");
u1:setImage("rbxassetid://101548841384074", "Deselected");
u1:setImageScale(1);
u1:autoDeselect(false);
u1:setOrder(-1);
u1:bindToggleKey(Enum.KeyCode.Backquote);
Parent.StateChanged.Event:Connect(function(p2) -- Line: 18
    -- upvalues: u1 (copy)
    if p2 then
        u1:select();

        return;
    end;

    u1:deselect();
end);
u1.toggled:Connect(function(p3, p4) -- Line: 26
    -- upvalues: Parent (copy)
    if p4 == "User" then
        Parent.OpenClose();
    end;
end);
script.Parent.Parent.Parent.SetButtonsVisible.Event:Connect(function(p5) -- Line: 32
    -- upvalues: u1 (copy)
    local v6 = typeof(p5) == "string" and p5 == "All" and true or table.find(p5, "ShoppingCart") ~= nil;
    u1:setEnabled(v6);

    if not v6 then
        script.Parent.Parent.Parent.SetEnabled:Fire(false);
    end;
end);