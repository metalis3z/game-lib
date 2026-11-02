local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
drums = model


drums.Kick.ClickDetector.MouseClick:connect(function() workspace.Main.FurnitureSound:FireAllClients(drums.Kick.Sound,model,"Play") end)
drums.Snare.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Snare.Sound,model,"Play") end)
drums.HiHat.ClickDetector.MouseClick:connect(function() workspace.Main.FurnitureSound:FireAllClients(drums.HiHat.Sound,model,"Play") end)
drums.Crash.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Crash.Sound,model,"Play") end)
drums.Ride.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Ride.Sound,model,"Play") end)
drums.Tom1.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Tom1.Sound,model,"Play") end)
drums.Tom2.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Tom2.Sound,model,"Play") end)
drums.Tom3.ClickDetector.MouseClick:connect(function()  workspace.Main.FurnitureSound:FireAllClients(drums.Tom3.Sound,model,"Play") end)
