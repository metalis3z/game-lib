local ReplicatedFirst = game:GetService("ReplicatedFirst")

local client, server, shared = require(script:FindFirstChild("LoaderUtils", true)).toWallyFormat(script.src, false)

server.Name = "_SoftShutdownServerPackages"
server.Parent = script

client.Name = "_SoftShutdownClientPackages"
client.Parent = ReplicatedFirst

shared.Name = "_SoftShutdownSharedPackages"
shared.Parent = ReplicatedFirst

local clientScript = script.ClientScript
clientScript.Name = "QuentySoftShutdownClientScript"
clientScript:Clone().Parent = ReplicatedFirst

require(server.SoftShutdownService):Init()
