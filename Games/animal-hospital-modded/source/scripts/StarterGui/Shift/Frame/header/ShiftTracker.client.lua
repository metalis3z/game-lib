local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local Position = script.Parent.Position
local Size = script.Parent.Size

local function Update() --[[ Update | Line: 5 | Upvalues: Lib (copy), Size (copy), Position (copy) ]]
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 1
	}):Play()
	task.wait(1)
	script.Parent.Size = UDim2.new(Size.X.Scale * 2, 0, Size.Y.Scale * 2, 0)
	script.Parent.Position = UDim2.new(Position.X.Scale, 0, Position.Y.Scale + 0.8, 0)
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 0
	}):Play()
	task.wait(2)
	script.Parent:WaitForChild("text").Text = "Shift " .. game.Players:GetAttribute("Night")
	task.wait(3)
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 1
	}):Play()
	task.wait(1)
	script.Parent.Size = Size
	script.Parent.Position = Position
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 0
	}):Play()
end

local updating = false
local function SafeUpdate()
	if updating then return end
	updating = true
	Update()
	updating = false
end

game.Players:GetAttributeChangedSignal("Night"):Connect(SafeUpdate)
Lib.Inject("UpdateShiftTracker", SafeUpdate)

-- AL ENTRAR: el label venía con "Shift 1" escrito a mano y solo se actualizaba
-- cuando CAMBIABA el atributo Night, así que quien entraba con el turno ya
-- empezado (o reentraba) veía "Shift 1" para siempre. Ahora se escribe el turno
-- real apenas el atributo esté replicado, sin animación (no es un cambio de
-- turno, es ponerse al día).
task.spawn(function()
	local label = script.Parent:WaitForChild("text")
	local night = game.Players:GetAttribute("Night")

	for _ = 1, 100 do          -- ~10 s de margen para que replique
		if night then break end
		task.wait(0.1)
		night = game.Players:GetAttribute("Night")
	end

	if night and not updating then
		label.Text = "Shift " .. night
	end
end)