--credit to quartz games studio
local HttpService = game:GetService("HttpService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local JSONEncoder = require(game.ReplicatedStorage.UserGenerated.IO.JSONEncoder)
local t = {
	http = 80,
	https = 443
}
local v1 = Asserts.Optional(Asserts.Set(Keys(t)))
local String = Asserts.String
local v2 = Asserts.Optional(Asserts.IntegerRange(0, 65535))

local function f3(p1) --[[ Line: 34 ]]
	if type(p1) ~= "string" then
		error("string", 2)
	end

	if not utf8.len(p1) then
		error("UTF8", 2)
	end

	if #p1 > 0 and string.byte(p1, 1) ~= 47 then
		error("PathPrefix", 2)
	end

	return p1
end

local v4 = Asserts.Map(Asserts.String, Asserts.Any)
local v5 = Asserts.Table({
	Protocol = v1,
	Host = String,
	Port = v2,
	Path = f3,
	Params = Asserts.Optional(v4),
	Fragment = Asserts.Optional(Asserts.String)
})
local t2 = {
	AssertProtocol = v1,
	AssertHost = String,
	AssertPort = v2,
	AssertPath = f3,
	AssertEncodeParams = v4,
	AssertParams = v5,
	EncodePath = function(p1) --[[ EncodePath | Line: 72 | Upvalues: Asserts (copy), HttpService (copy) ]]
		Asserts.String(p1)

		return p1:gsub("([^/]+)", function(p1) --[[ Line: 76 | Upvalues: HttpService (ref) ]]
			return HttpService:UrlEncode(p1)
		end)
	end,
	EncodeParams = function(p1) --[[ EncodeParams | Line: 82 | Upvalues: v4 (copy), Keys (copy), JSONEncoder (copy), HttpService (copy) ]]
		v4(p1)

		local v1 = Keys(p1)

		table.sort(v1)

		local t = {}

		for i, v in ipairs(v1) do
			local v2 = JSONEncoder.Compact(p1[v])

			table.insert(t, HttpService:UrlEncode(v) .. "=" .. HttpService:UrlEncode(v2))
		end

		return table.concat(t, "&")
	end
}

function t2.Build(p1) --[[ Build | Line: 99 | Upvalues: v5 (copy), t (copy), t2 (copy), HttpService (copy) ]]
	v5(p1)

	local v1 = p1.Protocol or "https"
	local v2 = t[v1] or 80
	local v3 = p1.Port or v2
	local t3 = {}

	table.insert(t3, v1)
	table.insert(t3, "://")
	table.insert(t3, p1.Host)

	if v3 ~= v2 then
		table.insert(t3, ":")
		table.insert(t3, (tostring(v3)))
	end

	table.insert(t3, t2.EncodePath(p1.Path))

	local Params = p1.Params

	if Params and next(Params) ~= nil then
		table.insert(t3, "?")
		table.insert(t3, t2.EncodeParams(Params))
	end

	if p1.Fragment then
		table.insert(t3, "#")
		table.insert(t3, HttpService:UrlEncode(p1.Fragment))
	end

	return table.concat(t3)
end

return table.freeze(t2)