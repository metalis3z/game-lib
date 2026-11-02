local CollectionService = game:GetService("CollectionService")
local tool = script.Parent
local decalChroma = tool.ChromaLayer
decalChroma:SetAttribute("StaticLayer", script.Parent.Mesh.TextureId)
CollectionService:AddTag(decalChroma, "ChromaDecal")
for Index, Part in pairs(script.Parent:GetDescendants()) do
	if Part:IsA("MeshPart") then
		CollectionService:AddTag(Part, "ChromaPart")
	end
end