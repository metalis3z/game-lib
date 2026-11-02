--[[ ReplicaClient - Client-side replica system. Receives data from ReplicaServer. ]]
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Remotes = ReplicatedStorage.Shared:WaitForChild('ReplicaEvents', 30)
assert(Remotes, '[ReplicaClient] ReplicaEvents folder not found!')

local ECreate  = Remotes:WaitForChild('ReplicaCreate', 10)
local ESet     = Remotes:WaitForChild('ReplicaSet', 10)
local ESetVals = Remotes:WaitForChild('ReplicaSetValues', 10)
local EInsert  = Remotes:WaitForChild('ReplicaTableInsert', 10)
local ERemove  = Remotes:WaitForChild('ReplicaTableRemove', 10)
local EDestroy = Remotes:WaitForChild('ReplicaDestroy', 10)
local ESignal  = Remotes:WaitForChild('ReplicaSignal', 10)
local ERequest = Remotes:WaitForChild('ReplicaRequestData', 10)

-- Internal state
local replicas   = {}   -- [id] = replica
local listeners  = {}   -- [token] = { onCreate = {fn}, onDestroy = {fn} }
local isReady    = false
local requested  = false

-- Replica class
local Replica = {}
Replica.__index = Replica

local function getPath(data, path)
  local cur = data
  for i = 1, #path do
    cur = cur[path[i]]
    if cur == nil then return nil end
  end
  return cur
end

local function setPath(data, path, value)
  local cur = data
  for i = 1, #path - 1 do
    local k = path[i]
    if cur[k] == nil then cur[k] = {} end
    cur = cur[k]
  end
  cur[path[#path]] = value
end

-- OnSet: fire callback when a path changes
function Replica:OnSet(path, callback)
  if not self._listeners then self._listeners = {} end
  local key = table.concat(path, '.')
  if not self._listeners[key] then self._listeners[key] = {} end
  table.insert(self._listeners[key], callback)
  return {
    Disconnect = function()
      local t = self._listeners[key]
      if not t then return end
      for i, fn in t do
        if fn == callback then table.remove(t, i) break end
      end
    end
  }
end

function Replica:_fireListeners(path, value)
  if not self._listeners then return end
  -- fire exact path match
  local key = table.concat(path, '.')
  local fns = self._listeners[key]
  if fns then
    for _, fn in fns do
      task.spawn(fn, value)
    end
  end
  -- fire parent paths
  if #path > 1 then
    local parentPath = {}
    for i = 1, #path - 1 do parentPath[i] = path[i] end
    self:_fireListeners(parentPath, getPath(self.Data, parentPath))
  end
end

-- Module
local ReplicaClient = {}
ReplicaClient.IsReady = false

function ReplicaClient.RequestData()
  if requested then return end
  requested = true
  task.spawn(function()
    ERequest:FireServer()
    -- Retry every 2s until confirmed
    while not ReplicaClient.IsReady do
      task.wait(2)
      if not ReplicaClient.IsReady then
        ERequest:FireServer()
      end
    end
  end)
end

function ReplicaClient.OnNew(token, callback)
  if not listeners[token] then
    listeners[token] = {onCreate = {}, onDestroy = {}}
  end
  table.insert(listeners[token].onCreate, callback)
  -- If replicas already exist with this token, fire immediately
  for _, replica in replicas do
    if replica.Token == token then
      task.spawn(callback, replica)
    end
  end
end

function ReplicaClient.OnDestroy(token, callback)
  if not listeners[token] then
    listeners[token] = {onCreate = {}, onDestroy = {}}
  end
  table.insert(listeners[token].onDestroy, callback)
end

function ReplicaClient.GetReplica(id)
  return replicas[id]
end

-- Handle replica creation batch from server
ECreate.OnClientEvent:Connect(function(packets)
  for _, packet in packets do
    -- packet = {id, token, tags, data, parentId}
    local id, token, tags, data = packet[1], packet[2], packet[3], packet[4]
    local replica = setmetatable({
      Id       = id,
      Token    = token,
      Tags     = tags,
      Data     = data,
      _listeners = {},
    }, Replica)
    replicas[id] = replica
    -- Fire OnNew listeners
    local tokenListeners = listeners[token]
    if tokenListeners then
      for _, fn in tokenListeners.onCreate do
        task.spawn(fn, replica)
      end
    end
  end
end)

-- Handle server confirmation that initial data was sent
ERequest.OnClientEvent:Connect(function()
  ReplicaClient.IsReady = true
  isReady = true
end)

-- Handle Set
ESet.OnClientEvent:Connect(function(id, path, value)
  local replica = replicas[id]
  if not replica then return end
  setPath(replica.Data, path, value)
  replica:_fireListeners(path, value)
end)

-- Handle SetValues
ESetVals.OnClientEvent:Connect(function(id, path, values)
  local replica = replicas[id]
  if not replica then return end
  local target = getPath(replica.Data, path)
  if target then
    for k, v in values do
      target[k] = v
    end
  end
  replica:_fireListeners(path, values)
end)

-- Handle TableInsert
EInsert.OnClientEvent:Connect(function(id, path, value, index)
  local replica = replicas[id]
  if not replica then return end
  local t = getPath(replica.Data, path)
  if t then
    if index then
      table.insert(t, index, value)
    else
      table.insert(t, value)
    end
  end
  replica:_fireListeners(path, t)
end)

-- Handle TableRemove
ERemove.OnClientEvent:Connect(function(id, path, index)
  local replica = replicas[id]
  if not replica then return end
  local t = getPath(replica.Data, path)
  if t then table.remove(t, index) end
  replica:_fireListeners(path, t)
end)

-- Handle Destroy
EDestroy.OnClientEvent:Connect(function(id)
  local replica = replicas[id]
  if not replica then return end
  local tokenListeners = listeners[replica.Token]
  if tokenListeners then
    for _, fn in tokenListeners.onDestroy do
      task.spawn(fn, replica)
    end
  end
  replicas[id] = nil
end)

return ReplicaClient