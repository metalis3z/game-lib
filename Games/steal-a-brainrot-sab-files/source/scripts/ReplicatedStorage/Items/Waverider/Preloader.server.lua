local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

task.spawn(ContentProvider.PreloadAsync, ContentProvider, script.Parent:GetDescendants())

local Waverider = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")

task.spawn(ContentProvider.PreloadAsync, ContentProvider, Waverider:GetDescendants())