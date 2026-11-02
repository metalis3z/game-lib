--credit to quartz games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminPanelRemote = ReplicatedStorage:WaitForChild("AdminPanelRemote")
local v1 = script.Parent
local Main = v1:WaitForChild("Main")
local Contents = Main:WaitForChild("Contents")
local Header = Main:WaitForChild("Header")

local function text_of(p1, p2) --[[ text_of | Line: 10 ]]
	local v1 = p1:FindFirstChild(p2)

	if v1 == nil or not v1:IsA("TextBox") then
		return ""
	end

	return v1.Text
end

local function resolve(p1) --[[ resolve | Line: 18 ]]
	local v1 = p1.Name

	if v1 == "AddMoney" or v1 == "SetMoney" then
		local t = {}
		local Amount = p1:FindFirstChild("Amount")
		local v2, v3

		if Amount == nil or not Amount:IsA("TextBox") then
			v2 = ""
			v3 = v1
		else
			v2 = Amount.Text
			v3 = v1
		end

		t.Amount = v2

		return v3, t
	end

	if v1 == "GrowAll" or v1 == "RestockShop" then
		return v1, {}
	end

	if v1 == "SpawnPet" then
		local t = {}
		local PetName = p1:FindFirstChild("PetName")

		t.PetName = if PetName == nil or not PetName:IsA("TextBox") then "" else PetName.Text

		local PetMutation = p1:FindFirstChild("PetMutation")

		t.PetMutation = if PetMutation == nil or not PetMutation:IsA("TextBox") then "" else PetMutation.Text

		return "SpawnPet", t
	end

	if v1 == "SpawnSeed" then
		local t = {}
		local SeedName = p1:FindFirstChild("SeedName")

		t.SeedName = if SeedName == nil or not SeedName:IsA("TextBox") then "" else SeedName.Text

		return "SpawnSeed", t
	end

	if v1 == "Morph" then
		local t = {}
		local MorphName = p1:FindFirstChild("MorphName")

		t.MorphName = if MorphName == nil or not MorphName:IsA("TextBox") then "" else MorphName.Text

		local MutationName = p1:FindFirstChild("MutationName")

		t.MutationName = if MutationName == nil or not MutationName:IsA("TextBox") then "" else MutationName.Text

		return "Morph", t
	end

	if v1 ~= "Weather" then
		return nil, nil
	end

	if p1:FindFirstChild("WeatherName") == nil then
		if p1:FindFirstChild("Speed") == nil then
			return nil, nil
		end

		local t = {}
		local Speed = p1:FindFirstChild("Speed")

		t.Speed = if Speed == nil or not Speed:IsA("TextBox") then "" else Speed.Text

		local Jump = p1:FindFirstChild("Jump")

		t.Jump = if Jump == nil or not Jump:IsA("TextBox") then "" else Jump.Text

		return "SpeedJump", t
	end

	local t = {}
	local WeatherName = p1:FindFirstChild("WeatherName")

	t.WeatherName = if WeatherName == nil or not WeatherName:IsA("TextBox") then "" else WeatherName.Text

	local WeatherDuration = p1:FindFirstChild("WeatherDuration")

	t.WeatherDuration = if WeatherDuration == nil or not WeatherDuration:IsA("TextBox") then "" else WeatherDuration.Text

	return "Weather", t
end

local function notify(p1) --[[ notify | Line: 40 | Upvalues: ReplicatedStorage (copy) ]]
	if p1 == nil or p1 == "" then
		return
	end

	local Notify = ReplicatedStorage:FindFirstChild("Notify")

	if Notify == nil then
		return
	end

	Notify:Fire(p1)
end

for i, v in ipairs(Contents:GetChildren()) do
	if v:IsA("Frame") then
		local AddButton = v:FindFirstChild("AddButton")

		if AddButton ~= nil and AddButton:IsA("GuiButton") then
			AddButton.Activated:Connect(function() --[[ Line: 54 | Upvalues: resolve (copy), v (copy), AdminPanelRemote (copy), ReplicatedStorage (copy) ]]
				local v1, v2 = resolve(v)

				if v1 == nil then
					return
				end

				local ok, result = pcall(function() --[[ Line: 59 | Upvalues: AdminPanelRemote (ref), v1 (copy), v2 (copy) ]]
					return AdminPanelRemote:InvokeServer(v1, v2)
				end)

				if not ok or type(result) ~= "table" then
					return
				end

				local message = result.message

				if message == nil then
					return
				end

				if message == "" then
					return
				end

				local Notify = ReplicatedStorage:FindFirstChild("Notify")

				if Notify == nil then
					return
				end

				Notify:Fire(message)
			end)
		end
	end
end

local ExitButton = Header:FindFirstChild("ExitButton")

if ExitButton == nil then
	return
end

ExitButton.Activated:Connect(function() --[[ Line: 72 | Upvalues: v1 (copy) ]]
	v1.Enabled = false
end)