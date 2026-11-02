-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local AdminRemotes = ReplicatedStorage:WaitForChild("AdminRemotes")
local AdminAnnounce = AdminRemotes:WaitForChild("AdminAnnounce")
local UI = PlayerGui:WaitForChild("GUI")
local Announcement = UI:WaitForChild("Announcement")

Announcement.Visible = false

local FredokaOne = Enum.Font.FredokaOne
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = Color3.fromRGB(0, 0, 0)
local t = {}
local t2 = {}
local t3 = {}
local t4 = {
	BR = "\240\159\135\167\240\159\135\183",
	US = "\240\159\135\186\240\159\135\184",
	GB = "\240\159\135\172\240\159\135\167",
	PT = "\240\159\135\181\240\159\135\185",
	ES = "\240\159\135\170\240\159\135\184",
	MX = "\240\159\135\178\240\159\135\189",
	AR = "\240\159\135\166\240\159\135\183",
	CL = "\240\159\135\168\240\159\135\177",
	CO = "\240\159\135\168\240\159\135\180",
	PE = "\240\159\135\181\240\159\135\170",
	UY = "\240\159\135\186\240\159\135\190",
	PY = "\240\159\135\181\240\159\135\190",
	BO = "\240\159\135\167\240\159\135\180",
	VE = "\240\159\135\187\240\159\135\170",
	EC = "\240\159\135\170\240\159\135\168",
	CA = "\240\159\135\168\240\159\135\166",
	FR = "\240\159\135\171\240\159\135\183",
	DE = "\240\159\135\169\240\159\135\170",
	IT = "\240\159\135\174\240\159\135\185",
	NL = "\240\159\135\179\240\159\135\177",
	BE = "\240\159\135\167\240\159\135\170",
	PL = "\240\159\135\181\240\159\135\177",
	TR = "\240\159\135\185\240\159\135\183",
	RU = "\240\159\135\183\240\159\135\186",
	UA = "\240\159\135\186\240\159\135\166",
	JP = "\240\159\135\175\240\159\135\181",
	KR = "\240\159\135\176\240\159\135\183",
	CN = "\240\159\135\168\240\159\135\179",
	TW = "\240\159\135\185\240\159\135\188",
	HK = "\240\159\135\173\240\159\135\176",
	AU = "\240\159\135\166\240\159\135\186",
	NZ = "\240\159\135\179\240\159\135\191",
	IN = "\240\159\135\174\240\159\135\179",
	PH = "\240\159\135\181\240\159\135\173",
	ID = "\240\159\135\174\240\159\135\169",
	MY = "\240\159\135\178\240\159\135\190",
	TH = "\240\159\135\185\240\159\135\173",
	VN = "\240\159\135\187\240\159\135\179",
	SA = "\240\159\135\184\240\159\135\166",
	AE = "\240\159\135\166\240\159\135\170",
	EG = "\240\159\135\170\240\159\135\172",
	ZA = "\240\159\135\191\240\159\135\166"
}
local t5 = {
	["pt-br"] = "BR",
	["pt-pt"] = "PT",
	["en-us"] = "US",
	["en-gb"] = "GB",
	["en-ca"] = "CA",
	["en-au"] = "AU",
	["es-es"] = "ES",
	["es-mx"] = "MX",
	["fr-fr"] = "FR",
	["de-de"] = "DE",
	["it-it"] = "IT",
	["ja-jp"] = "JP",
	["ko-kr"] = "KR",
	["zh-cn"] = "CN",
	["zh-tw"] = "TW",
	["ru-ru"] = "RU",
	["th-th"] = "TH",
	["tr-tr"] = "TR",
	["vi-vn"] = "VN",
	["id-id"] = "ID",
	["pl-pl"] = "PL"
}

local function trimText(p1) --[[ trimText | Line: 111 ]]
	return tostring(p1 or ""):match("^%s*(.-)%s*$")
end

local function normalize(p1) --[[ normalize | Line: 115 ]]
	local v2 = tostring(p1 or ""):lower()

	for k, v in pairs({
		["\195\161"] = "a",
		["\195\160"] = "a",
		["\195\163"] = "a",
		["\195\162"] = "a",
		["\195\164"] = "a",
		["\195\169"] = "e",
		["\195\168"] = "e",
		["\195\170"] = "e",
		["\195\171"] = "e",
		["\195\173"] = "i",
		["\195\172"] = "i",
		["\195\174"] = "i",
		["\195\175"] = "i",
		["\195\179"] = "o",
		["\195\178"] = "o",
		["\195\181"] = "o",
		["\195\180"] = "o",
		["\195\182"] = "o",
		["\195\186"] = "u",
		["\195\185"] = "u",
		["\195\187"] = "u",
		["\195\188"] = "u",
		["\195\167"] = "c"
	}) do
		v2 = v2:gsub(k, v)
	end

	return v2:gsub("<[^>]->", ""):gsub("[^%w]+", " "):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", " ")
end

local function getLocaleId() --[[ getLocaleId | Line: 156 | Upvalues: LocalPlayer (copy), LocalizationService (copy) ]]
	local v1 = ""

	pcall(function() --[[ Line: 159 | Upvalues: v1 (ref), LocalPlayer (ref) ]]
		v1 = tostring(LocalPlayer.LocaleId or "")
	end)

	if v1 == "" then
		pcall(function() --[[ Line: 164 | Upvalues: v1 (ref), LocalizationService (ref) ]]
			v1 = tostring(LocalizationService.RobloxLocaleId or "")
		end)
	end

	if v1 == "" then
		pcall(function() --[[ Line: 170 | Upvalues: v1 (ref), LocalizationService (ref) ]]
			v1 = tostring(LocalizationService.SystemLocaleId or "")
		end)
	end

	if v1 == "" then
		v1 = "en-us"
	end

	v1 = string.lower(v1)
	v1 = v1:gsub("_", "-")

	if v1 == "en" then
		return "en-us"
	end

	if v1 == "pt" then
		return "pt-br"
	end

	if v1 == "es" then
		return "es-es"
	end

	if v1 == "fr" then
		return "fr-fr"
	end

	if v1 == "de" then
		return "de-de"
	end

	if v1 == "it" then
		return "it-it"
	end

	if v1 == "ja" then
		return "ja-jp"
	end

	if v1 == "ko" then
		return "ko-kr"
	end

	if v1 == "zh" then
		return "zh-cn"
	end

	if v1 == "ru" then
		return "ru-ru"
	end

	if v1 == "th" then
		return "th-th"
	end

	if v1 == "tr" then
		return "tr-tr"
	end

	if v1 == "vi" then
		return "vi-vn"
	end

	if v1 == "id" then
		return "id-id"
	end

	if v1 == "pl" then
		return "pl-pl"
	end

	return v1
end

local function getLanguageCode() --[[ getLanguageCode | Line: 217 | Upvalues: getLocaleId (copy) ]]
	local v1 = getLocaleId():match("^(%a%a)")

	if v1 and v1 ~= "" then
		return string.lower(v1)
	end

	return "en"
end

local function getCountryCode() --[[ getCountryCode | Line: 228 | Upvalues: getLocaleId (copy), t5 (copy) ]]
	local v1 = getLocaleId()

	if t5[v1] then
		return t5[v1]
	end

	local v2 = v1:match("[%-%_](%a%a)$")

	if v2 and v2 ~= "" then
		return string.upper(v2)
	end

	local v3 = getLocaleId():match("^(%a%a)")
	local v4 = if v3 and v3 ~= "" then string.lower(v3) else "en"

	if v4 == "pt" then
		return "BR"
	end

	if v4 == "en" then
		return "US"
	end

	if v4 == "es" then
		return "ES"
	end

	if v4 == "fr" then
		return "FR"
	end

	if v4 == "de" then
		return "DE"
	end

	if v4 == "it" then
		return "IT"
	end

	if v4 == "ja" then
		return "JP"
	end

	if v4 == "ko" then
		return "KR"
	end

	if v4 == "zh" then
		return "CN"
	end

	if v4 == "ru" then
		return "RU"
	end

	if v4 == "th" then
		return "TH"
	end

	return "US"
end

local function getPlayerFlag() --[[ getPlayerFlag | Line: 269 | Upvalues: getCountryCode (copy), t4 (copy) ]]
	return t4[getCountryCode()] or "\240\159\140\144"
end

local function getTranslateRemote() --[[ getTranslateRemote | Line: 274 | Upvalues: AdminRemotes (copy) ]]
	local TranslateAnnouncement = AdminRemotes:FindFirstChild("TranslateAnnouncement")

	if TranslateAnnouncement and TranslateAnnouncement:IsA("RemoteFunction") then
		return TranslateAnnouncement
	end

	return nil
end

local function fallbackTranslate(p1) --[[ fallbackTranslate | Line: 284 | Upvalues: normalize (copy), getLocaleId (copy) ]]
	local v1 = tostring(p1 or ""):match("^%s*(.-)%s*$")
	local v2 = normalize(v1)
	local v3 = getLocaleId():match("^(%a%a)")
	local v4 = if v3 and v3 ~= "" then string.lower(v3) else "en"
	local t = {
		oi = "Hi",
		ola = "Hello",
		["ol\195\161"] = "Hello",
		["oi gente"] = "Hi everyone",
		["ola gente"] = "Hello everyone",
		["ol\195\161 gente"] = "Hello everyone",
		salve = "Hello",
		["bom dia"] = "Good morning",
		["boa tarde"] = "Good afternoon",
		["boa noite"] = "Good night",
		["evento ativado"] = "Event activated",
		["evento ativado galera"] = "Event activated, everyone",
		["boa sorte"] = "Good luck",
		["entrem no grupo"] = "Join the group",
		["novo evento"] = "New event",
		["evento comecou"] = "The event has started",
		["evento come\195\167ou"] = "The event has started"
	}
	local t2 = {
		hi = "Oi",
		hello = "Ol\195\161",
		hey = "Ei",
		["hi everyone"] = "Oi gente",
		["hello everyone"] = "Ol\195\161 gente",
		["good morning"] = "Bom dia",
		["good afternoon"] = "Boa tarde",
		["good night"] = "Boa noite",
		["event activated"] = "Evento ativado",
		["good luck"] = "Boa sorte",
		["join the group"] = "Entrem no grupo",
		["new event"] = "Novo evento",
		["the event has started"] = "O evento come\195\167ou"
	}
	local t3 = {
		oi = "Hola",
		ola = "Hola",
		["ol\195\161"] = "Hola",
		["oi gente"] = "Hola a todos",
		["ola gente"] = "Hola a todos",
		["ol\195\161 gente"] = "Hola a todos",
		["bom dia"] = "Buenos d\195\173as",
		["boa tarde"] = "Buenas tardes",
		["boa noite"] = "Buenas noches",
		["evento ativado"] = "Evento activado",
		["boa sorte"] = "Buena suerte"
	}

	if v4 == "en" then
		return t[v2] or v1
	end

	if v4 == "pt" then
		return t2[v2] or v1
	end

	if v4 == "es" then
		return t3[v2] or v1
	end

	return v1
end

local t6 = {
	"galera",
	"gente",
	"entao",
	"ent\195\163o",
	"obrigado",
	"obrigada",
	"valeu",
	"falou",
	"beleza",
	"parabens",
	"parab\195\169ns",
	"tambem",
	"tamb\195\169m",
	"ainda",
	"sempre",
	"nunca",
	"tudo",
	"nada",
	"muito",
	"pode",
	"deve",
	"sobre",
	"entre",
	"coisa",
	"pessoas",
	"todos",
	"nosso",
	"nossa",
	"alguem",
	"algu\195\169m",
	"algum",
	"alguma",
	"trabalho",
	"equipe",
	"time",
	"voce",
	"voc\195\170",
	"nao",
	"n\195\163o",
	"sim",
	"sao",
	"s\195\163o",
	"tao",
	"t\195\163o",
	"bom",
	"boa",
	"bem",
	"dia",
	"noite",
	"tarde",
	"evento",
	"ativado",
	"comecou",
	"come\195\167ou",
	"entrem",
	"pedido",
	"sorte",
	"grupo",
	"novo",
	"amanha",
	"amanh\195\163",
	"hoje",
	"ontem",
	"agora",
	"depois",
	"antes",
	"sempre",
	"nunca",
	"obrigado",
	"brigado",
	"esse",
	"essa",
	"este",
	"esta",
	"isso",
	"isto",
	"aquele",
	"aquela",
	"disso",
	"desse",
	"deste",
	"nesse",
	"nessa",
	"neste",
	"nesta",
	"daqui",
	"dali",
	"perto",
	"longe",
	"cima",
	"baixo",
	"dentro",
	"fora",
	"mesmo",
	"assim",
	"caramba",
	"nossa",
	"puts",
	"poxa",
	"cara",
	"cade",
	"cad\195\170",
	"onde",
	"quando",
	"porque",
	"por",
	"pela",
	"pelos",
	"pelas",
	"com",
	"num",
	"numa",
	"dum",
	"duma",
	"pro",
	"pra",
	"capaz",
	"jeito",
	"coisa",
	"negocio",
	"neg\195\179cio",
	"servidor",
	"servidores",
	"todos",
	"todas",
	"oi",
	"oii",
	"ola",
	"ol\195\161",
	"blz",
	"vlw",
	"pq"
}

local function isPortuguese(p1) --[[ isPortuguese | Line: 379 | Upvalues: normalize (copy), t6 (copy) ]]
	local v1 = tostring(p1):lower()

	if v1:match("\195\163o") or (v1:match("\195\181e") or (v1:match("\195\167") or v1:match("\195\160"))) then
		return true
	end

	for v2 in normalize(v1):gmatch("%S+") do
		if t6[v2] then
			return true
		end
	end

	return false
end

local function translateCustomMessage(p1) --[[ translateCustomMessage | Line: 397 | Upvalues: isPortuguese (copy), getLocaleId (copy), t2 (copy), AdminRemotes (copy) ]]
	local v1 = tostring(p1 or ""):match("^%s*(.-)%s*$")

	if v1 == "" then
		return ""
	end

	if isPortuguese(v1) then
		return v1
	end

	local v2 = getLocaleId() .. "|" .. v1

	if t2[v2] then
		return t2[v2]
	end

	local v3 = nil
	local TranslateAnnouncement = AdminRemotes:FindFirstChild("TranslateAnnouncement")
	local v4 = if TranslateAnnouncement and TranslateAnnouncement:IsA("RemoteFunction") then TranslateAnnouncement else nil

	if v4 then
		local ok, result = pcall(function() --[[ Line: 418 | Upvalues: v4 (copy), v1 (copy) ]]
			return v4:InvokeServer(v1)
		end)

		if ok and type(result) == "string" and tostring(result or ""):match("^%s*(.-)%s*$") ~= "" then
			v3 = result
		end
	end

	if not v3 or v3 == "" then
		v3 = v1
	end

	if v3 ~= v1 then
		t2[v2] = v3
	end

	return v3
end

local function getLocalizedSpawnText(p1, p2, p3) --[[ getLocalizedSpawnText | Line: 437 | Upvalues: getLocaleId (copy) ]]
	local v1 = getLocaleId():match("^(%a%a)")
	local v2 = if v1 and v1 ~= "" then string.lower(v1) else "en"
	local v4 = tostring(p1 or ""):match("^%s*(.-)%s*$")
	local v5 = tostring(p2 or ""):match("^%s*(.-)%s*$")

	if v4 == "" then
		v4 = "Brainrot"
	end

	if v5 == "" then
		v5 = "Normal"
	end

	if p3 == "YOUR" then
		if v2 == "pt" then
			return "SPAWNOU " .. v4 .. " (" .. v5 .. ") NO SEU SERVIDOR"
		end

		if v2 == "es" then
			return "APARECI\195\147 " .. v4 .. " (" .. v5 .. ") EN TU SERVIDOR"
		end

		if v2 == "fr" then
			return v4 .. " (" .. v5 .. ") EST APPARU DANS TON SERVEUR"
		end

		if v2 == "de" then
			return v4 .. " (" .. v5 .. ") WURDE AUF DEINEM SERVER GESPAWNT"
		end

		if v2 == "it" then
			return "SPAWNATO " .. v4 .. " (" .. v5 .. ") NEL TUO SERVER"
		end

		return "SPAWNED " .. v4 .. " (" .. v5 .. ") IN YOUR SERVER"
	end

	if p3 == "ALL" then
		if v2 == "pt" then
			return "SPAWNOU " .. v4 .. " (" .. v5 .. ") EM TODOS OS SERVIDORES"
		end

		if v2 == "es" then
			return "APARECI\195\147 " .. v4 .. " (" .. v5 .. ") EN TODOS LOS SERVIDORES"
		end

		if v2 == "fr" then
			return v4 .. " (" .. v5 .. ") EST APPARU DANS TOUS LES SERVEURS"
		end

		if v2 == "de" then
			return v4 .. " (" .. v5 .. ") WURDE AUF ALLEN SERVERN GESPAWNT"
		end

		if v2 == "it" then
			return "SPAWNATO " .. v4 .. " (" .. v5 .. ") IN TUTTI I SERVER"
		end

		return "SPAWNED " .. v4 .. " (" .. v5 .. ") IN ALL SERVERS"
	end

	local v6 = tonumber(p3)

	if v6 then
		if v2 == "pt" then
			return "SPAWNOU " .. v4 .. " (" .. v5 .. ") EM " .. tostring(v6) .. " " .. (if v6 == 1 then "SERVIDOR" else "SERVIDORES")
		end

		if v2 == "es" then
			return "APARECI\195\147 " .. v4 .. " (" .. v5 .. ") EN " .. tostring(v6) .. " " .. (if v6 == 1 then "SERVIDOR" else "SERVIDORES")
		end

		if v2 == "fr" then
			return v4 .. " (" .. v5 .. ") EST APPARU DANS " .. tostring(v6) .. " " .. (if v6 == 1 then "SERVEUR" else "SERVEURS")
		end

		if v2 == "de" then
			return v4 .. " (" .. v5 .. ") WURDE AUF " .. tostring(v6) .. " " .. (if v6 == 1 then "SERVER" else "SERVERN") .. " GESPAWNT"
		end

		if v2 == "it" then
			return "SPAWNATO " .. v4 .. " (" .. v5 .. ") IN " .. tostring(v6) .. " SERVER"
		end

		return "SPAWNED " .. v4 .. " (" .. v5 .. ") IN " .. tostring(v6) .. " " .. (if v6 == 1 then "SERVER" else "SERVERS")
	end

	if v2 == "pt" then
		return "SPAWNOU " .. v4 .. " (" .. v5 .. ")"
	end

	if v2 == "es" then
		return "APARECI\195\147 " .. v4 .. " (" .. v5 .. ")"
	end

	if v2 == "fr" then
		return v4 .. " (" .. v5 .. ") EST APPARU"
	end

	if v2 == "de" then
		return v4 .. " (" .. v5 .. ") WURDE GESPAWNT"
	end

	if v2 == "it" then
		return "SPAWNATO " .. v4 .. " (" .. v5 .. ")"
	end

	return "SPAWNED " .. v4 .. " (" .. v5 .. ")"
end

local function localizeMessage(p1) --[[ localizeMessage | Line: 520 | Upvalues: translateCustomMessage (copy), trimText (copy) ]]
	return translateCustomMessage(trimText(p1))
end

local function buildMessage(p1) --[[ buildMessage | Line: 524 | Upvalues: getCountryCode (copy), t4 (copy), translateCustomMessage (copy), trimText (copy) ]]
	return (t4[getCountryCode()] or "\240\159\140\144") .. " " .. translateCustomMessage(trimText(p1))
end

local function getTextWidth(p1, p2, p3) --[[ getTextWidth | Line: 528 | Upvalues: TextService (copy) ]]
	return TextService:GetTextSize(tostring(p1), p3, p2, Vector2.new(10000, 100)).X
end

local function getDisplayName(p1) --[[ getDisplayName | Line: 539 | Upvalues: Players (copy) ]]
	local v1 = Players:FindFirstChild((tostring(p1)))

	if v1 then
		return v1.DisplayName
	end

	return tostring(p1)
end

local function getAvatarImage(p1, p2) --[[ getAvatarImage | Line: 549 | Upvalues: Players (copy) ]]
	local v1 = tostring(p1 or "")

	if v1 ~= "" then
		return v1
	end

	local v2 = Players:FindFirstChild((tostring(p2)))

	if v2 then
		local ok, result = pcall(function() --[[ Line: 559 | Upvalues: Players (ref), v2 (copy) ]]
			return Players:GetUserThumbnailAsync(v2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		end)

		if ok and result then
			return result
		end
	end

	local ok, result = pcall(function() --[[ Line: 572 | Upvalues: Players (ref), p2 (copy) ]]
		return Players:GetUserIdFromNameAsync((tostring(p2)))
	end)

	if not (ok and result) then
		return ""
	end

	local ok2, result2 = pcall(function() --[[ Line: 577 | Upvalues: Players (ref), result (copy) ]]
		return Players:GetUserThumbnailAsync(result, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
	end)

	if ok2 and result2 then
		return result2
	end

	return ""
end

local function getTemplateHeight() --[[ getTemplateHeight | Line: 593 | Upvalues: Announcement (copy) ]]
	local Y = Announcement.AbsoluteSize.Y

	if Y and Y > 0 then
		return Y
	end

	if Announcement.Size.Y.Offset > 0 then
		return Announcement.Size.Y.Offset
	end

	return 33
end

local function getSafeMaxWidth() --[[ getSafeMaxWidth | Line: 607 | Upvalues: UI (copy), Announcement (copy) ]]
	local X = UI.AbsoluteSize.X

	if X <= 0 then
		X = 900
	end

	local X2 = Announcement.AbsoluteSize.X

	if X2 <= 0 then
		X2 = X
	end

	return math.min(X2, (math.min(math.max(X * 0.52, 260), 560)))
end

local function updateAnnouncementPositions() --[[ updateAnnouncementPositions | Line: 628 | Upvalues: Announcement (copy), t (copy) ]]
	local Position = Announcement.Position
	local Y = Announcement.AbsoluteSize.Y
	local v1 = if Y and Y > 0 then Y elseif Announcement.Size.Y.Offset > 0 then Announcement.Size.Y.Offset else 33

	for i, v in ipairs(t) do
		if v and v.Parent then
			v.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset + (22 + (i - 1) * (v1 + 2)))
		end
	end
end

local function removeFromActive(p1) --[[ removeFromActive | Line: 646 | Upvalues: t (copy), updateAnnouncementPositions (copy) ]]
	for i, v in ipairs(t) do
		if v == p1 then
			table.remove(t, i)

			break
		end
	end

	updateAnnouncementPositions()
end

local function findTextLabel(p1, p2) --[[ findTextLabel | Line: 657 ]]
	local v1 = p1:FindFirstChild(p2)

	if v1 and v1:IsA("TextLabel") then
		return v1
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v.Name == p2 and v:IsA("TextLabel") then
			return v
		end
	end

	return nil
end

local function findOrCreateIcon(p1) --[[ findOrCreateIcon | Line: 673 ]]
	local Profile = p1:FindFirstChild("Profile", true)

	if Profile and (Profile:IsA("ImageLabel") or Profile:IsA("ImageButton")) then
		return Profile
	end

	local Icon = p1:FindFirstChild("Icon", true)

	if not (Icon and (Icon:IsA("ImageLabel") or Icon:IsA("ImageButton"))) then
		local Icon2 = Instance.new("ImageLabel")

		Icon2.Name = "Icon"
		Icon2.BackgroundTransparency = 1
		Icon2.BorderSizePixel = 0
		Icon2.Parent = p1

		return Icon2
	end

	return Icon
end

local function setupStroke(p1) --[[ setupStroke | Line: 695 | Upvalues: v1 (copy), v2 (copy) ]]
	p1.TextColor3 = v1
	p1.TextStrokeColor3 = v2
	p1.TextStrokeTransparency = 0

	local StrongStroke = p1:FindFirstChild("StrongStroke") or p1:FindFirstChildOfClass("UIStroke")

	if not StrongStroke then
		StrongStroke = Instance.new("UIStroke")
		StrongStroke.Name = "StrongStroke"
		StrongStroke.Parent = p1
	end

	StrongStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	StrongStroke.Color = v2
	StrongStroke.LineJoinMode = Enum.LineJoinMode.Round
	StrongStroke.Thickness = 3.5
	StrongStroke.Transparency = 0
	pcall(function() --[[ Line: 718 | Upvalues: StrongStroke (ref) ]]
		StrongStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	end)

	return StrongStroke
end

local function setupTextLabel(p1) --[[ setupTextLabel | Line: 725 | Upvalues: FredokaOne (copy), v1 (copy), v2 (copy), setupStroke (copy) ]]
	p1.Visible = true
	p1.AutoLocalize = false
	p1.BackgroundTransparency = 1
	p1.BorderSizePixel = 0
	p1.Font = FredokaOne
	p1.TextColor3 = v1
	p1.TextStrokeColor3 = v2
	p1.TextStrokeTransparency = 0
	p1.TextScaled = true
	p1.TextWrapped = false
	p1.TextTruncate = Enum.TextTruncate.None
	p1.TextXAlignment = Enum.TextXAlignment.Left
	p1.TextYAlignment = Enum.TextYAlignment.Center
	p1.ZIndex = 9994

	local TextSizeLimit = p1:FindFirstChild("TextSizeLimit")

	if not TextSizeLimit then
		local TextSizeLimit2 = Instance.new("UITextSizeConstraint")

		TextSizeLimit2.Name = "TextSizeLimit"
		TextSizeLimit2.Parent = p1
		TextSizeLimit = TextSizeLimit2
	end

	TextSizeLimit.MinTextSize = 8
	TextSizeLimit.MaxTextSize = 35

	return setupStroke(p1)
end

local function setupLayout(p1) --[[ setupLayout | Line: 757 ]]
	local UIListLayout = p1:FindFirstChildOfClass("UIListLayout")

	if not UIListLayout then
		local UIListLayout2 = Instance.new("UIListLayout")

		UIListLayout2.Parent = p1
		UIListLayout = UIListLayout2
	end

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 7)

	return UIListLayout
end

local function calculateTextSize(p1, p2, p3) --[[ calculateTextSize | Line: 774 | Upvalues: UI (copy), Announcement (copy), FredokaOne (copy), TextService (copy) ]]
	local X = UI.AbsoluteSize.X

	if X <= 0 then
		X = 900
	end

	local X2 = Announcement.AbsoluteSize.X

	if X2 <= 0 then
		X2 = X
	end

	local count = 35
	local v5 = math.min(X2, (math.min(math.max(X * 0.52, 260), 560))) - (if p3 then 41 else 0) - 16

	while count > 8 do
		local X3 = TextService:GetTextSize(tostring(p1), count, FredokaOne, Vector2.new(10000, 100)).X
		local X4 = TextService:GetTextSize(tostring(p2), count, FredokaOne, Vector2.new(10000, 100)).X

		if X3 + X4 <= v5 then
			return count, X3, X4
		end

		count = count - 1
	end

	local X3 = TextService:GetTextSize(tostring(p1), 8, FredokaOne, Vector2.new(10000, 100)).X
	local v9 = v5 * 0.45

	if v9 < X3 then
		X3 = v9
	end

	return 8, X3, math.max(30, v5 - X3)
end

local function updateLabelSizes(p1, p2, p3, p4, p5) --[[ updateLabelSizes | Line: 809 | Upvalues: calculateTextSize (copy) ]]
	local v1, v2, v3 = calculateTextSize(p3, p4, p5)

	if p1 then
		p1.TextSize = v1
		p1.Size = UDim2.new(0, v2 + 4, 1, 0)
	end

	if not p2 then
		return
	end

	p2.TextSize = v1
	p2.Size = UDim2.new(0, v3 + 8, 1, 0)
end

local function showAnnouncement(p1, p2, p3, p4) --[[ showAnnouncement | Line: 823 | Upvalues: Players (copy), getCountryCode (copy), t4 (copy), translateCustomMessage (copy), trimText (copy), Announcement (copy), UI (copy), setupLayout (copy), findTextLabel (copy), findOrCreateIcon (copy), getAvatarImage (copy), setupTextLabel (copy), updateLabelSizes (copy), t (copy), updateAnnouncementPositions (copy), TweenService (copy), removeFromActive (copy) ]]
	local v1 = tostring(p4 or "")

	if v1 == "" then
		local v2 = Players:FindFirstChild((tostring(p2)))

		v1 = if v2 then v2.DisplayName else tostring(p2)
	end

	local v4 = (v1 .. " \238\128\128") .. ":"
	local v5 = " " .. (t4[getCountryCode()] or "\240\159\140\144") .. " " .. translateCustomMessage(trimText(p3))
	local AnnouncementClone = Announcement:Clone()

	AnnouncementClone.Name = "AnnouncementClone"
	AnnouncementClone.Visible = true
	AnnouncementClone.Parent = UI
	AnnouncementClone.AnchorPoint = Announcement.AnchorPoint
	AnnouncementClone.Position = UDim2.new(Announcement.Position.X.Scale, Announcement.Position.X.Offset, Announcement.Position.Y.Scale, Announcement.Position.Y.Offset + 22)
	AnnouncementClone.Size = Announcement.Size
	AnnouncementClone.BackgroundTransparency = 1
	AnnouncementClone.BorderSizePixel = 0
	AnnouncementClone.ClipsDescendants = false
	AnnouncementClone.ZIndex = 9990
	setupLayout(AnnouncementClone)

	local v6 = findTextLabel(AnnouncementClone, "Title")
	local v7 = findTextLabel(AnnouncementClone, "message") or findTextLabel(AnnouncementClone, "Message")
	local v8 = findOrCreateIcon(AnnouncementClone)

	if v8 then
		v8.Visible = true
		v8.BackgroundTransparency = 1
		v8.BorderSizePixel = 0
		v8.Image = getAvatarImage(p1, p2)
		v8.ImageTransparency = 0
		v8.ScaleType = Enum.ScaleType.Fit
		v8.Size = UDim2.new(0, 34, 0, 34)
		v8.ZIndex = 9993
		v8.LayoutOrder = 1
	end

	if v6 then
		v6.Text = v4
		v6.LayoutOrder = 2
		setupTextLabel(v6)
	end

	if v7 then
		v7.Text = v5
		v7.LayoutOrder = 3
		setupTextLabel(v7)
	end

	updateLabelSizes(v6, v7, v4, v5, if v8 == nil then false else true)
	table.insert(t, AnnouncementClone)
	updateAnnouncementPositions()

	local UIScale = AnnouncementClone:FindFirstChildOfClass("UIScale")

	if not UIScale then
		UIScale = Instance.new("UIScale")
		UIScale.Parent = AnnouncementClone
	end

	UIScale.Scale = 0.96

	local list = {}

	if v8 then
		table.insert(list, v8)
	end

	if v6 then
		table.insert(list, v6)
	end

	if v7 then
		table.insert(list, v7)
	end

	for i, v in ipairs(list) do
		if v:IsA("TextLabel") or v:IsA("TextButton") then
			v.TextTransparency = 1
			v.TextStrokeTransparency = 1

			local v13 = v:FindFirstChild("StrongStroke") or v:FindFirstChildOfClass("UIStroke")

			if v13 then
				v13.Transparency = 1
			end

			continue
		end

		if v:IsA("ImageLabel") or v:IsA("ImageButton") then
			v.ImageTransparency = 1
		end
	end

	TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Scale = 1
	}):Play()

	for i, v in ipairs(list) do
		if v:IsA("TextLabel") or v:IsA("TextButton") then
			TweenService:Create(v, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				TextTransparency = 0,
				TextStrokeTransparency = 0
			}):Play()

			local v14 = v:FindFirstChild("StrongStroke") or v:FindFirstChildOfClass("UIStroke")

			if v14 then
				TweenService:Create(v14, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 0
				}):Play()
			end

			continue
		end

		if v:IsA("ImageLabel") or v:IsA("ImageButton") then
			TweenService:Create(v, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageTransparency = 0
			}):Play()
		end
	end

	task.delay(8, function() --[[ Line: 965 | Upvalues: AnnouncementClone (copy), TweenService (ref), UIScale (ref), list (copy), removeFromActive (ref) ]]
		if not AnnouncementClone.Parent then
			return
		end

		local v1 = TweenService:Create(UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Scale = 0.96
		})

		v1:Play()

		for i, v in ipairs(list) do
			if v:IsA("TextLabel") or v:IsA("TextButton") then
				TweenService:Create(v, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					TextTransparency = 1,
					TextStrokeTransparency = 1
				}):Play()

				local v2 = v:FindFirstChild("StrongStroke") or v:FindFirstChildOfClass("UIStroke")

				if v2 then
					TweenService:Create(v2, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Transparency = 1
					}):Play()
				end

				continue
			end

			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				TweenService:Create(v, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					ImageTransparency = 1
				}):Play()
			end
		end

		v1.Completed:Wait()
		removeFromActive(AnnouncementClone)

		if not AnnouncementClone.Parent then
			return
		end

		AnnouncementClone:Destroy()
	end)
end

AdminAnnounce.OnClientEvent:Connect(function(p1, p2, p3, p4) --[[ Line: 1015 | Upvalues: t3 (copy), showAnnouncement (copy) ]]
	local v1 = tostring(p2 or "") .. "|" .. tostring(p4 or "") .. "|" .. tostring(p3 or "")

	if not t3[v1] then
		t3[v1] = true
		task.delay(2, function() --[[ Line: 1024 | Upvalues: t3 (ref), v1 (copy) ]]
			t3[v1] = nil
		end)
		task.spawn(function() --[[ Line: 1028 | Upvalues: showAnnouncement (ref), p1 (copy), p2 (copy), p3 (copy), p4 (copy) ]]
			showAnnouncement(p1, p2, p3, p4)
		end)
	end
end)