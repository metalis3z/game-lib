local AbbreviateModule = {}


-- It has to be a string value!


-- Sorry That Its So Messy
-- Because Its the Only Thing I could think of
AbbreviateModule.AvailableAbbreviations = {
	K = 4;
	M = 7;
	B = 10;
	T = 13;
	Qua = 16;
	Qui = 19;
	Se = 22;
	Sep = 25;
	Oct = 28;
	Non = 31;
	Dec = 34;
	Und = 37;
	Duo = 40;
	Tre = 43;
	Quattd = 46;
	Quin = 49;
	Sed = 52;
	Sept = 55;
	Octo = 58;
	Nove = 61;
	Vigi = 64;
	Unvig = 67;
	Duov = 70;
	Tresv= 73;
	Quattv = 76;
	Quinv = 79;
	Ses = 82;
	Septe = 85;
	Octov = 88;
	Novev = 91;
	Tri = 94;
	Unt = 97;
	Duot = 100;
	Goo = 101
}
function AbbreviateModule:AbbreviateNumbers(x)
	local digits = tostring(x)
	digits = #digits
	local realX = x
	if digits < 4 then
		return x
	end
	for i,v in pairs(self.AvailableAbbreviations) do
		if digits >= v and digits < v+3 then
			local ChosenLetter = i
			local AbState = string.format("%.1f",tonumber(realX)/10^(v-1))..i
			return AbState
		end
	end
end








return AbbreviateModule