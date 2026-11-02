script.Parent.Siren:Play()
wait(12.8)
script.Parent.Siren:Destroy()
script.Parent.Explode:Play()
wait(2)
game.ServerScriptService.DevProductHandler.NukeA.Value = true
wait(1)
script.Parent.Explode:Destroy()