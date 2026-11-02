local v0 = "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>suitcase</font></stroke>"
local v1 = "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'"
local t = {}
local t2 = {}
local t3 = { "VAR_1", "VAR_2" }
local v260

do
	local function newDialog(p1, p2) --[[ newDialog | Line: 6 | Upvalues: t2 (copy) ]]
		local v1 = t2[p1]

		if not v1 then
			v1 = {}
			t2[p1] = v1
		end

		v1[#v1 + 1] = p2
	end

	function t.GetFromVGroup(p1, p2) --[[ GetFromVGroup | Line: 15 | Upvalues: t2 (copy), t3 (copy) ]]
		local v1 = t2[p1]

		if not v1 then
			return nil
		end

		local v2 = v1[math.random(1, #v1)]

		for i, v in ipairs(t3) do
			v2 = string.gsub(v2, v, p2[i] or "")
		end

		return v2
	end

	local function col(p1, p2) --[[ col | Line: 29 ]]
		local v1, v2, v3 = p2:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")

		if v1 and (v2 and v3) then
			return "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v1) * 0.3), math.floor(tonumber(v2) * 0.4), (math.floor(tonumber(v3) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. p2 .. "\'>" .. p1 .. "</font></stroke>"
		end

		return "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'" .. p2 .. "\'>" .. p1 .. "</font></stroke>"
	end

	local Greeting = t2.Greeting

	if not Greeting then
		Greeting = {}
		t2.Greeting = Greeting
	end

	Greeting[#Greeting + 1] = "Hello, My name is " .. t3[1]

	local Greeting2 = t2.Greeting

	if not Greeting2 then
		Greeting2 = {}
		t2.Greeting = Greeting2
	end

	Greeting2[#Greeting2 + 1] = "I\'m " .. t3[1]

	local Greeting3 = t2.Greeting

	if not Greeting3 then
		Greeting3 = {}
		t2.Greeting = Greeting3
	end

	Greeting3[#Greeting3 + 1] = "Sup, I\'m " .. t3[1]

	local Greeting4 = t2.Greeting

	if not Greeting4 then
		Greeting4 = {}
		t2.Greeting = Greeting4
	end

	Greeting4[#Greeting4 + 1] = "..."

	local Greeting5 = t2.Greeting

	if not Greeting5 then
		Greeting5 = {}
		t2.Greeting = Greeting5
	end

	Greeting5[#Greeting5 + 1] = "Hey..."

	local v5, v6, v7 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v14 = "I want to check in as a " .. (if v5 and (v6 and v7) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v5) * 0.3), math.floor(tonumber(v6) * 0.4), (math.floor(tonumber(v7) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>patient</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>patient</font></stroke>") .. "..."
	local Patient = t2.Patient

	if not Patient then
		Patient = {}
		t2.Patient = Patient
	end

	Patient[#Patient + 1] = v14

	local Patient2 = t2.Patient

	if not Patient2 then
		Patient2 = {}
		t2.Patient = Patient2
	end

	Patient2[#Patient2 + 1] = "I\'m here for my appointment..."

	local Patient3 = t2.Patient

	if not Patient3 then
		Patient3 = {}
		t2.Patient = Patient3
	end

	Patient3[#Patient3 + 1] = "I have an appointment..."

	local BurningGreeting = t2.BurningGreeting

	if not BurningGreeting then
		BurningGreeting = {}
		t2.BurningGreeting = BurningGreeting
	end

	BurningGreeting[#BurningGreeting + 1] = "AAAAH!! I\'M ON FIRE!!"

	local BurningPatient = t2.BurningPatient

	if not BurningPatient then
		BurningPatient = {}
		t2.BurningPatient = BurningPatient
	end

	BurningPatient[#BurningPatient + 1] = "I NEED HELP!!!"

	local v16 = "room " .. t3[1]
	local v17, v18, v19 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v26 = "Thanks, I will be in " .. (if v17 and (v18 and v19) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v17) * 0.3), math.floor(tonumber(v18) * 0.4), (math.floor(tonumber(v19) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(100, 255, 255)" .. "\'>" .. v16 .. "</font></stroke>" else v1 .. "rgb(100, 255, 255)" .. "\'>" .. v16 .. "</font></stroke>")
	local RoomAssigned = t2.RoomAssigned

	if not RoomAssigned then
		RoomAssigned = {}
		t2.RoomAssigned = RoomAssigned
	end

	RoomAssigned[#RoomAssigned + 1] = v26

	local v28 = "room " .. t3[1]
	local v29, v30, v31 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v38 = "I will be in " .. (if v29 and (v30 and v31) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v29) * 0.3), math.floor(tonumber(v30) * 0.4), (math.floor(tonumber(v31) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(100, 255, 255)" .. "\'>" .. v28 .. "</font></stroke>" else v1 .. "rgb(100, 255, 255)" .. "\'>" .. v28 .. "</font></stroke>")
	local RoomAssigned2 = t2.RoomAssigned

	if not RoomAssigned2 then
		RoomAssigned2 = {}
		t2.RoomAssigned = RoomAssigned2
	end

	RoomAssigned2[#RoomAssigned2 + 1] = v38

	local v40 = "room " .. t3[1]
	local v41, v42, v43 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v50 = "I got " .. (if v41 and (v42 and v43) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v41) * 0.3), math.floor(tonumber(v42) * 0.4), (math.floor(tonumber(v43) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(100, 255, 255)" .. "\'>" .. v40 .. "</font></stroke>" else v1 .. "rgb(100, 255, 255)" .. "\'>" .. v40 .. "</font></stroke>")
	local RoomAssigned3 = t2.RoomAssigned

	if not RoomAssigned3 then
		RoomAssigned3 = {}
		t2.RoomAssigned = RoomAssigned3
	end

	RoomAssigned3[#RoomAssigned3 + 1] = v50

	local v51 = "ROOM " .. t3[1]
	local v52, v53, v54 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v61 = (if v52 and (v53 and v54) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v52) * 0.3), math.floor(tonumber(v53) * 0.4), (math.floor(tonumber(v54) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(100, 255, 255)" .. "\'>" .. v51 .. "</font></stroke>" else v1 .. "rgb(100, 255, 255)" .. "\'>" .. v51 .. "</font></stroke>") .. "! OK!! AHH!!"
	local BurningRoom = t2.BurningRoom

	if not BurningRoom then
		BurningRoom = {}
		t2.BurningRoom = BurningRoom
	end

	BurningRoom[#BurningRoom + 1] = v61

	local CheckedInQuotes = t2.CheckedInQuotes

	if not CheckedInQuotes then
		CheckedInQuotes = {}
		t2.CheckedInQuotes = CheckedInQuotes
	end

	CheckedInQuotes[#CheckedInQuotes + 1] = "..."

	local CheckedInQuotes2 = t2.CheckedInQuotes

	if not CheckedInQuotes2 then
		CheckedInQuotes2 = {}
		t2.CheckedInQuotes = CheckedInQuotes2
	end

	CheckedInQuotes2[#CheckedInQuotes2 + 1] = "Are the myths real...?"

	local CheckedInQuotes3 = t2.CheckedInQuotes

	if not CheckedInQuotes3 then
		CheckedInQuotes3 = {}
		t2.CheckedInQuotes = CheckedInQuotes3
	end

	CheckedInQuotes3[#CheckedInQuotes3 + 1] = "This place gives me the creeps..."

	local CheckedInQuotes4 = t2.CheckedInQuotes

	if not CheckedInQuotes4 then
		CheckedInQuotes4 = {}
		t2.CheckedInQuotes = CheckedInQuotes4
	end

	CheckedInQuotes4[#CheckedInQuotes4 + 1] = "I hope I can get out of here soon..."

	local CheckedInQuotes5 = t2.CheckedInQuotes

	if not CheckedInQuotes5 then
		CheckedInQuotes5 = {}
		t2.CheckedInQuotes = CheckedInQuotes5
	end

	CheckedInQuotes5[#CheckedInQuotes5 + 1] = "There are stories about this place..."

	local threeDots = t2.threeDots

	if not threeDots then
		threeDots = {}
		t2.threeDots = threeDots
	end

	threeDots[#threeDots + 1] = "...!"

	local v63, v64, v65 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v72 = "You must be the new hire, I\'m " .. (if v63 and (v64 and v65) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v63) * 0.3), math.floor(tonumber(v64) * 0.4), (math.floor(tonumber(v65) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>Dr Harlow</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>Dr Harlow</font></stroke>") .. "."
	local DoctorDay1Greeting = t2.DoctorDay1Greeting

	if not DoctorDay1Greeting then
		DoctorDay1Greeting = {}
		t2.DoctorDay1Greeting = DoctorDay1Greeting
	end

	DoctorDay1Greeting[#DoctorDay1Greeting + 1] = v72

	local DoctorDay1Info = t2.DoctorDay1Info

	if not DoctorDay1Info then
		DoctorDay1Info = {}
		t2.DoctorDay1Info = DoctorDay1Info
	end

	DoctorDay1Info[#DoctorDay1Info + 1] = "Some advice: If things get strange, just keep working."

	local v74, v75, v76 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v77 = if v74 and (v75 and v76) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v74) * 0.3), math.floor(tonumber(v75) * 0.4), (math.floor(tonumber(v76) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>shutters</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>shutters</font></stroke>"
	local v84, v85, v86 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v93 = "I will fix up the " .. v77 .. " and " .. (if v84 and (v85 and v86) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v84) * 0.3), math.floor(tonumber(v85) * 0.4), (math.floor(tonumber(v86) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>security cameras</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>security cameras</font></stroke>") .. " for you."
	local DoctorDay1Info2 = t2.DoctorDay1Info2

	if not DoctorDay1Info2 then
		DoctorDay1Info2 = {}
		t2.DoctorDay1Info2 = DoctorDay1Info2
	end

	DoctorDay1Info2[#DoctorDay1Info2 + 1] = v93

	local DoctorDay2Info = t2.DoctorDay2Info

	if not DoctorDay2Info then
		DoctorDay2Info = {}
		t2.DoctorDay2Info = DoctorDay2Info
	end

	DoctorDay2Info[#DoctorDay2Info + 1] = "I\'m opening new facilities for you."

	local v95, v96, v97 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v98 = if v95 and (v96 and v97) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v95) * 0.3), math.floor(tonumber(v96) * 0.4), (math.floor(tonumber(v97) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>supplies shop</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>supplies shop</font></stroke>"
	local v105, v106, v107 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v108 = if v105 and (v106 and v107) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v105) * 0.3), math.floor(tonumber(v106) * 0.4), (math.floor(tonumber(v107) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>limited time</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>limited time</font></stroke>"
	local v115, v116, v117 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v124 = "The " .. v98 .. " will be open for a " .. v108 .. " each " .. (if v115 and (v116 and v117) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v115) * 0.3), math.floor(tonumber(v116) * 0.4), (math.floor(tonumber(v117) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>shift</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>shift</font></stroke>") .. "."
	local DoctorDay2Info2 = t2.DoctorDay2Info2

	if not DoctorDay2Info2 then
		DoctorDay2Info2 = {}
		t2.DoctorDay2Info2 = DoctorDay2Info2
	end

	DoctorDay2Info2[#DoctorDay2Info2 + 1] = v124

	local v126, v127, v128 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v135 = "Some patients may seem... " .. (if v126 and (v127 and v128) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v126) * 0.3), math.floor(tonumber(v127) * 0.4), (math.floor(tonumber(v128) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>unstable</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>unstable</font></stroke>") .. "..."
	local DoctorDay3Info = t2.DoctorDay3Info

	if not DoctorDay3Info then
		DoctorDay3Info = {}
		t2.DoctorDay3Info = DoctorDay3Info
	end

	DoctorDay3Info[#DoctorDay3Info + 1] = v135

	local DoctorDay3Info2 = t2.DoctorDay3Info2

	if not DoctorDay3Info2 then
		DoctorDay3Info2 = {}
		t2.DoctorDay3Info2 = DoctorDay3Info2
	end

	DoctorDay3Info2[#DoctorDay3Info2 + 1] = "Make sure to use the photo and cameras. Stay alert."

	local v137, v138, v139 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v146 = "I will unlock the " .. (if v137 and (v138 and v139) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v137) * 0.3), math.floor(tonumber(v138) * 0.4), (math.floor(tonumber(v139) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>taser</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>taser</font></stroke>") .. ". Use it wisely."
	local DoctorDay3Info3 = t2.DoctorDay3Info3

	if not DoctorDay3Info3 then
		DoctorDay3Info3 = {}
		t2.DoctorDay3Info3 = DoctorDay3Info3
	end

	DoctorDay3Info3[#DoctorDay3Info3 + 1] = v146

	local v148, v149, v150 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v151 = if v148 and (v149 and v150) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v148) * 0.3), math.floor(tonumber(v149) * 0.4), (math.floor(tonumber(v150) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>sanity</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>sanity</font></stroke>"
	local v158, v159, v160 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v167 = "Your " .. v151 .. " is important. Don\'t " .. (if v158 and (v159 and v160) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v158) * 0.3), math.floor(tonumber(v159) * 0.4), (math.floor(tonumber(v160) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>DIE</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>DIE</font></stroke>") .. " on me."
	local DoctorDay4Info = t2.DoctorDay4Info

	if not DoctorDay4Info then
		DoctorDay4Info = {}
		t2.DoctorDay4Info = DoctorDay4Info
	end

	DoctorDay4Info[#DoctorDay4Info + 1] = v167

	local v169, v170, v171 = ("rgb(255, 255, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v178 = "And take good care of the " .. (if v169 and (v170 and v171) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v169) * 0.3), math.floor(tonumber(v170) * 0.4), (math.floor(tonumber(v171) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>patients</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>patients</font></stroke>") .. "."
	local DoctorDay4Info2 = t2.DoctorDay4Info2

	if not DoctorDay4Info2 then
		DoctorDay4Info2 = {}
		t2.DoctorDay4Info2 = DoctorDay4Info2
	end

	DoctorDay4Info2[#DoctorDay4Info2 + 1] = v178

	local v180, v181, v182 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v189 = "If the hospital records " .. (if v180 and (v181 and v182) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v180) * 0.3), math.floor(tonumber(v181) * 0.4), (math.floor(tonumber(v182) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'> 3 DEATHS</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'> 3 DEATHS</font></stroke>") .. " it\'s over."
	local DoctorDay4Info3 = t2.DoctorDay4Info3

	if not DoctorDay4Info3 then
		DoctorDay4Info3 = {}
		t2.DoctorDay4Info3 = DoctorDay4Info3
	end

	DoctorDay4Info3[#DoctorDay4Info3 + 1] = v189

	local v191, v192, v193 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v200 = "There\'s been a huge " .. (if v191 and (v192 and v193) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v191) * 0.3), math.floor(tonumber(v192) * 0.4), (math.floor(tonumber(v193) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>anomaly attack</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>anomaly attack</font></stroke>") .. "!"
	local AmbulanceVisit = t2.AmbulanceVisit

	if not AmbulanceVisit then
		AmbulanceVisit = {}
		t2.AmbulanceVisit = AmbulanceVisit
	end

	AmbulanceVisit[#AmbulanceVisit + 1] = v200

	local AmbulanceVisit2 = t2.AmbulanceVisit2

	if not AmbulanceVisit2 then
		AmbulanceVisit2 = {}
		t2.AmbulanceVisit2 = AmbulanceVisit2
	end

	AmbulanceVisit2[#AmbulanceVisit2 + 1] = " 6 people died and many more were hurt."

	local v202, v203, v204 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v211 = "Be prepared, the " .. (if v202 and (v203 and v204) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v202) * 0.3), math.floor(tonumber(v203) * 0.4), (math.floor(tonumber(v204) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>ambulance</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>ambulance</font></stroke>") .. " is coming..."
	local AmbulanceVisit3 = t2.AmbulanceVisit3

	if not AmbulanceVisit3 then
		AmbulanceVisit3 = {}
		t2.AmbulanceVisit3 = AmbulanceVisit3
	end

	AmbulanceVisit3[#AmbulanceVisit3 + 1] = v211

	local AmbulanceFinish = t2.AmbulanceFinish

	if not AmbulanceFinish then
		AmbulanceFinish = {}
		t2.AmbulanceFinish = AmbulanceFinish
	end

	AmbulanceFinish[#AmbulanceFinish + 1] = "Good job, the emergency is over for now."

	local AmbulanceFinish2 = t2.AmbulanceFinish2

	if not AmbulanceFinish2 then
		AmbulanceFinish2 = {}
		t2.AmbulanceFinish2 = AmbulanceFinish2
	end

	AmbulanceFinish2[#AmbulanceFinish2 + 1] = "More ambulances will come, be prepared."

	local v213, v214, v215 = ("rgb(255, 255, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v222 = "Here is a " .. (if v213 and (v214 and v215) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v213) * 0.3), math.floor(tonumber(v214) * 0.4), (math.floor(tonumber(v215) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>bonus</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>bonus</font></stroke>") .. " for you work."
	local AmbulanceFinish3 = t2.AmbulanceFinish3

	if not AmbulanceFinish3 then
		AmbulanceFinish3 = {}
		t2.AmbulanceFinish3 = AmbulanceFinish3
	end

	AmbulanceFinish3[#AmbulanceFinish3 + 1] = v222

	local v223 = t2["1RatthewGreeting"]

	if not v223 then
		v223 = {}
		t2["1RatthewGreeting"] = v223
	end

	v223[#v223 + 1] = "Being small has its advantages..."

	local v224 = t2["1RatthewGreeting2"]

	if not v224 then
		v224 = {}
		t2["1RatthewGreeting2"] = v224
	end

	v224[#v224 + 1] = "I hear things... I see things..."

	local v225 = t2["1RatthewGreeting3"]

	if not v225 then
		v225 = {}
		t2["1RatthewGreeting3"] = v225
	end

	v225[#v225 + 1] = "It\'s a dangerous job..."

	local v226 = t2["2RatthewGreeting"]

	if not v226 then
		v226 = {}
		t2["2RatthewGreeting"] = v226
	end

	v226[#v226 + 1] = "You are a good guy..."

	local v228 = t3[1]
	local v229, v230, v231 = ("rgb(255, 100, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	local v238 = "My name is " .. (if v229 and (v230 and v231) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v229) * 0.3), math.floor(tonumber(v230) * 0.4), (math.floor(tonumber(v231) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(255, 100, 255)" .. "\'>" .. v228 .. "</font></stroke>" else v1 .. "rgb(255, 100, 255)" .. "\'>" .. v228 .. "</font></stroke>")
	local v239 = t2["2RatthewGreeting2"]

	if not v239 then
		v239 = {}
		t2["2RatthewGreeting2"] = v239
	end

	v239[#v239 + 1] = v238

	local v240 = t2["2RatthewGreeting3"]

	if not v240 then
		v240 = {}
		t2["2RatthewGreeting3"] = v240
	end

	v240[#v240 + 1] = "My advice... Don\'t trust anyone here..."

	local v241 = t2["3RatthewGreeting"]

	if not v241 then
		v241 = {}
		t2["3RatthewGreeting"] = v241
	end

	v241[#v241 + 1] = "The people with suitcases are hiding secrets..."

	local v242 = t2["3RatthewGreeting2"]

	if not v242 then
		v242 = {}
		t2["3RatthewGreeting2"] = v242
	end

	v242[#v242 + 1] = "Something evil is going on here."

	local v243 = t2["3RatthewGreeting3"]

	if not v243 then
		v243 = {}
		t2["3RatthewGreeting3"] = v243
	end

	v243[#v243 + 1] = "Stay alert..."

	local v244 = t2["4RatthewGreeting"]

	if not v244 then
		v244 = {}
		t2["4RatthewGreeting"] = v244
	end

	v244[#v244 + 1] = "You know, I\'m starting to like you."

	local v245 = t2["4RatthewGreeting2"]

	if not v245 then
		v245 = {}
		t2["4RatthewGreeting2"] = v245
	end

	v245[#v245 + 1] = "People on the street think I\'m some kind of anomaly :("

	local v246 = t2["4RatthewGreeting3"]

	if not v246 then
		v246 = {}
		t2["4RatthewGreeting3"] = v246
	end

	v246[#v246 + 1] = "But you treat me just like anyone else. I appreciate that..."

	local v247 = t2["5RatthewGreeting"]

	if not v247 then
		v247 = {}
		t2["5RatthewGreeting"] = v247
	end

	v247[#v247 + 1] = "I may need to disappear for a while..."

	local v248 = t2["5RatthewGreeting2"]

	if not v248 then
		v248 = {}
		t2["5RatthewGreeting2"] = v248
	end

	v248[#v248 + 1] = "The Animal Corporation is after me..."

	local v249 = t2["5RatthewGreeting3"]

	if not v249 then
		v249 = {}
		t2["5RatthewGreeting3"] = v249
	end

	v249[#v249 + 1] = "But first I want to chat with you..."

	local RatthewStory = t2.RatthewStory

	if not RatthewStory then
		RatthewStory = {}
		t2.RatthewStory = RatthewStory
	end

	RatthewStory[#RatthewStory + 1] = "..."

	local RatthewStory2 = t2.RatthewStory2

	if not RatthewStory2 then
		RatthewStory2 = {}
		t2.RatthewStory2 = RatthewStory2
	end

	RatthewStory2[#RatthewStory2 + 1] = "Slow night, huh? Just how I like \'em."

	local RatthewStory3 = t2.RatthewStory3

	if not RatthewStory3 then
		RatthewStory3 = {}
		t2.RatthewStory3 = RatthewStory3
	end

	RatthewStory3[#RatthewStory3 + 1] = "You\'re not bad company, you know that?"

	local RatthewStory4 = t2.RatthewStory4

	if not RatthewStory4 then
		RatthewStory4 = {}
		t2.RatthewStory4 = RatthewStory4
	end

	RatthewStory4[#RatthewStory4 + 1] = "Most folks don\'t even look down here."

	local RatthewStory5 = t2.RatthewStory5

	if not RatthewStory5 then
		RatthewStory5 = {}
		t2.RatthewStory5 = RatthewStory5
	end

	RatthewStory5[#RatthewStory5 + 1] = "Funny thing about being a rat..."

	local RatthewStory6 = t2.RatthewStory6

	if not RatthewStory6 then
		RatthewStory6 = {}
		t2.RatthewStory6 = RatthewStory6
	end

	RatthewStory6[#RatthewStory6 + 1] = "Everyone screams. Nobody offers cheese."

	local RatthewStory7 = t2.RatthewStory7

	if not RatthewStory7 then
		RatthewStory7 = {}
		t2.RatthewStory7 = RatthewStory7
	end

	RatthewStory7[#RatthewStory7 + 1] = "Ha... old joke. Still gets me though."

	local RatthewStory8 = t2.RatthewStory8

	if not RatthewStory8 then
		RatthewStory8 = {}
		t2.RatthewStory8 = RatthewStory8
	end

	RatthewStory8[#RatthewStory8 + 1] = "...Anyway. I wanted to tell you something."

	local RatthewStory9 = t2.RatthewStory9

	if not RatthewStory9 then
		RatthewStory9 = {}
		t2.RatthewStory9 = RatthewStory9
	end

	RatthewStory9[#RatthewStory9 + 1] = "I had a twin sister. Rattina..."

	local RatthewStory10 = t2.RatthewStory10

	if not RatthewStory10 then
		RatthewStory10 = {}
		t2.RatthewStory10 = RatthewStory10
	end

	RatthewStory10[#RatthewStory10 + 1] = "Smart one in the family, that\'s for sure."

	local RatthewStory11 = t2.RatthewStory11

	if not RatthewStory11 then
		RatthewStory11 = {}
		t2.RatthewStory11 = RatthewStory11
	end

	RatthewStory11[#RatthewStory11 + 1] = "She worked for the Animal Corporation."

	local RatthewStory12 = t2.RatthewStory12

	if not RatthewStory12 then
		RatthewStory12 = {}
		t2.RatthewStory12 = RatthewStory12
	end

	RatthewStory12[#RatthewStory12 + 1] = "Then one day... she just vanished."

	local RatthewStory13 = t2.RatthewStory13

	if not RatthewStory13 then
		RatthewStory13 = {}
		t2.RatthewStory13 = RatthewStory13
	end

	RatthewStory13[#RatthewStory13 + 1] = "No note. No goodbye. Nothing."

	local RatthewStory14 = t2.RatthewStory14

	if not RatthewStory14 then
		RatthewStory14 = {}
		t2.RatthewStory14 = RatthewStory14
	end

	RatthewStory14[#RatthewStory14 + 1] = "I\'ve been looking for her ever since..."

	local RatthewStory15 = t2.RatthewStory15

	if not RatthewStory15 then
		RatthewStory15 = {}
		t2.RatthewStory15 = RatthewStory15
	end

	RatthewStory15[#RatthewStory15 + 1] = "...Sorry. Didn\'t mean to get heavy."

	local RatthewStory16 = t2.RatthewStory16

	if not RatthewStory16 then
		RatthewStory16 = {}
		t2.RatthewStory16 = RatthewStory16
	end

	RatthewStory16[#RatthewStory16 + 1] = "You know what I do like?"

	local RatthewStory17 = t2.RatthewStory17

	if not RatthewStory17 then
		RatthewStory17 = {}
		t2.RatthewStory17 = RatthewStory17
	end

	RatthewStory17[#RatthewStory17 + 1] = "The quiet hours. Just me and the vents."

	local RatthewStory18 = t2.RatthewStory18

	if not RatthewStory18 then
		RatthewStory18 = {}
		t2.RatthewStory18 = RatthewStory18
	end

	RatthewStory18[#RatthewStory18 + 1] = "Whole place to myself. It\'s peaceful."

	local RatthewStory19 = t2.RatthewStory19

	if not RatthewStory19 then
		RatthewStory19 = {}
		t2.RatthewStory19 = RatthewStory19
	end

	RatthewStory19[#RatthewStory19 + 1] = "...Thanks for listening. Means a lot."

	local RatthewStory20 = t2.RatthewStory20

	if not RatthewStory20 then
		RatthewStory20 = {}
		t2.RatthewStory20 = RatthewStory20
	end

	RatthewStory20[#RatthewStory20 + 1] = "This is our goodbye... for now."

	local v251, v252, v253 = ("rgb(150, 150, 150)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")

	v260 = "Name\'s " .. (if v251 and (v252 and v253) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v251) * 0.3), math.floor(tonumber(v252) * 0.4), (math.floor(tonumber(v253) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(150, 150, 150)\'>Ron</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(150, 150, 150)\'>Ron</font></stroke>") .. "... from accounting."
end

local v261 = t2["1RonGreeting"]

if not v261 then
	v261 = {}
	t2["1RonGreeting"] = v261
end

v261[#v261 + 1] = v260

local v262 = t2["1RonGreeting2"]

if not v262 then
	v262 = {}
	t2["1RonGreeting2"] = v262
end

v262[#v262 + 1] = "You ever wonder why they keep hiring new people?"

local v263 = t2["1RonGreeting3"]

if not v263 then
	v263 = {}
	t2["1RonGreeting3"] = v263
end

v263[#v263 + 1] = "...Never mind."

local v264 = t2["2RonGreeting"]

if not v264 then
	v264 = {}
	t2["2RonGreeting"] = v264
end

v264[#v264 + 1] = "Still here? Huh."

local v265 = t2["2RonGreeting2"]

if not v265 then
	v265 = {}
	t2["2RonGreeting2"] = v265
end

v265[#v265 + 1] = "The last guy got eaten by the bed monster."

local v266 = t2["2RonGreeting3"]

if not v266 then
	v266 = {}
	t2["2RonGreeting3"] = v266
end

v266[#v266 + 1] = "That\'s why I always carry maple syrup with me."

local v267 = t2["3RonGreeting"]

if not v267 then
	v267 = {}
	t2["3RonGreeting"] = v267
end

v267[#v267 + 1] = "You want to know a secret?"

local v269, v270, v271 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v278 = "They\'re " .. (if v269 and (v270 and v271) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v269) * 0.3), math.floor(tonumber(v270) * 0.4), (math.floor(tonumber(v271) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>testing</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>testing</font></stroke>") .. " something here."
local v279 = t2["3RonGreeting2"]

if not v279 then
	v279 = {}
	t2["3RonGreeting2"] = v279
end

v279[#v279 + 1] = v278

local v281, v282, v283 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v290 = "The patients... they\'re not sick. They\'re " .. (if v281 and (v282 and v283) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v281) * 0.3), math.floor(tonumber(v282) * 0.4), (math.floor(tonumber(v283) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>infected</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>infected</font></stroke>") .. "."
local v291 = t2["3RonGreeting3"]

if not v291 then
	v291 = {}
	t2["3RonGreeting3"] = v291
end

v291[#v291 + 1] = v290

local v292 = t2["4RonGreeting"]

if not v292 then
	v292 = {}
	t2["4RonGreeting"] = v292
end

v292[#v292 + 1] = "I work for the Corporation, I process the paperwork every night..."

local v293 = t2["4RonGreeting2"]

if not v293 then
	v293 = {}
	t2["4RonGreeting2"] = v293
end

v293[#v293 + 1] = "Some people go mad over it. You know.. hollowed eyes and stuff..."

local v294 = t2["4RonGreeting3"]

if not v294 then
	v294 = {}
	t2["4RonGreeting3"] = v294
end

v294[#v294 + 1] = "It\'s grueling work. That\'s why coffee is important."

local v295 = t2["5RonGreeting"]

if not v295 then
	v295 = {}
	t2["5RonGreeting"] = v295
end

v295[#v295 + 1] = "Ever read the hospital discharge logs?"

local v296 = t2["5RonGreeting2"]

if not v296 then
	v296 = {}
	t2["5RonGreeting2"] = v296
end

v296[#v296 + 1] = "The Corporation owns this place but they hide the logs."

local v297 = t2["5RonGreeting3"]

if not v297 then
	v297 = {}
	t2["5RonGreeting3"] = v297
end

v297[#v297 + 1] = "Pretty sketchy..."

local v298 = t2["6RonGreeting"]

if not v298 then
	v298 = {}
	t2["6RonGreeting"] = v298
end

v298[#v298 + 1] = "They moved the old files last month."

local v300, v301, v302 = ("rgb(150, 150, 150)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v309 = "Said it was a " .. (if v300 and (v301 and v302) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v300) * 0.3), math.floor(tonumber(v301) * 0.4), (math.floor(tonumber(v302) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(150, 150, 150)\'>routine cleanup</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(150, 150, 150)\'>routine cleanup</font></stroke>") .. "."
local v310 = t2["6RonGreeting2"]

if not v310 then
	v310 = {}
	t2["6RonGreeting2"] = v310
end

v310[#v310 + 1] = v309

local v311 = t2["6RonGreeting3"]

if not v311 then
	v311 = {}
	t2["6RonGreeting3"] = v311
end

v311[#v311 + 1] = "Lot of smoke for a routine cleanup."

local v312 = t2["7RonGreeting"]

if not v312 then
	v312 = {}
	t2["7RonGreeting"] = v312
end

v312[#v312 + 1] = "I once saw eyes staring at me from the ceiling..."

local v313 = t2["7RonGreeting2"]

if not v313 then
	v313 = {}
	t2["7RonGreeting2"] = v313
end

v313[#v313 + 1] = "The doctor at the time panicked looking for eye drops."

local v314 = t2["7RonGreeting3"]

if not v314 then
	v314 = {}
	t2["7RonGreeting3"] = v314
end

v314[#v314 + 1] = "Then *POOF*, he was gone."

local v315 = t2["8RonGreeting"]

if not v315 then
	v315 = {}
	t2["8RonGreeting"] = v315
end

v315[#v315 + 1] = "You ever feel someone watching you from the corner of your eyes?"

local v316 = t2["8RonGreeting2"]

if not v316 then
	v316 = {}
	t2["8RonGreeting2"] = v316
end

v316[#v316 + 1] = "Yeah...I used to work with that guy."

local v317 = t2["8RonGreeting3"]

if not v317 then
	v317 = {}
	t2["8RonGreeting3"] = v317
end

v317[#v317 + 1] = "Just make sure not to stare at him. He is shy"

local v318 = t2["9RonGreeting"]

if not v318 then
	v318 = {}
	t2["9RonGreeting"] = v318
end

v318[#v318 + 1] = "That rat was in my office once..."

local v319 = t2["9RonGreeting2"]

if not v319 then
	v319 = {}
	t2["9RonGreeting2"] = v319
end

v319[#v319 + 1] = "Chewed through some experiment reports I wasn\'t supposed to see."

local v320 = t2["9RonGreeting3"]

if not v320 then
	v320 = {}
	t2["9RonGreeting3"] = v320
end

v320[#v320 + 1] = "Did me a favor, honestly."

local v321 = t2["10RonGreeting"]

if not v321 then
	v321 = {}
	t2["10RonGreeting"] = v321
end

v321[#v321 + 1] = "We\'ve been working so hard, we can\'t rest."

local v323, v324, v325 = ("rgb(255, 100, 100)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v332 = "The " .. (if v323 and (v324 and v325) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v323) * 0.3), math.floor(tonumber(v324) * 0.4), (math.floor(tonumber(v325) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>BOSS</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 100, 100)\'>BOSS</font></stroke>") .. " is furious... why did I accept this job?"
local v333 = t2["10RonGreeting2"]

if not v333 then
	v333 = {}
	t2["10RonGreeting2"] = v333
end

v333[#v333 + 1] = v332

local v334 = t2["10RonGreeting3"]

if not v334 then
	v334 = {}
	t2["10RonGreeting3"] = v334
end

v334[#v334 + 1] = "I need to get treated before the meeting with him."

local v336 = t3[1]
local v337, v338, v339 = ("rgb(255, 255, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v346 = "Hey there, friend, I\'m " .. (if v337 and (v338 and v339) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v337) * 0.3), math.floor(tonumber(v338) * 0.4), (math.floor(tonumber(v339) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(255, 255, 0)" .. "\'>" .. v336 .. "</font></stroke>" else v1 .. "rgb(255, 255, 0)" .. "\'>" .. v336 .. "</font></stroke>")
local CoffeeDay1Arrival = t2.CoffeeDay1Arrival

if not CoffeeDay1Arrival then
	CoffeeDay1Arrival = {}
	t2.CoffeeDay1Arrival = CoffeeDay1Arrival
end

CoffeeDay1Arrival[#CoffeeDay1Arrival + 1] = v346

local v348, v349, v350 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v357 = "Can you give me a " .. (if v348 and (v349 and v350) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v348) * 0.3), math.floor(tonumber(v349) * 0.4), (math.floor(tonumber(v350) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>coffee</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>coffee</font></stroke>") .. "? I had a long day..."
local CoffeeDay1Arrival2 = t2.CoffeeDay1Arrival2

if not CoffeeDay1Arrival2 then
	CoffeeDay1Arrival2 = {}
	t2.CoffeeDay1Arrival2 = CoffeeDay1Arrival2
end

CoffeeDay1Arrival2[#CoffeeDay1Arrival2 + 1] = v357

local CoffeeDay1Thanks = t2.CoffeeDay1Thanks

if not CoffeeDay1Thanks then
	CoffeeDay1Thanks = {}
	t2.CoffeeDay1Thanks = CoffeeDay1Thanks
end

CoffeeDay1Thanks[#CoffeeDay1Thanks + 1] = "Thanks friend, I needed that... I will remember this."

local CoffeeDay2Arrival = t2.CoffeeDay2Arrival

if not CoffeeDay2Arrival then
	CoffeeDay2Arrival = {}
	t2.CoffeeDay2Arrival = CoffeeDay2Arrival
end

CoffeeDay2Arrival[#CoffeeDay2Arrival + 1] = "Hello friend! Can I get another coffee?"

local CoffeeDay2Thanks = t2.CoffeeDay2Thanks

if not CoffeeDay2Thanks then
	CoffeeDay2Thanks = {}
	t2.CoffeeDay2Thanks = CoffeeDay2Thanks
end

CoffeeDay2Thanks[#CoffeeDay2Thanks + 1] = "Delicious..."

local OfferSuitcase = t2.OfferSuitcase

if not OfferSuitcase then
	OfferSuitcase = {}
	t2.OfferSuitcase = OfferSuitcase
end

OfferSuitcase[#OfferSuitcase + 1] = "May I ask for a favor, friend?"

local v359, v360, v361 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v368 = "Can you keep this " .. (if v359 and (v360 and v361) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v359) * 0.3), math.floor(tonumber(v360) * 0.4), (math.floor(tonumber(v361) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>suitcase</font></stroke>" else v0) .. " safe for a while?"
local OfferSuitcase2 = t2.OfferSuitcase2

if not OfferSuitcase2 then
	OfferSuitcase2 = {}
	t2.OfferSuitcase2 = OfferSuitcase2
end

OfferSuitcase2[#OfferSuitcase2 + 1] = v368

local CoffeeDay2Thanks2 = t2.CoffeeDay2Thanks2

if not CoffeeDay2Thanks2 then
	CoffeeDay2Thanks2 = {}
	t2.CoffeeDay2Thanks2 = CoffeeDay2Thanks2
end

CoffeeDay2Thanks2[#CoffeeDay2Thanks2 + 1] = "You are the best..."

local CoffeeDay3Arrival = t2.CoffeeDay3Arrival

if not CoffeeDay3Arrival then
	CoffeeDay3Arrival = {}
	t2.CoffeeDay3Arrival = CoffeeDay3Arrival
end

CoffeeDay3Arrival[#CoffeeDay3Arrival + 1] = t3[2] .. ", my friend! I would love a coffee right now..."

local CoffeeDay3Photo = t2.CoffeeDay3Photo

if not CoffeeDay3Photo then
	CoffeeDay3Photo = {}
	t2.CoffeeDay3Photo = CoffeeDay3Photo
end

CoffeeDay3Photo[#CoffeeDay3Photo + 1] = "You know friend...I need to ask you a favor..."

local v371, v372, v373 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v380 = "Could you use that " .. (if v371 and (v372 and v373) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v371) * 0.3), math.floor(tonumber(v372) * 0.4), (math.floor(tonumber(v373) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>camera</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>camera</font></stroke>") .. " to take a picture of me?"
local CoffeeDay3Photo2 = t2.CoffeeDay3Photo2

if not CoffeeDay3Photo2 then
	CoffeeDay3Photo2 = {}
	t2.CoffeeDay3Photo2 = CoffeeDay3Photo2
end

CoffeeDay3Photo2[#CoffeeDay3Photo2 + 1] = v380

local CoffeeDay3Thanks = t2.CoffeeDay3Thanks

if not CoffeeDay3Thanks then
	CoffeeDay3Thanks = {}
	t2.CoffeeDay3Thanks = CoffeeDay3Thanks
end

CoffeeDay3Thanks[#CoffeeDay3Thanks + 1] = "You truly are a friend, thanks for the photo..."

local CoffeeDay4Arrival = t2.CoffeeDay4Arrival

if not CoffeeDay4Arrival then
	CoffeeDay4Arrival = {}
	t2.CoffeeDay4Arrival = CoffeeDay4Arrival
end

CoffeeDay4Arrival[#CoffeeDay4Arrival + 1] = "Hello! Can I get a coffee, friend?"

local CoffeeDay4Tool = t2.CoffeeDay4Tool

if not CoffeeDay4Tool then
	CoffeeDay4Tool = {}
	t2.CoffeeDay4Tool = CoffeeDay4Tool
end

CoffeeDay4Tool[#CoffeeDay4Tool + 1] = "I have been thinking, and I want to ask you for a favor..."

local v382, v383, v384 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v391 = "Can I bother you with a " .. (if v382 and (v383 and v384) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v382) * 0.3), math.floor(tonumber(v383) * 0.4), (math.floor(tonumber(v384) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>Scalpel</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>Scalpel</font></stroke>") .. "?"
local CoffeeDay4Tool2 = t2.CoffeeDay4Tool2

if not CoffeeDay4Tool2 then
	CoffeeDay4Tool2 = {}
	t2.CoffeeDay4Tool2 = CoffeeDay4Tool2
end

CoffeeDay4Tool2[#CoffeeDay4Tool2 + 1] = v391

local CoffeeDay4Thanks = t2.CoffeeDay4Thanks

if not CoffeeDay4Thanks then
	CoffeeDay4Thanks = {}
	t2.CoffeeDay4Thanks = CoffeeDay4Thanks
end

CoffeeDay4Thanks[#CoffeeDay4Thanks + 1] = "This will help a lot, thanks friend!"

local v393, v394, v395 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v402 = "Oh! I\'m taking my " .. (if v393 and (v394 and v395) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v393) * 0.3), math.floor(tonumber(v394) * 0.4), (math.floor(tonumber(v395) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>suitcase</font></stroke>" else v0) .. " with me, bye friend!"
local CoffeeDay4Thanks2 = t2.CoffeeDay4Thanks2

if not CoffeeDay4Thanks2 then
	CoffeeDay4Thanks2 = {}
	t2.CoffeeDay4Thanks2 = CoffeeDay4Thanks2
end

CoffeeDay4Thanks2[#CoffeeDay4Thanks2 + 1] = v402

local v404, v405, v406 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v413 = "My dearest friend, " .. (if v404 and (v405 and v406) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v404) * 0.3), math.floor(tonumber(v405) * 0.4), (math.floor(tonumber(v406) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>something came up</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(100, 255, 255)\'>something came up</font></stroke>") .. "..."
local CoffeeDay5Arrival = t2.CoffeeDay5Arrival

if not CoffeeDay5Arrival then
	CoffeeDay5Arrival = {}
	t2.CoffeeDay5Arrival = CoffeeDay5Arrival
end

CoffeeDay5Arrival[#CoffeeDay5Arrival + 1] = v413

local v415, v416, v417 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v424 = "I need you to let me " .. (if v415 and (v416 and v417) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v415) * 0.3), math.floor(tonumber(v416) * 0.4), (math.floor(tonumber(v417) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>hide with you</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>hide with you</font></stroke>") .. " for a bit"
local CoffeeDay5Arrival2 = t2.CoffeeDay5Arrival2

if not CoffeeDay5Arrival2 then
	CoffeeDay5Arrival2 = {}
	t2.CoffeeDay5Arrival2 = CoffeeDay5Arrival2
end

CoffeeDay5Arrival2[#CoffeeDay5Arrival2 + 1] = v424

local v426 = t3[1]
local v427, v428, v429 = ("rgb(100, 255, 255)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v436 = "Hello, I\'m " .. (if v427 and (v428 and v429) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v427) * 0.3), math.floor(tonumber(v428) * 0.4), (math.floor(tonumber(v429) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'" .. "rgb(100, 255, 255)" .. "\'>" .. v426 .. "</font></stroke>" else v1 .. "rgb(100, 255, 255)" .. "\'>" .. v426 .. "</font></stroke>") .. "..."
local CoffeeDay6Arrival = t2.CoffeeDay6Arrival

if not CoffeeDay6Arrival then
	CoffeeDay6Arrival = {}
	t2.CoffeeDay6Arrival = CoffeeDay6Arrival
end

CoffeeDay6Arrival[#CoffeeDay6Arrival + 1] = v436

local v438, v439, v440 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v447 = "We are currently tracking a dangerous " .. (if v438 and (v439 and v440) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v438) * 0.3), math.floor(tonumber(v439) * 0.4), (math.floor(tonumber(v440) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>serial killer</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>serial killer</font></stroke>") .. "..."
local CoffeeDay6Info = t2.CoffeeDay6Info

if not CoffeeDay6Info then
	CoffeeDay6Info = {}
	t2.CoffeeDay6Info = CoffeeDay6Info
end

CoffeeDay6Info[#CoffeeDay6Info + 1] = v447

local v449, v450, v451 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v458 = "This is his picture... Have you seen " .. (if v449 and (v450 and v451) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v449) * 0.3), math.floor(tonumber(v450) * 0.4), (math.floor(tonumber(v451) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>him?</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>him?</font></stroke>")
local CoffeeDay6Info2 = t2.CoffeeDay6Info2

if not CoffeeDay6Info2 then
	CoffeeDay6Info2 = {}
	t2.CoffeeDay6Info2 = CoffeeDay6Info2
end

CoffeeDay6Info2[#CoffeeDay6Info2 + 1] = v458

local CoffeeDenied = t2.CoffeeDenied

if not CoffeeDenied then
	CoffeeDenied = {}
	t2.CoffeeDenied = CoffeeDenied
end

CoffeeDenied[#CoffeeDenied + 1] = "Oh...you better watch out, I don\'t like being refused..."

local PoliceDenied = t2.PoliceDenied

if not PoliceDenied then
	PoliceDenied = {}
	t2.PoliceDenied = PoliceDenied
end

PoliceDenied[#PoliceDenied + 1] = "Alright, if you see anything suspicious, let me know..."

local v460, v461, v462 = ("rgb(255, 0, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v469 = "THAT\'S THE " .. (if v460 and (v461 and v462) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v460) * 0.3), math.floor(tonumber(v461) * 0.4), (math.floor(tonumber(v462) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>SERIAL KILLER</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 0, 0)\'>SERIAL KILLER</font></stroke>") .. "!!! ARREST HIM!!"
local PoliceGetsCriminal = t2.PoliceGetsCriminal

if not PoliceGetsCriminal then
	PoliceGetsCriminal = {}
	t2.PoliceGetsCriminal = PoliceGetsCriminal
end

PoliceGetsCriminal[#PoliceGetsCriminal + 1] = v469

local BunnyThanksForHiding = t2.BunnyThanksForHiding

if not BunnyThanksForHiding then
	BunnyThanksForHiding = {}
	t2.BunnyThanksForHiding = BunnyThanksForHiding
end

BunnyThanksForHiding[#BunnyThanksForHiding + 1] = "Thank you so much for hiding me, friend..."

local v471, v472, v473 = ("rgb(255, 255, 0)"):match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
local v480 = "Take this " .. (if v471 and (v472 and v473) then "<stroke color=\'" .. string.format("rgb(%d, %d, %d)", math.floor(tonumber(v471) * 0.3), math.floor(tonumber(v472) * 0.4), (math.floor(tonumber(v473) * 0.4))) .. "\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>suitcase</font></stroke>" else "<stroke color=\'rgb(0, 0, 0)\' thickness=\'1\' joins=\'miter\'><font color=\'rgb(255, 255, 0)\'>suitcase</font></stroke>") .. " as a token of my gratitude..."
local BunnyThanksForHiding2 = t2.BunnyThanksForHiding2

if not BunnyThanksForHiding2 then
	BunnyThanksForHiding2 = {}
	t2.BunnyThanksForHiding2 = BunnyThanksForHiding2
end

BunnyThanksForHiding2[#BunnyThanksForHiding2 + 1] = v480

local BunnyLeavesForever = t2.BunnyLeavesForever

if not BunnyLeavesForever then
	BunnyLeavesForever = {}
	t2.BunnyLeavesForever = BunnyLeavesForever
end

BunnyLeavesForever[#BunnyLeavesForever + 1] = "I think it\'s best if I leave this place for good... Goodbye, friend..."

return t