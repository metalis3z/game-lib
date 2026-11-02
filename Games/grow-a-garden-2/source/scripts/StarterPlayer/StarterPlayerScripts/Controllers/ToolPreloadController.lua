--credit to prince games studio
local t = {}
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local LocalPlayer = Players.LocalPlayer
local t2 = {}

local function preloadTool(p1) --[[ preloadTool | Line: 22 | Upvalues: t2 (copy), ContentProvider (copy) ]]
	if not t2[p1] then
		t2[p1] = true
		p1.AncestryChanged:Connect(function() --[[ Line: 26 | Upvalues: p1 (copy), t2 (ref) ]]
			if p1:IsDescendantOf(game) then
				return
			end

			t2[p1] = nil
		end)
		task.spawn(function() --[[ Line: 34 | Upvalues: p1 (copy), ContentProvider (ref) ]]
			task.wait()

			local v1 = p1:GetDescendants()

			if #v1 ~= 0 then
				local _, _2 = pcall(function() --[[ Line: 45 | Upvalues: ContentProvider (ref), v1 (copy) ]]
					ContentProvider:PreloadAsync(v1)
				end)
			end
		end)
	end
end

local function tryPreload(p1) --[[ tryPreload | Line: 53 | Upvalues: preloadTool (copy) ]]
	if not p1:IsA("Tool") then
		return
	end

	preloadTool(p1)
end

local function watchContainer(p1) --[[ watchContainer | Line: 59 | Upvalues: preloadTool (copy), tryPreload (copy) ]]
	for v1, v2 in p1:GetChildren() do
		if v2:IsA("Tool") then
			preloadTool(v2)
		end
	end

	p1.ChildAdded:Connect(tryPreload)
end

function t.Init(p1) --[[ Init | Line: 66 ]] end
function t.Start(p1) --[[ Start | Line: 68 | Upvalues: LocalPlayer (copy), preloadTool (copy), tryPreload (copy) ]]
	local Backpack = LocalPlayer:WaitForChild("Backpack")

	for v1, v2 in Backpack:GetChildren() do
		if v2:IsA("Tool") then
			preloadTool(v2)
		end
	end

	Backpack.ChildAdded:Connect(tryPreload)

	local function onCharacter(p1) --[[ onCharacter | Line: 72 | Upvalues: preloadTool (ref), tryPreload (ref) ]]
		for v1, v2 in p1:GetChildren() do
			if v2:IsA("Tool") then
				preloadTool(v2)
			end
		end

		p1.ChildAdded:Connect(tryPreload)
	end

	if LocalPlayer.Character then
		local Character = LocalPlayer.Character

		for v3, v4 in Character:GetChildren() do
			if v4:IsA("Tool") then
				preloadTool(v4)
			end
		end

		Character.ChildAdded:Connect(tryPreload)
	end

	LocalPlayer.CharacterAdded:Connect(onCharacter)
end

return t