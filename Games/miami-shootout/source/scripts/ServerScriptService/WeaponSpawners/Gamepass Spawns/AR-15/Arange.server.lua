local sgi = game:GetService("StarterGui")
local ssh = script.Parent
local gs = script.Parent.Guns
local gp = script.Parent.GamePass
local sv = script.Parent.SpawnerViews
local ldr = script.Parent.Loader
local ws = game.Workspace


ssh.Parent = ws
gs.Parent = ssh
gp.Parent = ssh
sv.Parent = sgi
ldr.Parent = ssh
script:Destroy()


