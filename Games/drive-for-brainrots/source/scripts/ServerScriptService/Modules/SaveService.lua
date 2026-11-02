--!strict
-- Stub SaveService. Replace with DataStore calls for persistence.
local SaveService = {}
function SaveService.RestoreSlots(player: Player, plotModel: Model)
    -- No saved data on first session; SlotManager already handles fresh slots
end
function SaveService.RestoreInventory(player: Player)
    -- Nothing to restore on fresh session
end
return SaveService
