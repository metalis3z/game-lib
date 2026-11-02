local Knit = require(game:GetService('ReplicatedStorage').Packages.Knit)
local RunService = game:GetService('RunService')

local DataController = Knit.CreateController({
  Name = 'DataController',
  replica = nil,
  data = nil,
})

local ReplicaClient

function DataController:waitForData()
  while not self.data do
    task.wait(0.1)
  end
end

function DataController:getData()
  return self.data
end

function DataController:KnitInit()
  ReplicaClient = require(Knit.Modules.ReplicaClient)
end

function DataController:KnitStart()
  -- KRYTYCZNE: najpierw zarejestruj OnNew, potem wyslij RequestData
  -- Inaczej odpowiedz serwera moze przyjsc przed callbackiem
  ReplicaClient.OnNew('playerData', function(replica)
    print('[DataController] Got playerData replica!')
    self.replica = replica
    self.data = replica.Data
    _G.dataLoaded = true
  end)
  -- Teraz wysylamy request
  ReplicaClient.RequestData()
  print('[DataController] RequestData sent')
end

return DataController