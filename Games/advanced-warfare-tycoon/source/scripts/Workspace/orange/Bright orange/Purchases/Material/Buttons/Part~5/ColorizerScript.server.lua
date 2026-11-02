wait(1)
mat = "Fabric"

function click()
	script.Parent.Parent.Parent.Parent.Parent.Material.Value = mat
end
script.Parent.ClickDetector.MouseClick:connect(click)