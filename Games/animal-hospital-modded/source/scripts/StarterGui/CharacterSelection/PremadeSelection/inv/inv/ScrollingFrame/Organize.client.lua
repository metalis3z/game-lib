
local v1 = game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Characters"):GetChildren()
local t = { game.CreatorId, 10442464072 }

-- Modelos de la selección de personajes: carpeta SEPARADA (set completo de 22)
-- para no tocar el NPCs.UniqueVisitors original que usa el gameplay.
local visitorsFolder = game.ReplicatedStorage.NPCs:WaitForChild("UniqueVisitors1")

for k, v in pairs(v1) do
	local model = visitorsFolder:FindFirstChild(v.Name)

	-- Blindaje: si algún personaje no tiene su modelo, lo saltamos en vez de crashear.
	if not model then
		warn("[CharacterSelect] Falta el modelo de NPC en UniqueVisitors1: " .. v.Name)
		continue
	end

	local v2 = script.Parent.Template:Clone()
	local v3 = model:Clone()
	local v4 = require(v)
	local v5 = CFrame.new(-70.5820541, 2.07803416, -318.024048, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1)

	v2.Name = v.Name
	v2.text.Text = v4.Name
	v3.Parent = v2.ViewportFrame.WorldModel

	local hrp = v3:FindFirstChild("HumanoidRootPart") or v3.PrimaryPart
	if hrp then
		hrp.Anchored = true
	end

	v3:PivotTo(v5)
	v2.Visible = true
	v2.Parent = script.Parent

	if v4.Dev and not table.find(t, game.Players.LocalPlayer.UserId) then
		v2:Destroy()
	end
end
