wait(1)
mat = "Granite"

function click()
	script.Parent.Parent.Parent.Color.Material = script.Parent.Material
end
script.Parent.ClickDetector.MouseClick:connect(click)