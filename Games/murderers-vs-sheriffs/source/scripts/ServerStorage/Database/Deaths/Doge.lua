pants = 151923455
shirt = 151881602
local function KillEffect(rag)
if rag ~= nil then
if rag:FindFirstChild("Shirt") then
rag.Shirt:Destroy()
end
if rag:FindFirstChild("Pants") then
rag.Pants:Destroy()
end
children = rag:GetChildren()
for c = 1, #children do
if children[c].ClassName == "Accessory" or children[c].ClassName == "Hat" then
children[c]:Destroy()
end
end
dogeshirt = Instance.new("Shirt")
dogepant = Instance.new("Pants")
dogeshirt.ShirtTemplate = shirt
dogeshirt.Parent = rag
dogepant.PantsTemplate = pants
dogepant.Parent = rag
end
end

return KillEffect