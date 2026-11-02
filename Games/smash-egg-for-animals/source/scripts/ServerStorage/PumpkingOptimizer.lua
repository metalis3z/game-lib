-- Outil d'édition (pas utilisé en jeu) : allège un gardien fait de milliers de petites pièces (le Pumpking : 3 382 pièces soudées).
-- Dans chaque segment du squelette (Neck, Body, Tail1...), les pièces de décor de même matière sont fusionnées en quelques unions,
-- soudées à la pièce d'articulation (JointPart) comme avant. L'apparence ne change pas (couleurs de chaque pièce gardées, arêtes
-- vives), mais le moteur n'a plus que quelques dizaines de pièces à déplacer à chaque image au lieu de milliers.
-- Les articulations (JointPart, soudures PK), les lumières et les effets ne sont pas touchés.
--   return function(model, report?) -> nombre de pièces avant, après.   report(texte) est appelé pendant le travail (il est long).
local CHUNK = 70 -- pièces par union au maximum (au-delà, la fusion devient lente ou échoue)

local function keyOf(part)
	return table.concat({part.Material.Name, part.MaterialVariant, tostring(part.Transparency), tostring(part.Reflectance), tostring(part.CastShadow)}, "|")
end

-- fusionne une liste de pièces ; si la fusion échoue, on la coupe en deux et on recommence
local function fuse(parts, out)
	if #parts == 1 then
		table.insert(out, {Union = parts[1], Sources = {}})
		return
	end
	local rest = table.clone(parts)
	local first = table.remove(rest, 1)
	local ok, union = pcall(function() return first:UnionAsync(rest, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise) end)
	if ok and union then
		table.insert(out, {Union = union, Sources = parts})
	else
		local half = math.floor(#parts / 2)
		local a, b = {}, {}
		for i, p in parts do table.insert(i <= half and a or b, p) end
		fuse(a, out)
		fuse(b, out)
	end
end

return function(model, report)
	report = report or function() end
	local before, after = 0, 0
	for _, d in model:GetDescendants() do if d:IsA("BasePart") then before += 1 end end
	local segments = {}
	for _, segment in model:GetChildren() do
		if segment:IsA("Model") and segment:FindFirstChild("JointPart") then table.insert(segments, segment) end
	end
	for index, segment in segments do
		local joint = segment.JointPart
		-- les pièces de décor : tout sauf les articulations, les pièces invisibles et celles qui portent autre chose qu'une soudure
		local groups = {}
		for _, part in segment:GetChildren() do
			if part:IsA("BasePart") and part.Name ~= "JointPart" and part.Transparency < 1 and not part:IsA("UnionOperation") then
				local plain = true
				for _, c in part:GetChildren() do if not c:IsA("WeldConstraint") then plain = false end end
				if plain then
					local key = keyOf(part)
					groups[key] = groups[key] or {}
					table.insert(groups[key], part)
				end
			end
		end
		for _, parts in groups do
			-- des paquets compacts : les pièces sont rangées le long du plus grand côté du groupe
			local lo, hi = parts[1].Position, parts[1].Position
			for _, p in parts do lo, hi = lo:Min(p.Position), hi:Max(p.Position) end
			local size = hi - lo
			local axis = (size.X >= size.Y and size.X >= size.Z) and "X" or (size.Y >= size.Z and "Y" or "Z")
			table.sort(parts, function(a, b) return a.Position[axis] < b.Position[axis] end)
			for start = 1, #parts, CHUNK do
				local chunk = {}
				for i = start, math.min(start + CHUNK - 1, #parts) do table.insert(chunk, parts[i]) end
				local model0 = chunk[1]
				local results = {}
				fuse(chunk, results)
				for _, result in results do
					local union = result.Union
					if #result.Sources > 0 then
						union.Name = model0.Name
						union.Material, union.MaterialVariant = model0.Material, model0.MaterialVariant
						union.Transparency, union.Reflectance, union.CastShadow = model0.Transparency, model0.Reflectance, model0.CastShadow
						union.UsePartColor = false -- chaque pièce d'origine garde sa couleur
						union.SmoothingAngle = 0   -- arêtes vives, comme des blocs
						union.Anchored, union.Massless = false, true
						union.CanCollide, union.CanQuery, union.CanTouch = false, false, false
						local weld = Instance.new("WeldConstraint")
						weld.Part0, weld.Part1 = joint, union
						weld.Parent = union
						union.Parent = segment
						for _, source in result.Sources do source:Destroy() end
					end
				end
				task.wait()
			end
		end
		report(string.format("%d/%d %s", index, #segments, segment.Name))
	end
	for _, d in model:GetDescendants() do if d:IsA("BasePart") then after += 1 end end
	return before, after
end
