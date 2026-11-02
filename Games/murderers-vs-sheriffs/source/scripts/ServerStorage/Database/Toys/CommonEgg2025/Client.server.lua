local tool = script.Parent
local handle=tool:WaitForChild("Handle")
local textures={
	"rbxassetid://79373741438708",
	"rbxassetid://90771040095203",
	"rbxassetid://91180536574017",
	"rbxassetid://93625335816652"
}
local currentTextureIndex=1
local function cycleTexture()
	currentTextureIndex+=1
	if currentTextureIndex>#textures then
		currentTextureIndex=1
	end
	handle.TextureID=textures[currentTextureIndex]
end
tool.Equipped:Connect(cycleTexture)
tool.Unequipped:Connect(cycleTexture)