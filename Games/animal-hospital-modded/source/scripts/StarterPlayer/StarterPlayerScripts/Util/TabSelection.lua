local t = {}
local v1 = Color3.fromRGB(163, 103, 54)
local v2 = Color3.fromRGB(127, 79, 42)

function t.SetTabSelection(p1, p2, p3, p4) --[[ SetTabSelection | Line: 6 | Upvalues: v1 (copy), v2 (copy) ]]
	for v12, v22 in next, p1 do
		v22.OnActivated:connect(function() --[[ Line: 8 | Upvalues: p1 (copy), v22 (copy), p2 (copy), p3 (copy), v1 (ref), p4 (copy), v2 (ref) ]]
			for v12, v23 in next, p1 do
				if v23 == v22 then
					p2[v23.Name].Visible = true
					v23.BackgroundColor3 = p3 or v1

					continue
				end

				p2[v23.Name].Visible = false
				v23.BackgroundColor3 = p4 or v2
			end
		end)
	end
end

return t