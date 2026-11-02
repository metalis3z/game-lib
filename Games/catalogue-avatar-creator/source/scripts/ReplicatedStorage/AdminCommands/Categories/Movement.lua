--[[
    Movement Commands Module
    Secure command definitions for player movement actions
]]

return {
    {
        Name = "Teleport To",
        Description = "Teleport yourself to a specified player.",
        Icon = "rbxassetid://6034258833",
        Command = "teleport",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Bring",
        Description = "Teleport a player to your current position.",
        Icon = "rbxassetid://6034258833",
        Command = "fetch",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Blink",
        Description = "Teleport forward in the direction you are facing.",
        Icon = "rbxassetid://6034258833",
        Command = "blink",
        Arguments = {
            { Name = "Distance", Type = "number", Required = false, Placeholder = "Distance in studs (default: 32)" },
        },
    },
    {
        Name = "Go To Place",
        Description = "Teleport to a different game place within the universe.",
        Icon = "rbxassetid://6034258833",
        Command = "gotoPlace",
        Arguments = {
            { Name = "Place ID", Type = "number", Required = true, Placeholder = "Enter place ID..." },
            { Name = "Job ID", Type = "string", Required = false, Placeholder = "Job ID (optional)" },
        },
    },
    {
        Name = "Join Player",
        Description = "Teleport to the server where a specific player is located.",
        Icon = "rbxassetid://6034258833",
        Command = "joinplayer",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Thru",
        Description = "Teleport through walls or obstacles in front of you.",
        Icon = "rbxassetid://6034258833",
        Command = "thru",
        Arguments = {},
    },
}