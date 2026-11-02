local Kyfect = {}

function Kyfect:MergeTables(...)
	local NewTable = {}
	local TablesToMerge = {...}
	for Index, Table in pairs (TablesToMerge) do
		for Key, Value in pairs (Table) do
			NewTable[Key] = Value
		end
	end
	return NewTable
end

function Kyfect:Dump(Variable)
	if type(Variable) == "string" then
		print("string(" .. string.len(Variable) .. ") " .. Variable)
		return
	end
	if type(Variable) == "table" then
		print("table(" .. #Variable .. ") " .. game.HttpService:JSONEncode(Variable))
		return
	end
	print(type(Variable), Variable)
end

function Kyfect:New(Type, Parent, Table)
	local New = Instance.new(Type)
	if Table then
		for Property, Value in pairs (Table) do
			New[Property] = Value
		end
	end
	if Parent then
		New.Parent = Parent
	end
	return New
end

function Kyfect:Sep(String, Sep)
	String = tostring(String)
	if Sep == nil then
		Sep = ","
	end
	local NewString = ""
	while #String > 3 do
		NewString = Sep .. string.sub(String, #String - 2) .. NewString
		String = string.sub(String, 1, #String - 3)
	end
	return String .. NewString
end

function Kyfect:Round(Num, Dg)
	Num = math.floor(Num * 10 ^ Dg) / 10 ^ Dg
	return Num
end

function Kyfect:Short(Number, Prefix)
	if Prefix == nil then
		Prefix = ""
	end
	if Number < 0 then
		return "-" .. Kyfect:Short(-Number, Prefix)
	end
	Number = math.floor(Number)
	local Rnd = 2 - math.floor(math.log10(Number))
	if Number >= 10^9 then
		return Prefix .. Kyfect:Round(Number, Rnd) / 10^9 .. "B"
	end
	if Number >= 10^6 then
		return Prefix .. Kyfect:Round(Number, Rnd) / 10^6 .. "M"
	end
	if Number >= 10^4 then
		return Prefix .. Kyfect:Round(Number, Rnd) / 10^3 .. "K"
	end
	return Prefix .. Kyfect:Sep(Number)
end

function Kyfect:Format(Number, Prefix, Places, Sep)
	if Prefix == nil then
		Prefix = ""
	end
	if Places == nil then
		Places = 0
	end
	if Sep == nil then
		Sep = ","
	end
	if Number < 0 then
		return "-" .. Kyfect:Format(-Number, Prefix, Places, Sep)
	end
	if Places > 0 then
		local End = "."
		local Dec = Number - math.floor(Number)
		while Places > 0 do
			Dec = Dec * 10
			End = End .. math.floor(Dec + 0.000000001)
			Dec = Dec - math.floor(Dec)
			Places = Places - 1
		end
		return Prefix .. Kyfect:Sep(math.floor(Number), Sep) .. End
	end
	return Prefix .. Kyfect:Sep(math.floor(Number), Sep)
end

return Kyfect