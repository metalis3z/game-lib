-- Generated from ui/_StarterGui-all.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)
-- Large pack: split into ModuleScript children (Rojo layout). In Studio make init.lua a ModuleScript
-- and put each PartNN.lua inside it as a ModuleScript named PartNN.

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local parts = { script.Part01, script.Part02, script.Part03, script.Part04 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[75].Value = I[80]
	I[76].Value = I[83]
	I[77].Value = I[61]
	I[102].Value = I[107]
	I[103].Value = I[110]
	I[104].Value = I[88]
	I[323].Value = I[326]
	I[324].Value = I[330]
	I[334].Value = I[337]
	I[335].Value = I[340]
	I[614].Value = I[619]
	I[615].Value = I[622]
	I[616].Value = I[600]
	I[641].Value = I[646]
	I[642].Value = I[649]
	I[643].Value = I[627]
	I[670].Value = I[675]
	I[671].Value = I[678]
	I[672].Value = I[656]
	I[697].Value = I[702]
	I[698].Value = I[705]
	I[699].Value = I[683]
	I[724].Value = I[729]
	I[725].Value = I[732]
	I[726].Value = I[710]
	I[758].Value = I[752]
	I[759].Value = I[755]
	I[802].Value = I[807]
	I[803].Value = I[810]
	I[804].Value = I[788]
	I[832].Value = I[837]
	I[833].Value = I[840]
	I[834].Value = I[818]
	I[866].Value = I[860]
	I[867].Value = I[863]
	I[952].Value = I[957]
	I[953].Value = I[960]
	I[954].Value = I[949]
	I[972].Value = I[977]
	I[973].Value = I[980]
	I[974].Value = I[969]
	I[992].Value = I[997]
	I[993].Value = I[1000]
	I[994].Value = I[989]
	I[1129].Value = I[1113]
	I[1148].Value = I[1142]
	I[1149].Value = I[1145]
	I[1216].Value = I[1200]
	I[1235].Value = I[1229]
	I[1236].Value = I[1232]
	I[1293].Value = I[1277]
	I[1312].Value = I[1306]
	I[1313].Value = I[1309]
	I[1380].Value = I[1364]
	I[1399].Value = I[1393]
	I[1400].Value = I[1396]
	I[1467].Value = I[1451]
	I[1486].Value = I[1480]
	I[1487].Value = I[1483]
	I[1554].Value = I[1538]
	I[1573].Value = I[1567]
	I[1574].Value = I[1570]
	I[1641].Value = I[1625]
	I[1660].Value = I[1654]
	I[1661].Value = I[1657]
	I[1728].Value = I[1712]
	I[1747].Value = I[1741]
	I[1748].Value = I[1744]
	I[1815].Value = I[1799]
	I[1834].Value = I[1828]
	I[1835].Value = I[1831]
	I[1902].Value = I[1886]
	I[1921].Value = I[1915]
	I[1922].Value = I[1918]
	I[1989].Value = I[1973]
	I[2008].Value = I[2002]
	I[2009].Value = I[2005]
	I[2076].Value = I[2060]
	I[2095].Value = I[2089]
	I[2096].Value = I[2092]
	I[2163].Value = I[2147]
	I[2182].Value = I[2176]
	I[2183].Value = I[2179]
	return { I[1], I[2225] }
end

return build
