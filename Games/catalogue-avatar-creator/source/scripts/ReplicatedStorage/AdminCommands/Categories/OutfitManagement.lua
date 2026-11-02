--[[
    Outfit Management Commands Module
    Secure command definitions for outfit moderation
]]

return {
    {
        Name = "Delete Outfit",
        Description = "Delete a specific saved outfit from a player's wardrobe.",
        Icon = "rbxassetid://6034258833",
        Command = "deleteoutfit",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Outfit Name", Type = "string", Required = true, Placeholder = "Outfit name to delete" },
        },
    },
    {
        Name = "Moderate Outfit",
        Description = "Moderate (flag/remove) an outfit that violates content rules.",
        Icon = "rbxassetid://6034258833",
        Command = "moderateoutfit",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Outfit Name", Type = "string", Required = true, Placeholder = "Outfit name to moderate" },
        },
    },
    {
        Name = "View Outfit",
        Description = "View details of a player's saved outfit.",
        Icon = "rbxassetid://6034258833",
        Command = "viewoutfit",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
            { Name = "Outfit Name", Type = "string", Required = true, Placeholder = "Outfit name to view" },
        },
    },
    {
        Name = "Reset Outfit",
        Description = "Reset a player's outfit to the default avatar.",
        Icon = "rbxassetid://6034258833",
        Command = "resetoutfit",
        Arguments = {
            { Name = "Player", Type = "player", Required = true, Placeholder = "Enter player name..." },
        },
    },
}