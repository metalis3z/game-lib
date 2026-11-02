--credit to quartz games studio
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

game.Players.LocalPlayer.PlayerGui:WaitForChild("BackpackGui")

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = Instance.new("BindableEvent")

local function handlePlayerOrLocaleChanged() --[[ handlePlayerOrLocaleChanged | Line: 14 | Upvalues: v2 (ref), v3 (ref), v5 (copy) ]]
	if not v2 or v2.LocaleId == v3 then
		return
	end

	v3 = v2.LocaleId
	v5:Fire(v3)
end

local function reset() --[[ reset | Line: 21 | Upvalues: v1 (ref), v2 (ref), v4 (ref) ]]
	v1 = nil
	v2 = nil

	if not v4 then
		return
	end

	v4:Disconnect()
	v4 = nil
end

local function getTranslator() --[[ getTranslator | Line: 31 | Upvalues: v1 (ref), v2 (ref), Players (copy), LocalizationService (copy), v3 (ref), v5 (copy), v4 (ref), handlePlayerOrLocaleChanged (copy) ]]
	if v1 then
		return v1
	end

	v2 = Players.LocalPlayer

	if not v2 then
		return v1
	end

	v1 = LocalizationService:GetTranslatorForPlayer(v2)

	if v2 and v2.LocaleId ~= v3 then
		v3 = v2.LocaleId
		v5:Fire(v3)
	end

	v4 = v2:GetPropertyChangedSignal("LocaleId"):Connect(handlePlayerOrLocaleChanged)

	return v1
end

local t = {}

local function unregisterGui(p1) --[[ unregisterGui | Line: 46 | Upvalues: t (copy) ]]
	t[p1].connection:Disconnect()
	t[p1] = nil
end

local function makeAncestryChangedHandler(p1, p2) --[[ makeAncestryChangedHandler | Line: 51 | Upvalues: t (copy) ]]
	return function(p13, p2) --[[ Line: 52 | Upvalues: p1 (copy), p2 (copy), t (ref) ]]
		if game:IsAncestorOf(p1) then
			p2.hasBeenAdded = true
		elseif p2.hasBeenAdded then
			local v1 = p1

			t[v1].connection:Disconnect()
			t[v1] = nil
		end
	end
end

local function updateRegistryInfo(p1, p2, p3) --[[ updateRegistryInfo | Line: 63 ]]
	p1.context = p2
	p1.text = p3
end

local function makeRegistryInfo(p1, p2, p3) --[[ makeRegistryInfo | Line: 68 | Upvalues: t (copy) ]]
	local t2 = {
		hasBeenAdded = game:IsAncestorOf(p1),
		context = p2,
		text = p3
	}

	t2.connection = p1.AncestryChanged:Connect(function(p13, p2) --[[ Line: 52 | Upvalues: p1 (copy), t2 (copy), t (ref) ]]
		if game:IsAncestorOf(p1) then
			t2.hasBeenAdded = true
		elseif t2.hasBeenAdded then
			local v1 = p1

			t[v1].connection:Disconnect()
			t[v1] = nil
		end
	end)

	return t2
end

local function registerGui(p1, p2, p3) --[[ registerGui | Line: 76 | Upvalues: t (copy), makeRegistryInfo (copy) ]]
	if t[p1] == nil then
		t[p1] = makeRegistryInfo(p1, p2, p3)
	else
		local v1 = t[p1]

		v1.context = p2
		v1.text = p3
	end
end

local t2 = {
	LocaleChanged = v5.Event,
	TranslateGameText = function(p1, p2, p3) --[[ TranslateGameText | Line: 102 ]]
		return p3
	end
}

local function retranslateAll() --[[ retranslateAll | Line: 115 | Upvalues: t (copy), t2 (copy) ]]
	for k, v in pairs(t) do
		k.Text = t2:TranslateGameText(v.context, v.text)
	end
end

function t2.TranslateAndRegister(p1, p2, p3, p4) --[[ TranslateAndRegister | Line: 125 ]]
	return p4
end

return t2