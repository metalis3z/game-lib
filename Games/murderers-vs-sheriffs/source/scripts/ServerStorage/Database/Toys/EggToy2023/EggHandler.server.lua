local tool=script.Parent
local handle=tool:WaitForChild("Handle")
local textures={
	"rbxassetid://12966466016",
	"rbxassetid://12965628726",
	"rbxassetid://12966022347"
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
