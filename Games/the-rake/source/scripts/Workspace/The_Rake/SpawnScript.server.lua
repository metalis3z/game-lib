repeat
	wait()
	script.Parent.NPC:MoveTo(workspace.CavePart.Position)
until script.Stop.Value == true