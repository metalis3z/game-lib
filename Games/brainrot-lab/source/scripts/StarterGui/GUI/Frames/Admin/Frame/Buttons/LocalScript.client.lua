-- https://lua.expert/
local v1 = script.Parent
local Pages = v1.Parent:WaitForChild("Pages")

local function hideAllPages() --[[ hideAllPages | Line: 6 | Upvalues: Pages (copy) ]]
	for k, v in pairs(Pages:GetChildren()) do
		if v:IsA("Frame") then
			v.Visible = false
		end
	end
end

local function updateButtonVisuals(p1, p2, p3) --[[ updateButtonVisuals | Line: 14 ]]
	local Frame = p1:FindFirstChild("Frame")

	if not Frame then
		return
	end

	local On = Frame:FindFirstChild("On")
	local Off = Frame:FindFirstChild("Off")

	if not (On and Off) then
		return
	end

	if p3 or p2 then
		On.Visible = true
		Off.Visible = false

		return
	end

	On.Visible = false
	Off.Visible = true
end

local v2 = nil

for k, v in pairs(v1:GetChildren()) do
	if v:IsA("Frame") then
		local Frame = v:FindFirstChild("Frame")

		if Frame and (Frame:IsA("ImageButton") or Frame:IsA("TextButton")) then
			local v3 = false
			local Frame2 = v:FindFirstChild("Frame")

			if Frame2 then
				local On = Frame2:FindFirstChild("On")
				local Off = Frame2:FindFirstChild("Off")

				if On and Off then
					On.Visible = false
					Off.Visible = true
				end
			end

			Frame.MouseEnter:Connect(function() --[[ Line: 40 | Upvalues: v3 (ref), v (copy), v2 (ref) ]]
				v3 = true

				local Frame = v:FindFirstChild("Frame")

				if not Frame then
					return
				end

				local On = Frame:FindFirstChild("On")
				local Off = Frame:FindFirstChild("Off")

				if not (On and Off) then
					return
				end

				if v2 == v or v3 then
					On.Visible = true
					Off.Visible = false

					return
				end

				On.Visible = false
				Off.Visible = true
			end)
			Frame.MouseLeave:Connect(function() --[[ Line: 45 | Upvalues: v3 (ref), v (copy), v2 (ref) ]]
				v3 = false

				local Frame = v:FindFirstChild("Frame")

				if not Frame then
					return
				end

				local On = Frame:FindFirstChild("On")
				local Off = Frame:FindFirstChild("Off")

				if not (On and Off) then
					return
				end

				if v2 == v or v3 then
					On.Visible = true
					Off.Visible = false

					return
				end

				On.Visible = false
				Off.Visible = true
			end)
			Frame.MouseButton1Click:Connect(function() --[[ Line: 50 | Upvalues: v2 (ref), v (copy), v3 (ref), Pages (copy), hideAllPages (copy) ]]
				local v1 = v2

				v2 = v

				if v1 and v1 ~= v then
					local Frame = v1:FindFirstChild("Frame")

					if Frame then
						local On = Frame:FindFirstChild("On")
						local Off = Frame:FindFirstChild("Off")

						if On and Off then
							On.Visible = false
							Off.Visible = true
						end
					end
				end

				local Frame = v:FindFirstChild("Frame")

				if Frame then
					local On = Frame:FindFirstChild("On")
					local Off = Frame:FindFirstChild("Off")

					if On and Off then
						On.Visible = true
						Off.Visible = false
					end
				end

				local v22 = Pages:FindFirstChild(v.Name)

				if not v22 then
					return
				end

				hideAllPages()
				v22.Visible = true
			end)
		end
	end
end