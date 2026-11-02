local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

task.spawn(ContentProvider.PreloadAsync, ContentProvider, script.Parent:GetDescendants())

local SantasSleigh = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("SantasSleigh")

task.spawn(ContentProvider.PreloadAsync, ContentProvider, SantasSleigh:GetDescendants())
