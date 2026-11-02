local ServerScriptService = script.Parent
local Customers = require(ServerScriptService:WaitForChild("Customers"))
local Global = require(ServerScriptService:WaitForChild("Global"))
local Environment = Global.Environment
local Houses = Global.Houses
local Players = Global.Players
local Paycheck = Global.Paycheck
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))


local os = require(game.ReplicatedStorage.Utilities.GetDate)
local date = os.date("*t")
local yearDay = date.yday
local lighting = game.Lighting
local Trees = (Enums.IsPartyServer and game.ServerStorage.TreesPartyServer:GetChildren()) or workspace.Trees:GetChildren()
local OceanWater = workspace.OceanWater


Environment.Season = (Debug.Enabled and Debug.Season) or
					(yearDay == 1 and "Winter") or -- January 1
					(yearDay == 2 and "Winter") or -- January 2
					(yearDay == 3 and "Winter") or -- January 3
					(yearDay == 4 and "Winter") or -- January 4
					(yearDay == 5 and "Winter") or -- January 5
					(yearDay == 6 and "Winter") or -- January 6
					(yearDay == 7 and "Winter") or -- January 7
					(yearDay == 8 and "Winter") or -- January 8
					(yearDay == 9 and "Winter") or -- January 9
					(yearDay == 10 and "Winter") or -- January 10
					(yearDay == 11 and "Winter") or -- January 11 
					(yearDay == 12 and "Winter") or -- January 12
					(yearDay == 13 and "Winter") or -- January 13
					(yearDay == 14 and "Winter") or -- January 14
					(yearDay == 15 and "Winter") or -- January 15
					(yearDay == 16 and "Winter") or -- January 16
					(yearDay == 17 and "Winter") or -- January 17
					(yearDay == 18 and "Winter") or -- January 18
					(yearDay == 19 and "Winter") or -- January 19
					(yearDay == 20 and "Winter") or -- January 20
					(yearDay == 21 and "Winter") or -- January 21 
					(yearDay == 22 and "Winter") or -- January 22
					(yearDay == 23 and "Winter") or -- January 23
					(yearDay == 24 and "Winter") or -- January 24
					(yearDay == 25 and "Winter") or -- January 25
					(yearDay == 26 and "Winter") or -- January 26 
					(yearDay == 27 and "Winter") or -- January 27
					(yearDay == 28 and "Winter") or -- January 28
					(yearDay == 29 and "Winter") or -- January 29
					(yearDay == 30 and "Winter") or -- January 30
					(yearDay == 31 and "Winter") or -- January 31 
					(yearDay == 32 and "Winter") or -- February 1
					(yearDay == 33 and "Winter") or -- February 2
					(yearDay == 34 and "Winter") or -- February 3
					(yearDay == 35 and "Winter") or -- February 4
					(yearDay == 36 and "Winter") or -- February 5 
					(yearDay == 37 and "Winter") or -- February 6
					(yearDay == 38 and "Winter") or -- February 7
					(yearDay == 39 and "Winter") or -- February 8
					(yearDay == 40 and "Winter") or -- February 9
					(yearDay == 41 and "Winter") or -- February 10 
					(yearDay == 42 and "Winter") or -- February 11
					(yearDay == 43 and "Winter") or -- February 12
					(yearDay == 44 and "Winter") or -- February 13
					(yearDay == 45 and "Winter") or -- February 14
					(yearDay == 46 and "Winter") or -- February 15 
					(yearDay == 47 and "Winter") or -- February 16
					(yearDay == 48 and "Winter") or -- February 17
					(yearDay == 49 and "Winter") or -- February 18
					(yearDay == 50 and "Winter") or -- February 19
					(yearDay == 51 and "Winter") or -- February 20 
					(yearDay == 52 and "Winter") or -- February 21
					(yearDay == 53 and "Winter") or -- February 22
					(yearDay == 54 and "Winter") or -- February 23
					(yearDay == 55 and "Winter") or -- February 24
					(yearDay == 56 and "Winter") or -- February 25 
					(yearDay == 57 and "Winter") or -- February 26
					(yearDay == 58 and "Winter") or -- February 27
					(yearDay == 59 and "Winter") or -- February 28
					(yearDay == 60 and "Spring") or -- March 1
					(yearDay == 61 and "Spring") or -- March 2 
					(yearDay == 62 and "Spring") or -- March 3
					(yearDay == 63 and "Spring") or -- March 4
					(yearDay == 64 and "Spring") or -- March 5
					(yearDay == 65 and "Spring") or -- March 6
					(yearDay == 66 and "Spring") or -- March 7 
					(yearDay == 67 and "Spring") or -- March 8
					(yearDay == 68 and "Spring") or -- March 9
					(yearDay == 69 and "Spring") or -- March 10
					(yearDay == 70 and "Spring") or -- March 11
					(yearDay == 71 and "Spring") or -- March 12 
					(yearDay == 72 and "Spring") or -- March 13
					(yearDay == 73 and "Spring") or -- March 14
					(yearDay == 74 and "Spring") or -- March 15
					(yearDay == 75 and "Spring") or -- March 16
					(yearDay == 76 and "Spring") or -- March 17 
					(yearDay == 77 and "Spring") or -- March 18
					(yearDay == 78 and "Spring") or -- March 19
					(yearDay == 79 and "Spring") or -- March 20
					(yearDay == 80 and "Spring") or -- March 21
					(yearDay == 81 and "Spring") or -- March 22 
					(yearDay == 82 and "Spring") or -- March 23
					(yearDay == 83 and "Spring") or -- March 24
					(yearDay == 84 and "Spring") or -- March 25
					(yearDay == 85 and "Spring") or -- March 26
					(yearDay == 86 and "Spring") or -- March 27 
					(yearDay == 87 and "Spring") or -- March 28
					(yearDay == 88 and "Spring") or -- March 29
					(yearDay == 89 and "Spring") or -- March 30
					(yearDay == 90 and "Spring") or -- March 31
					(yearDay == 91 and "Spring") or -- April 1 
					(yearDay == 92 and "Spring") or -- April 2
					(yearDay == 93 and "Spring") or -- April 3
					(yearDay == 94 and "Spring") or -- April 4
					(yearDay == 95 and "Spring") or -- April 5
					(yearDay == 96 and "Spring") or -- April 6 
					(yearDay == 97 and "Spring") or -- April 7
					(yearDay == 98 and "Spring") or -- April 8
					(yearDay == 99 and "Spring") or -- April 9
					(yearDay == 100 and "Spring") or -- April 10
					(yearDay == 101 and "Spring") or -- April 11 
					(yearDay == 102 and "Spring") or -- April 12
					(yearDay == 103 and "Spring") or -- April 13
					(yearDay == 104 and "Spring") or -- April 14
					(yearDay == 105 and "Spring") or -- April 15
					(yearDay == 106 and "Spring") or -- April 16 
					(yearDay == 107 and "Spring") or -- April 17
					(yearDay == 108 and "Spring") or -- April 18
					(yearDay == 109 and "Spring") or -- April 19
					(yearDay == 110 and "Spring") or -- April 20
					(yearDay == 111 and "Spring") or -- April 21 
					(yearDay == 112 and "Spring") or -- April 22
					(yearDay == 113 and "Spring") or -- April 23
					(yearDay == 114 and "Spring") or -- April 24
					(yearDay == 115 and "Spring") or -- April 25
					(yearDay == 116 and "Spring") or -- April 26 
					(yearDay == 117 and "Spring") or -- April 27
					(yearDay == 118 and "Spring") or -- April 28
					(yearDay == 119 and "Spring") or -- April 29
					(yearDay == 120 and "Spring") or -- April 30
					(yearDay == 121 and "Spring") or -- May 1 
					(yearDay == 122 and "Spring") or -- May 2
					(yearDay == 123 and "Spring") or -- May 3
					(yearDay == 124 and "Spring") or -- May 4
					(yearDay == 125 and "Spring") or -- May 5
					(yearDay == 126 and "Spring") or -- May 6 
					(yearDay == 127 and "Spring") or -- May 7
					(yearDay == 128 and "Spring") or -- May 8
					(yearDay == 129 and "Spring") or -- May 9
					(yearDay == 130 and "Spring") or -- May 10
					(yearDay == 131 and "Spring") or -- May 11 
					(yearDay == 132 and "Spring") or -- May 12
					(yearDay == 133 and "Spring") or -- May 13
					(yearDay == 134 and "Spring") or -- May 14
					(yearDay == 135 and "Spring") or -- May 15
					(yearDay == 136 and "Spring") or -- May 16 
					(yearDay == 137 and "Spring") or -- May 17
					(yearDay == 138 and "Spring") or -- May 18
					(yearDay == 139 and "Spring") or -- May 19
					(yearDay == 140 and "Spring") or -- May 20
					(yearDay == 141 and "Spring") or -- May 21 
					(yearDay == 142 and "Spring") or -- May 22
					(yearDay == 143 and "Spring") or -- May 23
					(yearDay == 144 and "Spring") or -- May 24
					(yearDay == 145 and "Spring") or -- May 25
					(yearDay == 146 and "Spring") or -- May 26 
					(yearDay == 147 and "Spring") or -- May 27
					(yearDay == 148 and "Spring") or -- May 28
					(yearDay == 149 and "Spring") or -- May 29
					(yearDay == 150 and "Spring") or -- May 30
					(yearDay == 151 and "Spring") or -- May 31 
					(yearDay == 152 and "Summer") or -- June 1
					(yearDay == 153 and "Summer") or -- June 2
					(yearDay == 154 and "Summer") or -- June 3
					(yearDay == 155 and "Summer") or -- June 4
					(yearDay == 156 and "Summer") or -- June 5 
					(yearDay == 157 and "Summer") or -- June 6
					(yearDay == 158 and "Summer") or -- June 7
					(yearDay == 159 and "Summer") or -- June 8
					(yearDay == 160 and "Summer") or -- June 9
					(yearDay == 161 and "Summer") or -- June 10 
					(yearDay == 162 and "Summer") or -- June 11
					(yearDay == 163 and "Summer") or -- June 12
					(yearDay == 164 and "Summer") or -- June 13
					(yearDay == 165 and "Summer") or -- June 14
					(yearDay == 166 and "Summer") or -- June 15 
					(yearDay == 167 and "Summer") or -- June 16
					(yearDay == 168 and "Summer") or -- June 17
					(yearDay == 169 and "Summer") or -- June 18
					(yearDay == 170 and "Summer") or -- June 19
					(yearDay == 171 and "Summer") or -- June 20 
					(yearDay == 172 and "Summer") or -- June 21
					(yearDay == 173 and "Summer") or -- June 22
					(yearDay == 174 and "Summer") or -- June 23
					(yearDay == 175 and "Summer") or -- June 24
					(yearDay == 176 and "Summer") or -- June 25 
					(yearDay == 177 and "Summer") or -- June 26
					(yearDay == 178 and "Summer") or -- June 27
					(yearDay == 179 and "Summer") or -- June 28
					(yearDay == 180 and "Summer") or -- June 29
					(yearDay == 181 and "Summer") or -- June 30 
					(yearDay == 182 and "Summer") or -- July 1
					(yearDay == 183 and "Summer") or -- July 2
					(yearDay == 184 and "Summer") or -- July 3
					(yearDay == 185 and "Summer") or -- July 4
					(yearDay == 186 and "Summer") or -- July 5 
					(yearDay == 187 and "Summer") or -- July 6
					(yearDay == 188 and "Summer") or -- July 7
					(yearDay == 189 and "Summer") or -- July 8
					(yearDay == 190 and "Summer") or -- July 9
					(yearDay == 191 and "Summer") or -- July 10 
					(yearDay == 192 and "Summer") or -- July 11
					(yearDay == 193 and "Summer") or -- July 12
					(yearDay == 194 and "Summer") or -- July 13
					(yearDay == 195 and "Summer") or -- July 14
					(yearDay == 196 and "Summer") or -- July 15 
					(yearDay == 197 and "Summer") or -- July 16
					(yearDay == 198 and "Summer") or -- July 17
					(yearDay == 199 and "Summer") or -- July 18
					(yearDay == 200 and "Summer") or -- July 19
					(yearDay == 201 and "Summer") or -- July 20 
					(yearDay == 202 and "Summer") or -- July 21
					(yearDay == 203 and "Summer") or -- July 22
					(yearDay == 204 and "Summer") or -- July 23
					(yearDay == 205 and "Summer") or -- July 24
					(yearDay == 206 and "Summer") or -- July 25 
					(yearDay == 207 and "Summer") or -- July 26
					(yearDay == 208 and "Summer") or -- July 27
					(yearDay == 209 and "Summer") or -- July 28
					(yearDay == 210 and "Summer") or -- July 29
					(yearDay == 211 and "Summer") or -- July 30 
					(yearDay == 212 and "Summer") or -- July 31
					(yearDay == 213 and "Summer") or -- August 1
					(yearDay == 214 and "Summer") or -- August 2
					(yearDay == 215 and "Summer") or -- August 3
					(yearDay == 216 and "Summer") or -- August 4 
					(yearDay == 217 and "Summer") or -- August 5
					(yearDay == 218 and "Summer") or -- August 6
					(yearDay == 219 and "Summer") or -- August 7
					(yearDay == 220 and "Summer") or -- August 8
					(yearDay == 221 and "Summer") or -- August 9 
					(yearDay == 222 and "Summer") or -- August 10
					(yearDay == 223 and "Summer") or -- August 11
					(yearDay == 224 and "Summer") or -- August 12
					(yearDay == 225 and "Summer") or -- August 13
					(yearDay == 226 and "Summer") or -- August 14 
					(yearDay == 227 and "Summer") or -- August 15
					(yearDay == 228 and "Summer") or -- August 16
					(yearDay == 229 and "Summer") or -- August 17
					(yearDay == 230 and "Summer") or -- August 18
					(yearDay == 231 and "Summer") or -- August 19 
					(yearDay == 232 and "Summer") or -- August 20
					(yearDay == 233 and "Summer") or -- August 21
					(yearDay == 234 and "Summer") or -- August 22
					(yearDay == 235 and "Summer") or -- August 23
					(yearDay == 236 and "Summer") or -- August 24 
					(yearDay == 237 and "Summer") or -- August 25
					(yearDay == 238 and "Summer") or -- August 26
					(yearDay == 239 and "Summer") or -- August 27
					(yearDay == 240 and "Summer") or -- August 28
					(yearDay == 241 and "Summer") or -- August 29 
					(yearDay == 242 and "Summer") or -- August 30
					(yearDay == 243 and "Summer") or -- August 31
					(yearDay == 244 and "Fall") or -- September 1
					(yearDay == 245 and "Fall") or -- September 2
					(yearDay == 246 and "Fall") or -- September 3 
					(yearDay == 247 and "Fall") or -- September 4
					(yearDay == 248 and "Fall") or -- September 5
					(yearDay == 249 and "Fall") or -- September 6
					(yearDay == 250 and "Fall") or -- September 7
					(yearDay == 251 and "Fall") or -- September 8 
					(yearDay == 252 and "Fall") or -- September 9
					(yearDay == 253 and "Fall") or -- September 10
					(yearDay == 254 and "Fall") or -- September 11
					(yearDay == 255 and "Fall") or -- September 12
					(yearDay == 256 and "Fall") or -- September 13 
					(yearDay == 257 and "Fall") or -- September 14
					(yearDay == 258 and "Fall") or -- September 15
					(yearDay == 259 and "Fall") or -- September 16
					(yearDay == 260 and "Fall") or -- September 17
					(yearDay == 261 and "Fall") or -- September 18 
					(yearDay == 262 and "Fall") or -- September 19
					(yearDay == 263 and "Fall") or -- September 20
					(yearDay == 264 and "Fall") or -- September 21
					(yearDay == 265 and "Fall") or -- September 22
					(yearDay == 266 and "Fall") or -- September 23 
					(yearDay == 267 and "Fall") or -- September 24
					(yearDay == 268 and "Fall") or -- September 25
					(yearDay == 269 and "Fall") or -- September 26
					(yearDay == 270 and "Fall") or -- September 27
					(yearDay == 271 and "Fall") or -- September 28 
					(yearDay == 272 and "Fall") or -- September 29
					(yearDay == 273 and "Fall") or -- September 30
					(yearDay == 274 and "Fall") or -- October 1
					(yearDay == 275 and "Fall") or -- October 2
					(yearDay == 276 and "Fall") or -- October 3 
					(yearDay == 277 and "Fall") or -- October 4
					(yearDay == 278 and "Fall") or -- October 5
					(yearDay == 279 and "Fall") or -- October 6
					(yearDay == 280 and "Fall") or -- October 7
					(yearDay == 281 and "Fall") or -- October 8 
					(yearDay == 282 and "Fall") or -- October 9
					(yearDay == 283 and "Fall") or -- October 10
					(yearDay == 284 and "Fall") or -- October 11
					(yearDay == 285 and "Fall") or -- October 12
					(yearDay == 286 and "Fall") or -- October 13 
					(yearDay == 287 and "Fall") or -- October 14
					(yearDay == 288 and "Fall") or -- October 15
					(yearDay == 289 and "Fall") or -- October 16
					(yearDay == 290 and "Fall") or -- October 17
					(yearDay == 291 and "Fall") or -- October 18 
					(yearDay == 292 and "Fall") or -- October 19
					(yearDay == 293 and "Fall") or -- October 20
					(yearDay == 294 and "Fall") or -- October 21
					(yearDay == 295 and "Fall") or -- October 22
					(yearDay == 296 and "Fall") or -- October 23 
					(yearDay == 297 and "Fall") or -- October 24
					(yearDay == 298 and "Fall") or -- October 25
					(yearDay == 299 and "Fall") or -- October 26
					(yearDay == 300 and "Fall") or -- October 27
					(yearDay == 301 and "Fall") or -- October 28 
					(yearDay == 302 and "Fall") or -- October 29
					(yearDay == 303 and "Fall") or -- October 30
					(yearDay == 304 and "Fall") or -- October 31
					(yearDay == 305 and "Fall") or -- November 1
					(yearDay == 306 and "Fall") or -- November 2 
					(yearDay == 307 and "Fall") or -- November 3
					(yearDay == 308 and "Fall") or -- November 4
					(yearDay == 309 and "Fall") or -- November 5
					(yearDay == 310 and "Fall") or -- November 6
					(yearDay == 311 and "Fall") or -- November 7 
					(yearDay == 312 and "Fall") or -- November 8
					(yearDay == 313 and "Fall") or -- November 9
					(yearDay == 314 and "Fall") or -- November 10
					(yearDay == 315 and "Fall") or -- November 11
					(yearDay == 316 and "Fall") or -- November 12 
					(yearDay == 317 and "Fall") or -- November 13
					(yearDay == 318 and "Fall") or -- November 14
					(yearDay == 319 and "Fall") or -- November 15
					(yearDay == 320 and "Fall") or -- November 16
					(yearDay == 321 and "Fall") or -- November 17 
					(yearDay == 322 and "Fall") or -- November 18
					(yearDay == 323 and "Fall") or -- November 19
					(yearDay == 324 and "Fall") or -- November 20
					(yearDay == 325 and "Fall") or -- November 21
					(yearDay == 326 and "Fall") or -- November 22 
					(yearDay == 327 and "Fall") or -- November 23
					(yearDay == 328 and "Fall") or -- November 24
					(yearDay == 329 and "Fall") or -- November 25
					(yearDay == 330 and "Fall") or -- November 26
					(yearDay == 331 and "Fall") or -- November 27 
					(yearDay == 332 and "Fall") or -- November 28
					(yearDay == 333 and "Fall") or -- November 29
					(yearDay == 334 and "Fall") or -- November 30
					(yearDay == 335 and "Winter") or -- December 1
					(yearDay == 336 and "Winter") or -- December 2 
					(yearDay == 337 and "Winter") or -- December 3
					(yearDay == 338 and "Winter") or -- December 4
					(yearDay == 339 and "Winter") or -- December 5
					(yearDay == 340 and "Winter") or -- December 6
					(yearDay == 341 and "Winter") or -- December 7 
					(yearDay == 342 and "Winter") or -- December 8
					(yearDay == 343 and "Winter") or -- December 9
					(yearDay == 344 and "Winter") or -- December 10
					(yearDay == 345 and "Winter") or -- December 11
					(yearDay == 346 and "Winter") or -- December 12 
					(yearDay == 347 and "Winter") or -- December 13
					(yearDay == 348 and "Winter") or -- December 14
					(yearDay == 349 and "Winter") or -- December 15
					(yearDay == 350 and "Winter") or -- December 16
					(yearDay == 351 and "Winter") or -- December 17 
					(yearDay == 352 and "Winter") or -- December 18
					(yearDay == 353 and "Winter") or -- December 19
					(yearDay == 354 and "Winter") or -- December 20
					(yearDay == 355 and "Winter") or -- December 21
					(yearDay == 356 and "Winter") or -- December 22 
					(yearDay == 357 and "Winter") or -- December 23
					(yearDay == 358 and "Winter") or -- December 24
					(yearDay == 359 and "Winter") or -- December 25
					(yearDay == 360 and "Winter") or -- December 28
					(yearDay == 361 and "Winter") or -- December 27 
					(yearDay == 362 and "Winter") or -- December 28
					(yearDay == 363 and "Winter") or -- December 29
					(yearDay == 364 and "Winter") or -- December 30
					(yearDay == 365 and "Winter") -- December 31
	
					



					
Environment.Holiday = (Debug.Enabled and Debug.Holiday) or
					(yearDay == 1 and "") or -- January 1
					(yearDay == 2 and "") or -- January 2
					(yearDay == 3 and "") or -- January 3
					(yearDay == 4 and "") or -- January 4
					(yearDay == 5 and "") or -- January 5
					(yearDay == 6 and "") or -- January 6
					(yearDay == 7 and "") or -- January 7
					(yearDay == 8 and "") or -- January 8
					(yearDay == 9 and "") or -- January 9
					(yearDay == 10 and "") or -- January 10
					(yearDay == 11 and "") or -- January 11 
					(yearDay == 12 and "") or -- January 12
					(yearDay == 13 and "") or -- January 13
					(yearDay == 14 and "") or -- January 14
					(yearDay == 15 and "") or -- January 15
					(yearDay == 16 and "") or -- January 16
					(yearDay == 17 and "") or -- January 17
					(yearDay == 18 and "") or -- January 18
					(yearDay == 19 and "") or -- January 19
					(yearDay == 20 and "") or -- January 20
					(yearDay == 21 and "") or -- January 21 
					(yearDay == 22 and "") or -- January 22
					(yearDay == 23 and "") or -- January 23
					(yearDay == 24 and "") or -- January 24
					(yearDay == 25 and "") or -- January 25
					(yearDay == 26 and "") or -- January 26 
					(yearDay == 27 and "") or -- January 27
					(yearDay == 28 and "") or -- January 28
					(yearDay == 29 and "") or -- January 29
					(yearDay == 30 and "") or -- January 30
					(yearDay == 31 and "") or -- January 31 
					(yearDay == 32 and "") or -- February 1
					(yearDay == 33 and "") or -- February 2
					(yearDay == 34 and "") or -- February 3
					(yearDay == 35 and "") or -- February 4
					(yearDay == 36 and "") or -- February 5 
					(yearDay == 37 and "") or -- February 6
					(yearDay == 38 and "") or -- February 7
					(yearDay == 39 and "") or -- February 8
					(yearDay == 40 and "") or -- February 9
					(yearDay == 41 and "") or -- February 10 
					(yearDay == 42 and "") or -- February 11
					(yearDay == 43 and "") or -- February 12
					(yearDay == 44 and "") or -- February 13
					(yearDay == 45 and "") or -- February 14
					(yearDay == 46 and "") or -- February 15 
					(yearDay == 47 and "") or -- February 16
					(yearDay == 48 and "") or -- February 17
					(yearDay == 49 and "") or -- February 18
					(yearDay == 50 and "") or -- February 19
					(yearDay == 51 and "") or -- February 20 
					(yearDay == 52 and "") or -- February 21
					(yearDay == 53 and "") or -- February 22
					(yearDay == 54 and "") or -- February 23
					(yearDay == 55 and "") or -- February 24
					(yearDay == 56 and "") or -- February 25 
					(yearDay == 57 and "") or -- February 26
					(yearDay == 58 and "") or -- February 27
					(yearDay == 59 and "") or -- February 28
					(yearDay == 60 and "") or -- March 1
					(yearDay == 61 and "") or -- March 2 
					(yearDay == 62 and "") or -- March 3
					(yearDay == 63 and "") or -- March 4
					(yearDay == 64 and "") or -- March 5
					(yearDay == 65 and "") or -- March 6
					(yearDay == 66 and "") or -- March 7 
					(yearDay == 67 and "") or -- March 8
					(yearDay == 68 and "") or -- March 9
					(yearDay == 69 and "") or -- March 10
					(yearDay == 70 and "") or -- March 11
					(yearDay == 71 and "") or -- March 12 
					(yearDay == 72 and "") or -- March 13
					(yearDay == 73 and "") or -- March 14
					(yearDay == 74 and "") or -- March 15
					(yearDay == 75 and "") or -- March 16
					(yearDay == 76 and "") or -- March 17 
					(yearDay == 77 and "") or -- March 18
					(yearDay == 78 and "") or -- March 19
					(yearDay == 79 and "") or -- March 20
					(yearDay == 80 and "") or -- March 21
					(yearDay == 81 and "") or -- March 22 
					(yearDay == 82 and "") or -- March 23
					(yearDay == 83 and "") or -- March 24
					(yearDay == 84 and "") or -- March 25
					(yearDay == 85 and "") or -- March 26
					(yearDay == 86 and "") or -- March 27 
					(yearDay == 87 and "") or -- March 28
					(yearDay == 88 and "") or -- March 29
					(yearDay == 89 and "") or -- March 30
					(yearDay == 90 and "") or -- March 31
					(yearDay == 91 and "") or -- April 1 
					(yearDay == 92 and "") or -- April 2
					(yearDay == 93 and "") or -- April 3
					(yearDay == 94 and "") or -- April 4
					(yearDay == 95 and "") or -- April 5
					(yearDay == 96 and "") or -- April 6 
					(yearDay == 97 and "") or -- April 7
					(yearDay == 98 and "") or -- April 8
					(yearDay == 99 and "") or -- April 9
					(yearDay == 100 and "") or -- April 10
					(yearDay == 101 and "") or -- April 11 
					(yearDay == 102 and "") or -- April 12
					(yearDay == 103 and "") or -- April 13
					(yearDay == 104 and "") or -- April 14
					(yearDay == 105 and "") or -- April 15
					(yearDay == 106 and "") or -- April 16 
					(yearDay == 107 and "") or -- April 17
					(yearDay == 108 and "") or -- April 18
					(yearDay == 109 and "") or -- April 19
					(yearDay == 110 and "") or -- April 20
					(yearDay == 111 and "") or -- April 21 
					(yearDay == 112 and "") or -- April 22
					(yearDay == 113 and "") or -- April 23
					(yearDay == 114 and "") or -- April 24
					(yearDay == 115 and "") or -- April 25
					(yearDay == 116 and "") or -- April 26 
					(yearDay == 117 and "") or -- April 27
					(yearDay == 118 and "") or -- April 28
					(yearDay == 119 and "") or -- April 29
					(yearDay == 120 and "") or -- April 30
					(yearDay == 121 and "") or -- May 1 
					(yearDay == 122 and "") or -- May 2
					(yearDay == 123 and "") or -- May 3
					(yearDay == 124 and "") or -- May 4
					(yearDay == 125 and "") or -- May 5
					(yearDay == 126 and "") or -- May 6 
					(yearDay == 127 and "") or -- May 7
					(yearDay == 128 and "") or -- May 8
					(yearDay == 129 and "") or -- May 9
					(yearDay == 130 and "") or -- May 10
					(yearDay == 131 and "") or -- May 11 
					(yearDay == 132 and "") or -- May 12
					(yearDay == 133 and "") or -- May 13
					(yearDay == 134 and "") or -- May 14
					(yearDay == 135 and "") or -- May 15
					(yearDay == 136 and "") or -- May 16 
					(yearDay == 137 and "") or -- May 17
					(yearDay == 138 and "") or -- May 18
					(yearDay == 139 and "") or -- May 19
					(yearDay == 140 and "") or -- May 20
					(yearDay == 141 and "") or -- May 21 
					(yearDay == 142 and "") or -- May 22
					(yearDay == 143 and "") or -- May 23
					(yearDay == 144 and "") or -- May 24
					(yearDay == 145 and "") or -- May 25
					(yearDay == 146 and "") or -- May 26 
					(yearDay == 147 and "") or -- May 27
					(yearDay == 148 and "") or -- May 28
					(yearDay == 149 and "") or -- May 29
					(yearDay == 150 and "") or -- May 30
					(yearDay == 151 and "") or -- May 31 
					(yearDay == 152 and "") or -- June 1
					(yearDay == 153 and "") or -- June 2
					(yearDay == 154 and "") or -- June 3
					(yearDay == 155 and "") or -- June 4
					(yearDay == 156 and "") or -- June 5 
					(yearDay == 157 and "") or -- June 6
					(yearDay == 158 and "") or -- June 7
					(yearDay == 159 and "") or -- June 8
					(yearDay == 160 and "") or -- June 9
					(yearDay == 161 and "") or -- June 10 
					(yearDay == 162 and "") or -- June 11
					(yearDay == 163 and "") or -- June 12
					(yearDay == 164 and "") or -- June 13
					(yearDay == 165 and "") or -- June 14
					(yearDay == 166 and "") or -- June 15 
					(yearDay == 167 and "") or -- June 16
					(yearDay == 168 and "") or -- June 17
					(yearDay == 169 and "") or -- June 18
					(yearDay == 170 and "") or -- June 19
					(yearDay == 171 and "") or -- June 20 
					(yearDay == 172 and "") or -- June 21
					(yearDay == 173 and "") or -- June 22
					(yearDay == 174 and "") or -- June 23
					(yearDay == 175 and "") or -- June 24
					(yearDay == 176 and "") or -- June 25 
					(yearDay == 177 and "") or -- June 26
					(yearDay == 178 and "") or -- June 27
					(yearDay == 179 and "") or -- June 28
					(yearDay == 180 and "") or -- June 29
					(yearDay == 181 and "") or -- June 30 
					(yearDay == 182 and "") or -- July 1
					(yearDay == 183 and "") or -- July 2
					(yearDay == 184 and "") or -- July 3
					(yearDay == 185 and "") or -- July 4
					(yearDay == 186 and "") or -- July 5 
					(yearDay == 187 and "") or -- July 6
					(yearDay == 188 and "") or -- July 7
					(yearDay == 189 and "") or -- July 8
					(yearDay == 190 and "") or -- July 9
					(yearDay == 191 and "") or -- July 10 
					(yearDay == 192 and "") or -- July 11
					(yearDay == 193 and "") or -- July 12
					(yearDay == 194 and "") or -- July 13
					(yearDay == 195 and "") or -- July 14
					(yearDay == 196 and "") or -- July 15 
					(yearDay == 197 and "") or -- July 16
					(yearDay == 198 and "") or -- July 17
					(yearDay == 199 and "") or -- July 18
					(yearDay == 200 and "") or -- July 19
					(yearDay == 201 and "") or -- July 20 
					(yearDay == 202 and "") or -- July 21
					(yearDay == 203 and "") or -- July 22
					(yearDay == 204 and "") or -- July 23
					(yearDay == 205 and "") or -- July 24
					(yearDay == 206 and "") or -- July 25 
					(yearDay == 207 and "") or -- July 26
					(yearDay == 208 and "") or -- July 27
					(yearDay == 209 and "") or -- July 28
					(yearDay == 210 and "") or -- July 29
					(yearDay == 211 and "") or -- July 30 
					(yearDay == 212 and "") or -- July 31
					(yearDay == 213 and "") or -- August 1
					(yearDay == 214 and "") or -- August 2
					(yearDay == 215 and "") or -- August 3
					(yearDay == 216 and "") or -- August 4 
					(yearDay == 217 and "") or -- August 5
					(yearDay == 218 and "") or -- August 6
					(yearDay == 219 and "") or -- August 7
					(yearDay == 220 and "") or -- August 8
					(yearDay == 221 and "") or -- August 9 
					(yearDay == 222 and "") or -- August 10
					(yearDay == 223 and "") or -- August 11
					(yearDay == 224 and "") or -- August 12
					(yearDay == 225 and "") or -- August 13
					(yearDay == 226 and "") or -- August 14 
					(yearDay == 227 and "") or -- August 15
					(yearDay == 228 and "") or -- August 16
					(yearDay == 229 and "") or -- August 17
					(yearDay == 230 and "") or -- August 18
					(yearDay == 231 and "") or -- August 19 
					(yearDay == 232 and "") or -- August 20
					(yearDay == 233 and "") or -- August 21
					(yearDay == 234 and "") or -- August 22
					(yearDay == 235 and "") or -- August 23
					(yearDay == 236 and "") or -- August 24 
					(yearDay == 237 and "") or -- August 25
					(yearDay == 238 and "") or -- August 26
					(yearDay == 239 and "") or -- August 27
					(yearDay == 240 and "") or -- August 28
					(yearDay == 241 and "") or -- August 29 
					(yearDay == 242 and "") or -- August 30
					(yearDay == 243 and "") or -- August 31
					(yearDay == 244 and "") or -- September 1
					(yearDay == 245 and "") or -- September 2
					(yearDay == 246 and "") or -- September 3 
					(yearDay == 247 and "") or -- September 4
					(yearDay == 248 and "") or -- September 5
					(yearDay == 249 and "") or -- September 6
					(yearDay == 250 and "") or -- September 7
					(yearDay == 251 and "") or -- September 8 
					(yearDay == 252 and "") or -- September 9
					(yearDay == 253 and "") or -- September 10
					(yearDay == 254 and "") or -- September 11
					(yearDay == 255 and "") or -- September 12
					(yearDay == 256 and "") or -- September 13 
					(yearDay == 257 and "") or -- September 14
					(yearDay == 258 and "") or -- September 15
					(yearDay == 259 and "") or -- September 16
					(yearDay == 260 and "") or -- September 17
					(yearDay == 261 and "") or -- September 18 
					(yearDay == 262 and "") or -- September 19
					(yearDay == 263 and "") or -- September 20
					(yearDay == 264 and "") or -- September 21
					(yearDay == 265 and "") or -- September 22
					(yearDay == 266 and "") or -- September 23 
					(yearDay == 267 and "") or -- September 24
					(yearDay == 268 and "") or -- September 25
					(yearDay == 269 and "") or -- September 26
					(yearDay == 270 and "") or -- September 27
					(yearDay == 271 and "") or -- September 28 
					(yearDay == 272 and "") or -- September 29
					(yearDay == 273 and "") or -- September 30
					(yearDay == 274 and "Halloween") or -- October 1
					(yearDay == 275 and "Halloween") or -- October 2
					(yearDay == 276 and "Halloween") or -- October 3 
					(yearDay == 277 and "Halloween") or -- October 4
					(yearDay == 278 and "Halloween") or -- October 5
					(yearDay == 279 and "Halloween") or -- October 6
					(yearDay == 280 and "Halloween") or -- October 7
					(yearDay == 281 and "Halloween") or -- October 8 
					(yearDay == 282 and "Halloween") or -- October 9
					(yearDay == 283 and "Halloween") or -- October 10
					(yearDay == 284 and "Halloween") or -- October 11
					(yearDay == 285 and "Halloween") or -- October 12
					(yearDay == 286 and "Halloween") or -- October 13 
					(yearDay == 287 and "Halloween") or -- October 14
					(yearDay == 288 and "Halloween") or -- October 15
					(yearDay == 289 and "Halloween") or -- October 16
					(yearDay == 290 and "Halloween") or -- October 17
					(yearDay == 291 and "Halloween") or -- October 18 
					(yearDay == 292 and "Halloween") or -- October 19
					(yearDay == 293 and "Halloween") or -- October 20
					(yearDay == 294 and "Halloween") or -- October 21
					(yearDay == 295 and "Halloween") or -- October 22
					(yearDay == 296 and "Halloween") or -- October 23 
					(yearDay == 297 and "Halloween") or -- October 24
					(yearDay == 298 and "Halloween") or -- October 25
					(yearDay == 299 and "Halloween") or -- October 26
					(yearDay == 300 and "Halloween") or -- October 27
					(yearDay == 301 and "Halloween") or -- October 28 
					(yearDay == 302 and "Halloween") or -- October 29
					(yearDay == 303 and "Halloween") or -- October 30
					(yearDay == 304 and "Halloween") or -- October 31
					(yearDay == 305 and "Thanksgiving") or -- November 1
					(yearDay == 306 and "Thanksgiving") or -- November 2 
					(yearDay == 307 and "Thanksgiving") or -- November 3
					(yearDay == 308 and "Thanksgiving") or -- November 4
					(yearDay == 309 and "Thanksgiving") or -- November 5
					(yearDay == 310 and "Thanksgiving") or -- November 6
					(yearDay == 311 and "Thanksgiving") or -- November 7 
					(yearDay == 312 and "Thanksgiving") or -- November 8
					(yearDay == 313 and "Thanksgiving") or -- November 9
					(yearDay == 314 and "Thanksgiving") or -- November 10
					(yearDay == 315 and "Thanksgiving") or -- November 11
					(yearDay == 316 and "Thanksgiving") or -- November 12 
					(yearDay == 317 and "Thanksgiving") or -- November 13
					(yearDay == 318 and "Thanksgiving") or -- November 14
					(yearDay == 319 and "Thanksgiving") or -- November 15
					(yearDay == 320 and "Thanksgiving") or -- November 16
					(yearDay == 321 and "Thanksgiving") or -- November 17 
					(yearDay == 322 and "Thanksgiving") or -- November 18
					(yearDay == 323 and "Thanksgiving") or -- November 19
					(yearDay == 324 and "Thanksgiving") or -- November 20
					(yearDay == 325 and "Thanksgiving") or -- November 21
					(yearDay == 326 and "Thanksgiving") or -- November 22 
					(yearDay == 327 and "Thanksgiving") or -- November 23
					(yearDay == 328 and "Thanksgiving") or -- November 24
					(yearDay == 329 and "Thanksgiving") or -- November 25
					(yearDay == 330 and "Thanksgiving") or -- November 26
					(yearDay == 331 and "Thanksgiving") or -- November 27 
					(yearDay == 332 and "Thanksgiving") or -- November 28
					(yearDay == 333 and "Thanksgiving") or -- November 29
					(yearDay == 334 and "Thanksgiving") or -- November 30
					(yearDay == 335 and "Christmas") or -- December 1
					(yearDay == 336 and "Christmas") or -- December 2 
					(yearDay == 337 and "Christmas") or -- December 3
					(yearDay == 338 and "Christmas") or -- December 4
					(yearDay == 339 and "Christmas") or -- December 5
					(yearDay == 340 and "Christmas") or -- December 6
					(yearDay == 341 and "Christmas") or -- December 7 
					(yearDay == 342 and "Christmas") or -- December 8
					(yearDay == 343 and "Christmas") or -- December 9
					(yearDay == 344 and "Christmas") or -- December 10
					(yearDay == 345 and "Christmas") or -- December 11
					(yearDay == 346 and "Christmas") or -- December 12 
					(yearDay == 347 and "Christmas") or -- December 13
					(yearDay == 348 and "Christmas") or -- December 14
					(yearDay == 349 and "Christmas") or -- December 15
					(yearDay == 350 and "Christmas") or -- December 16
					(yearDay == 351 and "Christmas") or -- December 17 
					(yearDay == 352 and "Christmas") or -- December 18
					(yearDay == 353 and "Christmas") or -- December 19
					(yearDay == 354 and "Christmas") or -- December 20
					(yearDay == 355 and "Christmas") or -- December 21
					(yearDay == 356 and "Christmas") or -- December 22 
					(yearDay == 357 and "Christmas") or -- December 23
					(yearDay == 358 and "Christmas") or -- December 24
					(yearDay == 359 and "Christmas") or -- December 25
					(yearDay == 360 and "Christmas") or -- December 28
					(yearDay == 361 and "Christmas") or -- December 27 
					(yearDay == 362 and "Christmas") or -- December 28
					(yearDay == 363 and "Christmas") or -- December 29
					(yearDay == 364 and "Christmas") or -- December 30
					(yearDay == 365 and "Christmas") -- December 31


Environment.TimeOfDay = (Debug.Enabled and Debug.TimeOfDay) or "Afternoon"
Environment.Sky = game.Lighting:FindFirstChild("Sky")
Environment.Trees = Trees


if Enums.IsPartyServer then
	for _,tree in ipairs(workspace.Trees:GetChildren()) do
		tree:Destroy()
	end
	for _,tree in ipairs(Trees) do
		tree.Parent = workspace.Trees
	end
end


local Color = {}
Color.new = function(r,g,b)
	return Color3.new(r/255,g/255,b/255)
end


function Environment:SetTimeOfDay(timeOfDay)

	Environment.TimeOfDay = timeOfDay
	game.ReplicatedStorage.GlobalData.TimeOfDay.Value = timeOfDay
	
	workspace.Main.TimeOfDayChanged:FireAllClients(timeOfDay)
	
	
	if OceanWater then OceanWater.BrickColor = BrickColor.new("Bright blue") end
	
	
	local function SetLighting(properties)
		for propertyName,value in pairs(properties) do
			game.Lighting[propertyName] = value
		end
	end
	
	local function SetTerrain(properties)
		for propertyName,value in pairs(properties) do
			workspace.Terrain[propertyName] = value
		end
	end
	
	
	local function SetIndoorLighting(LightTypes)
		for _,group in ipairs(workspace.Lights:GetChildren()) do
			for _,lightPart in ipairs(group:GetChildren()) do
				
				local light = lightPart:FindFirstChild("PointLight") or lightPart:FindFirstChild("SurfaceLight") or lightPart:FindFirstChild("SpotLight")
				
				for lightType,lightProperties in pairs(LightTypes) do
					if lightPart.Name == lightType then
						for propertyName,value in pairs(lightProperties) do
							light[propertyName] = value
						end
					end
				end
			end
		end
	end

	
	
	local function SetSkyBox(skyName)
		if Environment.Sky then Environment.Sky:Destroy() end
		if skyName then
			Environment.Sky = script.Skies[skyName]:clone()
			Environment.Sky.Name = "Sky"
			Environment.Sky.Parent = game.Lighting
		end
	end
	
	local function EnableChristmasLights(enabled)
		--tree lights
		
		for _,obj in ipairs(workspace:GetChildren()) do
			if obj.Name == "Tree" then
				obj.LeavesMain.PointLight.Enabled = enabled
			end
		end
		
		--toggle lights from server storage
		local source = (enabled and game.ServerStorage.SeasonalStorage.DecorationTempStorage) or workspace
		local destination = (enabled and workspace) or game.ServerStorage.SeasonalStorage.DecorationTempStorage
	
		for _,obj in ipairs(source:GetChildren()) do
			if obj.Name == "ChristmasLights" or obj.Name == "FrontChristmasLight" then
				obj.Parent = destination
			end
		end
	end
	
	
	
	local function SetColorCorrection(timeOfDay)
		for _,obj in ipairs(game.Lighting:GetChildren()) do
			if obj:IsA("ColorCorrectionEffect") then
				obj.Enabled =  (obj.Name == timeOfDay and true) or false
				if obj.Enabled then
					game.Lighting.CurrentCorrection.Value = obj
				end
			end
		end
	end
	
	local function SetSunRays(enabled,intensity,spread)
		game.Lighting.SunRays.Enabled = enabled
		game.Lighting.SunRays.Intensity = intensity
		game.Lighting.SunRays.Spread = spread

	end
	

	local function FallingLeavesEnabled(enabled)

		for _,obj in ipairs(Trees) do
			obj.LeavesMain.LeafParticles.Enabled = enabled
		end
	end
	
	
	
	
	
	
	
	
	if timeOfDay == "Afternoon" then
	
		SetLighting({
			OutdoorAmbient = Color.new(255, 205, 176),
			Ambient = Color.new(68, 58, 39),
			TimeOfDay = "07:50:00",
			FogEnd = 1000000,
			GeographicLatitude = -30.733,
			Brightness = 1,
			ColorShift_Bottom =  Color.new(248, 199, 100),
			ColorShift_Top = Color.new(248, 199, 100),
		})
		
		SetTerrain({
			WaterColor = Color.new(19, 33, 66),
			WaterReflectance = .3,
			WaterTransparency = .15,
			WaterWaveSize = .15,
			WaterWaveSpeed = 10,
		})
		
		SetIndoorLighting({
			NormalLight = {Enabled = true, Color = Color.new(131,142,163)},
			MainLight = {Enabled = false, Color = Color.new(131,142,163)},
			HangingLight = {Enabled = true, Color = Color.new(131,142,163)},
		})
		
		SetColorCorrection("Afternoon")
		SetSkyBox("Afternoon")
		SetSunRays(true,0.2,1)

		
		if Environment.Season == "Fall" then
			SetSkyBox("FallAfternoon")
        end
		
		
		
		
		
		
		
		
	elseif timeOfDay == "Night" then
		
		spawn(function() Paycheck:GiveEveryonePaychecks() end)
		
		SetTerrain({
			WaterColor = Color.new(24, 28, 31),
			WaterReflectance = .2,
			WaterTransparency = .05,
			WaterWaveSize = .15,
			WaterWaveSpeed = 10,
		})
		
		
		SetLighting({
			OutdoorAmbient = Color.new(44,90,150),
			Ambient = Color.new(76, 96, 138),
			TimeOfDay = "15:00:00",
			FogEnd = 1000000,
			GeographicLatitude = -16.733,
			Brightness = 1,
			ColorShift_Bottom =  Color.new(93, 142, 255),
			ColorShift_Top =Color.new(93, 142, 255),
		})
		
		SetIndoorLighting({
			NormalLight = {Enabled = true, Color = Color.new(255,255,255)},
			MainLight = {Enabled = true, Color = Color.new(255,255,255)},
			HangingLight = {Enabled = true, Color = Color.new(255,255,255)},
			Candle = {Enabled = false},
		})
		
		SetColorCorrection("Night")
		SetSunRays(true,0.05,.6)
		SetSkyBox("Night")
		if OceanWater then OceanWater.BrickColor = BrickColor.new("Storm blue") end
		
		
			if Environment.Holiday == "Christmas" then
			SetLighting({
				OutdoorAmbient = Color.new(38,52,147),
				Ambient = Color.new(29, 37, 54),
				TimeOfDay = "21:00:00",
				FogEnd = 10000000,
				FogColor = Color.new(0,0,0),
				GeographicLatitude = -30.733,
				Brightness = .5,
				ColorShift_Bottom =  Color.new(93, 142, 255),
				ColorShift_Top = Color.new(93, 142, 255),
			})
			
			SetColorCorrection("ChristmasNight")
			SetSkyBox(nil)
			if OceanWater then OceanWater.BrickColor = BrickColor.new("Navy blue") end
			
				EnableChristmasLights(true)
				SetIndoorLighting({
					NormalLight = {Enabled = true, Color = Color.new(255,255,255)},
					MainLight = {Enabled = false, Color = Color.new(255,255,255)},
					HangingLight = {Enabled = false},
					Candle = {Enabled = true},
				})
			end

			if Environment.Holiday == "Halloween" then
				
			SetLighting({
				OutdoorAmbient = Color.new(87, 121, 150),
				Ambient = Color.new(0,0,0),
				TimeOfDay = "21:00:00",
				FogEnd = 1000,
				FogColor = Color.new(0,0,0),
				GeographicLatitude = -30.733,
				Brightness = 2,
				ColorShift_Bottom =  Color.new(93, 142, 255),
				ColorShift_Top = Color.new(93, 142, 255),
			})
			SetColorCorrection("Night")
			SetSkyBox(nil)
			if OceanWater then OceanWater.BrickColor = BrickColor.new("Navy blue") end
				
				SetIndoorLighting({
					NormalLight = {Enabled = true, Color = Color.new(255,255,255)},
					MainLight = {Enabled = false, Color = Color.new(255,0,0)},
					HangingLight = {Enabled = true, Color = Color.new(255,0,0)},
					Candle = {Enabled = false},
				})
	
				SetColorCorrection("HalloweenNight")
				SetSkyBox(nil)
			
			end 
			
		if Environment.Season == "Winter" then
			
			SetLighting({
				OutdoorAmbient = Color.new(50, 70, 195),
				Ambient = Color.new(29, 37, 54),
				TimeOfDay = "15:00:00",
				FogEnd = 10000000,
				FogColor = Color.new(0,0,0),
				GeographicLatitude = -30.733,
				Brightness = 1,
				ColorShift_Bottom =  Color.new(93, 142, 255),
				ColorShift_Top = Color.new(93, 142, 255),
			})
			
			SetColorCorrection("WinterNight")
			SetSkyBox("Night")
			if OceanWater then OceanWater.BrickColor = BrickColor.new("Navy blue") end
			
			
			
			
			
		elseif Environment.Season == "Fall" then
			
			FallingLeavesEnabled(false)
			
			if Environment.Holiday == "Halloween" then
				
				SetIndoorLighting({
					NormalLight = {Enabled = true, Color = Color.new(255,255,255)},
					MainLight = {Enabled = false, Color = Color.new(255,0,0)},
					HangingLight = {Enabled = true, Color = Color.new(255,0,0)},
					Candle = {Enabled = false},
				})
	
				SetColorCorrection("HalloweenNight")
				SetSkyBox(nil)
			
			end 
		
			
		end
	
	
	
	
	
	
	
	
	
	elseif timeOfDay == "Midday" then

		spawn(function() Paycheck:GiveEveryonePaychecks() end)

		SetTerrain({
			WaterColor = Color.new(7, 66, 84),
			WaterReflectance = .2,
			WaterTransparency = .3,
			WaterWaveSize = 0.05,
			WaterWaveSpeed = 10,
		})
		
		SetLighting({
			OutdoorAmbient = Color.new(255,255,255),
			Ambient = Color.new(112, 112, 112),
			TimeOfDay = "12:00:00",
			FogEnd = 10000000,
			GeographicLatitude = 40,
			Brightness = 1,
			ColorShift_Bottom =  Color.new(0,0,0),
			ColorShift_Top = Color.new(0,0,0),
		})
		SetSunRays(false,0,0)
		SetSkyBox("Midday")
		SetColorCorrection("Midday")
		
		
		SetIndoorLighting({
			NormalLight = {Enabled = true},
			MainLight = {Enabled = true},
			HangingLight = {Enabled = false},
			Candle = {Enabled = false},
		})

		if Environment.Holiday == "Thanksgiving" then

			SetLighting({
				OutdoorAmbient = Color.new(255,255,255),
				Ambient = Color.new(84, 84, 84),
				TimeOfDay = "12:00:00",
				FogEnd = 10000000,
				GeographicLatitude = 40,
				Brightness = 1,
				ColorShift_Bottom =  Color.new(0,0,0),
				ColorShift_Top = Color.new(0,0,0),
			})
			
			SetSkyBox(nil)
			if OceanWater then OceanWater.BrickColor = BrickColor.new("Storm blue") end
			end
			
		if Environment.Season == "Winter" then
			
			SetLighting({
				OutdoorAmbient = Color.new(185, 185, 185),
				Ambient = Color.new(84, 84, 84),
				TimeOfDay = "11:59:00",
				FogEnd = 10000000,
				GeographicLatitude = 40,
				Brightness = .8,
				FogStart = 50,
				FogEnd = 400,
				FogColor =  Color.new(232, 232, 232),
				ColorShift_Bottom =  Color.new(0,0,0),
				ColorShift_Top = Color.new(0,0,0),
			})
			SetSkyBox("WinterMidday")
			SetColorCorrection("WinterDay")

			if OceanWater then OceanWater.BrickColor = BrickColor.new("Storm blue") end
			
			if Environment.Holiday == "Christmas" then
				EnableChristmasLights(false)
			end
	
			
		end
		
		
		
		
		
		
		
		
	elseif timeOfDay == "Morning" then
		SetLighting({
			OutdoorAmbient = Color.new(255, 191, 112),
			Ambient = Color.new(67, 63, 36),
			TimeOfDay = "07:00:00",
			FogEnd = 10000000,
			GeographicLatitude = 95,
			Brightness = 1,
			ColorShift_Bottom =  Color.new(255, 248, 161),
			ColorShift_Top = Color.new(255, 248, 161),
		})
		
		SetTerrain({
			WaterColor = Color.new(13, 28, 42),
			WaterReflectance = .4,
			WaterTransparency = .2,
			WaterWaveSize = 0,
			WaterWaveSpeed = 5,
		})
		
		SetIndoorLighting({
			NormalLight = {Enabled = true, Color =Color.new(255,108,79)},
			MainLight = {Enabled = true, Color = Color.new(255,108,79)},
			HangingLight = {Enabled = true, Color = Color.new(255,108,79)},
		})
		
		
		SetSkyBox("Morning")
		SetSunRays(true,0.250,0.900)
		SetColorCorrection("Morning")
		
		if Environment.Season == "Fall" then
			FallingLeavesEnabled(true)
		end
		
	end

	
end

local clearedTreesByHouse = {}
function Environment:ClearTreesForHouse(houseObject,areaBlock)
	
	clearedTreesByHouse[houseObject] = clearedTreesByHouse[houseObject] or {}

	for _,tree in ipairs(Trees) do
		local insideBox = Utility:IsBoxInsideBox(areaBlock,tree.LeavesMain,2)
		if not clearedTreesByHouse[houseObject][tree] and insideBox and tree.Parent == workspace.Trees  then
				
			tree.Parent = game.ServerStorage.ClearedTrees
			clearedTreesByHouse[houseObject][tree] = tree
				
				
		elseif clearedTreesByHouse[houseObject][tree] and not insideBox and tree.Parent == game.ServerStorage.ClearedTrees then
			tree.Parent = workspace.Trees
			clearedTreesByHouse[houseObject][tree] = nil
				
		end
	end
	
end



local Durations = {["Afternoon"] = 6, ["Night"] = 9, ["Morning"] = 4, ["Midday"] = 8 }  --time is in minutes
local Order = {"Midday","Afternoon","Night","Morning"}
local WinterOrder = {"Midday","Night"}
local HalloweenOrder = {"Night"}
local FallOrder = {"Afternoon","Night"}
local TGOrder = {"Midday","Afternoon","Night","Morning"}


function Environment:StartDayNightCycle()
	if not (Debug.Enabled and (Debug.TimeOfDay or Debug.DayNightCycleDisabled)) then
		spawn(function()
			while true do
				for _,timeOfDay in pairs((Environment.Holiday == "Christmas" and WinterOrder or Environment.Holiday == "Halloween" and HalloweenOrder or Environment.Holiday == "Thanksgiving" and TGOrder or Environment.Season == "Winter" and WinterOrder  or Environment.Season == "Fall" and FallOrder) or Order) do
					
					Environment:SetTimeOfDay(timeOfDay)
					print(Environment.TimeOfDay)
					wait(Durations[timeOfDay]*((Debug.Enabled and Debug.FastCycle) or 60))
				end	
			end
		end)
	else
		Environment:SetTimeOfDay(Debug.TimeOfDay)
	end

end


--/////////////////HOLIDAYS\\\\\\\\\\\\\\\\\\\\----------------------------------------------------------------------------------------------------------------------------------------------------------


function Environment:SetHoliday(holidayName)
	Environment.Holiday = holidayName
	game.ReplicatedStorage.GlobalData.Holiday.Value = holidayName
		
	local function SetTreeColor(tree,trunkColor,leavesColor)

		tree.Trunk.BrickColor = BrickColor.new(trunkColor)
	end
		
	
	local function SetTableCloth(textureId)
		for _,tab in ipairs(workspace.Tables:GetChildren()) do
			for _,part in ipairs(tab:GetChildren()) do
				if part:FindFirstChild("Texture") then
					for _,obj in ipairs(part:GetChildren()) do
						if obj.Name == "Texture" then
							obj.Texture = "rbxassetid://" .. textureId
						end
					end
				end
			end
		end
	end
	

	
	
		if Environment.Holiday == "Thanksgiving" then
			SetTableCloth(187727998)
			Utility:SetParentOfChildren(game.ServerStorage.SeasonalStorage.Thanksgiving,workspace)
		
		elseif Environment.Holiday == "Halloween" then
			SetTableCloth(304316861)
			Utility:SetParentOfChildren(game.ServerStorage.SeasonalStorage.Halloween,workspace)
			game.ServerStorage.SeasonalStorage.Bucket.Parent = game.StarterPack

		
		elseif Environment.Holiday == "Christmas" then
			
			SetTableCloth(188770508)
			game.ServerStorage.SeasonalStorage.Christmas.Candles.Parent = workspace.Lights
			Utility:SetParentOfChildren(game.ServerStorage.SeasonalStorage.Christmas,workspace)
			--game.ServerStorage.SeasonalStorage.Snowball.Parent = game.StarterPack
		end

end
--/////////////////SEASONS\\\\\\\\\\\\\\\\\\\\----------------------------------------------------------------------------------------------------------------------------------------------------------


function Environment:SetSeason(seasonName)
	Environment.Season = seasonName
	game.ReplicatedStorage.GlobalData.Season.Value = seasonName

	math.randomseed(tick())
	
	
	local function SetTreeColor(tree,trunkColor,leavesColor)

		tree.Trunk.BrickColor = BrickColor.new(trunkColor)
		
		for _,obj in ipairs(tree:GetChildren()) do
			if obj.Name == "Leaves" or obj.Name == "LeavesMain" then
				obj.BrickColor = BrickColor.new(leavesColor)
				
				if Environment.Season == "Winter" then
					obj.Material = "Sand"
				
				elseif Environment.Season == "Spring" then
					obj.Material = "Concrete"
				
				else
					obj.Material = "Grass"
				end
			end
		end
	end
	
	local function SnowFlakesEnabled(obj,enabled)
		for _,tex in ipairs(obj:GetChildren()) do
			if tex.Name == "Texture" then
				tex.Transparency = (enabled and 0) or 1
			end
		end
	end

		
		
	if seasonName == "Spring" then
	
		for _,tree in ipairs(Trees) do
			local colors = {1025,1026,9,"Carnation pink","Sunrise","Seashell"}
			local color = colors[math.random(1,#colors)]
			SetTreeColor(tree,192,color)
							
			if tree.LeavesMain.Shape == Enum.PartType.Ball then --remove winter stuff
				tree.LeavesMain.Shape = "Block"
				tree.LeavesMain.Size = Vector3.new(14,14,14)
				tree.LeavesMain.PointLight:Destroy()
				for _,part in ipairs(tree:GetChildren()) do
					if part.Name == "Leaves" then
						part.Transparency = 0
					end
				end
			end
		end
		
		for _,obj in ipairs(game.Workspace:GetChildren()) do
				
			if obj.Name == "BasePlate" then
	
				obj.BrickColor = BrickColor.new(1021)
				obj.Texture.Transparency = 0.5
				obj.Texture.Texture = "http://www.roblox.com/asset/?id=173042836"
				obj.Material = "Grass"
					
			elseif obj.Name == "Window" then
					
				SnowFlakesEnabled(obj,false)
			elseif obj.Name == "DirveThroughWindow" then
					
				SnowFlakesEnabled(obj.Left.Window,false)
				SnowFlakesEnabled(obj.Right.Window,false)
				
			elseif string.sub(obj.Name,1,4) == "Snow" then
				obj.Parent = game.ServerStorage.SeasonalStorage.Snow
					
			elseif obj.Name == "PineTree" then
				obj.Parent = game.ServerStorage.SeasonalStorage.WinterPineTrees
						
			elseif obj.Name == "Beach" then
				obj.BrickColor = BrickColor.new("Nougat")
			end
		end
				





	elseif seasonName == "Summer" then
	
		for _,tree in ipairs(Trees) do
			local colors = {37,28,"Sea green","Camo","Shamrock","Parsley green","Forest green","Moss"}								
			local color = colors[math.random(1,#colors)]
			SetTreeColor(tree,192,color)
		end

		
		for _,obj in ipairs(game.Workspace:GetChildren()) do
			if obj.Name == "BasePlate" then
				obj.BrickColor = BrickColor.new(28)
				obj.Texture.Transparency = 1
				obj.Material = "Grass"
			end
		end
			








	elseif seasonName == "Fall" then
		
		for _,tree in ipairs(Trees) do
			local colors = {"Deep orange","Bright orange","Br. yellowish orange","Dark orange","Bright red"}
			local particleIds = {300827259,300827220,300827259,300827259,300827220}
			local particleColors = {Color.new(255,255,255),Color.new(255,255,255),Color.new(255,200,0),Color.new(168,90,80),Color.new(247,0,255)}
			local index = math.random(1,5)
						
			SetTreeColor(tree,192,colors[index])
						
						
			if tree.LeavesMain:FindFirstChild("LeafParticles") then tree.LeavesMain.LeafParticles:Destroy() end
			local particle = script.LeafParticles:clone()
			particle.Texture = "rbxassetid://" .. particleIds[index]
			particle.Color = ColorSequence.new(particleColors[index])
			particle.Parent = tree.LeavesMain
			particle.Enabled = true
		end

		--change tree color
		for _,obj in ipairs(game.Workspace:GetChildren()) do
			if obj.Name == "BasePlate" then
				obj.BrickColor = BrickColor.new("Dark orange")
				obj.Texture.Transparency = 0
				obj.Texture.Texture = "http://www.roblox.com/asset/?id=15518942"
				obj.Material = "Grass"		
			end
		end
		
		
		
		--wind blowing makes more leaves spawn
		spawn(function()
			while true do
				wait(math.random(10,30))
				local acceleration = Vector3.new(math.random(-2,2),0,math.random(-2,2))
				for _,tree in ipairs(Trees) do
					tree.LeavesMain.LeafParticles.Acceleration = acceleration
					tree.LeavesMain.LeafParticles.Rate = math.random(4,6)
						
				end
				wait(8,12)
				for _,tree in ipairs(Trees) do
					tree.LeavesMain.LeafParticles.Rate = math.random(1,10)/10
				end

			end
				
		end)
			
		
	
		
		
		
		
				
	elseif seasonName == "Winter" then

		
		Utility:SetParentOfChildren(game.ServerStorage.SeasonalStorage.Winter,workspace)
		
		for _,tree in ipairs(Trees) do
			SetTreeColor(tree,192,"Pearl")
							
			for _,part in ipairs(tree:GetChildren()) do
						
				if part.Name == "Leaves" then
					part.Transparency = 1
						
				elseif part.Name == "LeavesMain" then
					part.Shape = "Ball"
					part.Size = Vector3.new(18,18,18)
	
				end
			end
						
			if tree.LeavesMain:FindFirstChild("LeafParticles") then tree.LeavesMain.LeafParticles:Destroy() end
	
						
						
			if tree.LeavesMain:FindFirstChild("PointLight") then tree.LeavesMain.PointLight:Destroy() end
			local colors = {Color.new(0,255,0),Color.new(255,0,0),Color.new(0,0,255),Color.new(255,255,0),Color.new(0,255,255),Color.new(255,0,255)}
			local l = Instance.new("PointLight")
			l.Brightness= 1000
			l.Range = 20
			l.Color = colors[math.random(1,#colors)]
			l.Parent = tree.LeavesMain
			l.Enabled = false
		end
	

		
		for _,obj in ipairs(game.Workspace:GetChildren()) do
			if obj.Name == "BasePlate" then
	
				obj.BrickColor = BrickColor.new("Pearl")
				obj.Texture.Transparency = 1
				obj.Material = "Sand"
				
			elseif obj.Name == "Beach" then
				obj.BrickColor = BrickColor.new("Pearl")
					
			elseif obj.Name == "Window" then
					
				SnowFlakesEnabled(obj,true)
					
			elseif obj.Name == "DirveThroughWindow" then
					
				SnowFlakesEnabled(obj.Left.Window,true)
				SnowFlakesEnabled(obj.Right.Window,true)
			end
		end
		
		
	end
end


	


return Environment


