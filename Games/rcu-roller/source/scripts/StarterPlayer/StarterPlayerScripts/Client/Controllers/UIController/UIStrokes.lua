-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:33
-- Luau version 6, Types version 3
-- Time taken: 0.002283 seconds

local module = {
	setOriginalThickness = function(arg1, arg2) -- Line 9, Named "setOriginalThickness"
		if arg2:IsA("UIStroke") and arg2:GetAttribute("OriginalThickness") == nil then
			arg2:SetAttribute("OriginalThickness", arg2.Thickness)
			arg2:SetAttribute("CurrentThickness", 1)
		end
		if arg2:IsA("TextLabel") then
			if arg2.RichText then
				if arg2:GetAttribute("OriginalThicknessText") == nil then
					local Text = arg2.Text
					local _, string_find_result2_2 = string.find(Text, "thickness=\"")
					if string_find_result2_2 then
						arg2:SetAttribute("OriginalThicknessText", string.sub(Text, string_find_result2_2 + 1, string_find_result2_2 + 1))
						arg2:SetAttribute("CurrentThicknessText", 1)
					end
				end
			end
		end
		if arg2:IsA("ScrollingFrame") then
			if arg2:GetAttribute("OriginalThickness") == nil then
				arg2:SetAttribute("OriginalThickness", arg2.ScrollBarThickness)
			end
		end
	end;
	getAverage = function(arg1, arg2) -- Line 28, Named "getAverage"
		return (arg2.X + arg2.Y) / 2
	end;
}
local CurrentCamera_upvr = workspace.CurrentCamera
function module.adjustThickness(arg1, arg2) -- Line 32
	local any_getAverage_result1 = arg1:getAverage(CurrentCamera_upvr.ViewportSize)
	local originalThickness = arg2:GetAttribute("OriginalThickness")
	if not originalThickness then return end
	local var10 = originalThickness / arg1:getAverage(Vector2.new(1920, 1080))
	local newThickness = any_getAverage_result1 * var10
	if arg2:IsA("UIStroke") then
		arg2.Thickness = newThickness
	elseif arg2:IsA("ScrollingFrame") then
		arg2.ScrollBarThickness = math.round(newThickness)
	end
	arg2:SetAttribute("CurrentThickness", newThickness)
end
function module.changeUIObject(arg1, arg2) -- Line 54
	if arg2:IsA("UIStroke") or arg2:IsA("TextLabel") and arg2.RichText or arg2:IsA("ScrollingFrame") then
		arg1:setOriginalThickness(arg2)
		arg1:adjustThickness(arg2)
	end
end
function module.modifyUIStrokes(arg1) -- Line 61
	for _, v in ipairs(workspace:GetDescendants()) do
		arg1:changeUIObject(v)
	end
end
return module