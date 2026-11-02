
wait(0.2)
game.Workspace.The_Rake.Torso.DamagedParticles.Enabled = false
local ice = game.ReplicatedStorage.Special.Ice:Clone()
ice.Parent = game.Workspace.The_Rake.HumanoidRootPart
ice.Weld.Part1 = game.Workspace.The_Rake.HumanoidRootPart
ice.Transparency = 0.6
ice.Anchored = true
ice.CanCollide = true
ice.Position = game.Workspace.The_Rake.HumanoidRootPart.Position
ice.Orientation = game.Workspace.The_Rake.HumanoidRootPart.Orientation
game.Workspace.The_Rake["Left Arm"].Anchored = true
game.Workspace.The_Rake["Left Leg"].Anchored = true
game.Workspace.The_Rake["Right Leg"].Anchored = true
game.Workspace.The_Rake["Right Arm"].Anchored = true
game.Workspace.The_Rake.Torso.Anchored = true
game.Workspace.The_Rake.Head.Anchored = true
wait(3)
ice:Destroy()
game.Workspace.The_Rake["Left Arm"].Anchored = false
game.Workspace.The_Rake["Left Leg"].Anchored = false
game.Workspace.The_Rake["Right Leg"].Anchored = false
game.Workspace.The_Rake["Right Arm"].Anchored = false
game.Workspace.The_Rake.Torso.Anchored = false
game.Workspace.The_Rake.Head.Anchored = false

game.Workspace.The_Rake.Torso.DamagedParticles:Destroy()
script:Destroy()