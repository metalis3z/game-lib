--[[
    Player Management Commands Module
    Secure command definitions for player attribute and flag management
]]

return {
    {
        Name = "Set Flag",
        Description = "Set a permission flag for a specific player (e.g. IsAdministrator, IsContentModerator).",
        Icon = "rbxassetid://6034258833",
        Command = "setflag",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Flag", Type = "string", Required = true, Placeholder = "Flag name (e.g. IsAdministrator)" },
            { Name = "Value", Type = "string", Required = true, Placeholder = "true or false" },
        },
    },
    {
        Name = "Get Flags",
        Description = "View all permission flags currently set on a player.",
        Icon = "rbxassetid://6034258833",
        Command = "getflags",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Vanish",
        Description = "Toggle invisibility for a player. They become invisible to others but can still interact.",
        Icon = "rbxassetid://6034258833",
        Command = "vanish",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Set Credits",
        Description = "Set the credit balance for a specific player.",
        Icon = "rbxassetid://6034258833",
        Command = "setcredits",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Amount", Type = "number", Required = true, Placeholder = "Credit amount" },
        },
    },
    {
        Name = "Staff Tag",
        Description = "Toggle a staff tag display for a player.",
        Icon = "rbxassetid://6034258833",
        Command = "stafftag",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Set Statistic",
        Description = "Modify a specific statistic value for a player.",
        Icon = "rbxassetid://6034258833",
        Command = "setstatistic",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Statistic", Type = "string", Required = true, Placeholder = "Statistic name" },
            { Name = "Value", Type = "string", Required = true, Placeholder = "New value" },
        },
    },
    {
        Name = "Get Stats",
        Description = "Retrieve all statistics for a specified player.",
        Icon = "rbxassetid://6034258833",
        Command = "getstats",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
    {
        Name = "Check Rank",
        Description = "Check the group rank of a player.",
        Icon = "rbxassetid://6034258833",
        Command = "checkrank",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
}