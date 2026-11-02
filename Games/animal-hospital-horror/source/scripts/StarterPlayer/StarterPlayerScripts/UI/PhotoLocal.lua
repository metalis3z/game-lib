--[[
	PhotoLocal  (cliente — sostiene la polaroid frente a la cámara)

	La PhotoUI es una SurfaceGui adornada a `ReplicatedStorage.Misc.Photo.Picture`
	(una FOTO física, no un overlay). UI.PhotoSystem.RevealPhoto habilita la
	SurfaceGui y llena su ViewportFrame con el visitante, PERO nadie mueve el modelo
	`Photo` al mundo -> como la parte Picture está en ReplicatedStorage no se ve nada.

	Este módulo (faltaba en el leak) posiciona la polaroid frente a la cámara del
	jugador mientras la foto está activa (PhotoUI.Enabled), y la devuelve a
	ReplicatedStorage al cerrarse. Así, al usar el prompt "Photo", la polaroid
	aparece sostenida frente a ti mostrando la foto (con el impostor sin cara).
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))

local Misc = ReplicatedStorage:WaitForChild("Misc")
local PhotoModel = Misc:WaitForChild("Photo")
local PhotoUI = Lib.UI.Get("PhotoUI")

local conn

-- Coloca la polaroid ~2 studs frente a la cámara, con la cara Picture mirándola.
local function positionInFront()
	local cam = workspace.CurrentCamera
	local picture = PhotoModel:FindFirstChild("Picture")
	if not (cam and picture) then return end

	local targetPos = (cam.CFrame * CFrame.new(0, -0.4, -2.2)).Position
	-- Picture debe MIRAR a la cámara: su cara Front (-Z) apunta a la cámara.
	local desired = CFrame.lookAt(targetPos, cam.CFrame.Position)

	-- Mueve el MODELO para que la parte Picture quede en `desired`
	local relative = PhotoModel:GetPivot():ToObjectSpace(picture.CFrame)
	PhotoModel:PivotTo(desired * relative:Inverse())
end

local function show()
	for _, p in ipairs(PhotoModel:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = true
			p.CanCollide = false
			p.CanQuery = false
		elseif p:IsA("ProximityPrompt") then
			p.Enabled = false -- evita un prompt fantasma en la polaroid flotante
		end
	end
	PhotoModel.Parent = workspace
	positionInFront()
	if conn then conn:Disconnect() end
	conn = RunService.RenderStepped:Connect(positionInFront)
end

local function hide()
	if conn then conn:Disconnect(); conn = nil end
	if PhotoModel.Parent ~= Misc then
		PhotoModel.Parent = Misc
	end
end

PhotoUI:GetPropertyChangedSignal("Enabled"):Connect(function()
	if PhotoUI.Enabled then
		show()
	else
		hide()
	end
end)

-- por si ya estaba activa al cargar
if PhotoUI.Enabled then show() end

return {}
