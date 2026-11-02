-- Este Script es un PLUGIN (usa `plugin`). Como Script normal en ServerScriptService
-- `plugin` es nil, así que salimos sin hacer nada (solo funciona instalado como plugin).
if not plugin then return end

-- 1. Crear la barra de herramientas superior
local pluginMenu = plugin:CreateToolbar("Ryders Tools")
local botonMenu = pluginMenu:CreateButton(
	"Fix Uniones Menu", 
	"Abre la interfaz para recuperar uniones corruptas", 
	"rbxassetid://4483345998"
)

-- 2. Crear la interfaz gráfica flotante (DockWidget)
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, -- Aparece flotando
	false,                       -- Empieza cerrada por defecto
	false,                      -- No guarda el estado anterior para evitar bugs
	200, 120,                   -- Ancho y alto inicial
	150, 100                    -- Ancho y alto mínimo
)

local pluginGui = plugin:CreateDockWidgetPluginGui("FixUnionesWidget", widgetInfo)
pluginGui.Title = "Ryders Tools - Fix Uniones"

-- 3. Crear el diseño visual de la interfaz (Sin usar instancias externas)
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Color oscuro tipo Studio
background.BorderSizePixel = 0
background.Parent = pluginGui

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = background

local botonReparar = Instance.new("TextButton")
botonReparar.Size = UDim2.new(1, 0, 1, 0) -- Rellena la ventana
botonReparar.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- Azul llamativo
botonReparar.TextColor3 = Color3.fromRGB(255, 255, 255)
botonReparar.Text = "Reparar Modelo\nSeleccionado"
botonReparar.Font = Enum.Font.SourceSansBold
botonReparar.TextSize = 16
botonReparar.Parent = background

-- Redondear las esquinas del botón para que se vea moderno
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 6)
uiCorner.Parent = botonReparar

-- 4. Función para abrir/cerrar la ventana al tocar el botón de la barra superior
botonMenu.Click:Connect(function()
	pluginGui.Enabled = not pluginGui.Enabled
end)

-- 5. Recuperación: reemplaza cada UnionOperation corrupta por un Part FIEL (misma
--    pose, color, material, transparencia), CONSERVANDO sus hijos (ClickDetector,
--    Sounds, Attachments, Decals...), atributos, tags y re-cableando las juntas
--    (Motor6D / Weld / WeldConstraint / etc.) que lo referenciaban.
--    NOTA: la FORMA no se puede recuperar (la malla del union está corrupta, CSG -6):
--    queda una CAJA editable con todo lo demás intacto.
local CollectionService = game:GetService("CollectionService")

-- Propiedades de BasePart a copiar (con pcall: algunas podrían no aplicar).
local PROPS = {
	"Anchored", "CanCollide", "CanTouch", "CanQuery", "CastShadow", "Color",
	"Material", "MaterialVariant", "Reflectance", "Massless", "Locked",
	"CollisionGroup", "RootPriority",
}

-- Adivina un Shape primitivo por las PROPORCIONES del bounding box. Es solo una
-- APROXIMACIÓN (dos formas distintas pueden tener el mismo Size): no es exacto.
local function guessShape(size)
	local x, y, z = size.X, size.Y, size.Z
	local function close(a, b) return math.abs(a - b) <= 0.15 * math.max(a, b) end
	if close(y, z) and not close(x, y) then
		return Enum.PartType.Cylinder   -- dos lados iguales + uno distinto -> cilindro (eje X)
	end
	return Enum.PartType.Block          -- por defecto caja (lo más común); esfera se pone a mano
end

local function reemplazarUnion(obj, modelo, nuevas)
	-- 1) INTENTO REAL: separar el union en sus partes originales (recupera la FORMA).
	--    Solo funciona si el union NO está corrupto (y si el plugin tiene permiso CSG).
	do
		local sepParts
		local ok = pcall(function() sepParts = obj:SeparateAsync() end)
		if ok and sepParts and #sepParts > 0 then
			for _, p in ipairs(sepParts) do table.insert(nuevas, p) end
			return
		end
	end

	-- 2) FALLBACK (union corrupto, CSG -6): Part fiel conservando todo.
	-- raíz para buscar juntas: si seleccionaron el union directo, usamos su padre.
	local scanRoot = (modelo == obj) and (obj.Parent or obj) or modelo

	local nuevaParte = Instance.new("Part")
	nuevaParte.Name = obj.Name
	nuevaParte.Size = obj.Size
	nuevaParte.CFrame = obj.CFrame
	nuevaParte.Shape = guessShape(obj.Size)   -- aproximación de forma por proporciones
	for _, prop in ipairs(PROPS) do
		pcall(function() nuevaParte[prop] = obj[prop] end)
	end
	-- Transparencia fiel; si estaba casi invisible (union sin malla) la hacemos
	-- visible para que puedas verla y editarla.
	nuevaParte.Transparency = (obj.Transparency >= 0.9) and 0 or obj.Transparency

	-- Atributos y tags (CollectionService)
	for k, v in pairs(obj:GetAttributes()) do
		nuevaParte:SetAttribute(k, v)
	end
	for _, tag in ipairs(CollectionService:GetTags(obj)) do
		CollectionService:AddTag(nuevaParte, tag)
	end

	-- Hijos (ClickDetector, Sound, Attachment, Decal, luces, welds internos...)
	for _, ch in ipairs(obj:GetChildren()) do
		ch.Parent = nuevaParte
	end

	nuevaParte.Parent = obj.Parent

	-- Re-cablear cualquier junta que apuntara al union (Motor6D/Weld/WeldConstraint...)
	for _, j in ipairs(scanRoot:GetDescendants()) do
		pcall(function() if j.Part0 == obj then j.Part0 = nuevaParte end end)
		pcall(function() if j.Part1 == obj then j.Part1 = nuevaParte end end)
	end

	if modelo:IsA("Model") and modelo.PrimaryPart == obj then
		modelo.PrimaryPart = nuevaParte
	end

	obj:Destroy()
	table.insert(nuevas, nuevaParte)
end

local function ejecutarRecuperacion()
	local Selection = game:GetService("Selection")
	local seleccion = Selection:Get()
	if #seleccion == 0 then return end

	local ChangeHistoryService = game:GetService("ChangeHistoryService")
	ChangeHistoryService:SetWaypoint("AntesDeRecuperarUniones")

	local nuevas = {}
	for _, modelo in ipairs(seleccion) do
		local objetivos = {}
		if modelo:IsA("UnionOperation") then
			table.insert(objetivos, modelo)
		end
		for _, d in ipairs(modelo:GetDescendants()) do
			if d:IsA("UnionOperation") then
				table.insert(objetivos, d)
			end
		end
		for _, u in ipairs(objetivos) do
			reemplazarUnion(u, modelo, nuevas)
		end
	end

	if #nuevas > 0 then
		Selection:Set(nuevas)   -- deja seleccionadas las partes recuperadas
	end
	ChangeHistoryService:SetWaypoint("UnionesRecuperadas")
	print(("[Restauracion] %d union(es) recuperada(s) como Part."):format(#nuevas))
end

-- 6. Conectar el botón de la interfaz con la función
botonReparar.MouseButton1Click:Connect(ejecutarRecuperacion)