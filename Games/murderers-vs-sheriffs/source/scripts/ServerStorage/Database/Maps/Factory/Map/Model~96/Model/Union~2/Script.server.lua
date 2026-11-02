local Texture = script.Parent.TX
local TextureTable = {
	"rbxassetid://870746629",
	"rbxassetid://870746626",
	"rbxassetid://870746627",
	"rbxassetid://870746675",
	"rbxassetid://870746628",
	"rbxassetid://870746618",
	"rbxassetid://870746638",
	"rbxassetid://870746657",
	"rbxassetid://870746658",
	"rbxassetid://870746661",
	"rbxassetid://870746660",
	"rbxassetid://870746669",
	"rbxassetid://870746683",
	"rbxassetid://870746682",
	"rbxassetid://870746686",
	"rbxassetid://870746687",
	"rbxassetid://870746695",
	"rbxassetid://870746758",
	"rbxassetid://870746706",
	"rbxassetid://870746709",
	"rbxassetid://870746710",
	"rbxassetid://870746711",
	"rbxassetid://870746721",
	"rbxassetid://870746729",
	"rbxassetid://870746731",
	"rbxassetid://870746733",
	"rbxassetid://870746735",
	"rbxassetid://870746741",
	"rbxassetid://870746747",
	"rbxassetid://870746748",
	"rbxassetid://870746754",
}

while true do
	for _,v in TextureTable do
		Texture.Texture = v
		wait(0.1)
	end
end