-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: easing, time of decompilation: Sun May  3 10:10:45 2026 ]]
return {
	linear = function(n1: number) --[[ linear ]] -- line: 46
		return n1
	end,
	instant = function(n2: number) --[[ instant ]] -- line: 50
		if n2 == 0 then
			return 0
		end

		return 1
	end,
	smoothstep = function(n3: number) --[[ smoothstep ]] -- line: 54
		return n3 * n3 * (3 - n3 * 2)
	end,
	quadIn = function(n4: number) --[[ quadIn ]] -- line: 58
		return n4 * n4
	end,
	quadOut = function(n5: number) --[[ quadOut ]] -- line: 62
		return 1 - (1 - n5) * (1 - n5)
	end,
	quadInOut = function(n6: number) --[[ quadInOut ]] -- line: 66
		if n6 < 0.5 then
			return n6 * 2 * n6
		end

		return 1 - (n6 * -2 + 2) ^ 2 / 2
	end,
	cubicIn = function(n7: number) --[[ cubicIn ]] -- line: 70
		return n7 * n7 * n7
	end,
	cubicOut = function(n8: number) --[[ cubicOut ]] -- line: 74
		return 1 - (1 - n8) ^ 3
	end,
	cubicInOut = function(n9: number) --[[ cubicInOut ]] -- line: 78
		if n9 < 0.5 then
			return n9 * 4 * n9 * n9
		end

		return 1 - (n9 * -2 + 2) ^ 3 / 2
	end,
	quartIn = function(n10: number) --[[ quartIn ]] -- line: 82
		return n10 * n10 * n10 * n10
	end,
	quartOut = function(n11: number) --[[ quartOut ]] -- line: 86
		return 1 - (1 - n11) ^ 4
	end,
	quartInOut = function(n12: number) --[[ quartInOut ]] -- line: 90
		if n12 < 0.5 then
			return n12 * 8 * n12 * n12 * n12
		end

		return 1 - (n12 * -2 + 2) ^ 4 / 2
	end,
	quintIn = function(n13: number) --[[ quintIn ]] -- line: 94
		return n13 * n13 * n13 * n13 * n13
	end,
	quintOut = function(n14: number) --[[ quintOut ]] -- line: 98
		return 1 - (1 - n14) ^ 5
	end,
	quintInOut = function(n15: number) --[[ quintInOut ]] -- line: 102
		if n15 < 0.5 then
			return n15 * 16 * n15 * n15 * n15 * n15
		end

		return 1 - (n15 * -2 + 2) ^ 5 / 2
	end,
	sineIn = function(n16: number) --[[ sineIn ]] -- line: 106
		return 1 - math.cos(n16 * 3.141592653589793 / 2)
	end,
	sineOut = function(n17: number) --[[ sineOut ]] -- line: 110
		return (math.sin(n17 * 3.141592653589793 / 2))
	end,
	sineInOut = function(n18: number) --[[ sineInOut ]] -- line: 114
		return -(math.cos(3.141592653589793 * n18) - 1) / 2
	end,
	expoIn = function(n19: number) --[[ expoIn ]] -- line: 118
		if n19 == 0 then
			return 0
		end

		return 2 ^ (n19 * 10 - 10)
	end,
	expoOut = function(n20: number) --[[ expoOut ]] -- line: 122
		if n20 == 1 then
			return 1
		end

		return 1 - 2 ^ (n20 * -10)
	end,
	expoInOut = function(n21: number) --[[ expoInOut ]] -- line: 126
		if n21 == 0 then
			return 0
		end

		if n21 == 1 then
			return 1
		end

		if n21 < 0.5 then
			return 2 ^ (n21 * 20 - 10) / 2
		end

		return (2 - 2 ^ (n21 * -20 + 10)) / 2
	end,
	circIn = function(n22: number) --[[ circIn ]] -- line: 134
		return 1 - (1 - n22 ^ 2) ^ 0.5
	end,
	circOut = function(n23: number) --[[ circOut ]] -- line: 138
		return (1 - (n23 - 1) ^ 2) ^ 0.5
	end,
	circInOut = function(n24: number) --[[ circInOut ]] -- line: 142
		if n24 < 0.5 then
			return (1 - (1 - (n24 * 2) ^ 2) ^ 0.5) / 2
		end

		return ((1 - (n24 * -2 + 2) ^ 2) ^ 0.5 + 1) / 2
	end,
	backIn = function(n25: number) --[[ backIn ]] -- line: 146
		return n25 * 2.70158 * n25 * n25 - n25 * 1.70158 * n25
	end,
	backOut = function(n26: number) --[[ backOut ]] -- line: 150
		return (n26 - 1) ^ 3 * 2.70158 + 1 + (n26 - 1) ^ 2 * 1.70158
	end,
	backInOut = function(n27: number) --[[ backInOut ]] -- line: 154
		if n27 < 0.5 then
			return (n27 * 2) ^ 2 * (n27 * 7.189819 - 2.5949095) / 2
		end

		return ((n27 * 2 - 2) ^ 2 * ((n27 * 2 - 2) * 3.5949095 + 2.5949095) + 2) / 2
	end,
	elasticIn = function(n28: number) --[[ elasticIn ]] -- line: 160
		if n28 == 0 then
			return 0
		end

		if n28 == 1 then
			return 1
		end

		return -2 ^ (n28 * 10 - 10) * math.sin((n28 * 10 - 10.75) * 2.0943951023931953)
	end,
	elasticOut = function(n29: number) --[[ elasticOut ]] -- line: 164
		if n29 == 0 then
			return 0
		end

		if n29 == 1 then
			return 1
		end

		return 2 ^ (n29 * -10) * math.sin((n29 * 10 - 0.75) * 2.0943951023931953) + 1
	end,
	elasticInOut = function(n30: number) --[[ elasticInOut ]] -- line: 168
		if n30 == 0 then
			return 0
		end

		if n30 == 1 then
			return 1
		end

		if n30 < 0.5 then
			return -(2 ^ (n30 * 20 - 10) * math.sin((n30 * 20 - 11.125) * 1.3962634015954636)) / 2
		end

		return 2 ^ (n30 * -20 + 10) * math.sin((n30 * 20 - 11.125) * 1.3962634015954636) / 2 + 1
	end,
	bounceIn = function(n31: number) --[[ bounceIn ]] -- line: 194
		local v36 = 1 - n31
		local v37

		if v36 < 0.36363636363636365 then
			v37 = v36 * 7.5625 * v36
		elseif v36 < 0.7272727272727273 then
			local v38 = v36 - 0.5454545454545454

			v37 = v38 * 7.5625 * v38 + 0.75
		elseif v36 < 0.9090909090909091 then
			local v39 = v36 - 0.8181818181818182

			v37 = v39 * 7.5625 * v39 + 0.9375
		else
			local v40 = v36 - 0.9545454545454546

			v37 = v40 * 7.5625 * v40 + 0.984375
		end

		return 1 - v37
	end,
	bounceOut = function(n32: number) --[[ bounceOut ]] -- line: 176
		if n32 < 0.36363636363636365 then
			return n32 * 7.5625 * n32
		end

		if n32 < 0.7272727272727273 then
			local v32 = n32 - 0.5454545454545454

			return v32 * 7.5625 * v32 + 0.75
		end

		if n32 < 0.9090909090909091 then
			local v33 = n32 - 0.8181818181818182

			return v33 * 7.5625 * v33 + 0.9375
		end

		local v34 = n32 - 0.9545454545454546

		return v34 * 7.5625 * v34 + 0.984375
	end,
	bounceInOut = function(n33: number) --[[ bounceInOut ]] -- line: 198
		if n33 < 0.5 then
			local v42 = 1 - n33 * 2
			local v43

			if v42 < 0.36363636363636365 then
				v43 = v42 * 7.5625 * v42
			elseif v42 < 0.7272727272727273 then
				local v44 = v42 - 0.5454545454545454

				v43 = v44 * 7.5625 * v44 + 0.75
			elseif v42 < 0.9090909090909091 then
				local v45 = v42 - 0.8181818181818182

				v43 = v45 * 7.5625 * v45 + 0.9375
			else
				local v46 = v42 - 0.9545454545454546

				v43 = v46 * 7.5625 * v46 + 0.984375
			end

			return (1 - v43) / 2
		end

		local v47 = n33 * 2 - 1
		local v48

		if v47 < 0.36363636363636365 then
			v48 = v47 * 7.5625 * v47
		elseif v47 < 0.7272727272727273 then
			local v49 = v47 - 0.5454545454545454

			v48 = v49 * 7.5625 * v49 + 0.75
		elseif v47 < 0.9090909090909091 then
			local v50 = v47 - 0.8181818181818182

			v48 = v50 * 7.5625 * v50 + 0.9375
		else
			local v51 = v47 - 0.9545454545454546

			v48 = v51 * 7.5625 * v51 + 0.984375
		end

		return (v48 + 1) / 2
	end
}
