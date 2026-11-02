--[[
    Communication Commands Module
    Secure command definitions for announcements and messaging
]]

return {
    {
        Name = "Announce",
        Description = "Send a server-wide announcement to all players in the current server.",
        Icon = "rbxassetid://6034258833",
        Command = "announce",
        Arguments = {
            { Name = "Message", Type = "string", Required = true, Placeholder = "Enter announcement message..." },
        },
    },
    {
        Name = "Global Announce",
        Description = "Send an announcement across all servers in the universe.",
        Icon = "rbxassetid://6034258833",
        Command = "globalannounce",
        Arguments = {
            { Name = "Message", Type = "string", Required = true, Placeholder = "Enter global message..." },
        },
    },
    {
        Name = "Self Announce",
        Description = "Send an announcement that appears as a system message from you.",
        Icon = "rbxassetid://6034258833",
        Command = "selfannounce",
        Arguments = {
            { Name = "Message", Type = "string", Required = true, Placeholder = "Enter message..." },
        },
    },
    {
        Name = "Global Self Announce",
        Description = "Send a self-styled announcement globally across all servers.",
        Icon = "rbxassetid://6034258833",
        Command = "globalselfannounce",
        Arguments = {
            { Name = "Message", Type = "string", Required = true, Placeholder = "Enter global message..." },
        },
    },
}