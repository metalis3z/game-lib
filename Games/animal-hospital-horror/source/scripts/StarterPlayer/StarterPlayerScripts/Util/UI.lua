local t = {}
local LocalPlayer = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

function t.GetAll() --[[ GetAll | Line: 5 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:WaitForChild("PlayerGui"):GetChildren()
end
function t.Get(p1) --[[ Get | Line: 9 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(p1)
end
function t.GetScript(p1) --[[ GetScript | Line: 13 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:WaitForChild("PlayerScripts").UI:WaitForChild(p1)
end
function t.CollidesWith(p1, p2) --[[ CollidesWith | Line: 17 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local v1 = AbsolutePosition + p1.AbsoluteSize
	local AbsolutePosition2 = p2.AbsolutePosition
	local v2 = AbsolutePosition2 + p2.AbsoluteSize

	return if AbsolutePosition.x < v2.x and (v1.x > AbsolutePosition2.x and AbsolutePosition.y < v2.y) then v1.y > AbsolutePosition2.y else false
end
function t.ChangeGroupTransparency(p1, p2, p3) --[[ ChangeGroupTransparency | Line: 28 | Upvalues: TweenService (copy) ]]
	local v1 = if p2 < 1 then true else false

	for i, v in ipairs(p1:GetDescendants()) do
		local v2, v3

		if v:IsA("GuiObject") then
			if not v:GetAttribute("OriginalImageTransparency") and (v:IsA("ImageLabel") or v:IsA("ImageButton")) then
				v:SetAttribute("OriginalImageTransparency", v.ImageTransparency)
			end

			if not v:GetAttribute("OriginalTextTransparency") and (v:IsA("TextLabel") or v:IsA("TextButton")) then
				v:SetAttribute("OriginalTextTransparency", v.TextTransparency)
			end

			if not v:GetAttribute("OriginalBackgroundTransparency") and (v:IsA("Frame") or (v:IsA("TextLabel") or (v:IsA("TextButton") or (v:IsA("ImageLabel") or v:IsA("ImageButton"))))) then
				v:SetAttribute("OriginalBackgroundTransparency", v.BackgroundTransparency)
			end

			local t = {}

			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				if v1 then
					v.ImageTransparency = 1
				end

				t.ImageTransparency = v1 and math.max(v:GetAttribute("OriginalImageTransparency") or 0, p2) or 1
			end

			if v:IsA("TextLabel") or v:IsA("TextButton") then
				if v1 then
					v.TextTransparency = 1
				end

				t.TextTransparency = v1 and math.max(v:GetAttribute("OriginalTextTransparency") or 0, p2) or 1
			end

			if v:IsA("Frame") or (v:IsA("TextLabel") or (v:IsA("TextButton") or (v:IsA("ImageLabel") or v:IsA("ImageButton")))) then
				if v1 then
					v.BackgroundTransparency = 1
				end

				t.BackgroundTransparency = v1 and math.max(v:GetAttribute("OriginalBackgroundTransparency") or 1, p2) or 1
			end

			if next(t) then
				TweenService:Create(v, TweenInfo.new(p3 or 0), t):Play()
			end

			continue
		end

		if v:IsA("UIStroke") then
			if not v:GetAttribute("OriginalStrokeTransparency") then
				v:SetAttribute("OriginalStrokeTransparency", v.Transparency)
			end

			if v1 then
				v.Transparency = 1
			end

			local v10 = v:GetAttribute("OriginalStrokeTransparency") or 0
			local v12 = TweenInfo.new(p3 or 0)
			local t = {}

			if v1 then
				v2 = math.max(v10, p2)

				if v2 then
					v3 = v
				else
					v2 = 1
					v3 = v
				end
			else
				v2 = 1
				v3 = v
			end

			t.Transparency = v2
			TweenService:Create(v3, v12, t):Play()
		end
	end

	task.spawn(function() --[[ Line: 93 | Upvalues: v1 (copy), p3 (copy), p1 (copy) ]]
		if not v1 then
			task.wait(p3 or 0)
		end

		p1.Visible = v1
	end)
end

return t