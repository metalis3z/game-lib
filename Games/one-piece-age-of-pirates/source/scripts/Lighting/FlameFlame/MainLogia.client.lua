wait(1)

script.HeadLogia.Disabled = false
script.LeftArmLogia.Disabled = false
script.LeftLegLogia.Disabled = false
script.RightArmLogia.Disabled = false
script.RightLegLogia.Disabled = false
script.TorsoLogia.Disabled = false

logia = Instance.new("BoolValue")
logia.Parent = game.Players.LocalPlayer.Data
logia.Name = "Logia"
logia.Value = true