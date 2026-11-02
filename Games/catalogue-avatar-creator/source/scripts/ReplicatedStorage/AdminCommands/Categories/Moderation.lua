--[[
    Moderation Commands Module
    Secure command definitions for moderation actions
    All execution goes through Cmdr with server-side permission validation
]]

return {
    {
        Name = "Kick",
        Description = "Remove a player from the server immediately.",
        Icon = "rbxassetid://6034258833",
        Command = "kick",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Reason", Type = "string", Required = false, Placeholder = "Reason (optional)" },
        },
    },
    {
        Name = "Ban",
        Description = "Permanently ban a player from the game.",
        Icon = "rbxassetid://6034258833",
        Command = "ban",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Reason", Type = "string", Required = false, Placeholder = "Reason (optional)" },
        },
    },
    {
        Name = "Unban",
        Description = "Lift a ban on a previously banned player.",
        Icon = "rbxassetid://6034258833",
        Command = "unban",
        Arguments = {
            { Name = "Player", Type = "string", Required = true, Placeholder = "Enter player name or ID..." },
        },
    },
    {
        Name = "Temp Ban",
        Description = "Temporarily ban a player for a specified duration.",
        Icon = "rbxassetid://6034258833",
        Command = "tempban",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Duration", Type = "duration", Required = true, Placeholder = "e.g. 1h, 30m, 2d" },
            { Name = "Reason", Type = "string", Required = false, Placeholder = "Reason (optional)" },
        },
    },
    {
        Name = "Warn",
        Description = "Send a formal warning to a player.",
        Icon = "rbxassetid://6034258833",
        Command = "warn",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Reason", Type = "string", Required = true, Placeholder = "Warning reason..." },
        },
    },
    {
        Name = "Kill",
        Description = "Instantly kill a player's character.",
        Icon = "rbxassetid://6034258833",
        Command = "kill",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Respawn",
        Description = "Force respawn a player's character.",
        Icon = "rbxassetid://6034258833",
        Command = "respawn",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
}