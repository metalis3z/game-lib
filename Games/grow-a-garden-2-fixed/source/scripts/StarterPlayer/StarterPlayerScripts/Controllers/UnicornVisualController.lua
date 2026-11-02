--credit to leon games studio
local RunService = game:GetService("RunService")
local t = {
	Color3.fromRGB(241, 131, 255),
	Color3.fromRGB(193, 131, 255),
	Color3.fromRGB(152, 121, 255),
	Color3.fromRGB(133, 141, 255),
	Color3.fromRGB(112, 162, 255)
}
local t2 = {}

local function BuildHornRainbowState(p1) --[[ BuildHornRainbowState | Line: 39 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			local v3 = v2:GetAttribute("HornIndex")

			if typeof(v3) == "number" and not (v3 < 1 or v3 > 7) then
				local v4, v5, v6 = Color3.toHSV(v2.Color)

				table.insert(t, {
					Instance = v2,
					OrigHue = v4,
					Sat = v5,
					Val = v6
				})
			end
		end
	end

	return t
end

local function UpdateHornRainbow(p1, p2) --[[ UpdateHornRainbow | Line: 57 ]]
	local v1 = p1.StartOffset - p2 * 0.5

	for v2, v3 in p1.HornParts do
		v3.Instance.Color = Color3.fromHSV((v3.OrigHue + v1) % 1, v3.Sat, v3.Val)
	end
end

local function BuildHairState(p1) --[[ BuildHairState | Line: 66 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and v2:GetAttribute("UnicornHair") ~= nil then
			table.insert(t, v2)
		end
	end

	return t
end

local function UpdateHair(p1, p2) --[[ UpdateHair | Line: 76 | Upvalues: t (copy) ]]
	if #p1.HairParts == 0 then
		return
	end

	local v1 = #t
	local v2 = (p2 * 0.3333333333333333 + p1.StartOffset) * v1
	local v3 = math.floor(v2)
	local v4 = v3 % v1
	local v5 = t[v4 + 1]:Lerp(t[(v4 + 1) % v1 + 1], v2 - v3)

	for v6, v7 in p1.HairParts do
		v7.Color = v5
	end
end

local function UnregisterUnicorn(p1) --[[ UnregisterUnicorn | Line: 92 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end

local function RegisterUnicorn(p1) --[[ RegisterUnicorn | Line: 96 | Upvalues: t2 (copy), BuildHornRainbowState (copy), BuildHairState (copy) ]]
	if not t2[p1] then
		t2[p1] = {
			Model = p1,
			StartOffset = math.random(),
			HornParts = BuildHornRainbowState(p1),
			HairParts = BuildHairState(p1)
		}
		p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 107 | Upvalues: p1 (copy), t2 (ref) ]]
			if p2 ~= nil then
				return
			end

			t2[p1] = nil
		end)
	end
end

local function OnModelChildAdded(p1) --[[ OnModelChildAdded | Line: 112 | Upvalues: RegisterUnicorn (copy) ]]
	if not p1:IsA("Model") then
		return
	end

	if p1.Name == "Unicorn" then
		RegisterUnicorn(p1)
	end
end

return {
	StartOrder = 7,
	Init = function(p1) --[[ Init | Line: 122 ]] end,
	Start = function(p1) --[[ Start | Line: 124 | Upvalues: RegisterUnicorn (copy), OnModelChildAdded (copy), RunService (copy), t2 (copy), UpdateHornRainbow (copy), UpdateHair (copy) ]]
		local _PetVisualClient = workspace:WaitForChild("_PetVisualClient", 30)

		if not _PetVisualClient then
			return
		end

		local Models = _PetVisualClient:WaitForChild("Models", 30)

		if not Models then
			return
		end

		for v1, v2 in Models:GetChildren() do
			if v2:IsA("Model") and v2.Name == "Unicorn" then
				RegisterUnicorn(v2)
			end
		end

		Models.ChildAdded:Connect(OnModelChildAdded)
		RunService:BindToRenderStep("UnicornVisual", Enum.RenderPriority.Camera.Value + 2, function() --[[ Line: 135 | Upvalues: t2 (ref), UpdateHornRainbow (ref), UpdateHair (ref) ]]
			local v1 = os.clock()

			for v2, v3 in t2 do
				UpdateHornRainbow(v3, v1)
				UpdateHair(v3, v1)
			end
		end)
	end
}