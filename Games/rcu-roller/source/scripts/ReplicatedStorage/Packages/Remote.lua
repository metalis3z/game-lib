--[[ Remote - Lightweight RemoteEvent wrapper for Replica system (FIXED FireServer) ]]
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local isServer = RunService:IsServer()

local container

if isServer then
  container = ReplicatedStorage.Shared:FindFirstChild('ReplicaEvents')
  if not container then
    container = Instance.new('Folder')
    container.Name = 'ReplicaEvents'
    container.Parent = ReplicatedStorage.Shared
  end
else
  -- Client: wait for container synchronously via WaitForChild
  container = ReplicatedStorage.Shared:WaitForChild('ReplicaEvents', 30)
end

local Connection = {}
Connection.__index = Connection
function Connection.New(fn)
  return setmetatable({fn=fn, is_disconnected=false, real_connection=nil}, Connection)
end
function Connection:Disconnect()
  self.is_disconnected = true
  if self.real_connection then self.real_connection:Disconnect() end
end

local Remote = {}
Remote.__index = Remote
local definedRemotes = {}

function Remote.New(name, unreliable)
  if type(name) ~= 'string' then error('[Remote]: name must be a string') end

  if isServer then
    if definedRemotes[name] then
      error('[Remote]: RemoteEvent '..name..' was already defined')
    end
    definedRemotes[name] = true
    local className = unreliable and 'UnreliableRemoteEvent' or 'RemoteEvent'
    local remote = Instance.new(className)
    remote.Name = name
    remote.Parent = container
    return remote
  end

  -- Client: find or wait for the RemoteEvent
  local remoteEvent = container and container:FindFirstChild(name)
  if not remoteEvent and container then
    remoteEvent = container:WaitForChild(name, 30)
  end

  if not remoteEvent then
    warn('[Remote]: RemoteEvent ' .. name .. ' not found after 30s')
  end

  local proxy = setmetatable({
    RemoteEvent = remoteEvent,
    OnClientEvent = {
      Connect = function(_self, fn)
        if remoteEvent then
          return remoteEvent.OnClientEvent:Connect(fn)
        end
        warn('[Remote]: Cannot connect to ' .. name .. ' - RemoteEvent not found')
        return {Disconnect = function() end}
      end,
    },
    OnServerEvent = {
      Connect = function()
        error('[Remote]: Cannot connect to OnServerEvent client-side')
      end,
    },
  }, Remote)

  return proxy
end

function Remote:FireServer(...)
  if self.RemoteEvent then
    self.RemoteEvent:FireServer(...)
  else
    warn('[Remote]: FireServer called but RemoteEvent is nil')
  end
end

function Remote:FireClient()
  error('[Remote]: Cannot use FireClient client-side')
end

function Remote:FireAllClients()
  error('[Remote]: Cannot use FireAllClients client-side')
end

return Remote