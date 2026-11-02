--[[ PetService - Equip/unequip/delete/lock/nickname pets. Slot count from upgrades. ]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require(ReplicatedStorage.Packages.Knit)

local BASE_PET_SLOTS = 3
local MAX_PET_NICKNAME_LENGTH = 20

local PetService = Knit.CreateService({
  Name = 'PetService',
  Client = {
    spawnPet     = Knit.CreateSignal(),
    despawnPet   = Knit.CreateSignal(),
    existUpdated = Knit.CreateSignal(),
    getExist     = Knit.CreateSignal(),
    requestPets  = Knit.CreateSignal(),
  },
  _ds  = nil,
  _upg = nil,
})

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
local function findPet(data, petId)
  if data.inventory and data.inventory.pet then
    return data.inventory.pet[petId]
  end
  return nil
end

local function getMaxSlots(data)
  local slots = BASE_PET_SLOTS
  slots += (data.upgrades and data.upgrades.petsEquipped or 0)
  if data.passes and data.passes.petEquip2 then slots += 2 end
  if data.passes and data.passes.petEquip3 then slots += 3 end
  return slots
end

local function countEquipped(data)
  local count = 0
  if not data.equippedPets then return 0 end
  for _ in data.equippedPets do count += 1 end
  return count
end

------------------------------------------------------------------------
-- Client: equipPet (accepts single petId string or array of petIds)
------------------------------------------------------------------------
function PetService.Client:equipPet(player, petIds)
  local data = self.Server._ds:GetData(player)
  if not data then return "fail" end
  if type(petIds) == "string" then petIds = {petIds} end
  for _, petId in petIds do
    if data.equippedPets and data.equippedPets[petId] then continue end
    local pet = findPet(data, petId)
    if not pet then continue end
    local maxSlots = getMaxSlots(data)
    if countEquipped(data) >= maxSlots then break end
    self.Server._ds:Set(player, {'equippedPets', petId}, true)
    self.Server.Client.spawnPet:Fire(player, player, petId, pet)
  end
  return "success"
end

------------------------------------------------------------------------
-- Client: unequipPet (accepts single petId string or array of petIds)
------------------------------------------------------------------------
function PetService.Client:unequipPet(player, petIds)
  local data = self.Server._ds:GetData(player)
  if not data then return "fail" end
  if type(petIds) == "string" then petIds = {petIds} end
  for _, petId in petIds do
    if not data.equippedPets or not data.equippedPets[petId] then continue end
    self.Server._ds:Set(player, {'equippedPets', petId}, nil)
    self.Server.Client.despawnPet:Fire(player, petId)
  end
  return "success"
end

------------------------------------------------------------------------
-- Client: deletePet
------------------------------------------------------------------------
function PetService.Client:deletePet(player, petId)
  local data = self.Server._ds:GetData(player)
  if not data then return end
  local pet = findPet(data, petId)
  if not pet then return end
  if pet.lk then
    warn('[PetService] deletePet: pet is locked', petId)
    return
  end
  if data.equippedPets and data.equippedPets[petId] then
    self.Server._ds:Set(player, {'equippedPets', petId}, nil)
    self.Server.Client.despawnPet:Fire(player, petId)
  end
  -- Remove from inventory
  self.Server._ds:Set(player, {'inventory', 'pet', petId}, nil)
end

------------------------------------------------------------------------
-- Client: toggleLock
------------------------------------------------------------------------
function PetService.Client:toggleLock(player, petId)
  local data = self.Server._ds:GetData(player)
  if not data then return "fail" end
  local pet = findPet(data, petId)
  if not pet then return "fail" end
  local newLocked = not pet.lk
  self.Server._ds:Set(player, {'inventory', 'pet', petId, 'lk'}, newLocked)
  return "success", newLocked
end

------------------------------------------------------------------------
-- Client: lockPet
------------------------------------------------------------------------
function PetService.Client:lockPet(player, petId, locked)
  local data = self.Server._ds:GetData(player)
  if not data then return end
  local pet = findPet(data, petId)
  if not pet then return end
  self.Server._ds:Set(player, {'inventory', 'pet', petId, 'lk'}, locked == true)
end

------------------------------------------------------------------------
-- Client: setNickname
------------------------------------------------------------------------
function PetService.Client:setNickname(player, petId, nickname)
  local data = self.Server._ds:GetData(player)
  if not data then return end
  if type(nickname) ~= 'string' then return end
  nickname = nickname:sub(1, MAX_PET_NICKNAME_LENGTH)
  local pet = findPet(data, petId)
  if not pet then return end
  self.Server._ds:Set(player, {'inventory', 'pet', petId, 'nickname'}, nickname)
end

------------------------------------------------------------------------
-- Client: archivePet
------------------------------------------------------------------------
function PetService.Client:archivePet(player, petId)
  local data = self.Server._ds:GetData(player)
  if not data then return end
  if data.equippedPets and data.equippedPets[petId] then
    self.Server._ds:Set(player, {'equippedPets', petId}, nil)
    self.Server.Client.despawnPet:Fire(player, petId)
  end
end

function PetService:KnitInit()
  self._ds  = Knit.GetService('DataService')
  self._upg = Knit.GetService('UpgradeService')
  
  self.Client.requestPets:Connect(function(player)
    local data = self._ds:GetData(player)
    if not data then return end
    if data.equippedPets then
      for petId, _ in data.equippedPets do
        local pet = findPet(data, petId)
        if pet then
          self.Client.spawnPet:Fire(player, player, petId, pet)
        end
      end
    end
  end)
  
  self.Client.getExist:Connect(function(player, petDescriptor)
    local data = self._ds:GetData(player)
    if not data then return end
    self.Client.existUpdated:Fire(player, petDescriptor, {
      exist = true,
      updated = os.time(),
    })
  end)
end

function PetService:KnitStart()
  print('[PetService] Started')
end

return PetService