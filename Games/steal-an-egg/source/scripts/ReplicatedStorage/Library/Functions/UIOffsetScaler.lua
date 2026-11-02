-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function adjustThickness(p1, p2) --[[ adjustThickness | Line: 1 ]]
	return string.gsub(p1, "(<stroke.-thickness=\"(%d+)\".->)", function(p13) --[[ Line: 2 | Upvalues: p2 (copy) ]]
		return string.gsub(p13, "thickness=\"(%d+)\"", function(p13) --[[ Line: 3 | Upvalues: p2 (ref) ]]
			local v1 = tonumber(p13)

			if v1 then
				p13 = tostring((p2(v1)))
			end

			return ("thickness=\"%*\""):format(p13)
		end)
	end)
end

local t = { "rbxassetid://14001321443" }

return function(p1, p2) --[[ Line: 17 | Upvalues: t (copy) ]]
	local v1 = p1 or {}

	local function getOldAttribute(p1, p2, p3) --[[ getOldAttribute | Line: 19 ]]
		local v1 = p1:GetAttribute("oldp_" .. p2)

		if not v1 then
			local v2 = p3(p1)

			p1:SetAttribute("oldp_" .. p2, v2)
			v1 = v2
		end

		assert(v1 ~= nil)

		return v1
	end

	local t2 = {}

	local function v2(p1, p22, p3) --[[ processElement | Line: 30 | Upvalues: p2 (copy), v1 (copy), t (ref), t2 (copy), v2 (copy) ]]
		if p2 and not p2(p1) then
			return false
		end

		if p3 then
			for k, v in pairs(p1:GetAttributes()) do
				if k:sub(0, 5) == "oldp_" then
					p1:SetAttribute(k, nil)
				end
			end
		end

		local v12 = false

		if p1:IsA("UIStroke") then
			if v1.Stroke and p1.StrokeSizingMode ~= Enum.StrokeSizingMode.ScaledSize then
				local function getStrokeThickness(p1) --[[ getStrokeThickness | Line: 223 ]]
					return p1.Thickness
				end

				local v22 = p1:GetAttribute("oldp_Thickness")

				if not v22 then
					v22 = p1.Thickness
					p1:SetAttribute("oldp_Thickness", v22)
				end

				assert(if v22 == nil then false else true)
				p1.Thickness = v22 * p22
				v12 = true
			end
		elseif p1:IsA("TextLabel") then
			if p1.RichText and v1.RichText then
				local Text = p1.Text
				local v4 = t2[p1]
				local v5 = false
				local v6

				if v4 then
					if v4.text2 == Text then
						if v4.scale == p22 then
							v6 = Text
						else
							v6 = v4.text1
							v5 = true
						end
					else
						v5 = true
						v6 = Text
					end
				else
					v4 = {}
					t2[p1] = v4
					v5 = true
					v6 = Text
				end

				if v5 then
					local function f7(p1) --[[ Line: 210 | Upvalues: p22 (copy) ]]
						return p1 * p22
					end

					local v8 = string.gsub(v6, "(<stroke.-thickness=\"(%d+)\".->)", function(p13) --[[ Line: 2 | Upvalues: f7 (copy) ]]
						return string.gsub(p13, "thickness=\"(%d+)\"", function(p13) --[[ Line: 3 | Upvalues: f7 (ref) ]]
							local v1 = tonumber(p13)

							if v1 then
								p13 = tostring((p2(v1)))
							end

							return ("thickness=\"%*\""):format(p13)
						end)
					end)

					v4.scale = p22
					v4.text1 = v6
					v4.text2 = v8

					if Text ~= v8 then
						p1.Text = v8
					end
				end

				v12 = true
			end
		elseif p1:IsA("ImageLabel") then
			if p1.ScaleType == Enum.ScaleType.Slice and (not table.find(t, p1.Image) and v1.NineSlice) then
				local function getSliceScaleImage(p1) --[[ getSliceScaleImage | Line: 180 ]]
					return p1.SliceScale
				end

				local v9 = p1:GetAttribute("oldp_SliceScale")

				if not v9 then
					v9 = p1.SliceScale
					p1:SetAttribute("oldp_SliceScale", v9)
				end

				assert(if v9 == nil then false else true)
				p1.SliceScale = v9 * p22
				v12 = true
			end
		elseif p1:IsA("ImageButton") then
			if p1.ScaleType == Enum.ScaleType.Slice and v1.NineSlice then
				local function getSliceScale(p1) --[[ getSliceScale | Line: 160 ]]
					return p1.SliceScale
				end

				local v11 = p1:GetAttribute("oldp_SliceScale")

				if not v11 then
					v11 = p1.SliceScale
					p1:SetAttribute("oldp_SliceScale", v11)
				end

				assert(if v11 == nil then false else true)
				p1.SliceScale = v11 * p22
				v12 = true
			end
		elseif p1:IsA("UIPadding") then
			if v1.Padding then
				local function getPaddingTop(p1) --[[ getPaddingTop | Line: 105 ]]
					return p1.PaddingTop
				end

				local v13 = p1:GetAttribute("oldp_PaddingTop")

				if not v13 then
					local v14 = getPaddingTop(p1)

					p1:SetAttribute("oldp_PaddingTop", v14)
					v13 = v14
				end

				assert(if v13 == nil then false else true)

				local function f16(p1) --[[ Line: 115 ]]
					return p1.PaddingBottom
				end

				local v17 = p1:GetAttribute("oldp_PaddingBottom")

				if not v17 then
					local v18 = f16(p1)

					p1:SetAttribute("oldp_PaddingBottom", v18)
					v17 = v18
				end

				local v19, v20

				if v17 == nil then
					v19 = false
					v20 = v13
				else
					v19 = true
					v20 = v13
				end

				assert(v19)

				local function f21(p1) --[[ Line: 125 ]]
					return p1.PaddingLeft
				end

				local v22 = p1:GetAttribute("oldp_PaddingLeft")

				if not v22 then
					local v23 = f21(p1)

					p1:SetAttribute("oldp_PaddingLeft", v23)
					v22 = v23
				end

				local v24, v25

				if v22 == nil then
					v24 = false
					v25 = v17
				else
					v24 = true
					v25 = v17
				end

				assert(v24)

				local function f26(p1) --[[ Line: 135 ]]
					return p1.PaddingRight
				end

				local v27 = p1:GetAttribute("oldp_PaddingRight")

				if not v27 then
					local v28 = f26(p1)

					p1:SetAttribute("oldp_PaddingRight", v28)
					v27 = v28
				end

				local v29, v30

				if v27 == nil then
					v29 = false
					v30 = v22
				else
					v29 = true
					v30 = v22
				end

				assert(v29)
				p1.PaddingTop = UDim.new(v20.Scale, v20.Offset * p22)
				p1.PaddingBottom = UDim.new(v25.Scale, v25.Offset * p22)
				p1.PaddingLeft = UDim.new(v30.Scale, v30.Offset * p22)
				p1.PaddingRight = UDim.new(v27.Scale, v27.Offset * p22)
				v12 = true
			end
		elseif p1:IsA("UIListLayout") then
			if v1.List then
				local function getPadding(p1) --[[ getPadding | Line: 90 ]]
					return p1.Padding
				end

				local v31 = p1:GetAttribute("oldp_Padding")

				if not v31 then
					v31 = p1.Padding
					p1:SetAttribute("oldp_Padding", v31)
				end

				assert(if v31 == nil then false else true)
				p1.Padding = UDim.new(v31.Scale, v31.Offset * p22)
				v12 = true
			end
		elseif p1:IsA("UIGridLayout") then
			if v1.Grid then
				local function getCellPadding(p1) --[[ getCellPadding | Line: 71 ]]
					return p1.CellPadding
				end

				local v33 = p1:GetAttribute("oldp_CellPadding")

				if not v33 then
					v33 = p1.CellPadding
					p1:SetAttribute("oldp_CellPadding", v33)
				end

				assert(if v33 == nil then false else true)
				p1.CellPadding = UDim2.new(v33.X.Scale, v33.X.Scale * p22, v33.Y.Scale, v33.Y.Offset * p22)
				v12 = true
			end
		elseif p1:IsA("ScrollingFrame") and v1.ScrollBar then
			local function getScrollBarThickness(p1) --[[ getScrollBarThickness | Line: 54 ]]
				return p1.ScrollBarThickness
			end

			local v35 = p1:GetAttribute("oldp_ScrollBarThickness")

			if not v35 then
				v35 = p1.ScrollBarThickness
				p1:SetAttribute("oldp_ScrollBarThickness", v35)
			end

			assert(if v35 == nil then false else true)
			p1.ScrollBarThickness = v35 * p22
			v12 = true
		end

		for i, v in ipairs(p1:GetChildren()) do
			if v2(v, p22, p3) then
				v12 = true
			end
		end

		return v12
	end

	return function(p1, p2, p3) --[[ Line: 246 | Upvalues: v2 (copy) ]]
		return v2(p1, p2, p3)
	end
end