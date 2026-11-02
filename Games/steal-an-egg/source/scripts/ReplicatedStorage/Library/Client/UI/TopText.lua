-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local GamepadService = game:GetService("GamepadService")
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local Response_UI = ReplicatedStorage.Assets.UI.Npcs.Response_UI
local Option_UI = ReplicatedStorage.Assets.UI.Npcs.Option_UI
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local Response_Text = SoundService.Response_Text

task.wait(1)

local function typeEffect(p1, p2, p3) --[[ typeEffect | Line: 18 | Upvalues: SoundService (copy), Response_Text (copy), Debris (copy) ]]
	local v1 = p1.Text:gsub("<.->", "")
	local count = string.len(v1)
	local v2 = string.len(v1)

	p1.MaxVisibleGraphemes = 0

	local v3 = p3 and SoundService.NPC_SFX:FindFirstChild(p3) or SoundService.NPC_Text

	if p2 == true then
		while count >= 1 do
			task.wait()

			if v3.TimePosition > 0.07 or v3.Playing == false then
				v3.TimePosition = 0
				v3.Playing = true
				v3.PlaybackSpeed = 1 + math.random(-5, 5) / 100
			end

			p1.MaxVisibleGraphemes = p1.MaxVisibleGraphemes + 1
			count = count - 1
		end
	else
		while count >= 1 do
			task.wait()

			if math.floor(count / 3) * 3 == count or count == v2 then
				local SFX = Response_Text:Clone()

				SFX.Parent = SoundService
				SFX.Name = "SFX"
				SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				SFX.Playing = true
				Debris:AddItem(SFX, SFX.TimeLength * SFX.PlaybackSpeed)
			end

			p1.MaxVisibleGraphemes = p1.MaxVisibleGraphemes + 1
			count = count - 1
		end
	end
end

function t.NpcText(p1, p2, p3) --[[ NpcText | Line: 55 | Upvalues: Talk_UI (copy), typeEffect (copy) ]]
	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 == nil then
		local v2 = Talk_UI:Clone()

		v2.Parent = p1.Head
		v2.TextLabel.Text = p2
		typeEffect(v2.TextLabel, true, p1.Name)

		if p3 == true then
			for k, v in pairs(v2:GetDescendants()) do
				if v:IsA("LocalScript") or v:IsA("Script") then
					v.Enabled = true
				end
			end
		end

		return v2
	end

	if p3 == true then
		for k, v in pairs(v1:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				v:Destroy()
			end
		end
	end

	v1.TextLabel.Text = p2
	typeEffect(v1.TextLabel, true, p1.Name)

	if p3 == true then
		for k, v in pairs(Talk_UI:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				for k2, v2 in pairs(v1:GetDescendants()) do
					if v2.Name == v.Parent.Name then
						local v3 = v:Clone()

						v3.Parent = v2
						v3.Enabled = true
					end
				end
			end
		end
	end

	return v1
end
function t.ShowChoices(p1, p2) --[[ ShowChoices | Line: 97 | Upvalues: Option_UI (copy), TweenService (copy), Debris (copy), GamepadService (copy) ]]
	local count = 0
	local t = {}

	for k, v in pairs(p2) do
		count = count + 1

		local v1 = Option_UI:Clone()

		v1.Parent = p1.PlayerGui.Billboard_UI
		v1.Frame.Frame.Text_Element.Text = v
		v1.Frame.Frame.TextLabel.Text = tostring(count) .. "."

		local UIPadding = v1.Frame.Frame.Text_Element.UIPadding
		local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)

		UIPadding.PaddingLeft = UDim.new(string.len(v) * 0.001 + 0.04, 0)

		local v3 = TweenService:Create(UIPadding, v2, {
			PaddingLeft = UDim.new(0, 0)
		})

		v3:Play()
		Debris:AddItem(v3, v2.Time)
		table.insert(t, v1)
		v1.Frame.Frame.Text_Element:SetAttribute("Text", v)
		task.wait(0.075)
	end

	if t[1] then
		GamepadService:EnableGamepadCursor(t[1])
	end

	return t
end
function t.TakeAwayResponses(p1, p2) --[[ TakeAwayResponses | Line: 124 | Upvalues: TweenService (copy), v1 (copy), Debris (copy) ]]
	for k, v in pairs(p2.PlayerGui.Billboard_UI:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			v:Destroy()
		end
	end

	for k, v in pairs(p1.Head:GetChildren()) do
		if v:IsA("BillboardGui") and (v.Name == "Response_UI" or v.Name == "Talk_UI") then
			for k2, v2 in pairs(v:GetChildren()) do
				if v2:IsA("TextLabel") then
					TweenService:Create(v2, v1, {
						TextTransparency = 1
					}):Play()

					continue
				end

				if v2:IsA("ImageLabel") then
					TweenService:Create(v2, v1, {
						ImageTransparency = 1
					}):Play()
				end
			end

			Debris:AddItem(v, v1.Time)
		end
	end
end
function t.RemovePlayerSideFrame(p1) --[[ RemovePlayerSideFrame | Line: 148 | Upvalues: GamepadService (copy) ]]
	for k, v in pairs(p1.PlayerGui.Billboard_UI:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			v:Destroy()
		end
	end

	GamepadService:DisableGamepadCursor()
end
function t.ShowResponse(p1, p2, p3) --[[ ShowResponse | Line: 157 | Upvalues: Talk_UI (copy), typeEffect (copy) ]]
	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 == nil then
		local v2 = Talk_UI:Clone()

		v2.Parent = p1.Head
		v2.TextLabel.Text = p2
		typeEffect(v2.TextLabel, true)

		if p3 == true then
			for k, v in pairs(v2:GetDescendants()) do
				if v:IsA("LocalScript") or v:IsA("Script") then
					v.Enabled = true
				end
			end
		end

		return v2
	end

	if p3 == true then
		for k, v in pairs(v1:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				v:Destroy()
			end
		end
	end

	v1.TextLabel.Text = p2
	typeEffect(v1.TextLabel, true)

	if p3 == true then
		for k, v in pairs(Talk_UI:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				for k2, v2 in pairs(v1:GetDescendants()) do
					if v2.Name == v.Parent.Name then
						v.Enabled = false

						local v3 = v:Clone()

						v3.Parent = v2
						v3.Enabled = true
					end
				end
			end
		end
	end

	return v1
end
function t.PlayerResponse(p1, p2, p3) --[[ PlayerResponse | Line: 200 | Upvalues: Talk_UI (copy), Response_UI (copy), typeEffect (copy) ]]
	if p2 == nil then
		return
	end

	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 == nil then
		local v2 = Response_UI:Clone()

		v2.Parent = p1.Head
		v2.TextLabel.Text = p2
		typeEffect(v2.TextLabel, false)

		if p3 == true then
			for k, v in pairs(v2:GetDescendants()) do
				if v:IsA("LocalScript") or v:IsA("Script") then
					v.Enabled = true
				end
			end
		end

		return v2
	end

	if p3 == true then
		for k, v in pairs(v1:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				v:Destroy()
			end
		end
	end

	v1.TextLabel.Text = p2
	typeEffect(v1.TextLabel, false)

	if p3 == true then
		for k, v in pairs(Response_UI:GetDescendants()) do
			if v:IsA("LocalScript") or v:IsA("Script") then
				for k2, v2 in pairs(v1:GetDescendants()) do
					if v2.Name == v.Parent.Name then
						v.Enabled = false

						local v3 = v:Clone()

						v3.Parent = v2
						v3.Enabled = true
					end
				end
			end
		end
	end

	return v1
end

return t