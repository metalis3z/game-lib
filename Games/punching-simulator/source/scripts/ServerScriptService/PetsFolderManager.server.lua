local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetsModule = require(ReplicatedStorage.Common.Modules.Databases.Pets.Pets)

-- Function to add a PetsFolder to a player
local function addPetsFolder(player)
    local petsFolder = Instance.new("Folder")
    petsFolder.Name = "PetsFolder"
    petsFolder.Parent = player
end

-- Function to give a pet to a player
local function givePet(player, petName)
    local petsFolder = player:FindFirstChild("PetsFolder")
    if not petsFolder then
        warn("PetsFolder not found for player: "..player.Name)
        return
    end
    
    -- Check if the pet exists in the PetsModule
    local petInfo = PetsModule[petName]
    if not petInfo then
        warn("Pet not found: "..petName)
        return
    end
    
    -- Create a new instance of the pet and parent it to the PetsFolder
    local petInstance = Instance.new("StringValue") -- Using StringValue as a placeholder for the pet instance
    petInstance.Name = petName
    petInstance.Value = petInfo -- Assuming petInfo is a string or similar for demonstration
    petInstance.Parent = petsFolder
end

-- Listen for players joining the game
Players.PlayerAdded:Connect(function(player)
    addPetsFolder(player)
    
    -- Listen for chat messages to give pets
    player.Chatted:Connect(function(message)
        if message:sub(1, 8) == "!givepet" then
            local petName = message:sub(10) -- Extract the pet name from the command
            givePet(player, petName)
        end
    end)
end)