-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
task.spawn(function() -- Line: 5
    -- upvalues: StarterGui (copy)
    while task.wait(3) do
        if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
            warn("Purse and CoreGui backpack enabled at the same time");

            return;
        end;
    end;
end);