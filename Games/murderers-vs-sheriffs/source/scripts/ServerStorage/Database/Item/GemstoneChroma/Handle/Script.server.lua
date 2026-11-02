local CollectionService = game:GetService("CollectionService")
local tool = script.Parent
local decalChroma = tool.ChromaLayer
decalChroma:SetAttribute("StaticLayer", script.Parent.Mesh.TextureId)
CollectionService:AddTag(decalChroma, "ChromaDecal")