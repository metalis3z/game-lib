-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil

	local function setup() --[[ setup | Line: 7 | Upvalues: v1 (ref), p1 (copy), v2 (ref), v3 (ref), v4 (ref) ]]
		v1 = p1:FindFirstChild("Left")
		v2 = p1:FindFirstChild("Right")
		assert(v1 and v1:IsA("GuiObject"), "CircularBar is missing a Left GuiObject child")
		assert(v2 and v2:IsA("GuiObject"), "CircularBar is missing a Right GuiObject child")
		v3 = v1:FindFirstChildOfClass("UIGradient")
		v4 = v2:FindFirstChildOfClass("UIGradient")
		assert(v3 and v3:IsA("UIGradient"), "CircularBar is missing a Left UIGradient child")
		assert(v4 and v4:IsA("UIGradient"), "CircularBar is missing a Right UIGradient child")
	end

	if pcall(setup) and not p1:GetAttribute("Progress") then
		local function updateProgress(p12) --[[ updateProgress | Line: 21 | Upvalues: p1 (copy), v3 (ref), v4 (ref), v1 (ref), v2 (ref) ]]
			local v12 = math.clamp(p12, 0.0001, 1)

			if not (p1 and (v3 and v4)) then
				return
			end

			local v22 = math.clamp(v12 * 2, 0, 1) * 180
			local v32 = math.clamp((v12 - 0.5) * 2, 0, 1) * 180 + 180

			v4.Rotation = v22
			v3.Rotation = v32
			v4.Enabled = v12 < 0.5
			v3.Enabled = v12 < 1
			v1.Visible = v12 > 0
			v2.Visible = v12 > 0
		end

		p1:SetAttribute("Progress", 1)
		p1:GetAttributeChangedSignal("Progress"):Connect(function() --[[ Line: 40 | Upvalues: p1 (copy), v3 (ref), v4 (ref), v1 (ref), v2 (ref) ]]
			local v12 = p1:GetAttribute("Progress")

			if type(v12) ~= "number" then
				return
			end

			local v22 = math.clamp(v12, 0.0001, 1)

			if not (p1 and (v3 and v4)) then
				return
			end

			local v32 = math.clamp(v22 * 2, 0, 1) * 180
			local v42 = math.clamp((v22 - 0.5) * 2, 0, 1) * 180 + 180

			v4.Rotation = v32
			v3.Rotation = v42
			v4.Enabled = v22 < 0.5
			v3.Enabled = v22 < 1
			v1.Visible = v22 > 0
			v2.Visible = v22 > 0
		end)
	else
		warn("Could not setup CircularBar for " .. p1.Name)
	end
end