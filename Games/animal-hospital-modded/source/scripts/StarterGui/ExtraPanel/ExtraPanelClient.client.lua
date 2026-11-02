-- ExtraPanelClient
-- Maneja la seccion Weather del ExtraPanel:
--   [Select] abre/cierra la lista de climas (Header.Select)
--   elegir uno llena WeatherName + WeatherDuration con su duracion por defecto
--   [SET] lanza el clima con la duracion que haya en la caja
--
-- No destruye la GUI para los que no tienen acceso: el panel se gana a los 10
-- minutos, asi que hay que poder entregarselo despues. Quien no lo tiene
-- simplemente no ve el boton que lo abre (ExtraOpenClient) y, si igual llega
-- hasta aca, el SET le rebota. El que decide es ExtraPanelWeatherServer.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Access = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ExtraPanelAccess"))
local WeatherHandler = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeatherHandler"))

local player = Players.LocalPlayer
local gui = script.Parent

local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AdminWeather")

local main = gui:WaitForChild("Main")
local header = main:WaitForChild("Header")
local exitButton = header:WaitForChild("ExitButton")
local picker = header:WaitForChild("Select")
local list = picker:WaitForChild("ScrollingFrame")

local weather = main:WaitForChild("Contents"):WaitForChild("Weather")
-- OJO: weather.Select / weather.Name chocan con propiedades del Instance,
-- por eso todo lo de este frame se busca con WaitForChild y nunca con punto.
local selectButton = weather:WaitForChild("Select")
local addButton = weather:WaitForChild("AddButton")
local nameBox = weather:WaitForChild("WeatherName")
local durationBox = weather:WaitForChild("WeatherDuration")

local GROW_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Sine)

local function hoverGrow(button)
	local scale = button:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", button)
	button.MouseEnter:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1.05 }):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
	end)
	button.MouseButton1Down:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 0.9 }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(scale, GROW_INFO, { Scale = 1 }):Play()
	end)
end

-- 60 -> "1m", 90 -> "1m30s", 45 -> "45s"
local function formatDuration(seconds)
	seconds = math.floor(seconds)
	local minutes = math.floor(seconds / 60)
	local rest = seconds % 60
	if minutes > 0 and rest > 0 then
		return ("%dm%ds"):format(minutes, rest)
	elseif minutes > 0 then
		return ("%dm"):format(minutes)
	end
	return ("%ds"):format(rest)
end

-- acepta "90" (segundos pelados), "30s", "2m", "1m30s"
local function parseDuration(text)
	if type(text) ~= "string" then
		return nil
	end
	text = text:lower():gsub("%s", "")
	if text == "" then
		return nil
	end

	local plain = tonumber(text)
	if plain then
		return plain
	end

	local total, found = 0, false
	for value, unit in text:gmatch("(%d+%.?%d*)([ms])") do
		local amount = tonumber(value)
		if amount then
			total = total + (unit == "m" and amount * 60 or amount)
			found = true
		end
	end
	return found and total or nil
end

-- busca el clima sin importar mayusculas, asi tambien vale escribirlo a mano
local function resolveKey(text)
	if type(text) ~= "string" then
		return nil
	end
	local wanted = text:gsub("%s", ""):lower()
	if wanted == "" then
		return nil
	end
	for name in pairs(WeatherHandler.WheatherList) do
		if name:lower() == wanted then
			return name
		end
	end
	return nil
end

-- El boton SET hace de cartel de estado un par de segundos y vuelve a "SET".
local IDLE_TEXT = addButton.Text
local flashToken = 0

local function flash(message)
	flashToken += 1
	local mine = flashToken
	addButton.Text = message
	task.delay(2, function()
		if flashToken == mine and addButton.Parent then
			addButton.Text = IDLE_TEXT
		end
	end)
end

local function setPickerOpen(open)
	picker.Visible = open
end

local function apply()
	if not Access.canUse(player) then
		flash("LOCKED")
		return
	end

	local key = resolveKey(nameBox.Text)
	if not key then
		flash("?")
		return
	end

	local config = WeatherHandler.WheatherList[key]
	local seconds = parseDuration(durationBox.Text) or config.Time

	-- dejamos las cajas prolijas con lo que realmente se mando
	nameBox.Text = key
	durationBox.Text = formatDuration(seconds)

	setPickerOpen(false)
	remote:FireServer(key, seconds)
end

selectButton.MouseButton1Click:Connect(function()
	setPickerOpen(not picker.Visible)
end)

for _, button in ipairs(list:GetChildren()) do
	if button:IsA("ImageButton") then
		local key = button.Name
		hoverGrow(button)
		button.MouseButton1Click:Connect(function()
			local config = WeatherHandler.WheatherList[key]
			if not config then
				return
			end
			nameBox.Text = key
			durationBox.Text = formatDuration(config.Time)
			setPickerOpen(false)
		end)
	end
end

hoverGrow(selectButton)
hoverGrow(addButton)
hoverGrow(exitButton)

addButton.MouseButton1Click:Connect(apply)

-- Enter en la caja de duracion tambien lanza
durationBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		apply()
	end
end)

exitButton.MouseButton1Click:Connect(function()
	setPickerOpen(false)
	gui.Enabled = false
end)

remote.OnClientEvent:Connect(function(ok, message)
	if ok then
		flash("OK")
	else
		flash("ERROR")
		warn("[ExtraPanel] " .. tostring(message))
	end
end)

setPickerOpen(false)
