button = script.Parent

regen = button.Parent.Regen



local debounce = false



function onButtonClicked()

	if debounce == false then

		debounce = true

		button.BrickColor = BrickColor.Black()

		regen.Value = 1

		wait(1)

		regen.Value = 0

		wait(5)

		button.BrickColor = BrickColor.new("Cyan")

		debounce = false

	end

end

script.Parent.ClickDetector.MouseClick:Connect(onButtonClicked)