local t = {}

local function search(p1, p2) --[[ search | Line: 3 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("GuiObject") then
			if p2.Text == "" then
				v.Visible = true

				continue
			end

			local v1 = string.lower(p2.Text)

			v.Visible = string.find(string.lower(v.Name), v1)
		end
	end

	p1.CanvasPosition = Vector2.new(0, 0)
end

function t.SetSearch(p1, p2) --[[ SetSearch | Line: 18 | Upvalues: search (copy) ]]
	p2.Changed:Connect(function() --[[ Line: 19 | Upvalues: search (ref), p1 (copy), p2 (copy) ]]
		search(p1, p2)
	end)
end

return t