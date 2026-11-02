--[[ Magnus Night V3 decompiler (early alpha)
	output: \4\1\12\6\80\97\114\101\110\116\3\104\105\116\8\80\111\115\105\116\105\111\110\6\77\111\118\101\84\111\4\84\101\108\101\6\115\99\114\105\112\116\4\103\97\109\101\7\80\108\97\121\101\114\115\11\76\111\99\97\108\80\108\97\121\101\114\8\71\101\116\77\111\117\115\101\9\65\99\116\105\118\97\116\101\100\7\67\111\110\110\101\99\116\2\5\0\2\0\0\0\12\251\1\0\0\77\0\1\36\0\0\0\0\251\4\1\0\77\3\4\219\1\0\0\0\77\2\3\59\2\0\0\0\188\0\0\119\3\0\0\0\159\0\3\1\130\0\1\0\4\3\1\3\2\3\3\3\4\0\5\5\1\24\0\0\0\0\0\0\0\0\0\0\0\1\6\0\0\0\0\7\0\0\1\2\0\24\163\0\0\0\164\1\1\0\0\0\0\64\77\0\1\36\2\0\0\0\164\3\4\0\0\0\48\64\77\2\3\80\5\0\0\0\77\1\2\49\6\0\0\0\188\2\1\35\7\0\0\0\159\2\2\2\192\3\8\0\18\0\0\0\18\0\2\0\77\4\0\30\9\0\0\0\82\6\3\0\188\4\4\199\10\0\0\0\159\4\3\1\130\0\1\0\11\3\6\4\0\0\0\64\3\1\3\7\4\0\0\48\64\3\8\3\9\3\10\6\0\3\11\3\12\1\0\1\0\1\24\0\0\0\0\0\1\0\0\0\0\0\1\0\0\2\0\0\4\0\0\0\0\0\0\1\0\0\0\0\1

0 param(s), 5 slot(s), 2 upvalue(s), 4 constant(s), 0 function(s)
function Tele() -- line 1 through 2
   GETUPVAL  	     1 0 0
   GETTABLEKS	     0 1 36
      AUX    	     0
   GETUPVAL  	     4 1 0
   GETTABLEKS	     3 4 219
      AUX    	     1
   GETTABLEKS	     2 3 59
      AUX    	     2
   NAMECALL  	     0 0 119
      AUX    	     3
   CALL      	     0 3 1
   RETURN    	     0 1 0

   constants (4)
      1          string     "Parent"  
      2          string     "hit"     
      3          string     "Position"
      4          string     "MoveTo"  
end

0+ param(s), 7 slot(s), 0 upvalue(s), 11 constant(s), 1 function(s)
function main(...) -- line 1 through 9
   PREPVARARGS	     0 0 0
   GETIMPORT 	     1 1
      AUX    	 1073741824
   GETTABLEKS	     0 1 36
      AUX    	     2
   GETIMPORT 	     3 4
      AUX    	 1076887552
   GETTABLEKS	     2 3 80
      AUX    	     5
   GETTABLEKS	     1 2 49
      AUX    	     6
   NAMECALL  	     2 1 35
      AUX    	     7
   CALL      	     2 2 2
   DUPCLOSURE	     3 8
   CAPTURE   	     0 0 0
   CAPTURE   	     0 2 0
   GETTABLEKS	     4 0 30
      AUX    	     9
   MOVE      	     6 3 0
   NAMECALL  	     4 4 199
      AUX    	    10
   CALL      	     4 3 1
   RETURN    	     0 1 0

   constants (11)
      1          string     "script"  
      2          import     ["script"]
      3          string     "Parent"  
      4          string     "game"    
      5          import     ["game"]  
      6          string     "Players" 
      7          string     "LocalPlayer"
      8          string     "GetMouse"
      9          closure    0         
      10         string     "Activated"
      11         string     "Connect" 
end

Main Function: 1

-- Unluau v guid: e07f73a5-c424-4e2c-950e-e688aab09238


--]]

local Parent_v0 = script.Parent
local upval1 = game.Players.LocalPlayer:GetMouse()
Parent_v0.Activated:Connect(function()
	Parent_v0.Parent:MoveTo(upval1.Hit.Position)
end)