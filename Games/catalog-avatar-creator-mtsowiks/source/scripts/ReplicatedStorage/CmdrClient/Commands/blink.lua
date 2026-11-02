-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "blink",
    Description = "Teleports you to where your mouse is hovering.",
    Group = "Administrator",
    Aliases = { "b" },
    Args = {},

    ClientRun = function(p1) -- Line: 8, Name: ClientRun
        local v2 = p1.Executor:GetMouse();
        local Character = p1.Executor.Character;

        if not Character then
            return "You don\'t have a character.";
        end;

        Character:MoveTo(v2.Hit.p);

        return "Blinked!";
    end
};