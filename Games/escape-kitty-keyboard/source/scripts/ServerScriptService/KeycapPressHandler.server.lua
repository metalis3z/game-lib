-- Keycap animation is handled entirely client-side via StarterPlayerScripts.KeycapAnimation
-- for zero-delay response. The server does NOT modify keycap CFrames to avoid
-- replication delay that would cause visible lag.

-- If server-side keycap logic is needed in the future (e.g. RemoteEvents for
-- other players to see animations), it can be added here.