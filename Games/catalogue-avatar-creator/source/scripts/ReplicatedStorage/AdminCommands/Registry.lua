--[[
    Admin Command Registry
    Central module that loads all command category modules and provides
    a structured API for the AdminController to query commands.
    
    Security: This module only contains command METADATA (names, descriptions,
    argument definitions). It does NOT contain any executable server logic.
    All command execution is routed through Cmdr's CmdrFunction RemoteFunction,
    which validates permissions server-side via the PermissionChecker module.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AdminCommands = ReplicatedStorage:WaitForChild("AdminCommands")
local Categories = AdminCommands:WaitForChild("Categories")

-- Category display metadata
local CategoryInfo = {
    Moderation = { DisplayName = "Moderation", Icon = "rbxassetid://6034258833", Order = 1 },
    Movement = { DisplayName = "Movement", Icon = "rbxassetid://6034258833", Order = 2 },
    Communication = { DisplayName = "Announce", Icon = "rbxassetid://6034258833", Order = 3 },
    PlayerManagement = { DisplayName = "Player", Icon = "rbxassetid://6034258833", Order = 4 },
    OutfitManagement = { DisplayName = "Outfits", Icon = "rbxassetid://6034258833", Order = 5 },
    Utility = { DisplayName = "Utility", Icon = "rbxassetid://6034258833", Order = 6 },
}

-- Load all category modules
local Registry = {}
Registry.Categories = {}
Registry.Commands = {}
Registry.CommandsByCategory = {}

-- Build sorted category list
local sortedCategoryNames = {}
for name, info in pairs(CategoryInfo) do
    table.insert(sortedCategoryNames, name)
end
table.sort(sortedCategoryNames, function(a, b)
    return CategoryInfo[a].Order < CategoryInfo[b].Order
end)

for _, categoryName in ipairs(sortedCategoryNames) do
    local module = Categories:FindFirstChild(categoryName)
    if module then
        local success, commands = pcall(require, module)
        if success and type(commands) == "table" then
            local categoryData = {
                Name = categoryName,
                DisplayName = CategoryInfo[categoryName].DisplayName,
                Icon = CategoryInfo[categoryName].Icon,
                Order = CategoryInfo[categoryName].Order,
                Commands = commands,
            }
            
            table.insert(Registry.Categories, categoryData)
            Registry.CommandsByCategory[categoryName] = commands
            
            for _, cmd in ipairs(commands) do
                cmd.Category = categoryName
                table.insert(Registry.Commands, cmd)
            end
        end
    end
end

-- API: Get all categories sorted by order
function Registry.GetCategories()
    return Registry.Categories
end

-- API: Get commands for a specific category
function Registry.GetCommandsByCategory(categoryName)
    return Registry.CommandsByCategory[categoryName] or {}
end

-- API: Get all commands (flat list)
function Registry.GetAllCommands()
    return Registry.Commands
end

-- API: Search commands by keyword (matches name or description)
function Registry.SearchCommands(query)
    if not query or query == "" then
        return Registry.Commands
    end
    
    query = string.lower(query)
    local results = {}
    for _, cmd in ipairs(Registry.Commands) do
        if string.find(string.lower(cmd.Name), query, 1, true) 
            or string.find(string.lower(cmd.Description), query, 1, true)
            or string.find(string.lower(cmd.Command), query, 1, true) then
            table.insert(results, cmd)
        end
    end
    return results
end

-- API: Find a command by its command string
function Registry.FindByCommand(commandStr)
    for _, cmd in ipairs(Registry.Commands) do
        if cmd.Command == commandStr then
            return cmd
        end
    end
    return nil
end

return Registry