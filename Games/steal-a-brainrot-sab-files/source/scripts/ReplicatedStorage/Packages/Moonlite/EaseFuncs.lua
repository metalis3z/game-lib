
local t1 = {}
local scriptParent = script.Parent

require(scriptParent.Types)

function t1.Linear(p1, p2, p3, p4)
	return p3 * p1 / p4 + p2
end
function t1.Constant(p5, _, _, p8)
	if p5 == p8 then
		return 1
	end

	return 0
end
function t1.InSine(p9, p10, p11, p12)
	return -p11 * math.cos(p9 / p12 * 1.5707963267948966) + p11 + p10
end
function t1.OutSine(p13, p14, p15, p16)
	return p15 * math.sin(p13 / p16 * 1.5707963267948966) + p14
end
function t1.InOutSine(p17, p18, p19, p20)
	return -p19 / 2 * (math.cos(3.141592653589793 * p17 / p20) - 1) + p18
end
function t1.OutInSine(p21, p22, p23, p24)
	if p21 < p24 / 2 then
		return t1.OutSine(p21 * 2, p22, p23 / 2, p24)
	end

	return t1.InSine(p21 * 2 - p24, p22 + p23 / 2, p23 / 2, p24)
end
function t1.InQuad(p25, p26, p27, p28)
	return p27 * math.pow(p25 / p28, 2) + p26
end
function t1.OutQuad(p29, p30, p31, p32)
	local v39 = p29 / p32

	return -p31 * v39 * (v39 - 2) + p30
end
function t1.InOutQuad(p33, p34, p35, p36)
	local v44 = p33 / p36 * 2

	if v44 < 1 then
		return p35 / 2 * math.pow(v44, 2) + p34
	end

	return -p35 / 2 * ((v44 - 1) * (v44 - 3) - 1) + p34
end
function t1.OutInQuad(p37, p38, p39, p40)
	if p37 < p40 / 2 then
		return t1.OutQuad(p37 * 2, p38, p39 / 2, p40)
	end

	return t1.InQuad(p37 * 2 - p40, p38 + p39 / 2, p39 / 2, p40)
end
function t1.InCubic(p41, p42, p43, p44)
	return p43 * math.pow(p41 / p44, 3) + p42
end
function t1.OutCubic(p45, p46, p47, p48)
	return p47 * (math.pow(p45 / p48 - 1, 3) + 1) + p46
end
function t1.InOutCubic(p49, p50, p51, p52)
	local v61 = p49 / p52 * 2

	if v61 < 1 then
		return p51 / 2 * v61 * v61 * v61 + p50
	end

	local v62 = v61 - 2

	return p51 / 2 * (v62 * v62 * v62 + 2) + p50
end
function t1.OutInCubic(p53, p54, p55, p56)
	if p53 < p56 / 2 then
		return t1.OutCubic(p53 * 2, p54, p55 / 2, p56)
	end

	return t1.InCubic(p53 * 2 - p56, p54 + p55 / 2, p55 / 2, p56)
end
function t1.InQuart(p57, p58, p59, p60)
	return p59 * math.pow(p57 / p60, 4) + p58
end
function t1.OutQuart(p61, p62, p63, p64)
	local v75 = p61 / p64 - 1

	return -p63 * (math.pow(v75, 4) - 1) + p62
end
function t1.InOutQuart(p65, p66, p67, p68)
	local v80 = p65 / p68 * 2

	if v80 < 1 then
		return p67 / 2 * math.pow(v80, 4) + p66
	end

	local v81 = v80 - 2

	return -p67 / 2 * (math.pow(v81, 4) - 2) + p66
end
function t1.OutInQuart(p69, p70, p71, p72)
	if p69 < p72 / 2 then
		return t1.OutQuart(p69 * 2, p70, p71 / 2, p72)
	end

	return t1.InQuart(p69 * 2 - p72, p70 + p71 / 2, p71 / 2, p72)
end
function t1.InQuint(p73, p74, p75, p76)
	return p75 * math.pow(p73 / p76, 5) + p74
end
function t1.OutQuint(p77, p78, p79, p80)
	return p79 * (math.pow(p77 / p80 - 1, 5) + 1) + p78
end
function t1.InOutQuint(p81, p82, p83, p84)
	local v98 = p81 / p84 * 2

	if v98 < 1 then
		return p83 / 2 * math.pow(v98, 5) + p82
	end

	local v99 = v98 - 2

	return p83 / 2 * (math.pow(v99, 5) + 2) + p82
end
function t1.OutInQuint(p85, p86, p87, p88)
	if p85 < p88 / 2 then
		return t1.OutQuint(p85 * 2, p86, p87 / 2, p88)
	end

	return t1.InQuint(p85 * 2 - p88, p86 + p87 / 2, p87 / 2, p88)
end
function t1.InSextic(p89, p90, p91, p92)
	return p91 * math.pow(p89 / p92, 6) + p90
end
function t1.OutSextic(p93, p94, p95, p96)
	local v112 = p93 / p96 - 1

	return -p95 * (math.pow(v112, 6) - 1) + p94
end
function t1.InOutSextic(p97, p98, p99, p100)
	local v117 = p97 / p100 * 2

	if v117 < 1 then
		return p99 / 2 * math.pow(v117, 6) + p98
	end

	local v118 = v117 - 2

	return -p99 / 2 * (math.pow(v118, 6) - 2) + p98
end
function t1.OutInSextic(p101, p102, p103, p104)
	if p101 < p104 / 2 then
		return t1.OutSextic(p101 * 2, p102, p103 / 2, p104)
	end

	return t1.InSextic(p101 * 2 - p104, p102 + p103 / 2, p103 / 2, p104)
end
function t1.InExpo(p105, p106, p107, p108)
	if p105 == 0 then
		return p106
	end

	return p107 * math.pow(2, 10 * (p105 / p108 - 1)) + p106 - p107 * 0.001
end
function t1.OutExpo(p109, p110, p111, p112)
	if p109 == p112 then
		return p110 + p111
	end

	return p111 * 1.001 * (-math.pow(2, -10 * p109 / p112) + 1) + p110
end
function t1.InOutExpo(p113, p114, p115, p116)
	if p113 == 0 then
		return p114
	end

	if p113 == p116 then
		return p114 + p115
	end

	local v135 = p113 / p116 * 2

	if v135 < 1 then
		return p115 / 2 * math.pow(2, 10 * (v135 - 1)) + p114 - p115 * 0.0005
	end

	local v136 = v135 - 1

	return p115 / 2 * 1.0005 * (-math.pow(2, -10 * v136) + 2) + p114
end
function t1.OutInExpo(p117, p118, p119, p120)
	if p117 < p120 / 2 then
		return t1.OutExpo(p117 * 2, p118, p119 / 2, p120)
	end

	return t1.InExpo(p117 * 2 - p120, p118 + p119 / 2, p119 / 2, p120)
end
function t1.InCirc(p121, p122, p123, p124)
	local v145 = p121 / p124

	return -p123 * (math.sqrt(1 - math.pow(v145, 2)) - 1) + p122
end
function t1.OutCirc(p125, p126, p127, p128)
	return p127 * math.sqrt(1 - math.pow(p125 / p128 - 1, 2)) + p126
end
function t1.InOutCirc(p129, p130, p131, p132)
	local v154 = p129 / p132 * 2

	if v154 < 1 then
		return -p131 / 2 * (math.sqrt(1 - v154 * v154) - 1) + p130
	end

	local v155 = v154 - 2

	return p131 / 2 * (math.sqrt(1 - v155 * v155) + 1) + p130
end
function t1.OutInCirc(p133, p134, p135, p136)
	if p133 < p136 / 2 then
		return t1.OutCirc(p133 * 2, p134, p135 / 2, p136)
	end

	return t1.InCirc(p133 * 2 - p136, p134 + p135 / 2, p135 / 2, p136)
end
function t1.InBack(p137, p138, p139, p140, p141)
	if not p141 then
		p141 = 1.70158
	end

	local v165 = p137 / p140

	return p139 * v165 * v165 * ((p141 + 1) * v165 - p141) + p138
end
function t1.OutBack(p142, p143, p144, p145, p146)
	if not p146 then
		p146 = 1.70158
	end

	local v171 = p142 / p145 - 1

	return p144 * (v171 * v171 * ((p146 + 1) * v171 + p146) + 1) + p143
end
function t1.InOutBack(p147, p148, p149, p150, p151)
	if not p151 then
		p151 = 1.70158
	end

	local v177 = p151 * 1.525
	local v178 = p147 / p150 * 2

	if v178 < 1 then
		return p149 / 2 * (v178 * v178 * ((v177 + 1) * v178 - v177)) + p148
	end

	local v179 = v178 - 2

	return p149 / 2 * (v179 * v179 * ((v177 + 1) * v179 + v177) + 2) + p148
end
function t1.OutInBack(p152, p153, p154, p155, p156)
	if p152 < p155 / 2 then
		return t1.OutBack(p152 * 2, p153, p154 / 2, p155, p156)
	end

	return t1.InBack(p152 * 2 - p155, p153 + p154 / 2, p154 / 2, p155, p156)
end
function t1.OutBounce(p157, p158, p159, p160)
	local v189 = p157 / p160

	if v189 < 0.36363636363636365 then
		return p159 * (7.5625 * v189 * v189) + p158
	end

	if v189 < 0.7272727272727273 then
		local v190 = v189 - 0.5454545454545454

		return p159 * (7.5625 * v190 * v190 + 0.75) + p158
	end

	if v189 < 0.9090909090909091 then
		local v191 = v189 - 0.8181818181818182

		return p159 * (7.5625 * v191 * v191 + 0.9375) + p158
	end

	local v192 = v189 - 0.9545454545454546

	return p159 * (7.5625 * v192 * v192 + 0.984375) + p158
end
function t1.InBounce(p161, p162, p163, p164)
	return p163 - t1.OutBounce(p164 - p161, 0, p163, p164) + p162
end
function t1.InOutBounce(p165, p166, p167, p168)
	if p165 < p168 / 2 then
		return t1.InBounce(p165 * 2, 0, p167, p168) * 0.5 + p166
	end

	return t1.OutBounce(p165 * 2 - p168, 0, p167, p168) * 0.5 + p167 * 0.5 + p166
end
function t1.OutInBounce(p169, p170, p171, p172)
	if p169 < p172 / 2 then
		return t1.OutBounce(p169 * 2, p170, p171 / 2, p172)
	end

	return t1.InBounce(p169 * 2 - p172, p170 + p171 / 2, p171 / 2, p172)
end
function t1.ElasticBlend(p173, p174, p175, p176, p177, p178)
	if p174 ~= 0 then
		local v211 = math.abs(p177)

		p178 = p176 == 0 and 0 or p178 * (p176 / math.abs(p174))

		if v211 > math.abs(p173 * p175) then
			local v212 = math.abs(p173 * p175) / v211

			p178 = p178 * v212 + (1 - v212)
		end
	end

	return p178
end
function t1.InElastic(p179, p180, p181, p182, p183, p184)
	local n1 = 1

	if p179 == 0 then
		return p180
	end

	local v220 = p179 / p182

	if v220 == 1 then
		return p180 + p181
	end

	local v221 = v220 - 1

	if not p184 or p184 == 0 then
		p184 = p182 * 0.3
	end

	local v222

	if p183 == nil or p183 < math.abs(p181) then
		v222 = p184 / 4
		n1 = t1.ElasticBend(v221, p181, p182, p183, v222, n1)
		p183 = p181
	else
		v222 = p184 / 6.283185307179586 * math.asin(p181 / p183)
	end

	return -n1 * (p183 * math.pow(2, 10 * v221) * math.sin((v221 * p182 - v222) * 6.283185307179586 / p184)) + p180
end
function t1.OutElastic(p185, p186, p187, p188, p189, p190)
	local n2 = 1

	if p185 == 0 then
		return p186
	end

	local v230 = p185 / p188

	if v230 == 1 then
		return p186 + p187
	end

	local v231 = -v230

	if not p190 or p190 == 0 then
		p190 = p188 * 0.3
	end

	local v232

	if p189 == nil or p189 < math.abs(p187) then
		v232 = p190 / 4
		n2 = t1.ElasticBlend(v231, p187, p188, p189, v232, n2)
		p189 = p187
	else
		v232 = p190 / 6.283185307179586 * math.asin(p187 / p189)
	end

	return n2 * (p189 * math.pow(2, 10 * v231) * math.sin((v231 * p188 - v232) * 6.283185307179586 / p190)) + p187 + p186
end
function t1.InOutElastic(p191, p192, p193, p194, p195, p196)
	local n3 = 1

	if p191 == 0 then
		return p192
	end

	local v240 = p191 / (p194 / 2)

	if v240 == 2 then
		return p192 + p193
	end

	local v241 = v240 - 1

	if not p196 or p196 == 0 then
		p196 = p194 * 0.44999999999999996
	end

	local v242

	if p195 == nil or p195 < math.abs(p193) then
		v242 = p196 / 4
		n3 = t1.ElasticBlend(v241, p193, p194, p195, v242, n3)
		p195 = p193
	else
		v242 = p196 / 6.283185307179586 * math.asin(p193 / p195)
	end

	if v241 < 0 then
		return n3 * -0.5 * (p195 * math.pow(2, 10 * v241) * math.sin((v241 * p194 - v242) * 6.283185307179586 / p196)) + p192
	end

	local v243 = -v241

	return n3 * 0.5 * (p195 * math.pow(2, 10 * v243) * math.sin((v243 * p194 - v242) * 6.283185307179586 / p196)) + p193 + p192
end
function t1.OutInElastic(p197, p198, p199, p200, p201, p202)
	if p197 < p200 / 2 then
		return t1.OutElastic(p197 * 2, p198, p199 / 2, p200, p201, p202)
	end

	return t1.InElastic(p197 * 2 - p200, p198 + p199 / 2, p199 / 2, p200, p201, p202)
end

local HttpService = game:GetService("HttpService")
local t2 = {
	Type = "Linear",
	Params = {}
}
local t3 = {}

local function get(p203)
	local v251 = p203 or t2
	local json = HttpService:JSONEncode(v251)

	if t3[json] == nil then
		local Params = v251.Params
		local v254 = v251.Type or "Linear"
		local v255 = t1[`{ Params.Direction or "In" }{ v254 }`] or t1[v254]

		if not v255 then
			return get(t2)
		end

		local u256 = nil
		local u257 = nil

		if v254 == "Elastic" then
			u256 = Params.Amplitude or 1
			u257 = Params.Period or 0.3
		elseif v254 == "Back" then
			u256 = Params.Overshoot or 1.70158
		end

		t3[json] = function(p204)
			return v255(p204, 0, 1, 1, u256, u257)
		end
	end

	return t3[json]
end

return {
	Get = get
}
