# Leaderboards (global boards, leaderstats, number display)

Two kinds of leaderboard live here: global boards backed by an OrderedDataStore (top 50/100 on a
SurfaceGui, a #1 podium, friend and country boards) and the in-server `leaderstats` player list.
The interesting problems are all the same across games: how often to write, how to show players
in the server instantly, how to fit numbers bigger than 2^53 into an ordered store, how to rank
"fastest time" boards, and how to format values. `drill-and-mine` and `rivals-modded` are the
most complete; `_patterns/GlobalLeaderboard.lua` combines their ideas into one module.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| [LeaderboardService-PodiumAndTags__drill-and-mine.lua](LeaderboardService-PodiumAndTags__drill-and-mine.lua) | drill-and-mine | Config list of boards (store, value getter, formatter), SurfaceGui rows with headshots, a #1 podium dummy wearing the top player's avatar (rig scale kept), per-board rank attributes and a '[#3 Cash]' chat tag, playtime counter. | Very complete. Writes every player to every board every 30s; raise the interval or write only on change for big servers. |
| [LeaderboardService-LiveMerge__rivals-modded.lua](LeaderboardService-LiveMerge__rivals-modded.lua) | rivals-modded | Reads each board's top every minute, merges everyone in the server at their live value so a new win shows instantly, writes only values that changed, request cooldown and name validation on the client remote. | Clean and safe. Board names map to data fields in SOURCES; LeaderboardLibrary holds per-board options (ascending, size, store key). |
| [LeaderboardService-LogScale-Friends-Country__steal-a-brainrot.lua](LeaderboardService-LogScale-Friends-Country__steal-a-brainrot.lua) | steal-a-brainrot | Stores huge values as log(value)/log(1.0000001) so they fit an ordered store, a 12s read cache, a friends board (GetFriendsAsync + GetAsync per friend), a country board (LocalizationService) with an opt-out toggle. | Great ideas. The friends board does one GetAsync per friend per request; cache it or limit it before copying. |
| [LeaderboardService-SanitizeMerge__aura-ascension.lua](LeaderboardService-SanitizeMerge__aura-ascension.lua) | aura-ascension | Clamps values (NaN/inf/negative/too big) before writing, publishes only changed values on an interval, formats durations and big numbers, and merges cached global entries with live players before sorting. | Excerpt of a 1172-line board+podium service. Big-number helpers come from a LeaderboardShared module that was not copied (decompiled). |
| [LeaderboardController-FastestTime__needoh-escape.lua](LeaderboardController-FastestTime__needoh-escape.lua) | needoh-escape | Several boards from one config, including a best-time board that stores MAX_MS - timeMs so a descending sort shows the fastest run first, plus mm:ss.mmm and 1h 2m 3s formatters. | Simple and readable. GetSortedAsync(true, ...) would also work for ascending boards; inverting keeps one code path. |
| [LeaderboardService-Knit__rcu-roller.lua](LeaderboardService-Knit__rcu-roller.lua) | rcu-roller | Knit service that, for each board in a shared config, uploads online players, reads the top 100, attaches cached user infos (display name, verified badge) and fires one signal to clients. | Short and easy to adapt. Writes every player every minute regardless of change. |
| [GlobalLeaderboard-Basic__uno.lua](GlobalLeaderboard-Basic__uno.lua) | uno | The beginner version: GetSortedAsync top 50 into a SurfaceGui scroller with GetNameFromUserIdAsync, and SetAsync helpers with retry. | Good for learning. Retries forever with no cap and fetches names one by one. |
| [TimePlayedClass-RenanMSV__steal-a-brainrot.lua](TimePlayedClass-RenanMSV__steal-a-brainrot.lua) | steal-a-brainrot | Self-contained 'most time played' board class from RenanMSV's public model: settings module, score update and board refresh timers, username/thumbnail caches, optional dancing #1 rig. | Community model bundled in the game; a nice reference for a drop-in board object. Settings module sits next to it. |
| [DataHandler-OrderedStoreBackfill__escape-kitty-keyboard.lua](DataHandler-OrderedStoreBackfill__escape-kitty-keyboard.lua) | escape-kitty-keyboard | Writes Wins/XP/Rebirths to ordered stores on every save (math.floor to avoid ValueNotNumeric), a faster ordered-store-only update, and a one-time backfill of known players' saved data. | The flooring helper is useful. Keeping every known player id in ONE DataStore key will hit the 4MB limit in a popular game. |
| [Leaderstats-Abbreviated__aura-ascension.lua](Leaderstats-Abbreviated__aura-ascension.lua) | aura-ascension | Creates leaderstats with StringValue columns and fills them with FormatNumber text (1.2M) from the profile. | Tiny excerpt; MathUtility.FormatNumber is the game's formatter (see 19-Utility for formatters). |
| [LeaderStats-Mirror__forsaken.lua](LeaderStats-Mirror__forsaken.lua) | forsaken | Clones a leaderstats template and mirrors Money/KillerChance from the player's data folder with GetPropertyChangedSignal. | Shows the 'leaderstats is display only' idea in a few lines. |
| [leaderstats-Playtime__natural-disaster.lua](leaderstats-Playtime__natural-disaster.lua) | natural-disaster | Tutorial-style leaderstats Time counter that saves on leave and BindToClose. | Beginner reference only: GetAsync is not pcall'd and the loop errors if a player has no leaderstats yet. |
| [_patterns/GlobalLeaderboard.lua](_patterns/GlobalLeaderboard.lua) | pattern (rivals-modded, aura-ascension, steal-a-brainrot, needoh-escape, slime-rng, evade) | One ordered-store board: write-on-change with interval, keep-best UpdateAsync, ascending boards, log-encoded big numbers, daily/weekly period stores, live merge, batched names, OnUpdated callback, Abbreviate helper. | Create one per board and render entries yourself (SurfaceGui or remote). |
| [_patterns/LeaderstatsMirror.lua](_patterns/LeaderstatsMirror.lua) | pattern (aura-ascension, drill-and-mine, forsaken, steal-an-egg) | Builds leaderstats from getter functions and keeps it synced; numeric columns or abbreviated StringValue columns. | Keeps your data table the source of truth; leaderstats is display only. |

## Techniques seen across games

- **Merge live players into the stored top** (`rivals-modded`, `aura-ascension`) so the board updates the moment someone scores, while the ordered store is only read once a minute.
- **Write only when the value changed** (`rivals-modded` written cache, `aura-ascension` PublishedValues) instead of writing every player every refresh (`drill-and-mine`, `rcu-roller`).
- **Huge numbers**: ordered stores hold whole numbers and doubles lose precision past 2^53, so simulators store a log of the value (`steal-a-brainrot` LOG_BASE 1.0000001, aura-ascension EncodeBig) and decode for display.
- **Fastest-time boards** either sort ascending or store `MAX - time` (`needoh-escape`) so the same descending code works.
- **Make the top visible**: #1 podium rigs wearing the leader's avatar (`drill-and-mine`, `aura-ascension`, RenanMSV board), rank chat tags and overhead '#3' labels from rank attributes (`drill-and-mine`).
- **Cache names**: one batched `UserService:GetUserInfosByUserIdsAsync` call per refresh (`steal-a-brainrot`, `evade`) beats `GetNameFromUserIdAsync` per row (`uno`).

## Things we did not copy (and why)

- `slime-rng` LeaderboardTemplate / LongNum / Abbreviate and `aura-ascension` LeaderboardShared are saveinstance-decompiled; their ideas (period boards, big-number encoding) are rebuilt in `_patterns/GlobalLeaderboard.lua` instead.
- `murder-mystery-2` event leaderboards `require()` an asset id, and `street-life` Leaderstats makes outside HTTP calls; not copied.
- `big-paintball` MockOrderedDataStore is the public MockDataStoreService library.
