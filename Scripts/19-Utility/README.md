# Utility modules (formatting, tables, random, networking, rate limits, pools)

The small helpers every game carries around: number abbreviation (1.2M), commas, time and
countdown strings, table helpers, weighted random, object pools, remote wrappers and rate
limiters. Many games' utility folders turned out to be saveinstance/decompiler output (for
example `steal-a-brainrot` Utils, `steal-an-egg` Library/Functions, `rcu-roller` Functions,
`forsaken` Network), so only hand-written modules were copied. Popular libraries (Signal,
Promise, TableUtil, Janitor...) are already in `Scripts/Libraries/`. `_patterns/` has a complete
formatter, a validated + rate-limited remote wrapper, and a toolkit with weighted random,
cooldowns and an object pool.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| [NumberFormatter-Adaptive__needoh-escape.lua](NumberFormatter-Adaptive__needoh-escape.lua) | needoh-escape | Abbreviates numbers with a 100+ entry suffix list (k, M, B ... Ce), 2/1/0 decimals depending on size, trailing zeros stripped, %.2e fallback past the list. | Best plain formatter found. Floors the input first, so it is for whole numbers. |
| [FormatUtils-CommasTimeAbbrev__drill-and-mine.lua](FormatUtils-CommasTimeAbbrev__drill-and-mine.lua) | drill-and-mine | Three helpers: FormatNumber adds thousands commas, FormatTime gives mm:ss or h:mm:ss, Abbreviate gives 1.5M style text with a long suffix list. | Simple. FormatNumber works on tostring(), so floats and very large numbers (scientific notation) come out wrong. |
| [Suffixes-Truncating__rcu-roller.lua](Suffixes-Truncating__rcu-roller.lua) | rcu-roller | One-function abbreviator that FLOORS to N decimals instead of rounding, so 1999 shows 1.99K and never more money than the player has. | Good for currency displays; returns a number (not a string) below 1000. |
| [NumberUtility-TimersRoman__punching-simulator.lua](NumberUtility-TimersRoman__punching-simulator.lua) | punching-simulator | short() suffix formatter, decimal(), commas() via reverse+gsub, colon/short/long timer formats with auto unit choice, and roman numeral to/from (for tiers like 'Rebirth IV'). | Uses the game's _G._L loader only for the header; the table itself is standalone. |
| [NameCache__drill-and-mine.lua](NameCache__drill-and-mine.lua) | drill-and-mine | Tiny function that caches GetNameFromUserIdAsync results so boards and UIs do not call the web API repeatedly. | Drop-in. For many ids at once, UserService:GetUserInfosByUserIdsAsync is cheaper. |
| [TableUtility-Functional__punching-simulator.lua](TableUtility-Functional__punching-simulator.lua) | punching-simulator | Functional table helpers: all, once, filter, max/min by mapper, entries, match, length, map, sort, and deep set/get by path, deep compare and deep copy. | Handy path helpers (deep.set(t, {'a','b'}, v)) for nested player data. |
| [TableUtil-Small__aura-ascension.lua](TableUtil-Small__aura-ascension.lua) | aura-ascension | DeepCopy (keys too), ShallowCopy, ArrayToSet, SetToArray (sorted) and SanitizeKey. | The 5 helpers most games actually use; copy as is. |
| [RandomUtility-Weighted__punching-simulator.lua](RandomUtility-Weighted__punching-simulator.lua) | punching-simulator | chance(d) picks a key from a {key = weight} dictionary with a cumulative-weight roll. | Works, but pairs() order is not fixed and it makes a new Random each call; see _patterns/Toolkit.lua WeightedPicker. |
| [Pool-Simple__punching-simulator.lua](Pool-Simple__punching-simulator.lua) | punching-simulator | Minimal object pool: get() reuses a returned instance or clones the template, back() puts one back. | Shows the idea in 20 lines; add a max size and Parent = nil on return (Toolkit.Pool does). |
| [Network-Multiplexed__punching-simulator.lua](Network-Multiplexed__punching-simulator.lua) | punching-simulator | Network module that sends every call through ONE RemoteEvent/RemoteFunction with a name, plus the same API for bindables; Fired/Invoked return a disconnect function. | Neat API. Server handlers do unpack(args) on client data without type checks; validate inside your handlers. |
| [Core_Network-SafeBind__steal-an-egg.lua](Core_Network-SafeBind__steal-an-egg.lua) | steal-an-egg | Creates remotes on demand in one folder (asserting the class), wraps every handler in xpcall with a traceback, and returns a friendly error from failed RemoteFunctions instead of throwing to the client. | Short and safe; pair with argument checks and a rate limiter. |
| [RemoteBinder-PerService__aura-ascension.lua](RemoteBinder-PerService__aura-ascension.lua) | aura-ascension | Creates RF/RE folders per service on demand (Knit-style layout) and binds functions / fires events by service + name. | Lets non-Knit code talk to a Knit client. Change ServicesRoot if you do not use Knit. |
| [RateLimiter-PerKey__aura-ascension.lua](RateLimiter-PerKey__aura-ascension.lua) | aura-ascension | Allow(player, key, cooldown) returns false (and the time left) until the cooldown for that key has passed; Forget(player) on leave. | Tiny and correct. Call Forget in PlayerRemoving to avoid a slow memory leak. |
| [RemoteFallbacks-DevTool__rivals-modded.lua](RemoteFallbacks-DevTool__rivals-modded.lua) | rivals-modded | Gives every RemoteFunction that has no handler one that returns nil (so clients never hang forever) and logs the first calls to each remote with argument types. | Great while rebuilding or debugging a game; start it LAST, after every real service. |
| [_patterns/Format.lua](_patterns/Format.lua) | pattern (needoh-escape, rcu-roller, punching-simulator, drill-and-mine) | Abbreviate (rounding or truncating, carry 999.95K -> 1M), Commas, Clock, Short/Long durations, Ago, Percent, Odds ('1 in 2.5K'), Parse('2.5M'), Ordinal. | Shared module; same output on server and client. |
| [_patterns/Net.lua](_patterns/Net.lua) | pattern (aura-ascension, punching-simulator, steal-an-egg, rivals-modded) | Remote wrapper: server-created remotes in one folder, per-handler argument type schema (rejects NaN/inf/huge strings), token-bucket rate limit per player, pcall'd handlers, (ok, ...) replies. | Put in ReplicatedStorage; OnEvent/OnInvoke on the server, Send/Invoke/On on the client. |
| [_patterns/Toolkit.lua](_patterns/Toolkit.lua) | pattern (punching-simulator, rcu-roller, aura-ascension, steal-a-brainrot) | WeightedPicker with luck multiplier for rare entries and seeds, Cooldown/Debounce keyed by anything, and an object Pool with prewarm and max size. | Shared module; no dependencies. |

## Techniques seen across games

- **Two kinds of abbreviation**: rounding for stats (`needoh-escape`) and truncating for money (`rcu-roller`), so a player with 1,999 coins never sees '2K' and thinks they can afford a 2K item.
- **Strip trailing zeros and pick decimals by size** (1.25K, 12.5K, 125K) and fall back to scientific notation past the suffix list instead of printing 'nil'.
- **One place for remotes**: create them on the server on demand (`steal-an-egg` Core_Network, `aura-ascension` RemoteBinder) and wrap handlers in pcall/xpcall so one bad call does not kill the connection.
- **Rate-limit per player and per action** (`aura-ascension` RateLimiter) and validate argument types at the top of every handler; never `unpack` client tables blindly.
- **Never leave a RemoteFunction without a handler**: the client's InvokeServer waits forever (`rivals-modded` RemoteFallbacks).
- **Cache web lookups** (names, thumbnails) per UserId (`drill-and-mine` NameCache) instead of calling them per frame or per row.

## Things we did not copy (and why)

- Decompiled utility modules skipped: `steal-a-brainrot`/`evade`/`steal-a-brainrot-sab-files` Utils (NumberUtils, TableUtils, RandomUtils, MathUtils...), `steal-an-egg` Library/Functions (FormatAbbreviated, Debounce, RandomWeighted...) and Client/Network, `rcu-roller` SuffixToNumber/FormatUnix/Util, `aura-ascension` Math Utility, `forsaken` Network/Ratelimit, `rivals-modded` Utility, `catalogue-avatar-creator` ReplicaShared, `animal-hospital-*` Util, `slime-rng` UI formatters.
- Files with decompiler-style names (u1, p1, v1) but no header were also skipped: `big-paintball` NumberShorten/TimeString, `please-donate` NumberHelpers, `punching-simulator` TimeString, `murderers-vs-sheriffs` TimestampService.
- `murder-mystery-2` RbxUtility uses string.char byte lists; `bee-swarm-sim` DataStore2 Promise makes HttpService calls; `murder-mystery-2` Janitor uses getfenv. Not copied (and the clean Promise/Janitor are in `Scripts/Libraries/`).
- `gore-game` Network is the public EasyNetwork library and `doors` / `dandys-world` RateLimiter is Madwork's; libraries, not game code.
