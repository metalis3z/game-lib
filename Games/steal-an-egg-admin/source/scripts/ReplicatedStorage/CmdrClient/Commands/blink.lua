-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "blink",
    Description = "Teleports you to where your mouse is hovering.",
    Group = "DefaultDebug",
    Aliases = { "b" },
    Args = {},
    ClientRun = function(v1) -- ClientRun | line 12
        local v2 = v1.Executor:GetMouse()
        local Character = v1.Executor.Character
        if Character then
            Character:MoveTo(v2.Hit.p)
            return "Blinked!"
        end
        return "You don't have a character."
    end
}
