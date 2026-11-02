-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")

return {
    Name = "position",
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Aliases = { "pos" },
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "The player to report the position of. Omit for your own position.",
            Default = Players.LocalPlayer
        }
    },
    ClientRun = function(v1, v2) -- ClientRun | line 15
        local Character = v2.Character
        if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
            return ""
        end
        local Position = Character.HumanoidRootPart.Position
        return tostring(Position):gsub("%s", "")
    end
}
