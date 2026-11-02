--!nocheck

-- This takes the place of the loader's CommandAPI (and fills the ServerStorage
-- container's Core) after the framework moves the real one into ReplicatedStorage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hd = ReplicatedStorage:FindFirstChild("HD Admin")
return require(hd.Core.CommandAPI)
