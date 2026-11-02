local suffixList = {'K', 'M', 'B', 'T', "Qd", "Qn", "Sx", "Sp", 'O', 'N', "de", "Ud", "DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg", "qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG", "ssTG", "SpTG", "OcTG", "NoAG", "UnAG", "DuAG", "TeAG", "QdAG", "QnAG", "SxAG", "SpAG", "OcAG", "NvAG", "CT", "Aa", "Ab", "Ac", "Ad", "Ae", "Af", "Ag", "Ah", "Ai", "Aj", "Ak", "Al", "Am", "An", "Ao", "Ap", "Aq", "Ar", "As", "At", "Au", "Av", "Aw", "Ax", "Ay", "Az", "Ba", "Bb", "Bc", "Bd", "Be", "Bf", "Bg", "Bh", "Bi", "Bj", "Bk", "Bl", "Bm", "Bn", "Bo", "Bp", "Bq", "Br", "Bs", "Bt", "Bu", "Bv", "Bw", "Bx", "By", "Bz"}

return function(num, decimals)
	if not num or num ~= num then return "0" end
	if num < 1000 then
		return math.floor(num * 100) / 100
	end
	local dec = decimals or 2
	local digits = math.floor(math.log10(num))
	local suffixIndex = math.floor(digits / 3)
	local divisor = 10 ^ (suffixIndex * 3)
	local shortened = math.floor(num / divisor * 10 ^ dec) / 10 ^ dec
	return shortened .. (suffixList[suffixIndex] or "")
end