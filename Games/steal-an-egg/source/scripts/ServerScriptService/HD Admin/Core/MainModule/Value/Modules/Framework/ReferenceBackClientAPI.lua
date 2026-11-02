--!nocheck

-- This takes the place of the loader's ClientAPI after the framework moves the
-- real one into the ReplicatedStorage container
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hd = ReplicatedStorage:FindFirstChild("HD Admin")
return require(hd.Core.ClientAPI)
