local t = {}

local function SetFace(p1, p2) --[[ SetFace | Line: 3 ]]
	if p1:FindFirstChild("Head.002") then
		p1["Head.002"].TextureID = p2
		p1["Head.004"].TextureID = p2
	else
		p1.Face.TextureID = p2
	end
end

function t.Apply(p1) --[[ Apply | Line: 12 ]]
	if not p1:GetAttribute("SecondFace") then
		local v1 = game.ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("SkinwalkerPhotoFaces"):GetChildren()
		local TextureID = v1[math.random(1, #v1)].TextureID

		if p1:FindFirstChild("Head.002") then
			p1["Head.002"].TextureID = TextureID
			p1["Head.004"].TextureID = TextureID
		else
			p1.Face.TextureID = TextureID
		end
	end

	p1:SetAttribute("Cursed", true)
end
function t.UnDo(p1) --[[ UnDo | Line: 23 ]]
	local v1 = p1:GetAttribute("OriginalFace")

	if not v1 then
		return
	end

	if p1:FindFirstChild("Head.002") then
		p1["Head.002"].TextureID = v1
		p1["Head.004"].TextureID = v1

		return
	end

	p1.Face.TextureID = v1
end

return t