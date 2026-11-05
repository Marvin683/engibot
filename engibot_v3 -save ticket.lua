--GhostMoney 1.3 by golden pan

local GhostMoney = rawget(_G, "GhostMoney")
if type(GhostMoney) == "table"
and GhostMoney.Internal
and type(GhostMoney.Internal.Shutdown) == "function" then
pcall(GhostMoney.Internal.Shutdown)
end
if type(GhostMoney) ~= "table" then GhostMoney = {} end
rawset(_G, "GhostMoney", GhostMoney)

GhostMoney.Meta = GhostMoney.Meta or {}
GhostMoney.Meta.version = "2.0-engi-buy-v67-pistol-upgrades"
GhostMoney.Meta.build = "2026-11-04"

GhostMoney.Runtime = {
gp_lastQueueLen = -1,
gp_partyLeaveLastTrigger = 0,
sniperUpgradeCompleted = false,
sniperUpgradeCompletedTime = 0,
teleporterJustUsed = false,
tpStickyArmed = false,
tpStickyServerIP = "",
tpLastAliveState = nil,
tpRespawnRearmPending = false,
tpForceRestoreAwaitRespawn = false,
tpForceModeEnabled = false,
tpHotkeyHoldStart = 0,
tpHotkeyHoldDown = false,
tpHotkeyHoldTriggered = false,
TP_FORCE_HOLD_SECONDS = 1.3,
forceSniperBuyModeEnabled = false,
sniperHotkeyHoldStart = 0,
sniperHotkeyHoldDown = false,
sniperHotkeyHoldTriggered = false,
SNIPER_FORCE_HOLD_SECONDS = 1.3,
forceSniperBuyZoneLatch = false,
forceSniperBuyLastTry = 0,
sniperIgnoreShortToggleUntil = 0,
sniperSkipNextShortToggle = false,
sniperBlockShortToggleOnRelease = false,
sniperReloadAwaitRespawn = false,
sniperReloadRespawnPending = false,
sniperLastAliveState = nil,
gpSniperBuyLoadRearmPending = false,
gpHadSniperBuyActiveOnLoad = false,
gpStickyAutoBuyEnabled = false,
gpStickyForceSniperBuyEnabled = false,
tpToggleSpawnLock = false,
tpNoTeleFallbackActive = false,
tpTeleporterSeenCount = 0,
tpFallbackWaitPopupShown = false,
TP_TELE_STABLE_SCANS = 8,
TP_WAIT_NOTIFY_INTERVAL = 7.0,
TP_STUCK_TIMEOUT = 10.0,
tpFallbackNextWaitNotify = 0,
tpIsWaitingForTeleporter = false,
tpWaitMoveWarnNext = 0,
tpWaitMoveWarnCount = 0,
tpToggleNeedsTrigger = false,
tpIgnoreShortToggleUntil = 0,
tpSkipNextShortToggle = false,
tpLastKnownClassName = nil,
tpLastForceToggleAt = 0,
tpReloadRestoreNormalPending = false,
tpWaitForRoundReload = false,
tpWaitForRoundReloadReason = "",
tpStuckTargetId = nil,
tpStuckLastProgressTime = 0,
tpStuckLastDistance = nil,
tpStuckKillCooldownUntil = 0,
tpUseVerifyActive = false,
tpUseVerifyStart = 0,
tpUseVerifyAnchor = nil,
tpUseVerifyTargetPos = nil,
tpUseVerifyKillCooldownUntil = 0,
}

local __GM_STATE = GhostMoney.Runtime
local __GM_PROXY_KEYS = {
["ALL_OFF_KEY"] = true,
["ALL_OFF_RESTORE_WINDOW"] = true,
["GP_CheckSniperUpgradeDone"] = true,
["GP_IN_BACK"] = true,
["GP_IN_FORWARD"] = true,
["GP_IN_JUMP"] = true,
["GP_IN_LEFT"] = true,
["GP_IN_MOVELEFT"] = true,
["GP_IN_MOVERIGHT"] = true,
["GP_IN_RIGHT"] = true,
["GP_IsSniper"] = true,
["GP_OnSniperUpgradesComplete"] = true,
["GP_PICK_KEYS"] = true,
["GP_RST"] = true,
["GP_RST_CONTEXT_SECONDS"] = true,
["GP_RST_FORCE_LOCK_SECONDS"] = true,
["GP_RST_FORCE_MAX_RETRIES"] = true,
["GP_RST_FORCE_RETRY_DELAY"] = true,
["GP_RST_QUEUE_DELAY"] = true,
["GP_RST_RESTART_COOLDOWN"] = true,
["GP_RST_SNIPER_AFTER_WAVE"] = true,
["GP_RST_VOTE_WINDOW_SECONDS"] = true,
["GP_SPAWN_SCAN_INTERVAL"] = true,
["GP_SPAWN_SIGN_RADIUS"] = true,
["GP_SPAWN_SIGN_SCAN_INTERVAL"] = true,
["IsInSpawnRoom"] = true,
["RELOAD_SPAWN_RADIUS"] = true,
["SNIPER_FORCE_HOLD_SECONDS"] = true,
["TP_FORCE_HOLD_SECONDS"] = true,
["TP_LOCK_FAILSAFE_SECONDS"] = true,
["TP_STUCK_TIMEOUT"] = true,
["TP_TELE_STABLE_SCANS"] = true,
["TP_WAITROUND_REARM_FAILSAFE_SECONDS"] = true,
["TP_WAIT_NOTIFY_INTERVAL"] = true,
["__keyNameCache"] = true,
["allOffRestoreSnapshot"] = true,
["allOffRestoreUntil"] = true,
["cashGenEntryCount"] = true,
["forceSniperBuyLastTry"] = true,
["forceSniperBuyModeEnabled"] = true,
["forceSniperBuyZoneLatch"] = true,
["gpF4LastApplied"] = true,
["gpF4PendingRejoinCycle"] = true,
["gpF4RequireTpForReady"] = true,
["gpHadSniperBuyActiveOnLoad"] = true,
["gpSniperBuyLoadRearmPending"] = true,
["gpSpawnAreaAnchors"] = true,
["gpSpawnAreaAnchorsMap"] = true,
["gpSpawnAreaNextRescan"] = true,
["gpSpawnSignAnchor"] = true,
["gpSpawnSignAnchorMap"] = true,
["gpSpawnSignNextScan"] = true,
["gpStickyAutoBuyEnabled"] = true,
["gpStickyForceSniperBuyEnabled"] = true,
["gp_lastQueueLen"] = true,
["gp_partyKillLastTrigger"] = true,
["gp_partyLeaveLastTrigger"] = true,
["reloadMoveLock"] = true,
["sniperBlockShortToggleOnRelease"] = true,
["sniperHotkeyHoldDown"] = true,
["sniperHotkeyHoldStart"] = true,
["sniperHotkeyHoldTriggered"] = true,
["sniperIgnoreShortToggleUntil"] = true,
["sniperLastAliveState"] = true,
["sniperReloadAwaitRespawn"] = true,
["sniperReloadRespawnPending"] = true,
["sniperSkipNextShortToggle"] = true,
["sniperUpgradeCompleted"] = true,
["sniperUpgradeCompletedTime"] = true,
["teleporterJustUsed"] = true,
["tpFallbackNextWaitNotify"] = true,
["tpFallbackWaitPopupShown"] = true,
["tpForceModeEnabled"] = true,
["tpForceRestoreAwaitRespawn"] = true,
["tpHotkeyHoldDown"] = true,
["tpHotkeyHoldStart"] = true,
["tpHotkeyHoldTriggered"] = true,
["tpIgnoreShortToggleUntil"] = true,
["tpIsWaitingForTeleporter"] = true,
["tpLastAliveState"] = true,
["tpLastForceToggleAt"] = true,
["tpLastKnownClassName"] = true,
["tpNoTeleFallbackActive"] = true,
["tpReloadMoveLockArmedAt"] = true,
["tpReloadRestoreNormalPending"] = true,
["tpRespawnRearmPending"] = true,
["tpSkipNextShortToggle"] = true,
["tpStickyArmed"] = true,
["tpStickyServerIP"] = true,
["tpStuckKillCooldownUntil"] = true,
["tpStuckLastDistance"] = true,
["tpStuckLastProgressTime"] = true,
["tpStuckTargetId"] = true,
["tpTeleporterSeenCount"] = true,
["tpToggleNeedsTrigger"] = true,
["tpToggleSpawnLock"] = true,
["tpToggleSpawnLockArmedAt"] = true,
["tpUseVerifyActive"] = true,
["tpUseVerifyAnchor"] = true,
["tpUseVerifyKillCooldownUntil"] = true,
["tpUseVerifyStart"] = true,
["tpUseVerifyTargetPos"] = true,
["tpWaitForRoundReload"] = true,
["tpWaitForRoundReloadArmedAt"] = true,
["tpWaitForRoundReloadReason"] = true,
["tpWaitMoveWarnCount"] = true,
["tpWaitMoveWarnNext"] = true,
}

GhostMoney.Internal = GhostMoney.Internal or {}
GhostMoney.Internal.proxyKeys = __GM_PROXY_KEYS

local __GM_CALLBACK_IDS = {
fireGameEvent = "ghostmoney_fire_event",
draw = "ghostmoney_draw",
engiDraw = "ghostmoney_engibuy_status",
createMove = "ghostmoney_create_move",
engiRouteMove = "ghostmoney_engi_route_move_last",
unload = "ghostmoney_unload",
thresholdCommand = "threshold_command",
uiResetCommand = "gp_gm_ui_reset_cmd",
engiRetry = "gp_gm_engi_retry_reset",
engiStatus = "gp_gm_engi_status_command",
engiSetupInput = "gp_gm_engi_setup_input_before",
dispatchUserMessage = "ghostmoney_dispatch_user_message",
gcSendMessage = "ghostmoney_gc_send_message",
gcRetrieveMessage = "ghostmoney_gc_retrieve_message",
}
GhostMoney.Internal.callbackIds = __GM_CALLBACK_IDS

local function __GM_UnregisterCallbacks()
if not (callbacks and callbacks.Unregister) then return end
pcall(callbacks.Unregister, "FireGameEvent", __GM_CALLBACK_IDS.fireGameEvent)
pcall(callbacks.Unregister, "Draw", __GM_CALLBACK_IDS.draw)
pcall(callbacks.Unregister, "Draw", __GM_CALLBACK_IDS.engiDraw)
pcall(callbacks.Unregister, "CreateMove", __GM_CALLBACK_IDS.createMove)
pcall(callbacks.Unregister, "CreateMove", __GM_CALLBACK_IDS.engiSetupInput)
pcall(callbacks.Unregister, "CreateMove", __GM_CALLBACK_IDS.engiRouteMove)
pcall(callbacks.Unregister, "Unload", __GM_CALLBACK_IDS.unload)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.thresholdCommand)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.uiResetCommand)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.engiRetry)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.engiStatus)
pcall(callbacks.Unregister, "DispatchUserMessage", __GM_CALLBACK_IDS.dispatchUserMessage)
pcall(callbacks.Unregister, "GCSendMessage", __GM_CALLBACK_IDS.gcSendMessage)
pcall(callbacks.Unregister, "GCRetrieveMessage", __GM_CALLBACK_IDS.gcRetrieveMessage)
end

local __GM_OLD_MT = getmetatable(_G)
local __GM_OLD_INDEX = __GM_OLD_MT and __GM_OLD_MT.__index or nil
local __GM_OLD_NEWINDEX = __GM_OLD_MT and __GM_OLD_MT.__newindex or nil

for k in pairs(__GM_PROXY_KEYS) do
rawset(_G, k, nil)
end

local function __gm_fallback_index(t, k)
if type(__GM_OLD_INDEX) == "function" then
return __GM_OLD_INDEX(t, k)
elseif type(__GM_OLD_INDEX) == "table" then
return __GM_OLD_INDEX[k]
end
return rawget(t, k)
end

local function __gm_fallback_newindex(t, k, v)
if type(__GM_OLD_NEWINDEX) == "function" then
return __GM_OLD_NEWINDEX(t, k, v)
elseif type(__GM_OLD_NEWINDEX) == "table" then
__GM_OLD_NEWINDEX[k] = v
return
end
rawset(t, k, v)
end

local __GM_NEW_MT = {}
if type(__GM_OLD_MT) == "table" then
for k, v in pairs(__GM_OLD_MT) do
__GM_NEW_MT[k] = v
end
end

__GM_NEW_MT.__index = function(t, k)
if __GM_PROXY_KEYS[k] then
return __GM_STATE[k]
end
return __gm_fallback_index(t, k)
end

__GM_NEW_MT.__newindex = function(t, k, v)
if __GM_PROXY_KEYS[k] then
__GM_STATE[k] = v
return
end
__gm_fallback_newindex(t, k, v)
end

pcall(setmetatable, _G, __GM_NEW_MT)

function GhostMoney.StateGet(key, fallback)
local v = __GM_STATE[key]
if v == nil then return fallback end
return v
end

function GhostMoney.StateSet(key, value)
if __GM_PROXY_KEYS[key] then
__GM_STATE[key] = value
return true
end
return false
end

function GhostMoney.StateSnapshot()
local snap = {}
for k in pairs(__GM_PROXY_KEYS) do
snap[k] = __GM_STATE[k]
end
return snap
end

local __GM_SHUTDOWN_DONE = false
function GhostMoney.Internal.Shutdown(skipCallbackUnregister)
if __GM_SHUTDOWN_DONE then return end
__GM_SHUTDOWN_DONE = true
if skipCallbackUnregister ~= true then
__GM_UnregisterCallbacks()
end
pcall(function()
if __GM_OLD_MT ~= nil then
setmetatable(_G, __GM_OLD_MT)
else
setmetatable(_G, nil)
end
end)
for k in pairs(__GM_PROXY_KEYS) do
rawset(_G, k, __GM_STATE[k])
end
end

function GP_CheckSniperUpgradeDone(_queueLen) end
function GP_OnSniperUpgradesComplete(_reason) end
GP_CLASS_NAME = {
[1] = "scout",
[2] = "sniper",
[3] = "soldier",
[4] = "demoman",
[5] = "medic",
[6] = "heavy",
[7] = "pyro",
[8] = "spy",
[9] = "engineer",
}
local function GP_GetClassId(me)
if not (me and me.GetPropInt) then return nil end
local ok, cls = pcall(me.GetPropInt, me, "m_iClass")
if not ok or type(cls) ~= "number" then return nil end
return cls
end
function GP_GetCurrentClassName(me)
local cls = GP_GetClassId(me)
if not cls then return nil end
return GP_CLASS_NAME[cls]
end
local config = {
transparentEnabled = false,
hideHotkeysInUI = false,
hideInfoPopups = false,
hideInfoOnLoad = false,
infoLoadSeenVersion = "",
changelogSeenVersion = "",
partyGpKillEnabled = false,
partyGpLeaveEnabled = false,
partyGpFixEnabled = false,
partyGpRetryEnabled = false,
partyGpVoteEnabled = false,
partyGpLeadEnabled = false,
partyVoteRevealEnabled = false,
partyVoteRevealOutput = "party",
partyAutoAcceptInvitesEnabled = false,
smartVoteEnabled = false,
forceFixWaveStartEnabled = false,
autoDisconnectEnabled = false,
autoFocusEnabled = false,
autoWalkEnabled = false,
autoBuyEnabled = false,
forceSniperBuyEnabled = false,
tpWalkEnabled = false,
forceTpWalkEnabled = false,
tpWalkMoveLockEnabled = false,
tpWalkWhitelistEnabled = false,
firstJoinPickMedic = false,
mvmReadyTpCycleEnabled = false,
instantRespawnEnabled = false,
autoCanteenEnabled = false,
all_off_key = KEY_X,
watermarkX = 10,
watermarkY = 10,
moneyThreshold = 6500,
changeClassEnabled = false,
targetClass = ""
}

-- On script load, select Engineer in LMAOBOX > Misc > Class Auto-Pick.
-- This changes the LMAOBOX setting; it does not immediately swap classes.
do
    local ok, err = pcall(function()
        assert(gui and type(gui.SetValue) == "function", "LMAOBOX gui.SetValue unavailable")
        gui.SetValue("Class Auto-Pick", "engineer")
    end)
    if not ok then
        print("[GhostMoney] Engineer Class Auto-Pick could not be set: " .. tostring(err))
    end
end

local GP_STEAMID64_BASE = 76561197960265728
local GP_PARTY_VOTE_REVEAL_ORANGE = "\x08FFA500FF"
local GP_PARTY_VOTE_REVEAL_GREEN = "\x089EE09EFF"
local GP_PARTY_VOTE_REVEAL_RED = "\x08FF6663FF"
local gpPartyAutoInviteLastAt = 0
local gpPartyAutoInviteLastSteam64 = ""
local gpPartyAutoInviteProbeReadAt = 0
local gpPartyAutoInviteProbeUntil = 0
local gpPartyAutoInviteProbeCooldownUntil = 0
local gpPartyAutoAcceptStatusAt = 0
local gpPartyFeatureLastLog = {}
local gpVoteRevealSeenCast = {}
local gpVoteRevealStarter = {}
local gpVoteRevealTarget = {}
local gpVoteRevealTargetName = {}
local gpVoteRevealClosedUntil = {}
local gpVoteRevealPendingCasts = {}
local gpVoteRevealReportedMissing = {}
local CFG_DIR = "gp_ghost"
local CFG_NAME = "gp_ghost_settings.cfg"
local GP_PARTY_INVITE_LOGFILE = "gp_party_invites.log"
local GP_PARTY_INVITE_LOGFILE_READ_PATHS = {
"C:/Program Files (x86)/Steam/steamapps/common/Team Fortress 2/tf/gp_party_invites.log",
"gp_party_invites.log",
"tf/gp_party_invites.log",
"../tf/gp_party_invites.log",
}
pcall(function()
if os and os.getenv then
local localAppData = os.getenv("LOCALAPPDATA")
if type(localAppData) == "string" and localAppData ~= "" then
local localInviteLog = localAppData:gsub("\\", "/") .. "/lua/gp_party_invites.log"
table.insert(GP_PARTY_INVITE_LOGFILE_READ_PATHS, 1, localInviteLog)
end
end
end)
local function GP_TryMkdir(d)
pcall(function() filesystem.CreateDirectory(d) end)
pcall(function() filesystem.CreateFolder(d) end)
pcall(function() file.CreateDirectory(d) end)
pcall(function() file.CreateFolder(d) end)
pcall(function() file.CreateDir(d) end)
pcall(function() file.CreatePath(d) end)
pcall(function() os.execute('mkdir "' .. d .. '"') end)
pcall(function() os.execute("mkdir " .. d) end)
end
function GP_CfgPath()
GP_TryMkdir(CFG_DIR)
return CFG_DIR .. "/" .. CFG_NAME
end
function IsManualMoveInput()
-- Do not let held W/A/S/D pause Engineer automation during the locked setup.
if GP_EB_SetupInputLocked and GP_EB_SetupInputLocked() then return false end
return input.IsButtonDown(KEY_W) or input.IsButtonDown(KEY_A) or input.IsButtonDown(KEY_S) or input.IsButtonDown(KEY_D)
end
function GP_IsTextInputOpen()
if not engine then return false end
local chatOpen = false
local conOpen = false
local menuOpen = false
if engine.IsChatOpen then
local ok, v = pcall(engine.IsChatOpen)
chatOpen = (ok and v == true)
end
if engine.Con_IsVisible then
local ok, v = pcall(engine.Con_IsVisible)
conOpen = (ok and v == true)
end
if engine.IsGameUIVisible then
local ok, v = pcall(engine.IsGameUIVisible)
menuOpen = (ok and v == true)
end
return chatOpen or conOpen or menuOpen
end
function GP_HasMoveIntent(cmd)
if GP_IsTextInputOpen() then return false end
if IsManualMoveInput() then return true end
if not cmd then return false end
local fwd = 0
local side = 0
local up = 0
if cmd.GetForwardMove then
local ok, v = pcall(cmd.GetForwardMove, cmd)
if ok and type(v) == "number" then fwd = v end
end
if cmd.GetSideMove then
local ok, v = pcall(cmd.GetSideMove, cmd)
if ok and type(v) == "number" then side = v end
end
if cmd.GetUpMove then
local ok, v = pcall(cmd.GetUpMove, cmd)
if ok and type(v) == "number" then up = v end
end
return (math.abs(fwd) > 1) or (math.abs(side) > 1) or (math.abs(up) > 1)
end
GP_IN_JUMP = 2
GP_IN_FORWARD = 8
GP_IN_BACK = 16
GP_IN_LEFT = 128
GP_IN_RIGHT = 256
GP_IN_MOVELEFT = 512
GP_IN_MOVERIGHT = 1024
-- Legacy APIs are harmless no-ops; movement locking was removed.
function GP_TP_IsMoveLockActive() return false end
function GP_TP_ApplyMovementLock(_cmd) return end
function GP_IsMvM()
local ok, v = pcall(function()
if gamerules then
if gamerules.IsMvM then return gamerules.IsMvM() end
if gamerules.IsMannVsMachine then return gamerules.IsMannVsMachine() end
if gamerules.IsMannVsMachineMode then return gamerules.IsMannVsMachineMode() end
end
return nil
end)
if ok and type(v) == "boolean" then return v end
local proxy = nil
local ok2 = pcall(function()
if entities and entities.FindByClass then
local t = entities.FindByClass("CTFGameRulesProxy")
if t and t[1] then proxy = t[1] end
end
end)
if ok2 and proxy and proxy.GetPropInt then
local ok3, p1 = pcall(function() return proxy:GetPropInt("m_bPlayingMannVsMachine") end)
if ok3 and type(p1) == "number" then
return p1 ~= 0
end
end
local ok4, bots = pcall(function()
if entities and entities.FindByClass then
return entities.FindByClass("CTFBot")
end
return nil
end)
if ok4 and bots and #bots > 0 then
return true
end
return false
end
__GP_LAST_COLOR = __GP_LAST_COLOR or {255, 255, 255, 255}
function __GP_ForceLastColor()
local r = tonumber(__GP_LAST_COLOR[1]) or 255
local g = tonumber(__GP_LAST_COLOR[2]) or 255
local b = tonumber(__GP_LAST_COLOR[3]) or 255
local a = tonumber(__GP_LAST_COLOR[4]) or 255
if a <= 0 then a = 1 end
if type(_GP_OrigDrawColor) == "function" then
pcall(_GP_OrigDrawColor, r, g, b, a)
else
pcall(draw.Color, r, g, b, a)
end
end
function SafeFilledRect(x1, y1, x2, y2)
local ok = pcall(draw.FilledRect, x1, y1, x2, y2)
if not ok then
__GP_ForceLastColor()
pcall(draw.FilledRect, x1, y1, x2, y2)
end
end

local function SafeText(x, y, s)
local ix, iy = math.floor(x + 0.5), math.floor(y + 0.5)
local ok = pcall(draw.Text, ix, iy, s)
if not ok then
__GP_ForceLastColor()
pcall(draw.Text, ix, iy, s)
end
end
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
hasTriedClassChange = false
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
pendingClassChange = false
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = 0
lastRetryTime = 0
RETRY_COOLDOWN = 5.0
local THRESHOLD_CLASSCHANGE_DELAY = 0.65
thresholdNotificationShown = false
classChangeSwapPopupShown = false
classChangeUsePreWaveRules = false
local acPostWaveSwapLatched = false
local lastExploitTime = 0
lastCleanupTime = 0
cleanupFlashUntil = 0
autoWalkPaused = false
autoWalkPauseReason = nil
lastAutoWalkPauseReason = nil
local COOLDOWN_TIME = 0.5
local UPGRADE_DELAY = 0.05
local SNIPER_COOLDOWN_TIME = 0.5
local SNIPER_UPGRADE_DELAY = 0.05
local SNIPER_RETRY_DELAY = 0.18
local SNIPER_TRIGGER_DEBOUNCE = 0.25
local SNIPER_MAX_RETRIES = 30
local sniperUpgradeCooldownUntil = 0
local MEDIC_TRIGGER_DEBOUNCE = 0.08
local MEDIC_MAX_RETRIES = 25
local medicTriggerDebounceUntil = 0
local SEQUENCE_END_COOLDOWN = 1.0
local nextUpgradeTime = 0
local sequenceEndTime = 0
upgradeQueue = {}
isExploiting = false
isUpgradingSniper = false
local lastSniperTriggerTime = 0
sniperUpgradesComplete = false
autobuyRunOnceDone = false
medicThresholdReached = false
gpPhase = "MEDIC_FARM"
autobuyDoneAnnounced = false
respawnExpected = false
currentServer = nil
local hadLocalPlayer = false
gpFirstJoinPickMedicPending = false
gpFirstJoinPickMedicDone = false
gpFirstJoinPickMedicUntil = 0
gpFirstJoinPickMedicForce = false
local gpFirstJoinPickMedicFallbackAt = 0
gpRetryJoinClassPending = nil
gpRetryJoinClassUntil = 0
gpRetryJoinClassNextTry = 0
local gpRetryJoinClassMustIssue = false
local gpManualRetrySuppressNextAttach = false
local gpInternalRetryCommandUntil = 0
local gpReconnectFeatureRearmClass = nil
local gpReconnectFeatureRearmAt = 0
local gpReconnectFeatureRearmUntil = 0
gpClassSelectCloseActive = false
gpClassSelectCloseNext = 0
gpClassSelectCloseUntil = 0
gpClassSelectCloseSlotCmd = nil
gpClassSelectCloseClassCmd = nil
gpClassSelectCloseClassNumCmd = nil
gpClassSelectCloseSlotAttempts = 0
gpClassSelectDebugLastNotifyAt = 0
gpClassSelectDebugSeq = 0
gpPartyVoteRetryActive = false
gpPartyVoteRetryOption = 0
gpPartyVoteRetryNext = 0
gpPartyVoteRetryUntil = 0
gpPartyVoteRetryAttempts = 0
local gpLoadedWhileConnected = false
do
local _ok, _ip = pcall(function()
return (engine and engine.GetServerIP and engine.GetServerIP()) or ""
end)
if _ok and type(_ip) == "string" and _ip ~= "" then
gpLoadedWhileConnected = true
end
end
local gpSuppressFirstJoinPickMedicOnAttach = gpLoadedWhileConnected
local lastCurTime = globals.CurTime() or 0
gpF4PendingRejoinCycle = false
gpF4RequireTpForReady = false
gpF4LastApplied = nil
gpF4Wave2FailPauseUntil = gpF4Wave2FailPauseUntil or 0
-- Auto Disconnect transplanted from GhostMoney_final_version(3).lua.
local GP_AutoDisconnectReset
do
    local function GP_AutoDisconnectInstall()
local GP_AUTO_DISCONNECT_JOIN_GRACE = 12.0
local GP_AUTO_DISCONNECT_CONFIRM_TIME = 2.5
-- Last-wave Pre-end Auto Disconnect: leave on the FINAL wave when this many
-- main-wave enemies remain. Tanks are also checked directly as CTFTankBoss entities.
local GP_AUTO_DISCONNECT_PREEND_REMAINING = 1
local gpAutoDisconnectTriggered = false
local gpAutoDisconnectEndSeenAt = 0
local gpAutoDisconnectGraceUntil = 0
local gpAutoDisconnectLiveSeen = false
local gpAutoDisconnectFinalWaveArmed = false
local gpAutoDisconnectLastRemaining = nil
local gpAutoDisconnectEventWave = nil
local gpAutoDisconnectEventMaxWaves = nil
local gpAutoDisconnectDebugLast = nil
local gpAutoDisconnectDirectNextAt = 0
local gpAutoDisconnectDirectRemaining = nil
local gpAutoDisconnectDirectBots = 0
local gpAutoDisconnectDirectTanks = 0
local function GP_AutoDisconnectNow()
local now = 0
pcall(function()
if globals and globals.RealTime then
now = globals.RealTime()
elseif globals and globals.CurTime then
now = globals.CurTime()
end
end)
return tonumber(now) or 0
end
-- Robust CTFObjectiveResource lookup. Some Lmaobox/TF2 builds do not return the
-- objective resource through FindByClass("CTFObjectiveResource"), so cache its
-- entity INDEX and fall back to scanning networked entities by GetClass()/props.
-- We cache only the index (not the Entity object) because Lmaobox warns that
-- Entity objects can become invalid over time.
local gpAutoDisconnectObjectiveIndex = nil
local gpAutoDisconnectObjectiveNextScanAt = 0
local gpAutoDisconnectObjectiveDebugKey = nil

local function GP_AutoDisconnectObjectivePrint(msg)
pcall(function() print("[GhostMoney AutoDisconnect] " .. tostring(msg)) end)
end

local function GP_AutoDisconnectObjectiveClass(ent)
if not (ent and ent.GetClass) then return nil end
local ok, cls = pcall(ent.GetClass, ent)
if ok and type(cls) == "string" then return cls end
return nil
end

local function GP_AutoDisconnectEntityIndex(ent)
if not (ent and ent.GetIndex) then return nil end
local ok, idx = pcall(ent.GetIndex, ent)
if ok then return tonumber(idx) end
return nil
end

local function GP_AutoDisconnectObjectiveLooksValid(ent)
if not ent then return false end
-- These props are unique/useful enough to validate the MvM objective resource.
local ok1, maxWave = pcall(function()
if ent.GetPropInt then return ent:GetPropInt("m_nMannVsMachineMaxWaveCount") end
return nil
end)
if ok1 and type(maxWave) == "number" then return true end
local ok2, counts = pcall(function()
if ent.GetPropDataTableInt then return ent:GetPropDataTableInt("m_nMannVsMachineWaveClassCounts") end
return nil
end)
if ok2 and type(counts) == "table" then return true end
return false
end

local function GP_AutoDisconnectRememberObjective(ent, how)
if not GP_AutoDisconnectObjectiveLooksValid(ent) then return nil end
local idx = GP_AutoDisconnectEntityIndex(ent)
if not idx then return nil end
gpAutoDisconnectObjectiveIndex = idx
local cls = GP_AutoDisconnectObjectiveClass(ent) or "?"
local key = tostring(idx) .. ":" .. tostring(cls) .. ":" .. tostring(how)
if gpAutoDisconnectObjectiveDebugKey ~= key then
gpAutoDisconnectObjectiveDebugKey = key
GP_AutoDisconnectObjectivePrint("objective resource found index=" .. tostring(idx)
.. " class=" .. tostring(cls) .. " via=" .. tostring(how))
end
return ent
end

local function GP_AutoDisconnectGetObjectiveResource()
if not entities then return nil end

-- Fast path: reacquire the cached entity by index every time.
if gpAutoDisconnectObjectiveIndex and entities.GetByIndex then
local ok, ent = pcall(entities.GetByIndex, gpAutoDisconnectObjectiveIndex)
if ok and ent and GP_AutoDisconnectObjectiveLooksValid(ent) then
return ent
end
gpAutoDisconnectObjectiveIndex = nil
end

-- Normal lookup, including common client/network class-name variants.
if entities.FindByClass then
local names = {"CTFObjectiveResource", "C_TFObjectiveResource", "TFObjectiveResource"}
for i = 1, #names do
local ok, list = pcall(entities.FindByClass, names[i])
if ok and type(list) == "table" then
for _, ent in pairs(list) do
local found = GP_AutoDisconnectRememberObjective(ent, "FindByClass:" .. names[i])
if found then return found end
end
end
end
end

-- Avoid doing a full entity scan every frame.
local now = GP_AutoDisconnectNow()
if now < (gpAutoDisconnectObjectiveNextScanAt or 0) then return nil end
gpAutoDisconnectObjectiveNextScanAt = now + 1.0

if not (entities.GetHighestEntityIndex and entities.GetByIndex) then return nil end
local okHigh, highest = pcall(entities.GetHighestEntityIndex)
highest = okHigh and tonumber(highest) or nil
if not highest or highest < 1 then return nil end

-- First scan by class name. This is cheap and catches renamed/client-prefixed classes.
for i = 1, highest do
local okEnt, ent = pcall(entities.GetByIndex, i)
if okEnt and ent then
local cls = GP_AutoDisconnectObjectiveClass(ent)
if cls and string.find(string.lower(cls), "objectiveresource", 1, true) then
local found = GP_AutoDisconnectRememberObjective(ent, "class-scan")
if found then return found end
end
end
end

-- Last resort: probe networked entities for the actual MvM props. This only runs
-- once per second while the objective resource is missing.
for i = 1, highest do
local okEnt, ent = pcall(entities.GetByIndex, i)
if okEnt and ent and GP_AutoDisconnectObjectiveLooksValid(ent) then
local found = GP_AutoDisconnectRememberObjective(ent, "prop-scan")
if found then return found end
end
end

if gpAutoDisconnectObjectiveDebugKey ~= "missing" then
gpAutoDisconnectObjectiveDebugKey = "missing"
GP_AutoDisconnectObjectivePrint("objective resource NOT FOUND; wavebar counters unavailable")
end
return nil
end
local function GP_AutoDisconnectReadInt(obj, prop)
if not (obj and obj.GetPropInt) then return nil end
local ok, v = pcall(obj.GetPropInt, obj, prop)
if ok and type(v) == "number" then return v end
return nil
end
local function GP_AutoDisconnectReadIntTable(obj, prop)
if not (obj and obj.GetPropDataTableInt) then return nil end
local ok, v = pcall(obj.GetPropDataTableInt, obj, prop)
if ok and type(v) == "table" then return v end
return nil
end
local function GP_AutoDisconnectCountMainWave(obj)
local mainTotal = 0
local rawTotal = 0
local sawAnyCount = false
local sawAnyFlag = false
local function addTable(countProp, flagProp)
local counts = GP_AutoDisconnectReadIntTable(obj, countProp)
local flags = GP_AutoDisconnectReadIntTable(obj, flagProp)
if type(counts) ~= "table" then return end
for idx, count in pairs(counts) do
local n = tonumber(count)
if n ~= nil then
sawAnyCount = true
if n > 0 then rawTotal = rawTotal + n end
local f = (type(flags) == "table") and tonumber(flags[idx]) or nil
if f ~= nil then
sawAnyFlag = true
-- MvM wavebar flag bit/value 1 marks MAIN WAVE. Extra bits (giant/crit)
-- can be combined with it, so odd values still mean main-wave.
if n > 0 and (f % 2) == 1 then
mainTotal = mainTotal + n
end
end
end
end
end
addTable("m_nMannVsMachineWaveClassCounts", "m_nMannVsMachineWaveClassFlags")
addTable("m_nMannVsMachineWaveClassCounts2", "m_nMannVsMachineWaveClassFlags2")
if sawAnyFlag then return math.max(0, mainTotal), "flagged_wavebar" end
if sawAnyCount then return math.max(0, rawTotal), "raw_wavebar" end
return nil, "unavailable"
end
local function GP_AutoDisconnectGetPreEndStatus()
local obj = GP_AutoDisconnectGetObjectiveResource()
if not obj then return nil, nil, nil, nil, nil, nil end
local wave = GP_AutoDisconnectReadInt(obj, "m_nMannVsMachineWaveCount")
local maxWave = GP_AutoDisconnectReadInt(obj, "m_nMannVsMachineMaxWaveCount")
local between = GP_AutoDisconnectReadInt(obj, "m_bMannVsMachineBetweenWaves")
local remaining, source = GP_AutoDisconnectCountMainWave(obj)
-- This is useful for diagnostics, but it is the total number of main-wave
-- enemies for the wave, not a trustworthy remaining-enemies counter.
local waveEnemyTotal = GP_AutoDisconnectReadInt(obj, "m_nMannVsMachineWaveEnemyCount")
return wave, maxWave, remaining, between, source, waveEnemyTotal
end

-- Entity fallback for the last enemy. Tanks are CTFTankBoss entities (tank_boss),
-- not player bots. Wavebar tables can fail to expose the last tank as count=1 on
-- some clients/servers, so we also look at actual live entities. This fallback is
-- conservative: support bots are counted too, so it cannot make us leave early.
local function GP_AutoDisconnectCountLiveEntities()
local seen = {}
local bots = 0
local tanks = 0
local function entityIndex(ent)
if not ent then return nil end
local idx = nil
pcall(function() if ent.GetIndex then idx = ent:GetIndex() end end)
return tonumber(idx)
end
local function alive(ent)
if not ent then return false end
local okAlive, isAlive = pcall(function()
if ent.IsAlive then return ent:IsAlive() end
return nil
end)
if okAlive and type(isAlive) == "boolean" then return isAlive end
local hp = nil
pcall(function() if ent.GetHealth then hp = ent:GetHealth() end end)
return type(hp) == "number" and hp > 0
end
local function addBot(ent)
if not ent or not alive(ent) then return end
local idx = entityIndex(ent)
if idx and seen[idx] then return end
local team = nil
pcall(function() if ent.GetTeamNumber then team = ent:GetTeamNumber() end end)
if type(team) == "number" and team ~= 3 then return end
-- If m_bIsABot exists, require it. CTFBot results generally already satisfy this.
local botFlag = nil
pcall(function() if ent.GetPropInt then botFlag = ent:GetPropInt("m_bIsABot") end end)
if type(botFlag) == "number" and botFlag == 0 then return end
if idx then seen[idx] = true end
bots = bots + 1
end
local function addTank(ent)
if not ent or not alive(ent) then return end
local idx = entityIndex(ent)
if idx and seen[idx] then return end
if idx then seen[idx] = true end
tanks = tanks + 1
end

pcall(function()
if entities and entities.FindByClass then
local list = entities.FindByClass("CTFBot")
if type(list) == "table" then for i = 1, #list do addBot(list[i]) end end
-- Some Lmaobox builds expose bots through CTFPlayer instead; unique indices avoid doubles.
local players = entities.FindByClass("CTFPlayer")
if type(players) == "table" then for i = 1, #players do addBot(players[i]) end end
local tankList = entities.FindByClass("CTFTankBoss")
if type(tankList) == "table" then for i = 1, #tankList do addTank(tankList[i]) end end
end
end)
return bots + tanks, bots, tanks
end
function GP_AutoDisconnectOnEvent(name, ev)
local lname = string.lower(tostring(name or ""))
if lname == "mvm_begin_wave" then
local idx = nil
local maxWaves = nil
pcall(function()
if ev and ev.GetInt then
idx = ev:GetInt("wave_index")
maxWaves = ev:GetInt("max_waves")
end
end)
if type(idx) == "number" and idx >= 0 and idx < 100 then
gpAutoDisconnectEventWave = idx + 1
else
local obj = GP_AutoDisconnectGetObjectiveResource()
gpAutoDisconnectEventWave = GP_AutoDisconnectReadInt(obj, "m_nMannVsMachineWaveCount")
end
if type(maxWaves) == "number" and maxWaves > 0 and maxWaves < 100 then
gpAutoDisconnectEventMaxWaves = maxWaves
else
local obj = GP_AutoDisconnectGetObjectiveResource()
gpAutoDisconnectEventMaxWaves = GP_AutoDisconnectReadInt(obj, "m_nMannVsMachineMaxWaveCount")
end
gpAutoDisconnectFinalWaveArmed = false
gpAutoDisconnectLastRemaining = nil
gpAutoDisconnectDebugLast = nil
pcall(function()
print("[GhostMoney AutoDisconnect] begin wave=" .. tostring(gpAutoDisconnectEventWave)
.. "/" .. tostring(gpAutoDisconnectEventMaxWaves))
end)
end
end
local function GP_AutoDisconnectLeave(message)
if gpAutoDisconnectTriggered then return true end
gpAutoDisconnectTriggered = true
pcall(function()
if gamecoordinator and gamecoordinator.AbandonMatch then
gamecoordinator.AbandonMatch()
end
end)
pcall(function()
if client and client.Command then
client.Command("disconnect", true)
end
end)
AddNotification(message or "Auto Disconnect triggered - abandoned and disconnected", "info")
return true
end
GP_AutoDisconnectReset = function(joinGrace)
gpAutoDisconnectTriggered = false
gpAutoDisconnectEndSeenAt = 0
gpAutoDisconnectLiveSeen = false
gpAutoDisconnectFinalWaveArmed = false
gpAutoDisconnectLastRemaining = nil
gpAutoDisconnectEventWave = nil
gpAutoDisconnectEventMaxWaves = nil
gpAutoDisconnectDebugLast = nil
gpAutoDisconnectDirectNextAt = 0
gpAutoDisconnectDirectRemaining = nil
gpAutoDisconnectDirectBots = 0
gpAutoDisconnectDirectTanks = 0
gpAutoDisconnectObjectiveIndex = nil
gpAutoDisconnectObjectiveNextScanAt = 0
gpAutoDisconnectObjectiveDebugKey = nil
if joinGrace == true then
gpAutoDisconnectGraceUntil = GP_AutoDisconnectNow() + GP_AUTO_DISCONNECT_JOIN_GRACE
end
end
function GP_AutoDisconnectTick()
if not (config and config.autoDisconnectEnabled == true) then
GP_AutoDisconnectReset(false)
return
end
local now = GP_AutoDisconnectNow()
if now < (gpAutoDisconnectGraceUntil or 0) then
gpAutoDisconnectEndSeenAt = 0
return
end
local me = nil
local serverIP = ""
local mapName = ""
pcall(function()
if entities and entities.GetLocalPlayer then me = entities.GetLocalPlayer() end
if engine and engine.GetServerIP then serverIP = engine.GetServerIP() or "" end
if engine and engine.GetMapName then mapName = engine.GetMapName() or "" end
end)
if not me or serverIP == "" or mapName == "" then
gpAutoDisconnectEndSeenAt = 0
return
end

-- LAST-WAVE PRE-END AUTO DISCONNECT v2 (robust objective-resource scan):
-- Use the mvm_begin_wave event/netvars to identify the FINAL wave, then count remaining
-- MAIN-WAVE icons from the wavebar tables. Tanks also have a direct entity fallback.
local wave, maxWave, remaining, between, remainingSource, waveEnemyTotal = GP_AutoDisconnectGetPreEndStatus()
local eventWave = tonumber(gpAutoDisconnectEventWave)
local eventMaxWaves = tonumber(gpAutoDisconnectEventMaxWaves)
local observedWave = eventWave or wave
local observedMaxWave = eventMaxWaves or maxWave
local threshold = tonumber(GP_AUTO_DISCONNECT_PREEND_REMAINING) or 2
local targetWaveActive = (type(observedWave) == "number")
and (type(observedMaxWave) == "number")
and (observedMaxWave > 0)
and (observedWave >= observedMaxWave)
and (between ~= 1)

if targetWaveActive then
-- Direct entity count is throttled to 10 Hz to keep this light even in a VM.
if now >= (gpAutoDisconnectDirectNextAt or 0) then
gpAutoDisconnectDirectNextAt = now + 0.10
local d, b, t = GP_AutoDisconnectCountLiveEntities()
gpAutoDisconnectDirectRemaining = d
gpAutoDisconnectDirectBots = b or 0
gpAutoDisconnectDirectTanks = t or 0
end
local directRemaining = tonumber(gpAutoDisconnectDirectRemaining)
local liveBots = tonumber(gpAutoDisconnectDirectBots) or 0
local liveTanks = tonumber(gpAutoDisconnectDirectTanks) or 0

-- Print low counts to the console so a failed test tells us exactly what TF2
-- exposed. This only prints when the wavebar value changes or when a tank is present.
local debugKey = tostring(remaining) .. ":" .. tostring(directRemaining) .. ":" .. tostring(liveTanks)
if ((type(remaining) == "number" and remaining <= threshold) or liveTanks > 0 or (directRemaining and directRemaining <= threshold))
and debugKey ~= gpAutoDisconnectDebugLast then
gpAutoDisconnectDebugLast = debugKey
pcall(function()
print("[GhostMoney AutoDisconnect] wave=" .. tostring(observedWave) .. "/" .. tostring(observedMaxWave)
.. " wavebar=" .. tostring(remaining) .. " source=" .. tostring(remainingSource)
.. " direct=" .. tostring(directRemaining) .. " bots=" .. tostring(liveBots)
.. " tanks=" .. tostring(liveTanks) .. " total=" .. tostring(waveEnemyTotal)
.. " between=" .. tostring(between))
end)
end

-- Primary path on the final wave: TF2's main-wave wavebar reaches the threshold.
if type(remaining) == "number" and remaining > 0 and remaining <= threshold then
GP_AutoDisconnectLeave(
"Auto Disconnect: final wave nearly complete (" .. tostring(remaining) .. " main-wave enemies left)"
)
return
end

-- Tank fix on the final wave: on some clients the wavebar can reach 0 while one live tank entity
-- still exists. If there are no wavebar main-wave bots left and exactly one tank
-- is alive, that tank is the last main-wave threat. Support bots do not matter.
if type(remaining) == "number" and remaining == 0 and liveTanks == 1 then
GP_AutoDisconnectLeave("Auto Disconnect: final wave nearly complete (last tank alive)")
return
end

-- Last-resort entity fallback: if the wavebar tables are unavailable/stuck but
-- the client can see exactly one live MvM enemy and it is a tank, leave. This is
-- conservative because support bots are included in directRemaining.
if liveTanks == 1 and directRemaining == 1 then
GP_AutoDisconnectLeave("Auto Disconnect: final wave nearly complete (last live tank detected)")
return
end

gpAutoDisconnectLastRemaining = remaining
else
gpAutoDisconnectFinalWaveArmed = false
gpAutoDisconnectLastRemaining = nil
gpAutoDisconnectDebugLast = nil
gpAutoDisconnectDirectRemaining = nil
gpAutoDisconnectDirectBots = 0
gpAutoDisconnectDirectTanks = 0
end

-- Existing end-of-match detection remains as a fallback in case the wavebar
-- counters are unavailable on a server/mission.
local inEnd = false
pcall(function()
if gamecoordinator and gamecoordinator.InEndOfMatch then
inEnd = (gamecoordinator.InEndOfMatch() == true)
end
end)
local hasLive = nil
pcall(function()
if gamecoordinator and gamecoordinator.HasLiveMatch then
hasLive = (gamecoordinator.HasLiveMatch() == true)
end
end)
local connectedToMatch = nil
pcall(function()
if gamecoordinator and gamecoordinator.IsConnectedToMatchServer then
connectedToMatch = (gamecoordinator.IsConnectedToMatchServer() == true)
end
end)
if connectedToMatch == false then
GP_AutoDisconnectReset(false)
return
end
if hasLive == true then
gpAutoDisconnectLiveSeen = true
end
if not inEnd then
gpAutoDisconnectEndSeenAt = 0
return
end
if hasLive ~= nil and gpAutoDisconnectLiveSeen ~= true then
gpAutoDisconnectEndSeenAt = 0
return
end
if (gpAutoDisconnectEndSeenAt or 0) <= 0 or now < (gpAutoDisconnectEndSeenAt or 0) then
gpAutoDisconnectEndSeenAt = now
return
end
if (now - (gpAutoDisconnectEndSeenAt or now)) < GP_AUTO_DISCONNECT_CONFIRM_TIME then
return
end
GP_AutoDisconnectLeave("Auto Disconnect fallback - abandoned and disconnected")
end
    end
    GP_AutoDisconnectInstall()
end
function GP_F4_IsFeatureEnabled()
return (config and config.mvmReadyTpCycleEnabled == true)
end
function GP_F4_SetGuiAutoReady(enabled, forceWrite)
if not GP_F4_IsFeatureEnabled() then return false end
local want = (enabled and true or false)
-- Rottenburg ONLY: never issue auto-F4 unless our own Dispenser is
-- physically deployed (not carried, a blueprint, or still building).
-- Failure to read the sensor is treated as NOT READY, not as a missing building.
if want then
    local okMap, mapName = pcall(function()
        return (engine and engine.GetMapName and engine.GetMapName()) or ""
    end)
    if okMap and type(mapName) == "string"
       and mapName:lower():find("mvm_rottenburg", 1, true) then
        local state = "unknown"
        if GP_EB_RottenburgDispenserState then
            local ok, value = pcall(GP_EB_RottenburgDispenserState)
            if ok then state = value end
        end
        if state ~= "up" then want = false end
    end
end

local function _f4Normalize(v)
local tv = type(v)
if tv == "boolean" then return v end
if tv == "number" then return (v ~= 0) end
if tv == "string" then
local sv = string.lower(v)
return (sv == "1") or (sv == "true") or (sv == "on") or (sv == "enabled")
end
return false
end

local curMatches = false
do
local okCur, curV = pcall(function()
if gui and gui.GetValue then
return gui.GetValue("mvm auto ready (f4)")
end
return nil
end)
if okCur and curV ~= nil then
curMatches = (_f4Normalize(curV) == want)
end
end

if (not forceWrite) and gpF4LastApplied ~= nil and gpF4LastApplied == want and curMatches then
return true
end

local ok = pcall(function()
if gui and gui.SetValue then
gui.SetValue("mvm auto ready (f4)", want and 1 or 0)
end
end)

if (not ok) then
ok = pcall(function()
if gui and gui.SetValue then
gui.SetValue("mvm auto ready (f4)", want and true or false)
end
end)
end

if ok then
gpF4LastApplied = want
return true
end
return false
end
function GP_F4_IsPreWave1State()
local preWave = false
if GP_IsMvM and GP_IsMvM() then
if GP_HasExplicitPreWave1Proof then
local ok, v = pcall(GP_HasExplicitPreWave1Proof)
preWave = (ok and v == true) or false
end
if not preWave then
local w = (GP_GetWaveNumber and GP_GetWaveNumber()) or nil
if type(w) == "number" and w <= 0 then
preWave = true
end
end
end
return preWave
end
function GP_F4_Sync(_reason, forceWrite)
if not GP_F4_IsFeatureEnabled() then return end
-- EngiBuy may need to suicide and purchase new upgrades between waves.
-- Do not start the next wave before the purchasing step has finished.
if GP_EB_HoldAutoReady and GP_EB_HoldAutoReady() then
    GP_F4_SetGuiAutoReady(false, forceWrite)
    return
end
if GP_IsMvM and (not GP_IsMvM()) then
GP_F4_SetGuiAutoReady(false, forceWrite)
return
end
local nowRT = GP_RST_Now and GP_RST_Now() or ((globals and globals.RealTime and globals.RealTime()) or 0)
local pauseUntil = (gpF4Wave2FailPauseUntil or 0)
if pauseUntil > 0 then
if nowRT < pauseUntil then
GP_F4_SetGuiAutoReady(false, true)
return
end
gpF4Wave2FailPauseUntil = 0
gpF4PendingRejoinCycle = false
gpF4RequireTpForReady = false
GP_F4_SetGuiAutoReady(true, true)
return
end
local preWave = GP_F4_IsPreWave1State()
local shouldOn = (not preWave) or (not gpF4RequireTpForReady)
GP_F4_SetGuiAutoReady(shouldOn, forceWrite)
end
function GP_F4_OnDisconnectCycle(_reason)
gpF4PendingRejoinCycle = true
gpF4RequireTpForReady = true
if GP_F4_IsFeatureEnabled() then
GP_F4_SetGuiAutoReady(false, true)
end
end
function GP_F4_OnJoinCycle(_reason)
if not GP_F4_IsFeatureEnabled() then return end
if gpF4PendingRejoinCycle then
gpF4RequireTpForReady = true
gpF4PendingRejoinCycle = false
GP_F4_SetGuiAutoReady(false, true)
return
end
local preWave = GP_F4_IsPreWave1State()
if preWave then
gpF4RequireTpForReady = true
GP_F4_SetGuiAutoReady(false, true)
else
gpF4RequireTpForReady = false
GP_F4_Sync("join_non_prewave", true)
end
end
function GP_F4_OnTpSuccess()
if not GP_F4_IsFeatureEnabled() then return end
if gpF4RequireTpForReady then
gpF4RequireTpForReady = false
gpF4PendingRejoinCycle = false
GP_F4_Sync("tp_success", true)
else
GP_F4_Sync("tp_success", false)
end
end
function GP_F4_OnFeatureToggle(enabled)
if enabled then
local preWave = GP_F4_IsPreWave1State()
gpF4PendingRejoinCycle = false
gpF4RequireTpForReady = (preWave and true or false)
GP_F4_Sync("feature_enable", true)
AddNotification("Smart AutoF4 Enabled - Pre Wave 1 waits till threshold or teleported", preWave and "warning" or "success", preWave and 4.8 or 3.8)
else
gpF4LastApplied = nil
AddNotification("Smart AutoF4 Disabled", "info", 3.5)
end
end
cashGenEntryCount = cashGenEntryCount or 0
autoModeWalkActive = false
local gpDropdown = {
want = nil,
state = nil,
anim = 0,
sliderDragging = false,
lastMouseDown = false,
openedCashThreshold = nil,
openedClassEnabled = nil,
openedClassTarget = nil
}
shouldGuidePlayer = false
midpoint = nil
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
SNIPER_BUY_WALK_TIMEOUT = 10.0
SNIPER_BUY_WALK_KILL_COOLDOWN = 4.0
sniperBuyWalkStartTime = 0
sniperBuyWalkKillCooldownUntil = 0
local AUTOBUY_SPAWN_RADIUS = 200
local IsInSpawnRoom
local function DistSqr(a, b)
local dx, dy, dz = a.x - b.x, a.y - b.y, a.z - b.z
return dx*dx + dy*dy + dz*dz
end
RELOAD_SPAWN_RADIUS = 200
gpSpawnAreaAnchors = {}
gpSpawnAreaAnchorsMap = ""
gpSpawnAreaNextRescan = 0
GP_SPAWN_SCAN_INTERVAL = 2.0
GP_SPAWN_SIGN_SCAN_INTERVAL = 1.0
GP_SPAWN_SIGN_RADIUS = 1200
gpSpawnSignAnchor = nil
gpSpawnSignAnchorMap = ""
gpSpawnSignNextScan = 0
function GP_RebuildSpawnAreaAnchors(force)
local now = 0
pcall(function()
if globals and globals.RealTime then now = globals.RealTime()
elseif globals and globals.CurTime then now = globals.CurTime() end
end)
local mapName = ""
pcall(function() mapName = engine.GetMapName() or "" end)
if (not force) and gpSpawnAreaAnchorsMap == mapName and now < (gpSpawnAreaNextRescan or 0) and #gpSpawnAreaAnchors > 0 then
return
end
gpSpawnAreaAnchors = {}
gpSpawnAreaAnchorsMap = mapName
gpSpawnAreaNextRescan = now + GP_SPAWN_SCAN_INTERVAL
local classes = {
"func_respawnroom",
"func_respawnroomvisualizer",
"info_player_teamspawn",
"info_player_spawn",
"CFuncRespawnRoom",
"CFuncRespawnRoomVisualizer",
"CInfoPlayerTeamspawn",
"CInfoPlayerSpawn",
"CTFPlayerStart"
}
for _, cls in ipairs(classes) do
local okList, list = pcall(function()
if entities and entities.FindByClass then
return entities.FindByClass(cls)
end
return nil
end)
if okList and list then
for i = 1, #list do
local ent = list[i]
if ent and ent.GetAbsOrigin then
local okPos, pos = pcall(ent.GetAbsOrigin, ent)
if okPos and pos then
local team = nil
if ent.GetTeamNumber then
pcall(function() team = ent:GetTeamNumber() end)
end
if (not team or team <= 0) and ent.GetPropInt then
pcall(function() team = ent:GetPropInt("m_iTeamNum") end)
end
gpSpawnAreaAnchors[#gpSpawnAreaAnchors + 1] = { pos = pos, team = team }
end
end
end
end
end
if (#gpSpawnAreaAnchors == 0) and entities and entities.GetHighestEntityIndex and entities.GetByIndex then
local highest = entities.GetHighestEntityIndex() or 2048
for i = 0, highest do
local ent = entities.GetByIndex(i)
if ent and ent.GetClass and ent.GetAbsOrigin then
local okClass, className = pcall(ent.GetClass, ent)
if okClass and className then
local c = string.lower(tostring(className))
local looksSpawn = string.find(c, "respawn", 1, true)
or string.find(c, "teamspawn", 1, true)
or string.find(c, "player_spawn", 1, true)
or string.find(c, "playerstart", 1, true)
if looksSpawn then
local okPos, pos = pcall(ent.GetAbsOrigin, ent)
if okPos and pos then
local team = nil
if ent.GetTeamNumber then
pcall(function() team = ent:GetTeamNumber() end)
end
if (not team or team <= 0) and ent.GetPropInt then
pcall(function() team = ent:GetPropInt("m_iTeamNum") end)
end
gpSpawnAreaAnchors[#gpSpawnAreaAnchors + 1] = { pos = pos, team = team }
end
end
end
end
end
end
end
function GP_UpdateSpawnSignAnchor(me, force)
if not me then return gpSpawnSignAnchor end
local now = 0
pcall(function()
if globals and globals.RealTime then now = globals.RealTime()
elseif globals and globals.CurTime then now = globals.CurTime() end
end)
local mapName = ""
pcall(function() mapName = engine.GetMapName() or "" end)
if (not force) and gpSpawnSignAnchor and gpSpawnSignAnchorMap == mapName and now < (gpSpawnSignNextScan or 0) then
return gpSpawnSignAnchor
end
gpSpawnSignAnchor = nil
gpSpawnSignAnchorMap = mapName
gpSpawnSignNextScan = now + GP_SPAWN_SIGN_SCAN_INTERVAL
if not (entities and entities.GetHighestEntityIndex and entities.GetByIndex and models and models.GetModelName) then
return nil
end
local myPos = nil
if me.GetAbsOrigin then
local okMy, posMy = pcall(me.GetAbsOrigin, me)
if okMy then myPos = posMy end
end
local signs = {}
local highest = entities.GetHighestEntityIndex() or 2048
for i = 0, highest do
local ent = entities.GetByIndex(i)
if ent and ent.GetClass and ent.GetModel and ent.GetAbsOrigin then
local okClass, className = pcall(ent.GetClass, ent)
if okClass and className == "CDynamicProp" then
local mdl = nil
pcall(function() mdl = models.GetModelName(ent:GetModel()) end)
if mdl == "models/props_mvm/mvm_upgrade_sign.mdl" then
local okPos, pos = pcall(ent.GetAbsOrigin, ent)
if okPos and pos then
signs[#signs + 1] = pos
end
end
end
end
end
if #signs == 0 then
return nil
end
if myPos and #signs >= 2 then
table.sort(signs, function(a, b) return DistSqr(a, myPos) < DistSqr(b, myPos) end)
local p1 = signs[1]
local p2 = signs[2]
gpSpawnSignAnchor = Vector3((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2)
return gpSpawnSignAnchor
end
gpSpawnSignAnchor = signs[1]
return gpSpawnSignAnchor
end
function GP_IsInSpawnRadiusArea(player, radius)
if not player or not player.GetAbsOrigin then return false end
GP_RebuildSpawnAreaAnchors(false)
local okPos, myPos = pcall(player.GetAbsOrigin, player)
if not okPos or not myPos then return false end
local myTeam = nil
if player.GetTeamNumber then
pcall(function() myTeam = player:GetTeamNumber() end)
end
if (not myTeam or myTeam <= 0) and player.GetPropInt then
pcall(function() myTeam = player:GetPropInt("m_iTeamNum") end)
end
local r = radius or RELOAD_SPAWN_RADIUS
local r2 = r * r
if gpSpawnAreaAnchors and #gpSpawnAreaAnchors > 0 then
for i = 1, #gpSpawnAreaAnchors do
local a = gpSpawnAreaAnchors[i]
if a and a.pos then
local t = a.team
local teamOk = (not t) or (t <= 1) or (not myTeam) or (t == myTeam)
if teamOk and DistSqr(myPos, a.pos) <= r2 then
return true
end
end
end
end
local signAnchor = GP_UpdateSpawnSignAnchor(player, false)
if signAnchor then
local signR = GP_SPAWN_SIGN_RADIUS or 1200
if DistSqr(myPos, signAnchor) <= (signR * signR) then
return true
end
end
return false
end
function IsInSniperBuySpawnArea(player)
if not player then return false end
if IsInSpawnRoom and IsInSpawnRoom(player) then
buySpawnAnchor = player:GetAbsOrigin()
return true
end
if GP_IsInSpawnRadiusArea(player, AUTOBUY_SPAWN_RADIUS) then
if not buySpawnAnchor then
buySpawnAnchor = player:GetAbsOrigin()
end
return true
end
if buySpawnAnchor then
local pos = player:GetAbsOrigin()
return DistSqr(pos, buySpawnAnchor) <= (AUTOBUY_SPAWN_RADIUS * AUTOBUY_SPAWN_RADIUS)
end
return false
end
function IsInAutoCreditSpawnArea(player)
if not player then return false end
if IsInSpawnRoom and IsInSpawnRoom(player) then
medicSpawnAnchor = player:GetAbsOrigin()
return true
end
if GP_IsInSpawnRadiusArea(player, AUTOBUY_SPAWN_RADIUS) then
if not medicSpawnAnchor then
medicSpawnAnchor = player:GetAbsOrigin()
end
return true
end
if medicSpawnAnchor then
local pos = player:GetAbsOrigin()
return DistSqr(pos, medicSpawnAnchor) <= (AUTOBUY_SPAWN_RADIUS * AUTOBUY_SPAWN_RADIUS)
end
return false
end
-- Removed in v24: credit threshold handler
lastToggleTime = 0
local suppressToggleUntil = 0
TOGGLE_COOLDOWN = 0.2
WALK_KEY = KEY_L
CLEAN_KEY = KEY_K
AUTO_KEY = KEY_J
TP_KEY = KEY_O
ALL_OFF_KEY = KEY_X
ALL_OFF_RESTORE_WINDOW = 60.0
allOffRestoreSnapshot = nil
allOffRestoreUntil = 0
TELEPORTER_AUTOWALK_DELAY = 1.0
TP_TELE_STOP_DISTANCE = 67
TP_TELE_WAIT_STOP_DISTANCE = 67
TP_ENDPOINT_TELE_RADIUS = 650
local TP_TELE_USE_VERIFY_SECONDS = 10.0
local TP_TELE_USE_SUCCESS_DISTANCE = 180
local TP_TELE_VERIFY_TARGET_LEAVE_DISTANCE = 120
tpLastReachedTeleporterAt = 0
teleporterConfig = {
scanEnabled = true,
maxScanDistance = 10000,
showOnlyFriendly = true,
autoWalkEnabled = false,
walkSpeed = 450
}
reloadMoveLock = true
tpReloadMoveLockArmedAt = (globals and globals.CurTime and globals.CurTime()) or 0
tpToggleSpawnLockArmedAt = 0
tpWaitForRoundReloadArmedAt = 0
TP_LOCK_FAILSAFE_SECONDS = TP_LOCK_FAILSAFE_SECONDS or 6.0
TP_WAITROUND_REARM_FAILSAFE_SECONDS = TP_WAITROUND_REARM_FAILSAFE_SECONDS or 12.0
function GP_ArmReloadMoveLock()
reloadMoveLock = true
tpReloadMoveLockArmedAt = (globals and globals.CurTime and globals.CurTime()) or 0
gpSpawnAreaAnchors = {}
gpSpawnAreaAnchorsMap = ""
gpSpawnAreaNextRescan = 0
gpSpawnSignAnchor = nil
gpSpawnSignAnchorMap = ""
gpSpawnSignNextScan = 0
shouldGuidePlayer = false
midpoint = nil
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
teleporterConfig.autoWalkEnabled = false
end
function GP_IsReloadMoveUnlocked(me)
if not me or not me.IsAlive or (not me:IsAlive()) then
return false
end
if not reloadMoveLock then
tpReloadMoveLockArmedAt = 0
return true
end
local now = (globals and globals.CurTime and globals.CurTime()) or 0
if (tpReloadMoveLockArmedAt or 0) <= 0 then
tpReloadMoveLockArmedAt = now
end
local inSpawn = false
if IsInSpawnRoom then
local okSpawn, vSpawn = pcall(IsInSpawnRoom, me)
inSpawn = (okSpawn and vSpawn == true)
end
local inZone = false
if me.GetPropInt then
local okZone, vZone = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
inZone = (okZone and vZone == 1)
end
local okRadius, vRadius = pcall(GP_IsInSpawnRadiusArea, me, RELOAD_SPAWN_RADIUS)
local inSpawnRadius = (okRadius and vRadius == true)
if inSpawn or inZone or inSpawnRadius then
reloadMoveLock = false
tpReloadMoveLockArmedAt = 0
return true
end
if (now - (tpReloadMoveLockArmedAt or now)) >= (TP_LOCK_FAILSAFE_SECONDS or 6.0) then
reloadMoveLock = false
tpReloadMoveLockArmedAt = 0
return true
end
return false
end
function GP_TP_IsSpawnContextNow(me)
if not me then return false end
local inSpawn = false
if IsInSpawnRoom then
local okSpawn, vSpawn = pcall(IsInSpawnRoom, me)
inSpawn = (okSpawn and vSpawn == true)
end
local inZone = false
if me.GetPropInt then
local okZone, vZone = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
inZone = (okZone and vZone == 1)
end
local okRadius, vRadius = pcall(GP_IsInSpawnRadiusArea, me, RELOAD_SPAWN_RADIUS)
local inSpawnRadius = (okRadius and vRadius == true)
return (inSpawn or inZone or inSpawnRadius)
end
function GP_TP_ArmSpawnToggleLock()
tpToggleSpawnLock = true
tpToggleSpawnLockArmedAt = (globals and globals.CurTime and globals.CurTime()) or 0
teleporterConfig.autoWalkEnabled = false
end
function GP_TP_IsToggleSpawnUnlocked(me)
if not tpToggleSpawnLock then
tpToggleSpawnLockArmedAt = 0
return true
end
local now = (globals and globals.CurTime and globals.CurTime()) or 0
if (tpToggleSpawnLockArmedAt or 0) <= 0 then
tpToggleSpawnLockArmedAt = now
end
if GP_TP_IsSpawnContextNow(me) then
tpToggleSpawnLock = false
tpToggleSpawnLockArmedAt = 0
return true
end
local alive = false
if me and me.IsAlive then
local okAlive, vAlive = pcall(me.IsAlive, me)
alive = (okAlive and vAlive == true)
end
if alive and (now - (tpToggleSpawnLockArmedAt or now)) >= (TP_LOCK_FAILSAFE_SECONDS or 6.0) then
tpToggleSpawnLock = false
tpToggleSpawnLockArmedAt = 0
return true
end
return false
end
foundTeleporters = {}
local tpPathSelected = false
tpCurrentPathIndex = nil
local tpCurrentPathWaypointIndex = 1
local tpUsingPredefinedPath = false
local tpLOSDetectedTime = 0
local tpLOSDelay = 1.0
teleporterManuallyDisabled = false
teleporterScanInterval = 0.35
nextTeleporterScanTime = 0
lastTpClassWarnTime = 0
mapPaths = {
["maps/mvm_mannhattan.bsp"] = {
{
{x = 246.57, y = 2350.02, z = -159.97},
{x = 426.71, y = 2343.59, z = -159.97},
{x = 465.11, y = 2201.82, z = -159.97},
{x = 465.23, y = 2199.62, z = -159.97},
{x = 465.34, y = 2197.45, z = -159.97},
{x = 462.59, y = 2047.58, z = -159.97},
{x = 282.40, y = 2033.19, z = -147.94},
{x = 279.63, y = 2033.27, z = -147.94},
{x = 128.87, y = 2038.56, z = -159.97},
{x = 127.16, y = 2038.62, z = -159.97},
{x = -12.44, y = 1890.93, z = -159.97}
},
{
{x = -337.60, y = 2379.35, z = -159.97},
{x = -510.33, y = 2372.52, z = -159.97},
{x = -519.99, y = 2208.79, z = -159.97},
{x = -519.95, y = 2207.23, z = -159.97},
{x = -519.90, y = 2205.39, z = -159.97},
{x = -513.53, y = 2039.08, z = -159.97},
{x = -340.88, y = 2030.59, z = -159.97},
{x = -134.46, y = 2018.24, z = -159.97},
{x = -132.56, y = 2018.22, z = -159.97},
{x = -130.88, y = 2018.20, z = -159.97},
{x = -15.76, y = 1814.91, z = -159.97}
}
},
["maps/mvm_rottenburg.bsp"] = {
{
{x = -1174.54, y = 2397.37, z = -127.97},
{x = -760.03, y = 2161.80, z = -127.97},
{x = -1127.16, y = 1730.38, z = -169.79},
{x = -1084.47, y = 1275.69, z = -170.00}
},
{
{x = -1507.05, y = 669.63, z = -167.97},
{x = -1530.55, y = 1126.37, z = -169.98},
{x = -1084.47, y = 1275.69, z = -170.00}
}
}
}
-- Removed in v24: hotkey mapping
function SaveConfig(_filename, _cfg) return true end
local function LoadConfig(_filename) return nil end
local loadedConfig = nil
gpHadActiveTogglesOnLoad = false
if loadedConfig then
gpHadActiveTogglesOnLoad =
(loadedConfig.autoWalkEnabled == true)
or (loadedConfig.autoBuyEnabled == true)
or (loadedConfig.forceSniperBuyEnabled == true)
or (loadedConfig.tpWalkEnabled == true)
or (loadedConfig.forceTpWalkEnabled == true)
gpHadSniperBuyActiveOnLoad =
(loadedConfig.autoBuyEnabled == true)
gpSniperBuyLoadRearmPending = gpHadSniperBuyActiveOnLoad
for k, v in pairs(loadedConfig) do
config[k] = v
end
-- Existing users with an automatic SniperBuy class target now change into Engineer.
if (config.autoBuyEnabled == true or config.forceSniperBuyEnabled == true) and config.targetClass == "sniper" then
    config.targetClass = "engineer"
end
if type(config.walk_key)=="number" then WALK_KEY=config.walk_key end
if type(config.clean_key)=="number" then CLEAN_KEY=config.clean_key end
if type(config.auto_key)=="number" then AUTO_KEY=config.auto_key end
if type(config.tp_key)=="number" then TP_KEY=config.tp_key end
if type(config.all_off_key)=="number" then ALL_OFF_KEY=config.all_off_key end
tpForceModeEnabled = (config.forceTpWalkEnabled == true)
forceSniperBuyModeEnabled = (config.forceSniperBuyEnabled == true)
if tpForceModeEnabled then
config.tpWalkEnabled = false
tpStickyArmed = true
tpForceRestoreAwaitRespawn = true
tpRespawnRearmPending = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
end
if (not tpForceModeEnabled) and (config.tpWalkEnabled == true) then
tpReloadRestoreNormalPending = true
tpToggleNeedsTrigger = true
tpRespawnRearmPending = false
tpToggleSpawnLock = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
end
end
if config.forceTpWalkEnabled == nil then config.forceTpWalkEnabled = false end
if tpForceModeEnabled == nil then tpForceModeEnabled = false end
if config.forceSniperBuyEnabled == nil then config.forceSniperBuyEnabled = false end
if forceSniperBuyModeEnabled == nil then forceSniperBuyModeEnabled = false end
if config.hideHotkeysInUI == nil then config.hideHotkeysInUI = false end
if config.hideInfoPopups == nil then config.hideInfoPopups = false end
if config.hideInfoOnLoad == nil then config.hideInfoOnLoad = false end
if config.infoLoadSeenVersion == nil then config.infoLoadSeenVersion = "" end
if config.changelogSeenVersion == nil then config.changelogSeenVersion = "" end
if config.partyGpKillEnabled == nil then config.partyGpKillEnabled = false end
if config.partyGpLeaveEnabled == nil then config.partyGpLeaveEnabled = false end
if config.partyGpFixEnabled == nil then config.partyGpFixEnabled = false end
if config.partyGpRetryEnabled == nil then config.partyGpRetryEnabled = false end
if config.partyGpVoteEnabled == nil then config.partyGpVoteEnabled = false end
if config.partyGpLeadEnabled == nil then config.partyGpLeadEnabled = false end
if config.partyVoteRevealEnabled == nil then config.partyVoteRevealEnabled = false end
if config.partyVoteRevealOutput ~= "local" and config.partyVoteRevealOutput ~= "party" then config.partyVoteRevealOutput = "party" end
if config.partyAutoAcceptInvitesEnabled == nil then config.partyAutoAcceptInvitesEnabled = false end
if config.smartVoteEnabled == nil then config.smartVoteEnabled = false end
if config.forceFixWaveStartEnabled == nil then config.forceFixWaveStartEnabled = false end
if config.autoDisconnectEnabled == nil then config.autoDisconnectEnabled = false end
if config.autoFocusEnabled == nil then config.autoFocusEnabled = false end
if config.tpWalkMoveLockEnabled == nil then config.tpWalkMoveLockEnabled = false end
if config.tpWalkWhitelistEnabled == nil then config.tpWalkWhitelistEnabled = false end
if config.firstJoinPickMedic == nil then config.firstJoinPickMedic = false end
if config.mvmReadyTpCycleEnabled == nil then config.mvmReadyTpCycleEnabled = false end
if config.instantRespawnEnabled == nil then config.instantRespawnEnabled = false end
if config.autoCanteenEnabled == nil then config.autoCanteenEnabled = false end
if type(ALL_OFF_KEY) ~= "number" then ALL_OFF_KEY = KEY_X end
if type(config.all_off_key) ~= "number" then config.all_off_key = ALL_OFF_KEY end
if tpForceModeEnabled then
tpStickyArmed = true
end
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
gpStickyForceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config.forceSniperBuyEnabled == true)

-- HEADLESS DEFAULTS: remaining user-facing features are enabled at startup.
-- Removed functionality remains inaccessible, even with an old config file.
local HEADLESS_ON = {
    autoBuyEnabled=true,                -- EngiBuy
    tpWalkEnabled=true,                 -- Engineer-only TpWalk
    mvmReadyTpCycleEnabled=true,        -- Smart AutoF4
    instantRespawnEnabled=true,
    autoDisconnectEnabled=true,
    partyGpKillEnabled=true,
    partyGpLeaveEnabled=true,
    partyGpFixEnabled=true,
    partyGpRetryEnabled=true,
    partyGpVoteEnabled=true,
    partyGpLeadEnabled=true,
    smartVoteEnabled=true,
    partyAutoAcceptInvitesEnabled=true,
}
local HEADLESS_OFF = {
    autoWalkEnabled=true,               -- AutoCredit
    forceSniperBuyEnabled=true,         -- NoWalk EngiBuy
    forceTpWalkEnabled=true,            -- All Class TpWalk
    tpWalkMoveLockEnabled=true,         -- Lock TpWalking
    tpWalkWhitelistEnabled=true,
    firstJoinPickMedic=true,
    autoCanteenEnabled=true,
    autoFocusEnabled=true,
    forceFixWaveStartEnabled=true,
    partyVoteRevealEnabled=true,
    changeClassEnabled=true,
    transparentEnabled=true,
}
for k in pairs(HEADLESS_ON) do config[k]=true end
for k in pairs(HEADLESS_OFF) do config[k]=false end
config.targetClass="engineer"
config.hideInfoPopups=true
forceSniperBuyModeEnabled=false
 tpForceModeEnabled=false
 gpStickyAutoBuyEnabled=true
 gpStickyForceSniperBuyEnabled=false
-- Existing Engineer TpWalk uses the old completion/toggle state names.
-- Start in rearm mode, then let EngiBuy and the custom route take priority.
tpToggleNeedsTrigger=true
if teleporterConfig then teleporterConfig.autoWalkEnabled=false end
-- Headless build: all notifications are reported to the Lua console instead
-- of rendering HUD widgets, menus, buttons, or any hotkey configuration UI.
local _gp_lastMessage, _gp_lastMessageAt = nil, -100
function AddNotification(message, ntype, duration)
    local msg = tostring(message or "")
    local now = (globals and globals.RealTime and globals.RealTime()) or 0
    if msg == _gp_lastMessage and (now - _gp_lastMessageAt) < 4 then return end
    _gp_lastMessage, _gp_lastMessageAt = msg, now
    if print then print("[GhostMoney/" .. tostring(ntype or "info") .. "] " .. msg) end
end

local function ResetRuntimeState(reason)
if reason ~= nil and reason ~= "" and reason ~= "EngiBuy Enabled - Reset state" then
AddNotification(reason, "info")
end
isExploiting = false
upgradeQueue = {}
isUpgradingSniper = false
sniperUpgradeCooldownUntil = 0
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
respawnExpected = false
sequenceEndTime = 0
nextUpgradeTime = 0
shouldGuidePlayer = false
thresholdNotificationShown = false
hasTriedClassChange = false
pendingClassChange = false
classChangeUsePreWaveRules = false
pendingRetry = false
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = 0
lastExploitTime = 0
lastCleanupTime = 0
cleanupFlashUntil = 0
suppressToggleUntil = 0
allOffRestoreSnapshot = nil
allOffRestoreUntil = 0
if misc then
misc.waitKey = false
misc.waitKeyArmed = false
misc.waitWhich = nil
misc.waitKeyStartFrame = 0
misc.acPrevInUpgradeZone = nil
misc.acWarnPrevClassName = nil
misc.acWarnPrevHasVacc = nil
misc.acWarnPrevClassSelected = nil
misc.instantRespawnWasAlive = false
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
end
sniperHotkeyHoldDown = false
sniperHotkeyHoldStart = 0
sniperHotkeyHoldTriggered = false
sniperBlockShortToggleOnRelease = false
sniperIgnoreShortToggleUntil = 0
sniperSkipNextShortToggle = false
tpHotkeyHoldDown = false
tpHotkeyHoldStart = 0
tpHotkeyHoldTriggered = false
tpIgnoreShortToggleUntil = 0
tpSkipNextShortToggle = false
tpLastForceToggleAt = 0
medicTriggerDebounceUntil = 0
lastSniperTriggerTime = 0
autoWalkEnabled = config.autoWalkEnabled
autoWalkPaused = false
autoWalkPauseReason = nil
lastAutoWalkPauseReason = nil
lastToggleTime = 0
cashGenEntryCount = 0
medicThresholdReached = false
gpPhase = "MEDIC_FARM"
autobuyRunOnceDone = false
sniperUpgradesComplete = false
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
pendingRetry = false
if GP_RST then
GP_RST.medicCycleHardResetPending = false
GP_RST.medicCycleHardResetSince = 0
GP_RST.medicCycleSwapLockUntil = 0
end
teleporterConfig.autoWalkEnabled = false
foundTeleporters = {}
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
nextTeleporterScanTime = 0
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = 0
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
tpStuckTargetId = nil
tpStuckLastProgressTime = 0
tpStuckLastDistance = nil
tpStuckKillCooldownUntil = 0
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
end
local function HardReset(reason)
local r = reason or "hard_reset"
local __acHardServerTransition = (r == "Loading/Disconnected - Reset state") or (r == "Joined game - Reset state") or (r == "New server/state detected")
if __acHardServerTransition then
acPostWaveSwapLatched = false
end
if __acHardServerTransition and misc then
misc.acWarnSeenNoMedic = false
misc.acWarnSeenNoVacc = false
misc.acWarnPrevClassName = nil
misc.acWarnPrevHasVacc = nil
misc.acWarnPrevClassSelected = nil
misc.acStartedOnce = false
end
if r == "EngiBuy Enabled - Reset state" then
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
end
local serverIPNow = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
if serverIPNow == "" then
serverIPNow = currentServer or ""
end
local tpTransitionForceMode = __acHardServerTransition and ((tpForceModeEnabled == true) or (config and config.forceTpWalkEnabled == true))
local tpTransitionNormalMode = __acHardServerTransition and (not tpTransitionForceMode) and (config and config.tpWalkEnabled == true)
local stickyMismatch = (serverIPNow ~= "" and tpStickyServerIP ~= "" and serverIPNow ~= tpStickyServerIP)
local preserveTpSticky = tpStickyArmed
and ((r == "Loading/Disconnected - Reset state") or (r == "Joined game - Reset state") or (tpForceModeEnabled and r == "EngiBuy Enabled - Reset state"))
and (not stickyMismatch)
sniperUpgradesComplete = false
isUpgradingSniper = false
sniperUpgradeCooldownUntil = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
shouldGuidePlayerBuy = false
shouldGuidePlayer = false
sniperBuyWalkStartTime = 0
sniperBuyWalkKillCooldownUntil = 0
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
foundTeleporters = {}
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
nextTeleporterScanTime = 0
tpNoTeleFallbackActive = false
tpRespawnRearmPending = false
tpForceRestoreAwaitRespawn = false
tpToggleNeedsTrigger = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpLastAliveState = nil
tpFallbackNextWaitNotify = 0
tpStuckTargetId = nil
tpStuckLastProgressTime = 0
tpStuckLastDistance = nil
tpStuckKillCooldownUntil = 0
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
ResetRuntimeState(r)
if preserveTpSticky then
local keepSniperBuyPending = (config.autoBuyEnabled == true) and (not forceSniperBuyModeEnabled)
if keepSniperBuyPending then
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
gpPhase = "SNIPER_BUY"
else
sniperUpgradesComplete = true
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = globals.CurTime() or 0
autobuyRunOnceDone = true
gpPhase = "DONE"
end
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
GP_TP_ResetPathState()
else
tpStickyArmed = false
tpStickyServerIP = ""
if r == "New server/state detected" and (not tpTransitionForceMode) then
tpForceModeEnabled = false
config.forceTpWalkEnabled = false
SaveConfig(GP_CfgPath(), config)
end
end
if tpTransitionForceMode then
tpForceModeEnabled = true
config.forceTpWalkEnabled = true
config.tpWalkEnabled = false
tpStickyArmed = true
tpStickyServerIP = serverIPNow
tpForceRestoreAwaitRespawn = true
tpRespawnRearmPending = true
tpToggleNeedsTrigger = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
GP_TP_ResetPathState()
elseif tpTransitionNormalMode then
tpStickyArmed = true
tpStickyServerIP = serverIPNow
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpToggleNeedsTrigger = true
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
GP_TP_ResetPathState()
end
GP_ArmReloadMoveLock()
if GP_RST_Reset then pcall(GP_RST_Reset, "hard_reset") end
end
local function GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicPending = false
gpFirstJoinPickMedicUntil = 0
gpFirstJoinPickMedicForce = false
gpFirstJoinPickMedicFallbackAt = 0
end
local GP_RECONNECT_CLASS_MAP = {
scout = "scout",
sniper = "sniper",
soldier = "soldier",
demo = "demoman",
demoman = "demoman",
medic = "medic",
heavy = "heavy",
heavyweapons = "heavy",
pyro = "pyro",
spy = "spy",
engineer = "engineer",
engie = "engineer"
}
local function GP_ReconnectNow()
local now = 0
pcall(function()
if globals and globals.RealTime then
now = globals.RealTime()
elseif globals and globals.CurTime then
now = globals.CurTime()
end
end)
return tonumber(now) or 0
end
local function GP_GetReconnectTargetClass()
local raw = tostring((config and config.targetClass) or ""):lower()
return GP_RECONNECT_CLASS_MAP[raw]
end
local function GP_ClearReconnectFeatureRearm()
gpReconnectFeatureRearmClass = nil
gpReconnectFeatureRearmAt = 0
gpReconnectFeatureRearmUntil = 0
end
local function GP_ArmReconnectFeatureRearm(className, now)
local wanted = GP_RECONNECT_CLASS_MAP[tostring(className or ""):lower()]
if not wanted then
GP_ClearReconnectFeatureRearm()
return
end
now = tonumber(now) or GP_ReconnectNow()
gpReconnectFeatureRearmClass = wanted
gpReconnectFeatureRearmAt = now + 0.20
gpReconnectFeatureRearmUntil = now + 6.0
end
local function GP_RearmFeaturesAfterReconnectClass(className, currentTime)
local cls = GP_RECONNECT_CLASS_MAP[tostring(className or ""):lower()]
if not cls then return end
local nowCT = tonumber(currentTime) or ((globals and globals.CurTime and globals.CurTime()) or 0)
reloadMoveLock = false
tpReloadMoveLockArmedAt = 0
if cls == "medic" and config and config.autoWalkEnabled == true then
local preWave = (GP_PartyRetryStrictPreWave1 and GP_PartyRetryStrictPreWave1()) or false
if preWave then
isExploiting = false
isUpgradingSniper = false
upgradeQueue = {}
respawnExpected = false
gpPhase = "MEDIC_FARM"
autoWalkPaused = false
autoWalkPauseReason = nil
lastAutoWalkPauseReason = nil
thresholdNotificationShown = false
medicThresholdReached = false
hasTriedClassChange = false
pendingClassChange = false
pendingRetry = false
shouldGuidePlayer = false
midpoint = nil
acPostWaveSwapLatched = false
end
end
if cls == "engineer" then
local normalSniperBuy = config and config.autoBuyEnabled == true and not forceSniperBuyModeEnabled
if normalSniperBuy then
if GP_ResetSniperBuyProgressState then GP_ResetSniperBuyProgressState() end
gpPhase = "SNIPER_BUY"
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = true
end
if forceSniperBuyModeEnabled then
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
end
if tpForceModeEnabled or (config and config.tpWalkEnabled == true) then
tpStickyArmed = true
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpToggleNeedsTrigger = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
reloadMoveLock = false
if normalSniperBuy then
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
else
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = nowCT - (TELEPORTER_AUTOWALK_DELAY or 1.0)
end
local ip = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
if ip == "" then ip = currentServer or "" end
tpStickyServerIP = ip
if GP_TP_ResetPathState then GP_TP_ResetPathState() end
if GP_TP_ResetStuckTracker then GP_TP_ResetStuckTracker() end
end
elseif tpForceModeEnabled then
tpStickyArmed = true
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpToggleNeedsTrigger = false
tpToggleSpawnLock = false
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = nowCT - (TELEPORTER_AUTOWALK_DELAY or 1.0)
reloadMoveLock = false
end
end
local function GP_TickReconnectFeatureRearm(me, currentTime)
local wanted = gpReconnectFeatureRearmClass
if not wanted then return end
local now = GP_ReconnectNow()
if now > (gpReconnectFeatureRearmUntil or 0) then
GP_ClearReconnectFeatureRearm()
return
end
if now < (gpReconnectFeatureRearmAt or 0) then return end
local currentClass = GP_GetCurrentClassName(me)
if currentClass ~= wanted then return end
GP_ClearReconnectFeatureRearm()
GP_RearmFeaturesAfterReconnectClass(wanted, currentTime)
end
local function GP_ClearReconnectClassPending()
gpRetryJoinClassPending = nil
gpRetryJoinClassUntil = 0
gpRetryJoinClassNextTry = 0
gpRetryJoinClassMustIssue = false
end
local function GP_ArmReconnectClassPending(className, now)
local wanted = GP_RECONNECT_CLASS_MAP[tostring(className or ""):lower()]
if not wanted then
GP_ClearReconnectClassPending()
return false
end
now = tonumber(now) or GP_ReconnectNow()
gpRetryJoinClassPending = wanted
gpRetryJoinClassUntil = now + 120.0
gpRetryJoinClassNextTry = 0
gpRetryJoinClassMustIssue = true
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
return true
end
local function GP_ArmFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = false
gpFirstJoinPickMedicForce = false
local now = GP_ReconnectNow()
if config and config.firstJoinPickMedic then
GP_ClearReconnectClassPending()
gpFirstJoinPickMedicPending = true
gpFirstJoinPickMedicUntil = now + 120.0
gpFirstJoinPickMedicFallbackAt = now + 2.5
gpFirstJoinPickMedicForce = true
gpRetryJoinClassMustIssue = true
else
GP_ClearFirstJoinPickMedicWindow()
GP_ArmReconnectClassPending(GP_GetReconnectTargetClass(), now)
end
end
local function GP_IssueRetryWithAutoClass(className)
local wanted = GP_RECONNECT_CLASS_MAP[tostring(className or ""):lower()]
if wanted then
GP_ArmReconnectClassPending(wanted, GP_ReconnectNow())
else
GP_ClearReconnectClassPending()
end
gpManualRetrySuppressNextAttach = false
gpInternalRetryCommandUntil = GP_ReconnectNow() + 0.75
local ok = pcall(function()
if client and client.Command then
client.Command("retry", true)
end
end)
return ok
end
local gpServerCheckNextAt = 0
function CheckServerChange(force)
local nowCheck = 0
pcall(function()
if globals and globals.RealTime then
nowCheck = globals.RealTime()
elseif globals and globals.CurTime then
nowCheck = globals.CurTime()
end
end)
if (force ~= true) and nowCheck < (gpServerCheckNextAt or 0) then
return
end
gpServerCheckNextAt = nowCheck + 0.25
local serverIP = engine.GetServerIP() or ""
local me = entities.GetLocalPlayer()
local hasMe = (me ~= nil)
if hasMe then
if (config and config.autoBuyEnabled == true) then
gpStickyAutoBuyEnabled = true
elseif (config and config.autoBuyEnabled ~= true)
and (gpStickyAutoBuyEnabled == true)
and (not forceSniperBuyModeEnabled)
and (not (config and config.forceSniperBuyEnabled == true)) then
config.autoBuyEnabled = true
if GP_EnableSniperBuyRuntime then
GP_EnableSniperBuyRuntime(((GP_TP_IsTraversalActive and GP_TP_IsTraversalActive()) and true or false))
end
SaveConfig(GP_CfgPath(), config)
end
if (forceSniperBuyModeEnabled == true) or (config and config.forceSniperBuyEnabled == true) then
gpStickyForceSniperBuyEnabled = true
end
end
local keepAutoBuy = ((config and config.autoBuyEnabled == true) or (gpStickyAutoBuyEnabled == true))
local keepForceSniper = ((forceSniperBuyModeEnabled == true) or (config and config.forceSniperBuyEnabled == true) or (gpStickyForceSniperBuyEnabled == true))
if not hasMe then
if hadLocalPlayer then
hadLocalPlayer = false
currentServer = serverIP
HardReset("Loading/Disconnected - Reset state")
GP_AutoDisconnectReset(false)
GP_F4_OnDisconnectCycle("disconnect")
GP_ClearFirstJoinPickMedicWindow()
if keepForceSniper then
forceSniperBuyModeEnabled = true
config.forceSniperBuyEnabled = true
else
forceSniperBuyModeEnabled = false
config.forceSniperBuyEnabled = false
end
if keepAutoBuy then
config.autoBuyEnabled = true
end
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
gpStickyForceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config.forceSniperBuyEnabled == true)
SaveConfig(GP_CfgPath(), config)
end
return
end
if not hadLocalPlayer then
hadLocalPlayer = true
currentServer = serverIP
HardReset("Joined game - Reset state")
GP_AutoDisconnectReset(true)
do
local suppressAttachClass = (gpManualRetrySuppressNextAttach == true) or (gpSuppressFirstJoinPickMedicOnAttach == true)
gpManualRetrySuppressNextAttach = false
gpSuppressFirstJoinPickMedicOnAttach = false
if suppressAttachClass then
GP_ClearReconnectClassPending()
GP_ClearReconnectFeatureRearm()
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
else
GP_ArmFirstJoinPickMedicWindow()
end
end
GP_F4_OnJoinCycle("join")
if keepForceSniper then
forceSniperBuyModeEnabled = true
config.forceSniperBuyEnabled = true
else
forceSniperBuyModeEnabled = false
config.forceSniperBuyEnabled = false
end
if keepAutoBuy then
config.autoBuyEnabled = true
end
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
gpStickyForceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config.forceSniperBuyEnabled == true)
if config and (config.forceTpWalkEnabled == true) then
if GP_SetTpForceEnabled then
GP_SetTpForceEnabled(true, false)
else
tpForceModeEnabled = true
config.forceTpWalkEnabled = true
config.tpWalkEnabled = false
end
tpForceRestoreAwaitRespawn = true
tpRespawnRearmPending = false
teleporterConfig.autoWalkEnabled = false
teleporterManuallyDisabled = false
tpToggleSpawnLock = false
tpStickyArmed = true
end
if tpReloadRestoreNormalPending and config and (config.tpWalkEnabled == true) and (not tpForceModeEnabled) then
tpForceRestoreAwaitRespawn = false
tpToggleNeedsTrigger = true
tpRespawnRearmPending = false
tpToggleSpawnLock = false
tpStickyArmed = true
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
tpLastAliveState = nil
if GP_TP_ResetPathState then GP_TP_ResetPathState() end
if GP_TP_ResetStuckTracker then GP_TP_ResetStuckTracker() end
local _lp = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local _cls = GP_GetCurrentClassName(_lp)
if _lp and _lp.IsAlive and (not _lp:IsAlive()) and _cls == "sniper" then
tpRespawnRearmPending = true
end
tpReloadRestoreNormalPending = false
end
if gpSniperBuyLoadRearmPending and (config and config.autoBuyEnabled and (not forceSniperBuyModeEnabled)) then
sniperReloadAwaitRespawn = true
sniperReloadRespawnPending = false
sniperLastAliveState = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
isUpgradingSniper = false
upgradeQueue = {}
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
else
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
end
gpSniperBuyLoadRearmPending = false
do
local nowJoin = (globals and globals.CurTime and globals.CurTime()) or 0
if pendingRetryTargetClass and (pendingRetryTargetClass ~= "") and ((pendingRetryTargetUntil or 0) >= nowJoin) then
pendingRetry = true
else
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
end
end
SaveConfig(GP_CfgPath(), config)
return
end
if currentServer ~= serverIP then
if (currentServer == nil or currentServer == "") and (serverIP ~= "") then
currentServer = serverIP
GP_AutoDisconnectReset(true)
return
end
currentServer = serverIP
HardReset("New server/state detected")
GP_AutoDisconnectReset(true)
GP_F4_OnDisconnectCycle("new_server")
if gpManualRetrySuppressNextAttach or gpSuppressFirstJoinPickMedicOnAttach then
gpManualRetrySuppressNextAttach = false
gpSuppressFirstJoinPickMedicOnAttach = false
GP_ClearReconnectClassPending()
GP_ClearReconnectFeatureRearm()
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
else
GP_ArmFirstJoinPickMedicWindow()
end
if keepForceSniper then
forceSniperBuyModeEnabled = true
config.forceSniperBuyEnabled = true
else
forceSniperBuyModeEnabled = false
config.forceSniperBuyEnabled = false
end
if keepAutoBuy then
config.autoBuyEnabled = true
end
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
gpStickyForceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config.forceSniperBuyEnabled == true)
SaveConfig(GP_CfgPath(), config)
return
end
end

function IsGameInputAllowed()
return not engine.Con_IsVisible()
and not engine.IsGameUIVisible()
and not engine.IsChatOpen()
end
function GP_ShouldSniperBuyArmImmediately()
local preWave = (GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false
if not preWave then return false end
return (config and config.autoWalkEnabled)
or thresholdNotificationShown
or pendingClassChange
or needToLeaveZone
end
local function IsUIInputAllowed()
return not engine.Con_IsVisible()
end
local gp_curRewindLastHandled = 0
function GP_HandleCurTimeRewind(currentTime)
if type(currentTime) ~= "number" then return end
local prev = lastCurTime or currentTime
local delta = prev - currentTime
local rt = 0
pcall(function()
if globals and globals.RealTime then
rt = globals.RealTime()
elseif globals and globals.CurTime then
rt = globals.CurTime()
end
end)
local bigRewind = (delta > 0.50)
local mapLikeRewind = (prev > 20 and currentTime < 5 and delta > 0.05)
local lastHandled = gp_curRewindLastHandled or 0
local cooldownOk = ((rt - lastHandled) >= 2.0)
if (bigRewind or mapLikeRewind) and cooldownOk then
suppressToggleUntil = 0
lastToggleTime = 0
lastCleanupTime = 0
cleanupFlashUntil = 0
if misc then
misc.waitKey = false
misc.waitKeyArmed = false
misc.waitWhich = nil
misc.waitKeyStartFrame = 0
misc.instantRespawnWasAlive = false
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
end
sniperHotkeyHoldDown = false
sniperHotkeyHoldStart = 0
sniperHotkeyHoldTriggered = false
sniperBlockShortToggleOnRelease = false
sniperIgnoreShortToggleUntil = 0
sniperSkipNextShortToggle = false
tpHotkeyHoldDown = false
tpHotkeyHoldStart = 0
tpHotkeyHoldTriggered = false
tpIgnoreShortToggleUntil = 0
tpSkipNextShortToggle = false
tpLastForceToggleAt = 0
if GP_RST_Reset then
pcall(GP_RST_Reset, "curtime_rewind")
end
gp_curRewindLastHandled = rt
end
lastCurTime = currentTime
end
function IsMoneyThresholdReached()
local me = entities.GetLocalPlayer()
if not me then return false end
local currency = me:GetPropInt("m_nCurrency")
if not currency then return false end
return currency >= config.moneyThreshold
end
function IsMvMWaveActive()
if not GP_IsMvM() then return false end
local roundState = GP_GetRoundState()
return roundState == 4
end
function ComputeMove(userCmd, a, b)
local diff = (b - a)
if diff:Length() == 0 then return Vector3(0, 0, 0) end
local x = diff.x
local y = diff.y
local vSilent = Vector3(x, y, 0)
local ang = vSilent:Angles()
local cPitch, cYaw = userCmd:GetViewAngles()
local yaw = math.rad(ang.y - cYaw)
local pitch = math.rad(ang.x - cPitch)
local move = Vector3(math.cos(yaw) * 450, -math.sin(yaw) * 450, -math.cos(pitch) * 450)
return move
end
function WalkTo(userCmd, me, destination)
if IsManualMoveInput() then return end
local myPos = me:GetAbsOrigin()
local result = ComputeMove(userCmd, myPos, destination)
userCmd:SetForwardMove(result.x)
userCmd:SetSideMove(result.y)
end
function GP_TP_ResetPathState()
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
foundTeleporters = {}
nextTeleporterScanTime = 0
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = 0
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
tpStuckTargetId = nil
tpStuckLastProgressTime = 0
tpStuckLastDistance = nil
tpStuckKillCooldownUntil = 0
tpUseVerifyActive = false
tpUseVerifyStart = 0
tpUseVerifyAnchor = nil
tpUseVerifyTargetPos = nil
end
function GP_SetTpWalkEnabled(enabled, notify)
config.tpWalkEnabled = (enabled and true or false)
tpReloadRestoreNormalPending = false
if config.tpWalkEnabled then
if tpForceModeEnabled then
tpForceModeEnabled = false
config.forceTpWalkEnabled = false
end
teleporterManuallyDisabled = false
teleporterJustUsed = false
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
foundTeleporters = {}
nextTeleporterScanTime = 0
tpRespawnRearmPending = false
tpStickyArmed = false
tpStickyServerIP = ""
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpToggleNeedsTrigger = true
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
teleporterConfig.autoWalkEnabled = false
local _lp = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local canArmImmediately = false
if _lp and _lp.IsAlive and _lp:IsAlive() then
local okSpawnCtx, inSpawnCtx = pcall(GP_TP_IsSpawnContextNow, _lp)
if okSpawnCtx and inSpawnCtx == true then
canArmImmediately = true
end
end
if _lp and _lp.IsAlive and (not _lp:IsAlive()) then
tpRespawnRearmPending = true
elseif canArmImmediately then
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = (globals.CurTime() or 0) - (TELEPORTER_AUTOWALK_DELAY or 1.0)
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
end
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
else
teleporterManuallyDisabled = true
teleporterConfig.autoWalkEnabled = false
foundTeleporters = {}
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
nextTeleporterScanTime = 0
tpStickyArmed = false
tpStickyServerIP = ""
tpRespawnRearmPending = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpFallbackNextWaitNotify = 0
tpToggleNeedsTrigger = false
GP_TP_ResetStuckTracker()
tpForceModeEnabled = false
config.forceTpWalkEnabled = false
end
SaveConfig(GP_CfgPath(), config)
if notify then
if config.tpWalkEnabled then
local _lp = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local _cls = GP_GetCurrentClassName(_lp)
if _cls ~= "engineer" then
AddNotification("Standard TpWalk is now Engineer-only; use Force TpWalk for other classes", "info", 5.0)
end
AddNotification("TpWalk Enabled (Death/Respawn as Engineer or EngiBuy activates it)", "info", 4.0)
else
AddNotification("TpWalk Disabled", "info")
end
end
end
-- Removed in v24: All-class TpWalk, NoWalk EngiBuy controls
function GP_TP_GetDistance(pos1, pos2)
local dx = (pos2.x - pos1.x)
local dy = (pos2.y - pos1.y)
local dz = (pos2.z - pos1.z)
return math.sqrt(dx*dx + dy*dy + dz*dz)
end
function GP_TP_StopUseVerify()
tpUseVerifyActive = false
tpUseVerifyStart = 0
tpUseVerifyAnchor = nil
tpUseVerifyTargetPos = nil
end
function GP_TP_StartUseVerify(me, telePos, now)
if not me then return end
local p = me:GetAbsOrigin()
if not p then return end
tpUseVerifyActive = true
tpUseVerifyStart = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
tpUseVerifyAnchor = Vector3(p.x, p.y, p.z)
if telePos then
tpUseVerifyTargetPos = Vector3(telePos.x, telePos.y, telePos.z)
else
tpUseVerifyTargetPos = nil
end
end
-- Removed in v25: TP Position Lost - Kill monitor.
function GP_TP_TickUseVerify(me, now)
if not tpUseVerifyActive then return end
local anyTpModeOn = ((tpForceModeEnabled == true) or ((config and config.tpWalkEnabled) == true))
if not anyTpModeOn then
GP_TP_StopUseVerify()
return
end
if not me or (not me:IsAlive()) then
GP_TP_StopUseVerify()
return
end
now = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
local killCooldownActive = ((tpUseVerifyKillCooldownUntil or 0) > now)
if not tpUseVerifyAnchor then
GP_TP_StopUseVerify()
return
end
local curPos = me:GetAbsOrigin()
if not curPos then
GP_TP_StopUseVerify()
return
end
local movedDist = GP_TP_GetDistance(curPos, tpUseVerifyAnchor)
local farFromEntrance = true
if tpUseVerifyTargetPos then
local dTarget = GP_TP_GetDistance(curPos, tpUseVerifyTargetPos)
farFromEntrance = (dTarget >= (TP_TELE_VERIFY_TARGET_LEAVE_DISTANCE or 120))
end
local movedEnough = (movedDist >= (TP_TELE_USE_SUCCESS_DISTANCE or 180))
local closeTpSuccess = (teleporterJustUsed and farFromEntrance and movedDist >= 48)
if (movedEnough and farFromEntrance) or closeTpSuccess then
GP_TP_StopUseVerify()
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
GP_F4_OnTpSuccess()
return
end
if (not killCooldownActive) and ((now - (tpUseVerifyStart or now)) >= (TP_TELE_USE_VERIFY_SECONDS or 10.0)) then
GP_TP_StopUseVerify()
tpUseVerifyKillCooldownUntil = now + 4.0
AddNotification("TpWalk: teleporter not used in time - suiciding", "warning")
pcall(function()
if client and client.Command then
client.Command("kill", true)
end
end)
end
end
function GP_TP_ResetStuckTracker()
tpStuckTargetId = nil
tpStuckLastProgressTime = 0
tpStuckLastDistance = nil
end
function GP_TP_BuildTargetId(teleEntry)
if not teleEntry then return "none" end
local ent = teleEntry.entity
if ent and ent.GetIndex then
local ok, idx = pcall(function() return ent:GetIndex() end)
if ok and type(idx) == "number" then
return "e:" .. tostring(idx)
end
end
local p = teleEntry.pos
if p then
return string.format("p:%d:%d:%d", math.floor(p.x + 0.5), math.floor(p.y + 0.5), math.floor(p.z + 0.5))
end
return "unknown"
end
function GP_TP_CheckAndHandleStuck(me, teleEntry, dist, currentTime)
if not me or not teleEntry or type(dist) ~= "number" then
GP_TP_ResetStuckTracker()
return false
end
if (tpStuckKillCooldownUntil or 0) > currentTime then
return false
end
local targetId = GP_TP_BuildTargetId(teleEntry)
if targetId ~= tpStuckTargetId then
tpStuckTargetId = targetId
tpStuckLastProgressTime = currentTime
tpStuckLastDistance = dist
return false
end
local lastDist = tpStuckLastDistance
if type(lastDist) ~= "number" then
tpStuckLastDistance = dist
tpStuckLastProgressTime = currentTime
return false
end
if dist < (lastDist - 16) then
tpStuckLastDistance = dist
tpStuckLastProgressTime = currentTime
return false
end
if dist < lastDist then
tpStuckLastDistance = dist
end
if (currentTime - (tpStuckLastProgressTime or currentTime)) >= (TP_STUCK_TIMEOUT or 10.0) then
AddNotification("TpWalk: detected stuck - suiciding", "warning")
pcall(function()
if client and client.Command then
client.Command("kill", true)
end
end)
tpStuckKillCooldownUntil = currentTime + 4.0
GP_TP_ResetStuckTracker()
return true
end
return false
end
function GP_TP_CheckAndHandleWaypointStuck(me, waypointPos, currentTime, mapName, pathIndex, waypointIndex)
if not me or not waypointPos then
GP_TP_ResetStuckTracker()
return false
end
if (tpStuckKillCooldownUntil or 0) > currentTime then
return false
end
local myPos = me:GetAbsOrigin()
local dist = GP_TP_GetDistance(myPos, waypointPos)
local targetId = "wp:" .. tostring(mapName or "?") .. ":" .. tostring(pathIndex or 0) .. ":" .. tostring(waypointIndex or 0)
if targetId ~= tpStuckTargetId then
tpStuckTargetId = targetId
tpStuckLastProgressTime = currentTime
tpStuckLastDistance = dist
return false
end
local lastDist = tpStuckLastDistance
if type(lastDist) ~= "number" then
tpStuckLastDistance = dist
tpStuckLastProgressTime = currentTime
return false
end
if dist <= 120 then
tpStuckLastDistance = dist
tpStuckLastProgressTime = currentTime
return false
end
if dist < (lastDist - 12) then
tpStuckLastDistance = dist
tpStuckLastProgressTime = currentTime
return false
end
if dist < lastDist then
tpStuckLastDistance = dist
end
if (currentTime - (tpStuckLastProgressTime or currentTime)) >= (TP_STUCK_TIMEOUT or 10.0) then
AddNotification("TpWalk: path stuck at waypoint - suiciding", "warning")
pcall(function()
if client and client.Command then
client.Command("kill", true)
end
end)
tpStuckKillCooldownUntil = currentTime + 4.0
GP_TP_ResetStuckTracker()
return true
end
return false
end
local function GP_TP_NormalizeMapName(rawName)
local name = tostring(rawName or "")
if name == "" then return "" end
name = string.lower(name)
name = string.gsub(name, "\\", "/")
if string.find(name, "mvm_mannhattan", 1, true) or string.find(name, "mvm_manhattan", 1, true) then
return "maps/mvm_mannhattan.bsp"
end
if string.find(name, "mvm_rottenburg", 1, true) then
return "maps/mvm_rottenburg.bsp"
end
if not string.find(name, "/", 1, true) then
name = "maps/" .. name
end
if not string.find(name, ".bsp", 1, true) then
name = name .. ".bsp"
end
return name
end
function GP_TP_GetCurrentMap()
local raw = ""
if engine and engine.GetMapName then
raw = engine.GetMapName() or ""
end
return GP_TP_NormalizeMapName(raw)
end
function GP_TP_ChooseBestPath(playerPos, mapName)
local paths = mapPaths[mapName]
if not paths then return nil end
local closestPathIndex = nil
local closestDistance = math.huge
for i, path in ipairs(paths) do
local first = path[1]
if first then
local firstWaypoint = Vector3(first.x, first.y, first.z)
local distance = GP_TP_GetDistance(playerPos, firstWaypoint)
if distance < closestDistance then
closestDistance = distance
closestPathIndex = i
end
end
end
return closestPathIndex
end
function GP_TP_GetCurrentPathWaypoint()
if not tpCurrentPathIndex then return nil end
local mapName = GP_TP_GetCurrentMap()
local paths = mapPaths[mapName]
if not paths or not paths[tpCurrentPathIndex] then return nil end
local path = paths[tpCurrentPathIndex]
if tpCurrentPathWaypointIndex > #path then return nil end
local wp = path[tpCurrentPathWaypointIndex]
if not wp then return nil end
return Vector3(wp.x, wp.y, wp.z)
end
local function GP_TP_HasLineOfSight(fromPos, toPos)
if not (engine and engine.TraceLine) then return false end
local startPos = fromPos + Vector3(0, 0, 64)
local endPos = toPos + Vector3(0, 0, 32)
local ok, trace = pcall(engine.TraceLine, startPos, endPos, MASK_SHOT_HULL)
if not ok or not trace then return false end
local frac = trace.fraction or trace.Fraction
if type(frac) ~= "number" then return false end
return frac >= 0.98
end
local function GP_TP_ComputeMove(userCmd, fromPos, toPos)
local diff = toPos - fromPos
if diff:Length() == 0 then return 0, 0 end
local ang = Vector3(diff.x, diff.y, 0):Angles()
local _, cYaw, _ = userCmd:GetViewAngles()
local yaw = math.rad(ang.y - cYaw)
local forwardMove = math.cos(yaw) * teleporterConfig.walkSpeed
local sideMove = -math.sin(yaw) * teleporterConfig.walkSpeed
return forwardMove, sideMove
end
function GP_TP_WalkToTeleporter(userCmd, me, targetPos)
if (not sniperUpgradeCompleted) and (not tpForceModeEnabled) then return end
local lockConfigured = (config and config.tpWalkMoveLockEnabled == true)
local manualInput = IsManualMoveInput()
if (not lockConfigured) and manualInput then
return
end
if lockConfigured and manualInput then
GP_TP_ApplyMovementLock(userCmd)
end
local myPos = me:GetAbsOrigin()
local mapName = GP_TP_GetCurrentMap()
local hasPredefinedPaths = mapPaths[mapName] ~= nil
local hasLOS = GP_TP_HasLineOfSight(myPos, targetPos)
local currentTime = globals.CurTime()
if hasLOS and tpUsingPredefinedPath then
if tpLOSDetectedTime == 0 then
tpLOSDetectedTime = currentTime
end
if currentTime - tpLOSDetectedTime >= tpLOSDelay then
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
end
elseif not hasLOS then
tpLOSDetectedTime = 0
end
if hasPredefinedPaths and (not tpPathSelected) and (not hasLOS) then
tpCurrentPathIndex = GP_TP_ChooseBestPath(myPos, mapName)
if tpCurrentPathIndex then
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = true
tpPathSelected = true
end
elseif (not hasPredefinedPaths) and (not tpPathSelected) then
tpPathSelected = true
elseif hasLOS and (not tpPathSelected) then
tpPathSelected = true
end
if tpUsingPredefinedPath and (not hasLOS) then
local pathWaypoint = GP_TP_GetCurrentPathWaypoint()
if pathWaypoint then
local waypointDistance = GP_TP_GetDistance(myPos, pathWaypoint)
if waypointDistance < 100 then
tpCurrentPathWaypointIndex = tpCurrentPathWaypointIndex + 1
local nextWaypoint = GP_TP_GetCurrentPathWaypoint()
if nextWaypoint then
pathWaypoint = nextWaypoint
else
tpUsingPredefinedPath = false
end
end
if tpUsingPredefinedPath and pathWaypoint then
if GP_TP_CheckAndHandleWaypointStuck(me, pathWaypoint, currentTime, mapName, tpCurrentPathIndex, tpCurrentPathWaypointIndex) then
return
end
local fm, sm = GP_TP_ComputeMove(userCmd, myPos, pathWaypoint)
userCmd:SetForwardMove(fm)
userCmd:SetSideMove(sm)
return
end
end
end
local fm, sm = GP_TP_ComputeMove(userCmd, myPos, targetPos)
userCmd:SetForwardMove(fm)
userCmd:SetSideMove(sm)
end
function GP_TP_HandleWaitingPopups(userCmd)
tpIsWaitingForTeleporter = true
local now = globals.CurTime() or 0
if not tpFallbackWaitPopupShown then
AddNotification("Waiting for teleporter - don't walk away", "warning")
tpFallbackWaitPopupShown = true
tpFallbackNextWaitNotify = now + (TP_WAIT_NOTIFY_INTERVAL or 7.0)
end
if GP_TP_IsMoveLockActive() then
GP_TP_ApplyMovementLock(userCmd)
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
else
if GP_IsTextInputOpen() then
tpWaitMoveWarnNext = 0
elseif GP_HasMoveIntent(userCmd) then
if now >= (tpWaitMoveWarnNext or 0) then
tpWaitMoveWarnCount = (tpWaitMoveWarnCount or 0) + 1
if (tpWaitMoveWarnCount % 2) == 0 then
AddNotification("Don't walk away - still waiting for teleporter", "warning")
end
tpWaitMoveWarnNext = now + 0.85
end
else
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
end
end
if now >= (tpFallbackNextWaitNotify or 0) then
AddNotification("Still waiting for teleporter", "info")
tpFallbackNextWaitNotify = now + (TP_WAIT_NOTIFY_INTERVAL or 7.0)
end
end
function GP_TP_WalkFallbackPath(userCmd, me)
if not me then return false end
local lockConfigured = (config and config.tpWalkMoveLockEnabled == true)
local manualInput = IsManualMoveInput()
if (not lockConfigured) and manualInput then
return true
end
if lockConfigured and manualInput then
GP_TP_ApplyMovementLock(userCmd)
end
local myPos = me:GetAbsOrigin()
local mapName = GP_TP_GetCurrentMap()
local paths = mapPaths[mapName]
if not paths then
GP_TP_ResetStuckTracker()
GP_TP_HandleWaitingPopups(userCmd)
return true
end
if (not tpPathSelected) or (not tpCurrentPathIndex) then
tpCurrentPathIndex = GP_TP_ChooseBestPath(myPos, mapName)
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = (tpCurrentPathIndex ~= nil)
tpPathSelected = true
end
if not tpCurrentPathIndex then
GP_TP_ResetStuckTracker()
GP_TP_HandleWaitingPopups(userCmd)
return true
end
local pathWaypoint = GP_TP_GetCurrentPathWaypoint()
if not pathWaypoint then
GP_TP_ResetStuckTracker()
GP_TP_HandleWaitingPopups(userCmd)
return true
end
local waypointDistance = GP_TP_GetDistance(myPos, pathWaypoint)
if waypointDistance < 100 then
tpCurrentPathWaypointIndex = tpCurrentPathWaypointIndex + 1
local nextWaypoint = GP_TP_GetCurrentPathWaypoint()
if nextWaypoint then
pathWaypoint = nextWaypoint
else
GP_TP_ResetStuckTracker()
GP_TP_HandleWaitingPopups(userCmd)
return true
end
end
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
local now = globals.CurTime() or 0
if GP_TP_CheckAndHandleWaypointStuck(me, pathWaypoint, now, mapName, tpCurrentPathIndex, tpCurrentPathWaypointIndex) then
return true
end
local fm, sm = GP_TP_ComputeMove(userCmd, myPos, pathWaypoint)
userCmd:SetForwardMove(fm)
userCmd:SetSideMove(sm)
return true
end
function GP_TP_IsUsableTeleporter(entity)
if not entity or not entity.GetPropInt then return true end
local function P(name)
local ok, v = pcall(function() return entity:GetPropInt(name) end)
if ok and type(v) == "number" then return v end
return nil
end
local placing = P("m_bPlacing")
if placing == 1 then return false end
local building = P("m_bBuilding")
if building == 1 then return false end
local carried = P("m_bCarried")
if carried == 1 then return false end
local disabled = P("m_bDisabled")
if disabled == 1 then return false end
local health = P("m_iHealth")
if type(health) == "number" and health <= 0 then return false end
local state = P("m_iState")
if type(state) == "number" and state <= 0 then
return false
end
return true
end

function GP_TP_GetBuilderForWhitelist(entity)
if not entity then return nil end
local okEnt, bEnt = pcall(function() return entity:GetPropEntity("m_hBuilder") end)
if okEnt and bEnt then return bEnt end
local okH, h = pcall(function() return entity:GetPropInt("m_hBuilder") end)
if okH and h and entities and entities.GetByHandle then
local okB, bByHandle = pcall(function() return entities.GetByHandle(h) end)
if okB and bByHandle then return bByHandle end
end
return nil
end

function GP_TP_ScanForTeleporters(me)
if not me then return end
if not teleporterConfig.scanEnabled then return end

local myPos = me:GetAbsOrigin()
if not myPos then
foundTeleporters = {}
return
end

local myTeam = (me.GetTeamNumber and me:GetTeamNumber()) or -1
local candidates = {}
local maxDist = teleporterConfig.maxScanDistance or 10000
local maxDist2 = maxDist * maxDist

local function consider(entity, className)
if not (entity and entity.GetAbsOrigin) then return end
local pos = entity:GetAbsOrigin()
if not pos then return end

local dx, dy, dz = pos.x - myPos.x, pos.y - myPos.y, pos.z - myPos.z
local d2 = dx * dx + dy * dy + dz * dz
if d2 > maxDist2 then return end

local mode = -1
if entity.GetPropInt then
local okMode, m = pcall(entity.GetPropInt, entity, "m_iObjectMode")
if okMode and type(m) == "number" then mode = m end
end

local team = (entity.GetTeamNumber and entity:GetTeamNumber()) or -1
if teleporterConfig.showOnlyFriendly and team ~= myTeam then return end

local isEntrance = (className == "CObjectTeleporterEntrance") or (mode == 0)
if not isEntrance then return end
if not GP_TP_IsUsableTeleporter(entity) then return end

candidates[#candidates + 1] = {
entity = entity,
pos = pos,
distance2 = d2,
distance = math.sqrt(d2),
team = team,
mode = mode
}
end

local scannedByClass = false
if entities and entities.FindByClass then
local classNames = {
"CObjectTeleporterEntrance",
"CObjectTeleporter",
"CObjectTeleporterExit"
}
for ci = 1, #classNames do
local cls = classNames[ci]
local list = entities.FindByClass(cls)
if list and #list > 0 then
scannedByClass = true
for i = 1, #list do
consider(list[i], cls)
end
end
end
end

if (not scannedByClass) or (#candidates == 0) then
local highest = (entities.GetHighestEntityIndex and entities.GetHighestEntityIndex()) or 2048
for i = 0, highest do
local entity = entities.GetByIndex(i)
if entity and entity.GetClass and entity.GetAbsOrigin then
local class = entity:GetClass()
if class == "CObjectTeleporter" or class == "CObjectTeleporterEntrance" or class == "CObjectTeleporterExit" then
consider(entity, class)
end
end
end
end

if #candidates > 1 then
table.sort(candidates, function(a, b)
return (a.distance2 or math.huge) < (b.distance2 or math.huge)
end)
end

foundTeleporters = candidates
end
GP_OnSniperUpgradesComplete = function(_reason)
sniperUpgradeCompleted = true
local nowComplete = (globals and globals.CurTime and globals.CurTime()) or 0
sniperUpgradeCompletedTime = nowComplete
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterConfig.autoWalkEnabled = false
teleporterManuallyDisabled = false
tpStickyArmed = true
local ip = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
if ip == "" then ip = currentServer or "" end
tpStickyServerIP = ip
if (not tpForceModeEnabled) and (config and config.tpWalkEnabled) then
tpToggleNeedsTrigger = false
end
GP_TP_ResetPathState()
end
GP_CheckSniperUpgradeDone = function(queueLen)
if isUpgradingSniper and queueLen == 0 and not sniperUpgradeCompleted then
GP_OnSniperUpgradesComplete("queue_empty")
end
end
local gpUpgradeMidCache = nil
local gpUpgradeMidCacheUntil = 0
local gpUpgradeMidCacheMap = ""
local GP_UPGRADE_SCAN_INTERVAL = 0.5
function FindUpgradeStations(me)
if not (me and me.GetAbsOrigin) then return nil end
local now = 0
if globals and globals.RealTime then
now = globals.RealTime()
elseif globals and globals.CurTime then
now = globals.CurTime()
end
local mapName = ""
if engine and engine.GetMapName then
mapName = engine.GetMapName() or ""
end
if (mapName == gpUpgradeMidCacheMap) and (now < (gpUpgradeMidCacheUntil or 0)) then
return gpUpgradeMidCache
end
local myPos = me:GetAbsOrigin()
if not myPos then return nil end
if not (entities and entities.GetByIndex and entities.GetHighestEntityIndex and models and models.GetModelName) then
return nil
end
local signPositions = {}
local highest = entities.GetHighestEntityIndex() or 2048
for i = 0, highest do
local entity = entities.GetByIndex(i)
if entity and entity.GetClass and entity.GetModel and entity.GetAbsOrigin then
if entity:GetClass() == "CDynamicProp" then
local modelName = models.GetModelName(entity:GetModel())
if modelName == "models/props_mvm/mvm_upgrade_sign.mdl" then
local pos = entity:GetAbsOrigin()
if pos then
local dx, dy, dz = pos.x - myPos.x, pos.y - myPos.y, pos.z - myPos.z
local d2 = dx*dx + dy*dy + dz*dz
if d2 < (5000 * 5000) then
signPositions[#signPositions + 1] = pos
end
end
end
end
end
end
local result = nil
if #signPositions >= 2 then
local nearestIdx = nil
local nearestD2 = math.huge
for i = 1, #signPositions do
local p = signPositions[i]
local dx, dy, dz = p.x - myPos.x, p.y - myPos.y, p.z - myPos.z
local d2 = dx*dx + dy*dy + dz*dz
if d2 < nearestD2 then
nearestD2 = d2
nearestIdx = i
end
end
if nearestIdx then
local pos1 = signPositions[nearestIdx]
local pos2 = nil
local pairD2 = math.huge
for i = 1, #signPositions do
if i ~= nearestIdx then
local p = signPositions[i]
local dx, dy, dz = p.x - pos1.x, p.y - pos1.y, p.z - pos1.z
local d2 = dx*dx + dy*dy + dz*dz
if d2 < pairD2 then
pairD2 = d2
pos2 = p
end
end
end
if pos2 then
result = Vector3(
(pos1.x + pos2.x) / 2,
(pos1.y + pos2.y) / 2,
(pos1.z + pos2.z) / 2
)
end
end
end
gpUpgradeMidCache = result
gpUpgradeMidCacheMap = mapName
gpUpgradeMidCacheUntil = now + GP_UPGRADE_SCAN_INTERVAL
return result
end
function SendMvMUpgrade(itemslot, upgrade, count)
local kv = string.format([["MVM_Upgrade" { "Upgrade" { "itemslot" "%d" "Upgrade" "%s" "count" "%d" } }]],
itemslot, upgrade, count)
return engine.SendKeyValues(kv)
end
function ForceCleanup()
autoWalkPaused = false
autoWalkPauseReason = nil
engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "0" }')
isExploiting = false
isUpgradingSniper = false
upgradeQueue = {}
respawnExpected = false
teleporterConfig.autoWalkEnabled = false
foundTeleporters = {}
tpPathSelected = false
tpCurrentPathIndex = nil
tpCurrentPathWaypointIndex = 1
tpUsingPredefinedPath = false
tpLOSDetectedTime = 0
nextTeleporterScanTime = 0
end

function GP_TP_IsTraversalActive()
return ((teleporterConfig and teleporterConfig.autoWalkEnabled == true)
or (tpIsWaitingForTeleporter == true)
or (tpNoTeleFallbackActive == true)
or (tpUseVerifyActive == true))
end

local GP_EB_Cancel  -- forward declaration (defined after legacy functions)
function GP_DisableSniperBuyRuntime(preserveTpTraversal)
if GP_EB_Cancel then GP_EB_Cancel() end
local preserve = (preserveTpTraversal == true)
pcall(function()
if engine and engine.SendKeyValues then
engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "0" }')
end
end)
isExploiting = false
isUpgradingSniper = false
upgradeQueue = {}
respawnExpected = false
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
sniperBuyWalkStartTime = 0
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
sniperUpgradeCooldownUntil = 0
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
sniperBuyWalkStartTime = 0
sniperBuyWalkKillCooldownUntil = 0
if not preserve then
ForceCleanup()
end
end
-- Removed in v24: old Medic exploit queue
function HasVaccinator(player)
if not player then return false end
local secondaryWeapon = player:GetEntityForLoadoutSlot(LOADOUT_POSITION_SECONDARY)
if not secondaryWeapon then return false end
local weaponId = secondaryWeapon:GetPropInt("m_iItemDefinitionIndex")
return weaponId == 998
end

function GP_ResetSniperBuyProgressState()
if GP_EB_Cancel then GP_EB_Cancel() end
isUpgradingSniper = false
upgradeQueue = {}
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
sniperUpgradeCooldownUntil = 0
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
sniperBuyWalkStartTime = 0
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
end

function GP_EnableSniperBuyRuntime(preserveTpTraversal)
local preserve = (preserveTpTraversal == true)
if not preserve then
HardReset("EngiBuy Enabled - Reset state")
else
if teleporterConfig and teleporterConfig.autoWalkEnabled then
teleporterJustUsed = false
end
end
GP_ResetSniperBuyProgressState()
local me = nil
pcall(function()
if entities and entities.GetLocalPlayer then
me = entities.GetLocalPlayer()
end
end)
local aliveNow = nil
if me and me.IsAlive then
aliveNow = (me:IsAlive() == true)
end
sniperReloadAwaitRespawn = (aliveNow == false)
if aliveNow == nil then
sniperReloadRespawnPending = false
sniperLastAliveState = nil
elseif aliveNow then
sniperReloadRespawnPending = false
sniperLastAliveState = true
else
sniperReloadRespawnPending = true
sniperLastAliveState = false
end
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
end

-- Removed in v24: AutoCredit, toggle snapshots
-- EngiBuy 2026-11-04: live-state purchase planning (v38).
-- The original SniperBuy config switches and UI bindings are retained for backward compatibility.
-- Important: 'Upgrade' is a zero-based index into the ACTUAL loaded upgrade list,
-- not the key such as "11" in mvm_upgrades.txt. The earlier ID 58 bought CRIT
-- resistance (as the player reported), so ID 58 must not be used for Jump Height.
-- FIX: TF2's Engineer BUILDING PDA is loadout position 5, NOT 3.
-- Position 3 is Utility, so the previous requests could not apply to the PDA.
-- Default upgrade-list order is 20=Building Health, 22=Dispenser Range.
-- The 4-index offset observed for Jump Height does not prove the same offset
-- applies before the Engineer entries. Use default building IDs first;
-- alternate indices can only be attempted after a refused request or refund.
local GP_EB_STEPS = {
    {name="Jump Height", slot=-1, id="62", candidates={"62"}, price=100, max=3,
     attrClass="mod_jump_height", increment=0.2},
    {name="Dispenser Range", slot=5, id="22", candidates={"22","26"}, price=100, max=3,
     attrClass="mult_dispenser_radius", increment=1.0},
    {name="Building Health", slot=5, id="20", candidates={"20","24"}, price=400, max=3,
     attrClass="mult_engy_building_health", increment=1.0},
    -- Pistol (secondary weapon, slot 1): ONLY the two requested upgrades.
    -- Index 5 = ordinary +50% clip size (not index 43: rocket atomic clip),
    -- index 2 = ordinary -10% post-fire delay. Costs below reflect the user's
    -- pistol station screenshot, not the generic MvM upgrade file defaults.
    {name="Pistol Clip Size", slot=1, id="5", candidates={"5"}, price=200, max=4,
     attrClass="mult_clipsize_upgrade", increment=0.5},
    {name="Pistol Firing Speed", slot=1, id="2", candidates={"2"}, price=100, max=4,
     attrClass="mult_postfiredelay", increment=-0.1},
    -- Confirmed by the user in v30: index 34 purchases Upgrade Buildings
    -- Canteens on their server. Restore automatic buying and replenishment.
    {name="Upgrade Buildings Canteens", slot=9, id="34", candidates={"34"},
     price=50, max=3, isCanteen=true},
}
-- Keep canteen last in the static queue, but always refill it first in the
-- purchasing priority check. These constants avoid accidental index drift.
local GP_EB_CANTEEN_INDEX = #GP_EB_STEPS
local GP_EB_PERMANENT_COUNT = GP_EB_CANTEEN_INDEX - 1
local GP_EB = {
    levels = {0, 0, 0, 0, 0, 0}, stage = 1, wave = nil, server = "", map = "",
    running = false, phase = "idle", nextAt = 0,
    beforeCash = nil, requestAt = 0, requestFails = 0,
    killWave = nil, pendingKillWave = nil, awaitingRespawn = false,
    hasSeenDeath = false, killAt = 0,
    pendingKillFromComplete = false, waveCompletedAt = 0,
    lastCompletedWave = nil, completedWave1 = false,
    missionComplete = false, waveLive = false,
    rebuyPending = false, rebuyArmedAt = 0,
    requestCount = 0, notice = "idle", noticeUntil = 0,
    lastAttemptCash = nil, lastAttemptWave = nil, lastAttemptAt = 0,
    triedCandidate = {1,1,1,1,1,1}, beforeLevel = 0,
    refundBeforeCash = nil, refundAt = 0, lastRefundId = nil,
    candidateRejects = 0,
    routeStartRequested = false,
    routeFinishedAt = 0,
    canteenConfirmed = false, deferredUpgradeReason = nil,
    canteenRetryAfter = 0, canteenFailureCount = 0,
    permanentBlockedUntil = 0, permanentBlockReason = "none",
    -- Observed attributes are authoritative once positively verified.
    -- Some PDA attributes are invisible through Lua; verified debit
    -- provides a fallback only for those particular upgrades.
    liveAttributeSeen = {false, false, false, false, false},
    lastPurchaseSnapshot = nil,
    liveEnteredAt = 0, fallbackSetupSince = 0,
}
-- A failed MvM wave repeats the SAME wave number, so ordinary wave-number
-- transitions cannot rearm the Engineer. Keep a separate, one-shot replay flag
-- through the server's mvm_reset_stats/round restart events.
local GP_EB_FailReplay = {
    pending = false, wave = nil, armedAt = 0, rearmed = false,
    server = "", map = "",
    -- Persistent evidence: some clients receive mvm_reset_stats BEFORE the
    -- failure event. Rebuilding must not depend on that event order.
    lastLiveWave = nil, lastLiveAt = 0, lastSuccessWave = nil,
    setupObservedSince = 0, routeStartedForWave = nil, observedActive = false
}
local function GP_EB_ClearFailReplay()
    GP_EB_FailReplay.pending = false
    GP_EB_FailReplay.wave = nil
    GP_EB_FailReplay.armedAt = 0
    GP_EB_FailReplay.rearmed = false
    GP_EB_FailReplay.server = ""
    GP_EB_FailReplay.map = ""
    GP_EB_FailReplay.setupObservedSince = 0
end

local function GP_EB_Enabled()
    return (config and config.autoBuyEnabled == true) or (forceSniperBuyModeEnabled == true)
end
local function GP_EB_IsEngineer(me)
    return (me ~= nil) and (GP_GetClassId(me) == 9)
end
local function GP_EB_Currency(me)
    if not (me and me.GetPropInt) then return nil end
    local ok, value = pcall(me.GetPropInt, me, "m_nCurrency")
    if ok and type(value) == "number" then return value end
    return nil
end
local function GP_EB_Notify(message, color)
    GP_EB.notice = tostring(message)
    GP_EB.noticeUntil = (globals and globals.CurTime and globals.CurTime() or 0) + 8
    if AddNotification then AddNotification("EngiBuy: " .. message, color or "info", 4.0) end
    if print then print("[EngiBuy] " .. tostring(message)) end
end
-- Forward declarations: GP_EB_Finish is defined before the bottle helpers.
-- Without these bindings, its v63 charge diagnostic resolves a nil GLOBAL
-- and raises an error at buyer completion, interrupting all post-buy steps.
local GP_EB_GetBottle, GP_EB_GetBottleCharges, GP_EB_BottleIsBuildingUpgrade
local function GP_EB_EndKV()
    local count = tonumber(GP_EB.requestCount) or 0
    pcall(function() engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "' .. tostring(count) .. '" }') end)
    GP_EB.requestCount = 0
end
local function GP_EB_ResetAll()
    if GP_EB.running then GP_EB_EndKV() end
    -- A CurTime rewind can reset this buyer while the failed wave reloads.
    -- Keep the replay request, but make the rebuy arming repeatable.
    if GP_EB_FailReplay.pending then
        GP_EB_FailReplay.rearmed = false
        GP_EB_FailReplay.armedAt = ((globals and globals.CurTime and globals.CurTime()) or 0) - 0.5
    end
    GP_EB.levels = {0, 0, 0, 0, 0, 0}
    GP_EB.liveAttributeSeen = {false, false, false, false, false}
    GP_EB.lastPurchaseSnapshot = nil
    GP_EB.stage = 1
    -- Keep proof of the Upgrade Buildings canteen type across a same-server
    -- round reset / failed wave. Losing this flag is why an equipped, filled
    -- bottle could stop activating after a failed-wave replay. Do NOT carry
    -- the proof to another map/server.
    local oldServer, oldMap = GP_EB.server or "", GP_EB.map or ""
    local nowServer = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    local nowMap = (engine and engine.GetMapName and engine.GetMapName()) or ""
    GP_EB.canteenConfirmed = (GP_EB.canteenConfirmed == true)
        and oldServer ~= "" and oldMap ~= ""
        and nowServer == oldServer and nowMap == oldMap
    GP_EB.deferredUpgradeReason = nil
    GP_EB.canteenRetryAfter, GP_EB.canteenFailureCount = 0, 0
    GP_EB.canteenReplicateUntil, GP_EB.warnedUnreadableBottle = 0, false
    GP_EB.permanentBlockedUntil, GP_EB.permanentBlockReason = 0, "none"
    if GP_EB_CanteenReset then GP_EB_CanteenReset() end
    GP_EB.wave = nil
    GP_EB.running = false
    GP_EB.phase = "idle"
    GP_EB.nextAt = 0
    GP_EB.beforeCash = nil
    GP_EB.requestAt = 0
    GP_EB.requestFails = 0
    GP_EB.killWave = nil
    GP_EB.pendingKillWave = nil
    GP_EB.pendingKillFromComplete = false
    GP_EB.waveCompletedAt = 0
    GP_EB.lastCompletedWave = nil
    GP_EB.completedWave1 = false
    GP_EB.missionComplete = false
    GP_EB.waveLive = false
    GP_EB.liveEnteredAt, GP_EB.fallbackSetupSince = 0, 0
    GP_EB.rebuyPending = false
    GP_EB.rebuyArmedAt = 0
    GP_EB.awaitingRespawn = false
    GP_EB.hasSeenDeath = false
    GP_EB.killAt = 0
    GP_EB._wasEngineer = false
    GP_EB.lastAttemptCash = nil
    GP_EB.lastAttemptWave = nil
    GP_EB.lastAttemptAt = 0
    GP_EB.routeStartRequested = false
    GP_EB.routeFinishedAt = 0
    GP_EB.runningSince = 0
    GP_EB.lastProgressAt = 0
    if GP_EB_MannhattanWave1RouteReset then GP_EB_MannhattanWave1RouteReset() end
    if GP_EB_RottenburgRepairDisarm then GP_EB_RottenburgRepairDisarm() end
    GP_EB.triedCandidate = {1,1,1,1,1,1}
    GP_EB.candidateRejects = 0
    for _, step in ipairs(GP_EB_STEPS) do step.id = step.candidates[1] end
end
GP_EB_Cancel = function()
    if GP_EB.running then GP_EB_EndKV() end
    GP_EB.running = false
    GP_EB.phase = "idle"
    GP_EB.beforeCash = nil
end
local function GP_EB_Finish(reason)
    if GP_EB.running then GP_EB_EndKV() end
    GP_EB.rebuyPending = false
    GP_EB.running = false
    GP_EB.runningSince = 0
    GP_EB.lastProgressAt = 0
    GP_EB.phase = "idle"
    GP_EB.beforeCash = nil
    GP_EB.lastAttemptWave = GP_EB.wave
    local player = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    GP_EB.lastAttemptCash = GP_EB_Currency(player)
    GP_EB.lastAttemptAt = (globals and globals.CurTime and globals.CurTime()) or 0
    isUpgradingSniper = false  -- Legacy state also gates automatic teleporter walking.
    sniperUpgradesComplete = true
    autobuyRunOnceDone = true
    gpPhase = "DONE"
    sniperUpgradeCooldownUntil = globals.CurTime() + 0.50
    if GP_OnSniperUpgradesComplete then
        GP_OnSniperUpgradesComplete("engi_queue_done") -- Existing TpWalk coupling.
    end
    -- Normal setup uses Wave 1; after a failed wave, repeat the exact
    -- 9-waypoint/build/pickup/TpWalk sequence even if the failed wave was 2+.
    -- Buy failures, lack of cash and unavailable canteens must NEVER cancel
    -- building setup. Buying and rebuilding are independent operations.
    -- Never let a stale completedWave1 flag launch the Wave-1 route after
    -- the buyer has already advanced to Wave 2+. That route otherwise races
    -- the Dispenser-only rebuild and can leave TpWalk in charge.
    local currentBuyWave = math.max(tonumber(GP_EB.wave) or 0,
        tonumber(GP_EB.killWave) or 0,
        (tonumber(GP_EB.lastCompletedWave) or 0) + 1)
    local firstSetup = (not GP_EB.completedWave1)
        and currentBuyWave < 2
        and (not (GP_EB.pendingKillWave and GP_EB.pendingKillWave >= 2))
    if not GP_EB.waveLive and GP_EB_MannhattanMap and GP_EB_MannhattanMap()
       and (firstSetup or GP_EB_FailReplay.pending) then
        GP_EB.routeStartRequested = true
        GP_EB.routeFinishedAt = globals.CurTime()
        if GP_EB_MannhattanWave1RouteStart then
            local started = GP_EB_MannhattanWave1RouteStart(GP_EB.wave)
            if started and GP_EB_FailReplay.pending then
                GP_EB_ClearFailReplay()
            end
        end
    end
    -- Non-Mannhattan maps do not have a custom setup route.
    if GP_EB_FailReplay.pending and not GP_EB_MannhattanMap() then
        GP_EB_ClearFailReplay()
    end
    if reason and GP_EB.stage and GP_EB.stage <= GP_EB_PERMANENT_COUNT
       and (reason:find("unavailable", 1, true)
         or reason:find("no verified index", 1, true)
         or reason:find("not applied", 1, true)) then
        GP_EB.permanentBlockedUntil = globals.CurTime() + 15.0
        GP_EB.permanentBlockReason = reason
        GP_EB_Notify("permanent upgrade refused; canteen refill has 15s priority", "warning")
    end
    if reason and (reason:find("canteen", 1, true) or reason:find("Canteen", 1, true)
        or reason:find("Bottle", 1, true) or reason:find("Power Up", 1, true))
       and reason ~= "all requested upgrades maxed" then
        GP_EB.canteenFailureCount = (GP_EB.canteenFailureCount or 0) + 1
        -- Permit retries, but do not keep EngiBuy busy every 0.8 seconds
        -- while a Dispenser is awaiting a between-wave repair.
        GP_EB.canteenRetryAfter = globals.CurTime() + math.min(15, 2 * GP_EB.canteenFailureCount)
    end
    if reason then GP_EB_Notify(reason, reason == "all requested upgrades maxed" and "success" or "info") end
    -- Log the real outcome of the refill *before* releasing the shop to
    -- Rottenburg's mandatory rebuilt Dispenser path. Do not claim a successful
    -- refill simply because the SendKeyValues call returned true.
    if player and GP_EB_IsEngineer(player) then
        local bottleCharges = GP_EB_GetBottleCharges(player)
        local balance = GP_EB_Currency(player)
        if print then
            print("[EngiBuy/refill v63] Upgrade Buildings charges=" ..
                (bottleCharges == nil and "unreadable" or tostring(bottleCharges) .. "/3") ..
                ", currency=" .. tostring(balance) .. ", finished=" .. tostring(reason))
        end
    end
    -- Rottenburg Wave 2+: inspect our own Dispenser after EngiBuy.
    -- Only missing/disconnected Dispensers trigger the repair route.
    -- Wave 1 retains its normal initial setup route.
    if GP_EB_RottenburgRepairAfterBuy then
        GP_EB_RottenburgRepairAfterBuy(GP_EB.wave)
    end
    -- EngiBuy's own completion callback is the authoritative hand-off.
    -- Call the route controller immediately, BEFORE TpWalk can move us.
    -- On MvM servers with broken between-wave netvars, its fresh verified
    -- shop handoff is enough to begin the route (unless combat is live).
    if GP_EB_RottenburgDispenserRepairTick then
        GP_EB_RottenburgDispenserRepairTick(player,
            (globals and globals.CurTime and globals.CurTime()) or 0, true)
    end
    GP_EB_PrintStatus("buyer finished")
end
-- TF2's action item is loadout slot 9. Only a CTFPowerupBottle is safe
-- to use; do NOT activate other action items or other canteen types.
GP_EB_GetBottle = function(me)
    if not me then return nil end
    local function isBottle(bottle)
        if not (bottle and bottle.GetPropInt) then return false end
        if bottle.IsValid then
            local validOk, valid = pcall(bottle.IsValid, bottle)
            if not validOk or not valid then return false end
        end
        -- GetClass() may return a server classname, a network class name or
        -- a client alias depending on the Lua build. Rely on the bottle-only
        -- replicated charge field instead of rejecting valid aliases.
        local propOk, count = pcall(bottle.GetPropInt, bottle, "m_usNumCharges")
        return propOk and type(count) == "number" and count >= 0 and count <= 6
    end
    if me.GetEntityForLoadoutSlot then
        local ok, bottle = pcall(me.GetEntityForLoadoutSlot, me, LOADOUT_POSITION_ACTION or 9)
        if ok and isBottle(bottle) then return bottle end
    end
    -- Some LMAOBOX/TF2 versions expose the action item only as a weapon
    -- entity handle when GetEntityForLoadoutSlot(9) is temporarily missing.
    if me.GetPropEntity then
        for _, prop in ipairs({"m_hPowerupBottle", "m_hActionItem"}) do
            local ok, bottle = pcall(me.GetPropEntity, me, prop)
            if ok and isBottle(bottle) then return bottle end
        end
    end
    if entities and entities.FindByClass and me.GetIndex then
        local okMe, myIndex = pcall(me.GetIndex, me)
        local bottles = {}
        for _, className in ipairs({"CTFPowerupBottle", "tf_powerup_bottle", "C_TFPowerupBottle"}) do
            local okList, found = pcall(entities.FindByClass, className)
            if okList and type(found) == "table" then
                for _, bottle in pairs(found) do bottles[#bottles+1] = bottle end
            end
        end
        if okMe and type(myIndex) == "number" then
            for _, bottle in pairs(bottles) do
                if isBottle(bottle) then
                    local ownerId = nil
                    if bottle.GetPropEntity then
                        local okOwner, owner = pcall(bottle.GetPropEntity, bottle, "m_hOwnerEntity")
                        if okOwner and owner and owner.GetIndex then
                            local okIndex, ix = pcall(owner.GetIndex, owner)
                            if okIndex then ownerId = ix end
                        end
                    end
                    if ownerId ~= myIndex and bottle.GetPropInt then
                        local okOwner, raw = pcall(bottle.GetPropInt, bottle, "m_hOwnerEntity")
                        if okOwner and type(raw) == "number" and raw >= 0 then
                            ownerId = raw % 2048
                        end
                    end
                    if ownerId == myIndex then return bottle end
                end
            end
        end
    end
    return nil
end
GP_EB_GetBottleCharges = function(me)
    local bottle = GP_EB_GetBottle(me)
    if not bottle then return nil end
    local ok, charges = pcall(bottle.GetPropInt, bottle, "m_usNumCharges")
    if not ok or type(charges) ~= "number" then return nil end
    return math.max(0, math.min(3, charges))
end
GP_EB_BottleIsBuildingUpgrade = function(bottle)
    if not bottle then return false end
    -- TF2 internally uses CALL_ATTRIB_HOOK_INT for the canteen's effect type.
    -- The previous version only checked AttributeHookFloat, which can miss
    -- this integer attribute after reloads, respawns, and wave failures.
    for _, attribute in ipairs({"building_instant_upgrade", "building instant upgrade"}) do
        if bottle.AttributeHookInt then
            local ok, value = pcall(bottle.AttributeHookInt, bottle, attribute, 0)
            if ok and type(value) == "number" and value > 0 then return true end
        end
        if bottle.AttributeHookFloat then
            local ok, value = pcall(bottle.AttributeHookFloat, bottle, attribute, 0)
            if ok and type(value) == "number" and value > 0 then return true end
        end
    end
    -- Don't activate known other effects just because a previous bottle was
    -- Buildings. This matters if the player manually refills another type.
    for _, other in ipairs({"critboost", "ubercharge", "recall", "refill_ammo"}) do
        if bottle.AttributeHookInt then
            local ok, value = pcall(bottle.AttributeHookInt, bottle, other, 0)
            if ok and type(value) == "number" and value > 0 then return false end
        end
    end
    -- AttributeHookInt is not guaranteed to expose the bottle's dynamic
    -- MvM effect on all clients, particularly if Lua is loaded mid-match.
    -- This dedicated Engineer automation always requests Upgrade Buildings
    -- (index 34). If there is NO positive evidence of a different effect,
    -- allow a refill instead of deadlocking at 1 or 2 charges indefinitely.
    -- A known Crit/Uber/Recall/Ammo effect is still blocked by the loop above.
    return true
end
local function GP_EB_ReadLevel(me, step)
    if step.isCanteen then return GP_EB_GetBottleCharges(me) end
    if not (me and me.AttributeHookFloat) then return nil end
    -- LMAOBOX's AttributeHookFloat takes attribute *class* names, e.g.
    -- mod_jump_height / mult_dispenser_radius, NOT the human readable schema names.
    local sources = {me}
    if me.GetEntityForLoadoutSlot then
        local slots = nil
        if step.slot == 5 then
            -- Engineer PDA1/PDA2: existing building-upgrade behavior.
            slots = {5, 6}
        elseif step.slot == 1 then
            -- Engineer's Pistol is the SECONDARY, not the primary shotgun.
            slots = {1}
        end
        if slots then
            for _, slot in ipairs(slots) do
                local ok, weapon = pcall(me.GetEntityForLoadoutSlot, me, slot)
                if ok and weapon then
                    local valid = true
                    if weapon.IsValid then
                        local okValid, isValid = pcall(weapon.IsValid, weapon)
                        valid = okValid and isValid == true
                    end
                    if valid then sources[#sources + 1] = weapon end
                end
            end
        end
    end
    local seenValue = nil
    for _, ent in ipairs(sources) do
        if ent and ent.AttributeHookFloat then
            local ok, value = pcall(ent.AttributeHookFloat, ent, step.attrClass, 1.0)
            if ok and type(value) == "number" and value >= 0 and value <= 10 then
                if seenValue == nil
                   or (step.increment < 0 and value < seenValue)
                   or (step.increment > 0 and value > seenValue) then
                    seenValue = value
                end
            end
        end
    end
    if seenValue == nil then return nil end
    -- Firing Speed reduces post-fire delay; convert 0.9 to level 1, etc.
    local level = math.floor(((seenValue - 1.0) / step.increment) + 0.25)
    return math.max(0, math.min(step.max, level))
end
-- v38: Read the live upgrade attributes and actual bottle charges before
-- EVERY purchase decision. Never use the cached stage as the source of truth.
-- Caveat: AttributeHookFloat sometimes returns its default 1.0 for Engineer
-- PDA upgrades even when a purchase succeeds. In that case we can only rely
-- on purchases that were confirmed by an exact server currency debit; these
-- fallback levels are cleared at failed-wave/session reset.
local function GP_EB_SyncObservedLevels(me)
    local observed = {}
    for i, step in ipairs(GP_EB_STEPS) do
        local live = GP_EB_ReadLevel(me, step)
        observed[i] = live
        if step.isCanteen then
            if live ~= nil then
                -- After a purchase, briefly preserve the debit-confirmed count
                -- until the bottle's charge netvar catches up.
                local pending = GP_EB.canteenReplicateUntil or 0
                local now = (globals and globals.CurTime and globals.CurTime()) or 0
                if now < pending then
                    GP_EB.levels[i] = math.max(live, GP_EB.levels[i] or 0)
                else
                    GP_EB.levels[i] = live
                end
            end
        elseif live ~= nil then
            if live > 0 then
                GP_EB.liveAttributeSeen[i] = true
                -- Live attribute changes (including lower levels) beat cache.
                GP_EB.levels[i] = live
            elseif GP_EB.liveAttributeSeen[i] then
                GP_EB.levels[i] = 0 -- observable attribute actually reset
            else
                -- No reliable attribute reading yet: preserve only the
                -- levels validated through this transaction's cash debits.
                GP_EB.levels[i] = GP_EB.levels[i] or 0
            end
        end
    end
    return observed
end
local function GP_EB_AdvanceStage()
    while GP_EB.stage <= #GP_EB_STEPS and
          (GP_EB.levels[GP_EB.stage] or 0) >= GP_EB_STEPS[GP_EB.stage].max do
        GP_EB.stage = GP_EB.stage + 1
    end
end

local function GP_EB_RecalculatePurchaseState(me, cash)
    -- Called when starting EngiBuy AND each time before SendMvMUpgrade.
    -- Do not call while a request is awaiting confirmation or a refund;
    -- in those phases, GP_EB.stage identifies that in-flight request.
    local observed = GP_EB_SyncObservedLevels(me)
    local missing = nil
    for i = 1, GP_EB_PERMANENT_COUNT do
        if (GP_EB.levels[i] or 0) < GP_EB_STEPS[i].max then
            missing = i
            break
        end
    end
    local canteen = GP_EB_STEPS[GP_EB_CANTEEN_INDEX]
    -- SyncObservedLevels has already reread the bottle's real charges, and
    -- temporarily preserves debit-confirmed purchases while that netvar
    -- replicates. Do not bypass that two-second grace period here.
    local charges = GP_EB.levels[GP_EB_CANTEEN_INDEX] or 0
    local chosen = missing
    GP_EB.deferredUpgradeReason = nil
    local now = (globals and globals.CurTime and globals.CurTime()) or 0
    local permanentBlocked = missing and now < (GP_EB.permanentBlockedUntil or 0)
    local bottle = GP_EB_GetBottle(me)
    -- A failed/refused canteen request must not starve *permanent* upgrades.
    -- Skip the bottle for this shop transaction until its retry cooldown ends.
    local canRefill = cash ~= nil and cash >= canteen.price
        and now >= (GP_EB.canteenRetryAfter or 0)
        and charges < canteen.max
        and (bottle == nil or charges == 0 or GP_EB_BottleIsBuildingUpgrade(bottle))
    if canRefill then
        -- If Lua can't see the wearable, still ask TF2 to buy the known
        -- $50 Upgrade Buildings upgrade (slot 9 / index 34). Never invent a
        -- success: only an exact currency debit or observed charge increase
        -- can confirm it. On rejection we stop after a bounded retry.
        -- v63: Restock Upgrade Buildings BEFORE expensive permanent upgrades.
        -- v62 selected those first; when the Dispenser route took over after
        -- EngiBuy, the bottle could be left at 0/1/2 charges for the wave.
        -- A verified refill costs $50 per charge, so buy as many as the
        -- current cash permits (up to three) before the delivery route starts.
        chosen = GP_EB_CANTEEN_INDEX
        GP_EB.deferredUpgradeReason = "priority refill to 3 Upgrade Buildings charges"
    elseif permanentBlocked then
        chosen = #GP_EB_STEPS + 1
    elseif not missing then
        -- Do not blindly purchase a different action item if the bottle is
        -- absent or the current effects are not Upgrade Buildings.
        chosen = #GP_EB_STEPS + 1
    end
    GP_EB.stage = chosen
    local tracked = {}
    for i = 1, #GP_EB_STEPS do tracked[i] = GP_EB.levels[i] end
    GP_EB.lastPurchaseSnapshot = {
        cash = cash, tracked = tracked,
        observed = observed, stage = chosen,
        time = (globals and globals.CurTime and globals.CurTime()) or 0
    }
    return chosen
end
-- v35: State diagnostics, without changing verified upgrade IDs or limits.
-- In particular, a second failure does not award extra credits by itself.
-- Print the real cash/level state rather than silently claiming a bug.
local function GP_EB_StatusLine()
    local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    local cash = GP_EB_Currency(me)
    local progress = {}
    for i, step in ipairs(GP_EB_STEPS) do
        local observed = GP_EB_ReadLevel(me, step)
        -- Show locally tracked levels AND independently observed values.
        -- A question mark means Lua cannot read the attribute reliably.
        progress[#progress + 1] = string.format("%s=%s/%s(observed:%s)",
            step.name, tostring(GP_EB.levels[i] or 0), tostring(step.max),
            observed == nil and "?" or tostring(observed))
    end
    local route = "inactive"
    if GP_EB_MannhattanWave1RouteStatus then
        route = GP_EB_MannhattanWave1RouteStatus() or "inactive"
    end
    return string.format(
        "wave=%s, money=%s, buyer=%s/%s, stage=%s, failPending=%s, rebuyPending=%s, respawnWait=%s, route=%s; %s; last=%s",
        tostring(GP_EB.wave), tostring(cash or "unavailable"),
        tostring(GP_EB.running), tostring(GP_EB.phase), tostring(GP_EB.stage),
        tostring(GP_EB_FailReplay.pending), tostring(GP_EB.rebuyPending),
        tostring(GP_EB.awaitingRespawn), tostring(route),
        table.concat(progress, ", "), tostring(GP_EB.notice))
end
function GP_EB_PrintStatus(reason)
    if print then
        print("[EngiBuy/status] " .. tostring(reason or "snapshot") .. ": " .. GP_EB_StatusLine())
    end
end
function GP_EB_HoldAutoReady()
    if not GP_EB_Enabled() then return false end
    -- Don't ready up while the failed wave's Engineer rebuild is pending,
    -- or while its route is placing/picking up and delivering buildings.
    if GP_EB_FailReplay.pending then return true end
    if GP_EB_RottenburgRepairNeedsTime and GP_EB_RottenburgRepairNeedsTime() then return true end
    if GP_EB_MannhattanWave1RouteActive and GP_EB_MannhattanWave1RouteActive() then
        return true
    end
    if GP_EB.routeStartRequested and GP_EB_MannhattanMap and GP_EB_MannhattanMap() then
        return true
    end
    if GP_EB.pendingKillWave ~= nil or GP_EB.awaitingRespawn then return true end
    if GP_EB.running then return true end
    if GP_EB.rebuyPending then
        local now = (globals and globals.CurTime and globals.CurTime()) or 0
        if now - (GP_EB.rebuyArmedAt or now) < 20.0 then return true end
        -- Failsafe: never hold everyone in setup forever if the station can't be reached.
        GP_EB.rebuyPending = false
        GP_EB_Notify("wave rebuy timed out; AutoF4 restored", "warning")
    end
    return false
end
local function GP_EB_ArmRebuy(wave, fromComplete, now)
    if type(wave) ~= "number" or wave < 1 then return false end
    if GP_EB.killWave == wave then return false end
    if GP_EB.pendingKillWave ~= wave then
        GP_EB.pendingKillWave = wave
        if GP_EB_RottenburgRepairClearPostBuy then
            GP_EB_RottenburgRepairClearPostBuy()
        end
        GP_EB_Cancel()
        -- Re-evaluate permanent upgrades and refill consumed canteen charges
        -- at the start of *every* wave rather than keeping stage 5 forever.
        GP_EB.stage = 1
        -- A hidden wearable must not leave the previous wave's cached 3/3
        -- count in place forever. Re-probe each fresh wave at the station.
        local player = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
        GP_EB.levels[GP_EB_CANTEEN_INDEX] = (GP_EB_GetBottleCharges and GP_EB_GetBottleCharges(player)) or 0
        GP_EB.canteenReplicateUntil = 0
        GP_EB.warnedUnreadableBottle = false
        GP_EB.deferredUpgradeReason = nil
        -- Give the bottle one fresh chance on each new wave, but never let
        -- a rejected refill keep the permanent-upgrade queue from advancing.
        GP_EB.canteenRetryAfter, GP_EB.canteenFailureCount = 0, 0
        GP_EB.permanentBlockedUntil, GP_EB.permanentBlockReason = 0, "none"
        sniperUpgradesComplete = false
        sniperUpgradeCompleted = false
        sniperUpgradeCompletedTime = 0
        autobuyRunOnceDone = false
        autobuyDoneAnnounced = false
        gpPhase = "SNIPER_BUY" -- Legacy internal phase name.
        GP_EB.lastAttemptWave = nil
    end
    GP_EB.rebuyPending = true
    GP_EB.rebuyArmedAt = now
    if fromComplete then
        GP_EB.pendingKillFromComplete = true
        GP_EB.waveCompletedAt = now
    end
    return true
end
-- Canteens are optional to the permanent-upgrade buyer. Previously, a
-- missing/unreadable bottle or rejected index 34 would call GP_EB_Finish,
-- releasing the shop to TpWalk before Jump/Dispenser/Health could be bought.
-- Keep the MVM_UpgradesBegin session open and continue to permanent upgrades.
local function GP_EB_SkipCanteenForThisBuy(reason, now)
    now = tonumber(now) or ((globals and globals.CurTime and globals.CurTime()) or 0)
    GP_EB.canteenFailureCount = (GP_EB.canteenFailureCount or 0) + 1
    GP_EB.canteenRetryAfter = now + 30.0
    GP_EB.canteenReplicateUntil = 0
    GP_EB.candidateRejects = 0
    GP_EB.requestFails = 0
    GP_EB.beforeCash = nil
    GP_EB.phase = "ready"
    GP_EB.nextAt = now + 0.15
    GP_EB.lastProgressAt = now
    GP_EB_Notify("canteen refill skipped (" .. tostring(reason) .. "); continuing permanent upgrades", "warning")
end

local function GP_EB_Start(me)
    if not GP_EB_Enabled() or not GP_EB_IsEngineer(me) or not me:IsAlive() then return false end
    if GP_EB.running or GP_EB.awaitingRespawn or isExploiting then return false end
    if (upgradeQueue and #upgradeQueue > 0) or isUpgradingSniper then return false end
    if (me:GetPropInt("m_bInUpgradeZone") ~= 1) then return false end
    if GP_EB_Currency(me) == nil then
        GP_EB_Notify("can't read m_nCurrency", "warning")
        return false
    end
    GP_EB_RecalculatePurchaseState(me, GP_EB_Currency(me))
    if GP_EB.stage > #GP_EB_STEPS then
        GP_EB_Finish("all requested upgrades maxed")
        return true
    end
    local ok = engine.SendKeyValues('"MVM_UpgradesBegin" {}')
    if not ok then return false end
    GP_EB.running = true
    GP_EB.runningSince = globals.CurTime()
    GP_EB.lastProgressAt = GP_EB.runningSince
    GP_EB.phase = "ready"
    GP_EB.requestFails = 0
    GP_EB.requestCount = 0
    GP_EB.refundBeforeCash = nil
    GP_EB.candidateRejects = 0
    GP_EB.nextAt = globals.CurTime() + 0.12
    sniperUpgradesComplete = false
    sniperUpgradeCompleted = false
    sniperUpgradeCompletedTime = 0
    teleporterJustUsed = false
    tpLastReachedTeleporterAt = 0
    teleporterConfig.autoWalkEnabled = false
    teleporterManuallyDisabled = false
    GP_EB_Notify("upgrading: Upgrade Buildings Canteens first, then permanent upgrades")
    if print then print("[EngiBuy v64] canteen check: charges=" ..
        tostring(GP_EB_GetBottleCharges(me)) .. ", bottleVisible=" ..
        tostring(GP_EB_GetBottle(me) ~= nil) .. ", currency=" ..
        tostring(GP_EB_Currency(me)) .. ", upgradeIndex=34, actionSlot=9") end
    return true
end
-- Centralized failed-wave setup rearm. It is independent of how many
-- permanent upgrades/canteens are bought on the repeated same-numbered wave.
local function GP_EB_BeginFailedSetup(reason, now)
    if GP_EB_FailReplay.pending or GP_EB.missionComplete then return false end
    local failedWave = tonumber(GP_EB.wave) or
        tonumber((GP_GetWaveNumber and GP_GetWaveNumber()) or nil) or
        tonumber((GP_RST and GP_RST.lastReliableWave) or nil) or 1
    failedWave = math.max(1, failedWave)
    GP_EB_FailReplay.pending = true
    GP_EB_FailReplay.routeStartedForWave = nil
    GP_EB_FailReplay.setupObservedSince = 0
    GP_EB_FailReplay.wave = failedWave
    GP_EB_FailReplay.armedAt = now
    GP_EB_FailReplay.rearmed = false
    GP_EB_FailReplay.server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    GP_EB_FailReplay.map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    GP_EB_Cancel()
    GP_EB.waveLive = false
    GP_EB.liveEnteredAt, GP_EB.fallbackSetupSince = 0, 0
    GP_EB.killWave = nil
    GP_EB.pendingKillWave = nil
    GP_EB.pendingKillFromComplete = false
    GP_EB.awaitingRespawn = false
    GP_EB.hasSeenDeath = false
    GP_EB.rebuyPending = true
    GP_EB.rebuyArmedAt = now
    -- v36 FIX: the server can roll back upgrades bought during the failed
    -- wave. The previous code reset only stage=1, but left GP_EB.levels
    -- untouched. The buyer then skipped upgrades it thought were still maxed.
    -- Discard the permanent-upgrade cache once per confirmed failure. The
    -- existing GP_EB_SyncObservedLevels() call at the upgrade station will
    -- restore levels that the server really kept, if their attributes are
    -- observable. Canteen charges are also reread from the equipped bottle.
    local liveBottleCharges = nil
    do
        local player = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
        liveBottleCharges = GP_EB_GetBottleCharges(player)
    end
    GP_EB.levels = {0, 0, 0, 0, 0, liveBottleCharges or 0}
    GP_EB.liveAttributeSeen = {false, false, false, false, false}
    GP_EB.lastPurchaseSnapshot = nil
    GP_EB.stage = 1
    GP_EB.triedCandidate = {1, 1, 1, 1, 1, 1}
    GP_EB.candidateRejects = 0
    for _, upgrade in ipairs(GP_EB_STEPS) do
        upgrade.id = upgrade.candidates[1]
    end
    GP_EB.deferredUpgradeReason = nil
    GP_EB.lastAttemptWave = nil
    GP_EB.lastAttemptAt = 0
    GP_EB.routeStartRequested = false
    sniperUpgradesComplete, sniperUpgradeCompleted = false, false
    sniperUpgradeCompletedTime = 0
    sniperReloadAwaitRespawn, sniperReloadRespawnPending = false, false
    autobuyRunOnceDone, autobuyDoneAnnounced = false, false
    gpPhase = "SNIPER_BUY" -- Legacy compatibility name only.
    teleporterJustUsed = false
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
    if GP_TP_ResetPathState then GP_TP_ResetPathState() end
    if GP_TP_ResetStuckTracker then GP_TP_ResetStuckTracker() end
    if GP_EB_MannhattanWave1RouteReset then GP_EB_MannhattanWave1RouteReset() end
    if GP_EB_RottenburgRepairDisarm then GP_EB_RottenburgRepairDisarm() end
    GP_EB_Notify("wave " .. failedWave .. " failed (" .. tostring(reason or "event") .. "); repeating Engineer setup", "warning")
    GP_EB_PrintStatus("failed wave detected")
    return true
end

local function GP_EB_WaveTick(me, now)
    if not GP_EB_Enabled() then
        GP_EB_Cancel()
        return
    end
    local ip = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    if ip == "" or map == "" then return end
    if (GP_EB.server ~= ip) or (GP_EB.map ~= map) then
        if GP_EB.server ~= "" and GP_EB.map ~= "" then
            -- A genuinely different server/map must not inherit the last
            -- match's live-wave evidence.
            GP_EB_FailReplay.lastLiveWave = nil
            GP_EB_FailReplay.lastLiveAt = 0
            GP_EB_FailReplay.lastSuccessWave = nil
            GP_EB_FailReplay.observedActive = false
            GP_EB_FailReplay.routeStartedForWave = nil
        end
        if GP_EB_FailReplay.pending and
           ((GP_EB_FailReplay.server ~= "" and GP_EB_FailReplay.server ~= ip) or
            (GP_EB_FailReplay.map ~= "" and GP_EB_FailReplay.map ~= map)) then
            GP_EB_ClearFailReplay() -- A genuinely different match, not a failed wave.
        end
        GP_EB_ResetAll()
        GP_EB.server, GP_EB.map = ip, map
    end
    -- A return to setup on the SAME wave after a live wave implies a
    -- failure, even if the event never reached Lua or a stats reset cleared
    -- waveLive. Require stable setup and avoid successful wave transitions.
    local setupNow = GP_TP_IsSetupPhase and GP_TP_IsSetupPhase() == true
    if GP_EB.waveLive and not setupNow then
        GP_EB_FailReplay.observedActive = true
    end
    local lastLive = GP_EB_FailReplay.lastLiveWave
    local observed = tonumber((GP_GetWaveNumber and GP_GetWaveNumber()) or nil)
        or tonumber(GP_EB.wave)
    local sameWaveReplayed = type(lastLive)=="number"
        and GP_EB_FailReplay.observedActive == true
        and GP_EB_FailReplay.routeStartedForWave ~= lastLive
        and (observed == nil or lastLive == observed)
        and GP_EB_FailReplay.lastSuccessWave ~= lastLive
        and (now - (GP_EB_FailReplay.lastLiveAt or now)) >= 2.0
    if not GP_EB_FailReplay.pending and sameWaveReplayed and setupNow then
        if GP_EB_FailReplay.setupObservedSince <= 0 then
            GP_EB_FailReplay.setupObservedSince = now
        elseif now - GP_EB_FailReplay.setupObservedSince >= 0.85 then
            GP_EB_BeginFailedSetup("same wave returned to setup", now)
        end
    elseif not setupNow then
        GP_EB_FailReplay.setupObservedSince = 0
    end
    if GP_EB.waveLive and sameWaveReplayed and setupNow then
        GP_EB.waveLive = false
        GP_EB.liveEnteredAt = 0
    end
    if GP_EB_FailReplay.pending and not GP_EB_FailReplay.rearmed
       and (now < GP_EB_FailReplay.armedAt or (now - GP_EB_FailReplay.armedAt) >= 0.40) then
        -- On a failure the wave counter normally DOES NOT increment. Clear
        -- its previous kill guard and rearm once at the same wave number.
        local failedWave = tonumber(GP_EB_FailReplay.wave) or 1
        if GP_EB.killWave == failedWave then GP_EB.killWave = nil end
        GP_EB_ArmRebuy(failedWave, false, now)
        GP_EB_FailReplay.rearmed = true
    end
    local w = (GP_GetWaveNumber and GP_GetWaveNumber()) or nil
    if type(w) == "number" and w >= 1 then
        if GP_EB.wave and w < GP_EB.wave and not GP_EB_FailReplay.pending then
            GP_EB_ResetAll() -- A genuinely new mission/restarted wave counter.
        elseif GP_EB.wave and w > GP_EB.wave then
            GP_EB_ArmRebuy(w, false, now)
            GP_EB.routeStartRequested = false
            if GP_EB_MannhattanWave1RouteReset
               and not (GP_EB_RottenburgRepairRouteInProgress
                        and GP_EB_RottenburgRepairRouteInProgress()) then
                GP_EB_MannhattanWave1RouteReset()
            end
        end
        GP_EB.wave = w
    end
    if not GP_EB_IsEngineer(me) then
        if GP_EB._wasEngineer then
            GP_EB_Cancel()
            GP_EB.levels = {0, 0, 0, 0, 0, 0}
            GP_EB.liveAttributeSeen = {false, false, false, false, false}
            GP_EB.lastPurchaseSnapshot = nil
            GP_EB.stage = 1
        end
        GP_EB._wasEngineer = false
        return
    end
    -- On first enabling as Engineer during setup, one death returns us to the station.
    -- Also covers Wave 1 and starting the script during a later wave's setup.
    if (not GP_EB._wasEngineer) and GP_EB.wave
       and GP_EB.pendingKillWave == nil and GP_EB.killWave ~= GP_EB.wave
       and not GP_EB.waveLive
       and (GP_TP_IsSetupPhase and GP_TP_IsSetupPhase()) then
        GP_EB_ArmRebuy(GP_EB.wave, false, now)
    end
    GP_EB._wasEngineer = true
    if GP_EB.awaitingRespawn then
        local alive = me and me.IsAlive and me:IsAlive()
        if not alive then GP_EB.hasSeenDeath = true end
        if GP_EB.hasSeenDeath and alive then
            GP_EB.awaitingRespawn = false
            GP_EB.hasSeenDeath = false
            sniperReloadAwaitRespawn = false
            sniperReloadRespawnPending = false
            sniperLastAliveState = true
            GP_EB_Notify("respawned; resuming upgrades")
        elseif (now - GP_EB.killAt) >= 6.0 then
            GP_EB.awaitingRespawn = false
            sniperReloadAwaitRespawn = false
            GP_EB_Notify("kill did not cause respawn; retry buying", "warning")
        else
            return
        end
    end
    if GP_EB.pendingKillWave and GP_EB.pendingKillWave == GP_EB.killWave then
        GP_EB.pendingKillWave = nil
        GP_EB.pendingKillFromComplete = false
    end
    if GP_EB.pendingKillWave and GP_EB.killWave ~= GP_EB.pendingKillWave then
        local setup = (GP_TP_IsSetupPhase and GP_TP_IsSetupPhase()) or false
        if not setup and GP_GetRoundState then
            local state = GP_GetRoundState()
            setup = (state == 3 or state == 10) -- between rounds / setup
        end
        if not setup and entities and entities.FindByClass then
            local o = entities.FindByClass("CTFObjectiveResource")
            local obj = o and o[1]
            if obj and obj.GetPropInt then
                local ok, v = pcall(obj.GetPropInt, obj, "m_bMannVsMachineBetweenWaves")
                setup = (ok and v == 1)
            end
        end
        -- Some MvM servers report false/unknown setup flags between waves.
        -- mvm_wave_complete is an explicit safe boundary; it is stronger than
        -- the unreliable setup netvar and valid until mvm_begin_wave arrives.
        local eventSafe = GP_EB.pendingKillFromComplete
            and not GP_EB.waveLive
            and (now - (GP_EB.waveCompletedAt or now)) >= 0.20
        local canKill = (eventSafe or (setup and not GP_EB.missionComplete))
            and not GP_EB.missionComplete
        if canKill and me and me.IsAlive and not isExploiting then
            GP_EB_Cancel()
            local waveToKill = GP_EB.pendingKillWave
            GP_EB.killWave = waveToKill
            GP_EB.pendingKillWave = nil
            GP_EB.pendingKillFromComplete = false
            GP_EB.awaitingRespawn = true
            GP_EB.hasSeenDeath = not me:IsAlive()
            GP_EB.killAt = now
            sniperReloadAwaitRespawn = true
            sniperReloadRespawnPending = true
            sniperLastAliveState = not GP_EB.hasSeenDeath
            if not GP_EB.hasSeenDeath then
                pcall(function() client.Command("kill", true) end)
                GP_EB_Notify("wave " .. tostring(waveToKill) .. " - killbind for upgrades")
            else
                GP_EB_Notify("wave " .. tostring(waveToKill) .. " - already dead; buying after respawn")
            end
            return
        end
    end
    if GP_EB.pendingKillWave then
        -- Keep kill pending for a later setup tick but allow shopping in upgrade zone
        -- (some servers do not expose a reliable setup flag).
        local inzone = false
        if me and me.GetPropInt then
            local ok, v = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
            inzone = ok and v == 1
        end
        if not inzone then return end
    end
    -- Run the Engineer buyer even when the old SniperBuy phase/respawn gate is stale.
    -- When a same-wave failure is being confirmed, don't initiate a new
    -- upgrade transaction just before the once-only failed-wave rebuy.
    if not GP_EB.running and not (sameWaveReplayed and setupNow and not GP_EB_FailReplay.pending)
       and me and me.IsAlive and me:IsAlive() and not isExploiting then
        local okZone, inZone = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
        local currentCash = GP_EB_Currency(me)
        local changed = currentCash ~= nil and currentCash ~= GP_EB.lastAttemptCash
        local changedWave = GP_EB.wave ~= GP_EB.lastAttemptWave
        -- Charges can be spent without changing credits or wave number.
        -- Re-enter the buyer when standing at the station with an unfilled bottle.
        local bottleCharges = GP_EB_GetBottleCharges(me)
        GP_EB.lastBottleCharges = bottleCharges
        local needsCanteenRefill = bottleCharges ~= nil and bottleCharges < 3
            and currentCash ~= nil and currentCash >= GP_EB_STEPS[GP_EB_CANTEEN_INDEX].price
            and now >= (GP_EB.canteenRetryAfter or 0)
        local deliveryRouteActive = GP_EB_RottenburgRepairRouteInProgress
            and GP_EB_RottenburgRepairRouteInProgress()
        local rebuildHandoffQueued = GP_EB_MapIsRottenburg
            and GP_EB_MapIsRottenburg()
            and GP_EB_ROTTENBURG_REPAIR
            and GP_EB_ROTTENBURG_REPAIR.postBuyPending
        if okZone and inZone == 1 and not GP_EB.awaitingRespawn
           and not deliveryRouteActive and not rebuildHandoffQueued
           and (changed or changedWave or needsCanteenRefill or (not sniperUpgradesComplete))
           and (now - (GP_EB.lastAttemptAt or 0) > 0.8) then
            GP_EB_Start(me)
        end
    end
    if not GP_EB.running then return end
    if now < GP_EB.nextAt then return end
    if not me or not me.IsAlive or not me:IsAlive() or me:GetPropInt("m_bInUpgradeZone") ~= 1 then
        GP_EB_Cancel()
        return
    end
    -- The live snapshot is taken at the actual purchase decision below,
    -- not only on entering the station or once at the start of the wave.
    -- A wrong upgrade must be refunded, NOT counted as successful just because
    -- credits went down. This prevented the previous script from noticing that
    -- ID 58 was buying Crit Resistance instead of Jump Height.
    if GP_EB.phase == "reverting" then
        local cash = GP_EB_Currency(me)
        if cash and GP_EB.refundBeforeCash and cash > GP_EB.refundBeforeCash then
            -- The shop has refunded the mistaken purchase.
            GP_EB.requestCount = math.max(0, (GP_EB.requestCount or 0) - 1)
            local step = GP_EB_STEPS[GP_EB.stage]
            local nextCandidate = (GP_EB.triedCandidate[GP_EB.stage] or 1) + 1
            if step and step.candidates[nextCandidate] then
                GP_EB.triedCandidate[GP_EB.stage] = nextCandidate
                step.id = step.candidates[nextCandidate]
                GP_EB.candidateRejects = 0
                GP_EB_Notify("trying " .. step.name .. " index " .. step.id .. " after refund", "warning")
                GP_EB.phase = "ready"
                GP_EB.nextAt = now + 0.20
            else
                if step and step.isCanteen then
                    GP_EB_SkipCanteenForThisBuy("no verified canteen index", now)
                else
                    GP_EB_Finish("no verified index for " .. (step and step.name or "upgrade") .. "; stopped safely")
                end
            end
        elseif (now - (GP_EB.refundAt or now)) > 1.5 then
            GP_EB_Finish("could not CONFIRM refund of incorrect upgrade! Check station before continuing")
        end
        return
    end
    if GP_EB.phase == "waiting" then
        local cash = GP_EB_Currency(me)
        if cash == nil then GP_EB_Finish("couldn't read currency; stopped"); return end
        local step = GP_EB_STEPS[GP_EB.stage]
        if not step then GP_EB_Finish("all requested upgrades maxed"); return end
        local observed = GP_EB_ReadLevel(me, step)
        local bought = (cash < (GP_EB.beforeCash or cash))
        local targetChanged = (observed ~= nil and observed > (GP_EB.beforeLevel or 0))
        if step.isCanteen and targetChanged then
            -- Only a charge increase AND the expected $50 debit confirm this
            -- specific purchase. A delayed charge update from a prior
            -- request must not hide an unrelated server-side debit.
            local spentNow = (GP_EB.beforeCash or cash) - cash
            if not bought or spentNow ~= step.price then
                targetChanged = false
            end
        end
        if targetChanged then
            if step.isCanteen then
                GP_EB.canteenConfirmed = true
                GP_EB.canteenFailureCount, GP_EB.canteenRetryAfter = 0, 0
                GP_EB.canteenReplicateUntil = now + 0.8
            else
                GP_EB.liveAttributeSeen[GP_EB.stage] = true
            end
            GP_EB.levels[GP_EB.stage] = math.min(step.max, math.max(GP_EB.levels[GP_EB.stage]+1, observed))
            GP_EB.phase = "ready"
            GP_EB.lastProgressAt = now
            GP_EB.candidateRejects = 0
            GP_EB.nextAt = now + 0.16
            GP_EB_AdvanceStage()
            return
        end
        -- Currency and attribute replication can lag behind the sent request.
        if (now - GP_EB.requestAt) < 1.55 then return end
        if bought then
            local spent = (GP_EB.beforeCash or cash) - cash
            -- Building upgrades live on an item (PDA), and their attributes
            -- sometimes are not observable through local Lua hooks immediately.
            -- If the server deducted EXACTLY the expected PDA/Pistol cost
            -- on the correct slot, count the purchase instead of
            -- incorrectly refunding it just because AttributeHookFloat lagged.
            if (step.slot == 5 or step.slot == 1) and spent == step.price then
                GP_EB.levels[GP_EB.stage] = math.min(step.max,
                    math.max(GP_EB.levels[GP_EB.stage] + 1, observed or 0))
                GP_EB.phase = "ready"
                GP_EB.lastProgressAt = now
                GP_EB.candidateRejects = 0
                GP_EB.nextAt = now + 0.16
                GP_EB_AdvanceStage()
                GP_EB_Notify(step.name .. " purchased ($" .. spent .. "; attribute not readable yet)", "success")
                return
            end
            -- Bottle charge replication can lag after a valid purchase.
            -- For the confirmed Upgrade Buildings index, an exact $50 debit
            -- is evidence of a successful purchase even if charges are stale.
            if step.isCanteen and spent == step.price then
                GP_EB.canteenConfirmed = true
                GP_EB.canteenFailureCount, GP_EB.canteenRetryAfter = 0, 0
                GP_EB.canteenReplicateUntil = now + 2.0
                GP_EB.levels[GP_EB.stage] = math.min(step.max,
                    math.max((GP_EB.levels[GP_EB.stage] or 0) + 1, observed or 0))
                GP_EB.phase = "ready"
                GP_EB.lastProgressAt = now
                GP_EB.candidateRejects = 0
                GP_EB.nextAt = now + 0.35
                GP_EB_Notify("Upgrade Buildings canteen purchased ($" .. spent .. ")", "success")
                return
            end
            -- An unexpected debit is NOT proof of a correct purchase.
            -- Attempt rollback rather than counting it blindly.
            local refunded = SendMvMUpgrade(step.slot, step.id, -1)
            if refunded then
                GP_EB.refundBeforeCash = cash
                GP_EB.refundAt = now
                GP_EB.phase = "reverting"
                GP_EB.nextAt = now + 0.08
                GP_EB_Notify("index " .. step.id .. " did NOT raise " .. step.name .. "; refunding", "warning")
            else
                GP_EB_Finish("wrong upgrade bought; could not send refund; stop and check upgrades")
            end
            return
        end
        -- If the server rejected the request (or did not apply it), retry once.
        if step.isCanteen and print then
            print("[EngiBuy v64] canteen request not confirmed: cash=" .. tostring(cash) ..
                  ", beforeCash=" .. tostring(GP_EB.beforeCash) ..
                  ", observedCharges=" .. tostring(observed) ..
                  ", slot=" .. tostring(step.slot) .. ", index=" .. tostring(step.id))
        end
        -- Previous v3 stopped immediately here, so it never reached the fallback
        -- ID when 22/20 were not valid on the current server.
        GP_EB.requestCount = math.max(0, (GP_EB.requestCount or 0) - 1)
        if (GP_EB.candidateRejects or 0) < 1 then
            GP_EB.candidateRejects = 1
            GP_EB.phase = "ready"
            GP_EB.nextAt = now + 0.30
            GP_EB_Notify(step.name .. " index " .. step.id .. " not applied; retry once", "warning")
            return
        end
        GP_EB.candidateRejects = 0
        local nextCandidate = (GP_EB.triedCandidate[GP_EB.stage] or 1) + 1
        if step.candidates[nextCandidate] then
            GP_EB.triedCandidate[GP_EB.stage] = nextCandidate
            step.id = step.candidates[nextCandidate]
            GP_EB.phase = "ready"
            GP_EB.nextAt = now + 0.30
            GP_EB_Notify(step.name .. " rejected; switching to ID " .. step.id, "warning")
        else
            if step.isCanteen then
                GP_EB_SkipCanteenForThisBuy("server refused ID " .. tostring(step.id), now)
            else
                GP_EB_Finish(step.name .. " unavailable at ID " .. step.id .. "; no more safe candidates")
            end
        end
        return
    end
    local cash = GP_EB_Currency(me)
    if cash == nil then GP_EB_Finish("couldn't read currency"); return end
    -- Fresh check every attempt, even after a partially successful purchase,
    -- canteen consumption, external upgrade purchase or failed-wave rollback.
    GP_EB_RecalculatePurchaseState(me, cash)
    if GP_EB.stage > #GP_EB_STEPS then
        GP_EB_Finish("all requested upgrades maxed")
        return
    end
    local step = GP_EB_STEPS[GP_EB.stage]
    if step.isCanteen then
        local bottle = GP_EB_GetBottle(me)
        local currentCharges = GP_EB_GetBottleCharges(me)
        -- Only block a positively identified different canteen effect;
        -- unknown bottle visibility must not block ALL canteen purchases.
        if bottle and currentCharges and currentCharges > 0
           and not GP_EB_BottleIsBuildingUpgrade(bottle) then
            -- A different loaded effect should not block jump/PDA upgrades.
            GP_EB_SkipCanteenForThisBuy("different canteen effect equipped", now)
            return
        end
        if not bottle and not GP_EB.warnedUnreadableBottle then
            GP_EB.warnedUnreadableBottle = true
            GP_EB_Notify("bottle entity unreadable; trying $50 refill by confirmed currency debit", "warning")
        end
    end
    if cash < step.price then
        local reason = "need $" .. step.price .. " for " .. step.name .. " (have $" .. cash .. ")"
        GP_EB_Finish(reason)
        return
    end
    local before = GP_EB_ReadLevel(me, step)
    if step.isCanteen and print then
        print("[EngiBuy v64] requesting Upgrade Buildings: index=" .. tostring(step.id) ..
              ", slot=" .. tostring(step.slot) .. ", beforeCash=" .. tostring(cash) ..
              ", beforeCharges=" .. tostring(before))
    end
    local ok = SendMvMUpgrade(step.slot, step.id, 1)
    if not ok then
        GP_EB.requestFails = GP_EB.requestFails + 1
        if GP_EB.requestFails >= 5 then
            if step.isCanteen then
                GP_EB_SkipCanteenForThisBuy("SendMvMUpgrade rejected", now)
            else
                GP_EB_Finish("server send failed for " .. step.name)
            end
        else
            GP_EB.nextAt = now + 0.25
        end
        return
    end
    GP_EB.requestFails = 0
    GP_EB.requestCount = (GP_EB.requestCount or 0) + 1
    GP_EB.beforeCash = cash
    GP_EB.beforeLevel = math.max(before or 0, GP_EB.levels[GP_EB.stage] or 0)
    GP_EB.requestAt = now
    GP_EB.phase = "waiting"
    GP_EB.nextAt = now + 0.08
end
-- Track a full retry/reconnect, even when the IP and map are unchanged.
-- Detection is separate from the intentional killbind after placing Exit.
GP_EB_Session = {hadSession=false, lostSession=false, missingSince=nil,
    lastCurTime=nil, lastServer="", lastMap=""}
function GP_EB_SessionTick()
    local now = (globals and globals.CurTime and globals.CurTime()) or 0
    local realNow = (globals and globals.RealTime and globals.RealTime()) or now
    local server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    local connected = (server ~= "" and map ~= "" and me ~= nil)
    local rewind = GP_EB_Session.lastCurTime and now + 2 < GP_EB_Session.lastCurTime
    if GP_EB_Session.hadSession and not connected then
        if not GP_EB_Session.missingSince then GP_EB_Session.missingSince = realNow end
        if realNow - GP_EB_Session.missingSince >= 0.75 then
            GP_EB_Session.lostSession = true
        end
    elseif connected then
        GP_EB_Session.missingSince = nil
    end
    local changedServer = connected and GP_EB_Session.hadSession
        and (GP_EB_Session.lastServer ~= server or GP_EB_Session.lastMap ~= map)
    if connected and (rewind or changedServer or GP_EB_Session.lostSession) then
        GP_EB_FailReplay.lastLiveWave = nil
        GP_EB_FailReplay.lastLiveAt = 0
        GP_EB_FailReplay.lastSuccessWave = nil
        GP_EB_FailReplay.observedActive = false
        GP_EB_FailReplay.routeStartedForWave = nil
        GP_EB_ResetAll()
        sniperUpgradesComplete = false
        sniperUpgradeCompleted = false
        sniperUpgradeCompletedTime = 0
        sniperReloadAwaitRespawn = false
        sniperReloadRespawnPending = false
        autobuyRunOnceDone = false
        autobuyDoneAnnounced = false
        gpPhase = "SNIPER_BUY" -- Legacy phase identifier retained for other code.
        if GP_TP_ResetPathState then GP_TP_ResetPathState() end
        if GP_TP_ResetStuckTracker then GP_TP_ResetStuckTracker() end
        teleporterJustUsed = false
        if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
        GP_EB_Notify("session changed/retry detected - EngiBuy and route reset", "info")
        GP_EB_Session.lostSession = false
    end
    if connected then
        GP_EB_Session.hadSession = true
        GP_EB_Session.lastServer, GP_EB_Session.lastMap = server, map
    end
    GP_EB_Session.lastCurTime = now
end

-- Events are dispatched by the existing FireGameEvent callback.
-- This is more reliable than relying solely on wave count and setup netvars.
local function GP_EB_OnEvent(name, event)
    if not GP_EB_Enabled() then return end
    local n = tostring(name or ""):lower()
    local now = (globals and globals.CurTime and globals.CurTime()) or 0
    if n == "mvm_mission_complete" then
        GP_EB_ClearFailReplay()
        GP_EB.missionComplete = true
        GP_EB.pendingKillWave = nil
        GP_EB.pendingKillFromComplete = false
        GP_EB.rebuyPending = false
        return
    end
    local teamWon = nil
    if n == "teamplay_round_win" and event and event.GetInt then
        local ok, team = pcall(event.GetInt, event, "team")
        if ok then teamWon = team end
    end
    local fallbackWaveFailure =
        (n == "teamplay_round_win" and teamWon == 3) or
        (n == "teamplay_restart_round" and GP_RST
         and GP_RST.kind ~= "vote")
    if n == "mvm_wave_failed" or fallbackWaveFailure then
        GP_EB_BeginFailedSetup(n, now)
        return
    end
    if n == "mvm_begin_wave" or n == "mvm_wave_start" then
        -- Retain an independent record of the last LIVE wave. The buyer may
        -- be reset before mvm_wave_failed is delivered, particularly after a
        -- failed-wave stats reset.
        GP_EB_FailReplay.lastLiveWave = tonumber(GP_GetWaveNumber and GP_GetWaveNumber())
            or tonumber(GP_EB.wave) or 1
        GP_EB_FailReplay.lastLiveAt = now
        GP_EB_FailReplay.observedActive = false
        GP_EB_FailReplay.routeStartedForWave = nil
        GP_EB_FailReplay.setupObservedSince = 0
        -- Setup was interrupted by a prematurely started wave.
        if GP_EB_FailReplay.pending then GP_EB_ClearFailReplay() end
        GP_EB.waveLive = true
        -- Do not erase a completed EngiBuy's Dispenser check here.
        -- Its tick safely postpones any repair while combat is live.
        GP_EB.liveEnteredAt, GP_EB.fallbackSetupSince = now, 0
        if GP_EB.pendingKillWave ~= nil then
            -- Wave is live: no suicide during active combat.
            GP_EB_Notify("wave started before rebuy; cancelled pending kill", "warning")
            GP_EB.pendingKillWave = nil
            GP_EB.pendingKillFromComplete = false
            GP_EB.rebuyPending = false
        end
    elseif n == "mvm_wave_complete" then
        -- Cache Rottenburg's completed setup *before* the legacy route reset
        -- clears st.active/st.done. Keep the Dispenser repair monitor armed.
        if GP_EB_RottenburgRepairOnWaveComplete then
            GP_EB_RottenburgRepairOnWaveComplete(now)
        end
        GP_EB_FailReplay.lastSuccessWave = tonumber(GP_EB.wave)
            or tonumber(GP_GetWaveNumber and GP_GetWaveNumber())
        GP_EB_ClearFailReplay()
        GP_EB.waveLive = false
        GP_EB.liveEnteredAt, GP_EB.fallbackSetupSince = 0, 0
        GP_EB.routeStartRequested = false
        if GP_EB_MannhattanWave1RouteReset
           and not (GP_EB_RottenburgRepairRouteInProgress
                    and GP_EB_RottenburgRepairRouteInProgress()) then
            GP_EB_MannhattanWave1RouteReset()
        end
        local observedWave = (GP_GetWaveNumber and GP_GetWaveNumber()) or nil
        -- A few servers update the ObjectiveResource counter before broadcasting
        -- completion. Prefer the wave observed in the preceding CreateMove ticks.
        local wave = GP_EB.wave or observedWave
        if type(wave) ~= "number" or wave < 1 then
            wave = (GP_RST and tonumber(GP_RST.runWaveOrdinal)) or nil
        end
        if type(wave) == "number" and wave >= 1 and wave ~= GP_EB.lastCompletedWave then
            GP_EB.lastCompletedWave = wave
            if wave == 1 then GP_EB.completedWave1 = true end
            -- Do not suicide after the final wave in the mission.
            local maxWaves = nil
            pcall(function()
                local objs = entities.FindByClass("CTFObjectiveResource")
                local o = objs and objs[1]
                if o and o.GetPropInt then
                    maxWaves = o:GetPropInt("m_nMannVsMachineMaxWaveCount")
                end
            end)
            if not GP_EB.missionComplete and
               not (type(maxWaves) == "number" and maxWaves > 0 and wave >= maxWaves) then
                GP_EB_ArmRebuy(wave + 1, true, now)
                GP_EB_Notify("wave " .. tostring(wave) .. " complete; preparing next-wave upgrades")
            end
        end
    elseif n == "teamplay_round_start" then
        -- Restart after a failed live wave even when no failure event arrived.
        if GP_EB.waveLive and (GP_EB.liveEnteredAt or 0) > 0
           and now - GP_EB.liveEnteredAt > 2.0 then
            GP_EB_BeginFailedSetup("round restart", now)
        end
    elseif n == "mvm_reset_stats" then
        -- This event can arrive BEFORE mvm_wave_failed, after the ordinary
        -- WaveTick live flag has already been cleared. Never erase a failed
        -- replay or mistake this for a fresh mission.
        if GP_EB_FailReplay.pending then return end
        local observed = tonumber((GP_GetWaveNumber and GP_GetWaveNumber()) or nil)
            or tonumber(GP_EB.wave)
        local live = GP_EB_FailReplay.lastLiveWave
        local success = GP_EB_FailReplay.lastSuccessWave
        local hadLiveSameWave = type(live)=="number"
            and GP_EB_FailReplay.observedActive == true
            and (observed == nil or observed == live)
            and success ~= live
        if hadLiveSameWave then
            -- Stats can reset at wave startup as well as after failure. Do
            -- not kill early: preserve evidence and wait for a confirmed
            -- return to setup in WaveTick (or explicit failure event).
            return
        end
        -- A true map/session reset is handled by GP_EB_SessionTick. A stats
        -- refresh alone must not silently wipe the failure replay.
        if live == nil or live == success then
            GP_EB_ClearFailReplay()
        end
        sniperUpgradesComplete, sniperUpgradeCompleted = false, false
        sniperReloadAwaitRespawn, sniperReloadRespawnPending = false, false
        autobuyRunOnceDone, autobuyDoneAnnounced = false, false
        -- A stats refresh is not permission to cancel a live post-wave
        -- dispenser repair route. Otherwise movement silently stops mid-run.
        if GP_EB_MannhattanWave1RouteReset
           and not (GP_EB_RottenburgRepairRouteInProgress
                    and GP_EB_RottenburgRepairRouteInProgress()) then
            GP_EB_MannhattanWave1RouteReset()
        end
    end
end
-- ===== Engineer Upgrade Buildings canteens: unconditional damage-triggered use =====
-- Kept separate from the EngiBuy purchasing state: the canteen must remain
-- functional after a failed wave, buyer reset, and dispenser relocation.
local GP_EB_CANTEEN_DAMAGE_DELAY = 2.0
local GP_EB_CanteenRuntime = {
    lastHealth = {}, nextScan = 0, lastAttempt = -9999,
    pendingDamage = false, damageDetectedAt = nil, waitingConfirmation = false,
    beforeCharges = 0, confirmAt = 0, lastAlert = -9999,
    keyDown = false, keyUpAt = 0, usedFallback = false,
    lastReason = "idle", lastDamagedName = "",
    attemptsForDamage = 0, lastCharges = nil, ownedBuildings = 0,
    lastHP = nil, lastMaxHP = nil, lastScanAt = 0,
    damageSerial = 0, attemptDamageSerial = 0,
    lastConfirmedAt = -9999,
}
local function GP_EB_CanteenRelease(rt)
    if rt.keyDown and client and client.Command then
        pcall(client.Command, "-use_action_slot_item", true)
    end
    rt.keyDown = false
end
function GP_EB_CanteenReset()
    local rt = GP_EB_CanteenRuntime
    GP_EB_CanteenRelease(rt)
    rt.lastHealth, rt.nextScan = {}, 0
    rt.lastAttempt, rt.lastAlert = -9999, -9999
    rt.pendingDamage, rt.damageDetectedAt, rt.waitingConfirmation = false, nil, false
    rt.beforeCharges, rt.confirmAt = 0, 0
    rt.keyUpAt, rt.usedFallback = 0, false
    rt.attemptsForDamage, rt.ownedBuildings = 0, 0
    rt.lastCharges, rt.lastHP, rt.lastMaxHP = nil, nil, nil
    rt.lastScanAt = 0
    rt.damageSerial, rt.attemptDamageSerial = 0, 0
    rt.lastConfirmedAt = -9999
    rt.lastReason, rt.lastDamagedName = "reset", ""
end
-- Read-only console diagnostic: print(GP_EB_CanteenStatus().lastReason)
function GP_EB_CanteenStatus()
    local rt = GP_EB_CanteenRuntime
    return {
        lastReason = rt.lastReason, lastDamagedName = rt.lastDamagedName,
        pendingDamage = rt.pendingDamage, damageDetectedAt = rt.damageDetectedAt,
        waitingConfirmation = rt.waitingConfirmation,
        lastAttempt = rt.lastAttempt, charges = rt.lastCharges,
        ownedBuildings = rt.ownedBuildings, hp = rt.lastHP,
        maxhp = rt.lastMaxHP, attemptsForDamage = rt.attemptsForDamage,
        damageSerial = rt.damageSerial, lastConfirmedAt = rt.lastConfirmedAt,
    }
end
local function GP_EB_CanteenReadInt(obj, name)
    if not obj or not obj.GetPropInt then return nil end
    local ok, val = pcall(obj.GetPropInt, obj, name)
    if ok and type(val) == "number" then return val end
    return nil
end
local function GP_EB_CanteenIsOwned(me, obj)
    if not (me and me.GetIndex and obj) then return false end
    local ok, myIndex = pcall(me.GetIndex, me)
    if not ok or type(myIndex) ~= "number" then return false end
    if obj.GetPropEntity then
        local got, builder = pcall(obj.GetPropEntity, obj, "m_hBuilder")
        if got and builder and builder.GetIndex then
            local okIdx, idx = pcall(builder.GetIndex, builder)
            if okIdx and idx == myIndex then return true end
        end
    end
    if GP_TP_GetBuilderForWhitelist then
        local got, builder = pcall(GP_TP_GetBuilderForWhitelist, obj)
        if got and builder and builder.GetIndex then
            local okIdx, idx = pcall(builder.GetIndex, builder)
            if okIdx and idx == myIndex then return true end
        end
    end
    -- m_hBuilder is a Source handle: low 11 bits are entity index.
    local raw = GP_EB_CanteenReadInt(obj, "m_hBuilder")
    if raw and raw >= 0 and raw % 2048 == myIndex then return true end
    return false
end
local function GP_EB_CanteenHealth(obj)
    local hp = GP_EB_CanteenReadInt(obj, "m_iHealth")
    local maxhp = GP_EB_CanteenReadInt(obj, "m_iMaxHealth")
    if (hp == nil or hp <= 0) and obj.GetHealth then
        local ok, val = pcall(obj.GetHealth, obj)
        if ok and type(val) == "number" then hp = val end
    end
    if (maxhp == nil or maxhp <= 0) and obj.GetMaxHealth then
        local ok, val = pcall(obj.GetMaxHealth, obj)
        if ok and type(val) == "number" then maxhp = val end
    end
    return hp, maxhp
end
-- Prefer the server action-slot KV command documented by LMAOBOX.
-- A successful client.Command return value only proves dispatch, not use.
local function GP_EB_CanteenServerUse()
    if not (engine and engine.SendKeyValues) then return false end
    local ok, sent = pcall(engine.SendKeyValues, '"use_action_slot_item_server" {}')
    return ok and sent ~= false
end
local function GP_EB_CanteenClientUse(rt, now)
    if not (client and client.Command) then return false end
    local ok, sent = pcall(client.Command, "+use_action_slot_item", true)
    if ok and sent ~= false then
        rt.keyDown = true
        rt.keyUpAt = now + 0.10
        return true
    end
    return false
end
local function GP_EB_CanteenActivate(rt, now, charges)
    local sent = GP_EB_CanteenServerUse()
    rt.usedFallback = false
    if not sent then
        sent = GP_EB_CanteenClientUse(rt, now)
        rt.usedFallback = sent
    end
    rt.lastAttempt = now
    rt.attemptsForDamage = rt.attemptsForDamage + 1
    rt.beforeCharges = charges
    rt.attemptDamageSerial = rt.damageSerial
    rt.confirmAt = now
    rt.waitingConfirmation = sent
    rt.lastReason = sent and "canteen use sent; verifying charge consumption"
        or "cannot send canteen use command"
end
function GP_EB_CanteenTick(me, now)
    local rt = GP_EB_CanteenRuntime
    if rt.keyDown and now >= rt.keyUpAt then GP_EB_CanteenRelease(rt) end
    if not GP_EB_Enabled() or not GP_EB_IsEngineer(me)
       or not me.IsAlive or not me:IsAlive() then
        GP_EB_CanteenRelease(rt)
        return
    end

    -- Damage-triggered action-slot use does not depend on detecting a bottle,
    -- its type, or its remaining charges. TF2 itself decides if use succeeds.
    -- Release an earlier key press before scanning for another hit.
    rt.waitingConfirmation = false

    if now < rt.nextScan then return end
    rt.nextScan = now + 0.12
    rt.lastScanAt = now
    local present = {}
    local damagedNow = false
    local anyInjured = false
    local healthReadable = 0
    local observedOwn = 0
    for _, name in ipairs({"CObjectDispenser", "CObjectSentrygun", "CObjectTeleporter"}) do
        local ok, list = pcall(entities.FindByClass, name)
        if ok and type(list) == "table" then
            for _, obj in pairs(list) do
                if obj and obj.GetIndex and GP_EB_CanteenIsOwned(me, obj) then
                    local idxOk, idx = pcall(obj.GetIndex, obj)
                    local hp, maxhp = GP_EB_CanteenHealth(obj)
                    local placing = GP_EB_CanteenReadInt(obj, "m_bPlacing")
                    local building = GP_EB_CanteenReadInt(obj, "m_bBuilding")
                    local carried = GP_EB_CanteenReadInt(obj, "m_bCarried")
                    if idxOk and type(idx) == "number" and type(hp) == "number"
                       and hp > 0 and placing ~= 1 and building ~= 1 and carried ~= 1 then
                        observedOwn = observedOwn + 1
                        if type(maxhp) == "number" and maxhp > 0 then
                            healthReadable = healthReadable + 1
                            if hp < maxhp then anyInjured = true end
                        end
                        local key = name .. ":" .. tostring(idx)
                        local old = rt.lastHealth[key]
                        -- A health reduction is valid even if the max-health
                        -- netvar is missing; first-scan damage uses max health.
                        local healthDrop = (type(old) == "number" and hp < old)
                        local alreadyHurt = (old == nil and type(maxhp) == "number"
                            and maxhp > 0 and hp < maxhp)
                        if healthDrop or alreadyHurt then
                            damagedNow = true
                            rt.lastDamagedName = name
                            rt.lastHP, rt.lastMaxHP = hp, maxhp
                        end
                        present[key] = hp
                    end
                end
            end
        end
    end
    rt.ownedBuildings = observedOwn
    rt.lastHealth = present
    if damagedNow then
        -- FIX: A fresh hit must re-arm the monitor EVEN IF an earlier
        -- activation failed and left pendingDamage=true. Previously, after
        -- two unconfirmed attempts the >=2 guard blocked every later hit.
        rt.damageSerial = rt.damageSerial + 1
        rt.attemptsForDamage = 0
        if not rt.pendingDamage then rt.damageDetectedAt = now end
        rt.pendingDamage = true
    elseif not rt.waitingConfirmation and healthReadable > 0
       and not anyInjured then
        -- The building was repaired in the meantime: do not waste a
        -- canteen on stale damage when charges become available again.
        rt.pendingDamage = false
        rt.damageDetectedAt = nil
        rt.attemptsForDamage = 0
    end
    if not rt.pendingDamage then return end
    -- Wait two seconds after the first detected damage before using a canteen.
    if not rt.damageDetectedAt or now - rt.damageDetectedAt < GP_EB_CANTEEN_DAMAGE_DELAY then return end
    -- Use once for each observed damage event. No canteen inventory,
    -- charge-count, canteen-type, or active-effect gate.
    if now - rt.lastAttempt < 0.65 then return end
    rt.pendingDamage = false
    rt.damageDetectedAt = nil
    rt.lastAttempt = now
    rt.attemptsForDamage = rt.attemptsForDamage + 1
    rt.attemptDamageSerial = rt.damageSerial
    rt.lastCharges = nil -- no longer queried for activation
    GP_EB_CanteenRelease(rt)
    if GP_EB_CanteenClientUse(rt, now) then
        rt.lastReason = "building damaged: +use_action_slot_item sent (charges unchecked)"
    else
        rt.lastReason = "building damaged: action-slot command unavailable"
    end

end

-- ===== Mannhattan Wave 1: Engineer post-EngiBuy custom route =====
-- Wave 1: walk to stops 1..9; build dispenser at 3, entrance at 4,
-- and jump/place exit at 9. Regular route walking never auto-jumps.
-- Let the Engineer finish braking at the final point before jump-placement.
local GP_EB_MANNHATTAN_EXIT_SETTLE_SECONDS = 1.0
-- Screenshot: use 0 / -90 / 0 for building/pickup, 0 / 0 / 0 after teleport.
GP_EB_MANNHATTAN_BUILD_PITCH, GP_EB_MANNHATTAN_BUILD_YAW = 0, -90
GP_EB_MANNHATTAN_AFTER_TP_PITCH, GP_EB_MANNHATTAN_AFTER_TP_YAW = 0, 0
-- Final waypoint is a 2.5u precision stop; other waypoints retain their tolerances.
local GP_EB_MANNHATTAN_FINAL_REACH_RADIUS = 2.5 -- must be within 2.5 XY units
local GP_EB_MANNHATTAN_FINAL_SETTLE_RADIUS = 3.5 -- tight hysteresis while settling
-- Jump and teleporter-exit placement are allowed only below this speed.
local GP_EB_MANNHATTAN_FINAL_STOP_SPEED = 6.07
local GP_EB_MANNHATTAN_W1_POINTS = {
    {x = 445.62,  y = 2300.50, z = -91.87},
    {x = 445.63,  y = 2082.73, z = -91.87},
    {x = 150.29,  y = 2036.52, z = -91.87}, -- dispenser
    {x = -48.16,  y = 2036.52, z = -91.87}, -- entrance
    {x = -48.16,  y = -18.56, z = -93.51},
    {x = -699.75, y = -18.56, z = -91.97},
    {x = -699.75, y = -1671.92, z = 4.03},
    {x = 743.61,  y = -1851.80, z = 4.02},
    {x = 1089.07, y = -2292.08, z = 4.03} -- EXIT, former point 9
}
-- Rottenburg: two distinct spawn approaches, with shared stops 3..11.
-- Coordinates are the user's cl_showpos VIEW positions (not feet origins).
local GP_EB_ROTTENBURG_RIGHT_START = {
    {x = -1484.74, y = 1092.19, z = -101.98},
    {x = -1142.84, y = 1184.17, z = -102.30}
}
local GP_EB_ROTTENBURG_LEFT_START = {
    {x = -1151.25, y = 2269.12, z = -59.97},
    {x = -826.37, y = 2214.11, z = -59.97}
}
local GP_EB_ROTTENBURG_SHARED = {
    {x = -1108.55, y = 1436.81, z = -101.98}, -- 3 Dispenser
    {x = -973.36, y = 1329.86, z = -102.17}, -- 4 Teleporter Entrance
    {x = -756.77, y = 1307.60, z = -91.97}, -- 5 Additional walking waypoint
    {x = -209.41, y = 1274.07, z = -207.97}, -- 6 New walking waypoint
    {x = 1049.41, y = 1195.09, z = -147.84}, -- 7 New walking waypoint
    {x = 1500.71, y = 157.57, z = -352.45}, -- 8 walking waypoint
    {x = 1496.22, y = -646.04, z = -437.60}, -- 9 new walking waypoint
    {x = 570.02, y = -1463.99, z = -431.27}, -- 10 new walking waypoint
    {x = 806.28, y = -1468.72, z = -451.52} -- 11 Teleporter Exit
}
-- After taking the teleporter on Rottenburg, deliver the carried Dispenser here.
-- These are cl_showpos eye-position coordinates, not feet coordinates.
local GP_EB_ROTTENBURG_DISPENSER_DELIVERY = {
    x = 811.82, y = -1282.02, z = -441.94,
    pitch = 12.11, yaw = 43.70
}
local GP_EB_ROTTENBURG_DELIVERY_REACH_RADIUS = 14
local GP_EB_ROTTENBURG_DELIVERY_SETTLE_SECONDS = 0.45
local GP_EB_MANNHATTAN_DEFAULT_POINTS = GP_EB_MANNHATTAN_W1_POINTS
local GP_EB_ROTTENBURG_STOPS = {
    [3] = {label = "Dispenser", buildCommand = "build 0 0", class = "CObjectDispenser", pitch = 0, yaw = 180},
    [4] = {label = "Entrance", buildCommand = "build 1 0", class = "CObjectTeleporter", mode = 0, pitch = 0, yaw = 0},
    [11] = {label = "Exit", buildCommand = "build 1 1", class = "CObjectTeleporter", mode = 1,
            jump = true, pitch = 6.67, yaw = 25.61}
}
local GP_EB_MANNHATTAN_DEFAULT_STOPS -- assigned after the original stops table
local GP_EB_MANNHATTAN_W1_BUILD_STOPS -- forward declaration for selector
local GP_EB_ROTTENBURG_SPAWN_SIDE = nil
local function GP_EB_MapIsRottenburg()
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    return tostring(map):lower():find("mvm_rottenburg", 1, true) ~= nil
end
local function GP_EB_PickRottenburgStart(me)
    -- Choose the approach whose two given spawn points are closest to the
    -- actual player position, rather than guessing from the current angle.
    local pos = me and me.GetAbsOrigin and me:GetAbsOrigin() or nil
    if not pos then return GP_EB_ROTTENBURG_RIGHT_START, "right" end
    local function closest2D(starts)
        local best = math.huge
        for _, p in ipairs(starts) do
            local dx, dy = pos.x - p.x, pos.y - p.y
            best = math.min(best, dx*dx + dy*dy)
        end
        return best
    end
    if closest2D(GP_EB_ROTTENBURG_LEFT_START) < closest2D(GP_EB_ROTTENBURG_RIGHT_START) then
        return GP_EB_ROTTENBURG_LEFT_START, "left"
    end
    return GP_EB_ROTTENBURG_RIGHT_START, "right"
end
local function GP_EB_SelectEngineerMapRoute(me)
    if GP_EB_MapIsRottenburg() then
        local first, side = GP_EB_PickRottenburgStart(me)
        local points = {}
        for _, p in ipairs(first) do points[#points+1] = p end
        for _, p in ipairs(GP_EB_ROTTENBURG_SHARED) do points[#points+1] = p end
        GP_EB_MANNHATTAN_W1_POINTS = points
        GP_EB_MANNHATTAN_W1_BUILD_STOPS = GP_EB_ROTTENBURG_STOPS
        GP_EB_ROTTENBURG_SPAWN_SIDE = side
        return "Rottenburg (" .. side .. " spawn)"
    end
    GP_EB_MANNHATTAN_W1_POINTS = GP_EB_MANNHATTAN_DEFAULT_POINTS
    GP_EB_MANNHATTAN_W1_BUILD_STOPS = GP_EB_MANNHATTAN_DEFAULT_STOPS
    GP_EB_ROTTENBURG_SPAWN_SIDE = nil
    return "Mannhattan"
end

GP_EB_MANNHATTAN_W1_BUILD_STOPS = {
    [3] = {label = "Dispenser", buildCommand = "build 0 0", class = "CObjectDispenser"},
    [4] = {label = "Entrance", buildCommand = "build 1 0", class = "CObjectTeleporter", mode = 0},
    [9] = {label = "Exit", buildCommand = "build 1 1", class = "CObjectTeleporter", mode = 1, jump = true}
}
GP_EB_MANNHATTAN_DEFAULT_STOPS = GP_EB_MANNHATTAN_W1_BUILD_STOPS
local GP_EB_MANNHATTAN_W1 = {
    active = false, done = false, index = 1,
    failedWaveReplay = false,
    server = "", map = "", lastAlive = nil,
    stuckAt = 0, bestDistance = math.huge,
    lastWarnAt = 0, distance = nil, lastSteerAt = 0,
    status = "waiting for EngiBuy to finish",
    buildStopIndex = nil, buildSince = 0, nextBuildCmdAt = 0,
    buildCommands = 0, nextPlacementCheck = 0,
    lastBuildConfirmed = "", heightDifference = nil,
    phase = "setup", phaseSince = 0, exitPlacedAt = 0,
    exitKillAt = 0, exitKillRetries = 0, observedDeath = false,
    pickupSince = 0, nextPickupPulse = 0, pickupAttempts = 0, nextWrenchAt = 0,
    tpwalkSince = 0, nextTpWarn = 0, tpLandingPos = nil,
    dropSince = 0, nextDropCheck = 0, dropPulses = 0,
    deliveryArrivedAt = 0,
    postDeliveryKillAt = 0, postDeliveryKillRetries = 0, postDeliveryDeathSeen = false,
    expectedTransport = false, lastConnection = "",
    repairMode = false, repairDeathSeen = false, repairKillAt = 0,
    repairLastKillAt = 0, repairKillRetries = 0,
    repairForWave = nil, repairDestroyStartedAt = 0,
    repairDestroyLastAt = 0, repairDestroyAttempts = 0
}
-- Independent from the upgrade buyer: do not reset EngiBuy when repairing a Dispenser.
local GP_EB_ROTTENBURG_REPAIR = {
    armed = false, sawDispenser = false, missingSince = nil,
    repairNeeded = false, lastObservedDispenser = nil,
    nextScan = 0, server = "", map = "", lastLogAt = 0,
    armReason = "not armed", blockReason = "waiting for setup",
    lastExitSeen = nil,
    -- Explicit one-shot mandatory rebuild trigger after each EngiBuy, wave 2+.
    postBuyPending = false, postBuyWave = nil, postBuyAt = 0,
    shopVerifiedAt = 0, shopVerifiedWave = nil,
    checkedWave = nil, waveCompletionAt = 0, waveCompletedIndex = nil,
    fallbackArmedWave = nil, lastDebugAt = 0
}


function GP_EB_MannhattanMap()
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    local name = tostring(map):lower()
    return name:find("mvm_mannhattan", 1, true) ~= nil
        or name:find("mvm_rottenburg", 1, true) ~= nil
end

local function GP_EB_IsFirstWaveForStart(boughtWave)
    local observed = (GP_GetWaveNumber and GP_GetWaveNumber()) or nil
    local w, bought = tonumber(observed), tonumber(boughtWave)
    if (w and w >= 2) or (bought and bought >= 2) then return false end
    if w == 1 or bought == 1 then return true end
    if GP_HasExplicitPreWave1Proof then
        local ok, pre = pcall(GP_HasExplicitPreWave1Proof)
        if ok and pre == true then return true end
    end
    return false
end

local function GP_EB_MannhattanClearBuildState()
    local st = GP_EB_MANNHATTAN_W1
    st.buildStopIndex, st.buildSince, st.nextBuildCmdAt = nil, 0, 0
    st.buildCommands, st.nextPlacementCheck = 0, 0
end

function GP_EB_MannhattanWave1RouteReset()
    local st = GP_EB_MANNHATTAN_W1
    st.active, st.done, st.index = false, false, 1
    st.failedWaveReplay = false
    st.repairMode = false
    st.repairDeathSeen = false
    st.repairKillAt, st.repairLastKillAt, st.repairKillRetries = 0, 0, 0
    st.repairForWave = nil
    st.repairDestroyStartedAt, st.repairDestroyLastAt, st.repairDestroyAttempts = 0, 0, 0
    st.routeLabel = nil
    st.server, st.map, st.lastAlive = "", "", nil
    st.stuckAt, st.bestDistance, st.lastWarnAt = 0, math.huge, 0
    st.distance, st.lastSteerAt, st.heightDifference = nil, 0, nil
    st.status, st.lastBuildConfirmed = "waiting for EngiBuy to finish", ""
    st.phase, st.phaseSince, st.exitPlacedAt = "setup", 0, 0
    st.exitKillAt, st.exitKillRetries, st.observedDeath = 0, 0, false
    st.pickupSince, st.nextPickupPulse, st.pickupAttempts, st.nextWrenchAt = 0, 0, 0, 0
    st.tpwalkSince, st.nextTpWarn, st.tpLandingPos = 0, 0, nil
    st.dropSince, st.nextDropCheck, st.dropPulses, st.deliveryArrivedAt = 0, 0, 0, 0
    st.postDeliveryKillAt, st.postDeliveryKillRetries, st.postDeliveryDeathSeen = 0, 0, false
    st.expectedTransport, st.lastConnection = false, ""
    GP_EB_MannhattanClearBuildState()
end

function GP_EB_MannhattanWave1RouteStart(boughtWave)
    if not GP_EB_MannhattanMap() or
        (not GP_EB_FailReplay.pending and not GP_EB_IsFirstWaveForStart(boughtWave)) then
        return false
    end
    local st = GP_EB_MANNHATTAN_W1
    if st.active or st.done then return true end
    local meStart = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
    local routeLabel = GP_EB_SelectEngineerMapRoute(meStart)
    st.active, st.done, st.index = true, false, 1
    st.routeLabel = routeLabel
    -- Full initial/failed-wave setup takes priority over any Dispenser-only repair.
    GP_EB_ROTTENBURG_REPAIR.armed = false
    GP_EB_ROTTENBURG_REPAIR.sawDispenser = false
    GP_EB_ROTTENBURG_REPAIR.repairNeeded = false
    GP_EB_ROTTENBURG_REPAIR.missingSince = nil
    st.repairMode = false
    st.failedWaveReplay = (GP_EB_FailReplay.pending == true)
    if st.failedWaveReplay then
        GP_EB_FailReplay.routeStartedForWave = GP_EB_FailReplay.wave
    end
    st.phase, st.phaseSince = "setup", (globals and globals.CurTime and globals.CurTime()) or 0
    st.server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    st.map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    st.stuckAt, st.bestDistance, st.lastAlive, st.lastWarnAt = 0, math.huge, nil, 0
    st.status = "following waypoint 1/" .. #GP_EB_MANNHATTAN_W1_POINTS
    st.distance, st.lastSteerAt, st.heightDifference = nil, 0, nil
    st.lastBuildConfirmed = ""
    st.postDeliveryKillAt, st.postDeliveryKillRetries, st.postDeliveryDeathSeen = 0, 0, false
    GP_EB_MannhattanClearBuildState()
    GP_EB.routeStartRequested = false
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
    tpIsWaitingForTeleporter = false
    tpNoTeleFallbackActive = false
    tpUseVerifyActive = false
    if GP_TP_ResetPathState then GP_TP_ResetPathState() end
    if GP_TP_ResetStuckTracker then GP_TP_ResetStuckTracker() end
    if AddNotification then
        AddNotification(routeLabel .. ": Engineer route (9 stops + 3 buildings)", "success", 4.0)
    end
    return true
end

function GP_EB_MannhattanWave1RouteAutoStart()
    if not GP_EB_MannhattanMap() or GP_EB.waveLive then return end
    -- If the buyer is done after a failed wave, do not depend on a single
    -- upgrade-finish callback having run at exactly the correct time.
    if GP_EB_FailReplay.pending and not GP_EB.running
       and not GP_EB.awaitingRespawn and not GP_EB.rebuyPending
       and GP_EB.lastAttemptWave ~= nil then
        GP_EB.routeStartRequested = true
    end
    -- If an upgrade request stalls after a permanent upgrade, do NOT
    -- let shopping block a failed-wave rebuild forever. Keep the canteen
    -- purchase logic unchanged, but gracefully close a stalled upgrade batch.
    if GP_EB_FailReplay.pending and GP_EB.running
       and (globals and globals.CurTime and globals.CurTime() or 0)
           - (GP_EB.lastProgressAt or GP_EB.runningSince or 0) >= 12.0 then
        GP_EB_Finish("upgrade stalled; continuing failed-wave setup")
    end
    -- A late failure notification can arrive after the previous route ended.
    -- Reset completed state before trying to restart at 1/9.
    if GP_EB_FailReplay.pending and GP_EB_MANNHATTAN_W1.done then
        GP_EB_MannhattanWave1RouteReset()
    end
    if GP_EB.routeStartRequested and not GP_EB_MANNHATTAN_W1.active then
        local started = GP_EB_MannhattanWave1RouteStart(GP_EB.wave)
        if started and GP_EB_FailReplay.pending then
            GP_EB_ClearFailReplay()
        end
    end
end

function GP_EB_MannhattanWave1RouteActive()
    -- Once the carried Dispenser has been placed, stop intercepting CreateMove.
    -- Keeping active=true for route status is harmless; completed routes must
    -- not continue zeroing movement commands every tick.
    return GP_EB_MANNHATTAN_W1.active and not GP_EB_MANNHATTAN_W1.done
end

local function GP_EB_MannhattanViewPosition(me, origin)
    local eyeOffset = nil
    if me and me.GetPropVector then
        for _, prop in ipairs({
            {"localdata", "m_vecViewOffset[0]"},
            {"m_vecViewOffset[0]"},
            {"m_vecViewOffset"}
        }) do
            local ok, v
            if #prop == 2 then
                ok, v = pcall(me.GetPropVector, me, prop[1], prop[2])
            else
                ok, v = pcall(me.GetPropVector, me, prop[1])
            end
            if ok and v and type(v.z) == "number" and v.z >= 20 and v.z <= 100 then
                eyeOffset = v.z
                break
            end
        end
    end
    return {x = origin.x, y = origin.y, z = origin.z + (eyeOffset or 68)}
end

local function GP_EB_MannhattanReachRadius(index)
    local points = GP_EB_MANNHATTAN_W1_POINTS
    local point = points[index]
    if not point then return 38 end
    -- Exit: require 2.5 units of horizontal accuracy before settling.
    if index == #points then return GP_EB_MANNHATTAN_FINAL_REACH_RADIUS end
    -- Dispenser and entrance still use their existing 40-unit tolerance.
    if GP_EB_MANNHATTAN_W1_BUILD_STOPS[index] then return 40 end
    local shortest = math.huge
    for _, neighborIndex in ipairs({index - 1, index + 1}) do
        local neighbor = points[neighborIndex]
        if neighbor then
            local dx, dy = point.x - neighbor.x, point.y - neighbor.y
            shortest = math.min(shortest, math.sqrt(dx * dx + dy * dy))
        end
    end
    return math.min(80, math.max(34, shortest * 0.44))
end

-- Optional velocity feedback for braking at the final stop. Some LMAOBOX
-- versions may not expose the netprop; the slower distance-only approach
-- still works in that case.
local function GP_EB_MannhattanVelocityXY(me)
    if me and me.GetPropVector then
        local props = {
            {"localdata", "m_vecVelocity[0]"},
            {"m_vecVelocity[0]"},
            {"m_vecVelocity"}
        }
        for _, p in ipairs(props) do
            local ok, v
            if #p == 2 then
                ok, v = pcall(me.GetPropVector, me, p[1], p[2])
            else
                ok, v = pcall(me.GetPropVector, me, p[1])
            end
            if ok and v and type(v.x) == "number" and type(v.y) == "number" then
                return v.x, v.y, tonumber(v.z) or 0
            end
        end
    end
    if me and me.EstimateAbsVelocity then
        local ok, v = pcall(me.EstimateAbsVelocity, me)
        if ok and v and type(v.x) == "number" and type(v.y) == "number" then
            return v.x, v.y, tonumber(v.z) or 0
        end
    end
    return nil, nil
end

-- Set/clear specific input bits without requiring a particular bit library.
-- Match the full speed magnitude shown by cl_showpos, including vertical velocity.
-- Never assume zero speed when velocity could not be read.
local function GP_EB_MannhattanSpeed(me)
    local vx, vy, vz = GP_EB_MannhattanVelocityXY(me)
    if vx == nil or vy == nil or vz == nil then return nil end
    return math.sqrt(vx * vx + vy * vy + vz * vz)
end

local function GP_EB_SetInputBit(buttons, flag, shouldSet)
    local has = (math.floor(buttons / flag) % 2) == 1
    if shouldSet and not has then return buttons + flag end
    if not shouldSet and has then return buttons - flag end
    return buttons
end

local function GP_EB_ClearRouteMovement(cmd, stopJump)
    if cmd.SetForwardMove then cmd:SetForwardMove(0) end
    if cmd.SetSideMove then cmd:SetSideMove(0) end
    if cmd.SetUpMove then cmd:SetUpMove(0) end
    if not (cmd.GetButtons and cmd.SetButtons) then return end
    local b = tonumber(cmd:GetButtons()) or 0
    for _, flag in ipairs({8, 16, 128, 256, 512, 1024}) do
        b = GP_EB_SetInputBit(b, flag, false)
    end
    if stopJump then b = GP_EB_SetInputBit(b, 2, false) end
    cmd:SetButtons(b)
end

-- A blueprint entity exists even before a building has been placed. Never
-- count a ghost blueprint (m_bPlacing=1) as construction success.
local function GP_EB_BuildingPlacedAtStop(me, stop, point)
    -- Use the proven v3 detector for Rottenburg, since some clients expose
    -- Dispensers only via C_ObjectDispenser / entity-index scanning.
    if stop and stop.class == "CObjectDispenser" and GP_EB_MapIsRottenburg()
       and GP_EB_RottenburgDispenserState then
        local ds, index = GP_EB_RottenburgDispenserState(true)
        if (ds == "up" or ds == "building") and type(index) == "number" then
            local disp = nil
            if entities and entities.GetByIndex then
                pcall(function() disp = entities.GetByIndex(index) end)
            end
            local pos = nil
            if disp and disp.GetAbsOrigin then
                pcall(function() pos = disp:GetAbsOrigin() end)
            end
            if pos and point then
                local dx, dy, dz = pos.x-point.x, pos.y-point.y, pos.z-(point.z-68)
                if dx*dx + dy*dy <= 320*320 and math.abs(dz) <= 160 then
                    return true
                end
            end
        end
    end
    if not (entities and entities.FindByClass and me and me.GetIndex) then return false end
    local okMe, myIndex = pcall(me.GetIndex, me)
    if not okMe or type(myIndex) ~= "number" then return false end
    local classNames = stop.class == "CObjectDispenser"
        and {"CObjectDispenser"}
        or {"CObjectTeleporter", "CObjectTeleporterEntrance", "CObjectTeleporterExit"}
    for _, class in ipairs(classNames) do
        local okList, list = pcall(entities.FindByClass, class)
        if okList and type(list) == "table" then
            for _, ent in pairs(list) do
                local usable = ent ~= nil
                if usable and ent.IsValid then
                    local okValid, valid = pcall(ent.IsValid, ent)
                    usable = okValid and valid == true
                end
                if usable and ent.GetPropInt then
                    local okHp, hp = pcall(ent.GetPropInt, ent, "m_iHealth")
                    if okHp and type(hp) == "number" and hp <= 0 then usable = false end
                end
                if usable and ent.GetPropInt and ent.GetAbsOrigin then
                    local builder = nil
                    if ent.GetPropEntity then
                        local okBuilder, b = pcall(ent.GetPropEntity, ent, "m_hBuilder")
                        if okBuilder then builder = b end
                    end
                    if not builder and GP_TP_GetBuilderForWhitelist then
                        local okBuilder, b = pcall(GP_TP_GetBuilderForWhitelist, ent)
                        if okBuilder then builder = b end
                    end
                    local ownerMatch = false
                    if builder and builder.GetIndex then
                        local okIndex, ownerIndex = pcall(builder.GetIndex, builder)
                        ownerMatch = okIndex and ownerIndex == myIndex
                    end
                    if not ownerMatch and ent.GetPropInt then
                        -- Source EHANDLEs embed serial bits; the low 11 bits
                        -- contain the builder entity index. This fallback is
                        -- essential on clients where GetPropEntity returns nil.
                        local okHandle, handle = pcall(ent.GetPropInt, ent, "m_hBuilder")
                        ownerMatch = okHandle and type(handle) == "number"
                            and handle >= 0 and (handle % 2048) == myIndex
                    end
                    if ownerMatch then
                        local validMode = stop.mode == nil
                        if stop.mode ~= nil then
                            local okMode, mode = pcall(ent.GetPropInt, ent, "m_iObjectMode")
                            validMode = okMode and mode == stop.mode
                            if not validMode then
                                validMode = (stop.mode == 0 and class == "CObjectTeleporterEntrance")
                                    or (stop.mode == 1 and class == "CObjectTeleporterExit")
                            end
                        end
                        local okPlacing, placing = pcall(ent.GetPropInt, ent, "m_bPlacing")
                        if not okPlacing and ent.GetPropBool then
                            okPlacing, placing = pcall(ent.GetPropBool, ent, "m_bPlacing")
                        end
                        local placed = (not okPlacing) or placing == false or placing == 0
                        local okPos, p = pcall(ent.GetAbsOrigin, ent)
                        if validMode and placed and okPos and p then
                            local dx, dy, dz = p.x - point.x, p.y - point.y, p.z - (point.z - 68)
                            if dx*dx + dy*dy <= 320*320 and math.abs(dz) <= 160 then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function GP_EB_MannhattanHoldView(cmd, pitch, yaw)
    if cmd and cmd.SetViewAngles then
        cmd:SetViewAngles(pitch or 0, yaw or 0, 0)
    end
end

function GP_EB_MannhattanOwnedObject(me, className, mode)
    -- Rottenburg repair/pickup needs the same owner+class fallback that
    -- succeeds in the standalone Dispenser Detector v3.
    if className == "CObjectDispenser" and GP_EB_MapIsRottenburg()
       and GP_EB_RottenburgDispenserState then
        local ds, index = GP_EB_RottenburgDispenserState()
        if (ds == "up" or ds == "building" or ds == "carried")
           and type(index) == "number" and entities and entities.GetByIndex then
            local ok, ent = pcall(entities.GetByIndex, index)
            if ok and ent then return ent end
        end
    end
    if not (me and entities and entities.FindByClass and me.GetIndex) then return nil end
    local okMe, ownerId = pcall(me.GetIndex, me)
    if not okMe or not ownerId then return nil end
    local names = (className == "CObjectTeleporter")
        and {"CObjectTeleporter", "CObjectTeleporterEntrance", "CObjectTeleporterExit"}
        or {className}
    for _, name in ipairs(names) do
        local ok, ents = pcall(entities.FindByClass, name)
        if ok and type(ents) == "table" then
            for _, ent in pairs(ents) do
                local usable = ent ~= nil
                if usable and ent.IsValid then
                    local okValid, valid = pcall(ent.IsValid, ent)
                    usable = okValid and valid == true
                end
                if usable and ent.GetPropInt then
                    local okHp, hp = pcall(ent.GetPropInt, ent, "m_iHealth")
                    if okHp and type(hp) == "number" and hp <= 0 then
                        usable = false -- destroyed or dying entity, not a live building
                    end
                end
                if usable and ent.GetPropInt and className == "CObjectDispenser" then
                    -- A blueprint is not a surviving dispenser. Some clients
                    -- keep the ghost entity briefly after destruction.
                    local okPlacing, placing = pcall(ent.GetPropInt, ent, "m_bPlacing")
                    if okPlacing and (placing == 1 or placing == true) then usable = false end
                end
                if usable and ent.GetAbsOrigin then
                    local okB, owner = false, nil
                    if ent.GetPropEntity then
                        okB, owner = pcall(ent.GetPropEntity, ent, "m_hBuilder")
                    end
                    if (not okB or not owner) and GP_TP_GetBuilderForWhitelist then
                        okB, owner = pcall(GP_TP_GetBuilderForWhitelist, ent)
                    end
                    local builderId
                    if owner and owner.GetIndex then
                        local okI, id = pcall(owner.GetIndex, owner)
                        if okI then builderId = id end
                    end
                    if builderId ~= ownerId and ent.GetPropInt then
                        local okRaw, raw = pcall(ent.GetPropInt, ent, "m_hBuilder")
                        if okRaw and type(raw) == "number" and raw ~= -1 then
                            -- EHANDLE serial bits may make the signed value negative.
                            builderId = raw % 2048 -- Source's 11-bit entity index
                        end
                    end
                    if builderId == ownerId then
                        local actualMode = nil
                        if ent.GetPropInt then
                            local okMode, v = pcall(ent.GetPropInt, ent, "m_iObjectMode")
                            if okMode then actualMode = v end
                        end
                        local modeOk = (mode == nil or actualMode == mode)
                            or (mode == 0 and name == "CObjectTeleporterEntrance")
                            or (mode == 1 and name == "CObjectTeleporterExit")
                        if modeOk then return ent end
                    end
                end
            end
        end
    end
    return nil
end

-- Own-Dispenser sensor adapted from the working standalone v3 detector.
-- Never cache Entity userdata across scans: only entity indices/status.
-- Returns "up", "building", "carried", "blueprint", "down" or "unknown".
local GP_EB_DISP_SENSOR = {
    at = -1e9, state = "unknown", entityIndex = nil,
    deepAt = -1e9, deepIndices = {}, server = "", map = ""
}
local function GP_EB_DispApi(lib, name, ...)
    if lib == nil then return nil end
    local okFn, fn = pcall(function() return lib[name] end)
    if not okFn or fn == nil then return nil end
    local ok, result = pcall(fn, ...)
    if ok then return result end
    return nil
end
local function GP_EB_DispEnt(ent, name, ...)
    if ent == nil then return nil end
    local okFn, fn = pcall(function() return ent[name] end)
    if not okFn or fn == nil then return nil end
    local ok, result = pcall(fn, ent, ...)
    if ok then return result end
    return nil
end
local function GP_EB_DispTruth(ent, key)
    local value = GP_EB_DispEnt(ent, "GetPropBool", key)
    if value == nil then value = GP_EB_DispEnt(ent, "GetPropInt", key) end
    return value == true or value == 1
end
function GP_EB_RottenburgDispenserState(force)
    local c = GP_EB_DISP_SENSOR
    local now = GP_EB_DispApi(globals, "CurTime")
        or GP_EB_DispApi(globals, "RealTime") or os.clock()
    if type(now) ~= "number" then now = os.clock() end
    local server = GP_EB_DispApi(engine, "GetServerIP") or ""
    local map = GP_EB_DispApi(engine, "GetMapName") or ""
    if server ~= c.server or map ~= c.map then
        c.server, c.map, c.at, c.deepAt, c.deepIndices = server, map, -1e9, -1e9, {}
    end
    if not force and now >= c.at and now - c.at < 0.30 then
        return c.state, c.entityIndex
    end
    c.at, c.state, c.entityIndex = now, "unknown", nil

    local me = GP_EB_DispApi(entities, "GetLocalPlayer")
        or GP_EB_DispApi(client, "GetLocalPlayer")
    local myIndex = GP_EB_DispApi(client, "GetLocalPlayerIndex")
    if me then
        local direct = GP_EB_DispEnt(me, "GetIndex")
        if type(direct) == "number" and direct > 0 then myIndex = direct end
    end
    if not me and type(myIndex) == "number" and myIndex > 0 then
        me = GP_EB_DispApi(entities, "GetByIndex", myIndex)
    end
    if type(myIndex) ~= "number" or myIndex <= 0 or not me then
        return c.state, nil
    end
    local class = GP_EB_DispEnt(me, "GetPropInt", "m_iClass")
    if class ~= nil and class ~= 9 then return c.state, nil end

    local found, seen, hasClassList = {}, {}, false
    local function add(ent)
        if not ent or GP_EB_DispEnt(ent, "IsValid") == false then return end
        local i = GP_EB_DispEnt(ent, "GetIndex")
        if type(i) == "number" and seen[i] then return end
        if type(i) == "number" then seen[i] = true end
        found[#found + 1] = ent
    end
    for _, name in ipairs({"CObjectDispenser", "C_ObjectDispenser"}) do
        local results = GP_EB_DispApi(entities, "FindByClass", name)
        if type(results) == "table" then
            hasClassList = true
            for _, ent in pairs(results) do add(ent) end
        end
    end
    if #found == 0 then
        local highest = GP_EB_DispApi(entities, "GetHighestEntityIndex")
        if type(highest) == "number" and highest > 0 then
            if now < c.deepAt or now - c.deepAt >= 1.0 then
                c.deepIndices, c.deepAt = {}, now
                for i = 1, math.min(highest, 4096) do
                    local ent = GP_EB_DispApi(entities, "GetByIndex", i)
                    local name = GP_EB_DispEnt(ent, "GetClass")
                    if type(name) == "string" and name:lower():find("dispenser", 1, true) then
                        c.deepIndices[#c.deepIndices + 1] = i
                        add(ent)
                    end
                end
            else
                for _, i in ipairs(c.deepIndices) do
                    local ent = GP_EB_DispApi(entities, "GetByIndex", i)
                    local name = GP_EB_DispEnt(ent, "GetClass")
                    if type(name) == "string" and name:lower():find("dispenser", 1, true) then
                        add(ent)
                    end
                end
            end
            hasClassList = true
        end
    end
    if not hasClassList then return c.state, nil end

    local unknownOwner = false
    for _, disp in ipairs(found) do
        local builder = GP_EB_DispEnt(disp, "GetPropEntity", "m_hBuilder")
        local owner = GP_EB_DispEnt(builder, "GetIndex")
        if type(owner) ~= "number" or owner <= 0 then
            local raw = GP_EB_DispEnt(disp, "GetPropInt", "m_hBuilder")
            if type(raw) == "number" and raw ~= -1 then
                local decoded = raw % 2048
                if decoded > 0 and decoded < 2047 then owner = decoded end
            end
        end
        if type(owner) ~= "number" then
            unknownOwner = true
        elseif owner == myIndex then
            local hp = GP_EB_DispEnt(disp, "GetPropInt", "m_iHealth")
                or GP_EB_DispEnt(disp, "GetHealth")
            if type(hp) ~= "number" or hp > 0 then
                c.entityIndex = GP_EB_DispEnt(disp, "GetIndex")
                if GP_EB_DispTruth(disp, "m_bCarried") then
                    c.state = "carried"
                elseif GP_EB_DispTruth(disp, "m_bPlacing") then
                    c.state = "blueprint"
                elseif GP_EB_DispTruth(disp, "m_bBuilding") then
                    c.state = "building"
                else
                    c.state = "up"
                end
                return c.state, c.entityIndex
            end
        end
    end
    c.state = unknownOwner and "unknown" or "down"
    return c.state, nil
end

-- A completed Rottenburg setup arms a lightweight, debounced Dispenser
-- existence monitor. Only OWNED buildings count. A missing building must
-- persist for >1.25s to avoid reacting to a single replication gap.
function GP_EB_RottenburgRepairDisarm()
    local rt = GP_EB_ROTTENBURG_REPAIR
    rt.armed, rt.sawDispenser, rt.missingSince = false, false, nil
    rt.repairNeeded, rt.lastObservedDispenser = false, nil
    rt.nextScan = 0
    rt.postBuyPending, rt.postBuyWave, rt.postBuyAt = false, nil, 0
    rt.shopVerifiedAt, rt.shopVerifiedWave = 0, nil
    rt.checkedWave, rt.waveCompletionAt, rt.waveCompletedIndex = nil, 0, nil
    rt.fallbackArmedWave, rt.lastDebugAt = nil, 0
    rt.armReason, rt.blockReason, rt.lastExitSeen = "not armed", "waiting for setup", nil
end
-- A new wave requires a new EngiBuy completion before the next rebuild.
-- Do not reset an already-running delivery route here.
function GP_EB_RottenburgRepairClearPostBuy()
    local rt = GP_EB_ROTTENBURG_REPAIR
    rt.postBuyPending, rt.postBuyWave, rt.postBuyAt = false, nil, 0
    rt.shopVerifiedAt, rt.shopVerifiedWave = 0, nil
    rt.missingSince, rt.repairNeeded = nil, false
end
function GP_EB_RottenburgRepairAfterBuy(boughtWave)
    if not GP_EB_MapIsRottenburg() or GP_EB.missionComplete then return end
    local wave = tonumber(boughtWave) or 0
    -- The ObjectiveResource wave counter may still show the PREVIOUS wave
    -- while EngiBuy has already killed/respawned for the next one. The buy
    -- cycle's killWave is more authoritative at that particular boundary.
    local boughtFor = tonumber(GP_EB.killWave) or 0
    if boughtFor > wave and not GP_EB.awaitingRespawn then wave = boughtFor end
    local observed = tonumber(GP_GetWaveNumber and GP_GetWaveNumber()) or 0
    if observed > wave then wave = observed end
    if (tonumber(GP_EB.lastCompletedWave) or 0) >= 1
       and (tonumber(GP_EB.lastCompletedWave) or 0) + 1 > wave then
        wave = tonumber(GP_EB.lastCompletedWave) + 1
    end
    if wave < 2 then return end  -- NO dispenser repair on Wave 1.
    local rt = GP_EB_ROTTENBURG_REPAIR
    if rt.checkedWave == wave then return end
    rt.server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    rt.map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    rt.postBuyPending, rt.postBuyWave = true, wave
    rt.postBuyAt = (globals and globals.CurTime and globals.CurTime()) or 0
    -- This is called FROM GP_EB_Finish, not from a periodic live-wave scan.
    -- The buyer only finishes an actual purchase cycle while in the shop.
    local me = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
    local inShop = false
    if me and me.GetPropInt then
        local ok, v = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
        inShop = ok and v == 1
    end
    if inShop and not GP_EB.waveLive then
        rt.shopVerifiedAt, rt.shopVerifiedWave = rt.postBuyAt, wave
    else
        rt.shopVerifiedAt, rt.shopVerifiedWave = 0, nil
    end
    rt.nextScan = 0
    if print then print("[Rottenburg v61] EngiBuy finished for Wave " .. tostring(wave) ..
        "; shop=" .. tostring(inShop) .. "; combat=" .. tostring(GP_EB.waveLive) ..
        "; checking whether Dispenser needs repair") end
    rt.missingSince = nil
    rt.repairNeeded = false
    rt.blockReason = "EngiBuy finished; checking own Dispenser (wave 2+)"
end
-- Executed *before* the normal wave-complete route reset. Preserving proof
-- that the initial delivery finished is essential if the Dispenser was blown
-- up in the final few frames of a wave (or after the last periodic scan).
function GP_EB_RottenburgRepairOnWaveComplete(now)
    if not GP_EB_MapIsRottenburg() then return end
    local rt, st = GP_EB_ROTTENBURG_REPAIR, GP_EB_MANNHATTAN_W1
    -- Preserve the explicit completed-wave boundary even if the round's
    -- wave counter lags or EngiBuy finishes before it updates.
    rt.waveCompletionAt = now
    rt.waveCompletedIndex = tonumber(GP_EB.wave)
        or tonumber(GP_GetWaveNumber and GP_GetWaveNumber())
    if st.active and st.done and st.phase == "complete" then
        rt.armed, rt.sawDispenser = true, true
        rt.armReason = "completed delivery before wave reset"
    end
    -- A missing dispenser is still recoverable when the script was loaded
    -- mid-match. An OWNED exit confirms that the route is established;
    -- normal, still-running setup never counts as a finished route.
    if not rt.armed and not (st.active and not st.done) then
        local me = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
        if me and GP_GetClassId(me) == 9
            and GP_EB_MannhattanOwnedObject(me, "CObjectTeleporter", 1) then
            rt.armed, rt.sawDispenser = true, true
            rt.armReason = "existing owned exit on completed wave"
        end
    end
    if rt.armed then
        rt.server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
        rt.map = (engine and engine.GetMapName and engine.GetMapName()) or ""
        rt.nextScan = 0
    end
end
-- Exposed to Smart AutoF4 only while the wave is NOT live. The buyer still
-- has its own separate hold and always retains purchase priority.
function GP_EB_RottenburgRepairRouteInProgress()
    local st = GP_EB_MANNHATTAN_W1
    return GP_EB_MapIsRottenburg() and st.active and st.repairMode and not st.done
end
function GP_EB_RottenburgRepairNeedsTime()
    local rt, st = GP_EB_ROTTENBURG_REPAIR, GP_EB_MANNHATTAN_W1
    local now = (globals and globals.CurTime and globals.CurTime()) or 0
    local setup = false
    if GP_TP_IsSetupPhase then
        local ok, value = pcall(GP_TP_IsSetupPhase)
        setup = ok and value == true
    end
    return GP_EB_MapIsRottenburg() and not GP_EB.missionComplete
        and (not GP_EB.waveLive or setup)
        and ((rt.postBuyPending and now - (rt.postBuyAt or now) < 120.0)
            or (st.active and st.repairMode and not st.done))
end
function GP_EB_RottenburgDispenserRepairTick(me, now, fromBuyerFinish)
    if not GP_EB_MapIsRottenburg() then
        GP_EB_RottenburgRepairDisarm()
        return
    end
    local st, rt = GP_EB_MANNHATTAN_W1, GP_EB_ROTTENBURG_REPAIR
    local server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    if rt.server == "" and rt.map == "" then
        rt.server, rt.map = server, map
    elseif rt.server ~= server or rt.map ~= map then
        GP_EB_RottenburgRepairDisarm()
        rt.server, rt.map = server, map
    end
    if not (me and me.IsAlive and me:IsAlive() and GP_GetClassId(me) == 9) then return end
    if not GP_EB_Enabled() or GP_EB.missionComplete then return end
    if GP_EB_FailReplay.pending then
        GP_EB_RottenburgRepairClearPostBuy() -- a full failed-wave rebuild takes priority
        rt.blockReason = "failed-wave full Engineer setup has priority"
        return
    end
    if not fromBuyerFinish and now < rt.nextScan then return end
    rt.nextScan = now + 0.20

    -- A missing-Dispenser repair is ONLY allowed after that wave's EngiBuy, never mid-wave.
    -- Recover the post-buy handoff when EngiBuy finished with no purchases,
    -- or when the wave counter/event updated after its finish callback.
    if not rt.postBuyPending and not (st.active and not st.done) then
        local finishedAt = tonumber(GP_EB.lastAttemptAt) or 0
        local completedAt = tonumber(rt.waveCompletionAt) or 0
        local completedWave = tonumber(GP_EB.lastCompletedWave)
            or tonumber(rt.waveCompletedIndex) or 0
        local nextWave = completedWave + 1
        local killedFor = tonumber(GP_EB.killWave) or 0
        local attemptedWave = tonumber(GP_EB.lastAttemptWave) or 0
        if nextWave >= 2 and rt.checkedWave ~= nextWave
           and completedAt > 0 and finishedAt >= completedAt
           and killedFor >= nextWave
           and (attemptedWave >= nextWave or killedFor == nextWave)
           and not GP_EB.running and not GP_EB.awaitingRespawn
           and not GP_EB.rebuyPending and not GP_EB.pendingKillWave then
            rt.fallbackArmedWave = nextWave
            GP_EB_RottenburgRepairAfterBuy(nextWave)
        end
    end
    if not rt.postBuyPending then return end
    local wave = tonumber(rt.postBuyWave) or 0
    if wave < 2 then
        GP_EB_RottenburgRepairClearPostBuy()
        rt.blockReason = "Wave 1: normal initial setup only"
        return
    end
    -- Use the same owned-building detection as Dispenser Detector v3.
    -- Never tear down a healthy Dispenser. A carrying/blueprint state is
    -- not a destroyed Dispenser either: do not start another build.
    local dispenserState = GP_EB_RottenburgDispenserState()
    if dispenserState == "up" or dispenserState == "building"
       or dispenserState == "carried" or dispenserState == "blueprint" then
        rt.checkedWave = wave
        GP_EB_RottenburgRepairClearPostBuy()
        rt.armed, rt.sawDispenser = true, true
        rt.blockReason = "repair skipped: own Dispenser " .. dispenserState
        if print then print("[Rottenburg/repair] Wave " .. tostring(wave) ..
            ": Dispenser " .. dispenserState .. "; skipping repair") end
        return
    end
    if dispenserState ~= "down" then
        rt.missingSince = nil
        rt.blockReason = "repair paused: cannot verify owned Dispenser (sensor unknown)"
        return
    end
    -- Debounce destruction across multiple scans. Do not rebuild for a
    -- single missing-entity frame or a brief replication gap.
    if not rt.missingSince then rt.missingSince = now end
    if now - rt.missingSince < 0.65 then
        rt.blockReason = "confirming destroyed Dispenser before repair"
        return
    end
    -- A previous wave's unfinished route can be superseded after EngiBuy,
    -- but only AFTER the Dispenser has been confirmed missing.
    if st.active and not st.done then
        if (st.repairMode and st.repairForWave and wave > st.repairForWave)
            or (not st.failedWaveReplay and wave >= 2
                and (tonumber(GP_EB.killWave) or 0) >= wave
                and (tonumber(GP_EB.lastCompletedWave) or 0) >= wave - 1) then
            GP_EB_MannhattanWave1RouteReset()
        else
            rt.blockReason = "Engineer setup/delivery route already in progress"
            return
        end
    end
    rt.repairNeeded = true

    if GP_EB.running or GP_EB.awaitingRespawn or GP_EB.pendingKillWave or GP_EB.rebuyPending then
        rt.blockReason = "every-wave rebuild awaiting EngiBuy/purchases/respawn"
        return
    end
    if GP_EB.routeStartRequested then
        if not GP_EB_FailReplay.pending and wave >= 2 then
            -- An old Wave-1 route request is not allowed to supersede a
            -- finished next-wave buy. The mandatory Dispenser route wins.
            GP_EB.routeStartRequested = false
        else
            rt.blockReason = "initial/failed-wave setup has priority"
            return
        end
    end
    local betweenWaves = false
    if GP_TP_IsSetupPhase then
        local ok, v = pcall(GP_TP_IsSetupPhase)
        betweenWaves = ok and v == true
    end
    if not betweenWaves and GP_GetRoundState then
        local ok, state = pcall(GP_GetRoundState)
        betweenWaves = ok and (state == 3 or state == 10)
    end
    if not betweenWaves and entities and entities.FindByClass then
        local objs = entities.FindByClass("CTFObjectiveResource")
        local obj = objs and objs[1]
        if obj and obj.GetPropInt then
            local ok, v = pcall(obj.GetPropInt, obj, "m_bMannVsMachineBetweenWaves")
            betweenWaves = ok and v == 1
        end
    end
    -- A completed wave plus the following Engineer buy is a safe boundary,
    -- even if mvm_begin_wave left waveLive stale on a buggy server. When
    -- waveLive is true, however, REQUIRE positive setup evidence; a previous
    -- completion event alone is not permission to repair during combat.
    local completedWave = tonumber(GP_EB.lastCompletedWave)
        or tonumber(rt.waveCompletedIndex) or 0
    local purchasedNextWave = (tonumber(GP_EB.killWave) or 0) >= wave
        and (tonumber(GP_EB.lastAttemptAt) or 0) >= (tonumber(rt.waveCompletionAt) or 0)
    local observedWave = tonumber(GP_GetWaveNumber and GP_GetWaveNumber())
        or tonumber(GP_EB.wave) or 0
    local confirmedPostWave = purchasedNextWave and
        (completedWave >= (wave - 1)
         or (betweenWaves and observedWave >= wave))
    -- A completed shop transaction inside an upgrade zone, following the
    -- next-wave kill/respawn, also proves we reached post-wave setup even
    -- when the wave-complete event or between-wave netvar was missed.
    local inUpgradeZone = false
    if me and me.GetPropInt then
        local okZone, zone = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
        inUpgradeZone = okZone and zone == 1
    end
    local shopBoundary = purchasedNextWave and inUpgradeZone
        and (tonumber(GP_EB.lastAttemptAt) or 0) > 0
    -- The shop handoff is more reliable than map-specific setup netvars:
    -- it is freshly captured by EngiBuy itself, with the Engineer still at
    -- the upgrade cabinet. It does NOT require killWave/completion events.
    local freshShopHandoff = rt.shopVerifiedWave == wave
        and (tonumber(rt.shopVerifiedAt) or 0) > 0
        and now >= rt.shopVerifiedAt and now - rt.shopVerifiedAt <= 30.0
    -- Never begin a new rebuild in actual live combat. If the wave flag
    -- is stale but the engine positively reports setup, it may proceed.
    if GP_EB.waveLive and not (betweenWaves and (purchasedNextWave or freshShopHandoff)) then
        rt.blockReason = "rebuild queued; combat still live (not using TpWalk)"
        return
    end
    betweenWaves = betweenWaves
        or (not GP_EB.waveLive and (freshShopHandoff or confirmedPostWave or shopBoundary))
    if not betweenWaves then
        rt.blockReason = "mandatory rebuild awaiting verified between-wave setup"
        return
    end
    local ownExit = GP_EB_MannhattanOwnedObject(me, "CObjectTeleporter", 1)
    -- Exit ownership can be unreadable in Lua even when the building works.
    -- Do not permanently veto the whole repair on this optional sensor.
    local exitWarning = (not ownExit) and "; exit not detected (will try existing teleporter)" or ""

    rt.checkedWave = wave
    GP_EB_RottenburgRepairClearPostBuy()
    rt.armed, rt.sawDispenser = false, false
    rt.blockReason = "starting Wave " .. tostring(wave) .. " missing-Dispenser repair" .. exitWarning
    -- EngiBuy has already respawned us at the upgrade cabinet.
    -- Go to waypoint 3, BUILD the missing Dispenser (do not destroy),
    -- then pick it up, teleport, deliver, killbind, and resume TpWalk.
    local label = GP_EB_SelectEngineerMapRoute(me)
    st.active, st.done, st.repairMode, st.failedWaveReplay = true, false, true, false
    st.phase, st.phaseSince, st.index = "repair_return", now, 1
    st.repairForWave = wave
    st.repairDestroyStartedAt, st.repairDestroyLastAt, st.repairDestroyAttempts = 0, 0, 0
    st.server, st.map = server, map
    st.routeLabel = "Rottenburg Wave " .. tostring(wave) .. " Dispenser rebuild (" .. tostring(label) .. ")"
    st.lastAlive = true
    st.repairDeathSeen = false
    st.repairKillAt, st.repairLastKillAt, st.repairKillRetries = 0, 0, 0
    st.status = "After EngiBuy: going to waypoint 3 to rebuild missing Dispenser" .. exitWarning
    st.bestDistance, st.stuckAt = math.huge, 0
    GP_EB_MannhattanClearBuildState()
    if config then config.tpWalkEnabled = false end
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
    if print then print("[Rottenburg v61] Rebuild route ACTIVE Wave " .. tostring(wave) ..
        "; heading to waypoint 3; TpWalk suspended") end
    tpIsWaitingForTeleporter, tpNoTeleFallbackActive = false, false
    if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
    if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
    if AddNotification then
        AddNotification("Rottenburg: Wave " .. tostring(wave) .. " missing Dispenser; repair started", "warning", 4.0)
    end
end

function GP_EB_RepairAndRefillStatus()
    local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    local rt, st = GP_EB_ROTTENBURG_REPAIR, GP_EB_MANNHATTAN_W1
    return string.format(
        "charges=%s, cash=%s, canteenConfirmed=%s, refillBlock=%.1f, buyer=%s/%s, " ..
        "waveLive=%s, waveCompleted=%s, rebuyPending=%s, repairArmed=%s, " ..
        "dispenserSeen=%s, missingSince=%s, repairNeeded=%s, repairRoute=%s/%s, " ..
        "armedBy=%s, blockedBy=%s, routeStatus=%s, " ..
        "ownedExit=%s, ownedDispenser=%s, postBuyPending=%s, postBuyWave=%s, " ..
        "checkedWave=%s, completedAt=%s, recoveredWave=%s, " ..
        "inUpgradeZone=%s, permBlock=%.1f, permReason=%s",
        tostring(GP_EB_GetBottleCharges(me)), tostring(GP_EB_Currency(me)),
        tostring(GP_EB.canteenConfirmed),
        math.max(0, (GP_EB.canteenRetryAfter or 0) - (globals and globals.CurTime and globals.CurTime() or 0)),
        tostring(GP_EB.running), tostring(GP_EB.phase), tostring(GP_EB.waveLive),
        tostring(GP_EB.lastCompletedWave), tostring(GP_EB.rebuyPending),
        tostring(rt.armed), tostring(rt.sawDispenser), tostring(rt.missingSince),
        tostring(rt.repairNeeded), tostring(st.active), tostring(st.phase),
        tostring(rt.armReason), tostring(rt.blockReason), tostring(st.status),
        tostring(GP_EB_MannhattanOwnedObject(me, "CObjectTeleporter", 1) ~= nil),
        tostring(GP_EB_MannhattanOwnedObject(me, "CObjectDispenser") ~= nil),
        tostring(rt.postBuyPending), tostring(rt.postBuyWave),
        tostring(rt.checkedWave), tostring(rt.waveCompletionAt),
        tostring(rt.fallbackArmedWave),
        tostring(me and me.GetPropInt and me:GetPropInt("m_bInUpgradeZone") or nil),
        math.max(0, (GP_EB.permanentBlockedUntil or 0) -
            (globals and globals.CurTime and globals.CurTime() or 0)),
        tostring(GP_EB.permanentBlockReason))
end

-- The pickup angle must track the actual Dispenser, not a fixed -90 yaw.
-- A right-click only picks up a building when the player is close enough AND
-- the crosshair is pointing at that building. This runs automatically.
function GP_EB_MannhattanCarryingDispenser(me)
    if not me then return false end
    local carry = false
    if me.GetPropBool then
        local ok, v = pcall(me.GetPropBool, me, "m_bCarryingObject")
        carry = ok and v == true
    end
    if not carry and me.GetPropInt then
        local ok, v = pcall(me.GetPropInt, me, "m_bCarryingObject")
        carry = ok and (v == 1 or v == true)
    end
    if carry and me.GetPropEntity then
        local ok, ent = pcall(me.GetPropEntity, me, "m_hCarriedObject")
        if ok and ent and ent.GetClass then
            local classOk, name = pcall(ent.GetClass, ent)
            if classOk and type(name) == "string" then
                return name == "CObjectDispenser"
            end
        end
    end
    local disp = GP_EB_MannhattanOwnedObject(me, "CObjectDispenser")
    if disp then
        local carried = nil
        if disp.GetPropBool then
            local ok, v = pcall(disp.GetPropBool, disp, "m_bCarried")
            if ok then carried = v end
        end
        if carried == nil and disp.GetPropInt then
            local ok, v = pcall(disp.GetPropInt, disp, "m_bCarried")
            if ok then carried = (v == 1 or v == true) end
        end
        if carried == true then return true end
        -- Some builds expose only the player's carry netprop.
        if carried == nil and carry then return true end
    end
    return false
end

local function GP_EB_MannhattanPickupAim(cmd, me, dispenser)
    local pos = dispenser and dispenser.GetAbsOrigin and dispenser:GetAbsOrigin() or nil
    local origin = me and me.GetAbsOrigin and me:GetAbsOrigin() or nil
    if not pos or not origin then return nil, nil, nil end
    local eye = GP_EB_MannhattanViewPosition(me, origin)
    local targetZ = pos.z + 37
    -- Pick a point near the Dispenser's actual center, if bounds are exposed.
    if dispenser.GetMins and dispenser.GetMaxs then
        local okMin, mins = pcall(dispenser.GetMins, dispenser)
        local okMax, maxs = pcall(dispenser.GetMaxs, dispenser)
        if okMin and okMax and mins and maxs
           and type(mins.z) == "number" and type(maxs.z) == "number" then
            targetZ = pos.z + math.max(22, math.min(62, (mins.z + maxs.z) * 0.5))
        end
    end
    if cmd and cmd.SetViewAngles then
        local aim = Vector3(pos.x - eye.x, pos.y - eye.y, targetZ - eye.z):Angles()
        cmd:SetViewAngles(aim.x, aim.y, 0)
    end
    local dx, dy = pos.x - origin.x, pos.y - origin.y
    return pos, origin, math.sqrt(dx * dx + dy * dy)
end

function GP_EB_MannhattanPickupTick(cmd, me, now)
    local st = GP_EB_MANNHATTAN_W1
    GP_EB_ClearRouteMovement(cmd, true)

    if GP_EB_MannhattanCarryingDispenser(me) then
        -- Release pickup input before moving to the entrance.
        if cmd.GetButtons and cmd.SetButtons then
            local b = tonumber(cmd:GetButtons()) or 0
            cmd:SetButtons(GP_EB_SetInputBit(b, 2048, false))
        end
        st.expectedTransport = true
        st.phase, st.phaseSince = "engi_tpwalk", now
        st.tpwalkSince, st.nextTpWarn = now, now + 15
        st.status = "Dispenser picked up; Engi TpWalk to entrance"
        if config then config.tpWalkEnabled = true end
        tpForceModeEnabled = false
        if config then config.forceTpWalkEnabled = false end
        tpToggleNeedsTrigger = false
        sniperUpgradeCompleted = true
        sniperUpgradeCompletedTime = now
        tpStickyArmed = true
        teleporterManuallyDisabled = false
        teleporterConfig.autoWalkEnabled = false
        if SaveConfig and GP_CfgPath then pcall(SaveConfig, GP_CfgPath(), config) end
        if AddNotification then AddNotification("Dispenser picked up - Engineer TpWalk started", "success", 4.0) end
        return true
    end

    if st.pickupSince == 0 then st.pickupSince = now end
    local dispenser = GP_EB_MannhattanOwnedObject(me, "CObjectDispenser")
    if not dispenser then
        st.status = "waypoint 3: waiting for owned Dispenser entity"
        if now - st.pickupSince > 5 and now >= (st.nextTpWarn or 0) then
            st.nextTpWarn = now + 7
            if AddNotification then AddNotification("Engineer pickup: own Dispenser not found", "warning", 4.0) end
        end
        return true
    end
    -- Aim at the Dispenser entity automatically. No manually assigned angle
    -- or hard-coded building coordinates are needed.
    local buildingPos, playerPos, distance = GP_EB_MannhattanPickupAim(cmd, me, dispenser)
    if not buildingPos or not playerPos or not distance then
        st.status = "waypoint 3: waiting for Dispenser position"
        return true
    end

    -- Approach automatically if the Dispenser was built farther from waypoint 3.
    -- Standing ~70 units from its center is close enough for normal pickup.
    if distance > 72 then
        local movement = ComputeMove(cmd, playerPos, Vector3(buildingPos.x, buildingPos.y, playerPos.z))
        local speed = math.min(220, math.max(65, (distance - 65) * 2.5))
        if cmd.SetForwardMove then cmd:SetForwardMove(movement.x * (speed / 450)) end
        if cmd.SetSideMove then cmd:SetSideMove(movement.y * (speed / 450)) end
        st.status = string.format("waypoint 3: approaching Dispenser (%.0fu)", distance)
        if cmd.GetButtons and cmd.SetButtons then
            local b = tonumber(cmd:GetButtons()) or 0
            cmd:SetButtons(GP_EB_SetInputBit(b, 2048, false))
        end
        return true
    end

    -- Select melee (slot3) so IN_ATTACK2 is a building pickup, not a weapon
    -- secondary attack or blueprint rotation.
    local activeWeapon = me.GetPropEntity and me:GetPropEntity("m_hActiveWeapon") or nil
    local hasOtherWeapon = false
    if activeWeapon and activeWeapon.GetLoadoutSlot then
        local ok, slot = pcall(activeWeapon.GetLoadoutSlot, activeWeapon)
        hasOtherWeapon = ok and type(slot) == "number" and slot ~= 2
    end
    if hasOtherWeapon then
        if now >= (st.nextWrenchAt or 0) and client and client.Command then
            pcall(client.Command, "slot3", true)
            st.nextWrenchAt = now + 0.6
        end
        st.status = "waypoint 3: selecting wrench for Dispenser pickup"
        return true
    end

    -- Pulse right-click with releases between attempts (edge-triggered).
    if now >= (st.nextPickupPulse or 0) then
        st.nextPickupPulse = now + 0.48
        st.pickupAttempts = st.pickupAttempts + 1
    end
    if cmd.GetButtons and cmd.SetButtons then
        local b = tonumber(cmd:GetButtons()) or 0
        local pulse = st.pickupAttempts > 0 and (st.nextPickupPulse - now) > 0.35
        b = GP_EB_SetInputBit(b, 2048, pulse) -- IN_ATTACK2
        b = GP_EB_SetInputBit(b, 1, false)
        cmd:SetButtons(b)
    end
    st.status = string.format("waypoint 3: picking up Dispenser (%.0fu; attempt %d)",
        distance, st.pickupAttempts)
    if now - st.pickupSince > 9 and now >= (st.nextTpWarn or 0) then
        st.nextTpWarn = now + 7
        if AddNotification then AddNotification("Dispenser pickup not confirmed - check nearby obstruction", "warning", 4.0) end
    end
    return true
end

-- Engineer's dedicated TpWalk is only needed until he reaches the Exit.
-- Clear the legacy movement-lock state at that moment, even if the Dispenser
-- cannot be deployed. This lets the player correct placement manually.
local function GP_EB_MannhattanUnlockAfterTeleport()
    if config then config.tpWalkEnabled = false end
    tpForceModeEnabled = false
    if config then config.forceTpWalkEnabled = false end
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
    tpIsWaitingForTeleporter = false
    tpNoTeleFallbackActive = false
    tpUseVerifyActive = false
    tpStickyArmed = false
    tpToggleNeedsTrigger = false
    teleporterJustUsed = true
    -- Persist the auto-toggle being turned back off so it doesn't re-arm on
    -- script reload after we already teleported.
    if SaveConfig and GP_CfgPath then pcall(SaveConfig, GP_CfgPath(), config) end
end

function GP_EB_MannhattanTpWalkTick(cmd, me, now)
    local st = GP_EB_MANNHATTAN_W1
    GP_EB_ClearRouteMovement(cmd, true)
    local playerPos = me:GetAbsOrigin()
    if not playerPos then return true end
    -- Real teleport confirmation: physically near our placed Exit and far
    -- from the Entrance. Merely reaching the Entrance does not count.
    local exitPoint = GP_EB_MANNHATTAN_W1_POINTS[#GP_EB_MANNHATTAN_W1_POINTS]
    local entrancePoint = GP_EB_MANNHATTAN_W1_POINTS[4]
    local distExit = math.sqrt((playerPos.x-exitPoint.x)^2+(playerPos.y-exitPoint.y)^2)
    local distEntrance = math.sqrt((playerPos.x-entrancePoint.x)^2+(playerPos.y-entrancePoint.y)^2)
    if distExit < 600 and distEntrance > 900 then
        GP_EB_MannhattanUnlockAfterTeleport()
        st.phase, st.phaseSince = "deliver_dispenser", now
        st.tpLandingPos = playerPos
        st.dropSince, st.nextDropCheck, st.dropPulses, st.deliveryArrivedAt = now, 0, 0, 0
        st.status = GP_EB_MapIsRottenburg()
            and "Teleport confirmed; walking to Rottenburg dispenser delivery point"
            or "Teleport confirmed; aim 0,0,0 and place dispenser"
        if GP_F4_OnTpSuccess then GP_F4_OnTpSuccess() end
        if AddNotification then AddNotification("Engineer teleported - placing carried dispenser", "success", 4.0) end
        return true
    end
    if not GP_EB_MannhattanCarryingDispenser(me) then
        st.status = "TpWalk: lost carried Dispenser; waiting for verification"
        return true
    end
    local entrance = GP_EB_MannhattanOwnedObject(me, "CObjectTeleporter", 0)
    local target = (entrance and entrance.GetAbsOrigin and entrance:GetAbsOrigin()) or entrancePoint
    local dxy = math.sqrt((target.x-playerPos.x)^2+(target.y-playerPos.y)^2)
    if dxy > 7 then
        local mv = ComputeMove(cmd, playerPos, Vector3(target.x, target.y, playerPos.z))
        local speed = math.min(380, math.max(36, dxy * 3))
        if dxy < 35 then speed = math.min(speed, 110) end
        if cmd.SetForwardMove then cmd:SetForwardMove(mv.x * (speed / 450)) end
        if cmd.SetSideMove then cmd:SetSideMove(mv.y * (speed / 450)) end
    end
    st.status = string.format("Engineer TpWalk: carrying Dispenser to entrance (%.0fu)", dxy)
    if now > (st.nextTpWarn or 0) then
        st.nextTpWarn = now + 12
        if AddNotification then AddNotification("Engi TpWalk: waiting for usable entrance", "info", 3.0) end
    end
    return true
end

function GP_EB_MannhattanDeliverTick(cmd, me, now)
    local st = GP_EB_MANNHATTAN_W1
    -- Rottenburg: after teleporting while carrying the Dispenser, continue
    -- to the requested delivery coordinate before allowing any placement.
    -- Mannhattan retains its existing immediate 0,0,0 placement logic.
    if GP_EB_MapIsRottenburg() then
        local goal = GP_EB_ROTTENBURG_DISPENSER_DELIVERY
        local origin = me:GetAbsOrigin()
        if not origin then return true end
        local eye = GP_EB_MannhattanViewPosition(me, origin)
        local dx, dy, dz = goal.x - eye.x, goal.y - eye.y, goal.z - eye.z
        local dist = math.sqrt(dx * dx + dy * dy)
        local vx, vy = GP_EB_MannhattanVelocityXY(me)
        local hspeed = (vx and vy) and math.sqrt(vx*vx + vy*vy) or nil
        local inPosition = dist <= GP_EB_ROTTENBURG_DELIVERY_REACH_RADIUS
            and math.abs(dz) <= 72
            and (hspeed == nil or hspeed <= 18)
        if not inPosition then
            st.deliveryArrivedAt = 0
            GP_EB_ClearRouteMovement(cmd, true)
            local aimX = dx - (vx or 0) * 0.20
            local aimY = dy - (vy or 0) * 0.20
            local aimDist = math.sqrt(aimX*aimX + aimY*aimY)
            if aimDist > 0.25 then
                local aim = Vector3(origin.x + aimX, origin.y + aimY, origin.z)
                local movement = ComputeMove(cmd, origin, aim)
                local speed = math.min(350, math.max(18, aimDist * 2.0))
                if dist < 65 then speed = math.min(speed, 95) end
                if dist < 22 then speed = math.min(speed, 38) end
                if cmd.SetForwardMove then cmd:SetForwardMove(movement.x * (speed / 450)) end
                if cmd.SetSideMove then cmd:SetSideMove(movement.y * (speed / 450)) end
            end
            st.status = string.format("Rottenburg: delivering Dispenser to 811.82,-1282.02 (%.1fu)", dist)
            return true
        end
        GP_EB_ClearRouteMovement(cmd, true)
        if st.deliveryArrivedAt <= 0 then st.deliveryArrivedAt = now end
        if now - st.deliveryArrivedAt < GP_EB_ROTTENBURG_DELIVERY_SETTLE_SECONDS then
            st.status = "Rottenburg: stopped at dispenser waypoint; settling before placement"
            return true
        end
        GP_EB_MannhattanHoldView(cmd, goal.pitch, goal.yaw)
    else
        -- Existing Mannhattan behavior: release movement after teleportation.
        GP_EB_MannhattanHoldView(cmd, GP_EB_MANNHATTAN_AFTER_TP_PITCH, GP_EB_MANNHATTAN_AFTER_TP_YAW)
    end
    local disp = GP_EB_MannhattanOwnedObject(me, "CObjectDispenser")
    local carrying = GP_EB_MannhattanCarryingDispenser(me)
    if st.expectedTransport and not carrying and disp and disp.GetAbsOrigin then
        local okPos, pos = pcall(disp.GetAbsOrigin, disp)
        local landed = st.tpLandingPos or me:GetAbsOrigin()
        if okPos and pos then
            local okPlacing, placing = false, nil
            if disp.GetPropInt then
                okPlacing, placing = pcall(disp.GetPropInt, disp, "m_bPlacing")
            end
            if not okPlacing and disp.GetPropBool then
                okPlacing, placing = pcall(disp.GetPropBool, disp, "m_bPlacing")
            end
            local placed = (not okPlacing or placing == 0 or placing == false)
            local atDelivery = false
            if GP_EB_MapIsRottenburg() then
                -- The delivery waypoint is not the teleporter landing point.
                -- The old 300u-from-landing check could miss a valid drop,
                -- leaving the Engineer stuck in delivery instead of killing.
                local goal = GP_EB_ROTTENBURG_DISPENSER_DELIVERY
                local playerPos = me:GetAbsOrigin()
                if goal and playerPos then
                    local dx, dy = pos.x - goal.x, pos.y - goal.y
                    local px, py = pos.x - playerPos.x, pos.y - playerPos.y
                    atDelivery = (dx * dx + dy * dy <= 150 * 150)
                        and (px * px + py * py <= 220 * 220)
                end
            elseif landed then
                local dx, dy = pos.x - landed.x, pos.y - landed.y
                atDelivery = (dx * dx + dy * dy < 300 * 300)
            end
            if atDelivery and placed then
                -- Confirmed AFTER teleport: the owned Dispenser is no longer
                -- carried, is no longer a placement blueprint, and is near
                -- the actual delivery point. Killbind after a short settle
                -- delay, then re-arm ordinary TpWalk only after respawn.
                st.phase, st.done, st.phaseSince = "post_delivery_kill_wait", false, now
                st.postDeliveryKillAt, st.postDeliveryKillRetries = 0, 0
                st.postDeliveryDeathSeen = false
                st.status = "Dispenser delivered; killbinding after placement"
                if config then config.tpWalkEnabled = false end
                if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
                GP_EB_ClearRouteMovement(cmd, true)
                if cmd.GetButtons and cmd.SetButtons then
                    local b = tonumber(cmd:GetButtons()) or 0
                    cmd:SetButtons(GP_EB_SetInputBit(b, 1, false))
                end
                if print and GP_EB_MapIsRottenburg() then
                    print("[Rottenburg v62] Placed Dispenser confirmed after teleport; killbind queued")
                end
                if AddNotification then AddNotification("Dispenser placed - killbinding, then TpWalk", "success", 5.0) end
                return true
            end
        end
    end
    -- While hauling, attack1 confirms the location, NOT 'build 0 0'
    -- (which would create a new blueprint instead of redeploying the Dispenser).
    local attack = now-st.dropSince >= 0.20 and ((now-st.dropSince) % 0.40) < 0.10
    if cmd.GetButtons and cmd.SetButtons then
        local b = tonumber(cmd:GetButtons()) or 0
        b = GP_EB_SetInputBit(b, 2048, false)
        b = GP_EB_SetInputBit(b, 1, attack)
        cmd:SetButtons(b)
    end
    st.status = GP_EB_MapIsRottenburg()
        and "Rottenburg: looking 12.11,43.70,0; deploying Dispenser"
        or "after teleport: looking 0,0,0; deploying Dispenser"
    return true
end

local function GP_EB_MannhattanPlacementTick(cmd, me, now, index)
    local st = GP_EB_MANNHATTAN_W1
    local stop = GP_EB_MANNHATTAN_W1_BUILD_STOPS[index]
    local point = GP_EB_MANNHATTAN_W1_POINTS[index]
    if not (stop and point) then return false end
    GP_EB_ClearRouteMovement(cmd, true) -- stop moving and clear other automation's jump
    GP_EB_MannhattanHoldView(cmd,
        stop.pitch or GP_EB_MANNHATTAN_BUILD_PITCH,
        stop.yaw or GP_EB_MANNHATTAN_BUILD_YAW)
    if st.buildStopIndex ~= index then
        GP_EB_MannhattanClearBuildState()
        st.buildStopIndex, st.buildSince, st.nextBuildCmdAt = index, now, now
        st.status = "waypoint " .. index .. "/" .. #GP_EB_MANNHATTAN_W1_POINTS .. ": placing " .. stop.label
        if AddNotification then
            AddNotification((st.routeLabel or "Mannhattan") .. ": building " .. stop.label .. " at waypoint " .. index, "info", 3.0)
        end
    end
    -- Confirm a placed, owned building, not a temporary placement preview.
    -- Sampling every 0.12 sec avoids searching entity lists each command.
    if now >= st.nextPlacementCheck then
        st.nextPlacementCheck = now + 0.12
        if GP_EB_BuildingPlacedAtStop(me, stop, point) then
            st.lastBuildConfirmed = stop.label
            st.status = stop.label .. " confirmed"
            GP_EB_MannhattanClearBuildState()
            if st.repairMode and index == 3 then
                st.phase, st.phaseSince = "pickup_dispenser", now
                st.pickupSince, st.nextPickupPulse, st.pickupAttempts, st.nextWrenchAt = now, now, 0, 0
                st.status = "Dispenser rebuilt: picking it up before TpWalk"
            elseif index == #GP_EB_MANNHATTAN_W1_POINTS then
                st.phase, st.phaseSince = "exit_kill_wait", now
                st.exitPlacedAt, st.exitKillAt = now, 0
                st.exitKillRetries, st.observedDeath = 0, false
                st.status = "Exit confirmed; killbinding before Dispenser pickup run"
            elseif not st.repairMode then
                st.index = index + 1
                st.bestDistance, st.stuckAt = math.huge, 0
            end
            if AddNotification then
                AddNotification((st.routeLabel or "Mannhattan") .. ": " .. stop.label .. " placed - " ..
                    (st.phase == "exit_kill_wait" and "respawning for pickup" or "continuing route"), "success", 4.0)
            end
            -- No more build or jump input after placement confirmation.
            if cmd.GetButtons and cmd.SetButtons then
                local b = tonumber(cmd:GetButtons()) or 0
                cmd:SetButtons(GP_EB_SetInputBit(GP_EB_SetInputBit(b, 1, false), 2, false))
            end
            return true
        end
    end
    -- Final waypoint: if friction/momentum has moved us away during the
    -- no-jump wait, cancel placement mode and carefully re-approach point 9.
    -- The building confirmation above still wins when an exit already exists.
    if index == #GP_EB_MANNHATTAN_W1_POINTS then
        local origin = me:GetAbsOrigin()
        if origin then
            local dx, dy = point.x - origin.x, point.y - origin.y
            local drift = math.sqrt(dx * dx + dy * dy)
            -- Once within the precise arrival radius, brake without steering.
            -- Speed is handled by the build gate below, not by repeatedly
            -- cancelling this stop (which caused jitter at the waypoint).
            if st.buildCommands == 0 and drift > GP_EB_MANNHATTAN_FINAL_SETTLE_RADIUS then
                GP_EB_MannhattanClearBuildState()
                st.status = string.format("final waypoint: recentering (%.2fu away)", drift)
                st.bestDistance, st.stuckAt = math.huge, 0
                return true
            end
        end
    end
    -- Stay still for one full second before issuing exit-build/jump commands.
    if index == #GP_EB_MANNHATTAN_W1_POINTS
       and now - st.buildSince < GP_EB_MANNHATTAN_EXIT_SETTLE_SECONDS then
        if cmd.GetButtons and cmd.SetButtons then
            local b = tonumber(cmd:GetButtons()) or 0
            b = GP_EB_SetInputBit(b, 1, false) -- no attack during settling
            b = GP_EB_SetInputBit(b, 2, false) -- no jump during settling
            cmd:SetButtons(b)
        end
        local remaining = GP_EB_MANNHATTAN_EXIT_SETTLE_SECONDS - (now - st.buildSince)
        st.status = string.format("waypoint %d/%d: stabilizing %.1fs before Exit", index, #GP_EB_MANNHATTAN_W1_POINTS, math.max(0, remaining))
        return true
    end
    -- Only for the EXIT: wait for the actual player speed to be strictly
    -- below 6.07 units/s before sending the first build command or jump.
    -- Latch this permission after the first build command, because jumping
    -- itself naturally raises velocity.
    if index == #GP_EB_MANNHATTAN_W1_POINTS and st.buildCommands == 0 then
        local speed = GP_EB_MannhattanSpeed(me)
        if speed == nil or speed >= GP_EB_MANNHATTAN_FINAL_STOP_SPEED then
            if cmd.GetButtons and cmd.SetButtons then
                local b = tonumber(cmd:GetButtons()) or 0
                b = GP_EB_SetInputBit(b, 1, false)
                b = GP_EB_SetInputBit(b, 2, false)
                cmd:SetButtons(b)
            end
            st.status = speed and string.format("final waypoint: waiting for vel < 6.07 (%.2f)", speed)
                or "final waypoint: waiting for velocity reading"
            return true
        end
    end
    if now >= st.nextBuildCmdAt and client and client.Command then
        -- Request or refresh the Engineer blueprint, without destroying
        -- existing buildings. If lacking metal, retry on later ticks.
        pcall(client.Command, stop.buildCommand, true)
        st.buildCommands = st.buildCommands + 1
        st.nextBuildCmdAt = now + 3.5
    end
    -- Once EXIT placement has begun, keep targeting the exact final XY position
    -- even while jumping. The 1-second settle and <6.07 initial speed gate
    -- still happen BEFORE this section. No steering is added to other stops.
    if index == #GP_EB_MANNHATTAN_W1_POINTS and st.buildCommands > 0 then
        local origin = me:GetAbsOrigin()
        if origin and cmd.SetForwardMove and cmd.SetSideMove then
            local dx, dy = point.x - origin.x, point.y - origin.y
            local vx, vy = GP_EB_MannhattanVelocityXY(me)
            local horizontalSpeed = math.sqrt((vx or 0)^2 + (vy or 0)^2)
            local errorDistance = math.sqrt(dx * dx + dy * dy)
            -- Predict horizontal drift, then steer toward the exact target.
            -- Avoid micro-jitter when already nearly stationary on target.
            local aimX = dx - (vx or 0) * 0.22
            local aimY = dy - (vy or 0) * 0.22
            local aimDist = math.sqrt(aimX * aimX + aimY * aimY)
            if not (errorDistance < 0.60 and horizontalSpeed < 2.5)
               and aimDist > 0.30 then
                local aim = Vector3(origin.x + aimX, origin.y + aimY, origin.z)
                local movement = ComputeMove(cmd, origin, aim)
                local speed = math.min(100, math.max(8, aimDist * 1.9))
                if errorDistance < 6 then speed = math.min(speed, 32) end
                cmd:SetForwardMove(movement.x * (speed / 450))
                cmd:SetSideMove(movement.y * (speed / 450))
            end
        end
    end
    if cmd.GetButtons and cmd.SetButtons then
        local b = tonumber(cmd:GetButtons()) or 0
        cmd:SetButtons(GP_EB_SetInputBit(b, 2048, false))
    end
    local attackPulse = ((now - st.buildSince) % 0.32) < 0.09
    local jumpPulse = (stop.jump == true) and (((now - st.buildSince) % 0.56) < 0.085)
    if cmd.GetButtons and cmd.SetButtons then
        local b = tonumber(cmd:GetButtons()) or 0
        b = GP_EB_SetInputBit(b, 1, attackPulse)
        b = GP_EB_SetInputBit(b, 2, jumpPulse) -- only jump while placing EXIT
        cmd:SetButtons(b)
    end
    st.status = "waypoint " .. index .. "/" .. #GP_EB_MANNHATTAN_W1_POINTS .. ": placing " .. stop.label ..
        (stop.jump and " (jumping + positioning)" or "") .. " [build cmds " .. st.buildCommands .. "]"
    return true
end

-- Reactivate NORMAL Engineer TpWalk on the post-delivery respawn.
-- The v22 teleport unlock intentionally disabled TpWalk while dropping the
-- carried Dispenser. Re-arm it now, not during delivery, to prevent the
-- legacy movement controller from hijacking the placement phase.
local function GP_EB_MannhattanRearmTpWalkAfterDelivery(now)
    if GP_SetTpWalkEnabled then
        pcall(GP_SetTpWalkEnabled, true, false)
    end
    if config then
        config.tpWalkEnabled = true
        config.forceTpWalkEnabled = false
    end
    tpForceModeEnabled = false
    tpForceRestoreAwaitRespawn = false
    tpToggleNeedsTrigger = false
    tpToggleSpawnLock = false
    tpWaitForRoundReload = false
    tpWaitForRoundReloadReason = ""
    tpRespawnRearmPending = false
    tpLastAliveState = true
    tpStickyArmed = true
    reloadMoveLock = false
    sniperUpgradeCompleted = true -- legacy Engineer TpWalk readiness flag
    sniperUpgradeCompletedTime = now - (TELEPORTER_AUTOWALK_DELAY or 1.0) - 0.1
    teleporterJustUsed = false
    teleporterManuallyDisabled = false
    tpIsWaitingForTeleporter = false
    tpNoTeleFallbackActive = false
    tpUseVerifyActive = false
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
    if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
    if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
    if SaveConfig and GP_CfgPath then pcall(SaveConfig, GP_CfgPath(), config) end
end

-- Rebuild is non-destructive: a Dispenser must be confirmed missing first.

-- Registered as the LAST CreateMove callback. This function owns movement.
function GP_EB_MannhattanWave1RouteTick(cmd, me, now)
    local st = GP_EB_MANNHATTAN_W1
    if not st.active then return false end
    local wave = (GP_GetWaveNumber and GP_GetWaveNumber()) or nil
    local server = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
    local map = (engine and engine.GetMapName and engine.GetMapName()) or ""
    local enabled = (config and config.autoBuyEnabled == true) or (forceSniperBuyModeEnabled == true)
    if not enabled or ((type(wave) == "number" and wave >= 2) and not st.failedWaveReplay and not st.repairMode)
       or not GP_EB_MannhattanMap()
       or server ~= st.server or map ~= st.map then
        GP_EB_MannhattanWave1RouteReset()
        return false
    end
    if not (cmd and me and me.IsAlive and me.GetAbsOrigin and GP_GetClassId(me) == 9) then
        return false
    end
    now = tonumber(now) or 0
    local alive = me:IsAlive()
    if st.phase == "repair_wait_respawn" then
        if not alive then
            st.repairDeathSeen = true
            st.lastAlive = false
            return false
        end
        -- If CreateMove was skipped during death, recognize a confirmed
        -- respawn near one of the provided spawn routes after a short delay.
        local spawned = st.repairDeathSeen
        if not spawned and now - (st.repairKillAt or now) >= 2.0 then
            local p = me:GetAbsOrigin()
            if p then
                for _, starts in ipairs({GP_EB_ROTTENBURG_RIGHT_START, GP_EB_ROTTENBURG_LEFT_START}) do
                    for _, wp in ipairs(starts) do
                        local dx, dy = p.x-wp.x, p.y-wp.y
                        if dx*dx+dy*dy < 350*350 then spawned = true end
                    end
                end
            end
        end
        if spawned and not GP_EB.running and not GP_EB.awaitingRespawn
           and not GP_EB.rebuyPending then
            st.routeLabel = GP_EB_SelectEngineerMapRoute(me)
            st.phase, st.phaseSince, st.index = "repair_return", now, 1
            st.bestDistance, st.stuckAt = math.huge, 0
            st.status = "Respawned: walking to waypoint 3 to rebuild Dispenser"
            GP_EB_MannhattanClearBuildState()
        elseif not spawned and not GP_EB.waveLive
            and now - (st.repairLastKillAt or now) > 6.0
            and (st.repairKillRetries or 0) < 3 then
            -- Re-issue kill only if death was never observed.
            st.repairLastKillAt = now
            st.repairKillRetries = st.repairKillRetries + 1
            if client and client.Command then pcall(client.Command, "kill", true) end
        end
        st.lastAlive = alive
        return true
    end
    if not alive then
        if st.phase == "post_delivery_await_respawn" then
            st.postDeliveryDeathSeen = true
        elseif st.phase == "await_respawn" then
            st.observedDeath = true
        elseif st.lastAlive and st.phase == "setup" then
            -- Unplanned death during first setup: re-do the 9-point run.
            st.index, st.done = 1, false
            st.bestDistance, st.stuckAt = math.huge, 0
            GP_EB_MannhattanClearBuildState()
        elseif st.lastAlive and st.repairMode and st.phase ~= "complete" then
            st.phase = "repair_wait_respawn"
            st.repairDeathSeen = true
            st.repairKillAt, st.repairLastKillAt = now, now
            st.status = "Died during Dispenser rebuild; retrying from current spawn"
        elseif st.lastAlive and st.phase ~= "complete" then
            st.phase = "await_respawn"
            st.observedDeath = true
            st.exitKillAt = now
        end
        st.lastAlive = false
        return false
    end
    st.lastAlive = true
    if st.phase == "post_delivery_kill_wait" then
        -- After confirmed deployment, block ALL route movement and attack
        -- until the killbind has fired; legacy TpWalk stays disabled here.
        GP_EB_ClearRouteMovement(cmd, true)
        if cmd.GetButtons and cmd.SetButtons then
            local b = tonumber(cmd:GetButtons()) or 0
            cmd:SetButtons(GP_EB_SetInputBit(b, 1, false))
        end
        -- Do not suicide in combat if setup ran into the following wave.
        if st.repairMode and GP_EB.waveLive then
            st.status = "Dispenser placed; waiting for wave end before killbind"
            return true
        end
        -- Give TF2 0.4s to register the placement before using killbind.
        if now - st.phaseSince >= 0.40 then
            st.phase, st.phaseSince = "post_delivery_await_respawn", now
            st.postDeliveryKillAt, st.postDeliveryKillRetries = now, 1
            st.postDeliveryDeathSeen = false
            st.status = "Dispenser placed after teleport; kill sent; waiting for respawn"
            if client and client.Command then pcall(client.Command, "kill", true) end
            if print and GP_EB_MapIsRottenburg() then
                print("[Rottenburg v62] Post-delivery killbind sent; TpWalk will resume on respawn")
            end
        end
        return true
    end
    if st.phase == "post_delivery_await_respawn" then
        GP_EB_ClearRouteMovement(cmd, true)
        local respawnConfirmed = (st.postDeliveryDeathSeen == true)
        if not respawnConfirmed and now - st.postDeliveryKillAt > 3.5 then
            -- Fallback if CreateMove was not delivered during death: the
            -- player must actually be back in spawn, far from the Exit.
            local inSpawn = false
            if GP_TP_IsSpawnContextNow then
                local ok, v = pcall(GP_TP_IsSpawnContextNow, me)
                inSpawn = (ok and v == true)
            end
            local pos = me:GetAbsOrigin()
            local ex = GP_EB_MANNHATTAN_W1_POINTS[#GP_EB_MANNHATTAN_W1_POINTS]
            if inSpawn and pos and ex then
                local dx, dy = pos.x - ex.x, pos.y - ex.y
                respawnConfirmed = (dx*dx + dy*dy) >= 600*600
            end
        end
        if respawnConfirmed then
            GP_EB_MannhattanRearmTpWalkAfterDelivery(now)
            st.done, st.phase, st.phaseSince = true, "complete", now
            st.repairMode = false
            -- A completed delivery implies the Dispenser exists. Once it is
            -- gone for >1.25s during a live wave, repair mode can trigger.
            if GP_EB_MapIsRottenburg() then
                GP_EB_ROTTENBURG_REPAIR.armed = true
                GP_EB_ROTTENBURG_REPAIR.sawDispenser = true
                GP_EB_ROTTENBURG_REPAIR.nextScan = now + 0.30
            end
            GP_EB_ROTTENBURG_REPAIR.missingSince = nil
            st.status = "Dispenser delivered; respawned; Engineer TpWalk enabled"
            if AddNotification then
                AddNotification("Engineer respawned - TpWalk automatically enabled", "success", 4.0)
            end
        elseif now - st.postDeliveryKillAt > 3.5 and st.postDeliveryKillRetries < 3
            and not (st.repairMode and GP_EB.waveLive) then
            -- Only retry if there is no evidence of a death/respawn,
            -- and do not kill during combat to retry a repair.
            st.postDeliveryKillAt = now
            st.postDeliveryKillRetries = st.postDeliveryKillRetries + 1
            if client and client.Command then pcall(client.Command, "kill", true) end
        end
        return false
    end
    if st.phase == "exit_kill_wait" then
        GP_EB_ClearRouteMovement(cmd, true)
        if now - st.exitPlacedAt >= 0.35 then
            if client and client.Command then pcall(client.Command, "kill", true) end
            st.phase, st.phaseSince = "await_respawn", now
            st.exitKillAt, st.exitKillRetries = now, 1
            st.observedDeath = false
            st.status = "Exit placed; waiting for death and respawn"
        end
        return true
    end
    if st.phase == "await_respawn" then
        GP_EB_ClearRouteMovement(cmd, true)
        -- Allow a confirmed death/respawn, or re-arm from spawn after several
        -- seconds if no CreateMove callbacks were delivered while dead.
        local inSpawn = false
        if GP_TP_IsSpawnContextNow then
            local ok, v = pcall(GP_TP_IsSpawnContextNow, me)
            inSpawn = ok and v == true
        end
        local awayFromExit = false
        if me.GetAbsOrigin then
            local pos = me:GetAbsOrigin()
            local exit = GP_EB_MANNHATTAN_W1_POINTS[#GP_EB_MANNHATTAN_W1_POINTS]
            if pos and exit then
                local dx, dy = pos.x - exit.x, pos.y - exit.y
                awayFromExit = dx*dx + dy*dy >= 600*600
            end
        end
        if st.observedDeath or ((now - st.exitKillAt) >= 5.5 and (inSpawn or awayFromExit)) then
            -- A death may respawn us at the OPPOSITE Rottenburg spawn.
            -- Re-select waypoint 1 and 2 using the CURRENT respawn location,
            -- not the approach remembered before building the Exit.
            if GP_EB_MapIsRottenburg() then
                st.routeLabel = GP_EB_SelectEngineerMapRoute(me)
            end
            st.phase, st.phaseSince, st.index = "return_for_dispenser", now, 1
            st.bestDistance, st.stuckAt, st.done = math.huge, 0, false
            st.status = "respawned; repeating path to Dispenser at waypoint 3"
            GP_EB_MannhattanClearBuildState()
            if AddNotification then AddNotification("Engineer respawned - returning to Dispenser", "success", 4.0) end
        elseif (now - st.exitKillAt) > 7 and st.exitKillRetries < 3 then
            if client and client.Command then pcall(client.Command, "kill", true) end
            st.exitKillAt = now
            st.exitKillRetries = st.exitKillRetries + 1
        end
        return true
    end
    if st.phase == "repair_destroy_dispenser" then
        -- Legacy phase compatibility: route to build without ever issuing destroy.
        st.phase, st.phaseSince = "repair_build_dispenser", now
        GP_EB_MannhattanClearBuildState()
        return GP_EB_MannhattanPlacementTick(cmd, me, now, 3)
    end
    if st.phase == "pickup_dispenser" then
        return GP_EB_MannhattanPickupTick(cmd, me, now)
    elseif st.phase == "engi_tpwalk" then
        return GP_EB_MannhattanTpWalkTick(cmd, me, now)
    elseif st.phase == "deliver_dispenser" then
        return GP_EB_MannhattanDeliverTick(cmd, me, now)
    end
    if st.done or st.phase == "complete" then
        -- No more movement/view/button overrides after successful setup.
        return false
    end
    local current = me:GetAbsOrigin()
    if not current then return true end
    local eye = GP_EB_MannhattanViewPosition(me, current)
    local point = GP_EB_MANNHATTAN_W1_POINTS[st.index]
    if not point then
        st.done = true
        GP_EB_ClearRouteMovement(cmd, true)
        return true
    end
    local dx, dy, dz = point.x-eye.x, point.y-eye.y, point.z-eye.z
    local dxy = math.sqrt(dx*dx + dy*dy)
    now = tonumber(now) or 0
    st.distance, st.heightDifference = dxy, dz

    -- A reached build stop stays current until the corresponding owned
    -- building is confirmed. Reaching point 3/4/9 cannot auto-skip it.
    if (st.phase == "setup" or st.phase == "repair_build_dispenser")
       and st.buildStopIndex == st.index then
        return GP_EB_MannhattanPlacementTick(cmd, me, now, st.index)
    end
    while dxy <= GP_EB_MannhattanReachRadius(st.index) and math.abs(dz) <= 72 do
        -- Final waypoint: enter a motion-free settling state as soon as the
        -- precise XY target is reached. Do NOT keep steering to chase zero
        -- velocity; placement itself waits until speed is below 6.07.
        if st.phase == "repair_return" and st.index == 3 then
            local ds = GP_EB_RottenburgDispenserState(true)
            if ds == "up" or ds == "building" or ds == "carried" or ds == "blueprint" then
                st.active, st.done, st.repairMode = false, true, false
                st.phase, st.phaseSince = "complete", now
                st.status = "Dispenser already exists; repair cancelled"
                GP_EB_MannhattanRearmTpWalkAfterDelivery(now)
                return true
            elseif ds ~= "down" then
                GP_EB_ClearRouteMovement(cmd, true)
                st.status = "Waypoint 3: waiting to verify missing Dispenser"
                return true
            end
            st.phase, st.phaseSince = "repair_build_dispenser", now
            st.status = "Waypoint 3: building missing Dispenser (no destroy)"
            GP_EB_MannhattanClearBuildState()
            return GP_EB_MannhattanPlacementTick(cmd, me, now, 3)
        end
        if st.phase == "return_for_dispenser" and st.index == 3 then
            st.phase, st.phaseSince = "pickup_dispenser", now
            st.pickupSince, st.nextPickupPulse, st.pickupAttempts, st.nextWrenchAt = now, now, 0, 0
            st.status = "waypoint 3: locating and automatically picking up Dispenser"
            return GP_EB_MannhattanPickupTick(cmd, me, now)
        end
        local stop = (st.phase == "setup" or st.phase == "repair_build_dispenser")
            and GP_EB_MANNHATTAN_W1_BUILD_STOPS[st.index] or nil
        if stop then
            return GP_EB_MannhattanPlacementTick(cmd, me, now, st.index)
        end
        st.index = st.index + 1
        st.bestDistance, st.stuckAt = math.huge, 0
        point = GP_EB_MANNHATTAN_W1_POINTS[st.index]
        if not point then
            st.done = true
            st.status = "route finished"
            st.distance = 0
            GP_EB_ClearRouteMovement(cmd, true)
            return true
        end
        dx, dy, dz = point.x-eye.x, point.y-eye.y, point.z-eye.z
        dxy = math.sqrt(dx*dx + dy*dy)
    end
    st.distance, st.heightDifference = dxy, dz
    st.status = "following waypoint " .. st.index .. "/" .. #GP_EB_MANNHATTAN_W1_POINTS
    if dxy < st.bestDistance - 9 then
        st.bestDistance, st.stuckAt = dxy, now
    elseif (st.stuckAt or 0) <= 0 then
        st.stuckAt = now
    end
    -- Manual WASD is masked by the setup-input pre-callback; do not pause
    -- auto-navigation just because a physical key is held.
    if st.index == #GP_EB_MANNHATTAN_W1_POINTS then
        -- Fine positioning at the last waypoint: reduce input as distance
        -- shrinks, and counteract horizontal velocity to prevent overshoot.
        -- The other eight waypoints keep their existing walking behavior.
        local vx, vy = GP_EB_MannhattanVelocityXY(me)
        local aimX = dx - (vx or 0) * 0.30
        local aimY = dy - (vy or 0) * 0.30
        local aimDist = math.sqrt(aimX * aimX + aimY * aimY)
        GP_EB_ClearRouteMovement(cmd, true)
        if aimDist > 0.01 then
            local aim = Vector3(current.x + aimX, current.y + aimY, current.z)
            local movement = ComputeMove(cmd, current, aim)
            local speed = math.min(140, math.max(8, aimDist * 1.25))
            if dxy < 18 then speed = math.min(speed, 28) end
            cmd:SetForwardMove(movement.x * (speed / 450))
            cmd:SetSideMove(movement.y * (speed / 450))
        end
        st.status = string.format("precision approach to EXIT: %.2fu", dxy)
    else
        -- All earlier waypoints retain the original walking behavior.
        local target = Vector3(point.x, point.y, point.z)
        local movement = ComputeMove(cmd, current, target)
        local speed = math.min(450, math.max(105, dxy * 3.0))
        local mul = speed / 450
        cmd:SetForwardMove(movement.x * mul)
        cmd:SetSideMove(movement.y * mul)
    end
    st.lastSteerAt = now
    -- Never generate jump input while WALKING. Only the exit placement uses it.
    if (st.stuckAt or 0) > 0 and now-st.stuckAt >= 8.0
       and now-(st.lastWarnAt or 0) >= 8.0 then
        st.lastWarnAt = now
        if AddNotification then
            AddNotification((st.routeLabel or "Mannhattan") .. " route stuck at waypoint " .. st.index .. "/" .. #GP_EB_MANNHATTAN_W1_POINTS, "warning", 4.0)
        end
    end
    return true
end

function GP_EB_DebugStatus()
    local route = (GP_EB_MannhattanWave1RouteStatus and GP_EB_MannhattanWave1RouteStatus()) or "inactive"
    return string.format("EngiBuy: wave=%s live=%s buying=%s phase=%s stage=%s failPending=%s rebuy=%s awaitingRespawn=%s route=%s",
        tostring(GP_EB.wave), tostring(GP_EB.waveLive), tostring(GP_EB.running),
        tostring(GP_EB.phase), tostring(GP_EB.stage), tostring(GP_EB_FailReplay.pending),
        tostring(GP_EB.rebuyPending), tostring(GP_EB.awaitingRespawn), tostring(route))
end

function GP_EB_MannhattanWave1RouteStatus()
    local st = GP_EB_MANNHATTAN_W1
    if not st.active then return nil end
    if st.done then return (st.routeLabel or "Mannhattan") .. " Engineer: DONE - TpWalk armed after Dispenser delivery" end
    if st.phase == "post_delivery_kill_wait" or st.phase == "post_delivery_await_respawn"
       or st.phase == "await_respawn" or st.phase == "exit_kill_wait"
       or st.phase == "pickup_dispenser" or st.phase == "engi_tpwalk"
       or st.phase == "deliver_dispenser"
       or st.phase == "repair_destroy_dispenser" or st.phase == "repair_build_dispenser" then
        return (st.routeLabel or "Mannhattan") .. " Engineer: " .. st.status
    end
    if st.buildStopIndex then
        return (st.routeLabel or "Mannhattan") .. " Wave 1: " .. st.status
    end
    local dist = st.distance and (" XY " ..
        (st.index == #GP_EB_MANNHATTAN_W1_POINTS
         and string.format("%.2f", st.distance)
         or tostring(math.floor(st.distance))) .. "u") or ""
    local height = st.heightDifference and (" Z " .. tostring(math.floor(st.heightDifference)) .. "u") or ""
    return (st.routeLabel or "Mannhattan") .. " " .. (st.phase == "return_for_dispenser" and "pickup run" or "setup") ..
        " route: " .. st.index .. "/" .. #GP_EB_MANNHATTAN_W1_POINTS .. dist .. height
end
-- ===== Engineer setup control lock =====
-- Prevent the HUMAN player's keyboard/mouselook from interrupting scripted
-- buying, waypoint movement, building placement, pickup and dispenser delivery.
-- Mouse movement still works normally in TF2 menus, console and chat. The
-- physical mouse/keyboard aren't disabled at the OS level.
local GP_SETUP_VIEW = nil

local function GP_EB_InteractiveUIOpen()
    if not engine then return false end
    local ok, visible = pcall(function()
        return (engine.Con_IsVisible and engine.Con_IsVisible())
            or (engine.IsChatOpen and engine.IsChatOpen())
            or (engine.IsGameUIVisible and engine.IsGameUIVisible())
    end)
    return ok and visible == true
end

function GP_EB_SetupInputLocked()
    if not (config and config.autoBuyEnabled == true) then return false end
    if GP_EB_InteractiveUIOpen() then return false end
    local me = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
    if not (me and me.IsAlive and me:IsAlive() and GP_GetClassId(me) == 9) then return false end
    -- Always lock mouse/keyboard during actual EngiBuy purchases.
    if GP_EB.running then return true end
    if not GP_EB_MannhattanMap() then return false end
    local st = GP_EB_MANNHATTAN_W1
    if st and st.done then return false end
    if st and st.active then return true end
    -- Wave 1: hold input until EngiBuy can finish and start the route.
    if (GP_EB_IsFirstWaveForStart(GP_EB.wave) or GP_EB_FailReplay.pending)
       and not GP_EB.waveLive then
        return GP_EB.awaitingRespawn or GP_EB.rebuyPending
            or GP_EB.routeStartRequested or not sniperUpgradesComplete
    end
    return false
end

local function GP_EB_SetupReadAngles(cmd)
    local angles
    if cmd and cmd.GetViewAngles then
        local ok,a,b,c = pcall(cmd.GetViewAngles, cmd)
        if ok and type(a) == "number" and type(b) == "number" then
            return {a,b,type(c) == "number" and c or 0}
        elseif ok and a ~= nil then
            angles = a
        end
    end
    if angles == nil and engine and engine.GetViewAngles then
        local ok,a = pcall(engine.GetViewAngles)
        if ok then angles = a end
    end
    if angles ~= nil then
        local ok,x,y,z = pcall(function()
            return angles.x or angles.pitch, angles.y or angles.yaw, angles.z or angles.roll or 0
        end)
        if ok and type(x)=="number" and type(y)=="number" then
            return {x,y,type(z)=="number" and z or 0}
        end
    end
    return nil
end

-- Registered BEFORE the legacy AI CreateMove callback. Removing raw inputs
-- here means existing scripted navigation can write its own movement later.
function GP_EB_SetupInputBefore(cmd)
    if not GP_EB_SetupInputLocked() then
        GP_SETUP_VIEW = nil
        return
    end
    if not GP_SETUP_VIEW then GP_SETUP_VIEW = GP_EB_SetupReadAngles(cmd) end
    if cmd.SetForwardMove then cmd:SetForwardMove(0) end
    if cmd.SetSideMove then cmd:SetSideMove(0) end
    if cmd.SetUpMove then cmd:SetUpMove(0) end
    if cmd.SetButtons then cmd:SetButtons(0) end
    if GP_SETUP_VIEW and cmd.SetViewAngles then
        cmd:SetViewAngles(GP_SETUP_VIEW[1], GP_SETUP_VIEW[2], GP_SETUP_VIEW[3])
    end
    pcall(function() cmd.mousedx, cmd.mousedy = 0,0 end)
end

-- Run AFTER all navigation. Keep the bot's chosen angles (when picking up
-- buildings etc.) while preventing subsequent mouse deltas from rotating view.
function GP_EB_SetupInputAfter(cmd)
    if not GP_EB_SetupInputLocked() then
        GP_SETUP_VIEW = nil
        return
    end
    local updated = GP_EB_SetupReadAngles(cmd)
    if updated then GP_SETUP_VIEW = updated end
    pcall(function() cmd.mousedx,cmd.mousedy = 0,0 end)
    if GP_SETUP_VIEW and engine and engine.SetViewAngles and EulerAngles then
        pcall(function()
            engine.SetViewAngles(EulerAngles(GP_SETUP_VIEW[1], GP_SETUP_VIEW[2], GP_SETUP_VIEW[3]))
        end)
    end
end
-- ===== End Engineer setup control lock =====

-- ===== End of Mannhattan Wave 1 Engineer route =====

-- End of EngiBuy module. Legacy SniperBuy API names remain aliases for compatibility.
local GP_IsSniper
function TriggerSniperUpgrades()
    local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    return GP_EB_Start(me)
end
-- Old Sniper-specific upgrade queue replaced with incremental EngiBuy logic.
--[[
function TriggerSniperUpgrades()
local currentTime = globals.CurTime()
if (currentTime - (lastSniperTriggerTime or 0)) < (SNIPER_TRIGGER_DEBOUNCE or 0.25) then
return
end
lastSniperTriggerTime = currentTime
if currentTime < sniperUpgradeCooldownUntil then return end
if (not isUpgradingSniper) and upgradeQueue and (#upgradeQueue > 0) and (not sniperUpgradesComplete) then
isUpgradingSniper = true
end
if isUpgradingSniper or sniperUpgradesComplete or (upgradeQueue and #upgradeQueue > 0) then
return
end
if isExploiting then return end
local me = entities.GetLocalPlayer()
if not me or (not me:IsAlive()) then return end
if not (GP_IsSniper and GP_IsSniper(me)) then return end
if me:GetPropInt('m_bInUpgradeZone') ~= 1 then return end
isUpgradingSniper = true
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterConfig.autoWalkEnabled = false
teleporterManuallyDisabled = false
nextUpgradeTime = currentTime
upgradeQueue = {
{type = "begin"},
{type = "upgrade", slot = 0, id = "62", count = 10},
{type = "upgrade", slot = 0, id = "40", count = 10},
{type = "upgrade", slot = 0, id = "35.1", count = 10},
{type = "upgrade", slot = 0, id = "-0.9", count = 10},
{type = "upgrade", slot = 0, id = "17", count = 10},
{type = "upgrade", slot = 0, id = "12", count = 10},
{type = "upgrade", slot = 0, id = "59", count = 10},
{type = "upgrade", slot = 0, id = "6", count = 10},
{type = "upgrade", slot = 9, id = "29.0", count = 10},
{type = "end", count = 90}
}
nextUpgradeTime = currentTime + SNIPER_UPGRADE_DELAY
end
]]
IsInSpawnRoom = function(player)
if not player then return false end
function tryGetInt(...)
local ok, v = pcall(player.GetPropInt, player, ...)
if not ok then return nil end
if type(v) == "number" then return v end
if type(v) == "boolean" then return v and 1 or 0 end
if type(v) == "string" then
local n = tonumber(v)
if n ~= nil then return n end
end
return nil
end
local v = tryGetInt('m_Shared.m_bInRespawnRoom')
if v ~= nil then return v == 1 end
v = tryGetInt('m_Shared', 'm_bInRespawnRoom')
if v ~= nil then return v == 1 end
v = tryGetInt('m_bInRespawnRoom')
if v ~= nil then return v == 1 end
v = tryGetInt('m_Shared.m_bInSpawnRoom')
if v ~= nil then return v == 1 end
v = tryGetInt('m_Shared', 'm_bInSpawnRoom')
if v ~= nil then return v == 1 end
return false
end
-- Removed in v24: Medic cash exploit
function __GM_PART2__()
-- Remaining non-visual support for Engineer automation and retained features.
misc = GhostMoney.Misc or {
want = false,
anim = 0.0,
open = false,
armed = false,
lastRDown = false,
openedAt = 0,
openFrame = 0,
debounceFrames = 0,
category = nil,
waitKey = false,
waitKeyArmed = false,
waitWhich = nil,
waitKeyStartFrame = 0,
keyPrev = {},
acWarnPrevClassName = nil,
acWarnPrevHasVacc = nil,
acWarnPrevClassSelected = nil,
acWarnSeenNoMedic = false,
acWarnSeenNoVacc = false,
acStartedOnce = false,
instantRespawnWasAlive = false,
instantRespawnAlreadyRequested = false,
instantRespawnSuspendUntil = 0,
instantRespawnHardLockUntil = 0,
instantRespawnRetryAt = 0,
instantRespawnRetryDone = false,
instantRespawnRetryCount = 0,
instantRespawnBuybackAt = 0,
instantRespawnBuybackDone = false,
instantRespawnBuybackAttempts = 0,
}
GhostMoney.Misc = misc

function GP_InstantRespawnNow()
local t = 0
pcall(function()
if globals and globals.RealTime then
t = globals.RealTime()
elseif globals and globals.CurTime then
t = globals.CurTime()
end
end)
if type(t) ~= "number" then t = 0 end
return t
end

function GP_InstantRespawnSendRequest()
local kv = [[ "MVM_Revive_Response" { "accepted" "1" } ]]
pcall(function()
if engine and engine.SendKeyValues then
engine.SendKeyValues(kv)
end
end)
end

function GP_InstantRespawnBuybackFallback()
pcall(function()
if client and client.Command then
client.Command("td_buyback")
client.Command("td_buyback", false)
client.Command("td_buyback", true)
end
end)
end

function GP_InstantRespawnSuspend(seconds, _reason)
if not misc then return end
local dur = tonumber(seconds) or 0
if dur <= 0 then return end
local now = GP_InstantRespawnNow()
local untilT = now + dur
if untilT > (misc.instantRespawnSuspendUntil or 0) then
misc.instantRespawnSuspendUntil = untilT
end
if untilT > (misc.instantRespawnHardLockUntil or 0) then
misc.instantRespawnHardLockUntil = untilT
end
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
misc.instantRespawnWasAlive = false
end

function GP_HandleInstantRespawn(me)
if not (config and config.instantRespawnEnabled == true) then
if misc then
misc.instantRespawnWasAlive = false
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnSuspendUntil = 0
misc.instantRespawnHardLockUntil = 0
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
end
return
end
if not me then return end
local alive = (me:IsAlive() == true)
local now = GP_InstantRespawnNow()
local lockUntil = math.max((misc.instantRespawnSuspendUntil or 0), (misc.instantRespawnHardLockUntil or 0))
local rstLockActive = false
if GP_RST then
local rstNow = (GP_RST_Now and GP_RST_Now()) or now
local k = tostring(GP_RST.kind or "")
if rstNow < (GP_RST.detectGlobalUntil or 0) then
rstLockActive = true
elseif (k == "vote" or k == "fail") and (rstNow < (GP_RST.contextUntil or 0)) then
rstLockActive = true
elseif ((GP_RST.queueAt or 0) > rstNow) then
rstLockActive = true
end
end
if (now < lockUntil) or rstLockActive then
misc.instantRespawnWasAlive = alive
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
return
end
if misc.instantRespawnWasAlive and (not alive) then
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
end
if not alive then
if not misc.instantRespawnAlreadyRequested then
GP_InstantRespawnSendRequest()
misc.instantRespawnAlreadyRequested = true
misc.instantRespawnRetryAt = now + 0.5
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = now + 0.45
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
elseif ((misc.instantRespawnRetryAt or 0) > 0) and (now >= (misc.instantRespawnRetryAt or 0)) and (misc.instantRespawnRetryDone ~= true) then
local rc = tonumber(misc.instantRespawnRetryCount) or 0
if rc == 0 then
GP_InstantRespawnSendRequest()
misc.instantRespawnRetryCount = 1
misc.instantRespawnRetryAt = now + 0.5
elseif rc == 1 then
GP_InstantRespawnSendRequest()
misc.instantRespawnRetryCount = 2
misc.instantRespawnRetryAt = now + 1.0
elseif rc == 2 then
GP_InstantRespawnSendRequest()
misc.instantRespawnRetryCount = 3
misc.instantRespawnRetryAt = now + 2.0
misc.instantRespawnRetryDone = true
else
misc.instantRespawnRetryDone = true
misc.instantRespawnRetryAt = 0
end
end
if (misc.instantRespawnBuybackDone ~= true) and ((misc.instantRespawnBuybackAt or 0) > 0) and now >= (misc.instantRespawnBuybackAt or 0) then
GP_InstantRespawnBuybackFallback()
local ba = tonumber(misc.instantRespawnBuybackAttempts) or 0
ba = ba + 1
misc.instantRespawnBuybackAttempts = ba
if ba >= 8 then
misc.instantRespawnBuybackDone = true
misc.instantRespawnBuybackAt = 0
else
misc.instantRespawnBuybackAt = now + 1.00
end
end
else
misc.instantRespawnAlreadyRequested = false
misc.instantRespawnRetryAt = 0
misc.instantRespawnRetryDone = false
misc.instantRespawnRetryCount = 0
misc.instantRespawnBuybackAt = 0
misc.instantRespawnBuybackDone = false
misc.instantRespawnBuybackAttempts = 0
end
misc.instantRespawnWasAlive = alive
end


-- State for retained aimbot suspension/restore during party fix.
GP_TP_AIMBOT_CTL = GP_TP_AIMBOT_CTL or {
    suppressed=false, restorePending=false, restoreAt=0,
    snapshot=nil, lastSuppressedAt=0,
}
GP_TP_AIMBOT_KEYS = GP_TP_AIMBOT_KEYS or {
    "lbot.aim.enable", "lbot.master", "rbot.aim.enable", "rbot.master",
    "ragebot.enable", "aimbot", "aim bot",
}
function GP_TP_AimbotValueIsEnabled(v)
local tv = type(v)
if tv == "boolean" then return v end
if tv == "number" then return v ~= 0 end
if tv == "string" then
local sv = string.lower(v)
return (sv == "1") or (sv == "true") or (sv == "on") or (sv == "enabled")
end
return false
end

function GP_TP_AimbotReadSnapshot()
if not (gui and gui.GetValue) then return nil end
local snap = { keys = {}, anyEnabled = false }
for i = 1, #GP_TP_AIMBOT_KEYS do
local k = GP_TP_AIMBOT_KEYS[i]
local ok, v = pcall(gui.GetValue, k)
if ok and v ~= nil then
local rec = { key = k, value = v, vtype = type(v) }
if GP_TP_AimbotValueIsEnabled(v) then
rec.wasEnabled = true
snap.anyEnabled = true
else
rec.wasEnabled = false
end
table.insert(snap.keys, rec)
end
end
if #snap.keys <= 0 then
return nil
end
return snap
end

function GP_TP_AimbotDisableFromSnapshot(snap)
if not (snap and snap.keys and gui and gui.SetValue) then return end
for i = 1, #snap.keys do
local rec = snap.keys[i]
if rec and rec.wasEnabled then
if rec.vtype == "boolean" then
pcall(gui.SetValue, rec.key, false)
else
pcall(gui.SetValue, rec.key, 0)
end
end
end
end

function GP_TP_AimbotRestoreFromSnapshot(snap)
if not (snap and snap.keys and gui and gui.SetValue) then return end
for i = 1, #snap.keys do
local rec = snap.keys[i]
if rec then
pcall(gui.SetValue, rec.key, rec.value)
end
end
end

function GP_TP_AimbotForceEnable(snap)
if not (gui and gui.SetValue) then return end
local seen = {}
if snap and snap.keys then
for i = 1, #snap.keys do
local rec = snap.keys[i]
if rec and rec.key then
seen[rec.key] = true
if rec.vtype == "boolean" then
pcall(gui.SetValue, rec.key, true)
else
local okNum = pcall(gui.SetValue, rec.key, 1)
if not okNum then pcall(gui.SetValue, rec.key, true) end
end
end
end
end
for i = 1, #GP_TP_AIMBOT_KEYS do
local k = GP_TP_AIMBOT_KEYS[i]
if k and (not seen[k]) then
local okBool = pcall(gui.SetValue, k, true)
if not okBool then pcall(gui.SetValue, k, 1) end
end
end
end

function GP_TP_HandleAimbotSuppression(now)
if not (gui and gui.GetValue and gui.SetValue) then return end
now = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
local tpModeOn = (tpForceModeEnabled == true) or ((config and config.tpWalkEnabled) == true)
local lockConfigured = tpModeOn and ((config and config.tpWalkMoveLockEnabled) == true)

function GP_TP_GetSuppressStates(ts)
local autoWalking = (((teleporterConfig and teleporterConfig.autoWalkEnabled) == true) and (not teleporterJustUsed))
local movingRaw = autoWalking
or (tpIsWaitingForTeleporter == true)
or (tpNoTeleFallbackActive == true)
or (tpUseVerifyActive == true)

local pending = (tpRespawnRearmPending == true)
or (tpWaitForRoundReload == true)

local reachedAt = (tpLastReachedTeleporterAt or 0)
local reachedAgo = -1
if reachedAt > 0 then reachedAgo = (ts - reachedAt) end
if reachedAgo >= 1.0 and (not autoWalking) then
movingRaw = false
pending = false
end

return movingRaw, pending, reachedAgo, autoWalking
end

local movingToTp, pendingRearm, reachedAgo, autoWalkingNow = GP_TP_GetSuppressStates(now)
local shouldSuppress = lockConfigured and (movingToTp or pendingRearm)

if lockConfigured and GP_TP_AIMBOT_CTL.suppressed then
local suppressedFor = now - (GP_TP_AIMBOT_CTL.lastSuppressedAt or now)
if (not autoWalkingNow) and ((reachedAgo >= 1.0) or (suppressedFor >= 5.0)) then
shouldSuppress = false
end
end

if shouldSuppress then
GP_TP_AIMBOT_CTL.restorePending = false
GP_TP_AIMBOT_CTL.restoreAt = 0
GP_TP_AIMBOT_CTL.lastSuppressedAt = now
if not GP_TP_AIMBOT_CTL.suppressed then
GP_TP_AIMBOT_CTL.suppressed = true
GP_TP_AIMBOT_CTL.snapshot = GP_TP_AimbotReadSnapshot()
if GP_TP_AIMBOT_CTL.snapshot and GP_TP_AIMBOT_CTL.snapshot.anyEnabled then
GP_TP_AimbotDisableFromSnapshot(GP_TP_AIMBOT_CTL.snapshot)
end
elseif GP_TP_AIMBOT_CTL.snapshot and GP_TP_AIMBOT_CTL.snapshot.anyEnabled then
GP_TP_AimbotDisableFromSnapshot(GP_TP_AIMBOT_CTL.snapshot)
end
return
end

if GP_TP_AIMBOT_CTL.suppressed then
GP_TP_AIMBOT_CTL.suppressed = false
local baseRestore = now + 1.0
local reachRestore = (tpLastReachedTeleporterAt or 0) + 1.0
if reachRestore > baseRestore then baseRestore = reachRestore end
GP_TP_AIMBOT_CTL.restorePending = true
GP_TP_AIMBOT_CTL.restoreAt = baseRestore
end

if GP_TP_AIMBOT_CTL.restorePending and now >= (GP_TP_AIMBOT_CTL.restoreAt or 0) then
local stillMoving, stillPending, stillReachedAgo, stillAutoWalking = GP_TP_GetSuppressStates(now)
local stillSuppress = lockConfigured and (stillMoving or stillPending)
if (not stillAutoWalking) and (stillReachedAgo >= 1.0) then
stillSuppress = false
end
if (not stillSuppress) then
GP_TP_AimbotForceEnable(GP_TP_AIMBOT_CTL.snapshot)
GP_TP_AIMBOT_CTL.restorePending = false
GP_TP_AIMBOT_CTL.restoreAt = 0
GP_TP_AIMBOT_CTL.snapshot = nil
elseif now >= ((GP_TP_AIMBOT_CTL.restoreAt or 0) + 2.5) then
GP_TP_AimbotForceEnable(GP_TP_AIMBOT_CTL.snapshot)
GP_TP_AIMBOT_CTL.restorePending = false
GP_TP_AIMBOT_CTL.restoreAt = 0
GP_TP_AIMBOT_CTL.snapshot = nil
end
end
end

function GP_TP_AimbotRestoreOnUnload()
if GP_TP_AIMBOT_CTL.snapshot and (GP_TP_AIMBOT_CTL.suppressed or GP_TP_AIMBOT_CTL.restorePending) and GP_TP_AIMBOT_CTL.snapshot.anyEnabled then
GP_TP_AimbotRestoreFromSnapshot(GP_TP_AIMBOT_CTL.snapshot)
end
GP_TP_AIMBOT_CTL.suppressed = false
GP_TP_AIMBOT_CTL.restorePending = false
GP_TP_AIMBOT_CTL.restoreAt = 0
GP_TP_AIMBOT_CTL.snapshot = nil
GP_TP_AIMBOT_CTL.lastSuppressedAt = 0
end

function GP_IsMedic(me)
return GP_GetClassId(me) == 5
end
function IsMedic(me)
if me ~= nil then
return GP_IsMedic(me)
end
local lp = (entities and entities.GetLocalPlayer) and entities.GetLocalPlayer() or nil
return GP_IsMedic(lp)
end
GP_IsSniper = function(me)
return GP_GetClassId(me) == 2
end
function GP_IsEngineer(me)
return GP_GetClassId(me) == 9
end
function GP_GetCurrentClassName(me)
local cls = GP_GetClassId(me)
if not cls then return nil end
return GP_CLASS_NAME[cls]
end
function GP_UpdatePostWaveSwapLatch()
if acPostWaveSwapLatched then
return true
end
local wave = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local rs = GP_GetRoundState and GP_GetRoundState() or nil
local inSetup = nil
if GP_TP_IsSetupPhase then
local okSetup, vSetup = pcall(GP_TP_IsSetupPhase)
if okSetup then
inSetup = vSetup
end
end
if (type(rs) == "number") and (rs == 4) then
acPostWaveSwapLatched = true
end
if (not acPostWaveSwapLatched) and (type(rs) == "number") and (rs == 3) then
local liveSeen = (GP_RST and GP_RST.liveSeen) or false
if liveSeen then
acPostWaveSwapLatched = true
end
end
if (not acPostWaveSwapLatched) and (type(wave) == "number") then
if wave >= 2 then
acPostWaveSwapLatched = true
elseif (wave >= 1) and (inSetup == false) then
acPostWaveSwapLatched = true
end
end
return acPostWaveSwapLatched
end
function GP_HasExplicitPreWave1Proof()
local wave = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local rs = GP_GetRoundState and GP_GetRoundState() or nil
local inSetup = nil
if GP_TP_IsSetupPhase then
local okSetup, vSetup = pcall(GP_TP_IsSetupPhase)
if okSetup then
inSetup = vSetup
end
end
local liveSeen = (GP_RST and GP_RST.liveSeen) or false
if GP_UpdatePostWaveSwapLatch and GP_UpdatePostWaveSwapLatch() then
return false
end
if type(wave) == "number" then
if wave <= 0 then
return true
end
if (wave == 1) and (inSetup == true) and (not liveSeen) then
return true
end
return false
end
if inSetup == true then
return (not liveSeen)
end
if type(rs) == "number" and (rs == 3 or rs == 10) then
if not liveSeen then
return true
end
end
return false
end
function GP_IsPostWaveSwapRestricted()
if GP_UpdatePostWaveSwapLatch() then
return true
end
local rs = GP_GetRoundState and GP_GetRoundState() or nil
if (type(rs) == "number") and (rs == 4) then
acPostWaveSwapLatched = true
return true
end
local wave = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local inSetup = nil
if GP_TP_IsSetupPhase then
local okSetup, vSetup = pcall(GP_TP_IsSetupPhase)
if okSetup then
inSetup = vSetup
end
end
if type(wave) == "number" then
if wave <= 0 then
return false
end
if wave == 1 then
if inSetup == false then
acPostWaveSwapLatched = true
return true
end
return false
end
if wave >= 2 then
acPostWaveSwapLatched = true
return true
end
end
return acPostWaveSwapLatched == true
end
function GP_GetPostWaveAutoCreditTargetClass()
if not config or not config.changeClassEnabled then return nil end
local tc = config.targetClass
if type(tc) ~= "string" then return nil end
tc = string.lower(tc)
if tc == "" or tc == "off" or tc == "medic" then
return nil
end
local valid = {
scout=true, sniper=true, soldier=true, demoman=true,
heavy=true, heavyweapons=true, pyro=true, spy=true, engineer=true
}
if valid[tc] then
return tc
end
return nil
end
function GP_GetPostWaveStationSwapTarget(me)
if not me then return nil, "no_player" end
local tc = GP_GetPostWaveAutoCreditTargetClass()
if not tc then
return nil, "invalid_target"
end
if not IsMedic(me) then
return nil, "not_medic"
end
local inZone = false
if me.GetPropInt then
local okZone, vZone = pcall(me.GetPropInt, me, "m_bInUpgradeZone")
inZone = (okZone and vZone == 1)
end
if not inZone then
return nil, "not_in_upgrade"
end
return tc, nil
end
function GP_ShouldAllowPostWaveStationSwapWithoutThreshold(me)
if not me then return false end
if not (config and config.autoWalkEnabled) then return false end
if not (config and config.changeClassEnabled) then return false end
if not GP_IsPostWaveSwapRestricted() then return false end
local tc = GP_GetPostWaveStationSwapTarget(me)
return (tc ~= nil and tc ~= "")
end
function GP_SafeCall(fn, default)
local ok, res = pcall(fn)
if ok then return res end
return default
end
function GP_GetGameRulesProxy()
if entities and entities.FindByClass then
local t = entities.FindByClass("CTFGameRulesProxy")
if t and t[1] then return t[1] end
end
return nil
end
function GP_TryPropInt(ent, ...)
if not ent or not ent.GetPropInt then return nil end
for i = 1, select('#', ...) do
local name = select(i, ...)
local ok, v = pcall(ent.GetPropInt, ent, name)
if ok then
local tv = type(v)
if tv == "number" then
return v
elseif tv == "boolean" then
return v and 1 or 0
elseif tv == "string" then
local n = tonumber(v)
if n ~= nil then return n end
end
end
end
return nil
end
function GP_GetRoundState()
local rs = GP_SafeCall(function() return gamerules.GetRoundState() end, nil)
if type(rs) == "number" then return rs end
rs = GP_SafeCall(function() return gamerules.RoundState() end, nil)
if type(rs) == "number" then return rs end
local proxy = GP_GetGameRulesProxy()
rs = GP_TryPropInt(proxy, "m_iRoundState", "m_iState", "m_nRoundState")
if type(rs) == "number" then return rs end
return nil
end
function GP_GetWaveNumber()
local wn = GP_SafeCall(function() return gamerules.GetWaveNumber() end, nil)
if type(wn) == "number" then return wn end
wn = GP_SafeCall(function() return gamerules.GetWave() end, nil)
if type(wn) == "number" then return wn end
wn = GP_SafeCall(function() return gamerules.WaveNumber() end, nil)
if type(wn) == "number" then return wn end
local proxy = GP_GetGameRulesProxy()
wn = GP_TryPropInt(proxy,
"m_nMannVsMachineWaveCount",
"m_iMvMWaveCount",
"m_nWaveCount",
"m_iWaveNumber",
"m_nWaveNumber"
)
if type(wn) == "number" then return wn end
local obj = nil
if entities and entities.FindByClass then
local t = entities.FindByClass("CTFObjectiveResource")
if t and t[1] then obj = t[1] end
end
wn = GP_TryPropInt(obj,
"m_nMannVsMachineWaveCount",
"m_iMvMWaveCount",
"m_nWaveCount",
"m_iWaveNumber",
"m_nWaveNumber"
)
if type(wn) == "number" then return wn end
return nil
end
function GP_TP_IsSetupPhase()
local b = GP_SafeCall(function()
if gamerules then
if gamerules.IsInSetup then return gamerules.IsInSetup() end
if gamerules.InSetup then return gamerules.InSetup() end
end
return nil
end, nil)
if type(b) == "boolean" then
return b
elseif type(b) == "number" then
return (b ~= 0)
end
local proxy = GP_GetGameRulesProxy()
local setup = GP_TryPropInt(proxy, "m_bInSetup")
if type(setup) == "number" then
return (setup ~= 0)
end
local between = GP_TryPropInt(proxy, "m_bMannVsMachineBetweenWaves")
if type(between) == "number" then
if between ~= 0 then return true end
end
local waiting = GP_TryPropInt(proxy, "m_bInWaitingForPlayers")
if type(waiting) == "number" then
if waiting ~= 0 then return true end
return false
end
return nil
end
function GP_TP_IsArmedAndAllowed()
local now = (globals and globals.CurTime and globals.CurTime()) or 0
function tryReleaseRoundReloadGate()
if not tpWaitForRoundReload then
tpWaitForRoundReloadArmedAt = 0
return
end
if (tpWaitForRoundReloadArmedAt or 0) <= 0 then
tpWaitForRoundReloadArmedAt = now
end
local me = nil
if entities and entities.GetLocalPlayer then
local okMe, vMe = pcall(entities.GetLocalPlayer)
if okMe then me = vMe end
end
local inSpawnCtx = false
if me then
local okCtx, vCtx = pcall(GP_TP_IsSpawnContextNow, me)
inSpawnCtx = (okCtx and vCtx == true)
end
local timedOut = ((now - (tpWaitForRoundReloadArmedAt or now)) >= (TP_WAITROUND_REARM_FAILSAFE_SECONDS or 12.0))
local rrReason = tostring(tpWaitForRoundReloadReason or "")
local strictRestartReload = (string.find(rrReason, "restart", 1, true) ~= nil) or (string.find(rrReason, "fail", 1, true) ~= nil)
local canReleaseEarly = inSpawnCtx
if strictRestartReload then
canReleaseEarly = false
end
if canReleaseEarly or timedOut then
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpWaitForRoundReloadArmedAt = 0
tpToggleSpawnLock = false
tpToggleSpawnLockArmedAt = 0
if (sniperUpgradeCompletedTime or 0) <= 0 then
sniperUpgradeCompletedTime = now - (TELEPORTER_AUTOWALK_DELAY or 1.0)
end
if tpForceModeEnabled and tpForceRestoreAwaitRespawn then
local aliveNow = false
if me and me.IsAlive then
aliveNow = (me:IsAlive() == true)
end
if aliveNow then
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpStickyArmed = true
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = (TP_TELE_STABLE_SCANS or 8)
reloadMoveLock = false
else
tpRespawnRearmPending = true
reloadMoveLock = true
end
tpLastAliveState = aliveNow
end
end
end
tryReleaseRoundReloadGate()
if tpForceModeEnabled then
if tpForceRestoreAwaitRespawn then return false end
if tpWaitForRoundReload then return false end
return (tpStickyArmed == true)
end
if not (config and config.tpWalkEnabled) then return false end
local lp = entities and entities.GetLocalPlayer and entities.GetLocalPlayer() or nil
if lp and GP_GetClassId(lp) ~= 9 then return false end
if tpWaitForRoundReload then return false end
if tpToggleNeedsTrigger then return false end
return (sniperUpgradeCompleted == true)
end

end
__GM_PART2__()

function __GM_PART3__()
GP_RST = GP_RST or {}
GP_RST.contextUntil = GP_RST.contextUntil or 0
GP_RST.queueAt = GP_RST.queueAt or 0
GP_RST.queueReason = GP_RST.queueReason or "none"
GP_RST.cooldownUntil = GP_RST.cooldownUntil or 0
GP_RST.lastEvent = GP_RST.lastEvent or "none"
GP_RST.sourceWave = GP_RST.sourceWave
GP_RST.sourceWaveReliable = GP_RST.sourceWaveReliable or false
GP_RST.lastReliableWave = GP_RST.lastReliableWave
GP_RST.lastLiveAt = GP_RST.lastLiveAt or 0
GP_RST.forceActive = GP_RST.forceActive or false
GP_RST.forceTarget = GP_RST.forceTarget or ""
GP_RST.forceReason = GP_RST.forceReason or "none"
GP_RST.forceRetries = GP_RST.forceRetries or 0
GP_RST.forceNextAt = GP_RST.forceNextAt or 0
GP_RST.forceLockUntil = GP_RST.forceLockUntil or 0
GP_RST.lastWave = GP_RST.lastWave
GP_RST.lastRound = GP_RST.lastRound
GP_RST.lastSetup = GP_RST.lastSetup
GP_RST.liveSeen = GP_RST.liveSeen or false
GP_RST.liveMaxWave = GP_RST.liveMaxWave
GP_RST.lastRuntimeArmAt = GP_RST.lastRuntimeArmAt or 0
GP_RST.runtimeTpArmDone = GP_RST.runtimeTpArmDone or false
GP_RST.sourceClass = GP_RST.sourceClass or nil
GP_RST.detectNotifyUntil = GP_RST.detectNotifyUntil or 0
GP_RST.detectNotifyKind = GP_RST.detectNotifyKind or ""
GP_RST.detectGlobalUntil = GP_RST.detectGlobalUntil or 0
GP_RST.kind = GP_RST.kind or "unknown"
GP_RST.runWaveOrdinal = GP_RST.runWaveOrdinal or 0
GP_RST.runWaveReliable = GP_RST.runWaveReliable or false
GP_RST.waitLogAt = GP_RST.waitLogAt or 0
GP_RST.ignoreAutoArmUntil = GP_RST.ignoreAutoArmUntil or 0
GP_RST.medicCycleHardResetPending = GP_RST.medicCycleHardResetPending or false
GP_RST.medicCycleHardResetSince = GP_RST.medicCycleHardResetSince or 0
GP_RST.medicCycleSwapLockUntil = GP_RST.medicCycleSwapLockUntil or 0
GP_RST_CONTEXT_SECONDS = GP_RST_CONTEXT_SECONDS or 25.0
GP_RST_QUEUE_DELAY = GP_RST_QUEUE_DELAY or 0.60
GP_RST_RESTART_COOLDOWN = GP_RST_RESTART_COOLDOWN or 1.50
GP_RST_FORCE_RETRY_DELAY = GP_RST_FORCE_RETRY_DELAY or 0.40
GP_RST_FORCE_MAX_RETRIES = GP_RST_FORCE_MAX_RETRIES or 70
GP_RST_FORCE_LOCK_SECONDS = GP_RST_FORCE_LOCK_SECONDS or 12.0
GP_RST.voteRestartWindowUntil = GP_RST.voteRestartWindowUntil or 0
GP_RST.voteRestartCandidate = GP_RST.voteRestartCandidate or false
GP_RST.voteRestartWeakCandidate = GP_RST.voteRestartWeakCandidate or false
GP_RST.voteRestartPassedUntil = GP_RST.voteRestartPassedUntil or 0
GP_RST_VOTE_WINDOW_SECONDS = GP_RST_VOTE_WINDOW_SECONDS or 20.0
GP_RST_SNIPER_AFTER_WAVE = 2
function GP_RST_Now()
local t = 0
pcall(function()
if globals and globals.RealTime then t = globals.RealTime()
elseif globals and globals.CurTime then t = globals.CurTime()
end
end)
return t
end
function GP_RST_IsTransitionLockActive()
local now = GP_RST_Now()
local k = tostring(GP_RST.kind or "unknown")
if now < (GP_RST.detectGlobalUntil or 0) then
return true
end
if (k == "vote" or k == "fail") and (now < (GP_RST.contextUntil or 0)) then
return true
end
if ((GP_RST.queueAt or 0) > now) then
return true
end
if tpWaitForRoundReload == true then
return true
end
return false
end
function GP_RST_Log(_msg)
end
function GP_RST_GetVotePayloadText(ev)
if not ev then return "" end
local keys = {
"issue", "details", "detailstr", "vote_name", "vote_option", "reason",
"text", "message", "chat", "param1", "param2",
"option1", "option2", "option3", "option4", "option5"
}
local parts = {}
for i = 1, #keys do
local k = keys[i]
local v = GP_SafeCall(function()
if ev and ev.GetString then return ev:GetString(k) end
return nil
end, nil)
if type(v) == "string" and v ~= "" then
parts[#parts + 1] = string.lower(v)
end
end
return table.concat(parts, " | ")
end
function GP_RST_IsNegativeVotePayload(ev)
local s = GP_RST_GetVotePayloadText(ev)
if s == "" then
return false
end
local hasNegative =
(string.find(s, "kick", 1, true) ~= nil) or
(string.find(s, "ban", 1, true) ~= nil) or
(string.find(s, "scramble", 1, true) ~= nil) or
(string.find(s, "changelevel", 1, true) ~= nil) or
(string.find(s, "nextlevel", 1, true) ~= nil) or
(string.find(s, "difficulty", 1, true) ~= nil) or
(string.find(s, "surrender", 1, true) ~= nil) or
(string.find(s, "forfeit", 1, true) ~= nil)
return hasNegative
end
function GP_RST_IsRestartVotePayload(ev)
local s = GP_RST_GetVotePayloadText(ev)
if s == "" then
return false
end
local hasRestart =
(string.find(s, "restart", 1, true) ~= nil) or
(string.find(s, "reset", 1, true) ~= nil) or
(string.find(s, "tf_vote_restart", 1, true) ~= nil) or
(string.find(s, "mvm_restart", 1, true) ~= nil) or
(string.find(s, "restart round", 1, true) ~= nil)
if not hasRestart then
return false
end
if GP_RST_IsNegativeVotePayload(ev) then
local explicitRestart =
(string.find(s, "tf_vote_restart", 1, true) ~= nil) or
(string.find(s, "mvm_restart", 1, true) ~= nil) or
(string.find(s, "restart round", 1, true) ~= nil)
if not explicitRestart then
return false
end
end
return true
end
function GP_RST_NotifyDetected(kind, reason)
local k = tostring(kind or "unknown")
if k ~= "vote" and k ~= "fail" then return end
local r = tostring(reason or "")
if r == "vote_options" or r == "vote_cast" or r == "vote_changed" then
return
end
local now = GP_RST_Now()
if now < (GP_RST.detectGlobalUntil or 0) then
return
end
local hold = (k == "vote") and 1.50 or 1.00
if now < (GP_RST.detectNotifyUntil or 0) and tostring(GP_RST.detectNotifyKind or "") == k then
return
end
GP_RST.detectNotifyUntil = now + hold
GP_RST.detectNotifyKind = k
GP_RST.detectGlobalUntil = now + 6.00
if GP_InstantRespawnSuspend then pcall(GP_InstantRespawnSuspend, 8.0, "rst_detect_" .. tostring(k)) end
AddNotification("Map fail/restart detected - reset state", "warning", 5.0)
GP_RST_Log("detected popup: kind=" .. tostring(k) .. " by=" .. tostring(reason))
end
function GP_RST_Reset(reason)
GP_RST.contextUntil = 0
GP_RST.queueAt = 0
GP_RST.queueReason = "none"
GP_RST.cooldownUntil = 0
GP_RST.sourceWave = nil
GP_RST.sourceWaveReliable = false
GP_RST.sourceClass = nil
GP_RST.kind = "unknown"
GP_RST.forceActive = false
GP_RST.forceTarget = ""
GP_RST.forceReason = "none"
GP_RST.forceRetries = 0
GP_RST.forceNextAt = 0
GP_RST.forceLockUntil = 0
GP_RST.waitLogAt = 0
GP_RST.ignoreAutoArmUntil = 0
GP_RST.runtimeTpArmDone = false
GP_RST.medicCycleHardResetPending = false
GP_RST.medicCycleHardResetSince = 0
GP_RST.medicCycleSwapLockUntil = 0
GP_RST.runWaveOrdinal = 0
GP_RST.runWaveReliable = false
GP_RST.liveSeen = false
GP_RST.liveMaxWave = nil
GP_RST.lastWave = nil
GP_RST.lastReliableWave = nil
GP_RST.lastRound = nil
GP_RST.lastSetup = nil
GP_RST.lastLiveAt = 0
GP_RST.detectNotifyUntil = 0
GP_RST.detectNotifyKind = ""
GP_RST.detectGlobalUntil = 0
GP_RST.voteRestartWindowUntil = 0
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartPassedUntil = 0
gpF4Wave2FailPauseUntil = 0
if reason then
GP_RST_Log("reset: " .. tostring(reason))
end
end
function GP_RST_GetConfiguredTargetClass()
if not config then return nil end
-- Headless Engineer-only build: restart/retry always reselects Engineer,
-- without exposing the removed general-purpose class selector.
if config.autoBuyEnabled == true then return "engineer" end
if not config.changeClassEnabled then return nil end
local tc = config.targetClass
if type(tc) ~= "string" then return nil end
tc = tc:lower()
if tc == "" then return nil end
local valid = {
scout=true, sniper=true, soldier=true, demoman=true, medic=true,
heavy=true, heavyweapons=true, pyro=true, spy=true, engineer=true
}
if valid[tc] then return tc end
return nil
end
function GP_RST_EventKind(name)
local n = tostring(name or "")
if n == "vote_options" or n == "vote_cast" or n == "vote_changed" then
return "vote"
end
if n == "teamplay_restart_round" or n == "mvm_wave_failed" then
return "fail"
end
return "unknown"
end
function GP_RST_UpdateKind(newKind)
local old = GP_RST.kind or "unknown"
if newKind == "vote" then
GP_RST.kind = "vote"
return
end
if old == "vote" then
return
end
if newKind == "fail" then
GP_RST.kind = "fail"
return
end
if old == "unknown" and newKind ~= nil then
GP_RST.kind = newKind
end
end
function GP_RST_Arm(reason, kindOverride)
local t = GP_RST_Now()
local untilT = t + GP_RST_CONTEXT_SECONDS
if untilT > (GP_RST.contextUntil or 0) then
GP_RST.contextUntil = untilT
end
local kind = kindOverride or GP_RST_EventKind(reason)
GP_RST_UpdateKind(kind)
GP_RST.runtimeTpArmDone = false
GP_RST_NotifyDetected(GP_RST.kind or kind, reason)
if (GP_RST.kind == "vote" or GP_RST.kind == "fail") then
local holdUntil = t + 8.0
if holdUntil > (GP_RST.detectGlobalUntil or 0) then
GP_RST.detectGlobalUntil = holdUntil
end
end
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpRespawnRearmPending = false
tpForceRestoreAwaitRespawn = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpToggleSpawnLock = false
tpToggleSpawnLockArmedAt = 0
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
if GP_InstantRespawnSuspend then pcall(GP_InstantRespawnSuspend, 8.0, "rst_arm_" .. tostring(reason or "event")) end
if GP_F4_IsFeatureEnabled and GP_F4_OnDisconnectCycle then
local kNow = tostring(GP_RST.kind or kind or "unknown")
if kNow == "vote" or kNow == "fail" then
pcall(GP_F4_OnDisconnectCycle, "restart_fail_arm")
end
end
do
local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local cls = GP_GetCurrentClassName(me)
if type(cls) == "string" then
cls = string.lower(cls)
else
cls = nil
end
GP_RST.sourceClass = cls
end
if (GP_RST.kind or "unknown") == "vote" then
GP_RST.sourceWave = 0
GP_RST.sourceWaveReliable = true
acPostWaveSwapLatched = false
else
GP_RST.sourceWaveReliable = false
local w = GP_GetWaveNumber()
if type(w) == "number" then
GP_RST.sourceWave = w
GP_RST.sourceWaveReliable = true
elseif type(GP_RST.lastReliableWave) == "number" then
GP_RST.sourceWave = GP_RST.lastReliableWave
GP_RST.sourceWaveReliable = true
elseif type(GP_RST.runWaveOrdinal) == "number" and GP_RST.runWaveOrdinal > 0 and GP_RST.runWaveReliable == true then
GP_RST.sourceWave = GP_RST.runWaveOrdinal
GP_RST.sourceWaveReliable = true
elseif GP_RST.liveSeen then
GP_RST.sourceWave = 1
GP_RST.sourceWaveReliable = false
else
GP_RST.sourceWave = 0
GP_RST.sourceWaveReliable = false
end
if type(GP_RST.sourceWave) == "number" and GP_RST.sourceWave <= 1 then
acPostWaveSwapLatched = false
end
end
if (GP_RST.kind == "fail")
and (type(GP_RST.sourceWave) == "number")
and (GP_RST.sourceWave >= (GP_RST_SNIPER_AFTER_WAVE or 2)) then
local f4HoldUntil = t + 30.0
if f4HoldUntil > (gpF4Wave2FailPauseUntil or 0) then
gpF4Wave2FailPauseUntil = f4HoldUntil
end
if GP_F4_IsFeatureEnabled and GP_F4_IsFeatureEnabled() then
GP_F4_SetGuiAutoReady(false, true)
end
end
GP_RST_Log(
"arm by=" .. tostring(reason) ..
" kind=" .. tostring(GP_RST.kind) ..
" sourceClass=" .. tostring(GP_RST.sourceClass) ..
" sourceWave=" .. tostring(GP_RST.sourceWave) ..
" reliable=" .. tostring(GP_RST.sourceWaveReliable) ..
" contextLeft=" .. string.format("%.1f", math.max(0, GP_RST.contextUntil - t))
)
end
function GP_RST_Queue(reason)
local t = GP_RST_Now()
if t < (GP_RST.cooldownUntil or 0) then
return
end
GP_RST.queueAt = t + GP_RST_QUEUE_DELAY
GP_RST.queueReason = reason or "event_chain"
GP_RST.cooldownUntil = t + GP_RST_RESTART_COOLDOWN
GP_RST_Log("queue reason=" .. tostring(GP_RST.queueReason) .. " in " .. string.format("%.1f", GP_RST_QUEUE_DELAY) .. "s")
end
function GP_RST_ClassNum(cls)
if cls == "scout" then return 1 end
if cls == "sniper" then return 2 end
if cls == "soldier" then return 3 end
if cls == "demoman" then return 4 end
if cls == "medic" then return 5 end
if cls == "heavy" or cls == "heavyweapons" then return 6 end
if cls == "pyro" then return 7 end
if cls == "spy" then return 8 end
if cls == "engineer" then return 9 end
return nil
end
function GP_RST_RearmTpWalkNormal(reason)
if tpForceModeEnabled then return end
if not (config and config.tpWalkEnabled) then return end
local nowCT = (globals and globals.CurTime and globals.CurTime()) or GP_RST_Now()
local rearmTime = nowCT - (TELEPORTER_AUTOWALK_DELAY or 1.0)
tpToggleNeedsTrigger = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = rearmTime
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
tpRespawnRearmPending = false
tpForceRestoreAwaitRespawn = false
tpToggleSpawnLock = true
tpStickyArmed = true
reloadMoveLock = true
tpWaitForRoundReload = true
tpWaitForRoundReloadReason = tostring(reason or "restart_fail")
tpWaitForRoundReloadArmedAt = nowCT
tpLastAliveState = nil
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = 0
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
AddNotification("TpWalk armed after fail/restart - waiting for round reload", "warning")
end
function GP_RST_RearmForceTpWalk(reason)
if not tpForceModeEnabled then return end
local nowCT = (globals and globals.CurTime and globals.CurTime()) or GP_RST_Now()
local rearmTime = nowCT - (TELEPORTER_AUTOWALK_DELAY or 1.0)
tpStickyArmed = true
tpForceRestoreAwaitRespawn = true
tpRespawnRearmPending = false
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = rearmTime
tpToggleSpawnLock = true
reloadMoveLock = true
tpWaitForRoundReload = true
tpWaitForRoundReloadReason = tostring(reason or "restart_fail_force")
tpWaitForRoundReloadArmedAt = nowCT
tpLastAliveState = nil
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = 0
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
if me and me.IsAlive and (not me:IsAlive()) then
tpRespawnRearmPending = true
end
AddNotification("Force TpWalk armed after fail/restart - waiting for round reload", "warning")
end
function GP_RST_DecideTarget()
local sourceWave = GP_RST.sourceWave
if type(sourceWave) ~= "number" then
sourceWave = 0
end
local sourceReliable = (GP_RST.sourceWaveReliable == true)
local kind = GP_RST.kind or "unknown"
local acOn = (config and config.autoWalkEnabled) and true or false
local sbOn = (config and config.autoBuyEnabled) and true or false
local tc = GP_RST_GetConfiguredTargetClass()
local sourceClass = tostring(GP_RST.sourceClass or ""):lower()
local wasSniperBeforeRestart = (sourceClass == "sniper")
local tpwalkNormalSniperRecovery = ((config and config.tpWalkEnabled) and (not tpForceModeEnabled) and (not acOn) and (not sbOn) and wasSniperBeforeRestart)
if tpwalkNormalSniperRecovery then
return "sniper", "restart_tpwalk_normal_sniper", "tpwalk_sniper"
end
local sniperAfterWave = 2
GP_RST.lastDecisionThreshold = sniperAfterWave
if kind == "vote" then
GP_RST.lastDecisionWave2Plus = false
if acOn then
return "medic", "vote_restart_prewave1_autocredit", "medic_cycle"
end
if tc then
if tc == "engineer" and sbOn then
return "engineer", "vote_restart_target_sniperbuy", "sniper_cycle"
end
return tc, "vote_restart_target_class", "target_only"
end
return nil, "vote_restart_no_path", "none"
end
local wave2plus = (kind == "fail" and sourceReliable and sourceWave >= sniperAfterWave)
if sourceWave <= 1 then
wave2plus = false
end
GP_RST.lastDecisionWave2Plus = wave2plus
if kind == "fail" and wave2plus then
if tc then
if tc == "engineer" and sbOn then
return "engineer", "fail_wave2plus_target_sniperbuy", "sniper_cycle"
end
return tc, "fail_wave2plus_target_class", "target_only"
end
return nil, "fail_wave2plus_no_path", "none"
end
if acOn then
return "medic", "prewave_autocredit", "medic_cycle"
end
if tc then
if tc == "engineer" and sbOn then
return "engineer", "prewave_target_sniperbuy", "sniper_cycle"
end
return tc, "prewave_target_class", "target_only"
end
if (config and config.tpWalkEnabled) and (not tpForceModeEnabled) then
return "__tpwalk__", "prewave_tpwalk_rearm", "tpwalk_rearm"
end
return nil, "no_matching_path", "none"
end
function GP_RST_PrepareMedicCycle()
ForceCleanup()
acPostWaveSwapLatched = false
if GP_F4_IsFeatureEnabled and GP_F4_IsFeatureEnabled() then
gpF4PendingRejoinCycle = false
gpF4RequireTpForReady = true
GP_F4_Sync("restart_medic_cycle", true)
end
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
sniperUpgradeCooldownUntil = 0
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
thresholdNotificationShown = false
medicThresholdReached = false
gpPhase = "MEDIC_FARM"
autoWalkPaused = false
autoWalkPauseReason = nil
lastAutoWalkPauseReason = nil
shouldGuidePlayer = false
midpoint = nil
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
hasTriedClassChange = false
pendingClassChange = false
classChangeUsePreWaveRules = false
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
classChangeSwapPopupShown = false
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = 0
local rstNow = GP_RST_Now()
GP_RST.medicCycleHardResetPending = true
GP_RST.medicCycleHardResetSince = rstNow
GP_RST.medicCycleSwapLockUntil = rstNow + 180.0
end
function GP_RST_PrepareSniperCycle()
ForceCleanup()
gpPhase = "SNIPER_BUY"
isUpgradingSniper = false
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
sniperUpgradeCooldownUntil = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpNoTeleFallbackActive = false
end
function GP_RST_StartForce(targetClass, reason)
if not targetClass or targetClass == "" then return end
GP_RST.forceActive = true
GP_RST.forceTarget = tostring(targetClass)
GP_RST.forceReason = tostring(reason or "restart")
GP_RST.forceRetries = 0
GP_RST.forceNextAt = 0
local baseLock = (GP_RST_FORCE_LOCK_SECONDS or 12.0)
local k = tostring(GP_RST.kind or "unknown")
if k == "vote" then
baseLock = math.max(baseLock, 30.0)
elseif k == "fail" then
baseLock = math.max(baseLock, 20.0)
end
GP_RST.forceLockUntil = GP_RST_Now() + baseLock
GP_RST_Log("FORCE START target=" .. tostring(GP_RST.forceTarget) .. " reason=" .. tostring(GP_RST.forceReason))
end
function GP_RST_StopForce(reason)
GP_RST_Log("FORCE STOP: " .. tostring(reason))
GP_RST.forceActive = false
GP_RST.forceTarget = ""
GP_RST.forceReason = "none"
GP_RST.forceRetries = 0
GP_RST.forceNextAt = 0
GP_RST.forceLockUntil = 0
GP_RST.contextUntil = 0
GP_RST.queueAt = 0
GP_RST.queueReason = "none"
GP_RST.sourceWave = nil
GP_RST.sourceWaveReliable = false
GP_RST.sourceClass = nil
GP_RST.kind = "unknown"
GP_RST.waitLogAt = 0
GP_RST.ignoreAutoArmUntil = GP_RST_Now() + 6.0
GP_RST.runtimeTpArmDone = false
end
function GP_RST_IsClassChangeAllowed()
local setup = GP_TP_IsSetupPhase()
local rs = GP_GetRoundState()
if setup == true then
return true
end
if type(rs) == "number" then
if rs == 4 then return false end
if rs >= 8 then return true end
end
return false
end
function GP_RST_TickForce()
if not GP_RST.forceActive then return end
local t = GP_RST_Now()
local me = entities.GetLocalPlayer()
if not me then
return
end
local curClass = GP_GetCurrentClassName(me)
if curClass == GP_RST.forceTarget then
GP_RST_StopForce("target class reached")
return
end
if t >= (GP_RST.forceLockUntil or 0) then
GP_RST_StopForce("lock timeout")
return
end
if (GP_RST.forceRetries or 0) >= (GP_RST_FORCE_MAX_RETRIES or 70) then
GP_RST_StopForce("max retries")
return
end
if not GP_RST_IsClassChangeAllowed() then
if t >= (GP_RST.waitLogAt or 0) then
GP_RST.waitLogAt = t + 0.75
GP_RST_Log("force wait: class change not allowed yet (between waves only)")
end
return
end
if t >= (GP_RST.forceNextAt or 0) then
GP_RST.forceNextAt = t + (GP_RST_FORCE_RETRY_DELAY or 0.4)
GP_RST.forceRetries = (GP_RST.forceRetries or 0) + 1
local c = GP_RST.forceTarget
local n = GP_RST_ClassNum(c)
client.Command("joinclass " .. tostring(c), true)
client.Command("join_class " .. tostring(c), true)
if n then
client.Command("joinclass " .. tostring(n), true)
end
GP_ArmClassSelectClose(t, c)
GP_RST_Log("force retry=" .. tostring(GP_RST.forceRetries) .. " target=" .. tostring(c) .. " current=" .. tostring(curClass))
end
end
function GP_RST_TickState()
local prevRound = GP_RST.lastRound
local wave = GP_GetWaveNumber()
local rs = GP_GetRoundState()
local setup = GP_TP_IsSetupPhase()
local t = GP_RST_Now()
if prevRound ~= nil and rs ~= nil and prevRound ~= 4 and rs == 4 then
GP_RST.runWaveOrdinal = (tonumber(GP_RST.runWaveOrdinal) or 0) + 1
GP_RST.runWaveReliable = false
GP_RST.liveSeen = true
GP_RST.lastLiveAt = t
if GP_RST.runWaveOrdinal > (tonumber(GP_RST.liveMaxWave) or 0) then
GP_RST.liveMaxWave = GP_RST.runWaveOrdinal
end
end
if rs == 4 then
GP_RST.liveSeen = true
GP_RST.lastLiveAt = t
end
if type(wave) == "number" then
if type(GP_RST.liveMaxWave) ~= "number" or wave > GP_RST.liveMaxWave then
GP_RST.liveMaxWave = wave
end
GP_RST.lastWave = wave
GP_RST.lastReliableWave = wave
end
GP_RST.lastSetup = setup
GP_RST.lastRound = rs
end
function GP_RST_TickQueuedStart()
local t = GP_RST_Now()
if (GP_RST.queueAt or 0) > 0 and t >= GP_RST.queueAt then
GP_RST.queueAt = 0
local queuedReason = GP_RST.queueReason or "event_chain"
GP_RST.queueReason = "none"
local target, why, mode = GP_RST_DecideTarget()
GP_RST_Log(
"decide target=" .. tostring(target) ..
" mode=" .. tostring(mode) ..
" why=" .. tostring(why) ..
" kind=" .. tostring(GP_RST.kind) ..
" sourceClass=" .. tostring(GP_RST.sourceClass) ..
" sourceWave=" .. tostring(GP_RST.sourceWave) ..
" reliable=" .. tostring(GP_RST.sourceWaveReliable) ..
" runWaveOrdinal=" .. tostring(GP_RST.runWaveOrdinal) ..
" threshold=" .. tostring(GP_RST.lastDecisionThreshold) ..
" wave2plus=" .. tostring(GP_RST.lastDecisionWave2Plus)
)
if (GP_RST.kind == "vote" or GP_RST.kind == "fail") and (not GP_RST.runtimeTpArmDone) then
if tpForceModeEnabled then
GP_RST_RearmForceTpWalk(queuedReason)
GP_RST.runtimeTpArmDone = true
GP_RST.lastRuntimeArmAt = t
else
if mode == "tpwalk_sniper"
or (((config and config.tpWalkEnabled) == true) and (target == "sniper" or tostring((GP_RST and GP_RST.sourceClass) or ""):lower() == "sniper")) then
GP_RST_RearmTpWalkNormal(queuedReason)
GP_RST.runtimeTpArmDone = true
GP_RST.lastRuntimeArmAt = t
end
end
end
if target and target ~= "" then
if mode == "medic_cycle" and target == "medic" then
GP_RST_PrepareMedicCycle()
GP_RST_StartForce(target, queuedReason .. ":" .. tostring(why))
elseif mode == "sniper_cycle" and target == "engineer" then
GP_RST_PrepareSniperCycle()
GP_RST_StartForce(target, queuedReason .. ":" .. tostring(why))
elseif mode == "tpwalk_rearm" and target == "__tpwalk__" then
GP_RST.contextUntil = 0
GP_RST.sourceWave = nil
GP_RST.sourceWaveReliable = false
GP_RST.sourceClass = nil
GP_RST.kind = "unknown"
elseif mode == "tpwalk_sniper" and target == "sniper" then
local meNow = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local curCls = GP_GetCurrentClassName(meNow)
if curCls ~= "sniper" then
ForceCleanup()
GP_RST_StartForce("sniper", queuedReason .. ":" .. tostring(why))
AddNotification("TpWalk: fail/restart detected - switching to Sniper", "info", 5.0)
else
GP_RST.contextUntil = 0
GP_RST.sourceWave = nil
GP_RST.sourceWaveReliable = false
GP_RST.sourceClass = nil
GP_RST.kind = "unknown"
end
else
if target == "engineer" and (config and config.autoBuyEnabled) and (not forceSniperBuyModeEnabled) then
GP_RST_PrepareSniperCycle()
else
ForceCleanup()
end
GP_RST_StartForce(target, queuedReason .. ":" .. tostring(why))
end
else
GP_RST.contextUntil = 0
GP_RST.sourceWave = nil
GP_RST.sourceWaveReliable = false
GP_RST.sourceClass = nil
GP_RST.kind = "unknown"
end
end
GP_RST_TickForce()
end
function GP_RST_OnEvent(name, ev)
GP_RST.lastEvent = name or "none"
if name == "mvm_begin_wave" then
local idx = GP_SafeCall(function() return ev and ev.GetInt and ev:GetInt("wave_index") end, nil)
if type(idx) == "number" then
if idx >= 0 and idx < 100 then
GP_RST.runWaveOrdinal = idx + 1
GP_RST.lastReliableWave = GP_RST.runWaveOrdinal
GP_RST.runWaveReliable = true
end
elseif (tonumber(GP_RST.runWaveOrdinal) or 0) <= 0 then
GP_RST.runWaveOrdinal = 1
GP_RST.runWaveReliable = false
end
GP_RST.liveSeen = true
GP_RST.lastLiveAt = GP_RST_Now()
end
if name == "vote_options" then
local now = GP_RST_Now()
local isRestart = GP_RST_IsRestartVotePayload(ev)
local isNegative = GP_RST_IsNegativeVotePayload(ev)
if isRestart then
GP_RST.voteRestartCandidate = true
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartWindowUntil = now + (GP_RST_VOTE_WINDOW_SECONDS or 20.0)
GP_RST_Arm(name, "vote")
elseif not isNegative then
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = true
GP_RST.voteRestartWindowUntil = now + (GP_RST_VOTE_WINDOW_SECONDS or 20.0)
GP_RST_Log("vote_options: ambiguous payload -> weak restart context")
else
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartWindowUntil = 0
GP_RST_Log("ignore vote_options (not restart vote)")
end
return
end
if name == "vote_cast" or name == "vote_changed" then
local now = GP_RST_Now()
if (GP_RST.voteRestartCandidate == true) and (now < (GP_RST.voteRestartWindowUntil or 0)) then
GP_RST_Arm(name, "vote")
elseif (GP_RST.voteRestartWeakCandidate == true) and (now < (GP_RST.voteRestartWindowUntil or 0)) then
GP_RST_Log(tostring(name) .. ": weak restart context pending vote result")
else
GP_RST_Log("ignore " .. tostring(name) .. " (no restart-vote context)")
end
return
end
if name == "vote_passed" or name == "vote_ended" then
local now = GP_RST_Now()
local inWindow = (now < (GP_RST.voteRestartWindowUntil or 0))
local strongCtx = (GP_RST.voteRestartCandidate == true) and inWindow
local weakCtx = (GP_RST.voteRestartWeakCandidate == true) and inWindow
local isRestart = GP_RST_IsRestartVotePayload(ev)
local isNegative = GP_RST_IsNegativeVotePayload(ev)
local confirmRestart = false
if isRestart then
confirmRestart = true
elseif strongCtx then
confirmRestart = true
elseif weakCtx and (not isNegative) then
confirmRestart = true
end
if confirmRestart then
GP_RST.voteRestartPassedUntil = now + 20.0
GP_RST_Log("vote pass confirmed -> immediate restart arm")
GP_RST_Arm("vote_passed", "vote")
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "vote_passed") end
GP_RST_Queue("vote_passed")
else
GP_RST_Log("ignore " .. tostring(name) .. " (not a restart vote)")
end
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartWindowUntil = 0
return
end
if name == "vote_failed" then
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartWindowUntil = 0
return
end
if name == "teamplay_restart_round" then
local now = GP_RST_Now()
local fromVote =
((GP_RST.voteRestartCandidate == true or GP_RST.voteRestartWeakCandidate == true) and (now < (GP_RST.voteRestartWindowUntil or 0))) or
(now < (GP_RST.voteRestartPassedUntil or 0))
if fromVote then
GP_RST_Arm(name, "vote")
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "teamplay_restart_round_vote") end
GP_RST_Queue("teamplay_restart_round_vote")
else
GP_RST_Arm(name, "fail")
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "teamplay_restart_round_fail") end
GP_RST_Queue("teamplay_restart_round_fail")
end
return
end
if name == "mvm_wave_failed" then
GP_RST_Arm(name, GP_RST_EventKind(name))
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "mvm_wave_failed") end
return
end
if name == "teamplay_round_win" then
local winTeam = GP_SafeCall(function() return ev and ev.GetInt and ev:GetInt("team") end, nil)
if type(winTeam) == "number" and winTeam == 3 then
GP_RST_Arm("teamplay_round_win_blue", "fail")
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "teamplay_round_win_blue") end
GP_RST_Queue("teamplay_round_win_blue")
return
end
end
if name == "teamplay_round_start" or name == "mvm_reset_stats"
or name == "localplayer_respawn" or name == "player_spawn"
or name == "post_inventory_application" then
local t = GP_RST_Now()
if (name == "teamplay_round_start" or name == "mvm_reset_stats")
and (GP_RST.voteRestartWeakCandidate == true)
and (t < (GP_RST.voteRestartWindowUntil or 0)) then
GP_RST_Log("weak restart context confirmed by " .. tostring(name))
GP_RST.voteRestartPassedUntil = t + 20.0
GP_RST_Arm("weak_" .. tostring(name), "vote")
if GP_InstantRespawnSuspend then GP_InstantRespawnSuspend(8.0, "weak_" .. tostring(name)) end
GP_RST_Queue("weak_" .. tostring(name))
GP_RST.voteRestartCandidate = false
GP_RST.voteRestartWeakCandidate = false
GP_RST.voteRestartWindowUntil = 0
end
if tpWaitForRoundReload and (name == "teamplay_round_start" or name == "mvm_reset_stats") then
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
teleporterConfig.autoWalkEnabled = false
tpToggleSpawnLock = false
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
local nowCT = (globals and globals.CurTime and globals.CurTime()) or t
sniperUpgradeCompletedTime = nowCT - (TELEPORTER_AUTOWALK_DELAY or 1.0)
if tpForceModeEnabled and tpForceRestoreAwaitRespawn then
local meNow = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
local aliveNow = (meNow and meNow.IsAlive and meNow:IsAlive()) and true or false
if aliveNow then
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpStickyArmed = true
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = (TP_TELE_STABLE_SCANS or 8)
reloadMoveLock = false
else
tpRespawnRearmPending = true
reloadMoveLock = true
end
tpLastAliveState = aliveNow
end
if tpForceModeEnabled then
AddNotification("Force TpWalk: round reload detected", "info")
else
AddNotification("TpWalk: round reload detected", "info")
end
end
if t < (GP_RST.contextUntil or 0) then
GP_RST_Queue("followup_" .. tostring(name))
end
if name == "teamplay_round_start" or name == "mvm_reset_stats" then
GP_RST.runWaveOrdinal = 0
GP_RST.runWaveReliable = false
GP_RST.liveSeen = false
GP_RST.liveMaxWave = nil
GP_RST.lastWave = nil
GP_RST.lastReliableWave = nil
GP_RST.voteRestartPassedUntil = 0
end
end
end
gp_partyKillLastTrigger = gp_partyKillLastTrigger or 0
gp_partyLeaveLastTrigger = gp_partyLeaveLastTrigger or 0
gp_partyFixLastTrigger = gp_partyFixLastTrigger or 0
gp_partyRetryLastTrigger = gp_partyRetryLastTrigger or 0
gp_partyVoteLastTrigger = gp_partyVoteLastTrigger or 0
gp_partyLeadLastTrigger = gp_partyLeadLastTrigger or 0
gpSmartVoteLastTrigger = gpSmartVoteLastTrigger or 0
gpSmartVotePendingActive = gpSmartVotePendingActive or false
gpSmartVotePendingOption = gpSmartVotePendingOption or 0
gpSmartVotePendingNext = gpSmartVotePendingNext or 0
gpSmartVotePendingUntil = gpSmartVotePendingUntil or 0
gpSmartVotePendingAttempts = gpSmartVotePendingAttempts or 0
gpSmartVotePendingLabel = gpSmartVotePendingLabel or ""
gpSmartVotePendingVoteIdx = gpSmartVotePendingVoteIdx or nil
gpSmartVoteObservedFirstCast = gpSmartVoteObservedFirstCast or false
gpSmartVoteObservedStarterCast = gpSmartVoteObservedStarterCast or false
gpClassSelectDebugLastNotifyAt = gpClassSelectDebugLastNotifyAt or 0
gpClassSelectDebugSeq = gpClassSelectDebugSeq or 0
gpForceFixWaveLastTrigger = gpForceFixWaveLastTrigger or 0
gpPartyFixSwapBackPending = gpPartyFixSwapBackPending or false
gpPartyFixSwapBackAt = gpPartyFixSwapBackAt or 0
gpPartyFixAimbotSnapshot = gpPartyFixAimbotSnapshot or nil
gpPartyRecStopActive = gpPartyRecStopActive or false
gpPartyRecStopNext = gpPartyRecStopNext or 0
gpPartyRecStopUntil = gpPartyRecStopUntil or 0
gpPartyActiveVoteIds = gpPartyActiveVoteIds or {}
gpPartyLastMemberEventAt = gpPartyLastMemberEventAt or 0
gpPartyLastMemberEventName = gpPartyLastMemberEventName or ""
gpPartyLootSeeded = gpPartyLootSeeded or false

function GP_ClassCloseDebugValue(label, fn)
local ok, v = pcall(fn)
if ok and v ~= nil then return tostring(label) .. "=" .. tostring(v) end
return tostring(label) .. "=nil"
end

function GP_ClassCloseDebugState(reason, notify)
local parts = {}
parts[#parts + 1] = "seq=" .. tostring(gpClassSelectDebugSeq or 0)
parts[#parts + 1] = "reason=" .. tostring(reason or "state")
parts[#parts + 1] = "rt=" .. string.format("%.2f", GP_PartyNow() or 0)
parts[#parts + 1] = GP_ClassCloseDebugValue("ct", function() return globals and globals.CurTime and globals.CurTime() end)
parts[#parts + 1] = GP_ClassCloseDebugValue("gameui", function() return engine and engine.IsGameUIVisible and engine.IsGameUIVisible() end)
parts[#parts + 1] = GP_ClassCloseDebugValue("lboxmenu", function() return gui and gui.IsMenuOpen and gui.IsMenuOpen() end)
parts[#parts + 1] = "active=" .. tostring(gpClassSelectCloseActive == true)
parts[#parts + 1] = "attempts=" .. tostring(gpClassSelectCloseSlotAttempts or 0)
parts[#parts + 1] = "target=" .. tostring(gpClassSelectCloseClassCmd or "nil")
parts[#parts + 1] = "next=" .. string.format("%.2f", tonumber(gpClassSelectCloseNext or 0) or 0)
parts[#parts + 1] = "until=" .. string.format("%.2f", tonumber(gpClassSelectCloseUntil or 0) or 0)
local me = nil
pcall(function() if entities and entities.GetLocalPlayer then me = entities.GetLocalPlayer() end end)
parts[#parts + 1] = "me=" .. tostring(me ~= nil)
if me then
parts[#parts + 1] = GP_ClassCloseDebugValue("alive", function() return me.IsAlive and me:IsAlive() end)
parts[#parts + 1] = GP_ClassCloseDebugValue("class", function() return GP_GetCurrentClassName and GP_GetCurrentClassName(me) end)
parts[#parts + 1] = GP_ClassCloseDebugValue("m_iClass", function() return me.GetPropInt and me:GetPropInt("m_iClass") end)
parts[#parts + 1] = GP_ClassCloseDebugValue("desiredA", function() return me.GetPropInt and me:GetPropInt("m_Shared.m_iDesiredPlayerClass") end)
parts[#parts + 1] = GP_ClassCloseDebugValue("desiredB", function() return me.GetPropInt and me:GetPropInt("m_iDesiredPlayerClass") end)
end
local msg = table.concat(parts, " ")
pcall(function() print("[GM ClassClose] " .. msg) end)
if notify == true then
local now = GP_PartyNow()
if (now - (gpClassSelectDebugLastNotifyAt or 0)) >= 0.35 then
gpClassSelectDebugLastNotifyAt = now
AddNotification("Class debug: " .. tostring(reason or "state"), "info", 4.0)
end
end
end

function GP_TryGetEventString(ev, key)
if not ev or not key then return nil end
local ok, v = pcall(function()
if ev.GetString then return ev:GetString(key) end
return nil
end)
if ok and type(v) == "string" and v ~= "" then
return v
end
return nil
end
function GP_NormalizeChatCmd(s)
if not s then return "" end
s = tostring(s)
s = s:gsub("^%s+", ""):gsub("%s+$", "")
s = s:gsub("%s+", " ")
s = string.lower(s)
return s
end
function GP_PartyMsgHasCommand(normMsg, commandToken)
if not normMsg or normMsg == "" or not commandToken then return false end
if normMsg == commandToken then return true end
for token in string.gmatch(normMsg, "[%w_]+") do
if token == commandToken then
return true
end
end
return false
end

function GP_PartyNow()
local now = 0
pcall(function()
if globals and globals.RealTime then now = globals.RealTime()
elseif globals and globals.CurTime then now = globals.CurTime()
end
end)
return tonumber(now) or 0
end

function GP_PartyRun(cmd)
if type(cmd) ~= "string" or cmd == "" then return false end
local ok = pcall(function()
if client and client.Command then
client.Command(cmd, true)
end
end)
return ok == true
end

function GP_ClassSelectSlotForClass(className)
local c = string.lower(tostring(className or ""))
local map = {
scout = "slot1",
soldier = "slot2",
pyro = "slot3",
demo = "slot4",
demoman = "slot4",
heavy = "slot5",
heavyweapons = "slot5",
engineer = "slot6",
engie = "slot6",
medic = "slot7",
sniper = "slot8",
spy = "slot9"
}
return map[c]
end

function GP_ClassSelectNumForClass(className)
local c = string.lower(tostring(className or ""))
local map = {
scout = 1,
sniper = 2,
soldier = 3,
demo = 4,
demoman = 4,
medic = 5,
heavy = 6,
heavyweapons = 6,
pyro = 7,
spy = 8,
engineer = 9,
engie = 9
}
return map[c]
end

function GP_ArmClassSelectClose(_, className)
local now = GP_PartyNow()
gpClassSelectDebugSeq = (gpClassSelectDebugSeq or 0) + 1
gpClassSelectCloseActive = true
gpClassSelectCloseNext = now + 0.15
gpClassSelectCloseUntil = now + 0.90
gpClassSelectCloseSlotCmd = GP_ClassSelectSlotForClass(className)
gpClassSelectCloseClassCmd = tostring(className or "")
if gpClassSelectCloseClassCmd == "" then gpClassSelectCloseClassCmd = nil end
local num = GP_ClassSelectNumForClass(className)
gpClassSelectCloseClassNumCmd = num and ("joinclass " .. tostring(num)) or nil
gpClassSelectCloseSlotAttempts = 0
GP_ClassCloseDebugState("armed", true)
end

function GP_ClassSelectCloseTick(now)
if gpClassSelectCloseActive ~= true then return end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
if now < (gpClassSelectCloseNext or 0) then return end
GP_ClassCloseDebugState("before_attempt", true)
GP_PartyRun("closedwelcomemenu")
GP_PartyRun("menuclosed")
GP_PartyRun("hideconsole")
gpClassSelectCloseSlotAttempts = (gpClassSelectCloseSlotAttempts or 0) + 1
GP_ClassCloseDebugState("after_attempt", false)
if now >= (gpClassSelectCloseUntil or 0) or (gpClassSelectCloseSlotAttempts or 0) >= 2 then
GP_ClassCloseDebugState("stopped", false)
gpClassSelectCloseActive = false
gpClassSelectCloseNext = 0
gpClassSelectCloseUntil = 0
gpClassSelectCloseSlotCmd = nil
gpClassSelectCloseClassCmd = nil
gpClassSelectCloseClassNumCmd = nil
gpClassSelectCloseSlotAttempts = 0
else
gpClassSelectCloseNext = now + 0.35
end
end

function GP_PartyVoteRetryStart(optionNum, now)
optionNum = tonumber(optionNum) or 0
if optionNum < 1 or optionNum > 2 then return false end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
gpPartyVoteRetryActive = true
gpPartyVoteRetryOption = optionNum
gpPartyVoteRetryNext = now + 0.18
gpPartyVoteRetryUntil = now + 1.80
gpPartyVoteRetryAttempts = 0
return true
end

function GP_PartyVoteRetryTick(now)
if gpPartyVoteRetryActive ~= true then return end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
if now >= (gpPartyVoteRetryUntil or 0) then
gpPartyVoteRetryActive = false
gpPartyVoteRetryOption = 0
gpPartyVoteRetryNext = 0
gpPartyVoteRetryUntil = 0
gpPartyVoteRetryAttempts = 0
return
end
if now < (gpPartyVoteRetryNext or 0) then return end
gpPartyVoteRetryAttempts = (gpPartyVoteRetryAttempts or 0) + 1
GP_PartyDoVote(gpPartyVoteRetryOption, false)
if (gpPartyVoteRetryAttempts or 0) >= 6 then
gpPartyVoteRetryActive = false
gpPartyVoteRetryOption = 0
gpPartyVoteRetryNext = 0
gpPartyVoteRetryUntil = 0
gpPartyVoteRetryAttempts = 0
else
gpPartyVoteRetryNext = now + (((gpPartyVoteRetryAttempts or 0) < 3) and 0.20 or 0.32)
end
end

function GP_QueueSmartVote(optionNum, label, voteIdx)
optionNum = tonumber(optionNum) or 0
if optionNum < 1 or optionNum > 2 then return false end
local t = GP_PartyNow()
gpSmartVotePendingActive = true
gpSmartVotePendingOption = optionNum
gpSmartVotePendingNext = t + 0.40
gpSmartVotePendingUntil = t + 1.20
gpSmartVotePendingAttempts = 0
gpSmartVotePendingLabel = tostring(label or "")
gpSmartVotePendingVoteIdx = voteIdx
gpSmartVoteObservedFirstCast = false
gpSmartVoteObservedStarterCast = false
return true
end

function GP_SmartVoteTick(now)
if gpSmartVotePendingActive ~= true then return end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
if now >= (gpSmartVotePendingUntil or 0) then
gpSmartVotePendingActive = false
gpSmartVotePendingOption = 0
gpSmartVotePendingNext = 0
gpSmartVotePendingUntil = 0
gpSmartVotePendingAttempts = 0
gpSmartVotePendingLabel = ""
gpSmartVotePendingVoteIdx = nil
gpSmartVoteObservedFirstCast = false
gpSmartVoteObservedStarterCast = false
return
end
if now < (gpSmartVotePendingNext or 0) then return end
gpSmartVotePendingAttempts = (gpSmartVotePendingAttempts or 0) + 1
GP_PartyDoVote(gpSmartVotePendingOption, false)
if gpSmartVotePendingOption == 1 then
AddNotification("Smart Vote: party vote -> F1", "info")
else
AddNotification("Smart Vote: random vote -> F2", "info")
end
gpSmartVotePendingActive = false
gpSmartVotePendingOption = 0
gpSmartVotePendingNext = 0
gpSmartVotePendingUntil = 0
gpSmartVotePendingAttempts = 0
gpSmartVotePendingLabel = ""
gpSmartVotePendingVoteIdx = nil
gpSmartVoteObservedFirstCast = false
gpSmartVoteObservedStarterCast = false
end

function GP_PartyEventInt(ev, key)
local ok, v = pcall(function()
if ev and ev.GetInt then return ev:GetInt(key) end
return nil
end)
if ok and v ~= nil then return tonumber(v) end
return nil
end

function GP_PartyEventIntString(ev, key)
local ok, v = pcall(function()
if ev and ev.GetUint64 then return ev:GetUint64(key) end
if ev and ev.GetInt64 then return ev:GetInt64(key) end
if ev and ev.GetInt then return ev:GetInt(key) end
return nil
end)
if ok and v ~= nil then
v = tostring(v)
if v ~= "" and v ~= "0" then return v end
end
return nil
end

function GP_PartyRememberVoteFromEvent(name, ev)
local n = string.lower(tostring(name or ""))
if not string.find(n, "vote", 1, true) then return end
if n == "vote_ended" or n == "vote_passed" or n == "vote_failed" then
gpPartyActiveVoteIds = {}
return
end
local keys = {"voteidx", "vote_idx", "voteid", "vote_id", "vote_index", "idx", "index", "id"}
local now = GP_PartyNow()
for i = 1, #keys do
local id = GP_PartyEventInt(ev, keys[i])
if id and id >= 0 and id <= 64 then
gpPartyActiveVoteIds[tostring(id)] = now + 35.0
end
end
end

function GP_PartyActiveVoteIds()
local ids = {}
local now = GP_PartyNow()
for k, untilT in pairs(gpPartyActiveVoteIds or {}) do
if type(untilT) == "number" and untilT > now then
ids[#ids + 1] = tonumber(k)
else
gpPartyActiveVoteIds[k] = nil
end
end
table.sort(ids)
return ids
end

function GP_PartyRunVoteCommand(cmd)
if type(cmd) ~= "string" or cmd == "" then return false end
local ok = pcall(function()
if client and client.Command then
client.Command(cmd, false)
end
end)
return ok == true
end

function GP_PartyDoVote(optionNum, armRetry)
optionNum = tonumber(optionNum) or 0
if optionNum < 1 or optionNum > 2 then return false end
local opt = "option" .. tostring(optionNum)
local sent = {}
local function runVote(voteIdx)
local cmd = "vote " .. opt
voteIdx = tonumber(voteIdx)
if voteIdx then
cmd = "vote " .. tostring(voteIdx) .. " " .. opt
end
if sent[cmd] then return end
sent[cmd] = true
GP_PartyRunVoteCommand(cmd)
end
runVote(gpSmartVotePendingVoteIdx)
local ids = GP_PartyActiveVoteIds()
for i = 1, #ids do
runVote(ids[i])
end
runVote(nil)
if armRetry ~= false then
GP_PartyVoteRetryStart(optionNum, GP_PartyNow())
end
return true
end

function GP_PartyTrim(s)
s = tostring(s or "")
return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

function GP_PartyAccountToSteam2(acc)
acc = tonumber(acc)
if not acc or acc <= 0 then return nil end
local y = acc % 2
local z = math.floor((acc - y) / 2)
return "STEAM_0:" .. tostring(y) .. ":" .. tostring(z)
end

function GP_PartyCanonicalSteam(s)
s = GP_PartyTrim(s)
if s == "" then return nil end
local _, b, c = s:match("STEAM_([0-5]):([0-1]):(%d+)")
if b and c then return "STEAM_0:" .. tostring(b) .. ":" .. tostring(c) end
local acc3 = s:match("%[U:1:(%d+)%]")
if acc3 then return GP_PartyAccountToSteam2(acc3) end
if s:match("^%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d$") then
local n = tonumber(s)
if n and n >= 76561197960265728 then
return GP_PartyAccountToSteam2(n - 76561197960265728)
end
end
if s:match("^%d+$") then
local fromAcc = GP_PartyAccountToSteam2(s)
if fromAcc then return fromAcc end
end
return string.lower(s)
end

function GP_PartyMembers()
local ok, members = pcall(function()
if party and party.GetMembers then return party.GetMembers() end
return nil
end)
if ok and type(members) == "table" then return members end
return nil
end

function GP_PartyLeader()
local ok, leader = pcall(function()
if party and party.GetLeader then return party.GetLeader() end
return nil
end)
if ok and type(leader) == "string" and leader ~= "" then return leader end
return nil
end

function GP_PartyLocalSteamCandidates()
local out = {}
local funcs = {
function() return client and client.GetSteamID and client.GetSteamID() end,
function() return client and client.GetLocalSteamID and client.GetLocalSteamID() end,
function() return steam and steam.GetSteamID and steam.GetSteamID() end,
function() return steam and steam.GetSteamID64 and steam.GetSteamID64() end,
function() return steam and steam.GetAccountID and steam.GetAccountID() end
}
for i = 1, #funcs do
local ok, v = pcall(funcs[i])
if ok and v ~= nil and tostring(v) ~= "" then out[#out + 1] = tostring(v) end
end
return out
end

function GP_PartyAmLeader()
local leader = GP_PartyLeader()
if not leader then return nil end
local cleader = GP_PartyCanonicalSteam(leader)
local mine = GP_PartyLocalSteamCandidates()
for i = 1, #mine do
if GP_PartyCanonicalSteam(mine[i]) == cleader then return true end
end
return false
end

function GP_PartyFeatureLog(key, text, cooldown)
key = tostring(key or "log")
local now = GP_PartyNow()
cooldown = tonumber(cooldown) or 1.5
if (now - (gpPartyFeatureLastLog[key] or 0)) < cooldown then return end
gpPartyFeatureLastLog[key] = now
pcall(function() print("[GM PartyFeatures] " .. tostring(text or "")) end)
end

function GP_PartySteam2ToSteam64(steam2)
steam2 = tostring(steam2 or "")
local _, y, z = steam2:match("STEAM_([0-5]):([0-1]):(%d+)")
if not y or not z then return nil end
local account = (tonumber(z) or 0) * 2 + (tonumber(y) or 0)
return tostring(GP_STEAMID64_BASE + account)
end

function GP_PartyAnyToSteam64(value)
value = GP_PartyTrim(value)
if value == "" then return nil end
if value:match("^%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d$") then
return value
end
if steam and steam.ToSteamID64 then
local ok64, steam64 = pcall(function() return steam.ToSteamID64(value) end)
if ok64 and steam64 ~= nil and tostring(steam64) ~= "" and tostring(steam64) ~= "0" then
return tostring(steam64)
end
end
local account = value:match("^%[U:1:(%d+)%]$")
if account then
return tostring(GP_STEAMID64_BASE + (tonumber(account) or 0))
end
local steam2 = GP_PartySteam2ToSteam64(value)
if steam2 then return steam2 end
if value:match("^%d+$") then
if #value >= 17 then
return value
end
local n = tonumber(value)
if n then
if n >= GP_STEAMID64_BASE then
return tostring(n)
end
if n > 0 then
return tostring(GP_STEAMID64_BASE + n)
end
end
end
return nil
end

function GP_PartyRequestJoinSteam64(steam64)
steam64 = GP_PartyAnyToSteam64(steam64)
if not steam64 then return false end
local shareKey = "share my lobby"
local prevShare = nil
if gui and gui.GetValue then
pcall(function() prevShare = gui.GetValue(shareKey) end)
end
if gui and gui.SetValue then
pcall(function() gui.SetValue(shareKey, 1) end)
end
GP_PartyRun("tf_party_force_update")
local ok = GP_PartyRun("tf_party_request_join_user " .. tostring(steam64))
if gui and gui.SetValue and prevShare ~= nil then
pcall(function() gui.SetValue(shareKey, prevShare) end)
end
return ok == true
end

function GP_PartyInviteSteam64(steam64)
steam64 = GP_PartyAnyToSteam64(steam64)
if not steam64 then return false end
local shareKey = "share my lobby"
local prevShare = nil
if gui and gui.GetValue then
pcall(function() prevShare = gui.GetValue(shareKey) end)
end
if gui and gui.SetValue then
pcall(function() gui.SetValue(shareKey, 1) end)
end
GP_PartyRun("tf_party_force_update")
local ok = GP_PartyRun("tf_party_invite_user " .. tostring(steam64))
if gui and gui.SetValue and prevShare ~= nil then
pcall(function() gui.SetValue(shareKey, prevShare) end)
end
return ok == true
end

function GP_PartyCollectSteamCandidates(value, out, depth)
out = out or {}
depth = tonumber(depth) or 0
if depth > 3 or value == nil then return out end
local tv = type(value)
if tv == "string" or tv == "number" then
local steam64 = GP_PartyAnyToSteam64(value)
if steam64 then out[steam64] = true end
return out
end
if tv == "table" then
for _, v in pairs(value) do
GP_PartyCollectSteamCandidates(v, out, depth + 1)
end
return out
end
if tv == "userdata" then
local methods = {
"GetSenderId", "GetSenderID", "GetSteamId", "GetSteamID", "GetSteamID64",
"GetSteamid", "GetMemberId", "GetMemberID", "GetUserID", "GetXuid"
}
for i = 1, #methods do
local okFn, fn = pcall(function() return value[methods[i]] end)
if not okFn then fn = nil end
if type(fn) == "function" then
local ok, v = pcall(fn, value)
if ok then GP_PartyCollectSteamCandidates(v, out, depth + 1) end
end
end
end
return out
end

function GP_PartyCountApiResult(apiName)
if not party then return "no_api", nil end
if apiName == "GetPendingMembers" then
local okPending, pending = pcall(function() return party.GetPendingMembers() end)
if not okPending then return "no_api", nil end
if type(pending) == "table" then return tostring(#pending), pending end
if pending == nil then return "nil", nil end
return tostring(pending), pending
end
local okFn, fn = pcall(function() return party[apiName] end)
if not okFn or type(fn) ~= "function" then return "no_api", nil end
local ok, v = pcall(fn)
if not ok then return "api_error", nil end
if type(v) == "table" then return tostring(#v), v end
if v == nil then return "nil", nil end
return tostring(v), v
end

function GP_PartyShouldAutoAcceptInvites()
if not (config and config.partyAutoAcceptInvitesEnabled == true) then return false end
return true
end

function GP_PartyAutoAcceptBeginProbe(now)
now = tonumber(now) or GP_PartyNow()
if now < (gpPartyAutoInviteProbeCooldownUntil or 0) then return false end
gpPartyAutoInviteProbeCooldownUntil = now + 2.25
gpPartyAutoInviteProbeReadAt = now + 1.00
gpPartyAutoInviteProbeUntil = now + 8.00
pcall(function()
for i = 1, #GP_PARTY_INVITE_LOGFILE_READ_PATHS do
local f = io.open(GP_PARTY_INVITE_LOGFILE_READ_PATHS[i], "w")
if f then f:close() end
end
end)
GP_PartyRun('con_logfile "' .. GP_PARTY_INVITE_LOGFILE .. '"')
GP_PartyRun("tf_party_incoming_invites_debug")
return true
end

function GP_PartyAutoAcceptReadProbe(now)
if (gpPartyAutoInviteProbeReadAt or 0) <= 0 then return false end
now = tonumber(now) or GP_PartyNow()
if now < gpPartyAutoInviteProbeReadAt then return false end
local text = ""
for i = 1, #GP_PARTY_INVITE_LOGFILE_READ_PATHS do
pcall(function()
local f = io.open(GP_PARTY_INVITE_LOGFILE_READ_PATHS[i], "r")
if f then
local chunk = f:read("*a") or ""
f:close()
if chunk ~= "" then
text = text .. "\n" .. chunk
end
end
end)
end
local steam64 = text:match("inviter:%s*(%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+)") or text:match("steamid:%s*(%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+)")
if steam64 then
gpPartyAutoInviteProbeReadAt = 0
gpPartyAutoInviteProbeUntil = 0
GP_PartyRun('con_logfile ""')
if steam64 == gpPartyAutoInviteLastSteam64 and (now - (gpPartyAutoInviteLastAt or 0)) < 8.0 then
return false
end
local okJoin = GP_PartyRequestJoinSteam64(steam64)
if okJoin then
gpPartyAutoInviteLastAt = now
gpPartyAutoInviteLastSteam64 = steam64
AddNotification("Auto-accepted party invite", "info")
end
return okJoin == true
end
if now < (gpPartyAutoInviteProbeUntil or 0) then
gpPartyAutoInviteProbeReadAt = now + 0.30
return false
end
gpPartyAutoInviteProbeReadAt = 0
gpPartyAutoInviteProbeUntil = 0
GP_PartyRun('con_logfile ""')
return false
end

function GP_PartyAutoAcceptTick(now)
if not (config and config.partyAutoAcceptInvitesEnabled == true) then return end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
GP_PartyAutoAcceptReadProbe(now)
if (now - (gpPartyAutoAcceptStatusAt or 0)) >= 5.0 then
gpPartyAutoAcceptStatusAt = now
if (gpPartyAutoInviteProbeReadAt or 0) <= 0 then
GP_PartyAutoAcceptBeginProbe(now)
end
end
end

function GP_HandlePartyAutoAcceptGcRetrieve(_, _)
local okResult = (E_GCResults and E_GCResults.k_EGCResultOK) or 0
return okResult
end

-- Lobby/party invite acceptance port from "GhostMoney (MvM) - GP(1).lua".
-- The original invite-handling functions above are preserved exactly.
-- The source's UI toggle also ran these two initialization commands;
-- headless v64 has no Party Features menu, so activate them on startup.
local gpPartyAutoAcceptHeadlessReady = false
function GP_PartyAutoAcceptHeadlessTick(now)
    if not (config and config.partyAutoAcceptInvitesEnabled == true) then
        gpPartyAutoAcceptHeadlessReady = false
        return
    end
    now = tonumber(now) or GP_PartyNow()
    if not gpPartyAutoAcceptHeadlessReady then
        gpPartyAutoAcceptHeadlessReady = true
        GP_PartyRun("tf_party_ignore_invites 0")
        GP_PartyAutoAcceptBeginProbe(now)
    end
    GP_PartyAutoAcceptTick(now)
end

function GP_PartyEventSenderCandidates(ev, msg)
local keys = {
"steamid", "steam_id", "steamID", "steamID64", "xuid", "accountid", "account_id",
"sender", "sender_steamid", "sender_xuid", "member", "member_steamid", "userid",
"initiator", "initiator_steamid", "initiator_xuid", "caller", "caller_steamid",
"name", "sender_name", "player_name", "member_name", "param1", "param2", "param3"
}
local out = {}
for i = 1, #keys do
local k = keys[i]
local v = GP_TryGetEventString(ev, k) or GP_PartyEventIntString(ev, k)
if v and v ~= "" then out[#out + 1] = v end
end
local userKeys = {"userid", "initiator", "caller", "player", "player_userid"}
for i = 1, #userKeys do
local uid = GP_PartyEventInt(ev, userKeys[i])
if uid and entities and entities.GetByUserID then
local okEnt, ent = pcall(entities.GetByUserID, uid)
if okEnt and ent then
local methods = {"GetSteamID", "GetSteamID64", "GetName", "GetPlayerName"}
for j = 1, #methods do
local fn = ent[methods[j]]
if type(fn) == "function" then
local okV, v = pcall(fn, ent)
if okV and v ~= nil and tostring(v) ~= "" then
out[#out + 1] = tostring(v)
end
end
end
end
end
end
msg = tostring(msg or "")
for sid in msg:gmatch("STEAM_%d:%d:%d+") do out[#out + 1] = sid end
for s3 in msg:gmatch("%[U:1:%d+%]") do out[#out + 1] = s3 end
for s64 in msg:gmatch("%f[%d]%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%f[%D]") do out[#out + 1] = s64 end
local beforeColon = msg:match("^%s*(.-)%s*:%s*gp_%w+")
if beforeColon and beforeColon ~= "" then
beforeColon = beforeColon:gsub("^%s*%b[]%s*", "")
beforeColon = beforeColon:gsub("^%s*%b()%s*", "")
beforeColon = GP_PartyTrim(beforeColon)
if beforeColon ~= "" then out[#out + 1] = beforeColon end
end
return out
end

function GP_PartyFindMemberFromEvent(ev, msg)
local members = GP_PartyMembers()
if not members or #members == 0 then return nil, "party.GetMembers unavailable" end
local candidates = GP_PartyEventSenderCandidates(ev, msg)
for i = 1, #candidates do
local cc = GP_PartyCanonicalSteam(candidates[i])
if cc then
for j = 1, #members do
local member = tostring(members[j] or "")
if member ~= "" and GP_PartyCanonicalSteam(member) == cc then
return member, "matched steamid"
end
end
end
end
if #members == 2 then
local leader = GP_PartyCanonicalSteam(GP_PartyLeader() or "")
for j = 1, #members do
if GP_PartyCanonicalSteam(members[j]) ~= leader then
return tostring(members[j]), "2-member fallback"
end
end
end
return nil, "sender not matched"
end

function GP_PartyEventStartedByPartyMember(ev, msg)
local members = GP_PartyMembers()
if not members or #members == 0 then return false end
local candidates = GP_PartyEventSenderCandidates(ev, msg)
for i = 1, #candidates do
local cc = GP_PartyCanonicalSteam(candidates[i])
if cc then
for j = 1, #members do
if GP_PartyCanonicalSteam(members[j]) == cc then
return true
end
end
end
end
if party and party.GetMemberActivity then
for j = 1, #members do
local okAct, act = pcall(function() return party.GetMemberActivity(j) end)
if okAct and act then
local methods = {"GetName", "GetPersonaName", "GetPlayerName", "GetDisplayName", "GetSteamName"}
for mi = 1, #methods do
local okName, name = pcall(function()
local fn = act[methods[mi]]
if type(fn) == "function" then
return fn(act)
end
return nil
end)
if okName and name ~= nil then
local lname = string.lower(GP_PartyTrim(name))
for ci = 1, #candidates do
if lname ~= "" and lname == string.lower(GP_PartyTrim(candidates[ci])) then
return true
end
end
end
end
end
end
end
return false
end

function GP_PartyIsSteamInParty(steamID)
local members = GP_PartyMembers()
if not members or #members == 0 then return false end
local cc = GP_PartyCanonicalSteam(steamID)
if not cc then return false end
for i = 1, #members do
if GP_PartyCanonicalSteam(members[i]) == cc then
return true
end
end
return false
end

function GP_SmartVoteEntityIsPartyMember(entityID)
entityID = tonumber(entityID)
if not entityID or entityID <= 0 then return false, "no entityid" end
local steamID = nil
pcall(function()
if client and client.GetPlayerInfo then
local info = client.GetPlayerInfo(entityID)
if type(info) == "table" then
steamID = info.SteamID or info.steamID or info.steamid
end
end
end)
if (not steamID or steamID == "") and entities and entities.GetByIndex then
pcall(function()
local ent = entities.GetByIndex(entityID)
if ent then
local methods = {"GetSteamID", "GetSteamID64", "GetName", "GetPlayerName"}
for i = 1, #methods do
local fn = ent[methods[i]]
if type(fn) == "function" then
local ok, v = pcall(fn, ent)
if ok and v ~= nil and tostring(v) ~= "" then
steamID = tostring(v)
break
end
end
end
end
end)
end
if steamID and steamID ~= "" and GP_PartyIsSteamInParty(steamID) then
return true, tostring(steamID)
end
return false, tostring(steamID or "unknown")
end

function GP_SmartVoteObserveVoteCast(name, ev)
local lname = string.lower(tostring(name or ""))
if lname ~= "vote_cast" then return false end
if gpSmartVotePendingActive ~= true or (gpSmartVotePendingAttempts or 0) > 0 then return false end
local castIdx = GP_PartyEventInt(ev, "voteidx") or GP_PartyEventInt(ev, "vote_idx") or GP_PartyEventInt(ev, "voteid") or GP_PartyEventInt(ev, "vote_id")
if gpSmartVotePendingVoteIdx ~= nil and castIdx ~= nil and tonumber(gpSmartVotePendingVoteIdx) ~= tonumber(castIdx) then
return false
end
local entityID = GP_PartyEventInt(ev, "entityid") or GP_PartyEventInt(ev, "entity_id")
local voteOption = GP_PartyEventInt(ev, "vote_option") or GP_PartyEventInt(ev, "option")
if voteOption ~= 0 then
return false
end
if gpSmartVoteObservedStarterCast == true then
return false
end
gpSmartVoteObservedFirstCast = true
gpSmartVoteObservedStarterCast = true
local isParty = GP_SmartVoteEntityIsPartyMember(entityID)
if isParty then
gpSmartVotePendingOption = 1
gpSmartVotePendingLabel = "party_cast"
else
gpSmartVotePendingOption = 2
gpSmartVotePendingLabel = "random_cast"
end
return true
end

function GP_PartyRememberMemberActivity(ev, msg)
if GP_PartyEventStartedByPartyMember(ev, msg) then
gpPartyLastMemberEventAt = GP_PartyNow()
gpPartyLastMemberEventName = tostring(msg or "")
return true
end
return false
end

function GP_PartyGiveLeadToSender(ev, msg)
if not (party and party.PromoteMemberToLeader and party.GetMembers) then
AddNotification("Party gp_lead failed (party API unavailable)", "warning")
return true
end
local amLeader = GP_PartyAmLeader()
if amLeader == false then
AddNotification("Party gp_lead ignored (not party leader)", "info")
return true
end
local memberSteamID, reason = GP_PartyFindMemberFromEvent(ev, msg)
if not memberSteamID or memberSteamID == "" then
AddNotification("Party gp_lead failed (" .. tostring(reason or "sender not found") .. ")", "warning")
return true
end
local ok = pcall(function() party.PromoteMemberToLeader(memberSteamID) end)
if not ok then ok = pcall(function() party:PromoteMemberToLeader(memberSteamID) end) end
if ok then
AddNotification("Party gp_lead promoted member", "info")
else
AddNotification("Party gp_lead failed to promote", "warning")
end
return true
end

function GP_HandleSmartVoteEvent(name, ev)
if not (config and config.smartVoteEnabled == true) then return false end
local lname = string.lower(tostring(name or ""))
if lname ~= "vote_started" and lname ~= "vote_options" then return false end
local now = GP_PartyNow()
local msg = GP_TryGetEventString(ev, "text") or GP_TryGetEventString(ev, "message") or ""
local fromParty = GP_PartyEventStartedByPartyMember(ev, msg)
if not fromParty and (now - (gpPartyLastMemberEventAt or 0)) <= 3.0 then
fromParty = true
end
local voteIdx = GP_PartyEventInt(ev, "voteidx") or GP_PartyEventInt(ev, "vote_idx") or GP_PartyEventInt(ev, "voteid") or GP_PartyEventInt(ev, "vote_id")
local wantOption = fromParty and 1 or 2
if (now - (gpSmartVoteLastTrigger or 0)) < 0.10 and gpSmartVotePendingActive == true and gpSmartVotePendingOption == wantOption then
return true
end
gpSmartVoteLastTrigger = now
GP_QueueSmartVote(wantOption, fromParty and "party_event" or "waiting_cast", voteIdx)
return true
end

-- Removed in v24: Vote Revealer event callbacks
function GP_HandleAutoPartyInviteEvent(_, _)
return false
end

function GP_PartyRecordRefreshStart(now)
now = now or GP_PartyNow()
GP_PartyRun("record a")
gpPartyRecStopActive = true
gpPartyRecStopNext = now + 1.00
gpPartyRecStopUntil = now + 8.00
end

function GP_PartyRecTick(now)
if gpPartyRecStopActive ~= true then return end
now = now or GP_PartyNow()
if now >= (gpPartyRecStopUntil or 0) then
GP_PartyRun("stop")
GP_PartyRun("stop")
gpPartyRecStopActive = false
gpPartyRecStopNext = 0
gpPartyRecStopUntil = 0
return
end
if now >= (gpPartyRecStopNext or 0) then
GP_PartyRun("stop")
gpPartyRecStopNext = now + 0.50
end
end

function GP_PartyFixLagResets()
if ForceCleanup then pcall(ForceCleanup) end
local ct = nil
pcall(function() if globals and globals.CurTime then ct = globals.CurTime() end end)
if type(ct) == "number" then
lastCleanupTime = ct
cleanupFlashUntil = ct + 0.25
end
GP_PartyRun("hideconsole")
GP_PartyRun("gameui_hide")
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
end

local GP_LOOT_LINES = {}

function GP_PartySayParty(text)
text = tostring(text or "")
text = text:gsub('"', "'")
if text == "" then return false end
return GP_PartyRun('say_party "' .. text .. '"')
end

function GP_PartyDoLoot()
if gpPartyLootSeeded ~= true then
gpPartyLootSeeded = true
pcall(function() math.randomseed(math.floor((GP_PartyNow() * 1000000) % 2147483647)) end)
pcall(function() math.random(); math.random(); math.random() end)
end
local n = #GP_LOOT_LINES
if n <= 0 then return end
local idx = 1
pcall(function() idx = math.random(1, n) end)
GP_PartySayParty(GP_LOOT_LINES[idx] or GP_LOOT_LINES[1])
end

function GP_PartyFixStart(now, reason)
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
GP_PartyRecordRefreshStart(now)
GP_PartyFixLagResets()
if not gpPartyFixSwapBackPending then
gpPartyFixAimbotSnapshot = GP_TP_AimbotReadSnapshot()
if gpPartyFixAimbotSnapshot then
GP_TP_AimbotDisableFromSnapshot(gpPartyFixAimbotSnapshot)
end
pcall(function()
if client and client.Command then
client.Command("slot3", true)
end
end)
end
gpPartyFixSwapBackPending = true
gpPartyFixSwapBackAt = now + 2.0
if reason == "wave_start" then
AddNotification("Force Fix triggered", "info")
else
AddNotification("Party gp_fix received", "info")
end
end
function GP_PartyFixTick(now)
if not gpPartyFixSwapBackPending then return end
now = now or 0
if now < (gpPartyFixSwapBackAt or 0) then return end
gpPartyFixSwapBackPending = false
gpPartyFixSwapBackAt = 0
pcall(function()
if client and client.Command then
client.Command("slot1", true)
end
end)
GP_TP_AimbotForceEnable(gpPartyFixAimbotSnapshot)
gpPartyFixAimbotSnapshot = nil
end
function GP_PartyRetryStrictPreWave1()
local preWave = ((GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false)
if preWave then return true end
local wave = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local rs = GP_GetRoundState and GP_GetRoundState() or nil
local inSetup = nil
if GP_TP_IsSetupPhase then
local okSetup, vSetup = pcall(GP_TP_IsSetupPhase)
if okSetup then inSetup = vSetup end
end
if type(wave) == "number" and wave <= 1 then
if (inSetup == true) or (type(rs) == "number" and (rs == 3 or rs == 10)) then
return true
end
end
return false
end
function GP_PartyRetryPickClass()
local preWave = GP_PartyRetryStrictPreWave1()
local wantsMedicPre = (config and config.firstJoinPickMedic == true)
if preWave and wantsMedicPre then
return "medic", "pre"
end
local target = GP_GetReconnectTargetClass()
if target and target ~= "" then
return tostring(target), (preWave and "pre_target" or "post")
end
return nil, (preWave and "pre" or "post")
end
function GP_HandlePartyKillFromEvent(name, ev)
if not name then return false end
local wantsKill = (config and config.partyGpKillEnabled == true)
local wantsLeave = (config and config.partyGpLeaveEnabled == true)
local wantsFix = (config and config.partyGpFixEnabled == true)
local wantsRetry = (config and config.partyGpRetryEnabled == true)
local wantsVote = (config and config.partyGpVoteEnabled == true)
local wantsLead = (config and config.partyGpLeadEnabled == true)
local msg = GP_TryGetEventString(ev, "text")
or GP_TryGetEventString(ev, "message")
or GP_TryGetEventString(ev, "chat")
or GP_TryGetEventString(ev, "msg")
or GP_TryGetEventString(ev, "command")
or GP_TryGetEventString(ev, "param1")
or GP_TryGetEventString(ev, "param2")
if not msg then return false end
local cmd = GP_NormalizeChatCmd(msg)
local hasLoot = GP_PartyMsgHasCommand(cmd, "gp_loot")
if not wantsKill and not wantsLeave and not wantsFix and not wantsRetry and not wantsVote and not wantsLead and not hasLoot then
return false
end
local lname = string.lower(tostring(name))
if not string.find(lname, "party", 1, true) then
return false
end
GP_PartyRememberMemberActivity(ev, msg)
local hasLeave = wantsLeave and GP_PartyMsgHasCommand(cmd, "gp_leave")
local hasKill = wantsKill and GP_PartyMsgHasCommand(cmd, "gp_kill")
local hasFix = wantsFix and GP_PartyMsgHasCommand(cmd, "gp_fix")
local hasRetry = wantsRetry and GP_PartyMsgHasCommand(cmd, "gp_retry")
local hasF1 = wantsVote and GP_PartyMsgHasCommand(cmd, "gp_f1")
local hasF2 = wantsVote and GP_PartyMsgHasCommand(cmd, "gp_f2")
local hasLead = wantsLead and GP_PartyMsgHasCommand(cmd, "gp_lead")
if not hasLeave and not hasKill and not hasFix and not hasRetry and not hasF1 and not hasF2 and not hasLead and not hasLoot then
return false
end
local now = 0
pcall(function()
if globals and globals.RealTime then now = globals.RealTime()
elseif globals and globals.CurTime then now = globals.CurTime()
end
end)
if hasLeave then
if (now - (gp_partyLeaveLastTrigger or 0)) < 0.30 then
return true
end
gp_partyLeaveLastTrigger = now
pcall(function()
if gamecoordinator and gamecoordinator.AbandonMatch then
gamecoordinator.AbandonMatch()
end
end)
pcall(function()
if client and client.Command then
client.Command("disconnect", true)
end
end)
AddNotification("Party gp_leave received - abandoned and disconnected", "info")
return true
end
if hasFix then
if (now - (gp_partyFixLastTrigger or 0)) < 0.30 then
return true
end
gp_partyFixLastTrigger = now
GP_PartyFixStart(now)
return true
end
if hasF1 then
if (now - (gp_partyVoteLastTrigger or 0)) < 0.30 then
return true
end
gp_partyVoteLastTrigger = now
GP_PartyDoVote(1)
AddNotification("Party gp_f1 received - vote F1", "info")
return true
end
if hasF2 then
if (now - (gp_partyVoteLastTrigger or 0)) < 0.30 then
return true
end
gp_partyVoteLastTrigger = now
GP_PartyDoVote(2)
AddNotification("Party gp_f2 received - vote F2", "info")
return true
end
if hasLead then
if (now - (gp_partyLeadLastTrigger or 0)) < 0.30 then
return true
end
gp_partyLeadLastTrigger = now
GP_PartyGiveLeadToSender(ev, msg)
return true
end
if hasLoot then
GP_PartyDoLoot()
return true
end
if hasRetry then
if (now - (gp_partyRetryLastTrigger or 0)) < 0.30 then
return true
end
gp_partyRetryLastTrigger = now
local retryClass = GP_PartyRetryPickClass()
if retryClass and retryClass ~= "" then
GP_ArmReconnectClassPending(retryClass, now)
pcall(function()
if client and client.Command then
client.Command("joinclass " .. tostring(retryClass), true)
if retryClass == "medic" then
client.Command("join_class medic", true)
client.Command("joinclass 5", true)
end
GP_ArmClassSelectClose(now, retryClass)
end
end)
end
GP_IssueRetryWithAutoClass(retryClass)
if retryClass and retryClass ~= "" then
AddNotification("Party gp_retry received - retry (" .. tostring(retryClass) .. ")", "info")
else
AddNotification("Party gp_retry received - retry", "info")
end
return true
end
if hasKill then
if (now - (gp_partyKillLastTrigger or 0)) < 0.30 then
return true
end
gp_partyKillLastTrigger = now
pcall(function()
if client and client.Command then
client.Command("kill", true)
end
end)
AddNotification("Party gp_kill received - killbind used", "info")
return true
end
return false
end
pcall(function()
if client and client.AllowListener then
client.AllowListener("party_chat")
client.AllowListener("party_message")
client.AllowListener("party_member_chat")
client.AllowListener("vote_started")
client.AllowListener("vote_options")
client.AllowListener("vote_changed")
client.AllowListener("vote_cast")
client.AllowListener("vote_ended")
client.AllowListener("vote_passed")
client.AllowListener("vote_failed")
client.AllowListener("player_disconnect")
client.AllowListener("mvm_begin_wave")
client.AllowListener("mvm_wave_complete")
client.AllowListener("mvm_wave_failed")
client.AllowListener("teamplay_round_win")
client.AllowListener("teamplay_restart_round")
client.AllowListener("mvm_mission_complete")
client.AllowListener("mvm_reset_stats")
client.AllowListener("mvm_wave_start")
end
end)
callbacks.Register("FireGameEvent", __GM_CALLBACK_IDS.fireGameEvent, function(e)
local ok, name = pcall(function() return e:GetName() end)
if ok and name then
GP_PartyRememberVoteFromEvent(name, e)
GP_HandleSmartVoteEvent(name, e)
GP_SmartVoteObserveVoteCast(name, e)
GP_HandleAutoPartyInviteEvent(name, e)
local lname = string.lower(tostring(name))
GP_HandlePartyKillFromEvent(name, e)
GP_AutoDisconnectOnEvent(name, e)
GP_RST_OnEvent(name, e)
GP_EB_OnEvent(name, e)
end
end)
end
__GM_PART3__()

function __GM_PART4__()
-- Mirror the source's Draw-loop monitoring: works in the lobby, not only in a match.
callbacks.Register("Draw", __GM_CALLBACK_IDS.draw, function()
    if GP_PartyAutoAcceptHeadlessTick then
        GP_PartyAutoAcceptHeadlessTick((globals and globals.RealTime and globals.RealTime()) or 0)
    end
end)
callbacks.Register("CreateMove", __GM_CALLBACK_IDS.engiSetupInput, GP_EB_SetupInputBefore)
callbacks.Register("CreateMove", __GM_CALLBACK_IDS.createMove, function(cmd)
local currentTime = globals.CurTime()
GP_HandleCurTimeRewind(currentTime)
GP_PartyFixTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_PartyRecTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_PartyVoteRetryTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_SmartVoteTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
if GP_PartyAutoAcceptHeadlessTick then
    GP_PartyAutoAcceptHeadlessTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
end
GP_ClassSelectCloseTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
if type(currentTime) == "number" then
if (sniperIgnoreShortToggleUntil or 0) > (currentTime + 3.0) then
sniperIgnoreShortToggleUntil = 0
sniperSkipNextShortToggle = false
sniperBlockShortToggleOnRelease = false
sniperHotkeyHoldDown = false
sniperHotkeyHoldStart = 0
sniperHotkeyHoldTriggered = false
end
if (tpIgnoreShortToggleUntil or 0) > (currentTime + 3.0) then
tpIgnoreShortToggleUntil = 0
tpSkipNextShortToggle = false
tpHotkeyHoldDown = false
tpHotkeyHoldStart = 0
tpHotkeyHoldTriggered = false
tpLastForceToggleAt = 0
end
end
CheckServerChange()
GP_AutoDisconnectTick()
GP_RST_TickState()
GP_RST_TickQueuedStart()
local me = entities.GetLocalPlayer()
GP_EB_SessionTick()
GP_EB_WaveTick(me, currentTime)
GP_EB_CanteenTick(me, currentTime)
GP_HandleInstantRespawn(me)
GP_TP_HandleAimbotSuppression(currentTime)
GP_TP_TickUseVerify(me, currentTime)
GP_F4_Sync("tick", false)
-- Post-buy Wave 1 navigation runs here so the other GhostMoney tick systems
-- (especially Smart AutoF4) continue to run normally.
GP_EB_MannhattanWave1RouteAutoStart()
local gpEngiWave1RouteOwnsMovement = GP_EB_MannhattanWave1RouteActive()
-- A queued Rottenburg rebuild has priority over ordinary TpWalk.
if GP_EB_RottenburgRepairNeedsTime and GP_EB_RottenburgRepairNeedsTime() then
    gpEngiWave1RouteOwnsMovement = true
    if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
end
autoModeWalkActive = false
config._autoModeVacWarned = false
if not (config and config.autoWalkEnabled) then
thresholdNotificationShown = false
medicThresholdReached = false
hasTriedClassChange = false
pendingClassChange = false
classChangeUsePreWaveRules = false
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = 0
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
if GP_RST then
GP_RST.medicCycleHardResetPending = false
GP_RST.medicCycleHardResetSince = 0
GP_RST.medicCycleSwapLockUntil = 0
end
end
local gpMedicHardResetPending = (GP_RST and GP_RST.medicCycleHardResetPending == true) or false
if me and config and config.autoWalkEnabled and config.changeClassEnabled and (not gpMedicHardResetPending) and (not isExploiting) and (not pendingClassChange) and (
(thresholdNotificationShown == true)
or (medicThresholdReached == true)
or IsMoneyThresholdReached()
or GP_ShouldAllowPostWaveStationSwapWithoutThreshold(me)
) then
local postWaveRestrictedRearm = GP_IsPostWaveSwapRestricted()
if postWaveRestrictedRearm then
local strictTargetRearm = GP_GetPostWaveStationSwapTarget(me)
if strictTargetRearm and strictTargetRearm ~= "" then
local currentClassRearm = GP_GetCurrentClassName(me)
if currentClassRearm ~= strictTargetRearm then
hasTriedClassChange = false
pendingClassChange = true
classChangeUsePreWaveRules = false
classChangeSwapPopupShown = false
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = (currentTime or 0) + 0.05
end
end
end
end
if me and config and config.autoWalkEnabled and config.changeClassEnabled and (not gpMedicHardResetPending) and (not isExploiting) and pendingClassChange and currentTime >= classChangeReadyTime and (
(thresholdNotificationShown == true)
or (medicThresholdReached == true)
or IsMoneyThresholdReached()
or GP_ShouldAllowPostWaveStationSwapWithoutThreshold(me)
) then
local inZone = (me:GetPropInt('m_bInUpgradeZone') == 1)
local finalized = false
local swapTargetClass = config and config.targetClass or nil
local postWaveRestricted = GP_IsPostWaveSwapRestricted()
if classChangeUsePreWaveRules then
local definitelyPostWave = GP_UpdatePostWaveSwapLatch and GP_UpdatePostWaveSwapLatch() or false
if definitelyPostWave then
classChangeUsePreWaveRules = false
postWaveRestricted = true
else
postWaveRestricted = false
end
end
if postWaveRestricted then
local postWaveTarget, postWaveReason = GP_GetPostWaveStationSwapTarget(me)
if postWaveReason == "not_medic" then
AddNotification("Auto class change skipped (after Wave 1 only from Medic)", "info")
finalized = true
elseif postWaveReason == "invalid_target" then
AddNotification("Auto class change skipped (target class is OFF/Medic/invalid)", "warning")
finalized = true
elseif postWaveReason == "not_in_upgrade" then
classChangeReadyTime = currentTime + 0.35
return
elseif postWaveTarget then
swapTargetClass = postWaveTarget
else
finalized = true
end
end
if (not finalized) and ((not swapTargetClass) or swapTargetClass == "") then
AddNotification("Threshold reached but no target class set", "warning")
finalized = true
end
if (not finalized) and IsMvMWaveActive() then
classChangeReadyTime = currentTime + 0.35
if inZone and IsMedic(me) and (currentTime - (lastRetryTime or 0)) > RETRY_COOLDOWN then
local retryTarget
if not postWaveRestricted then
retryTarget = (swapTargetClass or (config and config.targetClass) or nil)
else
retryTarget = swapTargetClass
end
if retryTarget and retryTarget ~= "" then
AddNotification("Wave active - retrying to change class", "warning")
lastRetryTime = currentTime
pendingRetry = true
pendingRetryTargetClass = tostring(retryTarget)
pendingRetryTargetUntil = currentTime + 90.0
GP_IssueRetryWithAutoClass(retryTarget)
end
end
return
end
if not finalized then
local allowRefund = (not postWaveRestricted)
if allowRefund and inZone and (not classChangeDidRefund) then
pcall(engine.SendKeyValues, '"MVM_Respec" {}')
classChangeDidRefund = true
classChangeRefundTime = currentTime
classChangeReadyTime = currentTime + 0.12
return
end
if not classChangeDidCleanup then
ForceCleanup()
classChangeDidCleanup = true
classChangeCleanupTime = currentTime
classChangeReadyTime = currentTime + 0.08
return
end
local currentClassNow = GP_GetCurrentClassName(me)
if currentClassNow == swapTargetClass then
AddNotification("Already playing " .. tostring(swapTargetClass), "info")
finalized = true
else
client.Command("joinclass " .. tostring(swapTargetClass), true)
GP_ArmClassSelectClose(currentTime, swapTargetClass)
if not classChangeSwapPopupShown then
AddNotification("Changed class to " .. tostring(swapTargetClass), "success")
classChangeSwapPopupShown = true
end
finalized = true
end
end
if finalized then
hasTriedClassChange = true
pendingClassChange = false
classChangeUsePreWaveRules = false
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
else
classChangeReadyTime = currentTime + 0.25
end
end
if not me then return end
do
if gpFirstJoinPickMedicPending then
local nowFJ = GP_ReconnectNow()
if nowFJ > (gpFirstJoinPickMedicUntil or 0) then
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
GP_ArmReconnectClassPending(GP_GetReconnectTargetClass(), nowFJ)
else
local preWaveJoin = ((GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false)
if not preWaveJoin then
local waveJoin = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local rsJoin = GP_GetRoundState and GP_GetRoundState() or nil
local inSetupJoin = nil
if GP_TP_IsSetupPhase then
local okSetupJoin, vSetupJoin = pcall(GP_TP_IsSetupPhase)
if okSetupJoin then
inSetupJoin = vSetupJoin
end
end
if type(waveJoin) == "number" and waveJoin <= 1 then
if (inSetupJoin == true) or (type(rsJoin) == "number" and (rsJoin == 3 or rsJoin == 10)) then
preWaveJoin = true
end
end
end
if preWaveJoin then
local clsNowFJ = GP_GetCurrentClassName(me)
if gpRetryJoinClassMustIssue or clsNowFJ ~= "medic" then
client.Command("joinclass medic", true)
client.Command("join_class medic", true)
client.Command("joinclass 5", true)
GP_ArmClassSelectClose(nowFJ, "medic")
GP_ArmReconnectFeatureRearm("medic", nowFJ)
end
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
GP_ClearReconnectClassPending()
else
local waveConsume = GP_GetWaveNumber and GP_GetWaveNumber() or nil
local rsConsume = GP_GetRoundState and GP_GetRoundState() or nil
local liveSeenConsume = (GP_RST and GP_RST.liveSeen) or false
local postJoinFallbackReady = (gpFirstJoinPickMedicFallbackAt or 0) > 0 and nowFJ >= (gpFirstJoinPickMedicFallbackAt or 0)
if liveSeenConsume or (type(waveConsume) == "number" and waveConsume >= 2) or (type(rsConsume) == "number" and rsConsume == 4) or postJoinFallbackReady then
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
GP_ArmReconnectClassPending(GP_GetReconnectTargetClass(), nowFJ)
end
end
end
end
do
local nowRetryJoin = GP_ReconnectNow()
if gpRetryJoinClassPending and gpRetryJoinClassPending ~= "" then
if nowRetryJoin > (gpRetryJoinClassUntil or 0) then
GP_ClearReconnectClassPending()
else
local wantRetryClass = tostring(gpRetryJoinClassPending)
local clsRetryNow = GP_GetCurrentClassName(me)
if clsRetryNow == wantRetryClass and not gpRetryJoinClassMustIssue then
GP_ClearReconnectClassPending()
else
if nowRetryJoin >= (gpRetryJoinClassNextTry or 0) then
pcall(function()
if client and client.Command then
client.Command("joinclass " .. tostring(wantRetryClass), true)
if wantRetryClass == "medic" then
client.Command("join_class medic", true)
client.Command("joinclass 5", true)
end
GP_ArmClassSelectClose(nowRetryJoin, wantRetryClass)
GP_ArmReconnectFeatureRearm(wantRetryClass, nowRetryJoin)
end
end)
gpRetryJoinClassMustIssue = false
gpRetryJoinClassNextTry = nowRetryJoin + 0.50
end
end
end
end
end
GP_TickReconnectFeatureRearm(me, currentTime)
local cls = GP_GetCurrentClassName(me)
if tpLastKnownClassName == nil then
tpLastKnownClassName = cls
elseif cls and tpLastKnownClassName and cls ~= tpLastKnownClassName then
local hadTraversalBeforeSwap = (GP_TP_IsTraversalActive and GP_TP_IsTraversalActive()) or false
if hadTraversalBeforeSwap then
if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
if GP_TP_ResetStuckTracker then pcall(GP_TP_ResetStuckTracker) end
tpClassSwapUnlockUntil = (currentTime or 0) + 1.25
end
local rearmTime = currentTime - (TELEPORTER_AUTOWALK_DELAY or 1.0)
local ip = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
if ip == "" then ip = currentServer or "" end
if tpForceModeEnabled then
tpToggleNeedsTrigger = false
tpStickyArmed = true
tpStickyServerIP = ip
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = rearmTime
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
if tpForceRestoreAwaitRespawn then
tpRespawnRearmPending = true
AddNotification("Class switch detected - Force TpWalk still waiting for respawn", "info")
else
tpRespawnRearmPending = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
reloadMoveLock = false
AddNotification("Class switch detected - Force TpWalk re-armed", "success")
end
elseif (config and config.tpWalkEnabled) and cls == "engineer" then
tpForceRestoreAwaitRespawn = false
tpRespawnRearmPending = false
tpToggleNeedsTrigger = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpStickyArmed = true
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = rearmTime
tpStickyServerIP = ip
reloadMoveLock = false
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
AddNotification("Class switch to Engineer detected - TpWalk re-armed", "success")
end
if cls == "engineer"
and config and config.autoBuyEnabled
and (not forceSniperBuyModeEnabled)
and sniperReloadAwaitRespawn
and GP_ShouldSniperBuyArmImmediately() then
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
end
tpLastKnownClassName = cls
else
tpLastKnownClassName = cls or tpLastKnownClassName
end
end
local canAutoMoveNow = GP_IsReloadMoveUnlocked(me)
if (not gpEngiWave1RouteOwnsMovement) and GP_TP_IsMoveLockActive() and IsManualMoveInput() then
local tpPendingRearmNow = (tpRespawnRearmPending == true)
or (tpForceRestoreAwaitRespawn == true)
or (tpWaitForRoundReload == true)
or (tpToggleSpawnLock == true)
or ((not (teleporterConfig and teleporterConfig.autoWalkEnabled == true))
and (sniperUpgradeCompletedTime or 0) > 0
and ((currentTime - (sniperUpgradeCompletedTime or 0)) < (TELEPORTER_AUTOWALK_DELAY or 1.0)))
if tpPendingRearmNow then
GP_TP_ApplyMovementLock(cmd)
end
end
local hasVacc = HasVaccinator(me)
local gpMedicSwapLockedNow = (GP_RST and GP_RST.medicCycleHardResetPending == true) or false
if gpMedicSwapLockedNow then
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
pendingClassChange = false
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
end
if needToLeaveZone and (config and config.autoWalkEnabled) and (not gpMedicSwapLockedNow) and (not isExploiting) then
if me:GetPropInt('m_bInUpgradeZone') == 1 then
if leaveZoneStartPos then
if not IsManualMoveInput() then
cmd:SetForwardMove(-450)
end
end
else
if leaveZoneTime == 0 then
leaveZoneTime = currentTime
AddNotification("Waiting before class change", "info")
end
if currentTime - leaveZoneTime >= 0.5 then
local didSwap = false
local postWaveRestricted = GP_IsPostWaveSwapRestricted()
local swapTargetClass = config and config.targetClass or nil
local allowSwap = true
if postWaveRestricted then
local strictTarget = GP_GetPostWaveStationSwapTarget(me)
if strictTarget and strictTarget ~= "" then
swapTargetClass = strictTarget
else
allowSwap = false
end
end
if allowSwap and swapTargetClass and swapTargetClass ~= "" then
if GP_GetCurrentClassName(me) == swapTargetClass then
AddNotification("Already playing " .. tostring(swapTargetClass), "info")
else
client.Command("joinclass " .. tostring(swapTargetClass), true)
GP_ArmClassSelectClose(currentTime, swapTargetClass)
didSwap = true
end
end
hasTriedClassChange = true
pendingClassChange = false
classChangeUsePreWaveRules = false
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
if didSwap and swapTargetClass and (not classChangeSwapPopupShown) then AddNotification("Changed class to " .. tostring(swapTargetClass), "success"); classChangeSwapPopupShown = true end
end
end
end
if pendingRetry and (config and config.autoWalkEnabled) and (not gpMedicSwapLockedNow) and (not isExploiting) then
if entities.GetLocalPlayer() then
pendingRetry = false
local nowRetry = currentTime or ((globals and globals.CurTime and globals.CurTime()) or 0)
local swapTargetClass
local postWaveRetryRestricted = GP_IsPostWaveSwapRestricted()
local cachedRetryTarget = nil
if pendingRetryTargetClass and (pendingRetryTargetClass ~= "") and ((pendingRetryTargetUntil or 0) >= nowRetry) then
cachedRetryTarget = tostring(pendingRetryTargetClass)
end
if not postWaveRetryRestricted then
swapTargetClass = cachedRetryTarget
if (not swapTargetClass) or swapTargetClass == "" then
swapTargetClass = (config and config.targetClass) or nil
end
else
local allowRetryBypass = ((lastRetryTime or 0) > 0) and ((nowRetry - (lastRetryTime or 0)) <= 20.0)
if allowRetryBypass then
local strictValidTarget = GP_GetPostWaveAutoCreditTargetClass and GP_GetPostWaveAutoCreditTargetClass() or nil
if cachedRetryTarget and strictValidTarget and (cachedRetryTarget == strictValidTarget) then
swapTargetClass = cachedRetryTarget
else
swapTargetClass = GP_GetPostWaveStationSwapTarget(me)
end
else
swapTargetClass = GP_GetPostWaveStationSwapTarget(me)
end
end
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
if swapTargetClass and swapTargetClass ~= "" then
if GP_GetCurrentClassName(me) == swapTargetClass then
AddNotification("Already playing " .. tostring(swapTargetClass), "info")
else
client.Command("joinclass " .. tostring(swapTargetClass), true)
GP_ArmClassSelectClose(nowRetry, swapTargetClass)
if not classChangeSwapPopupShown then
AddNotification("Changed class to " .. tostring(swapTargetClass), "success")
classChangeSwapPopupShown = true
end
end
else
if not postWaveRetryRestricted then
AddNotification("Retry done, but no valid target class configured", "warning")
else
AddNotification("Retry class swap skipped (after Wave 1 requires Medic in upgrade station + valid target class)", "info")
end
end
end
return
end
do
local sbNeedsRearm = (config and config.autoBuyEnabled and (not forceSniperBuyModeEnabled))
if sniperReloadAwaitRespawn and sbNeedsRearm and me then
local aliveNowSB = me:IsAlive()
if sniperLastAliveState == nil then
sniperLastAliveState = aliveNowSB
if not aliveNowSB then
sniperReloadRespawnPending = true
end
end
if sniperLastAliveState and (not aliveNowSB) then
sniperReloadRespawnPending = true
if isUpgradingSniper then
isUpgradingSniper = false
upgradeQueue = {}
end
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
forceSniperBuyZoneLatch = false
elseif (not sniperLastAliveState) and aliveNowSB and sniperReloadRespawnPending then
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
end
sniperLastAliveState = aliveNowSB
else
sniperReloadRespawnPending = false
if not sbNeedsRearm then
sniperReloadAwaitRespawn = false
end
if me then
sniperLastAliveState = me:IsAlive()
else
sniperLastAliveState = nil
end
end
end
do
local inZoneFS = false
if me and me.GetPropInt then
inZoneFS = (me:GetPropInt('m_bInUpgradeZone') == 1)
end
if forceSniperBuyModeEnabled and (not sniperReloadAwaitRespawn) and me and me:IsAlive() and GP_IsEngineer(me) and (not isExploiting) and (not (GP_RST_IsTransitionLockActive and GP_RST_IsTransitionLockActive())) then
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
if inZoneFS then
if not forceSniperBuyZoneLatch then
forceSniperBuyZoneLatch = true
forceSniperBuyLastTry = currentTime
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
TriggerSniperUpgrades()
elseif (not isUpgradingSniper) and ((not upgradeQueue) or (#upgradeQueue == 0)) and (not sniperUpgradesComplete) then
if (currentTime - (forceSniperBuyLastTry or 0)) >= 1.0 then
forceSniperBuyLastTry = currentTime
TriggerSniperUpgrades()
end
end
else
forceSniperBuyZoneLatch = false
end
else
forceSniperBuyZoneLatch = false
end
end
if config.autoBuyEnabled and (not forceSniperBuyModeEnabled) and (not sniperReloadAwaitRespawn) and (gpPhase == "SNIPER_BUY") and (not autobuyRunOnceDone) then
if sniperUpgradesComplete then
autobuyRunOnceDone = true
if not autobuyDoneAnnounced then
AddNotification("EngiBuy run complete (this mission). Toggle EngiBuy OFF/ON to run again", "success")
autobuyDoneAnnounced = true
end
end
end
if (not gpEngiWave1RouteOwnsMovement) and config.autoBuyEnabled and (not forceSniperBuyModeEnabled) and (not sniperReloadAwaitRespawn) and (not autobuyRunOnceDone) and me and me:IsAlive() and GP_IsEngineer(me) and (not isExploiting) and canAutoMoveNow and (not (GP_RST_IsTransitionLockActive and GP_RST_IsTransitionLockActive())) then
local inZone = me:GetPropInt('m_bInUpgradeZone') == 1
if inZone then
if shouldGuidePlayerBuy then
AddNotification("EngiBuy: reached upgrade station", "success")
end
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
sniperBuyWalkStartTime = 0
if config.autoBuyEnabled and (not sniperUpgradesComplete) then
TriggerSniperUpgrades()
end
else
local newMidpoint = FindUpgradeStations(me)
local inSpawnArea = IsInSniperBuySpawnArea(me)
if newMidpoint and inSpawnArea then
buyMidpoint = newMidpoint
if not shouldGuidePlayerBuy then
shouldGuidePlayerBuy = true
sniperBuyWalkStartTime = currentTime
elseif (sniperBuyWalkStartTime or 0) <= 0 then
sniperBuyWalkStartTime = currentTime
end
local walkTimedOut = ((sniperBuyWalkStartTime or 0) > 0) and ((currentTime - (sniperBuyWalkStartTime or currentTime)) >= (SNIPER_BUY_WALK_TIMEOUT or 10.0))
local canKillNow = (currentTime >= (sniperBuyWalkKillCooldownUntil or 0))
if walkTimedOut and canKillNow then
AddNotification("EngiBuy: station not reached in 10s - suiciding reset", "warning")
pcall(function()
if client and client.Command then
client.Command("kill", true)
end
end)
sniperBuyWalkKillCooldownUntil = currentTime + (SNIPER_BUY_WALK_KILL_COOLDOWN or 4.0)
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
sniperBuyWalkStartTime = 0
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
autobuyRunOnceDone = false
autobuyDoneAnnounced = false
sniperReloadAwaitRespawn = true
sniperReloadRespawnPending = true
sniperLastAliveState = false
isUpgradingSniper = false
upgradeQueue = {}
else
WalkTo(cmd, me, buyMidpoint)
end
else
if shouldGuidePlayerBuy and (not inSpawnArea) then
AddNotification("EngiBuy: stopped (left spawn room)", "info")
end
shouldGuidePlayerBuy = false
buyMidpoint = nil
sniperBuyWalkStartTime = 0
if not inSpawnArea then
buySpawnAnchor = nil
medicSpawnAnchor = nil
end
end
end
else
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
sniperBuyWalkStartTime = 0
end
do
local inZone_now = false
if me and me.GetPropInt then
inZone_now = (me:GetPropInt('m_bInUpgradeZone') == 1)
end
if config.autoWalkEnabled and me and not (misc and misc.acStartedOnce) then
local wave_now = GP_GetWaveNumber()
local rs_now = GP_GetRoundState()
local preWave_now = ((GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false)
if not preWave_now then
local inSetup_fallback = nil
if GP_TP_IsSetupPhase then
local okSetup, vSetup = pcall(GP_TP_IsSetupPhase)
if okSetup then
inSetup_fallback = vSetup
end
end
if type(wave_now) == "number" and wave_now <= 1 then
if (inSetup_fallback == true) or (type(rs_now) == "number" and (rs_now == 3 or rs_now == 10)) then
preWave_now = true
end
end
end
local class_map = GP_CLASS_NAME
local class_now = nil
local class_selected_now = false
local cls_id = nil
if me and me.GetPropInt then
local okCls, vCls = pcall(function() return me:GetPropInt("m_iClass") end)
if okCls and type(vCls) == "number" then
cls_id = vCls
end
end
if type(cls_id) == "number" and cls_id >= 1 and cls_id <= 9 then
class_now = class_map[cls_id]
class_selected_now = true
else
local desired_id = nil
if me and me.GetPropInt then
local okD1, vD1 = pcall(function() return me:GetPropInt("m_Shared.m_iDesiredPlayerClass") end)
if okD1 and type(vD1) == "number" then
desired_id = vD1
end
if (not desired_id or desired_id <= 0) then
local okD2, vD2 = pcall(function() return me:GetPropInt("m_Shared", "m_iDesiredPlayerClass") end)
if okD2 and type(vD2) == "number" then
desired_id = vD2
end
end
if (not desired_id or desired_id <= 0) then
local okD3, vD3 = pcall(function() return me:GetPropInt("m_iDesiredPlayerClass") end)
if okD3 and type(vD3) == "number" then
desired_id = vD3
end
end
end
if type(desired_id) == "number" and desired_id >= 1 and desired_id <= 9 then
class_now = class_map[desired_id]
class_selected_now = true
end
end
if (not class_selected_now) and GP_GetCurrentClassName then
local fallback_class = GP_GetCurrentClassName(me)
if type(fallback_class) == "string" and fallback_class ~= "" then
class_now = fallback_class
class_selected_now = true
end
end
local prev_class = misc.acWarnPrevClassName
local prev_vacc = misc.acWarnPrevHasVacc
local prev_selected = misc.acWarnPrevClassSelected
if preWave_now then
local initial_snapshot = (prev_class == nil or prev_vacc == nil or prev_selected == nil)
local class_changed = (prev_class ~= nil and class_now ~= prev_class)
local vacc_changed = (prev_vacc ~= nil and hasVacc ~= prev_vacc)
local selected_changed = (prev_selected ~= nil and class_selected_now ~= prev_selected)
if class_selected_now and (initial_snapshot or class_changed or vacc_changed or selected_changed) then
if class_now ~= "medic" then
if not misc.acWarnSeenNoMedic then
AddNotification("Select Medic with Vaccinator for AutoCredit", "warning", 4.0)
misc.acWarnSeenNoMedic = true
end
elseif not hasVacc then
if not misc.acWarnSeenNoVacc then
AddNotification("Vaccinator not equipped for AutoCredit", "warning", 4.0)
misc.acWarnSeenNoVacc = true
end
end
end
end
misc.acWarnPrevClassName = class_now
misc.acWarnPrevHasVacc = (hasVacc and true or false)
misc.acWarnPrevClassSelected = (class_selected_now and true or false)
else
misc.acWarnPrevClassName = nil
misc.acWarnPrevHasVacc = nil
misc.acWarnPrevClassSelected = nil
end
end
do
local aliveNow = me:IsAlive()
local classNow = GP_GetCurrentClassName(me)
local isSniperNow = (classNow == "engineer") -- legacy variable name; normal TpWalk belongs to Engineer
local normalModeActive = (config and config.tpWalkEnabled) and (not tpForceModeEnabled)
local normalRespawnRelevant = normalModeActive and isSniperNow
local forceRespawnRelevant = tpForceModeEnabled and (GP_TP_IsArmedAndAllowed() or tpForceRestoreAwaitRespawn)
local initAliveWithPending = false
if tpLastAliveState == nil then
if aliveNow and tpRespawnRearmPending then
initAliveWithPending = true
end
tpLastAliveState = aliveNow
if (not aliveNow) and (tpForceRestoreAwaitRespawn or (normalRespawnRelevant and (tpToggleNeedsTrigger or sniperUpgradeCompleted))) then
tpRespawnRearmPending = true
end
end
local trackRespawn = forceRespawnRelevant
or (normalRespawnRelevant and (tpToggleNeedsTrigger or sniperUpgradeCompleted))
if trackRespawn then
if tpLastAliveState and (not aliveNow) then
tpRespawnRearmPending = true
teleporterConfig.autoWalkEnabled = false
GP_TP_ResetPathState()
if tpForceModeEnabled then
AddNotification("Force TpWalk pending re-arm, please wait", "warning", 4.0)
else
AddNotification("TpWalk pending re-arm, please wait", "warning")
end
elseif (initAliveWithPending or ((not tpLastAliveState) and aliveNow and tpRespawnRearmPending)) then
tpRespawnRearmPending = false
teleporterJustUsed = false
sniperUpgradeCompletedTime = currentTime - (TELEPORTER_AUTOWALK_DELAY or 1.0)
teleporterConfig.autoWalkEnabled = false
if tpForceRestoreAwaitRespawn then
if tpWaitForRoundReload then
reloadMoveLock = true
else
tpForceRestoreAwaitRespawn = false
tpToggleSpawnLock = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpStickyArmed = true
teleporterManuallyDisabled = false
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = currentTime - (TELEPORTER_AUTOWALK_DELAY or 1.0)
teleporterJustUsed = false
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpTeleporterSeenCount = (TP_TELE_STABLE_SCANS or 8)
reloadMoveLock = false
end
end
if (config and config.tpWalkEnabled) and tpToggleNeedsTrigger and isSniperNow then
tpToggleNeedsTrigger = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = currentTime - (TELEPORTER_AUTOWALK_DELAY or 1.0)
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
reloadMoveLock = false
end
GP_TP_ResetPathState()
if tpForceModeEnabled then
if not tpForceRestoreAwaitRespawn then
AddNotification("Respawn detected - Force TpWalk re-armed", "success")
end
end
end
else
tpRespawnRearmPending = false
end
if tpForceModeEnabled and (tpStickyArmed ~= true) then
tpStickyArmed = true
end
tpLastAliveState = aliveNow
end
if sniperUpgradesComplete and (not sniperUpgradeCompleted) and (not tpToggleNeedsTrigger) then
GP_OnSniperUpgradesComplete("sync")
end
tpHoldForSniperBuy = false
local tpHoldForAutoCredit = false
do
local tpAnyModeEnabled = (tpForceModeEnabled == true) or ((config and config.tpWalkEnabled) == true)
local tpNormalModeEnabled = ((not tpForceModeEnabled) and ((config and config.tpWalkEnabled) == true))
local curClsName = GP_GetCurrentClassName(me)
local sniperBuyPending = (curClsName == "engineer")
and (config and config.autoBuyEnabled)
and (not forceSniperBuyModeEnabled)
and (not sniperReloadAwaitRespawn)
and (not autobuyRunOnceDone)
and (not sniperUpgradesComplete)
local rstAutoCreditPending = false
if config and config.autoWalkEnabled and GP_RST then
local rstNow = GP_RST_Now()
if GP_RST.medicCycleHardResetPending == true then
rstAutoCreditPending = true
elseif ((GP_RST.kind == "vote") or (GP_RST.kind == "fail")) and (rstNow < (GP_RST.contextUntil or 0)) then
rstAutoCreditPending = true
elseif (GP_RST.queueAt or 0) > 0 then
rstAutoCreditPending = true
end
end
local autoCreditPending = (config and config.autoWalkEnabled) and rstAutoCreditPending
if tpAnyModeEnabled and sniperBuyPending then
tpHoldForSniperBuy = true
end
if tpNormalModeEnabled and autoCreditPending then
tpHoldForAutoCredit = true
end
end
local forceBypassSniperBuyHold = false
local forceBypassAutoCreditHold = (tpForceModeEnabled == true)
local rstTransitionBlocked = false
if GP_RST then
local rstNow = (GP_RST_Now and GP_RST_Now()) or currentTime
if rstNow < (GP_RST.detectGlobalUntil or 0) then
rstTransitionBlocked = true
elseif ((GP_RST.kind == "vote") or (GP_RST.kind == "fail")) and (rstNow < (GP_RST.contextUntil or 0)) then
if tpWaitForRoundReload or tpForceRestoreAwaitRespawn or ((GP_RST.queueAt or 0) > rstNow) then
rstTransitionBlocked = true
end
end
end
if rstTransitionBlocked then
if teleporterConfig and teleporterConfig.autoWalkEnabled then
teleporterConfig.autoWalkEnabled = false
end
tpNoTeleFallbackActive = false
if GP_TP_StopUseVerify then pcall(GP_TP_StopUseVerify) end
if GP_TP_ResetPathState then pcall(GP_TP_ResetPathState) end
end
local allowTpWalkNow = ((forceBypassSniperBuyHold or (not tpHoldForSniperBuy)) and (forceBypassAutoCreditHold or (not tpHoldForAutoCredit)) and (not rstTransitionBlocked))
if (not gpEngiWave1RouteOwnsMovement) and allowTpWalkNow and GP_TP_IsArmedAndAllowed() and me and me:IsAlive() and canAutoMoveNow and GP_TP_IsToggleSpawnUnlocked(me) then
if GP_TP_IsMoveLockActive() and IsManualMoveInput() then
GP_TP_ApplyMovementLock(cmd)
end
if tpForceModeEnabled or GP_IsEngineer(me) then
if (not teleporterConfig.autoWalkEnabled) and (not teleporterManuallyDisabled) and sniperUpgradeCompletedTime > 0 then
if (currentTime - sniperUpgradeCompletedTime) >= TELEPORTER_AUTOWALK_DELAY then
if GP_TP_ResetPathState then GP_TP_ResetPathState() end
teleporterConfig.autoWalkEnabled = true
teleporterJustUsed = false
AddNotification("TpWalk: searching for teleporter", "info")
end
end
if teleporterConfig.autoWalkEnabled then
local tpMapName = GP_TP_GetCurrentMap()
if currentTime >= nextTeleporterScanTime then
GP_TP_ScanForTeleporters(me)
nextTeleporterScanTime = currentTime + teleporterScanInterval
end
local activeTeleporterCandidates = foundTeleporters
local waitingAtEndpoint
do
waitingAtEndpoint = (tpIsWaitingForTeleporter == true)
if (not waitingAtEndpoint) and tpNoTeleFallbackActive then
waitingAtEndpoint = (GP_TP_GetCurrentPathWaypoint() == nil)
end
local endpointFilterRequired = waitingAtEndpoint
local endpointFilterRadius = (TP_ENDPOINT_TELE_RADIUS or 650)
if endpointFilterRequired then
local endpointPos = nil
local pths = mapPaths[tpMapName]
local endpointPathIndex = tpCurrentPathIndex
if (not endpointPathIndex) and me and me.GetAbsOrigin then
local myP = me:GetAbsOrigin()
if myP then
endpointPathIndex = GP_TP_ChooseBestPath(myP, tpMapName)
end
end
if pths and endpointPathIndex and pths[endpointPathIndex] and #pths[endpointPathIndex] > 0 then
local ep = pths[endpointPathIndex][#pths[endpointPathIndex]]
if ep then
endpointPos = Vector3(ep.x, ep.y, ep.z)
end
end
if endpointPos and foundTeleporters and #foundTeleporters > 0 then
local filteredCandidates = {}
for i = 1, #foundTeleporters do
local c = foundTeleporters[i]
if c and c.pos then
local dEnd = GP_TP_GetDistance(c.pos, endpointPos)
if dEnd <= endpointFilterRadius then
filteredCandidates[#filteredCandidates + 1] = c
end
end
end
if #filteredCandidates > 0 then
activeTeleporterCandidates = filteredCandidates
end
end
end
end
if activeTeleporterCandidates and #activeTeleporterCandidates > 0 then
local validated = {}
local mePosNow = me:GetAbsOrigin()
for i = 1, #activeTeleporterCandidates do
local c = activeTeleporterCandidates[i]
local ent = c and c.entity
if ent and ent.GetClass and ent.GetAbsOrigin and GP_TP_IsUsableTeleporter(ent) then
local class = ent:GetClass()
local mode = -1
if ent.GetPropInt then
local okMode, m = pcall(ent.GetPropInt, ent, "m_iObjectMode")
if okMode and type(m) == "number" then mode = m end
end
local isEntrance = (class == "CObjectTeleporterEntrance") or (mode == 0)
if isEntrance then
local p = ent:GetAbsOrigin()
if p then
c.pos = p
if mePosNow then
c.distance = GP_TP_GetDistance(mePosNow, p)
else
c.distance = GP_TP_GetDistance(me:GetAbsOrigin(), p)
end
validated[#validated + 1] = c
end
end
end
end
if #validated > 1 then
table.sort(validated, function(a, b) return (a.distance or math.huge) < (b.distance or math.huge) end)
end
activeTeleporterCandidates = validated
end
if activeTeleporterCandidates and #activeTeleporterCandidates > 0 then
tpTeleporterSeenCount = (tpTeleporterSeenCount or 0) + 1
else
tpTeleporterSeenCount = 0
end
local tpStableNeeded = (TP_TELE_STABLE_SCANS or 8)
if tpForceModeEnabled then
tpStableNeeded = 1
end
local fromWaitingState = waitingAtEndpoint
if activeTeleporterCandidates and #activeTeleporterCandidates > 0 and (tpTeleporterSeenCount >= tpStableNeeded) then
if tpNoTeleFallbackActive then
tpNoTeleFallbackActive = false
end
tpFallbackWaitPopupShown = false
tpFallbackNextWaitNotify = 0
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
local nearestTele = activeTeleporterCandidates[1]
local dist = GP_TP_GetDistance(me:GetAbsOrigin(), nearestTele.pos)
local stopDistance = (TP_TELE_STOP_DISTANCE or 75)
if fromWaitingState then
stopDistance = math.min(stopDistance, (TP_TELE_WAIT_STOP_DISTANCE or 24))
end
local shouldMove = (dist > stopDistance)
if shouldMove then
if not GP_TP_CheckAndHandleStuck(me, nearestTele, dist, currentTime) then
GP_TP_WalkToTeleporter(cmd, me, nearestTele.pos)
end
else
GP_TP_ResetStuckTracker()
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = true
tpLastReachedTeleporterAt = currentTime
tpIsWaitingForTeleporter = false
tpNoTeleFallbackActive = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
GP_TP_StartUseVerify(me, nearestTele.pos, currentTime)
sniperUpgradeCompletedTime = 0
end
else
if not tpNoTeleFallbackActive then
GP_TP_ResetStuckTracker()
end
tpNoTeleFallbackActive = true
GP_TP_WalkFallbackPath(cmd, me)
if tpIsWaitingForTeleporter and GP_TP_IsMoveLockActive() then
cmd:SetForwardMove(0)
cmd:SetSideMove(0)
end
end
end
else
if teleporterConfig.autoWalkEnabled then
teleporterConfig.autoWalkEnabled = false
end
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
GP_TP_ResetStuckTracker()
if (currentTime - lastTpClassWarnTime) > 1.5 then
lastTpClassWarnTime = currentTime
end
end
else
teleporterConfig.autoWalkEnabled = false
tpIsWaitingForTeleporter = false
tpWaitMoveWarnNext = 0
tpWaitMoveWarnCount = 0
GP_TP_ResetStuckTracker()
end
if autoWalkPaused then
local preWaveProofNow = ((GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false)
if autoWalkPauseReason == "after_wave1" and preWaveProofNow then
autoWalkPaused = false
autoWalkPauseReason = nil
lastAutoWalkPauseReason = nil
elseif autoWalkPauseReason == "threshold" and (not IsMoneyThresholdReached()) then
autoWalkPaused = false
autoWalkPauseReason = nil
thresholdNotificationShown = false
medicThresholdReached = false
elseif autoWalkPauseReason == "threshold" and GP_RST and GP_RST.medicCycleHardResetPending == true then
autoWalkPaused = false
autoWalkPauseReason = nil
thresholdNotificationShown = false
medicThresholdReached = false
hasTriedClassChange = false
pendingClassChange = false
classChangeUsePreWaveRules = false
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
end
end
if (not autoModeWalkActive) and ((not config.autoWalkEnabled) or autoWalkPaused) then
shouldGuidePlayer = false
midpoint = nil
return
end
local gpMedicHardResetPendingNow = (GP_RST and GP_RST.medicCycleHardResetPending == true)
if IsMoneyThresholdReached() and (not gpMedicHardResetPendingNow) then
GP_OnThresholdReached(me, currentTime, inZone, true)
if config.changeClassEnabled and (not hasTriedClassChange) and IsMvMWaveActive() and inZone and IsMedic(me) then
local retryTarget = GP_GetPostWaveStationSwapTarget(me)
if retryTarget and (currentTime - (lastRetryTime or 0)) > RETRY_COOLDOWN then
AddNotification("Wave active - retrying to change class", "warning")
lastRetryTime = currentTime
hasTriedClassChange = true
pendingRetry = true
pendingRetryTargetClass = retryTarget
pendingRetryTargetUntil = currentTime + 90.0
GP_IssueRetryWithAutoClass(retryTarget)
end
end
return
end
local isExpl = isExploiting
local tpOwnsAutoMovement = false
do
if tpUseVerifyActive then
tpOwnsAutoMovement = true
elseif teleporterConfig.autoWalkEnabled and (tpNoTeleFallbackActive or tpIsWaitingForTeleporter) then
tpOwnsAutoMovement = true
end
end
if tpOwnsAutoMovement then
shouldGuidePlayer = false
midpoint = nil
elseif canAutoMoveNow and (not inZone) and IsMedic(me) and hasVacc and not isExpl then
local inSpawnArea = IsInAutoCreditSpawnArea(me)
if inSpawnArea then
local newMidpoint = FindUpgradeStations(me)
if newMidpoint then
midpoint = newMidpoint
if not shouldGuidePlayer then
shouldGuidePlayer = true
AddNotification("Found upgrade station at: " .. tostring(midpoint.x) .. ", " .. tostring(midpoint.y) .. ", " .. tostring(midpoint.z), "info")
end
else
if shouldGuidePlayer then
AddNotification("Lost sight of upgrade station!", "warning")
end
shouldGuidePlayer = false
midpoint = nil
end
else
if shouldGuidePlayer then
AddNotification("Stopped guidance - reached zone or started exploit", "info")
end
shouldGuidePlayer = false
midpoint = nil
medicSpawnAnchor = nil
end
else
if shouldGuidePlayer then
AddNotification("Stopped guidance - reached zone or started exploit", "info")
end
shouldGuidePlayer = false
midpoint = nil
end
if (not tpOwnsAutoMovement) and shouldGuidePlayer and midpoint and canAutoMoveNow then
WalkTo(cmd, me, midpoint)
elseif (not canAutoMoveNow) then
shouldGuidePlayer = false
midpoint = nil
end
if tpIsWaitingForTeleporter and GP_TP_IsMoveLockActive() and IsManualMoveInput() then
GP_TP_ApplyMovementLock(cmd)
end
do
local tpAnyModeOn = (tpForceModeEnabled == true) or ((config and config.tpWalkEnabled) == true)
local lockConfigured = tpAnyModeOn and (config and config.tpWalkMoveLockEnabled == true)
if tpUseVerifyActive and lockConfigured and (teleporterConfig and teleporterConfig.autoWalkEnabled == true) and IsManualMoveInput() then
GP_TP_ApplyMovementLock(cmd)
end
end
GP_TP_HandleAimbotSuppression(currentTime)
if isExploiting and me:GetPropInt('m_bInUpgradeZone') ~= 1 and not respawnExpected then
ForceCleanup()
return
end
if respawnExpected and me:GetPropInt('m_bInUpgradeZone') == 1 then
respawnExpected = false
end
if isExploiting and not me:IsAlive() and not respawnExpected then
ForceCleanup()
AddNotification("Sequence interrupted!", "error")
return
end
-- Route movement is applied once, by the dedicated LAST CreateMove callback.
end)
-- Registered after all GhostMoney automation so the route has final say
-- about forward and side movement while its Wave 1 path is active.
callbacks.Register("CreateMove", __GM_CALLBACK_IDS.engiRouteMove, function(cmd)
    local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
    local now = (globals and globals.CurTime and globals.CurTime()) or 0
    GP_EB_RottenburgDispenserRepairTick(me, now)
    GP_EB_MannhattanWave1RouteAutoStart()
    if GP_EB_MannhattanWave1RouteActive() then
        local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
        local now = (globals and globals.CurTime and globals.CurTime()) or 0
        GP_EB_MannhattanWave1RouteTick(cmd, me, now)
    end
    GP_EB_SetupInputAfter(cmd)
end)
callbacks.Register("Unload", __GM_CALLBACK_IDS.unload, function()
GP_SETUP_VIEW = nil
GP_TP_AimbotRestoreOnUnload()
ForceCleanup()
SaveConfig(GP_CfgPath(), config)
if GhostMoney and GhostMoney.Internal and GhostMoney.Internal.Shutdown then
pcall(GhostMoney.Internal.Shutdown, true)
end
end)
AddNotification("EngiBuy + Engineer TpWalk headless mode started", "info")
if gpHadActiveTogglesOnLoad and entities.GetLocalPlayer() ~= nil and ((engine.GetMapName and engine.GetMapName()) or "") ~= "" then
AddNotification("Detected active toggles - some states reset", "warning", 5.0)
end
-- Optional headless diagnostic; type gp_engi_status in the TF2 console.
callbacks.Register("SendStringCmd", __GM_CALLBACK_IDS.engiStatus, function(cmd)
    if not (cmd and cmd.Get) then return end
    local text = tostring(cmd:Get() or ""):lower()
    if text:match("^%s*gp_engi_status%s*$") then
        GP_EB_PrintStatus("manual check")
        if cmd.Set then cmd:Set("") end
    end
end)
-- Reset as soon as user types 'retry' or 'reconnect'. Do not swallow the command.
callbacks.Register("SendStringCmd", "GhostMoney_EngiRepairStatus_v55", function(cmd)
    if not (cmd and cmd.Get) then return end
    local raw = tostring(cmd:Get() or ""):lower()
    if raw:match("^%s*gp_engi_repair_status%s*$") then
        if print then print("[Rottenburg repair] " .. GP_EB_RepairAndRefillStatus()) end
        if cmd.Set then cmd:Set("") end
    end
end)
callbacks.Register("SendStringCmd", __GM_CALLBACK_IDS.engiRetry, function(cmd)
    if not cmd or not cmd.Get then return end
    local raw = tostring(cmd:Get() or ""):lower()
    if raw:match("^%s*retry%s*$") or raw:match("^%s*reconnect%s*$") then
        GP_EB_ResetAll()
        sniperUpgradesComplete, sniperUpgradeCompleted = false, false
        sniperReloadAwaitRespawn, sniperReloadRespawnPending = false, false
        autobuyRunOnceDone, autobuyDoneAnnounced = false, false
        if GP_EB_Session then GP_EB_Session.lostSession = true end
        if teleporterConfig then teleporterConfig.autoWalkEnabled = false end
        GP_EB_Notify("retry requested - rearming EngiBuy and route", "info")
    end
end)

do
GhostMoney.Modules = GhostMoney.Modules or {}

function __GM_bind(bucket, alias, gname)
GhostMoney.Modules[bucket] = GhostMoney.Modules[bucket] or {}
local fn = _G[gname]
if type(fn) == "function" then
GhostMoney.Modules[bucket][alias] = fn
end
end

__GM_bind("Core", "GP_ArmReloadMoveLock", "GP_ArmReloadMoveLock")
__GM_bind("Core", "GP_CaptureActiveToggleSnapshot", "GP_CaptureActiveToggleSnapshot")
__GM_bind("Core", "GP_CheckSniperUpgradeDone", "GP_CheckSniperUpgradeDone")
__GM_bind("Core", "GP_DisableAllActiveToggles", "GP_DisableAllActiveToggles")
__GM_bind("F4", "IsFeatureEnabled", "GP_F4_IsFeatureEnabled")
__GM_bind("F4", "IsPreWave1State", "GP_F4_IsPreWave1State")
__GM_bind("F4", "OnDisconnectCycle", "GP_F4_OnDisconnectCycle")
__GM_bind("F4", "OnFeatureToggle", "GP_F4_OnFeatureToggle")
__GM_bind("F4", "OnJoinCycle", "GP_F4_OnJoinCycle")
__GM_bind("F4", "OnTpSuccess", "GP_F4_OnTpSuccess")
__GM_bind("F4", "SetGuiAutoReady", "GP_F4_SetGuiAutoReady")
__GM_bind("F4", "Sync", "GP_F4_Sync")
__GM_bind("Query", "GetCurrentClassName", "GP_GetCurrentClassName")
__GM_bind("Query", "GetGameRulesProxy", "GP_GetGameRulesProxy")
__GM_bind("Query", "GetPostWaveAutoCreditTargetClass", "GP_GetPostWaveAutoCreditTargetClass")
__GM_bind("Query", "GetPostWaveStationSwapTarget", "GP_GetPostWaveStationSwapTarget")
__GM_bind("Query", "GetRoundState", "GP_GetRoundState")
__GM_bind("Query", "GetWaveNumber", "GP_GetWaveNumber")
__GM_bind("Flow", "HandlePartyKillFromEvent", "GP_HandlePartyKillFromEvent")
__GM_bind("Query", "HasExplicitPreWave1Proof", "GP_HasExplicitPreWave1Proof")
__GM_bind("Query", "HasMoveIntent", "GP_HasMoveIntent")
__GM_bind("Query", "IsInSpawnRadiusArea", "GP_IsInSpawnRadiusArea")
__GM_bind("Query", "IsMedic", "GP_IsMedic")
__GM_bind("Query", "IsMvM", "GP_IsMvM")
__GM_bind("Query", "IsPostWaveSwapRestricted", "GP_IsPostWaveSwapRestricted")
__GM_bind("Query", "IsTextInputOpen", "GP_IsTextInputOpen")
__GM_bind("Core", "GP_NormalizeChatCmd", "GP_NormalizeChatCmd")
__GM_bind("Flow", "OnSniperUpgradesComplete", "GP_OnSniperUpgradesComplete")
__GM_bind("Restart", "Arm", "GP_RST_Arm")
__GM_bind("Restart", "ClassNum", "GP_RST_ClassNum")
__GM_bind("Restart", "DecideTarget", "GP_RST_DecideTarget")
__GM_bind("Restart", "EventKind", "GP_RST_EventKind")
__GM_bind("Restart", "GetConfiguredTargetClass", "GP_RST_GetConfiguredTargetClass")
__GM_bind("Restart", "GetVotePayloadText", "GP_RST_GetVotePayloadText")
__GM_bind("Restart", "IsClassChangeAllowed", "GP_RST_IsClassChangeAllowed")
__GM_bind("Restart", "IsNegativeVotePayload", "GP_RST_IsNegativeVotePayload")
__GM_bind("Restart", "IsRestartVotePayload", "GP_RST_IsRestartVotePayload")
__GM_bind("Restart", "Log", "GP_RST_Log")
__GM_bind("Restart", "NotifyDetected", "GP_RST_NotifyDetected")
__GM_bind("Restart", "Now", "GP_RST_Now")
__GM_bind("Restart", "OnEvent", "GP_RST_OnEvent")
__GM_bind("Restart", "PrepareMedicCycle", "GP_RST_PrepareMedicCycle")
__GM_bind("Restart", "PrepareSniperCycle", "GP_RST_PrepareSniperCycle")
__GM_bind("Restart", "Queue", "GP_RST_Queue")
__GM_bind("Restart", "RearmForceTpWalk", "GP_RST_RearmForceTpWalk")
__GM_bind("Restart", "RearmTpWalkNormal", "GP_RST_RearmTpWalkNormal")
__GM_bind("Restart", "Reset", "GP_RST_Reset")
__GM_bind("Restart", "StartForce", "GP_RST_StartForce")
__GM_bind("Restart", "StopForce", "GP_RST_StopForce")
__GM_bind("Restart", "TickForce", "GP_RST_TickForce")
__GM_bind("Restart", "TickQueuedStart", "GP_RST_TickQueuedStart")
__GM_bind("Restart", "TickState", "GP_RST_TickState")
__GM_bind("Restart", "UpdateKind", "GP_RST_UpdateKind")
__GM_bind("Core", "GP_RebuildSpawnAreaAnchors", "GP_RebuildSpawnAreaAnchors")
__GM_bind("Core", "GP_RestoreActiveToggleSnapshot", "GP_RestoreActiveToggleSnapshot")
__GM_bind("Core", "GP_SafeCall", "GP_SafeCall")
__GM_bind("Toggles", "SetTpWalkEnabled", "GP_SetTpWalkEnabled")
__GM_bind("Core", "GP_ShouldAllowPostWaveStationSwapWithoutThreshold", "GP_ShouldAllowPostWaveStationSwapWithoutThreshold")
__GM_bind("Core", "GP_SnapshotHasAnyActive", "GP_SnapshotHasAnyActive")
__GM_bind("TP", "ArmSpawnToggleLock", "GP_TP_ArmSpawnToggleLock")
__GM_bind("TP", "BuildTargetId", "GP_TP_BuildTargetId")
__GM_bind("TP", "CheckAndHandleStuck", "GP_TP_CheckAndHandleStuck")
__GM_bind("TP", "CheckAndHandleWaypointStuck", "GP_TP_CheckAndHandleWaypointStuck")
__GM_bind("TP", "HandleWaitingPopups", "GP_TP_HandleWaitingPopups")
__GM_bind("TP", "IsSetupPhase", "GP_TP_IsSetupPhase")
__GM_bind("TP", "IsSpawnContextNow", "GP_TP_IsSpawnContextNow")
__GM_bind("TP", "IsToggleSpawnUnlocked", "GP_TP_IsToggleSpawnUnlocked")
__GM_bind("TP", "ResetPathState", "GP_TP_ResetPathState")
__GM_bind("TP", "ResetStuckTracker", "GP_TP_ResetStuckTracker")
__GM_bind("TP", "StartUseVerify", "GP_TP_StartUseVerify")
__GM_bind("TP", "StopUseVerify", "GP_TP_StopUseVerify")
__GM_bind("TP", "TickUseVerify", "GP_TP_TickUseVerify")
__GM_bind("TP", "WalkFallbackPath", "GP_TP_WalkFallbackPath")
__GM_bind("Query", "TryGetEventString", "GP_TryGetEventString")
__GM_bind("Query", "TryPropInt", "GP_TryPropInt")
__GM_bind("Core", "GP_UpdateSpawnSignAnchor", "GP_UpdateSpawnSignAnchor")
__GM_bind("Core", "IsMedic", "IsMedic")

GhostMoney.API = GhostMoney.API or {}

function GhostMoney.API.GetRuntime()
return GhostMoney.Runtime
end

function GhostMoney.API.GetConfig()
return config
end

function GhostMoney.API.Save()
if SaveConfig and GP_CfgPath and config then
pcall(SaveConfig, GP_CfgPath(), config)
end
end

function GhostMoney.API.ResetRuntime(reason)
if ResetRuntimeState then
pcall(ResetRuntimeState, reason or "API reset")
end
end
end

end
__GM_PART4__()
