
wait(0.5)
game.Workspace.The_Rake.Torso.DamagedParticles.Enabled = false
game.Workspace.The_Rake.Torso.DamageLight.Enabled = false
wait(0.6)
game.Workspace.The_Rake.Torso.DamageLight:Destroy()
game.Workspace.The_Rake.Torso.DamagedParticles:Destroy()
script:Destroy()