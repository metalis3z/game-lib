
wait(0.2)
local ice = game.ReplicatedStorage.Special.Ice2:Clone()
ice.Parent = game.Workspace.The_Rake.HumanoidRootPart
ice.Anchored = true
ice.CanCollide = true
ice.Position = game.Workspace.The_Rake.Torso.Position
ice.Orientation = game.Workspace.The_Rake.Torso.Orientation
game.Workspace.The_Rake["Left Arm"].Anchored = true
game.Workspace.The_Rake["Left Leg"].Anchored = true
game.Workspace.The_Rake["Right Leg"].Anchored = true
game.Workspace.The_Rake["Right Arm"].Anchored = true
game.Workspace.The_Rake.Torso.Anchored = true
game.Workspace.The_Rake.Head.Anchored = true
wait(0.5)
ice.CanCollide = false
game.Workspace.The_Rake["Left Arm"].Anchored = false
game.Workspace.The_Rake["Left Leg"].Anchored = false
game.Workspace.The_Rake["Right Leg"].Anchored = false
game.Workspace.The_Rake["Right Arm"].Anchored = false
game.Workspace.The_Rake.Torso.Anchored = false
game.Workspace.The_Rake.Head.Anchored = false
script:Destroy()