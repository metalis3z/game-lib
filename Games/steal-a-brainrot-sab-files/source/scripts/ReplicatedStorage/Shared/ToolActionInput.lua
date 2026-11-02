

local UserInputService = game:GetService("UserInputService")
local E = Enum.KeyCode.E
local t1 = {
	[E] = true
}
local t2 = {}
local t3 = {}
local u6 = false

local function ShouldShowKeybind()
	return UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled
end
local function UpdateLabels()
	local v11 = not (UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled) and "" or ` ({ E.Name })`

	for _, v13 in t3 do
		if v13.Label.Parent ~= nil then
			v13.Label.Text = v13.Base .. v11
		end
	end
end
local function Start()
	if u6 then
		return
	end

	u6 = true
	UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
		if gameProcessed then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if not t1[input.KeyCode] then
			return
		end

		for _, v25 in t2 do
			local Frame = v25.Frame

			if Frame.Parent ~= nil and Frame.Visible then
				v25.Callback()

				return
			end
		end
	end)
	UserInputService.LastInputTypeChanged:Connect(UpdateLabels)
end

local t6 = {
	bind = function(p1, p2, p3: ((...any) -> ...any))
		if not u6 then
			u6 = true
			UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
				if gameProcessed then
					return
				end

				if input.UserInputType ~= Enum.UserInputType.Keyboard then
					return
				end

				if not t1[input.KeyCode] then
					return
				end

				for _, v30 in t2 do
					local Frame = v30.Frame

					if Frame.Parent ~= nil and Frame.Visible then
						v30.Callback()

						return
					end
				end
			end)
			UserInputService.LastInputTypeChanged:Connect(UpdateLabels)
		end

		local t4 = {
			Frame = p1,
			Callback = p3
		}

		table.insert(t2, t4)

		local connection = p2.MouseButton1Up:Connect(p3)
		local t5 = nil
		local Txt = p2:FindFirstChild("Txt")

		if Txt and Txt:IsA("TextLabel") then
			local BaseText = Txt:GetAttribute("BaseText")

			if typeof(BaseText) ~= "string" then
				BaseText = Txt.Text
				Txt:SetAttribute("BaseText", BaseText)
			end

			t5 = {
				Label = Txt,
				Base = BaseText
			}
			table.insert(t3, t5)
			UpdateLabels()
		end

		return function()
			connection:Disconnect()

			local v32 = table.find(t2, t4)

			if v32 then
				table.remove(t2, v32)
			end

			if t5 then
				local v33 = table.find(t3, t5)

				if v33 then
					table.remove(t3, v33)
				end
			end
		end
	end
}

return table.freeze(t6)
