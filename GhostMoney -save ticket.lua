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
GhostMoney.Meta.version = "2.0-modular-compat"
GhostMoney.Meta.build = "2026-02-12"

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
tpDropAutoKillActive = false,
tpDropAutoKillBaseX = nil,
tpDropAutoKillBaseY = nil,
tpDropAutoKillBaseZ = nil,
tpDropAutoKillUntil = 0,
tpDropAutoKillNextCheck = 0,
tpDropAutoKillLastKill = 0,
tpDropAutoKillMissCount = 0,
tpDropAutoKillDeadTicks = 0,
tpDropAutoKillLastArm = 0,
tpDropAutoKillFastUntil = 0,
tpDropManualNearUntil = 0,
tpDropManualScanNext = 0,
tpDropManualLastTime = 0,
tpDropEventArmPending = false,
tpDropEventArmAt = 0,
tpDropEventArmUntil = 0,
tpDropManualLastX = nil,
tpDropManualLastY = nil,
tpDropManualLastZ = nil,
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
["TP_DROP_AUTOKILL_KEY"] = true,
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
["tpDropAutoKillActive"] = true,
["tpDropAutoKillBaseX"] = true,
["tpDropAutoKillBaseY"] = true,
["tpDropAutoKillBaseZ"] = true,
["tpDropAutoKillUntil"] = true,
["tpDropAutoKillNextCheck"] = true,
["tpDropAutoKillLastKill"] = true,
["tpDropAutoKillMissCount"] = true,
["tpDropAutoKillDeadTicks"] = true,
["tpDropAutoKillLastArm"] = true,
["tpDropAutoKillFastUntil"] = true,
["tpDropManualNearUntil"] = true,
["tpDropManualScanNext"] = true,
["tpDropManualLastTime"] = true,
["tpDropEventArmPending"] = true,
["tpDropEventArmAt"] = true,
["tpDropEventArmUntil"] = true,
["tpDropManualLastX"] = true,
["tpDropManualLastY"] = true,
["tpDropManualLastZ"] = true,
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
createMove = "ghostmoney_create_move",
unload = "ghostmoney_unload",
thresholdCommand = "threshold_command",
uiResetCommand = "gp_gm_ui_reset_cmd",
dispatchUserMessage = "ghostmoney_dispatch_user_message",
gcSendMessage = "ghostmoney_gc_send_message",
gcRetrieveMessage = "ghostmoney_gc_retrieve_message",
}
GhostMoney.Internal.callbackIds = __GM_CALLBACK_IDS

local function __GM_UnregisterCallbacks()
if not (callbacks and callbacks.Unregister) then return end
pcall(callbacks.Unregister, "FireGameEvent", __GM_CALLBACK_IDS.fireGameEvent)
pcall(callbacks.Unregister, "Draw", __GM_CALLBACK_IDS.draw)
pcall(callbacks.Unregister, "CreateMove", __GM_CALLBACK_IDS.createMove)
pcall(callbacks.Unregister, "Unload", __GM_CALLBACK_IDS.unload)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.thresholdCommand)
pcall(callbacks.Unregister, "SendStringCmd", __GM_CALLBACK_IDS.uiResetCommand)
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
tpDropAutoKillEnabled = false,
firstJoinPickMedic = false,
mvmReadyTpCycleEnabled = false,
instantRespawnEnabled = false,
autoCanteenEnabled = false,
tp_drop_key = KEY_B,
all_off_key = KEY_X,
watermarkX = 10,
watermarkY = 10,
moneyThreshold = 6500,
changeClassEnabled = false,
targetClass = ""
}
local GP_STEAMID64_BASE = 76561197960265728
local GP_PARTY_AUTO_QUEUE_INTERVAL = 4.0
local GP_PARTY_AUTO_QUEUE_START_DELAY = 6.0
local GP_PARTY_AUTO_QUEUE_CANCEL_COOLDOWN = 15.0
local GP_PARTY_AUTO_QUEUE_WAIT_BUTTON_DELAY = 60.0
local GP_PARTY_VOTE_REVEAL_ORANGE = "\x08FFA500FF"
local GP_PARTY_VOTE_REVEAL_GREEN = "\x089EE09EFF"
local GP_PARTY_VOTE_REVEAL_RED = "\x08FF6663FF"
local GP_PARTY_QUEUE_OPERATIONS = {
two_cities = {
label = "Two Cities",
tour = "advanced3",
missions = {
"mvm_mannhattan_advanced1",
"mvm_mannhattan_advanced2",
"mvm_rottenburg_advanced1",
"mvm_rottenburg_advanced2",
},
},
mecha_engine = {
label = "Mecha Engine",
tour = "advanced2",
missions = {
"mvm_bigrock_advanced1",
"mvm_bigrock_advanced2",
"mvm_decoy_advanced3",
},
},
gear_grinder = {
label = "Gear Grinder",
tour = "expert1",
missions = {
"mvm_coaltown_expert1",
"mvm_decoy_expert1",
"mvm_mannworks_expert1",
},
},
}
local gpPartyAutoQueueNextAt = 0
local gpPartyAutoQueueGcArmUntil = 0
local gpPartyAutoQueueWasQueued = false
local gpPartyAutoQueueCooldownUntil = 0
local gpPartyAutoQueuePendingUntil = 0
local gpPartyAutoQueueOptionsReadyAt = 0
local gpPartyAutoQueueSetOptionsForceQueueUntil = 0
local gpPartyAutoQueueMatchJoinLastAt = 0
local gpPartyAutoQueueLastPartyWarnAt = 0
local gpPartyAutoQueueUiLastMouseDown = false
local gpPartyAutoQueueUiDragging = false
local gpPartyAutoQueueUiDragOffsetX = 0
local gpPartyAutoQueueUiDragOffsetY = 0
local gpPartyAutoQueueLearnedSuffixByOperation = {}
local gpPartyAutoQueueLearnedSetOptionsByOperation = {}
local gpPartyManualQueueTraceUntil = 0
local gpPartyManualQueueTraceLastAt = 0
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
function GP_TP_IsMoveLockActive()
local lockOn = (config and config.tpWalkMoveLockEnabled == true)
local modeOn = (tpForceModeEnabled == true) or (config and config.tpWalkEnabled == true)
if (not lockOn) or (not modeOn) then
return false
end
local now = ((globals and globals.CurTime and globals.CurTime()) or 0)
if (tpClassSwapUnlockUntil or 0) > now then
return false
end
local movingNow = (teleporterConfig and teleporterConfig.autoWalkEnabled == true) and (not teleporterJustUsed)
local waitingNow = (tpIsWaitingForTeleporter == true) or (tpNoTeleFallbackActive == true)
local verifyingNow = (tpUseVerifyActive == true)
return (movingNow or waitingNow or verifyingNow)
end
function GP_TP_ApplyMovementLock(cmd)
if not cmd then return end
pcall(function() cmd:SetForwardMove(0) end)
pcall(function() cmd:SetSideMove(0) end)
pcall(function() if cmd.SetUpMove then cmd:SetUpMove(0) end end)
pcall(function()
if cmd.GetButtons and cmd.SetButtons then
local b = cmd:GetButtons()
if type(b) == "number" then
local bitlib = bit32 or bit
if bitlib and bitlib.band and bitlib.bnot then
local clearMask = GP_IN_JUMP + GP_IN_FORWARD + GP_IN_BACK + GP_IN_LEFT + GP_IN_RIGHT + GP_IN_MOVELEFT + GP_IN_MOVERIGHT
local cleaned = bitlib.band(b, bitlib.bnot(clearMask))
cmd:SetButtons(cleaned)
end
end
end
end)
end
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
function AddNotification(message, ntype, duration)
if message == "SniperBuy Enabled" or message == "SniperBuy Enabled - Reset state" then
message = "SniperBuy Enabled - Reset state (Death/Respawn as Sniper activates it)"
if duration == nil then duration = 4.0 end
end
if type(message) == "string" then
message = message:gsub("%s+$", "")
message = message:gsub("%.+$", "")
end
if type(message) == "string" and string.find(message, "Enabled", 1, true) then
local d = tonumber(duration)
if d == nil or d < 5.0 then duration = 5.0 end
end
UI = UI or {}
UI.notifications = UI.notifications or {}
if config and config.hideInfoPopups == true then return end
if _G.type(message) == "string" and string.find(message, "^Changed class to ") then
local rt = 0
pcall(function()
if globals and globals.RealTime then
rt = globals.RealTime()
elseif globals and globals.CurTime then
rt = globals.CurTime()
end
end)
_G.__gm_lastClassChangedPopupMsg = _G.__gm_lastClassChangedPopupMsg or ""
_G.__gm_lastClassChangedPopupAt = _G.__gm_lastClassChangedPopupAt or -9999
if message == _G.__gm_lastClassChangedPopupMsg and (rt - (_G.__gm_lastClassChangedPopupAt or 0)) < 2.0 then
return
end
_G.__gm_lastClassChangedPopupMsg = message
_G.__gm_lastClassChangedPopupAt = rt
end
if _G.type(CreateNotification) == "function" then
table.insert(UI.notifications, 1, CreateNotification(message, ntype, duration))
if UI.maxNotifications and #UI.notifications > UI.maxNotifications then
table.remove(UI.notifications)
end
else
table.insert(UI.notifications, 1, {
message = tostring(message or ""),
type = ntype,
time = (globals and globals.RealTime and globals.RealTime()) or 0,
alpha = 255,
lifetime = duration
})
if #UI.notifications > 8 then table.remove(UI.notifications) end
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

local function GP_AutoDisconnectObjectiveIndex(ent)
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
local idx = GP_AutoDisconnectObjectiveIndex(ent)
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
local function GP_AutoDisconnectReset(joinGrace)
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
function GP_F4_IsFeatureEnabled()
return (config and config.mvmReadyTpCycleEnabled == true)
end
function GP_F4_SetGuiAutoReady(enabled, forceWrite)
if not GP_F4_IsFeatureEnabled() then return false end
local want = (enabled and true or false)

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
function GP_OnThresholdReached(_me, currentTime, inZone, pauseAutoWalk)
if thresholdNotificationShown then return true end
thresholdNotificationShown = true
medicThresholdReached = true
gpPhase = "SNIPER_BUY"
AddNotification("Money threshold ($" .. tostring(config.moneyThreshold) .. ") reached!", "warning")
if GP_F4_IsFeatureEnabled and GP_F4_IsFeatureEnabled() and GP_F4_IsPreWave1State and GP_F4_IsPreWave1State() then
gpF4RequireTpForReady = false
gpF4PendingRejoinCycle = false
GP_F4_Sync("threshold_reached", true)
end
shouldGuidePlayerBuy = false
buyMidpoint = nil
if pauseAutoWalk then
autoWalkPaused = true
autoWalkPauseReason = "threshold"
autoModeWalkActive = false
end
if config.changeClassEnabled and (not hasTriedClassChange) then
pendingClassChange = true
classChangeUsePreWaveRules = false
if GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof() then
classChangeUsePreWaveRules = true
end
classChangeSwapPopupShown = false
classChangeDidRefund = false
classChangeRefundTime = 0
classChangeDidCleanup = false
classChangeCleanupTime = 0
classChangeReadyTime = (currentTime or 0) + THRESHOLD_CLASSCHANGE_DELAY
AddNotification(inZone and "Threshold reached in station - preparing swap" or "Preparing class change", "info")
end
return true
end
lastToggleTime = 0
local suppressToggleUntil = 0
TOGGLE_COOLDOWN = 0.2
WALK_KEY = KEY_L
CLEAN_KEY = KEY_K
AUTO_KEY = KEY_J
TP_KEY = KEY_O
TP_DROP_AUTOKILL_KEY = KEY_B
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
local KEY_NAME_MAP = {
a=KEY_A,b=KEY_B,c=KEY_C,d=KEY_D,e=KEY_E,f=KEY_F,g=KEY_G,h=KEY_H,i=KEY_I,j=KEY_J,
k=KEY_K,l=KEY_L,m=KEY_M,n=KEY_N,o=KEY_O,p=KEY_P,q=KEY_Q,r=KEY_R,s=KEY_S,t=KEY_T,
u=KEY_U,v=KEY_V,w=KEY_W,x=KEY_X,y=KEY_Y,z=KEY_Z,
space=KEY_SPACE, shift=KEY_LSHIFT, ctrl=KEY_LCONTROL, alt=KEY_LALT
}
local KEY_CODE_TO_NAME = {}
for name, code in pairs(KEY_NAME_MAP) do
if type(code) == "number" then
KEY_CODE_TO_NAME[code] = name
end
end
local function KeyLabel(code)
local name = KEY_CODE_TO_NAME[code]
if not name then
return tostring(code)
end
if name == "space" then return "SPACE" end
if name == "shift" then return "SHIFT" end
if name == "ctrl" then return "CTRL" end
if name == "alt" then return "ALT" end
return string.upper(name)
end
function SaveConfig(filename, cfg)
local file = io.open(filename, "w")
if not file then return false end
for key, value in pairs(cfg) do
file:write(tostring(key) .. "=" .. tostring(value) .. "\n")
end
file:close()
return true
end
local function LoadConfig(filename)
local file = io.open(filename, "r")
if not file then return nil end
local loaded = {}
for line in file:lines() do
local key, value = line:match("^(.-)=(.+)$")
if key and value then
if value == "true" then value = true
elseif value == "false" then value = false
elseif tonumber(value) then value = tonumber(value)
end
loaded[key] = value
end
end
file:close()
return loaded
end
local loadedConfig = LoadConfig(GP_CfgPath())
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
if type(config.walk_key)=="number" then WALK_KEY=config.walk_key end
if type(config.clean_key)=="number" then CLEAN_KEY=config.clean_key end
if type(config.auto_key)=="number" then AUTO_KEY=config.auto_key end
if type(config.tp_key)=="number" then TP_KEY=config.tp_key end
if type(config.tp_drop_key)=="number" then TP_DROP_AUTOKILL_KEY=config.tp_drop_key end
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
config.partyAutoQueueEnabled = false
config.partyAutoQueuePaused = false
if config.partyVoteRevealEnabled == nil then config.partyVoteRevealEnabled = false end
if config.partyVoteRevealOutput ~= "local" and config.partyVoteRevealOutput ~= "party" then config.partyVoteRevealOutput = "party" end
if config.partyAutoAcceptInvitesEnabled == nil then config.partyAutoAcceptInvitesEnabled = false end
if config.smartVoteEnabled == nil then config.smartVoteEnabled = false end
if config.forceFixWaveStartEnabled == nil then config.forceFixWaveStartEnabled = false end
if config.autoDisconnectEnabled == nil then config.autoDisconnectEnabled = false end
if config.autoFocusEnabled == nil then config.autoFocusEnabled = false end
if config.tpWalkMoveLockEnabled == nil then config.tpWalkMoveLockEnabled = false end
if config.tpWalkWhitelistEnabled == nil then config.tpWalkWhitelistEnabled = false end
if config.tpDropAutoKillEnabled == nil then config.tpDropAutoKillEnabled = false end
if config.firstJoinPickMedic == nil then config.firstJoinPickMedic = false end
if config.mvmReadyTpCycleEnabled == nil then config.mvmReadyTpCycleEnabled = false end
if config.instantRespawnEnabled == nil then config.instantRespawnEnabled = false end
if config.autoCanteenEnabled == nil then config.autoCanteenEnabled = false end
if type(ALL_OFF_KEY) ~= "number" then ALL_OFF_KEY = KEY_X end
if type(TP_DROP_AUTOKILL_KEY) ~= "number" then TP_DROP_AUTOKILL_KEY = KEY_B end
if type(config.all_off_key) ~= "number" then config.all_off_key = ALL_OFF_KEY end
if type(config.tp_drop_key) ~= "number" then config.tp_drop_key = TP_DROP_AUTOKILL_KEY end
if tpForceModeEnabled then
tpStickyArmed = true
end
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
gpStickyForceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config.forceSniperBuyEnabled == true)
local UI = {
mainFont = draw.CreateFont("Verdana", 16, 400),
colors = {
background = {15, 15, 15, 240},
accent = {65, 185, 255},
success = {50, 205, 50},
warning = {255, 165, 0},
error = {255, 64, 64},
text = {255, 255, 255},
textDim = {180, 180, 180}
},
notifications = {},
maxNotifications = 15,
notificationLifetime = 3,
notificationHeight = 28,
notificationSpacing = 2
}
local _gp_noTransparent = false
local function GP_UIAlpha(a)
a = a or 255
if _gp_noTransparent then
return a
end
if config.transparentEnabled then
return math.max(0, math.floor(a * 0.42))
end
return a
end
local function GP_GoldBarAlpha()
return config.transparentEnabled and 107 or 255
end
local _gp_uiTimeLast = 0
local _gp_uiTimeOffset = 0
local function GP_Time()
local raw = 0
if globals.RealTime then
local ok, t = pcall(globals.RealTime)
if ok and t then raw = t end
elseif globals.CurTime then
local ok, t = pcall(globals.CurTime)
if ok and t then raw = t end
end
if raw < _gp_uiTimeLast then
_gp_uiTimeOffset = _gp_uiTimeOffset + (_gp_uiTimeLast - raw)
end
_gp_uiTimeLast = raw
return raw + _gp_uiTimeOffset
end
local function ClampByte(v)
v = tonumber(v) or 0
if v ~= v then return 0 end
v = math.floor(v + 0.5)
if v < 0 then return 0 end
if v > 255 then return 255 end
return v
end
_GP_OrigDrawColor = draw.Color
local function UI_Color(r,g,b,a)
r = ClampByte(r)
g = ClampByte(g)
b = ClampByte(b)
a = ClampByte(GP_UIAlpha(a))
if a <= 0 then a = 1 end
__GP_LAST_COLOR[1], __GP_LAST_COLOR[2], __GP_LAST_COLOR[3], __GP_LAST_COLOR[4] = r, g, b, a
if type(_GP_OrigDrawColor) == "function" then
_GP_OrigDrawColor(r,g,b,a)
else
draw.Color(r,g,b,a)
end
end
local function GP_Color(r,g,b,a) UI_Color(r,g,b,a) end
local function CreateNotification(message, ntype, duration)
local colors = {
success = UI.colors.success,
warning = UI.colors.warning,
error = UI.colors.error,
info = UI.colors.accent
}
return {
message = message,
type = ntype or "info",
color = colors[ntype] or colors.info,
time = GP_Time(),
lifetime = duration,
alpha = 0,
targetAlpha = 255,
y = nil,
offsetY = 0,
slideY = 0
}
end
local function GP_Clamp(x, a, b)
if x < a then return a end
if x > b then return b end
return x
end
local function GP_EaseOutCubic(t)
t = GP_Clamp(t, 0, 1)
local u = 1 - t
return 1 - (u*u*u)
end
local function GP_EaseInCubic(t)
t = GP_Clamp(t, 0, 1)
return t*t*t
end
local function GP_FrameDT()
if globals and globals.FrameTime then
local ok, v = pcall(globals.FrameTime)
if ok and type(v) == "number" and v > 0 and v < 0.2 then return v end
end
return 1/60
end
local function GP_ShouldAllowNotification(message)
if not message or message == "" then return false end
message = tostring(message)
message = message:gsub("%s+$", "")
message = message:gsub("%.+$", "")
local messageLower = string.lower(message)
if string.find(messageLower, "hotkey set", 1, true) then return true end
if config and config.hideInfoPopups == true then
return false
end
if message == "Sequence already in progress!" then return false end
if message == "Sequence interrupted!" then return false end
if message == "Waiting before class change" then return false end
if message == "Preparing class change" then return false end
if message == "Moving out of upgrade zone" then return false end
if message == "Equip Vaccinator (secondary) first!" then return false end
if message == "SniperBuy: reached upgrade station" then return false end
if message == "SniperBuy: walking to upgrade station" then return false end
if message == "SniperBuy: buying Sniper upgrades" then return false end
if message == "Lost sight of upgrade station!" then return false end
if message == "Stopped guidance - reached zone or started exploit" then return false end
if string.find(message, "Found upgrade station at:", 1, true) then return false end
if string.find(message, "Transparent ", 1, true) then return true end
if string.find(message, "Auto Mode ", 1, true) then return true end
if string.find(message, "Auto Walk ", 1, true) then return true end
if string.find(message, "Auto Walk:", 1, true) then return true end
if string.find(message, "Started cleanup", 1, true) then return true end
if string.find(message, "Toggles restored", 1, true) then return true end
if string.find(message, "Force TpWalk ", 1, true) then return true end
if string.find(message, "All Class TpWalk ", 1, true) then return true end
if string.find(message, "TpWalk Enabled", 1, true) then return true end
if string.find(message, "Use Force TpWalk to bypass class restrictions", 1, true) then return true end
if string.find(message, "TpWalk Disabled", 1, true) then return true end
if string.find(message, "AutoCredit Enabled", 1, true) then return true end
if string.find(message, "AutoCredit only works before Wave 1 starts and with 600+ starting credits", 1, true) then return true end
if string.find(message, "Vaccinator not equipped for AutoCredit", 1, true) then return true end
if string.find(message, "Select Medic with Vaccinator for AutoCredit", 1, true) then
local suppress = false
local rt = 0
pcall(function()
if globals and globals.RealTime then
rt = globals.RealTime()
elseif globals and globals.CurTime then
rt = globals.CurTime()
end
end)
local lastMsg = tostring(_G.__gm_lastClassChangedPopupMsg or "")
local lastAt = tonumber(_G.__gm_lastClassChangedPopupAt or -9999) or -9999
if (rt - lastAt) < 12.0 and string.find(lastMsg, "Changed class to ", 1, true) then
suppress = true
end
if not suppress then
local lp = nil
pcall(function()
if entities and entities.GetLocalPlayer then
lp = entities.GetLocalPlayer()
end
end)
if lp then
local curClass = nil
pcall(function() curClass = GP_GetCurrentClassName(lp) end)
local t = config and config.targetClass or nil
if type(curClass) == "string" and type(t) == "string" then
local c = string.lower(curClass)
local tc = string.lower(t)
if tc ~= "" and tc ~= "off" and tc ~= "none" and tc ~= "medic" and c == tc then
suppress = true
end
end
end
end
return (not suppress)
end
if string.find(message, "AutoCredit Disabled", 1, true) then return true end
if string.find(message, "Target class set to ", 1, true) then return true end
if string.find(message, "Auto class change disabled", 1, true) then return true end
if string.find(message, "Force SniperBuy ", 1, true) then return true end
if string.find(message, "NoWalk SniperBuy ", 1, true) then return true end
if message == "Sniper upgrades completed!" then return true end
if string.find(message, "SniperBuy run complete", 1, true) then return true end
if string.find(message, "SniperBuy Enabled", 1, true) then return true end
if string.find(message, "SniperBuy Disabled", 1, true) then return true end
if string.find(message, "waiting till teleporter is placed", 1, true) then return true end
if string.find(message, "waiting for teleporter", 1, true) then return true end
if string.find(message, "Waiting for teleporter", 1, true) then return true end
if string.find(message, "searching for teleporter", 1, true) then return true end
if string.find(message, "still waiting for teleporter", 1, true) then return true end
if string.find(message, "Still waiting for teleporter", 1, true) then return true end
if string.find(message, "Tp Position Lost - Kill", 1, true) then return true end
if string.find(message, "Position Lost - Kill", 1, true) then return true end
if string.find(message, "don't walk away", 1, true) then return true end
if string.find(message, "Don't walk away", 1, true) then return true end
if string.find(message, "pending re-arm", 1, true) then return true end
if string.find(message, "re-armed", 1, true) then return true end
if string.find(message, "detected stuck", 1, true) then return true end
if string.find(message, "Loaded GhostMoney", 1, true) then return true end
if string.find(message, "Detected active toggles - some states reset", 1, true) then return true end
if string.find(message, "Hide Info Pop ups Disabled", 1, true) then return true end
if string.find(message, "Hide Hotkeys in UI ", 1, true) then return true end
if string.find(message, "Party gp_kill command ", 1, true) then return true end
if string.find(message, "Party gp_kill received", 1, true) then return true end
if string.find(message, "Party gp_leave command ", 1, true) then return true end
if string.find(message, "Auto Disconnect ", 1, true) then return true end
if string.find(message, "Party gp_leave received", 1, true) then return true end
if string.find(message, "Party gp_fix command ", 1, true) then return true end
if string.find(message, "Party gp_f1 / gp_f2 command ", 1, true) then return true end
if string.find(message, "Party gp_lead command ", 1, true) then return true end
if string.find(message, "Auto Queue ", 1, true) then return true end
if string.find(message, "Queue operation set to ", 1, true) then return true end
if string.find(message, "Vote Revealer ", 1, true) then return true end
if string.find(message, "Auto Accept Party Invites ", 1, true) then return true end
if string.find(message, "Smart Vote ", 1, true) then return true end
if string.find(message, "Force Fix ", 1, true) then return true end
if string.find(message, "Party gp_retry command ", 1, true) then return true end
if string.find(message, "Auto Ammo Canteen ", 1, true) then return true end
if string.find(message, "Party gp_fix received", 1, true) then return true end
if string.find(message, "Party gp_retry received", 1, true) then return true end
if string.find(message, "Party gp_f1 received", 1, true) then return true end
if string.find(message, "Party gp_f2 received", 1, true) then return true end
if string.find(message, "Party gp_lead", 1, true) then return true end
if string.find(message, "Smart Vote:", 1, true) then return true end
if string.find(message, "Lock TpWalking ", 1, true) then return true end
if string.find(message, "TpWalk Whitelist ", 1, true) then return true end
if string.find(message, "First Join Medic ", 1, true) then return true end
if string.find(message, "First Join Medic:", 1, true) then return true end
if string.find(message, "Smart AutoF4 ", 1, true) then return true end
if string.find(message, "Instant Respawn ", 1, true) then return true end
if string.find(message, "Generating cash", 1, true) then return true end
if string.find(message, "Restart/Fail detected - Reset state", 1, true) then return true end
if string.find(message, "Map fail/restart detected - reset state", 1, true) then return true end
if isExploiting or (config and (config.autoWalkEnabled)) then
if string.find(message, "Started sequence", 1, true) then return true end
if string.find(message, "Generating cash", 1, true) then return true end
if string.find(message, "Money threshold", 1, true) then return true end
if string.find(message, "Changed class", 1, true) then return true end
if string.find(message, "Alert:", 1, true) then return true end
return false
end
return true
end
function AddNotification(message, ntype, duration)
if message == "SniperBuy Enabled" or message == "SniperBuy Enabled - Reset state" then
message = "SniperBuy Enabled - Reset state (Death/Respawn as Sniper activates it)"
if duration == nil then duration = 4.0 end
end
if type(message) == "string" then
message = message:gsub("%s+$", "")
message = message:gsub("%.+$", "")
end
if type(message) == "string" and string.find(message, "Enabled", 1, true) then
local d = tonumber(duration)
if d == nil or d < 5.0 then duration = 5.0 end
end
do
local msg = tostring(message or "")
local isThresholdReachedPopup =
string.find(msg, "Money threshold ($", 1, true) and
string.find(msg, ") reached!", 1, true)
if isThresholdReachedPopup then
_G.__gm_moneyThresholdReachedPopupShownOnce = _G.__gm_moneyThresholdReachedPopupShownOnce or false
if _G.__gm_moneyThresholdReachedPopupShownOnce then
return
end
_G.__gm_moneyThresholdReachedPopupShownOnce = true
end
end
UI.notifications = UI.notifications or {}
if not GP_ShouldAllowNotification(message) then return end
table.insert(UI.notifications, 1, CreateNotification(message, ntype, duration))
if #UI.notifications > UI.maxNotifications then
table.remove(UI.notifications)
end
end
local function DrawRect(x, y, w, h, color)
local r, g, b, a = 255, 255, 255, 255
if type(color) == "table" then
r = tonumber(color[1]) or r
g = tonumber(color[2]) or g
b = tonumber(color[3]) or b
a = tonumber(color[4]) or a
end
local x1 = math.floor(x)
local y1 = math.floor(y)
local x2 = math.floor(x + w)
local y2 = math.floor(y + h)
UI_Color(r, g, b, a)
local ok = pcall(draw.FilledRect, x1, y1, x2, y2)
if not ok then
if _GP_OrigDrawColor then
local fr = ClampByte(r)
local fg = ClampByte(g)
local fb = ClampByte(b)
local fa = ClampByte(GP_UIAlpha(a))
if fa <= 0 then fa = 1 end
pcall(_GP_OrigDrawColor, fr, fg, fb, fa)
end
pcall(draw.FilledRect, x1, y1, x2, y2)
end
end
local function DrawNotification(notif, x, y)
if notif.alpha <= 1 then return end
draw.SetFont(UI.mainFont)
local messageWidth, messageHeight = draw.GetTextSize(notif.message)
local barW = 3
local pad = 10
local width = math.floor(barW + pad + messageWidth + pad)
local height = math.floor(UI.notificationHeight)
local age = GP_Time() - (notif.time or GP_Time())
local inDur = UI.notificationInDur or 0.22
local outDur = UI.notificationOutDur or 0.28
local life = tonumber(notif.lifetime) or UI.notificationLifetime
local minLife = (inDur + outDur + 0.05)
if life < minLife then life = minLife end
local progress = 1 - (age / life)
if progress < 0 then progress = 0 elseif progress > 1 then progress = 1 end
local alpha = math.floor((notif.alpha or 0) + 0.5)
local bgA = math.floor(178 * (alpha / 255) + 0.5)
if bgA < 1 then bgA = 1 end
DrawRect(
math.floor(x),
math.floor(y),
width,
height,
{0, 0, 0, bgA}
)
local gp = GP_UI and GP_UI.colors and GP_UI.colors.gold or {255, 215, 0, 255}
DrawRect(
math.floor(x),
math.floor(y),
barW,
height,
{gp[1], gp[2], gp[3], alpha}
)
UI_Color(UI.colors.text[1], UI.colors.text[2], UI.colors.text[3], alpha)
local textY = math.floor(y + (height - messageHeight) / 2)
SafeText(math.floor(x + barW + pad), textY, notif.message)
if progress > 0 then
DrawRect(
math.floor(x + 1),
math.floor(y + height - 2),
math.floor((width - 2) * progress),
2,
{gp[1], gp[2], gp[3], math.floor(alpha * 0.7)}
)
end
end
GP_LOAD_INFO_README_URL =
"https://gitlab.com/golden_pan-lua/ghostmoney-lua-tf2-mvm/-/blob/main/README.md"
GP_INFO_LOAD_VERSION = "1.3-release"
GP_LoadInfoPopup = GhostMoney.LoadInfoPopup or {
visible = false,
lastMouseDown = false,
dragging = false,
dragOffsetX = 0,
dragOffsetY = 0,
feedback = nil,
feedbackUntil = 0,
lines = {}
}
GhostMoney.LoadInfoPopup = GP_LoadInfoPopup
GP_CHANGELOG_VERSION = "1.3-release"
GP_ChangelogPopup = GhostMoney.ChangelogPopup or {
visible = false,
lastMouseDown = false,
dragging = false,
dragOffsetX = 0,
dragOffsetY = 0,
activeVersion = "1.3",
lines = {}
}
GhostMoney.ChangelogPopup = GP_ChangelogPopup
local GP_CHANGELOG_PAGES = {
["1.3"] = {
{"Performance & UI", true},
{"- Moved Smart Vote to Party Features", false},
{"New Features", true},
{"- Auto Focus: activates Heatmaker Focus", false},
{"Other", true},
{"- Fixed gp_f1 / gp_f2 not working", false},
{"- Fixed Tp Position Lost - Kill breaking", false},
{"- Fixed reconnect class and feature states", false},
{"- Fixed Auto Disconnect issue on VMs", false},
{"- Changed Vote Revealer", false}
},
["1.2"] = {
{"Performance & UI", true},
{"- Performance updates", false},
{"- Cleaner feature layout", false},
{"New Features", true},
{"- Smart Vote: party F1, random F2", false},
{"- Vote Revealer: Party or Local", false},
{"- Auto Accept Party Invites", false},
{"- New commands: gp_f1 / gp_f2, gp_lead", false},
{"- Force Fix on wave start", false},
{"- Tp Position Lost - Kill", false},
{"Other", true},
{"- gp_fix now fixes large robots + Cleanup", false},
{"- Buyback fallback for Instant Respawn", false}
}
}

function GP_SetChangelogPage(version)
local wanted = tostring(version or "1.3")
if not GP_CHANGELOG_PAGES[wanted] then wanted = "1.3" end
GP_ChangelogPopup.activeVersion = wanted
GP_ChangelogPopup.lines = GP_CHANGELOG_PAGES[wanted]
end

function GP_LoadInfoTryOpenOrCopy()
local url = GP_LOAD_INFO_README_URL
local ok = false
pcall(function()
if SetClipboardText then
SetClipboardText(url)
ok = true
elseif setclipboard then
setclipboard(url)
ok = true
elseif gui and gui.SetClipboardText then
gui.SetClipboardText(url)
ok = true
elseif client and client.SetClipboardText then
client.SetClipboardText(url)
ok = true
end
end)
pcall(function()
if client and client.ChatPrintf then
client.ChatPrintf("[gp_gm] README: " .. url)
elseif client and client.ChatPrint then
client.ChatPrint("[gp_gm] README: " .. url)
end
end)
pcall(function()
if client and client.Command then
client.Command("echo " .. string.format("%q", "[gp_gm] README: " .. url), true)
end
end)
pcall(function()
print("[gp_gm] README: " .. url)
end)
local now = (globals and globals.RealTime and globals.RealTime()) or 0
if ok then
GP_LoadInfoPopup.feedback = "Copied. Check the console too."
GP_LoadInfoPopup.feedbackUntil = now + 4.0
AddNotification("README link copied", "success", 3.0)
else
GP_LoadInfoPopup.feedback = "Check the console."
GP_LoadInfoPopup.feedbackUntil = now + 4.0
AddNotification("README link printed to chat/console", "info", 3.5)
end
end

function GP_ShowLoadInfoPopup()
local seen = (config and tostring(config.infoLoadSeenVersion or "") == tostring(GP_INFO_LOAD_VERSION))
if config and config.hideInfoOnLoad == true and seen then return end
GP_LoadInfoPopup.visible = true
GP_LoadInfoPopup.lastMouseDown = false
GP_LoadInfoPopup.dragging = false
GP_LoadInfoPopup.feedback = nil
GP_LoadInfoPopup.feedbackUntil = 0
GP_LoadInfoPopup.lines = {
"Left-click and drag to move the UI.",
"Left-click cash/class in the UI to change it.",
"Right-click the UI for features & customization.",
"Disable this info: right-click GhostMoney UI > Misc > Hide Info on Load.",
"",
"AutoCredit works ONLY before Wave 1 with 600+ credits.",
"You must be Medic with the Vaccinator equipped.",
"SniperBuy buys Godspot Sniper upgrades.",
"TpWalk only supports Two Cities; other maps may cause errors.",
"",
"I highly recommend reading the README to fully understand all features."
}
end

function GP_ShowChangelogPopup()
local seen = (config and tostring(config.changelogSeenVersion or "") == tostring(GP_CHANGELOG_VERSION))
if config and config.hideInfoOnLoad == true and seen then return end
GP_ChangelogPopup.visible = true
GP_ChangelogPopup.lastMouseDown = false
GP_ChangelogPopup.dragging = false
GP_SetChangelogPage("1.3")
end

function GP_CloseChangelogPopup()
if not GP_ChangelogPopup then return end
GP_ChangelogPopup.visible = false
if config then
config.changelogSeenVersion = GP_CHANGELOG_VERSION
pcall(function()
if SaveConfig and GP_CfgPath then SaveConfig(GP_CfgPath(), config) end
end)
end
end

function GP_CloseLoadInfoPopup()
if not GP_LoadInfoPopup then return end
GP_LoadInfoPopup.visible = false
if config then
config.infoLoadSeenVersion = GP_INFO_LOAD_VERSION
pcall(function()
if SaveConfig and GP_CfgPath then SaveConfig(GP_CfgPath(), config) end
end)
end
end

function GP_DrawLoadInfoPopup(screenWidth, screenHeight)
if not (GP_LoadInfoPopup and GP_LoadInfoPopup.visible == true) then return false end
local seen = (config and tostring(config.infoLoadSeenVersion or "") == tostring(GP_INFO_LOAD_VERSION))
if config and config.hideInfoOnLoad == true and seen then
GP_LoadInfoPopup.visible = false
return false
end
screenWidth = screenWidth or (draw.GetScreenSize())
if not screenHeight then
screenWidth, screenHeight = draw.GetScreenSize()
end
local mousePos = input.GetMousePos()
local mx, my = mousePos[1] or 0, mousePos[2] or 0
local mouseDown = input.IsButtonDown(MOUSE_LEFT)
local mousePressed = mouseDown and not (GP_LoadInfoPopup.lastMouseDown or false)
GP_LoadInfoPopup.lastMouseDown = mouseDown
local prevNoTransparent = _gp_noTransparent
_gp_noTransparent = true
local w = math.min(620, math.max(390, screenWidth - 40))
local lineH = 18
local headerH = 28
local footerH = 32
local h = headerH + 12 + (#GP_LoadInfoPopup.lines * lineH) + footerH
local defaultX = math.floor((screenWidth - w) / 2) + 35
local defaultY = math.floor(math.max(24, (screenHeight - h) / 2))
local x = tonumber(GP_LoadInfoPopup.x) or defaultX
local y = tonumber(GP_LoadInfoPopup.y) or defaultY
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
local closeSize = 18
local closeX = x + w - closeSize - 8
local closeY = y + 5
local linkText = "README - click to generate link and paste it manually in browser"
local linkX = x + 12
local linkY = y + h - footerH + 8
local gold = {255, 215, 0, 255}
local text = {255, 255, 255, 255}
local titleFont = (UI and UI.mainFont) or (draw.CreateFont and draw.CreateFont("Verdana", 16, 400)) or nil
local bodyFont = (UI and UI.mainFont) or titleFont
if bodyFont then draw.SetFont(bodyFont) end
local linkW, linkH = draw.GetTextSize(linkText)
linkY = y + h - linkH - 8
local linkHitPad = 6
local overClose = (mx >= closeX and mx <= closeX + closeSize and my >= closeY and my <= closeY + closeSize)
local overPopup = (mx >= x and mx <= x + w and my >= y and my <= y + h)
local overLink = (
mx >= linkX - linkHitPad and mx <= linkX + linkW + linkHitPad and
my >= linkY - linkHitPad and my <= linkY + linkH + linkHitPad
)
if mousePressed then
if overClose then
GP_CloseLoadInfoPopup()
elseif overLink then
GP_LoadInfoTryOpenOrCopy()
elseif overPopup then
GP_LoadInfoPopup.dragging = true
GP_LoadInfoPopup.dragOffsetX = mx - x
GP_LoadInfoPopup.dragOffsetY = my - y
end
elseif not mouseDown then
GP_LoadInfoPopup.dragging = false
end
if GP_LoadInfoPopup.dragging then
x = mx - (GP_LoadInfoPopup.dragOffsetX or 0)
y = my - (GP_LoadInfoPopup.dragOffsetY or 0)
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
end
GP_LoadInfoPopup.x = x
GP_LoadInfoPopup.y = y
GP_LoadInfoPopup.w = w
GP_LoadInfoPopup.h = h
closeX = x + w - closeSize - 8
closeY = y + 5
linkX = x + 12
linkY = y + h - linkH - 8
overClose = (mx >= closeX and mx <= closeX + closeSize and my >= closeY and my <= closeY + closeSize)
overLink = (
mx >= linkX - linkHitPad and mx <= linkX + linkW + linkHitPad and
my >= linkY - linkHitPad and my <= linkY + linkH + linkHitPad
)
DrawRect(x, y, w, h, {15, 15, 15, 245})
DrawRect(x, y, w, 2, {gold[1], gold[2], gold[3], 255})
DrawRect(x, y + h - 2, w, 2, {gold[1], gold[2], gold[3], 255})
if titleFont then draw.SetFont(titleFont) end
UI_Color(gold[1], gold[2], gold[3], 255)
SafeText(x + 12, y + 7, "GhostMoney 1.3 by golden pan")
DrawRect(closeX, closeY, closeSize, closeSize, overClose and {80, 55, 20, 245} or {35, 35, 35, 230})
UI_Color(255, 255, 255, 255)
SafeText(closeX + 5, closeY + 1, "X")
if bodyFont then draw.SetFont(bodyFont) end
local ty = y + headerH + 8
for i = 1, #GP_LoadInfoPopup.lines do
if i <= 3 then
UI_Color(255, 140, 0, 255)
else
UI_Color(text[1], text[2], text[3], 255)
end
SafeText(x + 14, ty, GP_LoadInfoPopup.lines[i])
ty = ty + lineH
end
if overLink then
UI_Color(255, 245, 170, 255)
else
UI_Color(gold[1], gold[2], gold[3], 210)
end
SafeText(linkX, linkY, linkText)
DrawRect(linkX, linkY + linkH + 1, linkW, overLink and 2 or 1, {
255,
overLink and 245 or gold[2],
overLink and 170 or gold[3],
overLink and 255 or 160
})
local feedbackNow = (globals and globals.RealTime and globals.RealTime()) or 0
if GP_LoadInfoPopup.feedback and feedbackNow < (GP_LoadInfoPopup.feedbackUntil or 0) then
UI_Color(190, 190, 190, 255)
SafeText(linkX + linkW + 12, linkY, GP_LoadInfoPopup.feedback)
end
_gp_noTransparent = prevNoTransparent
return true
end

function GP_DrawChangelogPopup(screenWidth, screenHeight, infoVisible)
if not (GP_ChangelogPopup and GP_ChangelogPopup.visible == true) then return false end
local seen = (config and tostring(config.changelogSeenVersion or "") == tostring(GP_CHANGELOG_VERSION))
if config and config.hideInfoOnLoad == true and seen then
GP_ChangelogPopup.visible = false
return false
end
screenWidth = screenWidth or (draw.GetScreenSize())
if not screenHeight then
screenWidth, screenHeight = draw.GetScreenSize()
end
local mousePos = input.GetMousePos()
local mx, my = mousePos[1] or 0, mousePos[2] or 0
local mouseDown = input.IsButtonDown(MOUSE_LEFT)
local mousePressed = mouseDown and not (GP_ChangelogPopup.lastMouseDown or false)
GP_ChangelogPopup.lastMouseDown = mouseDown
local prevNoTransparent = _gp_noTransparent
_gp_noTransparent = true
local w = math.min(420, math.max(320, screenWidth - 40))
local lineH = 16
local headerH = 28
local footerH = 8
local h = headerH + 12 + (#GP_ChangelogPopup.lines * lineH) + footerH
local defaultX = math.floor((screenWidth - w) / 2) + 35
local defaultY = math.floor(math.max(24, (screenHeight - h) / 2))
if infoVisible and GP_LoadInfoPopup and GP_LoadInfoPopup.visible == true then
local infoX = tonumber(GP_LoadInfoPopup.x) or defaultX
local infoY = tonumber(GP_LoadInfoPopup.y) or defaultY
local infoW = tonumber(GP_LoadInfoPopup.w) or 620
defaultX = infoX + infoW + 10
defaultY = infoY
if defaultX + w > screenWidth then
local leftX = infoX - w - 10
if leftX >= 0 then
defaultX = leftX
else
defaultX = math.max(0, math.floor((screenWidth - w) / 2))
defaultY = infoY + (tonumber(GP_LoadInfoPopup.h) or 260) + 10
end
end
end
local x = tonumber(GP_ChangelogPopup.x) or defaultX
local y = tonumber(GP_ChangelogPopup.y) or defaultY
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
local closeSize = 18
local closeX = x + w - closeSize - 8
local closeY = y + 5
local tabY = y + 4
local tab1X = x + 8
local tab1W = 138
local tab2X = tab1X + tab1W + 4
local tab2W = 126
local overClose = (mx >= closeX and mx <= closeX + closeSize and my >= closeY and my <= closeY + closeSize)
local overTab1 = (mx >= tab1X and mx <= tab1X + tab1W and my >= tabY and my <= tabY + 20)
local overTab2 = (mx >= tab2X and mx <= tab2X + tab2W and my >= tabY and my <= tabY + 20)
local overPopup = (mx >= x and mx <= x + w and my >= y and my <= y + h)
if mousePressed then
if overClose then
GP_CloseChangelogPopup()
elseif overTab1 then
GP_SetChangelogPage("1.3")
h = headerH + 12 + (#GP_ChangelogPopup.lines * lineH) + footerH
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
elseif overTab2 then
GP_SetChangelogPage("1.2")
h = headerH + 12 + (#GP_ChangelogPopup.lines * lineH) + footerH
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
elseif overPopup then
GP_ChangelogPopup.dragging = true
GP_ChangelogPopup.dragOffsetX = mx - x
GP_ChangelogPopup.dragOffsetY = my - y
end
elseif not mouseDown then
GP_ChangelogPopup.dragging = false
end
if GP_ChangelogPopup.dragging then
x = mx - (GP_ChangelogPopup.dragOffsetX or 0)
y = my - (GP_ChangelogPopup.dragOffsetY or 0)
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
end
if infoVisible and GP_LoadInfoPopup and GP_LoadInfoPopup.visible == true and not GP_ChangelogPopup.dragging then
local ix = tonumber(GP_LoadInfoPopup.x) or 0
local iy = tonumber(GP_LoadInfoPopup.y) or 0
local iw = tonumber(GP_LoadInfoPopup.w) or 0
local ih = tonumber(GP_LoadInfoPopup.h) or 0
local function overlaps(ax, ay, aw, ah, bx, by, bw, bh)
return ax < bx + bw and ax + aw > bx and ay < by + bh and ay + ah > by
end
if iw > 0 and ih > 0 and overlaps(x, y, w, h, ix, iy, iw, ih) then
local candidates = {
{ix + iw + 10, iy},
{ix - w - 10, iy},
{ix, iy + ih + 10},
{ix, iy - h - 10},
{math.max(0, math.floor((screenWidth - w) / 2)), math.max(0, math.floor((screenHeight - h) / 2))}
}
for i = 1, #candidates do
local cx = candidates[i][1]
local cy = candidates[i][2]
if cx >= 0 and cy >= 0 and cx + w <= screenWidth and cy + h <= screenHeight and not overlaps(cx, cy, w, h, ix, iy, iw, ih) then
x = cx
y = cy
break
end
end
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
end
if iw > 0 and ih > 0 and not overlaps(x, y, w, h, ix, iy, iw, ih) then
if x >= ix + iw or x + w <= ix then
y = iy
elseif y >= iy + ih or y + h <= iy then
x = ix
end
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + w > screenWidth then x = math.max(0, screenWidth - w) end
if y + h > screenHeight then y = math.max(0, screenHeight - h) end
end
end
GP_ChangelogPopup.x = x
GP_ChangelogPopup.y = y
closeX = x + w - closeSize - 8
closeY = y + 5
tabY = y + 4
tab1X = x + 8
tab2X = tab1X + tab1W + 4
overClose = (mx >= closeX and mx <= closeX + closeSize and my >= closeY and my <= closeY + closeSize)
overTab1 = (mx >= tab1X and mx <= tab1X + tab1W and my >= tabY and my <= tabY + 20)
overTab2 = (mx >= tab2X and mx <= tab2X + tab2W and my >= tabY and my <= tabY + 20)
local gold = {255, 215, 0, 255}
local titleFont = (UI and UI.mainFont) or (draw.CreateFont and draw.CreateFont("Verdana", 16, 400)) or nil
local bodyFont = (UI and UI.mainFont) or titleFont
DrawRect(x, y, w, h, {15, 15, 15, 245})
DrawRect(x, y, w, 2, {gold[1], gold[2], gold[3], 255})
DrawRect(x, y + h - 2, w, 2, {gold[1], gold[2], gold[3], 255})
if titleFont then draw.SetFont(titleFont) end
local activeVersion = tostring(GP_ChangelogPopup.activeVersion or "1.3")
local function drawTab(tx, tw, label, active, hovered)
local bg
if active then
bg = {62, 51, 15, 245}
elseif hovered then
bg = {48, 48, 48, 240}
else
bg = {30, 30, 30, 230}
end
DrawRect(tx, tabY, tw, 20, bg)
if active then
DrawRect(tx, tabY + 18, tw, 2, {gold[1], gold[2], gold[3], 255})
UI_Color(gold[1], gold[2], gold[3], 255)
else
UI_Color(205, 205, 205, 245)
end
SafeText(tx + 7, tabY + 3, label)
end
drawTab(tab1X, tab1W, "Changelog 1.3", activeVersion == "1.3", overTab1)
drawTab(tab2X, tab2W, "Changelog 1.2", activeVersion == "1.2", overTab2)
DrawRect(closeX, closeY, closeSize, closeSize, overClose and {80, 55, 20, 245} or {35, 35, 35, 230})
UI_Color(255, 255, 255, 255)
SafeText(closeX + 5, closeY + 1, "X")
if bodyFont then draw.SetFont(bodyFont) end
local ty = y + headerH + 8
for i = 1, #GP_ChangelogPopup.lines do
local rec = GP_ChangelogPopup.lines[i]
local line
local isHeader = false
if type(rec) == "table" then
line = tostring(rec[1] or "")
isHeader = (rec[2] == true)
else
line = tostring(rec or "")
end
if isHeader then
UI_Color(gold[1], gold[2], gold[3], 255)
SafeText(x + 14, ty, line)
else
UI_Color(255, 255, 255, 235)
SafeText(x + 24, ty, line)
end
ty = ty + lineH
end
_gp_noTransparent = prevNoTransparent
return true
end
local function ResetRuntimeState(reason)
if reason ~= nil and reason ~= "" and reason ~= "SniperBuy Enabled - Reset state" then
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
if r == "SniperBuy Enabled - Reset state" then
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
and ((r == "Loading/Disconnected - Reset state") or (r == "Joined game - Reset state") or (tpForceModeEnabled and r == "SniperBuy Enabled - Reset state"))
and (not stickyMismatch)
local preserveTpDrop = (config and config.tpDropAutoKillEnabled == true)
and (r == "Loading/Disconnected - Reset state" or r == "SniperBuy Enabled - Reset state")
and (type(tpDropAutoKillBaseX) == "number" and type(tpDropAutoKillBaseY) == "number" and type(tpDropAutoKillBaseZ) == "number")
local keepTpDropActive = tpDropAutoKillActive
local keepTpDropBaseX = tpDropAutoKillBaseX
local keepTpDropBaseY = tpDropAutoKillBaseY
local keepTpDropBaseZ = tpDropAutoKillBaseZ
local keepTpDropUntil = tpDropAutoKillUntil
local keepTpDropNextCheck = tpDropAutoKillNextCheck
local keepTpDropLastKill = tpDropAutoKillLastKill
local keepTpDropLastArm = tpDropAutoKillLastArm
local keepTpDropFastUntil = tpDropAutoKillFastUntil
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
tpDropAutoKillActive = false
tpDropAutoKillBaseX = nil
tpDropAutoKillBaseY = nil
tpDropAutoKillBaseZ = nil
tpDropAutoKillUntil = 0
tpDropAutoKillNextCheck = 0
tpDropAutoKillMissCount = 0
tpDropAutoKillDeadTicks = 0
tpDropAutoKillLastKill = 0
tpDropAutoKillLastArm = 0
tpDropAutoKillFastUntil = 0
tpDropManualNearUntil = 0
tpDropManualScanNext = 0
tpDropManualLastTime = 0
tpDropEventArmPending = false
tpDropEventArmAt = 0
tpDropEventArmUntil = 0
tpDropManualLastX = nil
tpDropManualLastY = nil
tpDropManualLastZ = nil
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
ResetRuntimeState(r)
if preserveTpDrop then
tpDropAutoKillActive = keepTpDropActive == true
tpDropAutoKillBaseX = keepTpDropBaseX
tpDropAutoKillBaseY = keepTpDropBaseY
tpDropAutoKillBaseZ = keepTpDropBaseZ
tpDropAutoKillUntil = keepTpDropUntil
tpDropAutoKillNextCheck = keepTpDropNextCheck
tpDropAutoKillLastKill = keepTpDropLastKill
tpDropAutoKillMissCount = 0
tpDropAutoKillDeadTicks = 0
tpDropAutoKillLastArm = keepTpDropLastArm
tpDropAutoKillFastUntil = keepTpDropFastUntil
end
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
if cls == "sniper" then
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
if config and (config.autoWalkEnabled == true) then
GP_SetAutoCreditEnabled(true, false)
end
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
if GP_TP_ResetManualDropAutoKill then
pcall(GP_TP_ResetManualDropAutoKill)
end
tpDropAutoKillNextCheck = 0
tpDropAutoKillLastKill = currentTime - 1.0
tpDropAutoKillLastArm = 0
tpDropAutoKillFastUntil = currentTime + 6.0
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
local function onStringCmd(cmd)
local command = cmd:Get()
local args = {}
for word in string.gmatch(command:lower(), "%S+") do
table.insert(args, word)
end
local firstCommand = tostring(command or ""):lower():match("^%s*([^;%s]+)")
if firstCommand == "retry" then
local nowRetryCommand = GP_ReconnectNow()
local scriptedRetry = nowRetryCommand <= (gpInternalRetryCommandUntil or 0)
gpInternalRetryCommandUntil = 0
if not scriptedRetry then
gpManualRetrySuppressNextAttach = true
GP_ClearReconnectClassPending()
GP_ClearReconnectFeatureRearm()
GP_ClearFirstJoinPickMedicWindow()
gpFirstJoinPickMedicDone = true
pendingRetry = false
pendingRetryTargetClass = nil
pendingRetryTargetUntil = 0
else
gpManualRetrySuppressNextAttach = false
end
end
if args[1] == "gp_gm_cash" then
local threshold = tonumber(args[2])
if threshold then
if threshold > 0 then
config.moneyThreshold = threshold
SaveConfig(GP_CfgPath(), config)
if gpDropdown and gpDropdown.state ~= "cash" and gpDropdown.lastCashNotified ~= config.moneyThreshold then
gpDropdown.lastCashNotified = config.moneyThreshold
AddNotification("Money threshold set to $" .. tostring(config.moneyThreshold), "success")
end
AddNotification("Money threshold set to $" .. threshold, "success")
else
AddNotification("Threshold must be greater than 0", "error")
end
else
AddNotification("Invalid threshold value", "error")
end
cmd:Set("")
return false
elseif args[1] == "gp_gm_class" then
local validClasses = {
["scout"] = true,
["soldier"] = true,
["pyro"] = true,
["demoman"] = true,
["heavy"] = true,
["engineer"] = true,
["medic"] = true,
["sniper"] = true,
["spy"] = true
}
if args[2] == "off" then
config.changeClassEnabled = false
SaveConfig(GP_CfgPath(), config)
AddNotification("Auto class change disabled", "success")
elseif validClasses[args[2]] then
config.changeClassEnabled = true
config.targetClass = args[2]
SaveConfig(GP_CfgPath(), config)
AddNotification("Target class set to " .. tostring(args[2]) .. " after threshold", "success")
else
AddNotification("Invalid class name", "error")
end
cmd:Set("")
return false
end
end
callbacks.Register("SendStringCmd", __GM_CALLBACK_IDS.thresholdCommand, onStringCmd)
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
if _cls ~= "sniper" then
AddNotification("Use Force TpWalk to bypass class restrictions", "info", 5.0)
end
AddNotification("TpWalk Enabled (Death/Respawn as Sniper or SniperBuy activates it)", "info", 4.0)
else
AddNotification("TpWalk Disabled", "info")
end
end
end
function GP_SetTpForceEnabled(enabled, notify)
local wantEnable = (enabled and true or false)
tpForceModeEnabled = wantEnable
config.forceTpWalkEnabled = tpForceModeEnabled
tpLastForceToggleAt = globals.CurTime() or 0
tpIgnoreShortToggleUntil = (globals.CurTime() or 0) + 1.20
tpSkipNextShortToggle = true
if tpForceModeEnabled then
config.tpWalkEnabled = false
tpToggleNeedsTrigger = false
teleporterManuallyDisabled = false
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
tpRespawnRearmPending = false
tpForceRestoreAwaitRespawn = true
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
sniperUpgradeCompleted = true
sniperUpgradeCompletedTime = globals.CurTime() or 0
tpStickyArmed = true
local ip = (engine and engine.GetServerIP and engine.GetServerIP()) or ""
if ip == "" then ip = currentServer or "" end
tpStickyServerIP = ip
GP_TP_ArmSpawnToggleLock()
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
local _lp = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
if _lp and _lp.IsAlive and (not _lp:IsAlive()) then
tpRespawnRearmPending = true
end
else
GP_SetTpWalkEnabled(false, false)
tpToggleNeedsTrigger = false
teleporterManuallyDisabled = true
teleporterConfig.autoWalkEnabled = false
teleporterJustUsed = false
GP_TP_StopUseVerify()
tpRespawnRearmPending = false
tpForceRestoreAwaitRespawn = false
tpWaitForRoundReload = false
tpWaitForRoundReloadReason = ""
tpToggleSpawnLock = false
tpStickyArmed = false
tpStickyServerIP = ""
config.tpWalkEnabled = false
config.forceTpWalkEnabled = false
tpForceModeEnabled = false
if not sniperUpgradesComplete then
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
end
GP_TP_ResetPathState()
GP_TP_ResetStuckTracker()
end
SaveConfig(GP_CfgPath(), config)
if notify then
if tpForceModeEnabled then
AddNotification("Force TpWalk Enabled", "warning")
AddNotification("Force TpWalk waits for death/respawn (all classes)", "warning", 4.0)
else
AddNotification("Force TpWalk Disabled", "info")
end
end
return true
end
function GP_SetForceSniperBuyEnabled(enabled, notify)
local wantEnabled = (enabled and true or false)
if wantEnabled then
if config.autoBuyEnabled then
config.autoBuyEnabled = false
end
sniperReloadAwaitRespawn = false
sniperReloadRespawnPending = false
sniperLastAliveState = nil
end
forceSniperBuyModeEnabled = wantEnabled
config.forceSniperBuyEnabled = forceSniperBuyModeEnabled
if wantEnabled then
gpStickyAutoBuyEnabled = false
end
gpStickyForceSniperBuyEnabled = forceSniperBuyModeEnabled
forceSniperBuyZoneLatch = false
forceSniperBuyLastTry = 0
if not wantEnabled then
sniperSkipNextShortToggle = true
sniperBlockShortToggleOnRelease = true
local now = (globals and globals.CurTime and globals.CurTime()) or 0
sniperIgnoreShortToggleUntil = now + 0.90
end
shouldGuidePlayerBuy = false
buyMidpoint = nil
buySpawnAnchor = nil
medicSpawnAnchor = nil
SaveConfig(GP_CfgPath(), config)
if notify then
if forceSniperBuyModeEnabled then
AddNotification("Force SniperBuy Enabled - station only (no autowalk)", "warning")
else
AddNotification("Force SniperBuy Disabled", "info")
end
end
return true
end
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
function GP_TP_ClearDropAutoKill()
tpDropAutoKillActive = false
tpDropAutoKillBaseX = nil
tpDropAutoKillBaseY = nil
tpDropAutoKillBaseZ = nil
tpDropAutoKillUntil = 0
tpDropAutoKillNextCheck = 0
tpDropAutoKillMissCount = 0
tpDropAutoKillDeadTicks = 0
tpDropAutoKillLastKill = 0
tpDropAutoKillFastUntil = 0
end
function GP_TP_DropAutoKillLocked()
if not (config and config.tpDropAutoKillEnabled == true) then return false end
if not (type(tpDropAutoKillBaseX) == "number" and type(tpDropAutoKillBaseY) == "number" and type(tpDropAutoKillBaseZ) == "number") then return false end
return true
end
function GP_TP_ArmDropAutoKill(pos, now)
if not (config and config.tpDropAutoKillEnabled == true) then return end
if not pos then return end
local t = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
local quietArm = ((t - (tpDropAutoKillLastArm or 0)) < 0.50)
tpDropAutoKillActive = true
tpDropAutoKillBaseX = pos.x
tpDropAutoKillBaseY = pos.y
tpDropAutoKillBaseZ = pos.z
tpDropAutoKillUntil = 0
tpDropAutoKillNextCheck = t + 0.15
tpDropAutoKillMissCount = 0
tpDropAutoKillDeadTicks = 0
tpDropAutoKillLastKill = t - 1.0
tpDropAutoKillLastArm = t
tpDropAutoKillFastUntil = t + 6.0
if quietArm then return end
AddNotification("Tp Position Lost - Kill armed", "info")
end
function GP_TP_ResetManualDropAutoKill()
tpDropManualNearUntil = 0
tpDropManualScanNext = 0
tpDropManualLastTime = 0
tpDropEventArmPending = false
tpDropEventArmAt = 0
tpDropEventArmUntil = 0
tpDropManualLastX = nil
tpDropManualLastY = nil
tpDropManualLastZ = nil
end
function GP_TP_EventMatchesLocalPlayer(ev)
local me = (entities and entities.GetLocalPlayer and entities.GetLocalPlayer()) or nil
if not me then return false end
local localIndex = nil
if me.GetIndex then
local okIndex, idx = pcall(function() return me:GetIndex() end)
if okIndex and type(idx) == "number" then localIndex = idx end
end
local localUserID = nil
if client and client.GetPlayerInfo and localIndex then
local okInfo, info = pcall(function() return client.GetPlayerInfo(localIndex) end)
if okInfo and type(info) == "table" then
localUserID = tonumber(info.UserID or info.UserId or info.userid or info.userID)
end
end
local entityKeys = {"entindex", "entityid", "entity_id", "player", "index"}
for i = 1, #entityKeys do
local v = GP_PartyEventInt and GP_PartyEventInt(ev, entityKeys[i]) or nil
if localIndex and v and tonumber(v) == tonumber(localIndex) then
return true
end
end
local userKeys = {"userid", "user_id"}
for i = 1, #userKeys do
local v = GP_PartyEventInt and GP_PartyEventInt(ev, userKeys[i]) or nil
if localUserID and v and tonumber(v) == tonumber(localUserID) then
return true
end
end
return false
end
function GP_TP_HandleTeleportEvent(name, ev)
local n = string.lower(tostring(name or ""))
if n ~= "player_teleported" and n ~= "player_teleport" then return end
if not (config and config.tpDropAutoKillEnabled == true) then return end
if not GP_TP_EventMatchesLocalPlayer(ev) then return end
local now = (globals and globals.CurTime and globals.CurTime()) or 0
tpDropEventArmPending = true
tpDropEventArmAt = now + 0.10
tpDropEventArmUntil = now + 1.25
tpDropManualNearUntil = now + 1.25
end
function GP_TP_IsNearManualTeleporter(me, pos)
if not (me and pos and entities) then return false end
local myTeam = (me.GetTeamNumber and me:GetTeamNumber()) or -1
local function considerEntity(entity, className)
if not (entity and entity.GetAbsOrigin and GP_TP_IsUsableTeleporter(entity)) then return false end
local mode = -1
if entity.GetPropInt then
local okMode, m = pcall(function() return entity:GetPropInt("m_iObjectMode") end)
if okMode and type(m) == "number" then mode = m end
end
local isEntrance = (className == "CObjectTeleporterEntrance") or (mode == 0)
if not isEntrance then return false end
local team = (entity.GetTeamNumber and entity:GetTeamNumber()) or -1
if not (team == -1 or myTeam == -1 or team == myTeam) then return false end
local epos = entity:GetAbsOrigin()
if not epos then return false end
return GP_TP_GetDistance(pos, epos) <= 160
end
local function considerClass(className)
if not entities.FindByClass then return false end
local okList, list = pcall(function() return entities.FindByClass(className) end)
if not okList or type(list) ~= "table" then return false end
for i = 1, #list do
if considerEntity(list[i], className) then
return true
end
end
return false
end
if considerClass("CObjectTeleporterEntrance") or considerClass("CObjectTeleporter") or considerClass("CObjectTeleporterExit") then
return true
end
if not (entities.GetHighestEntityIndex and entities.GetByIndex) then return false end
local highest = entities.GetHighestEntityIndex() or 2048
for i = 0, highest do
local entity = entities.GetByIndex(i)
if entity and entity.GetClass and entity.GetAbsOrigin then
local className = entity:GetClass()
if className == "CObjectTeleporter" or className == "CObjectTeleporterEntrance" or className == "CObjectTeleporterExit" then
if considerEntity(entity, className) then
return true
end
end
end
end
return false
end
function GP_TP_TickManualDropAutoKill(me, now)
now = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
if (tpDropManualLastTime or 0) > 0 and now < ((tpDropManualLastTime or 0) - 0.50) then
GP_TP_ResetManualDropAutoKill()
end
tpDropManualLastTime = now
if not (config and config.tpDropAutoKillEnabled == true) then
GP_TP_ResetManualDropAutoKill()
return
end
if not (me and me.GetAbsOrigin) then
return
end
if me.IsAlive and (not me:IsAlive()) then
GP_TP_ResetManualDropAutoKill()
return
end
local pos = me:GetAbsOrigin()
if not pos then return end
if tpDropEventArmPending == true then
if now > (tpDropEventArmUntil or 0) then
tpDropEventArmPending = false
tpDropEventArmAt = 0
tpDropEventArmUntil = 0
elseif now >= (tpDropEventArmAt or 0) then
GP_TP_ArmDropAutoKill(pos, now)
tpDropEventArmPending = false
tpDropEventArmAt = 0
tpDropEventArmUntil = 0
tpDropManualNearUntil = 0
tpDropManualLastX = pos.x
tpDropManualLastY = pos.y
tpDropManualLastZ = pos.z
return
end
end
if (tpDropManualScanNext or 0) > (now + 1.0) then
tpDropManualScanNext = 0
tpDropManualNearUntil = 0
tpDropManualLastX = nil
tpDropManualLastY = nil
tpDropManualLastZ = nil
end
if now >= (tpDropManualScanNext or 0) then
tpDropManualScanNext = now + 0.25
if GP_TP_IsNearManualTeleporter(me, pos) then
tpDropManualNearUntil = now + 4.0
end
end
if tpDropManualLastX and (tpDropManualNearUntil or 0) >= now then
local dx = pos.x - (tonumber(tpDropManualLastX) or pos.x)
local dy = pos.y - (tonumber(tpDropManualLastY) or pos.y)
local dz = pos.z - (tonumber(tpDropManualLastZ) or pos.z)
local moved = math.sqrt(dx*dx + dy*dy + dz*dz)
if moved >= 130 then
GP_TP_ArmDropAutoKill(pos, now)
tpDropManualNearUntil = 0
end
end
tpDropManualLastX = pos.x
tpDropManualLastY = pos.y
tpDropManualLastZ = pos.z
end
function GP_TP_TickDropAutoKill(me, now)
now = now or ((globals and globals.CurTime and globals.CurTime()) or 0)
if not tpDropAutoKillActive then
if GP_TP_DropAutoKillLocked(now) then
tpDropAutoKillActive = true
else
return
end
end
if not (config and config.tpDropAutoKillEnabled == true) then
GP_TP_ClearDropAutoKill()
return
end
if not (me and me.GetAbsOrigin) then
tpDropAutoKillMissCount = (tpDropAutoKillMissCount or 0) + 1
return
end
if me.IsAlive and (not me:IsAlive()) then
tpDropAutoKillDeadTicks = (tpDropAutoKillDeadTicks or 0) + 1
if (tpDropAutoKillDeadTicks or 0) < 6 then return end
GP_TP_ClearDropAutoKill()
return
end
tpDropAutoKillMissCount = 0
tpDropAutoKillDeadTicks = 0
local p = me:GetAbsOrigin()
if not p then
tpDropAutoKillMissCount = (tpDropAutoKillMissCount or 0) + 1
return
end
if (tpDropAutoKillNextCheck or 0) > (now + 3.0) then
tpDropAutoKillNextCheck = 0
end
if (tpDropAutoKillFastUntil or 0) > (now + 20.0) then
tpDropAutoKillFastUntil = now + 6.0
end
if tpDropAutoKillBaseX == nil or tpDropAutoKillBaseY == nil or tpDropAutoKillBaseZ == nil then
tpDropAutoKillBaseX = p.x
tpDropAutoKillBaseY = p.y
tpDropAutoKillBaseZ = p.z
tpDropAutoKillNextCheck = now + 0.35
return
end
local lossX = math.abs(p.x - (tonumber(tpDropAutoKillBaseX) or p.x))
local lossY = math.abs(p.y - (tonumber(tpDropAutoKillBaseY) or p.y))
local lossZ = math.abs(p.z - (tonumber(tpDropAutoKillBaseZ) or p.z))
local lossDist = math.sqrt(lossX*lossX + lossY*lossY + lossZ*lossZ)
if lossX >= 70 or lossY >= 70 or lossZ >= 70 or lossDist >= 70 then
if (tpDropAutoKillLastKill or 0) > now then
tpDropAutoKillLastKill = now - 1.0
end
if (now - (tpDropAutoKillLastKill or 0)) >= 1.0 then
tpDropAutoKillLastKill = now
AddNotification("Position Lost - Kill", "warning")
pcall(function()
if client and client.Command then client.Command("kill", true) end
end)
end
return
end
if now < (tpDropAutoKillNextCheck or 0) then return end
if now < (tpDropAutoKillFastUntil or 0) then
tpDropAutoKillNextCheck = now + 0.35
else
tpDropAutoKillNextCheck = now + 1.0
end
end
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
GP_TP_ArmDropAutoKill(curPos, now)
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
if (not killCooldownActive) and ((now - (tpUseVerifyStart or now)) >= (TP_TELE_USE_VERIFY_SECONDS or 40.0)) then
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
if (currentTime - (tpStuckLastProgressTime or currentTime)) >= (TP_STUCK_TIMEOUT or 40.0) then
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
if (currentTime - (tpStuckLastProgressTime or currentTime)) >= (TP_STUCK_TIMEOUT or 40.0) then
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

function GP_TP_GetPlayerPriorityAny(arg)
if not playerlist or not playerlist.GetPriority then return nil end
local ok, v = pcall(function() return playerlist.GetPriority(arg) end)
if ok then return v end
local ok2, v2 = pcall(function() return playerlist.GetPriority(playerlist, arg) end)
if ok2 then return v2 end
return nil
end

function GP_TP_IsBuilderWhitelisted(builder)
if not builder then return false end
local pri = GP_TP_GetPlayerPriorityAny(builder)
if type(pri) == "number" then return pri > 0 end
if type(pri) == "boolean" then return pri end
if type(pri) == "string" then
local s = string.lower(pri)
if s == "friend" or s == "high" or s == "true" or s == "1" or s == "2" then return true end
end
local okIdx, idx = pcall(function() return builder:GetIndex() end)
if okIdx and idx then
local priIdx = GP_TP_GetPlayerPriorityAny(idx)
if type(priIdx) == "number" then return priIdx > 0 end
if type(priIdx) == "boolean" then return priIdx end
end
return false
end

function GP_TP_TeleporterPassesWhitelist(entity)
if not (config and config.tpWalkWhitelistEnabled == true) then return true end
local builder = GP_TP_GetBuilderForWhitelist(entity)
if not builder then return false end
return GP_TP_IsBuilderWhitelisted(builder)
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
local maxDist = teleporterConfig.maxScanDistance or 40000
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
if not GP_TP_TeleporterPassesWhitelist(entity) then return end

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

function GP_DisableSniperBuyRuntime(preserveTpTraversal)
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
function ProcessExploitQueue()
local currentTime = globals.CurTime()
local qlen = upgradeQueue and #upgradeQueue or 0
GP_CheckSniperUpgradeDone(qlen)
if sequenceEndTime > 0 and currentTime < sequenceEndTime then return end
sequenceEndTime = 0
if #upgradeQueue == 0 then
if isExploiting then
engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "0" }')
AddNotification("Sequence completed!", "success")
isExploiting = false
respawnExpected = true
shouldGuidePlayer = false
local endCooldown = SEQUENCE_END_COOLDOWN
if config and config.autoWalkEnabled then
endCooldown = 0
end
sequenceEndTime = currentTime + endCooldown
nextUpgradeTime = currentTime + endCooldown
upgradeQueue = {{type = "cleanup"}}
end
if isUpgradingSniper then
engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "0" }')
AddNotification("Sniper upgrades completed!", "success")
isUpgradingSniper = false
sniperUpgradesComplete = true
GP_OnSniperUpgradesComplete("queue_done")
autobuyRunOnceDone = true
gpPhase = "DONE"
sniperUpgradeCooldownUntil = currentTime + SNIPER_COOLDOWN_TIME
sequenceEndTime = currentTime + SEQUENCE_END_COOLDOWN
nextUpgradeTime = currentTime + SEQUENCE_END_COOLDOWN
end
return
end
local currentAction = upgradeQueue[1]
if currentAction.type == "respec" then
respawnExpected = true
end
if currentTime < nextUpgradeTime then
return
end
local action = table.remove(upgradeQueue, 1)
if action.type == "cleanup" then
ForceCleanup()
return
end
local ok = true
if action.type == "begin" then
ok = engine.SendKeyValues('"MVM_UpgradesBegin" {}')
elseif action.type == "upgrade" then
ok = SendMvMUpgrade(action.slot, action.id, action.count)
elseif action.type == "respec" then
ok = engine.SendKeyValues('"MVM_Respec" {}')
elseif action.type == "end" then
ok = engine.SendKeyValues('"MVM_UpgradesDone" { "num_upgrades" "' .. action.count .. '" }')
end
if not ok then
if isUpgradingSniper then
action._retries = (action._retries or 0) + 1
if action._retries <= SNIPER_MAX_RETRIES then
table.insert(upgradeQueue, 1, action)
nextUpgradeTime = currentTime + SNIPER_RETRY_DELAY
return
else
AddNotification("SniperBuy: Sniper upgrades stalled - restarting sequence", "warning")
ForceCleanup()
sniperUpgradesComplete = false
sniperUpgradeCompleted = false
sniperUpgradeCompletedTime = 0
teleporterJustUsed = false
tpLastReachedTeleporterAt = 0
teleporterManuallyDisabled = false
sniperUpgradeCooldownUntil = currentTime + 0.25
return
end
elseif isExploiting then
action._retries = (action._retries or 0) + 1
if action._retries <= MEDIC_MAX_RETRIES then
table.insert(upgradeQueue, 1, action)
nextUpgradeTime = currentTime
return
else
AddNotification("SniperBuy: Medic sequence stalled - forcing cleanup", "warning")
ForceCleanup()
return
end
end
end
nextUpgradeTime = currentTime + (isUpgradingSniper and SNIPER_UPGRADE_DELAY or UPGRADE_DELAY)
end
function HasVaccinator(player)
if not player then return false end
local secondaryWeapon = player:GetEntityForLoadoutSlot(LOADOUT_POSITION_SECONDARY)
if not secondaryWeapon then return false end
local weaponId = secondaryWeapon:GetPropInt("m_iItemDefinitionIndex")
return weaponId == 998
end

function GP_ResetSniperBuyProgressState()
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
HardReset("SniperBuy Enabled - Reset state")
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
sniperReloadAwaitRespawn = true
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

function GP_SetAutoCreditEnabled(enabled, notify)
local wantEnable = (enabled and true or false)
local me = entities.GetLocalPlayer()
local wasEnabled = (config and config.autoWalkEnabled == true)
config.autoWalkEnabled = wantEnable
if wantEnable then
local preWave = ((GP_HasExplicitPreWave1Proof and GP_HasExplicitPreWave1Proof()) or false)
if not wasEnabled then
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
end
autoWalkPaused = false
autoWalkPauseReason = nil
shouldGuidePlayer = false
midpoint = nil
autoModeWalkActive = false
lastAutoWalkPauseReason = nil
if not preWave then
autoWalkPaused = true
autoWalkPauseReason = "after_wave1"
shouldGuidePlayer = false
midpoint = nil
lastAutoWalkPauseReason = "after_wave1"
if notify then
AddNotification("AutoCredit only works before Wave 1 starts and with 600+ starting credits", "warning", 4.0)
end
else
local enableReason = nil
if me then
if not IsMedic(me) then
enableReason = "not_medic"
elseif not HasVaccinator(me) then
enableReason = "no_vacc"
end
lastAutoWalkPauseReason = enableReason
else
lastAutoWalkPauseReason = nil
end
end
if notify then AddNotification("AutoCredit Enabled - Reset state", "info") end
else
autoWalkPaused = false
autoWalkPauseReason = nil
shouldGuidePlayer = false
midpoint = nil
lastAutoWalkPauseReason = nil
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
if notify then AddNotification("AutoCredit Disabled", "info") end
end
thresholdNotificationShown = false
SaveConfig(GP_CfgPath(), config)
return true
end
function GP_CaptureActiveToggleSnapshot()
return {
autoWalkEnabled = (config and config.autoWalkEnabled == true),
autoBuyEnabled = (config and config.autoBuyEnabled == true),
forceSniperBuyEnabled = (forceSniperBuyModeEnabled == true) or (config and config.forceSniperBuyEnabled == true),
tpWalkEnabled = (config and config.tpWalkEnabled == true),
forceTpWalkEnabled = (tpForceModeEnabled == true) or (config and config.forceTpWalkEnabled == true),
}
end
function GP_SnapshotHasAnyActive(snapshot)
if type(snapshot) ~= "table" then return false end
return (snapshot.autoWalkEnabled == true)
or (snapshot.autoBuyEnabled == true)
or (snapshot.forceSniperBuyEnabled == true)
or (snapshot.tpWalkEnabled == true)
or (snapshot.forceTpWalkEnabled == true)
end
function GP_DisableAllActiveToggles(notify)
local hadAny = false
if config.autoWalkEnabled then
hadAny = true
GP_SetAutoCreditEnabled(false, false)
end
if forceSniperBuyModeEnabled or config.forceSniperBuyEnabled then
hadAny = true
GP_SetForceSniperBuyEnabled(false, false)
end
if config.autoBuyEnabled or gpStickyAutoBuyEnabled then
hadAny = true
config.autoBuyEnabled = false
gpStickyAutoBuyEnabled = false
gpStickyForceSniperBuyEnabled = false
GP_DisableSniperBuyRuntime()
ForceCleanup()
end
if tpForceModeEnabled or config.forceTpWalkEnabled then
hadAny = true
GP_SetTpForceEnabled(false, false)
end
if config.tpWalkEnabled then
hadAny = true
GP_SetTpWalkEnabled(false, false)
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
SaveConfig(GP_CfgPath(), config)
if notify then
if hadAny then
AddNotification("All active toggles disabled (Press again within 60s to restore previous toggles)", "info")
else
AddNotification("No active toggles to disable", "info")
end
end
return hadAny
end
function GP_RestoreActiveToggleSnapshot(snapshot, notify)
if type(snapshot) ~= "table" then
if notify then
AddNotification("No previous toggle state to restore", "info")
end
return false
end
local hadAny = GP_SnapshotHasAnyActive(snapshot)
GP_DisableAllActiveToggles(false)
if snapshot.autoWalkEnabled then
GP_SetAutoCreditEnabled(true, false)
end
if snapshot.forceSniperBuyEnabled then
GP_SetForceSniperBuyEnabled(true, false)
elseif snapshot.autoBuyEnabled then
if forceSniperBuyModeEnabled then
GP_SetForceSniperBuyEnabled(false, false)
end
config.autoBuyEnabled = true
GP_EnableSniperBuyRuntime(((GP_TP_IsTraversalActive and GP_TP_IsTraversalActive()) and true or false))
SaveConfig(GP_CfgPath(), config)
end
if snapshot.forceTpWalkEnabled then
GP_SetTpForceEnabled(true, false)
elseif snapshot.tpWalkEnabled then
GP_SetTpWalkEnabled(true, false)
end
if notify then
if hadAny then
AddNotification("Toggles restored", "success")
else
AddNotification("Previous state had no active toggles", "info")
end
end
return hadAny
end
local GP_IsSniper
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
function TriggerMoneyExploit()
local currentTime = globals.CurTime()
if currentTime < (medicTriggerDebounceUntil or 0) then
return
end
medicTriggerDebounceUntil = currentTime + MEDIC_TRIGGER_DEBOUNCE
if isExploiting then
return
end
local exploitCooldown = COOLDOWN_TIME or 0.5
if config and config.autoWalkEnabled then
exploitCooldown = math.min(exploitCooldown, 0.05)
end
if currentTime - lastExploitTime < exploitCooldown then return end
if sequenceEndTime > 0 and currentTime < sequenceEndTime then return end
if IsMvMWaveActive() then
shouldGuidePlayer = false
if config.changeClassEnabled and not hasTriedClassChange and currentTime - lastRetryTime > RETRY_COOLDOWN then
local meRetry = entities.GetLocalPlayer()
local retryTarget = GP_GetPostWaveStationSwapTarget(meRetry)
if retryTarget and retryTarget ~= "" then
AddNotification("Wave active - Reconnecting to change class", "warning")
pendingRetry = true
pendingRetryTargetClass = retryTarget
pendingRetryTargetUntil = currentTime + 90.0
lastRetryTime = currentTime
hasTriedClassChange = true
GP_IssueRetryWithAutoClass(retryTarget)
end
end
return
end
local gpMedicHardResetPendingNow = (GP_RST and GP_RST.medicCycleHardResetPending == true)
if IsMoneyThresholdReached() and (not gpMedicHardResetPendingNow) then
local me = entities.GetLocalPlayer()
local inZone = false
if me and me.GetPropInt then
inZone = (me:GetPropInt('m_bInUpgradeZone') == 1)
end
GP_OnThresholdReached(me, currentTime, inZone, false)
return
end
local me = entities.GetLocalPlayer()
if not me then
AddNotification("Local player not found!", "error")
return
end
if me:GetPropInt('m_bInUpgradeZone') ~= 1 then
AddNotification("Must be in upgrade zone!", "error")
return
end
if not me:IsAlive() then
AddNotification("Must be alive to use!", "error")
return
end
if not IsMedic(me) then
AddNotification("Must be Medic for this sequence!", "error")
return
end
if not HasVaccinator(me) then
AddNotification("Equip Vaccinator (secondary) first!", "error")
return
end
lastExploitTime = currentTime
isExploiting = true
if GP_RST then
GP_RST.medicCycleHardResetPending = false
GP_RST.medicCycleHardResetSince = 0
GP_RST.medicCycleSwapLockUntil = GP_RST_Now() + 12.0
end
if misc then misc.acStartedOnce = true end
cashGenEntryCount = (cashGenEntryCount or 0) + 1
if cashGenEntryCount == 1 or (cashGenEntryCount % 4 == 0) then
AddNotification("Generating cash", "success")
end
upgradeQueue = {
{type = "begin"},
{type = "upgrade", slot = 1, id = 19, count = 2},
{type = "upgrade", slot = 1, id = 19, count = -2},
{type = "upgrade", slot = 1, id = 19, count = 2},
{type = "respec"},
{type = "end", count = 2}
}
nextUpgradeTime = currentTime + UPGRADE_DELAY
end
function __GM_PART2__()
local watermarkX = config.watermarkX
local watermarkY = config.watermarkY
local isDragging = false
local dragOffsetX, dragOffsetY = 0, 0
local uiClampSavedAt = 0
function ClampUIPos(screenW, screenH, boxW, boxH)
local x, y = watermarkX, watermarkY
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if x + boxW > screenW then x = screenW - boxW end
if y + boxH > screenH then y = screenH - boxH end
if x < 0 then x = 0 end
if y < 0 then y = 0 end
local changed = (x ~= watermarkX) or (y ~= watermarkY)
watermarkX, watermarkY = x, y
return changed
end
local GP_UI = {
font = draw.CreateFont("Tahoma", 16, 600),
font2 = draw.CreateFont("Verdana", 15, 400),
colors = {
gold = {255, 215, 0, 255},
background = {15, 15, 15, 230},
text = {255, 255, 255, 255},
textDim = {180, 180, 180, 255},
barBg = {40, 35, 20, 255},
barFill = {255, 215, 0, 255}
}
}
GP_PICK_KEYS = GP_PICK_KEYS or {}
if #GP_PICK_KEYS == 0 then
local tmp = {}
for name, code in pairs(_G) do
if type(name) == "string" and type(code) == "number" and name:match("^KEY_") then
if not name:match("MOUSE") and not name:match("MWHEEL") and not name:match("BUTTON") and not name:match("LBUTTON") and not name:match("RBUTTON") and not name:match("MBUTTON") then
if not name:match("SHIFT") and not name:match("CONTROL") and not name:match("^KEY_LALT$") and not name:match("^KEY_RALT$") then
if name ~= "KEY_ESCAPE" then
tmp[#tmp + 1] = code
end
end
end
end
end
table.sort(tmp)
local last = nil
for i = 1, #tmp do
local c = tmp[i]
if c ~= last then
GP_PICK_KEYS[#GP_PICK_KEYS + 1] = c
last = c
end
end
end
__keyNameCache = __keyNameCache or {}
function GP_KeyName(code)
if type(code) ~= "number" then return "?" end
if __keyNameCache[code] then return __keyNameCache[code] end
for name, c in pairs(_G) do
if c == code and type(name) == "string" and name:match("^KEY_") then
local s = name:gsub("^KEY_", "")
__keyNameCache[code] = s
return s
end
end
__keyNameCache[code] = tostring(code)
return __keyNameCache[code]
end
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
function GP_KeyPressedBind(code)
if type(code) ~= "number" then return false end
local down = input.IsButtonDown(code)
local was = misc.keyPrev[code] or false
misc.keyPrev[code] = down
return down and not was
end
function GP_TryCaptureHotkey()
if not misc.waitKey then return end
if not IsUIInputAllowed() then return end
if input.IsButtonDown(KEY_ESCAPE) then
misc.waitKey = false
misc.waitKeyArmed = false
misc.waitWhich = nil
misc.waitKeyStartFrame = 0
misc.keyPrev = {}
return
end
if not misc.waitKeyArmed then
local fc = globals.FrameCount() or 0
local startFc = misc.waitKeyStartFrame or 0
if startFc ~= 0 and (fc - startFc) > 6 then
if (not input.IsButtonDown(MOUSE_LEFT)) and (not input.IsButtonDown(MOUSE_RIGHT)) then
misc.waitKeyArmed = true
misc.keyPrev = {}
else
return
end
else
return
end
end
for i = 1, #GP_PICK_KEYS do
local k = GP_PICK_KEYS[i]
if GP_KeyPressedBind(k) then
if misc.waitWhich == "walk" then
WALK_KEY = k
config.walk_key = k
elseif misc.waitWhich == "clean" then
CLEAN_KEY = k
config.clean_key = k
elseif misc.waitWhich == "tp" then
TP_KEY = k
config.tp_key = k
elseif misc.waitWhich == "tpdrop" then
TP_DROP_AUTOKILL_KEY = k
config.tp_drop_key = k
elseif misc.waitWhich == "alloff" then
ALL_OFF_KEY = k
config.all_off_key = k
else
AUTO_KEY = k
config.auto_key = k
end
SaveConfig(GP_CfgPath(), config)
AddNotification("Hotkey set: " .. GP_KeyName(k), "info")
local _rt = (globals.CurTime and globals.CurTime()) or (globals.RealTime and globals.RealTime()) or 0
suppressToggleUntil = _rt + 0.35
lastToggleTime = _rt
misc.keyPrev = misc.keyPrev or {}
misc.keyPrev[k] = true
misc.waitKey = false
misc.waitKeyArmed = false
misc.waitWhich = nil
misc.waitKeyStartFrame = 0
misc.keyPrev = {}
break
end
end
end
local __hotkeyPrev = {}
function GP_KeyPressedHK(code)
if type(code) ~= "number" then return false end
local down = input.IsButtonDown(code)
local was = __hotkeyPrev[code] or false
__hotkeyPrev[code] = down
return down and not was
end

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

local gpAutoCanteenHeld = false
local GP_IN_RELOAD = 8192
function GP_HandleAutoCanteen(me)
if not (config and config.autoCanteenEnabled == true) then
if gpAutoCanteenHeld then
client.Command("-use_action_slot_item", true)
gpAutoCanteenHeld = false
end
return
end
if not me or not me:IsAlive() then
if gpAutoCanteenHeld then
client.Command("-use_action_slot_item", true)
gpAutoCanteenHeld = false
end
return
end
local actionSlot = LOADOUT_POSITION_ACTION or 40
local canteen = me.GetEntityForLoadoutSlot and me:GetEntityForLoadoutSlot(actionSlot) or nil
local charges = (canteen and canteen.GetPropInt and canteen:GetPropInt("m_usNumCharges")) or 0
local hasCanteens = canteen and ((charges % 256) > 0)
local hasAmmoCanteens = hasCanteens and canteen.AttributeHookFloat and (canteen:AttributeHookFloat("refill_ammo", 0) > 0.0)
local ammoTable = me.GetPropDataTableInt and me:GetPropDataTableInt("localdata", "m_iAmmo") or nil
local ammo = ammoTable and ammoTable[2] or nil
if hasAmmoCanteens and ammo ~= nil and ammo <= 1 then
if not gpAutoCanteenHeld then
client.Command("+use_action_slot_item", true)
gpAutoCanteenHeld = true
end
else
if gpAutoCanteenHeld then
client.Command("-use_action_slot_item", true)
gpAutoCanteenHeld = false
end
end
end

function GP_HandleAutoFocus(cmd, me)
if not (config and config.autoFocusEnabled == true) then return end
if not (cmd and me and me.IsAlive and me:IsAlive()) then return end
local weapon = nil
if me.GetPropEntity then
local okWeapon, w = pcall(me.GetPropEntity, me, "m_hActiveWeapon")
if okWeapon then weapon = w end
end
if not (weapon and weapon.GetPropInt) then return end
local okIndex, index = pcall(weapon.GetPropInt, weapon, "m_iItemDefinitionIndex")
if not okIndex or tonumber(index) ~= 752 then return end
local charge = 0
if me.GetPropFloat then
local okCharge, c = pcall(me.GetPropFloat, me, "m_flRageMeter")
if okCharge and type(c) == "number" then charge = c end
end
if charge <= 0 then return end
if cmd.GetButtons and cmd.SetButtons then
local b = cmd:GetButtons()
if type(b) == "number" then
local bitlib = bit32 or bit
if bitlib and bitlib.bor then
cmd:SetButtons(bitlib.bor(b, GP_IN_RELOAD))
else
local hasReload = (math.floor(b / GP_IN_RELOAD) % 2) == 1
if hasReload then
cmd:SetButtons(b)
else
cmd:SetButtons(b + GP_IN_RELOAD)
end
end
end
end
end

GP_TP_AIMBOT_CTL = GP_TP_AIMBOT_CTL or {
suppressed = false,
restorePending = false,
restoreAt = 0,
snapshot = nil,
lastSuppressedAt = 0,
}

GP_TP_AIMBOT_KEYS = GP_TP_AIMBOT_KEYS or {
"lbot.aim.enable",
"lbot.master",
"rbot.aim.enable",
"rbot.master",
"ragebot.enable",
"aimbot",
"aim bot",
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
function GP_DrawMiscButton(x, y, w, h, label, accent, mx, my, active, alphaMul)
alphaMul = alphaMul or 1
if alphaMul < 0 then alphaMul = 0 elseif alphaMul > 1 then alphaMul = 1 end
function AM(a) return math.floor((a or 255) * alphaMul + 0.5) end
local hover = (mx >= x and mx <= x + w and my >= y and my <= y + h)
local base = {150,150,150,255}
local col = (hover or active) and accent or base
GP_Color(25,25,25, AM(235))
SafeFilledRect(x, y, x+w, y+h)
GP_Color(col[1],col[2],col[3], AM(col[4]))
SafeFilledRect(x, y, x+w, y+2)
GP_Color(col[1],col[2],col[3], AM(col[4]))
SafeFilledRect(x, y+h-2, x+w, y+h)
draw.SetFont(GP_UI.font)
local maxTextW = math.max(0, (w or 0) - 20)
local labelDraw = label or ""
do
local tw0 = draw.GetTextSize(labelDraw)
local guard = 0
while tw0 > maxTextW and #labelDraw > 0 and guard < 128 do
labelDraw = labelDraw:sub(1, #labelDraw - 1)
tw0 = draw.GetTextSize(labelDraw)
guard = guard + 1
end
end
local th = select(2, draw.GetTextSize(labelDraw))
local tx = math.floor(x + 10)
local ty = math.floor(y + h/2 - th/2)
GP_Color(col[1],col[2],col[3], AM(col[4]))
SafeText(tx, ty, labelDraw)
return hover
end

function GP_DrawAutoQueueMainMenuPanel(screenWidth, screenHeight)
if not (config and config.partyAutoQueueEnabled == true) then
gpPartyAutoQueueUiLastMouseDown = input.IsButtonDown(MOUSE_LEFT)
gpPartyAutoQueueUiDragging = false
return
end
local now = GP_PartyNow()
local mousePos = input.GetMousePos()
local mx, my = mousePos[1] or 0, mousePos[2] or 0
local mouseDown = input.IsButtonDown(MOUSE_LEFT)
local lastMouseDown = gpPartyAutoQueueUiLastMouseDown or false
local mousePressed = mouseDown and not lastMouseDown
local mouseReleased = (not mouseDown) and lastMouseDown
gpPartyAutoQueueUiLastMouseDown = mouseDown
local w, h = 232, 66
local defaultX = math.max(0, math.floor(((screenWidth or 0) - w) / 2))
local defaultY = 120
local x = tonumber(config.partyAutoQueueUiX) or defaultX
local y = tonumber(config.partyAutoQueueUiY) or defaultY
if x < 0 then x = 0 end
if y < 0 then y = 0 end
if screenWidth and x + w > screenWidth then x = math.max(0, screenWidth - w) end
if screenHeight and y + h > screenHeight then y = math.max(0, screenHeight - h) end
local panelHover = (mx >= x and mx <= x + w and my >= y and my <= y + h)
local accent = GP_UI.colors.gold or {214, 175, 55, 255}
GP_Color(18, 18, 18, 238)
SafeFilledRect(x, y, x + w, y + h)
GP_Color(accent[1], accent[2], accent[3], 230)
SafeFilledRect(x, y, x + w, y + 2)
SafeFilledRect(x, y + h - 2, x + w, y + h)
draw.SetFont(GP_UI.font)
GP_Color(accent[1], accent[2], accent[3], 255)
SafeText(x + 9, y + 4, "Auto Queue - " .. GP_PartyQueueOperationLabel())
GP_Color(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], 235)
SafeText(x + 9, y + 20, GP_PartyAutoQueueStateText(now))
local by = y + 41
local pauseHover = GP_DrawMiscButton(x + 9, by, 103, 18, (config.partyAutoQueuePaused and "Start" or "Stop"), accent, mx, my, false, 1)
local waitHover = GP_DrawMiscButton(x + 120, by, 103, 18, "Wait 60s", accent, mx, my, false, 1)
if mousePressed and pauseHover then
if config.partyAutoQueuePaused == true then
config.partyAutoQueuePaused = false
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueOptionsReadyAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
gpPartyAutoQueueNextAt = now + GP_PARTY_AUTO_QUEUE_START_DELAY
gpPartyAutoQueueCooldownUntil = math.max(gpPartyAutoQueueCooldownUntil or 0, now + GP_PARTY_AUTO_QUEUE_START_DELAY)
AddNotification("Auto Queue starting in 6 seconds", "info")
else
config.partyAutoQueuePaused = true
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueOptionsReadyAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
AddNotification("Auto Queue Stopped", "info")
end
SaveConfig(GP_CfgPath(), config)
elseif mousePressed and waitHover then
config.partyAutoQueuePaused = false
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueOptionsReadyAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
gpPartyAutoQueueCooldownUntil = now + GP_PARTY_AUTO_QUEUE_WAIT_BUTTON_DELAY
gpPartyAutoQueueNextAt = now + GP_PARTY_AUTO_QUEUE_WAIT_BUTTON_DELAY
AddNotification("Auto Queue waiting 60 seconds", "info")
SaveConfig(GP_CfgPath(), config)
elseif mousePressed and panelHover and IsUIInputAllowed() then
gpPartyAutoQueueUiDragging = true
gpPartyAutoQueueUiDragOffsetX = mx - x
gpPartyAutoQueueUiDragOffsetY = my - y
end
if gpPartyAutoQueueUiDragging == true then
if mouseDown then
local nx = mx - (gpPartyAutoQueueUiDragOffsetX or 0)
local ny = my - (gpPartyAutoQueueUiDragOffsetY or 0)
if nx < 0 then nx = 0 end
if ny < 0 then ny = 0 end
if screenWidth and nx + w > screenWidth then nx = math.max(0, screenWidth - w) end
if screenHeight and ny + h > screenHeight then ny = math.max(0, screenHeight - h) end
config.partyAutoQueueUiX = math.floor(nx + 0.5)
config.partyAutoQueueUiY = math.floor(ny + 0.5)
elseif mouseReleased then
gpPartyAutoQueueUiDragging = false
SaveConfig(GP_CfgPath(), config)
end
end
end

function GP_MiscResetKeyBindState()
misc.waitKey = false
misc.waitKeyArmed = false
misc.waitWhich = nil
misc.waitKeyStartFrame = 0
misc.keyPrev = {}
end
function GP_MiscCloseMenuState()
misc.want = false
misc.category = nil
GP_MiscResetKeyBindState()
end
function GP_MiscSubItemCount(cat)
if cat == "toggles" then return 5 end
if cat == "misc" then return 14 end
if cat == "party" then return 9 end
if cat == "hotkeys" then return 6 end
return 0
end
function GP_MiscSubExtraHeight(cat)
if cat == "misc" then return 8 end
if cat == "party" then return 8 end
return 0
end
function GP_MiscComputePanels(anchorX, anchorY, barHeight, screenWidth, screenHeight, animValue)
local mw, bh, gap, padding, barT = 220, 24, 6, 10, 2
local mainItems = 4
local mh = barT*2 + padding*2 + mainItems*bh + (mainItems-1)*gap
local px = anchorX
local py = anchorY + barHeight + 4
local attachBelow = true
if (py + mh) > screenHeight then
attachBelow = false
py = anchorY - mh - 6
end
if px < 0 then px = 0 end
if (px + mw) > screenWidth then px = math.max(0, screenWidth - mw) end
if py < 0 then py = 0 end
if (py + mh) > screenHeight then py = math.max(0, screenHeight - mh) end
local a = animValue or (misc.anim or 0)
local offset = (1 - a) * 8
if not attachBelow then offset = -offset end
local pyDraw = py + math.floor(offset + 0.5)
local cat = misc.category
local subItems = GP_MiscSubItemCount(cat)
local hasSub = subItems > 0
local sw, sh, sx, sy = 0, 0, 0, 0
if hasSub then
sw = 300
sh = barT*2 + padding*2 + subItems*bh + (subItems-1)*gap + GP_MiscSubExtraHeight(cat)
sx = px + mw + 8
if (sx + sw) > screenWidth then
sx = px - sw - 8
end
if sx < 0 then sx = 0 end
if (sx + sw) > screenWidth then sx = math.max(0, screenWidth - sw) end
sy = pyDraw
if sy < 0 then sy = 0 end
if (sy + sh) > screenHeight then sy = math.max(0, screenHeight - sh) end
end
return px, pyDraw, mw, mh, attachBelow, sw, sh, sx, sy, hasSub, bh, gap, padding, barT
end
function GP_MiscIsMouseOver(anchorX, anchorY, barHeight, screenWidth, screenHeight, mx, my)
if (misc.anim or 0) <= 0 then return false end
local px, pyDraw, mw, mh, _, sw, sh, sx, sy, hasSub =
GP_MiscComputePanels(anchorX, anchorY, barHeight, screenWidth, screenHeight, misc.anim)
local inMain = (mx >= px and mx <= (px + mw) and my >= pyDraw and my <= (pyDraw + mh))
if inMain then return true end
if hasSub then
local inSub = (mx >= sx and mx <= (sx + sw) and my >= sy and my <= (sy + sh))
if inSub then return true end
end
return false
end
function GP_DrawRightClickMenu(anchorX, anchorY, barHeight, screenWidth, screenHeight, mx, my, rPressedAny)
if (misc.anim or 0) <= 0 then return end
local _gp_prevNoTrans = _gp_noTransparent
_gp_noTransparent = true
local aMul = (misc.anim or 0)
if misc.debounceFrames and misc.debounceFrames > 0 then
misc.debounceFrames = misc.debounceFrames - 1
end
local px, pyDraw, mw, mh, attachBelow, sw, sh, sx, sy, hasSub, bh, gap, padding, barT =
GP_MiscComputePanels(anchorX, anchorY, barHeight, screenWidth, screenHeight, aMul)
local lDownMenu = input.IsButtonDown(MOUSE_LEFT)
local lPressedMenu = lDownMenu and not (misc.lastLDown or false)
misc.lastLDown = lDownMenu
local fc = (globals.FrameCount and globals.FrameCount() or 0)
local justOpened = (misc.openFrame ~= 0) and ((fc - misc.openFrame) < 6)
local inMain = (mx >= px and mx <= (px + mw) and my >= pyDraw and my <= (pyDraw + mh))
local inSub = hasSub and (mx >= sx and mx <= (sx + sw) and my >= sy and my <= (sy + sh)) or false
local inMenu = inMain or inSub
if (not misc.waitKey) then
if (not justOpened) and rPressedAny and (not inMenu) then
GP_MiscCloseMenuState()
elseif (not justOpened) and lPressedMenu and (not inMenu) then
GP_MiscCloseMenuState()
end
end
local accent = GP_UI.colors.gold
local forceAccent = {255, 140, 0, 255}
GP_Color(GP_UI.colors.background[1], GP_UI.colors.background[2], GP_UI.colors.background[3], math.floor((245 * aMul) + 0.5))
SafeFilledRect(px, pyDraw, px+mw, pyDraw+mh)
if attachBelow then
GP_Color(accent[1], accent[2], accent[3], math.floor((255 * aMul) + 0.5))
SafeFilledRect(px, pyDraw, px+mw, pyDraw+barT)
end
GP_Color(accent[1], accent[2], accent[3], math.floor((255 * aMul) + 0.5))
SafeFilledRect(px, pyDraw+mh-barT, px+mw, pyDraw+mh)
local bx = px + padding
local by = pyDraw + barT + padding
local cToggles = GP_DrawMiscButton(bx, by, mw-padding*2, bh, "Toggles", accent, mx, my, misc.category == "toggles", aMul)
by = by + bh + gap
local cMisc = GP_DrawMiscButton(bx, by, mw-padding*2, bh, "Misc", accent, mx, my, misc.category == "misc", aMul)
by = by + bh + gap
local cParty = GP_DrawMiscButton(bx, by, mw-padding*2, bh, "Party Features", accent, mx, my, misc.category == "party", aMul)
by = by + bh + gap
local cHotkeys = GP_DrawMiscButton(bx, by, mw-padding*2, bh, "Hotkeys", accent, mx, my, misc.category == "hotkeys", aMul)
if not misc.armed then
if not input.IsButtonDown(MOUSE_LEFT) then
misc.armed = true
end
end
local lPressed = lPressedMenu
if misc.armed and lPressed then
if (misc.debounceFrames or 0) <= 0 then
if cToggles then
if misc.category == "toggles" then
misc.category = nil
else
misc.category = "toggles"
end
GP_MiscResetKeyBindState()
misc.debounceFrames = 6
elseif cMisc then
if misc.category == "misc" then
misc.category = nil
else
misc.category = "misc"
end
GP_MiscResetKeyBindState()
misc.debounceFrames = 6
elseif cParty then
if misc.category == "party" then
misc.category = nil
else
misc.category = "party"
end
GP_MiscResetKeyBindState()
misc.debounceFrames = 6
elseif cHotkeys then
if misc.category == "hotkeys" then
misc.category = nil
else
misc.category = "hotkeys"
end
GP_MiscResetKeyBindState()
misc.debounceFrames = 6
end
end
end
if hasSub then
GP_Color(GP_UI.colors.background[1], GP_UI.colors.background[2], GP_UI.colors.background[3], math.floor((245 * aMul) + 0.5))
SafeFilledRect(sx, sy, sx+sw, sy+sh)
GP_Color(accent[1], accent[2], accent[3], math.floor((255 * aMul) + 0.5))
SafeFilledRect(sx, sy, sx+sw, sy+barT)
GP_Color(accent[1], accent[2], accent[3], math.floor((255 * aMul) + 0.5))
SafeFilledRect(sx, sy+sh-barT, sx+sw, sy+sh)
local sbx = sx + padding
local sby = sy + barT + padding
local swi = sw - padding*2
if misc.category == "toggles" then
local t1 = GP_DrawMiscButton(sbx, sby, swi, bh, "AutoCredit: " .. (config.autoWalkEnabled and "ON" or "OFF"), accent, mx, my, config.autoWalkEnabled, aMul)
sby = sby + bh + gap
local t2 = GP_DrawMiscButton(sbx, sby, swi, bh, "SniperBuy: " .. (config.autoBuyEnabled and "ON" or "OFF"), accent, mx, my, config.autoBuyEnabled, aMul)
sby = sby + bh + gap
local t3 = GP_DrawMiscButton(sbx, sby, swi, bh, "NoWalk SniperBuy: " .. (forceSniperBuyModeEnabled and "ON" or "OFF"), forceAccent, mx, my, forceSniperBuyModeEnabled, aMul)
sby = sby + bh + gap
local t4 = GP_DrawMiscButton(sbx, sby, swi, bh, "TpWalk: " .. (config.tpWalkEnabled and "ON" or "OFF"), accent, mx, my, config.tpWalkEnabled, aMul)
sby = sby + bh + gap
local t5 = GP_DrawMiscButton(sbx, sby, swi, bh, "All Class TpWalk: " .. (tpForceModeEnabled and "ON" or "OFF"), forceAccent, mx, my, tpForceModeEnabled, aMul)
if misc.armed and lPressed and ((misc.debounceFrames or 0) <= 0) then
if t1 then
GP_SetAutoCreditEnabled((not config.autoWalkEnabled), true)
elseif t2 then
local nextEnabled = (not config.autoBuyEnabled)
if nextEnabled and forceSniperBuyModeEnabled then
GP_SetForceSniperBuyEnabled(false, false)
end
config.autoBuyEnabled = nextEnabled
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
if config.autoBuyEnabled then
GP_EnableSniperBuyRuntime(((GP_TP_IsTraversalActive and GP_TP_IsTraversalActive()) and true or false))
AddNotification("SniperBuy Enabled - Reset state (Death/Respawn as Sniper activates it)", "warning", 4.0)
else
GP_DisableSniperBuyRuntime(GP_TP_IsTraversalActive())
AddNotification("SniperBuy Disabled", "info")
end
SaveConfig(GP_CfgPath(), config)
elseif t3 then
GP_SetForceSniperBuyEnabled((not forceSniperBuyModeEnabled), true)
elseif t4 then
GP_SetTpWalkEnabled((not config.tpWalkEnabled), true)
elseif t5 then
GP_SetTpForceEnabled((not tpForceModeEnabled), true)
end
end
elseif misc.category == "misc" then
local m1 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.transparentEnabled and "Transparent: ON" or "Transparent: OFF"), accent, mx, my, config.transparentEnabled, aMul)
sby = sby + bh + gap
local m2 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.hideHotkeysInUI and "Hide Hotkeys in UI: ON" or "Hide Hotkeys in UI: OFF"), accent, mx, my, config.hideHotkeysInUI, aMul)
sby = sby + bh + gap
local m3 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.hideInfoPopups and "Hide Info Pop ups: ON" or "Hide Info Pop ups: OFF"), accent, mx, my, config.hideInfoPopups, aMul)
sby = sby + bh + gap
local m3a = GP_DrawMiscButton(sbx, sby, swi, bh, (config.hideInfoOnLoad and "Hide Info on Load: ON" or "Hide Info on Load: OFF"), accent, mx, my, config.hideInfoOnLoad, aMul)
sby = sby + bh + gap + 8
local m6 = GP_DrawMiscButton(sbx, sby, swi, bh, "Lock TpWalking: " .. (config.tpWalkMoveLockEnabled and "ON" or "OFF"), forceAccent, mx, my, config.tpWalkMoveLockEnabled, aMul)
sby = sby + bh + gap
local m7 = GP_DrawMiscButton(sbx, sby, swi, bh, "TpWalk Whitelist: " .. (config.tpWalkWhitelistEnabled and "ON" or "OFF"), forceAccent, mx, my, config.tpWalkWhitelistEnabled, aMul)
sby = sby + bh + gap
local m8 = GP_DrawMiscButton(sbx, sby, swi, bh, "First Join Medic: " .. (config.firstJoinPickMedic and "ON" or "OFF"), forceAccent, mx, my, config.firstJoinPickMedic, aMul)
sby = sby + bh + gap
local m9 = GP_DrawMiscButton(sbx, sby, swi, bh, "Smart AutoF4: " .. (config.mvmReadyTpCycleEnabled and "ON" or "OFF"), forceAccent, mx, my, config.mvmReadyTpCycleEnabled, aMul)
sby = sby + bh + gap
local m10 = GP_DrawMiscButton(sbx, sby, swi, bh, "Instant Respawn: " .. (config.instantRespawnEnabled and "ON" or "OFF"), forceAccent, mx, my, config.instantRespawnEnabled, aMul)
sby = sby + bh + gap
local m11 = GP_DrawMiscButton(sbx, sby, swi, bh, "Auto Ammo Canteen: " .. (config.autoCanteenEnabled and "ON" or "OFF"), forceAccent, mx, my, config.autoCanteenEnabled, aMul)
sby = sby + bh + gap
local m11a = GP_DrawMiscButton(sbx, sby, swi, bh, "Auto Focus: " .. (config.autoFocusEnabled and "ON" or "OFF"), forceAccent, mx, my, config.autoFocusEnabled, aMul)
sby = sby + bh + gap
local m12 = GP_DrawMiscButton(sbx, sby, swi, bh, "Auto Disconnect: " .. (config.autoDisconnectEnabled and "ON" or "OFF"), forceAccent, mx, my, config.autoDisconnectEnabled, aMul)
sby = sby + bh + gap
local m13 = GP_DrawMiscButton(sbx, sby, swi, bh, "Force Fix: " .. (config.forceFixWaveStartEnabled and "ON" or "OFF"), forceAccent, mx, my, config.forceFixWaveStartEnabled, aMul)
sby = sby + bh + gap
local m14 = GP_DrawMiscButton(sbx, sby, swi, bh, "Tp Position Lost - Kill: " .. (config.tpDropAutoKillEnabled and "ON" or "OFF"), forceAccent, mx, my, config.tpDropAutoKillEnabled, aMul)
if misc.armed and lPressed and ((misc.debounceFrames or 0) <= 0) then
if m1 then
config.transparentEnabled = not config.transparentEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Transparent mode " .. (config.transparentEnabled and "Enabled" or "Disabled"), "success")
elseif m2 then
config.hideHotkeysInUI = not config.hideHotkeysInUI
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Hide Hotkeys in UI " .. (config.hideHotkeysInUI and "Enabled" or "Disabled"), "success")
elseif m3 then
config.hideInfoPopups = not config.hideInfoPopups
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
if not config.hideInfoPopups then
AddNotification("Hide Info Pop ups Disabled", "info")
end
elseif m3a then
config.hideInfoOnLoad = not config.hideInfoOnLoad
if config.hideInfoOnLoad == true then
config.infoLoadSeenVersion = GP_INFO_LOAD_VERSION
config.changelogSeenVersion = GP_CHANGELOG_VERSION
if GP_LoadInfoPopup then GP_LoadInfoPopup.visible = false end
if GP_ChangelogPopup then GP_ChangelogPopup.visible = false end
end
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
elseif m6 then
config.tpWalkMoveLockEnabled = not config.tpWalkMoveLockEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
if config.tpWalkMoveLockEnabled then
AddNotification("Lock TpWalking Enabled (locks your own movement and turns off aimbot until teleport)", "info", (UI.notificationLifetime or 3) + 2)
else
AddNotification("Lock TpWalking Disabled", "info")
end
elseif m7 then
config.tpWalkWhitelistEnabled = not config.tpWalkWhitelistEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
if config.tpWalkWhitelistEnabled then
AddNotification("TpWalk Whitelist enabled (set a player's priority to 1 in the playerlist to whitelist them)", "info", (UI.notificationLifetime or 3) + 2)
else
AddNotification("TpWalk Whitelist Disabled", "info")
end
elseif m8 then
config.firstJoinPickMedic = not config.firstJoinPickMedic
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("First Join Medic " .. (config.firstJoinPickMedic and "Enabled" or "Disabled"), "info")
elseif m9 then
config.mvmReadyTpCycleEnabled = not config.mvmReadyTpCycleEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
GP_F4_OnFeatureToggle(config.mvmReadyTpCycleEnabled == true)
elseif m10 then
config.instantRespawnEnabled = not config.instantRespawnEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Instant Respawn " .. (config.instantRespawnEnabled and "Enabled" or "Disabled"), "info")
elseif m11 then
config.autoCanteenEnabled = not config.autoCanteenEnabled
if not config.autoCanteenEnabled and gpAutoCanteenHeld then
client.Command("-use_action_slot_item", true)
gpAutoCanteenHeld = false
end
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Auto Ammo Canteen " .. (config.autoCanteenEnabled and "Enabled" or "Disabled"), "info")
elseif m11a then
config.autoFocusEnabled = not config.autoFocusEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Auto Focus " .. (config.autoFocusEnabled and "Enabled" or "Disabled"), "info")
elseif m12 then
config.autoDisconnectEnabled = not config.autoDisconnectEnabled
if not config.autoDisconnectEnabled then
GP_AutoDisconnectReset(false)
end
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Auto Disconnect " .. (config.autoDisconnectEnabled and "Enabled" or "Disabled"), "info")
elseif m13 then
config.forceFixWaveStartEnabled = not config.forceFixWaveStartEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification(config.forceFixWaveStartEnabled and "Force Fix Enabled - activates all fixes on wave start" or "Force Fix Disabled", "info")
elseif m14 then
config.tpDropAutoKillEnabled = not config.tpDropAutoKillEnabled
if not config.tpDropAutoKillEnabled then
GP_TP_ClearDropAutoKill()
GP_TP_ResetManualDropAutoKill()
end
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification(config.tpDropAutoKillEnabled and "Tp Position Lost - Kill Enabled (kills if position is lost after teleport)" or "Tp Position Lost - Kill Disabled", "info")
end
end
elseif misc.category == "party" then
local p1 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpKillEnabled and "Party gp_kill: ON" or "Party gp_kill: OFF"), accent, mx, my, config.partyGpKillEnabled, aMul)
sby = sby + bh + gap
local p2 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpLeaveEnabled and "Party gp_leave: ON" or "Party gp_leave: OFF"), accent, mx, my, config.partyGpLeaveEnabled, aMul)
sby = sby + bh + gap
local p3 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpFixEnabled and "Party gp_fix: ON" or "Party gp_fix: OFF"), accent, mx, my, config.partyGpFixEnabled, aMul)
sby = sby + bh + gap
local p4 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpRetryEnabled and "Party gp_retry: ON" or "Party gp_retry: OFF"), accent, mx, my, config.partyGpRetryEnabled, aMul)
sby = sby + bh + gap
local p5 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpVoteEnabled and "Party gp_f1 / gp_f2: ON" or "Party gp_f1 / gp_f2: OFF"), accent, mx, my, config.partyGpVoteEnabled, aMul)
sby = sby + bh + gap
local p6 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyGpLeadEnabled and "Party gp_lead: ON" or "Party gp_lead: OFF"), accent, mx, my, config.partyGpLeadEnabled, aMul)
sby = sby + bh + gap + 8
local p7 = GP_DrawMiscButton(sbx, sby, swi, bh, "Smart Vote: " .. (config.smartVoteEnabled and "ON" or "OFF"), forceAccent, mx, my, config.smartVoteEnabled, aMul)
sby = sby + bh + gap
local voteRevealLabel = "Vote Revealer: OFF"
if config.partyVoteRevealEnabled == true then
voteRevealLabel = "Vote Revealer (" .. ((config.partyVoteRevealOutput == "local") and "Local" or "Party") .. ")"
end
local p8 = GP_DrawMiscButton(sbx, sby, swi, bh, voteRevealLabel, forceAccent, mx, my, config.partyVoteRevealEnabled, aMul)
sby = sby + bh + gap
local p9 = GP_DrawMiscButton(sbx, sby, swi, bh, (config.partyAutoAcceptInvitesEnabled and "Auto Accept Party Invites: ON" or "Auto Accept Party Invites: OFF"), forceAccent, mx, my, config.partyAutoAcceptInvitesEnabled, aMul)
if misc.armed and lPressed and ((misc.debounceFrames or 0) <= 0) then
if p1 then
config.partyGpKillEnabled = not config.partyGpKillEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_kill command " .. (config.partyGpKillEnabled and "Enabled" or "Disabled"), "info")
elseif p2 then
config.partyGpLeaveEnabled = not config.partyGpLeaveEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_leave command " .. (config.partyGpLeaveEnabled and "Enabled" or "Disabled"), "info")
elseif p3 then
config.partyGpFixEnabled = not config.partyGpFixEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_fix command " .. (config.partyGpFixEnabled and "Enabled" or "Disabled"), "info")
elseif p4 then
config.partyGpRetryEnabled = not config.partyGpRetryEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_retry command " .. (config.partyGpRetryEnabled and "Enabled" or "Disabled"), "info")
elseif p5 then
config.partyGpVoteEnabled = not config.partyGpVoteEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_f1 / gp_f2 command " .. (config.partyGpVoteEnabled and "Enabled" or "Disabled"), "info")
elseif p6 then
config.partyGpLeadEnabled = not config.partyGpLeadEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification("Party gp_lead command " .. (config.partyGpLeadEnabled and "Enabled" or "Disabled"), "info")
elseif p7 then
config.smartVoteEnabled = not config.smartVoteEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification(config.smartVoteEnabled and "Smart Vote Enabled - F1 party votes, F2 random votes" or "Smart Vote Disabled", "info")
elseif p8 then
if config.partyVoteRevealEnabled ~= true then
config.partyVoteRevealEnabled = true
config.partyVoteRevealOutput = "party"
elseif config.partyVoteRevealOutput == "party" then
config.partyVoteRevealOutput = "local"
else
config.partyVoteRevealEnabled = false
config.partyVoteRevealOutput = "party"
end
if not config.partyVoteRevealEnabled then
gpVoteRevealSeenCast = {}
gpVoteRevealStarter = {}
gpVoteRevealTarget = {}
gpVoteRevealTargetName = {}
gpVoteRevealClosedUntil = {}
gpVoteRevealPendingCasts = {}
gpVoteRevealReportedMissing = {}
end
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
AddNotification(config.partyVoteRevealEnabled and ("Vote Revealer " .. ((config.partyVoteRevealOutput == "local") and "Local" or "Party")) or "Vote Revealer Disabled", "info")
elseif p9 then
config.partyAutoAcceptInvitesEnabled = not config.partyAutoAcceptInvitesEnabled
SaveConfig(GP_CfgPath(), config)
misc.debounceFrames = 10
gpPartyAutoAcceptStatusAt = 0
GP_PartyFeatureLog("toggle_autoaccept", "Auto Accept toggled enabled=" .. tostring(config.partyAutoAcceptInvitesEnabled) .. " mode=no_file_probe", 0)
if config.partyAutoAcceptInvitesEnabled then
GP_PartyRun("tf_party_ignore_invites 0")
GP_PartyAutoAcceptBeginProbe(GP_PartyNow())
end
AddNotification("Auto Accept Party Invites " .. (config.partyAutoAcceptInvitesEnabled and "Enabled" or "Disabled"), "info")
end
end
elseif misc.category == "hotkeys" then
local h1 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="walk" and "Press a key..." or ("Set Hotkey AutoCredit ["..GP_KeyName(WALK_KEY).."]")), accent, mx, my, false, aMul)
sby = sby + bh + gap
local h2 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="clean" and "Press a key..." or ("Set Hotkey Cleanup ["..GP_KeyName(CLEAN_KEY).."]")), accent, mx, my, false, aMul)
sby = sby + bh + gap
local h3 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="auto" and "Press a key..." or ("Set Hotkey SniperBuy ["..GP_KeyName(AUTO_KEY).."]")), accent, mx, my, false, aMul)
sby = sby + bh + gap
local h4 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="tp" and "Press a key..." or ("Set Hotkey TpWalk ["..GP_KeyName(TP_KEY).."]")), accent, mx, my, false, aMul)
sby = sby + bh + gap
local h5 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="alloff" and "Press a key..." or ("Set Hotkey Disable All ["..GP_KeyName(ALL_OFF_KEY).."]")), accent, mx, my, false, aMul)
sby = sby + bh + gap
local h6 = GP_DrawMiscButton(sbx, sby, swi, bh, (misc.waitKey and misc.waitWhich=="tpdrop" and "Press a key..." or ("Set Hotkey Tp Position Lost - Kill ["..GP_KeyName(TP_DROP_AUTOKILL_KEY).."]")), accent, mx, my, false, aMul)
if misc.armed and lPressed and ((misc.debounceFrames or 0) <= 0) then
if h1 then
misc.waitKey = true
misc.waitWhich = "walk"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
elseif h2 then
misc.waitKey = true
misc.waitWhich = "clean"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
elseif h3 then
misc.waitKey = true
misc.waitWhich = "auto"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
elseif h4 then
misc.waitKey = true
misc.waitWhich = "tp"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
elseif h5 then
misc.waitKey = true
misc.waitWhich = "alloff"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
elseif h6 then
misc.waitKey = true
misc.waitWhich = "tpdrop"
misc.waitKeyArmed = false
misc.keyPrev = {}
misc.waitKeyStartFrame = globals.FrameCount() or 0
end
end
end
end
if misc.waitKey then
local mw2, mh2 = 220, 62
local cx = px + mw/2 - mw2/2
local cy = pyDraw + mh/2 - mh2/2
GP_Color(0,0,0,140)
SafeFilledRect(cx-4, cy-4, cx+mw2+4, cy+mh2+4)
GP_Color(15,15,15,245)
SafeFilledRect(cx, cy, cx+mw2, cy+mh2)
GP_Color(accent[1], accent[2], accent[3], 255)
SafeFilledRect(cx, cy, cx+mw2, cy+2)
GP_Color(accent[1], accent[2], accent[3], 255)
SafeFilledRect(cx, cy+mh2-2, cx+mw2, cy+mh2)
draw.SetFont(GP_UI.font)
local line1 = "Press a key or ESC"
local line2 = "Binding: " .. (misc.waitWhich=="walk" and "AutoCredit" or (misc.waitWhich=="clean" and "Cleanup" or (misc.waitWhich=="tp" and "TpWalk" or (misc.waitWhich=="alloff" and "Disable All Toggles" or (misc.waitWhich=="tpdrop" and "Tp Position Lost - Kill" or "SniperBuy")))))
local tw1, th1 = draw.GetTextSize(line1)
local tw2, th2 = draw.GetTextSize(line2)
GP_Color(255,215,0,255)
SafeText(math.floor(cx + mw2/2 - tw1/2), math.floor(cy + 14 - th1/2), line1)
GP_Color(200,200,200,255)
SafeText(math.floor(cx + mw2/2 - tw2/2), math.floor(cy + 38 - th2/2), line2)
if IsUIInputAllowed() then
if not misc.waitKeyArmed then
if (not input.IsButtonDown(MOUSE_LEFT)) and (not input.IsButtonDown(MOUSE_RIGHT)) then
misc.waitKeyArmed = true
misc.keyPrev = {}
end
else
GP_TryCaptureHotkey()
end
end
end
_gp_noTransparent = _gp_prevNoTrans
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
if tpWaitForRoundReload then return false end
if tpToggleNeedsTrigger then return false end
return (sniperUpgradeCompleted == true)
end
function GP_Draw()
UI_Color(255, 255, 255, 255)
local lboxMenuOpen = (gui and gui.IsMenuOpen and gui.IsMenuOpen()) or false
local drawTickNow = (globals and globals.RealTime and globals.RealTime()) or 0
GP_SmartVoteTick(drawTickNow)
GP_ClassSelectCloseTick(drawTickNow)
GP_PartyVoteRevealTick(drawTickNow)
GP_PartyAutoAcceptTick(drawTickNow)
local popupScreenW, popupScreenH = draw.GetScreenSize()
local loadInfoVisible = GP_DrawLoadInfoPopup(popupScreenW, popupScreenH)
GP_DrawChangelogPopup(popupScreenW, popupScreenH, loadInfoVisible)
if engine.IsGameUIVisible() and not lboxMenuOpen then
return
end
local me = entities.GetLocalPlayer()
if me then
CheckServerChange()
end
GP_AutoDisconnectTick()
UI.notifications = UI.notifications or {}
if not me then
if not lboxMenuOpen then return end
end
if me and (not GP_IsMvM()) then
return
end
local currency = (me and (me:GetPropInt("m_nCurrency") or 0)) or 0
local goal = config.moneyThreshold or 0
local progressRatio = 0
if goal > 0 then
progressRatio = math.min(currency / goal, 1)
end
local showFillbar = (GP_GetRoundState() == 3 and GP_GetWaveNumber() == 0)
local mainLabel = "GhostMoney"
local moneyText = "Cash: $" .. currency .. "/" .. goal
local classText = "Class: " .. (config.changeClassEnabled and (config.targetClass or "unknown") or "off")
local lowerText
if config.hideHotkeysInUI then
lowerText = "AutoCredit | Cleanup | SniperBuy | TpWalk"
else
lowerText = "[" .. KeyLabel(WALK_KEY) .. "] AutoCredit | [" .. KeyLabel(CLEAN_KEY) .. "] Cleanup | [" .. KeyLabel(AUTO_KEY) .. "] SniperBuy | [" .. KeyLabel(TP_KEY) .. "] TpWalk"
end
local topText = mainLabel .. " | " .. moneyText .. " | " .. classText
draw.SetFont(GP_UI.font)
local topWidth = draw.GetTextSize(topText)
draw.SetFont(GP_UI.font2)
local lowerWidth = draw.GetTextSize(lowerText)
local paddingX = 10
local width = math.max(topWidth, lowerWidth) + paddingX * 2
local height = 44
local mousePos = input.GetMousePos()
local mouse = { x = mousePos[1], y = mousePos[2] }
local screenWidth, screenHeight = draw.GetScreenSize()
local barWidth, barHeight = width, height + (showFillbar and 6 or 0)
if ClampUIPos(screenWidth, screenHeight, barWidth, barHeight) then
local rt = globals.RealTime() or 0
if (rt - uiClampSavedAt) > 0.5 then
uiClampSavedAt = rt
config.watermarkX = watermarkX
config.watermarkY = watermarkY
SaveConfig(GP_CfgPath(), config)
end
end
local mouseDown = input.IsButtonDown(MOUSE_LEFT)
local mousePressed = mouseDown and not gpDropdown.lastMouseDown
local mouseReleased = (not mouseDown) and gpDropdown.lastMouseDown
gpDropdown.lastMouseDown = mouseDown
local mouseOverMisc = GP_MiscIsMouseOver(watermarkX, watermarkY, barHeight, screenWidth, screenHeight, mouse.x, mouse.y)
local mousePressedDD = mousePressed and (not mouseOverMisc)
local inMainPanel = (mouse.x >= watermarkX and mouse.x <= (watermarkX + barWidth) and mouse.y >= watermarkY and mouse.y <= (watermarkY + barHeight))
local rDown = input.IsButtonDown(MOUSE_RIGHT)
local rPressed = rDown and not misc.lastRDown
local rPressedAny = rPressed
misc.lastRDown = rDown
if rPressed and inMainPanel and IsUIInputAllowed() then
misc.want = not misc.want
misc.armed = false
if misc.want then
misc.openedAt = (globals.RealTime and globals.RealTime() or 0)
misc.openFrame = (globals.FrameCount and globals.FrameCount() or 0)
else
misc.openedAt = 0
misc.openFrame = 0
end
if not misc.want then
misc.category = nil
GP_MiscResetKeyBindState()
end
end
do
local ft = GP_FrameDT()
local target = (misc.want and 1 or 0)
local speed = 14
local t = math.min(1, ft * speed)
misc.anim = (misc.anim or 0) + (target - (misc.anim or 0)) * t
if misc.anim < 0.01 and (not misc.want) then
misc.anim = 0
end
misc.open = (misc.anim or 0) > 0
end
do
draw.SetFont(GP_UI.font)
local clickY1 = watermarkY + 6
local clickY2 = clickY1 + 18
local sepText = " | "
local mainX1 = watermarkX + paddingX
local mainX2 = mainX1 + draw.GetTextSize(mainLabel)
local moneyW = draw.GetTextSize(moneyText)
local classW = draw.GetTextSize(classText)
local sepW = draw.GetTextSize(sepText)
local classDrawX = watermarkX + width - paddingX - classW
local leftBound = mainX2 + sepW
local rightBound = classDrawX - sepW
local moneyDrawX = math.floor(((leftBound + rightBound) - moneyW) * 0.5 + 0.5)
local maxMoneyX = rightBound - moneyW
if maxMoneyX < leftBound then maxMoneyX = leftBound end
if moneyDrawX < leftBound then
moneyDrawX = leftBound
elseif moneyDrawX > maxMoneyX then
moneyDrawX = maxMoneyX
end
if classDrawX < (moneyDrawX + moneyW + sepW) then
classDrawX = moneyDrawX + moneyW + sepW
end
local moneyX1 = moneyDrawX - 6
local moneyX2 = moneyDrawX + moneyW + 6
local classX1 = classDrawX - 6
local classX2 = classDrawX + classW + 6
local hitMoneyTop = (mouse.x >= moneyX1 and mouse.x <= moneyX2 and mouse.y >= clickY1 and mouse.y <= clickY2)
local hitClassTop = (mouse.x >= classX1 and mouse.x <= classX2 and mouse.y >= clickY1 and mouse.y <= clickY2)
local hitMainTop = (mouse.x >= mainX1 and mouse.x <= mainX2 and mouse.y >= clickY1 and mouse.y <= clickY2)
if mouseDown then
if isDragging then
watermarkX = mouse.x - dragOffsetX
watermarkY = mouse.y - dragOffsetY
if watermarkX < 0 then
watermarkX = 0
elseif watermarkX + barWidth > screenWidth then
watermarkX = screenWidth - barWidth
end
if watermarkY < 0 then
watermarkY = 0
elseif watermarkY + barHeight > screenHeight then
watermarkY = screenHeight - barHeight
end
config.watermarkX = watermarkX
config.watermarkY = watermarkY
else
local inPanel = (mouse.x >= watermarkX and mouse.x <= (watermarkX + barWidth) and mouse.y >= watermarkY and mouse.y <= (watermarkY + barHeight))
local canDrag = inPanel and (
(mouse.y >= (watermarkY + 20) and mouse.y <= (watermarkY + barHeight)) or
(hitMainTop and not hitMoneyTop and not hitClassTop)
)
if canDrag then
isDragging = true
dragOffsetX = mouse.x - watermarkX
dragOffsetY = mouse.y - watermarkY
end
end
else
if isDragging then
config.watermarkX = watermarkX
config.watermarkY = watermarkY
SaveConfig(GP_CfgPath(), config)
end
isDragging = false
end
end
local bgA = (config.transparentEnabled and 110 or GP_UI.colors.background[4])
local infoA = (config.transparentEnabled and 150 or 255)
UI_Color(GP_UI.colors.background[1], GP_UI.colors.background[2], GP_UI.colors.background[3], bgA)
SafeFilledRect(watermarkX, watermarkY, watermarkX + width, watermarkY + height)
local goldA = GP_GoldBarAlpha()
UI_Color(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], goldA)
SafeFilledRect(watermarkX, watermarkY, watermarkX + width, watermarkY + 2)
draw.SetFont(GP_UI.font)
local sepText = " | "
local mainX = watermarkX + paddingX
local mainW = draw.GetTextSize(mainLabel)
local moneyW = draw.GetTextSize(moneyText)
local classW = draw.GetTextSize(classText)
local sepW = draw.GetTextSize(sepText)
local classX = watermarkX + width - paddingX - classW
local leftBound = mainX + mainW + sepW
local rightBound = classX - sepW
local moneyX = math.floor(((leftBound + rightBound) - moneyW) * 0.5 + 0.5)
local maxMoneyX = rightBound - moneyW
if maxMoneyX < leftBound then maxMoneyX = leftBound end
if moneyX < leftBound then
moneyX = leftBound
elseif moneyX > maxMoneyX then
moneyX = maxMoneyX
end
if classX < (moneyX + moneyW + sepW) then
classX = moneyX + moneyW + sepW
end
local sep1X = mainX + mainW
local sep2X = moneyX + moneyW
UI_Color(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], infoA)
SafeText(mainX, watermarkY + 6, mainLabel)
UI_Color(GP_UI.colors.textDim[1], GP_UI.colors.textDim[2], GP_UI.colors.textDim[3], infoA)
SafeText(sep1X, watermarkY + 6, sepText)
UI_Color(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], infoA)
SafeText(moneyX, watermarkY + 6, moneyText)
UI_Color(GP_UI.colors.textDim[1], GP_UI.colors.textDim[2], GP_UI.colors.textDim[3], infoA)
SafeText(sep2X, watermarkY + 6, sepText)
UI_Color(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], infoA)
SafeText(classX, watermarkY + 6, classText)
local clickY1 = watermarkY + 6
local clickY2 = clickY1 + 18
local moneyX1 = moneyX - 6
local moneyX2 = moneyX + moneyW + 6
local classX1 = classX - 6
local classX2 = classX + classW + 6
if mousePressedDD and not isDragging then
local hitMoney = (mouse.x >= moneyX1 and mouse.x <= moneyX2 and mouse.y >= clickY1 and mouse.y <= clickY2)
local hitClass = (mouse.x >= classX1 and mouse.x <= classX2 and mouse.y >= clickY1 and mouse.y <= clickY2)
if hitMoney then
if gpDropdown.want == "cash" then
local before = tonumber(gpDropdown.openedCashThreshold) or tonumber(config.moneyThreshold) or 0
local now = tonumber(config.moneyThreshold) or 0
if before ~= now then
SaveConfig(GP_CfgPath(), config)
AddNotification("Money threshold set to $" .. tostring(config.moneyThreshold), "success")
end
gpDropdown.openedCashThreshold = nil
gpDropdown.want = nil
else
gpDropdown.want = "cash"
gpDropdown.state = "cash"
gpDropdown.openedCashThreshold = tonumber(config.moneyThreshold) or 0
end
gpDropdown.sliderDragging = false
elseif hitClass then
if gpDropdown.want == "cash" then
local before = tonumber(gpDropdown.openedCashThreshold) or tonumber(config.moneyThreshold) or 0
local now = tonumber(config.moneyThreshold) or 0
if before ~= now then
SaveConfig(GP_CfgPath(), config)
AddNotification("Money threshold set to $" .. tostring(now), "success")
end
gpDropdown.openedCashThreshold = nil
end
if gpDropdown.want == "class" then
gpDropdown.openedClassEnabled = nil
gpDropdown.openedClassTarget = nil
gpDropdown.want = nil
else
gpDropdown.want = "class"
gpDropdown.state = "class"
gpDropdown.openedClassEnabled = config.changeClassEnabled
gpDropdown.openedClassTarget = config.targetClass
end
gpDropdown.sliderDragging = false
end
end
draw.SetFont(GP_UI.font2)
local lowerLeft, lowerMid, lowerRight, lowerFarRight
local lowerGap = " | "
local lowerGap2 = " | "
local lowerGap3 = " | "
if config.hideHotkeysInUI then
lowerLeft = "AutoCredit"
lowerMid = "Cleanup"
lowerRight = "SniperBuy"
lowerFarRight = "TpWalk"
else
lowerLeft = "[" .. KeyLabel(WALK_KEY) .. "] AutoCredit"
lowerMid = "[" .. KeyLabel(CLEAN_KEY) .. "] Cleanup"
lowerRight = "[" .. KeyLabel(AUTO_KEY) .. "] SniperBuy"
lowerFarRight = "[" .. KeyLabel(TP_KEY) .. "] TpWalk"
end
local lwL = draw.GetTextSize(lowerLeft)
local lwG = draw.GetTextSize(lowerGap)
local lwM = draw.GetTextSize(lowerMid)
local lwG2 = draw.GetTextSize(lowerGap2)
local lwR = draw.GetTextSize(lowerRight)
local lwG3 = draw.GetTextSize(lowerGap3)
local lwFR = draw.GetTextSize(lowerFarRight)
local totalLower = lwL + lwG + lwM + lwG2 + lwR + lwG3 + lwFR
local centerX = watermarkX + (width / 2) - (totalLower / 2)
if config.autoWalkEnabled or autoModeWalkActive then
UI_Color(table.unpack(GP_UI.colors.gold))
else
UI_Color(table.unpack(GP_UI.colors.textDim))
end
SafeText(centerX, watermarkY + 22, lowerLeft)
UI_Color(table.unpack(GP_UI.colors.textDim))
SafeText(centerX + lwL, watermarkY + 22, lowerGap)
if globals.CurTime() < cleanupFlashUntil then
UI_Color(table.unpack(GP_UI.colors.gold))
else
UI_Color(table.unpack(GP_UI.colors.textDim))
end
SafeText(centerX + lwL + lwG, watermarkY + 22, lowerMid)
UI_Color(table.unpack(GP_UI.colors.textDim))
SafeText(centerX + lwL + lwG + lwM, watermarkY + 22, lowerGap2)
if forceSniperBuyModeEnabled then
UI_Color(255, 140, 0, infoA)
elseif config.autoBuyEnabled then
UI_Color(table.unpack(GP_UI.colors.gold))
else
UI_Color(table.unpack(GP_UI.colors.textDim))
end
SafeText(centerX + lwL + lwG + lwM + lwG2, watermarkY + 22, lowerRight)
UI_Color(table.unpack(GP_UI.colors.textDim))
SafeText(centerX + lwL + lwG + lwM + lwG2 + lwR, watermarkY + 22, lowerGap3)
if tpForceModeEnabled then
UI_Color(255, 140, 0, infoA)
elseif config.tpWalkEnabled then
UI_Color(table.unpack(GP_UI.colors.gold))
else
UI_Color(table.unpack(GP_UI.colors.textDim))
end
SafeText(centerX + lwL + lwG + lwM + lwG2 + lwR + lwG3, watermarkY + 22, lowerFarRight)
do
local _gA = GP_GoldBarAlpha()
UI_Color(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], _gA)
end
SafeFilledRect(watermarkX, watermarkY + height - 2, watermarkX + width, watermarkY + height)
if showFillbar then
local barY = watermarkY + height
UI_Color(table.unpack(GP_UI.colors.barBg))
SafeFilledRect(watermarkX, barY, watermarkX + width, barY + 6)
UI_Color(table.unpack(GP_UI.colors.barFill))
SafeFilledRect(watermarkX, barY, watermarkX + math.floor(width * progressRatio), barY + 6)
end
local panelH = 0
local panelY = watermarkY + barHeight + 4
local panelX = watermarkX
local panelW = width
local panelBelow = true
local ft = (globals.FrameTime and globals.FrameTime() or 0.016)
local targetAnim = (gpDropdown.want ~= nil) and 1 or 0
gpDropdown.anim = gpDropdown.anim + (targetAnim - gpDropdown.anim) * math.min(1, ft * 14)
if gpDropdown.anim < 0.01 and gpDropdown.want == nil then
gpDropdown.anim = 0
gpDropdown.state = nil
end
if gpDropdown.state ~= nil and gpDropdown.anim > 0 then
local requiredH
if gpDropdown.state == "cash" then
requiredH = 52
else
local classesCount = 10
local cols = 3
local rows = math.ceil(classesCount / cols)
local btnH = 18
local gap = 6
local headerH = 36
local bottomPad = 10
requiredH = headerH + (rows * btnH) + ((rows - 1) * gap) + bottomPad
end
if (screenHeight - panelY) < (requiredH + 10) then
panelBelow = false
panelY = watermarkY - requiredH - 6
end
panelH = requiredH
local panelYDraw = panelY + math.floor((1 - gpDropdown.anim) * 8)
function PanelColor(r,g,b,a)
UI_Color(r, g, b, math.floor((a or 255) * gpDropdown.anim))
end
if mousePressed and not isDragging then
local inPanel = (mouse.x >= panelX and mouse.x <= (panelX + panelW) and mouse.y >= panelYDraw and mouse.y <= (panelYDraw + panelH))
local inHeader = (mouse.y >= clickY1 and mouse.y <= clickY2 and mouse.x >= watermarkX and mouse.x <= (watermarkX + width))
if (not inPanel) and (not inHeader) then
if gpDropdown.want == "cash" then
local before = tonumber(gpDropdown.openedCashThreshold) or tonumber(config.moneyThreshold) or 0
local now = tonumber(config.moneyThreshold) or 0
if before ~= now then
SaveConfig(GP_CfgPath(), config)
AddNotification("Money threshold set to $" .. tostring(now), "success")
end
gpDropdown.openedCashThreshold = nil
end
gpDropdown.want = nil
gpDropdown.sliderDragging = false
end
end
do
local _bgA = math.floor(235 * gpDropdown.anim)
UI_Color(15, 15, 15, _bgA)
DrawRect(panelX, panelYDraw, panelW, panelH, {15, 15, 15, _bgA})
end
do
local _gA = math.floor(GP_GoldBarAlpha() * gpDropdown.anim)
UI_Color(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], _gA)
DrawRect(panelX, panelYDraw, panelW, 2, {GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], _gA})
GP_Color(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], _gA)
DrawRect(panelX, panelYDraw + panelH - 2, panelW, 2, {GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], _gA})
end
draw.SetFont(GP_UI.font2)
if gpDropdown.state == "cash" then
local minV, maxV, step = 1, 50000, 250
local curV = tonumber(config.moneyThreshold) or 6500
if curV < minV then curV = minV end
if curV > maxV then curV = maxV end
local label = "Threshold: $" .. tostring(curV)
PanelColor(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], 255)
SafeText(panelX + 10, panelYDraw + 8, label)
local trackX = panelX + 10
local trackY = panelYDraw + 30
local trackW = panelW - 20
local trackH = 10
UI_Color(40, 35, 20, 255)
SafeFilledRect(trackX, trackY, trackX + trackW, trackY + trackH)
local ratio = (curV - minV) / (maxV - minV)
local fillW = math.floor(trackW * ratio)
PanelColor(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], GP_GoldBarAlpha())
SafeFilledRect(trackX, trackY, trackX + fillW, trackY + trackH)
local onTrack = (mouse.x >= trackX and mouse.x <= (trackX + trackW) and mouse.y >= trackY - 4 and mouse.y <= trackY + trackH + 4)
if mousePressedDD and onTrack then
gpDropdown.sliderDragging = true
end
if mouseReleased then
gpDropdown.sliderDragging = false
SaveConfig(GP_CfgPath(), config)
local before = tonumber(gpDropdown.openedCashThreshold) or tonumber(config.moneyThreshold) or 0
local now = tonumber(config.moneyThreshold) or 0
if before ~= now then
AddNotification("Money threshold set to $" .. tostring(now), "success")
gpDropdown.openedCashThreshold = now
end
end
if gpDropdown.sliderDragging and mouseDown then
local t = (mouse.x - trackX) / trackW
if t < 0 then t = 0 end
if t > 1 then t = 1 end
local raw = minV + (maxV - minV) * t
local snapped = math.floor((raw + step / 2) / step) * step
if snapped < minV then snapped = minV end
if snapped > maxV then snapped = maxV end
if snapped ~= config.moneyThreshold then
config.moneyThreshold = snapped
end
end
elseif gpDropdown.state == "class" then
PanelColor(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], 255)
SafeText(panelX + 10, panelYDraw + 8, "Select class")
local classes = {"scout","soldier","pyro","demoman","heavy","engineer","medic","sniper","spy","no class"}
local btnW = math.floor((panelW - 20 - 2 * 6) / 3)
local btnH = 18
local startX = panelX + 10
local startY = panelYDraw + 36
local gap = 6
for i = 1, #classes do
local col = (i - 1) % 3
local row = math.floor((i - 1) / 3)
local bx = startX + col * (btnW + gap)
local by = startY + row * (btnH + gap)
local name = classes[i]
local isNoClass = (name == "no class")
local isSelected
if isNoClass then
isSelected = (not config.changeClassEnabled)
else
isSelected = (config.changeClassEnabled and config.targetClass == name)
end
if isSelected then
PanelColor(GP_UI.colors.gold[1], GP_UI.colors.gold[2], GP_UI.colors.gold[3], GP_GoldBarAlpha())
SafeFilledRect(bx, by, bx + btnW, by + btnH)
UI_Color(15, 15, 15, 255)
else
UI_Color(30, 30, 30, 255)
SafeFilledRect(bx, by, bx + btnW, by + btnH)
PanelColor(GP_UI.colors.text[1], GP_UI.colors.text[2], GP_UI.colors.text[3], 255)
end
if mousePressedDD and mouse.x >= bx and mouse.x <= (bx + btnW) and mouse.y >= by and mouse.y <= (by + btnH) then
if isNoClass then
config.changeClassEnabled = false
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
pendingRetry = false
hasTriedClassChange = false
else
config.changeClassEnabled = true
config.targetClass = name
needToLeaveZone = false
leaveZoneStartPos = nil
leaveZoneTime = 0
pendingRetry = false
hasTriedClassChange = false
end
if isNoClass then
AddNotification("Auto class change disabled", "success")
else
AddNotification("Target class set to " .. tostring(name) .. " after threshold", "success")
end
SaveConfig(GP_CfgPath(), config)
gpDropdown.want = nil
end
SafeText(bx + 6, by + 2, name)
end
end
end
local currentTime = GP_Time()
UI.notifications = UI.notifications or {}
local dropdownOffset = ((gpDropdown.state ~= nil and gpDropdown.anim > 0 and panelBelow) and (panelH + 4) or 0)
local baseY = watermarkY + barHeight + 4 + dropdownOffset
baseY = math.max(0, math.min(baseY, screenHeight - UI.notificationHeight - 4))
local inDur = UI.notificationInDur or 0.22
local outDur = UI.notificationOutDur or 0.28
local slide = UI.notificationSlide or 16
for i = #UI.notifications, 1, -1 do
local notif = UI.notifications[i]
local age = currentTime - (notif.time or currentTime)
if age < 0 then
notif.time = currentTime
age = 0
end
local alpha
local off
local life = tonumber(notif.lifetime) or UI.notificationLifetime
local minLife = (inDur + outDur + 0.05)
if life < minLife then life = minLife end
if age < inDur then
local t = age / inDur
local e = GP_EaseOutCubic(t)
alpha = math.floor(255 * e + 0.5)
off = (1 - e) * slide
elseif age > (life - outDur) then
local t = (age - (life - outDur)) / outDur
local e = GP_EaseInCubic(t)
alpha = math.floor(255 * (1 - e) + 0.5)
off = -e * slide
else
alpha = 255
off = 0
end
notif.alpha = alpha
notif.offsetY = off
if age >= life and alpha <= 1 then
table.remove(UI.notifications, i)
end
end
for i = 1, #UI.notifications do
local notif = UI.notifications[i]
local targetY = baseY + (i - 1) * (UI.notificationHeight + UI.notificationSpacing)
local dt = GP_FrameDT()
local spring = UI.notificationSpring or 18.0
local t = 1 - math.exp(-spring * dt)
if notif.y == nil then notif.y = targetY end
notif.y = notif.y + (targetY - notif.y) * t
local offY = notif.offsetY or 0
if i == 1 and offY < 0 then offY = 0 end
local y = math.floor((notif.y or targetY) + offY + 0.5)
if (notif.alpha or 0) >= 5 then
DrawNotification(notif, watermarkX, y)
end
end
GP_DrawRightClickMenu(watermarkX, watermarkY, barHeight, screenWidth, screenHeight, mouse.x, mouse.y, rPressedAny)
end

function GP_SetUIPosition(x, y, save)
local nx = tonumber(x)
local ny = tonumber(y)
if nx then watermarkX = nx end
if ny then watermarkY = ny end
config.watermarkX = watermarkX
config.watermarkY = watermarkY
if save then
SaveConfig(GP_CfgPath(), config)
end
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
if tc == "sniper" and sbOn then
return "sniper", "vote_restart_target_sniperbuy", "sniper_cycle"
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
if tc == "sniper" and sbOn then
return "sniper", "fail_wave2plus_target_sniperbuy", "sniper_cycle"
end
return tc, "fail_wave2plus_target_class", "target_only"
end
return nil, "fail_wave2plus_no_path", "none"
end
if acOn then
return "medic", "prewave_autocredit", "medic_cycle"
end
if tc then
if tc == "sniper" and sbOn then
return "sniper", "prewave_target_sniperbuy", "sniper_cycle"
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
elseif mode == "sniper_cycle" and target == "sniper" then
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
if target == "sniper" and (config and config.autoBuyEnabled) and (not forceSniperBuyModeEnabled) then
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

function GP_PartyReasonsToString(reasons)
if reasons == true then return "true" end
if type(reasons) == "table" then
local out = {}
for _, v in pairs(reasons) do
out[#out + 1] = tostring(v)
end
if #out > 0 then return table.concat(out, ", ") end
return "empty table"
end
return tostring(reasons)
end

function GP_PartyQueueOperationKey()
local key = tostring((config and config.partyAutoQueueOperation) or "two_cities")
if not GP_PARTY_QUEUE_OPERATIONS[key] then
key = "two_cities"
if config then config.partyAutoQueueOperation = key end
end
return key
end

function GP_PartyQueueOperationLabel(key)
key = tostring(key or GP_PartyQueueOperationKey())
local rec = GP_PARTY_QUEUE_OPERATIONS[key]
return (rec and rec.label) or "Two Cities"
end

function GP_PartyCanControlQueue()
local members = GP_PartyMembers()
if members and #members > 1 then
local amLeader = GP_PartyAmLeader()
if amLeader == false then
return false, "not_leader"
end
end
return true, "ok"
end

function GP_PartyCancelQueuedMatchGroups()
if party and party.GetQueuedMatchGroups and party.CancelQueue then
local okQueued, queued = pcall(function() return party.GetQueuedMatchGroups() end)
if okQueued and type(queued) == "table" then
for _, matchGroup in pairs(queued) do
pcall(function() party.CancelQueue(matchGroup) end)
end
end
end
if party and party.IsInStandbyQueue and party.CancelQueueStandby then
local okStandby, inStandby = pcall(function() return party.IsInStandbyQueue() end)
if okStandby and inStandby == true then
pcall(function() party.CancelQueueStandby() end)
end
end
gpPartyAutoQueueGcArmUntil = 0
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueueCooldownUntil = 0
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueMatchJoinLastAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
gpPartyAutoQueueNextAt = GP_PartyNow() + 0.25
end

function GP_PartyAutoQueueHandleMatchInvite(now, reason)
if not gamecoordinator then return false end
now = tonumber(now) or GP_PartyNow()
if (now - (gpPartyAutoQueueMatchJoinLastAt or 0)) < 2.0 then return true end
gpPartyAutoQueueMatchJoinLastAt = now
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueOptionsReadyAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueueCooldownUntil = 0
local okAccept, acceptResult = false, "no_api"
if gamecoordinator.AcceptMatchInvites then
okAccept, acceptResult = pcall(function() return gamecoordinator.AcceptMatchInvites() end)
end
local okJoin, joinResult = false, "no_api"
if gamecoordinator.JoinMatchmakingMatch then
okJoin, joinResult = pcall(function() return gamecoordinator.JoinMatchmakingMatch() end)
end
GP_PartyFeatureLog("autoqueue_match_join", "auto queue match " .. tostring(reason or "invite") .. ": accept=" .. tostring(okAccept) .. "/" .. tostring(acceptResult) .. " join=" .. tostring(okJoin) .. "/" .. tostring(joinResult), 0)
return true
end

function GP_PartyAutoQueueRefresh(reason)
if config and config.partyAutoQueueEnabled ~= true then
GP_PartyCancelQueuedMatchGroups()
return
end
GP_PartyCancelQueuedMatchGroups()
local label = GP_PartyQueueOperationLabel()
local now = GP_PartyNow()
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueuePendingUntil = 0
gpPartyAutoQueueOptionsReadyAt = 0
gpPartyAutoQueueSetOptionsForceQueueUntil = 0
gpPartyAutoQueueCooldownUntil = math.max(gpPartyAutoQueueCooldownUntil or 0, now + GP_PARTY_AUTO_QUEUE_START_DELAY)
gpPartyAutoQueueNextAt = now + GP_PARTY_AUTO_QUEUE_START_DELAY
GP_PartyFeatureLog("autoqueue_refresh", "auto queue refresh reason=" .. tostring(reason or "nil") .. " operation=" .. tostring(label), 0)
if reason == "operation" then
AddNotification("Auto Queue operation set to " .. label, "info")
elseif reason == "enabled" then
AddNotification("Auto Queue Enabled (" .. label .. ", leader only)", "info")
end
end

function GP_PartyAutoQueueWarnParty(text, cooldown)
local now = GP_PartyNow()
cooldown = tonumber(cooldown) or 12.0
if (now - (gpPartyAutoQueueLastPartyWarnAt or 0)) < cooldown then return false end
gpPartyAutoQueueLastPartyWarnAt = now
if GP_PartySayParty then
return GP_PartySayParty("[AutoQueue] " .. tostring(text or "Queue stopped."))
end
return GP_PartyRun('say_party "[AutoQueue] ' .. tostring(text or "Queue stopped."):gsub('"', "'") .. '"')
end

function GP_PartyAutoQueueReasonNeedsPartyWarning(reasons)
local text = GP_PartyReasonsToString(reasons)
local lower = string.lower(text or "")
if lower == "" then return false, text end
if string.find(lower, "ticket", 1, true) then return true, text end
if string.find(lower, "tour", 1, true) and string.find(lower, "duty", 1, true) then return true, text end
if string.find(lower, "no missions", 1, true) then return true, text end
if string.find(lower, "not completed", 1, true) then return true, text end
return false, text
end

function GP_PartyAutoQueueStateText(now)
now = tonumber(now) or GP_PartyNow()
if not (config and config.partyAutoQueueEnabled == true) then return "Off" end
if config.partyAutoQueuePaused == true then return "Stopped" end
if gpPartyAutoQueueWasQueued == true then return "Queued" end
if now < (gpPartyAutoQueuePendingUntil or 0) then
return "Checking queue in " .. tostring(math.max(0, math.ceil((gpPartyAutoQueuePendingUntil or 0) - now))) .. "s"
end
if now < (gpPartyAutoQueueCooldownUntil or 0) then
return "Queue in " .. tostring(math.max(0, math.ceil((gpPartyAutoQueueCooldownUntil or 0) - now))) .. "s"
end
if now < (gpPartyAutoQueueNextAt or 0) then
return "Queue in " .. tostring(math.max(0, math.ceil((gpPartyAutoQueueNextAt or 0) - now))) .. "s"
end
return "Queue now"
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

function GP_PartyVoteRevealChat(text)
if config and config.partyVoteRevealOutput == "local" then
return GP_PartyVoteRevealLocalChat(text)
end
return GP_PartyVoteRevealPartyChat(text)
end

function GP_PartyVoteRevealPlainText(text)
text = tostring(text or "")
text = text:gsub("\x08%x%x%x%x%x%x%x%x", "")
text = text:gsub("\x01", "")
return GP_PartyVoteRevealCleanText(text)
end

function GP_PartyVoteRevealLocalColorText(text)
text = tostring(text or "")
text = text:gsub("\n", " ")
text = text:gsub(GP_PARTY_VOTE_REVEAL_ORANGE, "")
text = text:gsub("\x01", "")
return GP_PartyTrim(text)
end

function GP_PartyVoteRevealLocalChat(text)
text = GP_PartyVoteRevealLocalColorText(text)
if text == "" then return false end
local line = GP_PARTY_VOTE_REVEAL_ORANGE .. "[Vote] " .. text
if client and client.ChatPrintf then
pcall(function() client.ChatPrintf(line) end)
return true
end
if client and client.ChatPrint then
pcall(function() client.ChatPrint(GP_PartyVoteRevealPlainText("[Vote] " .. text)) end)
return true
end
print(GP_PartyVoteRevealPlainText("[Vote] " .. text))
return true
end

function GP_PartyVoteRevealPartyChat(text)
text = GP_PartyVoteRevealPlainText(text)
if text == "" then return false end
if GP_PartySayParty then
return GP_PartySayParty("[Vote] " .. text)
end
text = text:gsub('"', "'")
return GP_PartyRun('say_party "[Vote] ' .. text .. '"')
end

function GP_PartyVoteRevealPlayerInfo(entityID)
entityID = tonumber(entityID)
if not entityID or entityID <= 0 then return nil end
local out = nil
pcall(function()
if client and client.GetPlayerInfo then
local info = client.GetPlayerInfo(entityID)
if type(info) == "table" then
out = info
end
end
end)
return out
end

function GP_PartyVoteRevealPlayerName(entityID)
entityID = tonumber(entityID)
if not entityID or entityID <= 0 then return nil end
local nameText = nil
local info = GP_PartyVoteRevealPlayerInfo(entityID)
if type(info) == "table" then
nameText = info.Name or info.name
end
if not nameText or nameText == "" then
pcall(function()
if client and client.GetPlayerNameByIndex then
nameText = client.GetPlayerNameByIndex(entityID)
end
end)
end
nameText = GP_PartyTrim(nameText or "")
if nameText == "" then return nil end
return nameText
end

function GP_PartyVoteRevealHumanPlayerName(entityID)
local info = GP_PartyVoteRevealPlayerInfo(entityID)
if type(info) ~= "table" then return nil end
if info.IsBot == true or info.isBot == true or info.FakePlayer == true or info.fakeplayer == true then return nil end
local steamID = tostring(info.SteamID or info.steamID or info.steamid or info.SteamID64 or info.steamID64 or "")
if steamID == "" or steamID == "BOT" or steamID == "0" then return nil end
if not (string.find(steamID, "STEAM_", 1, true) or string.find(steamID, "[U:", 1, true) or string.find(steamID, "7656", 1, true)) then
return nil
end
return GP_PartyVoteRevealPlayerName(entityID)
end

function GP_PartyVoteRevealNameKey(name)
name = GP_PartyVoteRevealCleanText(name)
name = string.lower(name)
name = name:gsub("%s+", " ")
name = name:gsub("^%s+", ""):gsub("%s+$", "")
return name
end

function GP_PartyVoteRevealNamesMatch(a, b)
local ak = GP_PartyVoteRevealNameKey(a)
local bk = GP_PartyVoteRevealNameKey(b)
if ak == "" or bk == "" then return false end
if ak == bk then return true end
local short = (#ak < #bk) and ak or bk
local long = (#ak < #bk) and bk or ak
if #short < 3 then return false end
if string.sub(long, 1, #short) == short then
local nextChar = string.sub(long, #short + 1, #short + 1)
if nextChar == "" or nextChar == " " or nextChar == "(" or nextChar == "[" then return true end
end
return false
end

function GP_PartyVoteRevealTargetNameFromIssue(issue, details)
local out = GP_PartyVoteRevealCleanText(details)
if out ~= "" then
out = out:gsub("^Kick player:%s*", "")
out = out:gsub("%?%s*%([Nn]o reason given%)", "")
out = out:gsub("%?%s*%([Nn]o reason%)", "")
out = out:gsub("%?%s*$", "")
out = GP_PartyTrim(out)
end
if out == "" then
local text = GP_PartyVoteRevealCleanText(issue)
out = text:match("[Kk]ick player:%s*(.-)%s*%?") or text:match("[Kk]ick player:%s*(.-)%s*%(") or ""
out = GP_PartyTrim(out)
end
if out == "" then return nil end
return out
end

function GP_PartyVoteRevealReasonFromIssue(issue, details)
local text = GP_PartyVoteRevealCleanText(details)
local reason = text:match("%?%s*%((.-)%)")
if not reason or reason == "" then
text = GP_PartyVoteRevealCleanText(issue)
reason = text:match("%?%s*%((.-)%)")
end
reason = GP_PartyTrim(reason or "")
if reason == "" then return "" end
if string.lower(reason) == "no reason given" or string.lower(reason) == "no reason" then return "" end
return "(" .. reason .. ")"
end

function GP_PartyVoteRevealFormatIssue(issue, details, targetName)
issue = GP_PartyVoteRevealCleanText(issue)
targetName = GP_PartyVoteRevealCleanText(targetName)
if targetName ~= "" and string.find(string.lower(issue), "kick player", 1, true) then
local reason = GP_PartyVoteRevealReasonFromIssue(issue, details)
local suffix = reason ~= "" and (" " .. reason) or ""
return "Kick player: " .. GP_PARTY_VOTE_REVEAL_RED .. targetName .. GP_PARTY_VOTE_REVEAL_ORANGE .. suffix
end
issue = issue:gsub("%?%s*%(", " (")
issue = issue:gsub("%?%s*$", "")
return GP_PartyVoteRevealCleanText(issue)
end

function GP_PartyVoteRevealOptionText(voteOption)
local opt = tonumber(voteOption)
if opt == 0 then return GP_PARTY_VOTE_REVEAL_GREEN .. "F1" .. GP_PARTY_VOTE_REVEAL_ORANGE end
if opt == 1 then return GP_PARTY_VOTE_REVEAL_RED .. "F2" .. GP_PARTY_VOTE_REVEAL_ORANGE end
return "Option " .. tostring(voteOption)
end

function GP_PartyVoteRevealCleanText(text)
text = tostring(text or "")
text = text:gsub("%c", "")
text = text:gsub("\n", " ")
return GP_PartyTrim(text)
end

function GP_PartyVoteRevealLocalize(dispKey, details)
local text = tostring(dispKey or "")
local localized = nil
pcall(function()
if client and client.Localize then
localized = client.Localize(text)
end
end)
if localized and localized ~= "" then
text = localized
end
details = GP_PartyVoteRevealCleanText(details)
if details ~= "" then
text = text:gsub("%%s%d+", details)
end
return GP_PartyVoteRevealCleanText(text)
end

function GP_PartyVoteRevealClear(voteIdx)
local key = tostring(voteIdx or "")
if key ~= "" then
for castKey in pairs(gpVoteRevealSeenCast) do
if string.sub(castKey, 1, #key + 1) == (key .. ":") then
gpVoteRevealSeenCast[castKey] = nil
end
end
gpVoteRevealStarter[key] = nil
gpVoteRevealTarget[key] = nil
gpVoteRevealTargetName[key] = nil
for castKey in pairs(gpVoteRevealPendingCasts) do
if string.sub(castKey, 1, #key + 1) == (key .. ":") then
gpVoteRevealPendingCasts[castKey] = nil
end
end
end
end

function GP_PartyVoteRevealClose(voteIdx)
local key = tostring(voteIdx or "")
if key ~= "" then
gpVoteRevealClosedUntil[key] = GP_PartyNow() + 4.0
GP_PartyVoteRevealClear(voteIdx)
end
end

function GP_PartyVoteRevealIsClosed(voteIdx)
local key = tostring(voteIdx or "")
local untilT = gpVoteRevealClosedUntil[key]
if type(untilT) ~= "number" then return false end
if untilT <= GP_PartyNow() then
gpVoteRevealClosedUntil[key] = nil
return false
end
return true
end

function GP_PartyVoteRevealShouldSuppressCast(voteIdx, entityID, voteOption)
local voteKey = tostring(voteIdx or "")
entityID = tonumber(entityID)
voteOption = tonumber(voteOption)
if tonumber(gpVoteRevealStarter[voteKey] or -1) == entityID and voteOption == 0 then return true end
if tonumber(gpVoteRevealTarget[voteKey] or -1) == entityID and voteOption == 1 then return true end
if voteOption == 1 and gpVoteRevealTargetName[voteKey] then
local nameText = GP_PartyVoteRevealPlayerName(entityID)
if nameText and GP_PartyVoteRevealNamesMatch(nameText, gpVoteRevealTargetName[voteKey]) then return true end
end
return false
end

function GP_PartyVoteRevealEmitCast(voteIdx, entityID, voteOption)
if GP_PartyVoteRevealIsClosed(voteIdx) then return false end
if GP_PartyVoteRevealShouldSuppressCast(voteIdx, entityID, voteOption) then return true end
local nameText = GP_PartyVoteRevealPlayerName(entityID) or ("Player#" .. tostring(entityID))
local optionText = GP_PartyVoteRevealOptionText(voteOption)
GP_PartyVoteRevealChat(nameText .. " pressed " .. optionText)
return true
end

function GP_PartyVoteRevealTick(now)
now = tonumber(now) or GP_PartyNow()
for key, rec in pairs(gpVoteRevealPendingCasts) do
if type(rec) ~= "table" or now >= ((rec.at or 0) + 0.65) then
gpVoteRevealPendingCasts[key] = nil
if type(rec) == "table" then
GP_PartyVoteRevealEmitCast(rec.voteIdx, rec.entityID, rec.voteOption)
end
end
end
end

function GP_PartyVoteRevealReportDidntVote(voteIdx)
local voteKey = tostring(voteIdx or "")
if voteKey == "" or gpVoteRevealReportedMissing[voteKey] == true then return false end
gpVoteRevealReportedMissing[voteKey] = true
local missing = {}
local starterId = tonumber(gpVoteRevealStarter[voteKey] or -1)
local targetId = tonumber(gpVoteRevealTarget[voteKey] or -1)
local targetName = gpVoteRevealTargetName[voteKey]
for i = 1, 32 do
local nameText = GP_PartyVoteRevealHumanPlayerName(i)
local skipMissing = (i == starterId) or (i == targetId)
if (not skipMissing) and nameText and targetName and GP_PartyVoteRevealNamesMatch(nameText, targetName) then
skipMissing = true
end
if nameText and (not skipMissing) and gpVoteRevealSeenCast[voteKey .. ":" .. tostring(i)] ~= true then
missing[#missing + 1] = nameText
end
end
if #missing == 0 then return false end
GP_PartyVoteRevealChat(GP_PARTY_VOTE_REVEAL_RED .. table.concat(missing, GP_PARTY_VOTE_REVEAL_ORANGE .. " /// " .. GP_PARTY_VOTE_REVEAL_RED) .. GP_PARTY_VOTE_REVEAL_ORANGE .. " - didn't vote")
return true
end

function GP_PartyVoteRevealCloseByTargetName(nameText)
nameText = GP_PartyVoteRevealCleanText(nameText)
if nameText == "" then return false end
local closed = false
for voteKey, targetName in pairs(gpVoteRevealTargetName) do
if GP_PartyVoteRevealNamesMatch(nameText, targetName) then
GP_PartyVoteRevealReportDidntVote(voteKey)
GP_PartyVoteRevealClose(voteKey)
closed = true
end
end
return closed
end

local function GP_PartyEncodeVarint(val)
val = tonumber(val) or 0
if val < 0 then val = 0 end
local bytes = ""
repeat
local b = val % 128
val = math.floor(val / 128)
if val > 0 then b = b + 128 end
bytes = bytes .. string.char(b)
until val == 0
return bytes
end

local function GP_PartyFieldVarint(num, val)
return GP_PartyEncodeVarint((tonumber(num) or 0) * 8) .. GP_PartyEncodeVarint(val)
end

local function GP_PartyFixed64LE(val)
val = tonumber(val) or 0
if val < 0 then val = 0 end
local bytes = {}
for _ = 1, 8 do
local b = val % 256
bytes[#bytes + 1] = string.char(b)
val = math.floor(val / 256)
end
return table.concat(bytes)
end

local function GP_PartyFieldFixed64(num, val)
return GP_PartyEncodeVarint((tonumber(num) or 0) * 8 + 1) .. GP_PartyFixed64LE(val)
end

local function GP_PartyFieldStr(num, s)
return GP_PartyEncodeVarint((tonumber(num) or 0) * 8 + 2) .. GP_PartyEncodeVarint(#s) .. s
end

local function GP_PartyFieldMsg(num, data)
return GP_PartyEncodeVarint((tonumber(num) or 0) * 8 + 2) .. GP_PartyEncodeVarint(#data) .. data
end

function GP_PartyAutoQueuePayload()
local op = GP_PARTY_QUEUE_OPERATIONS[GP_PartyQueueOperationKey()]
if not op or type(op.missions) ~= "table" then return nil end
local groupCriteria = ""
if type(op.tour) == "string" and op.tour ~= "" then
groupCriteria = groupCriteria .. GP_PartyFieldStr(14, op.tour)
end
local options = GP_PartyFieldMsg(2, groupCriteria)
return GP_PartyFieldMsg(2, options) .. GP_PartyFieldVarint(3, 1)
end

local function GP_PartyReadProtoVarint(raw, pos)
if type(raw) ~= "string" then return nil, pos end
local shift = 0
local value = 0
while pos <= #raw and shift <= 49 do
local b = string.byte(raw, pos) or 0
pos = pos + 1
value = value + (b % 128) * (2 ^ shift)
if b < 128 then return value, pos end
shift = shift + 7
end
return nil, pos
end

local function GP_PartyGetVarintField(raw, wantedField)
local pos = 1
wantedField = tonumber(wantedField) or 0
while type(raw) == "string" and pos <= #raw do
local key
key, pos = GP_PartyReadProtoVarint(raw, pos)
if not key then return nil end
local field = math.floor(key / 8)
local wire = key % 8
if field == wantedField and wire == 0 then
local val
val = GP_PartyReadProtoVarint(raw, pos)
return val
end
if wire == 0 then
local _, nextPos = GP_PartyReadProtoVarint(raw, pos)
if not nextPos or nextPos <= pos then return nil end
pos = nextPos
elseif wire == 1 then
pos = pos + 8
elseif wire == 2 then
local len
len, pos = GP_PartyReadProtoVarint(raw, pos)
if not len then return nil end
pos = pos + len
elseif wire == 5 then
pos = pos + 4
else
return nil
end
end
return nil
end

local function GP_PartyFixed64ToNumber(raw, pos)
if type(raw) ~= "string" or not pos or pos + 7 > #raw then return nil end
local mult = 1
local val = 0
for i = pos, pos + 7 do
val = val + (string.byte(raw, i) or 0) * mult
mult = mult * 256
end
return val
end

local function GP_PartyGetFixed64Field(raw, wantedField)
local pos = 1
wantedField = tonumber(wantedField) or 0
while type(raw) == "string" and pos <= #raw do
local key
key, pos = GP_PartyReadProtoVarint(raw, pos)
if not key then return nil end
local field = math.floor(key / 8)
local wire = key % 8
if field == wantedField and wire == 1 then
return GP_PartyFixed64ToNumber(raw, pos)
end
if wire == 0 then
local _, nextPos = GP_PartyReadProtoVarint(raw, pos)
if not nextPos or nextPos <= pos then return nil end
pos = nextPos
elseif wire == 1 then
pos = pos + 8
elseif wire == 2 then
local len
len, pos = GP_PartyReadProtoVarint(raw, pos)
if not len then return nil end
pos = pos + len
elseif wire == 5 then
pos = pos + 4
else
return nil
end
end
return nil
end

local function GP_PartyScanVarintFields(raw)
local pos = 1
local out = {}
while type(raw) == "string" and pos <= #raw do
local key
key, pos = GP_PartyReadProtoVarint(raw, pos)
if not key then break end
local field = math.floor(key / 8)
local wire = key % 8
if wire == 0 then
local val, nextPos = GP_PartyReadProtoVarint(raw, pos)
if val == nil or not nextPos or nextPos <= pos then break end
out[#out + 1] = {field = field, wire = wire, value = val}
pos = nextPos
elseif wire == 1 then
out[#out + 1] = {field = field, wire = wire, value = "fixed64"}
pos = pos + 8
elseif wire == 2 then
local len
len, pos = GP_PartyReadProtoVarint(raw, pos)
if not len then break end
out[#out + 1] = {field = field, wire = wire, value = "len" .. tostring(len)}
pos = pos + len
elseif wire == 5 then
out[#out + 1] = {field = field, wire = wire, value = "fixed32"}
pos = pos + 4
else
out[#out + 1] = {field = field, wire = wire, value = "badwire"}
break
end
end
return out
end

local function GP_PartyFindLikelyPartyID(raw)
local best = nil
local bestSummary = ""
raw = tostring(raw or "")
for offset = 1, math.min(#raw, 12) do
local fields = GP_PartyScanVarintFields(string.sub(raw, offset))
local parts = {}
for i = 1, #fields do
local rec = fields[i]
parts[#parts + 1] = tostring(rec.field) .. "/" .. tostring(rec.wire) .. "=" .. tostring(rec.value)
local n = tonumber(rec.value)
if n and n > 100000000000 and n < 9007199254740991 then
best = n
bestSummary = "offset=" .. tostring(offset) .. " " .. table.concat(parts, " ")
return best, bestSummary
end
end
if offset == 1 then
bestSummary = "offset=1 " .. table.concat(parts, " ")
end
end
return best, bestSummary
end

local function GP_PartyHex(raw, maxLen)
raw = tostring(raw or "")
maxLen = math.min(tonumber(maxLen) or #raw, #raw)
local out = {}
for i = 1, maxLen do
out[#out + 1] = string.format("%02X", string.byte(raw, i) or 0)
end
return table.concat(out, " ")
end

function GP_PartyGetGroupID()
if not (party and party.GetGroupID) then return 0, "fallback_zero_no_api" end
local ok, groupID = pcall(function() return party.GetGroupID() end)
if not ok then return 0, "fallback_zero_error" end
groupID = tonumber(groupID)
if groupID and groupID > 0 then return groupID end
return 0, "fallback_zero_empty"
end

function GP_PartyAutoQueueDirectPayload(forcedPartyID)
local op = GP_PARTY_QUEUE_OPERATIONS[GP_PartyQueueOperationKey()]
if not op or type(op.missions) ~= "table" then return nil, "operation unavailable" end
local partyID, partyIDNote = tonumber(forcedPartyID), "from_queueup_payload"
if not partyID then
partyID, partyIDNote = GP_PartyGetGroupID()
end
if partyID == nil then return nil, "party group id unavailable" end
local groupCriteria = ""
if type(op.tour) == "string" and op.tour ~= "" then
groupCriteria = groupCriteria .. GP_PartyFieldStr(14, op.tour)
end
local finalOptions = GP_PartyFieldMsg(2, groupCriteria)
local payload = GP_PartyFieldVarint(1, partyID) .. GP_PartyFieldMsg(2, finalOptions) .. GP_PartyFieldVarint(3, 1)
return payload, nil, partyID, 0, partyIDNote
end

function GP_PartyAutoQueueOptionsPayload(forcedPartyID)
local op = GP_PARTY_QUEUE_OPERATIONS[GP_PartyQueueOperationKey()]
if not op or type(op.missions) ~= "table" then return nil, "operation unavailable" end
local partyID = tonumber(forcedPartyID)
if not partyID then
partyID = GP_PartyGetGroupID()
end
if not partyID then return nil, "party group id unavailable" end
local groupCriteria = ""
if type(op.tour) == "string" and op.tour ~= "" then
groupCriteria = groupCriteria .. GP_PartyFieldStr(14, op.tour)
end
local finalOptions = GP_PartyFieldMsg(2, groupCriteria)
return GP_PartyFieldFixed64(1, partyID) .. GP_PartyFieldMsg(2, finalOptions) .. GP_PartyFieldVarint(3, 1), nil, partyID
end

function GP_PartyAutoQueueSendOptions()
return false, "disabled"
end

function GP_PartyAutoQueueRawPayload(raw, partyID)
local op = GP_PARTY_QUEUE_OPERATIONS[GP_PartyQueueOperationKey()]
if not op or type(op.missions) ~= "table" then return nil end
local header = ""
local preamble = ""
if type(raw) == "string" and #raw >= 17 then
header = string.sub(raw, 1, 8)
if string.byte(raw, 9) == 0x51 then
preamble = string.sub(raw, 9, 17)
end
end
local groupCriteria = ""
if type(op.tour) == "string" and op.tour ~= "" then
groupCriteria = groupCriteria .. GP_PartyFieldStr(14, op.tour)
end
local finalOptions = GP_PartyFieldMsg(2, groupCriteria)
local msg = preamble .. GP_PartyFieldFixed64(1, partyID) .. GP_PartyFieldMsg(2, finalOptions) .. GP_PartyFieldVarint(3, 1)
return header .. msg
end

function GP_PartyAutoQueueLearnFromRaw(raw, source, msgType)
if type(raw) ~= "string" or #raw < 40 then return false end
local suffix = string.sub(raw, 27)
if type(suffix) ~= "string" or #suffix < 10 then return false end
if string.find(suffix, string.char(0x12), 1, true) == nil then return false end
local key = GP_PartyQueueOperationKey()
msgType = tonumber(msgType) or 0
if msgType == 6554 then
gpPartyAutoQueueLearnedSetOptionsByOperation[key] = raw
GP_PartyFeatureLog("autoqueue_learned_setopts_" .. key, "learned PartySetOptions for " .. GP_PartyQueueOperationLabel(key) .. " source=" .. tostring(source or "manual") .. " rawlen=" .. tostring(#raw), 0)
else
gpPartyAutoQueueLearnedSuffixByOperation[key] = suffix
GP_PartyFeatureLog("autoqueue_learned_queue_" .. key, "learned embedded queue options for " .. GP_PartyQueueOperationLabel(key) .. " source=" .. tostring(source or "manual") .. " rawlen=" .. tostring(#raw) .. " suffixlen=" .. tostring(#suffix), 0)
end
return true
end

function GP_PartyAutoQueueLearnedRawPayload(raw)
local suffix = gpPartyAutoQueueLearnedSuffixByOperation[GP_PartyQueueOperationKey()]
if type(raw) ~= "string" or #raw < 26 or type(suffix) ~= "string" or #suffix < 10 then return nil end
return string.sub(raw, 1, 26) .. suffix
end

function GP_PartyAutoQueueLearnedSetOptionsPayload()
local learned = gpPartyAutoQueueLearnedSetOptionsByOperation[GP_PartyQueueOperationKey()]
if type(learned) ~= "string" or #learned < 40 then return nil, "not learned" end
local partyID = GP_PartyGetGroupID()
if not partyID or partyID <= 0 then return learned, "learned_raw" end
return string.sub(learned, 1, 17) .. GP_PartyFieldFixed64(1, partyID) .. string.sub(learned, 27), "rebuilt_party"
end

function GP_PartyAutoQueueSendLearnedSetOptions()
if not (gamecoordinator and gamecoordinator.GCSendMessage) then return false, "no gamecoordinator.GCSendMessage" end
local payload, note = GP_PartyAutoQueueLearnedSetOptionsPayload()
if type(payload) ~= "string" then return false, tostring(note or "no learned payload") end
local ok, result = pcall(function() return gamecoordinator.GCSendMessage(6554, payload) end)
GP_PartyFeatureLog("autoqueue_setopts_send", "PartySetOptions learned send ok=" .. tostring(ok) .. " result=" .. tostring(result) .. " note=" .. tostring(note) .. " operation=" .. GP_PartyQueueOperationLabel() .. " rawlen=" .. tostring(#payload), 0)
return ok, result
end

function GP_PartyAutoQueueTick(now)
if not (config and config.partyAutoQueueEnabled == true) then return end
now = tonumber(now) or GP_PartyNow()
if now <= 0 then now = GP_PartyNow() end
if config.partyAutoQueuePaused == true then return end
if now < (gpPartyAutoQueueNextAt or 0) then return end
gpPartyAutoQueueNextAt = now + GP_PARTY_AUTO_QUEUE_INTERVAL
if not (party and party.GetQueuedMatchGroups and party.GetAllMatchGroups and party.QueueUp) then
GP_PartyFeatureLog("autoqueue_noapi", "auto queue blocked: party API unavailable", 4.0)
return
end
local canControl = GP_PartyCanControlQueue()
if canControl == false then
GP_PartyFeatureLog("autoqueue_notleader", "auto queue blocked: not party leader", 4.0)
return
end
if gamecoordinator then
local okGc, gcConnected = pcall(function() return gamecoordinator.ConnectedToGC and gamecoordinator.ConnectedToGC() end)
if okGc and gcConnected == false then
GP_PartyFeatureLog("autoqueue_nogc", "auto queue blocked: not connected to GC", 4.0)
return
end
local okConn, inServer = pcall(function() return gamecoordinator.IsConnectedToMatchServer and gamecoordinator.IsConnectedToMatchServer() end)
if okConn and inServer == true then
GP_PartyFeatureLog("autoqueue_inserver", "auto queue blocked: already connected to match server", 4.0)
return
end
local okLive, hasLive = pcall(function() return gamecoordinator.HasLiveMatch and gamecoordinator.HasLiveMatch() end)
if okLive and hasLive == true then
GP_PartyAutoQueueHandleMatchInvite(now, "live_match")
return
end
local okInv, numInvites = pcall(function() return gamecoordinator.GetNumMatchInvites and gamecoordinator.GetNumMatchInvites() end)
if okInv and (tonumber(numInvites) or 0) > 0 then
GP_PartyAutoQueueHandleMatchInvite(now, "invite_pending")
return
end
end
local okQueued, queued = pcall(function() return party.GetQueuedMatchGroups() end)
if okQueued and type(queued) == "table" and next(queued) ~= nil then
gpPartyAutoQueueWasQueued = true
gpPartyAutoQueuePendingUntil = 0
GP_PartyFeatureLog("autoqueue_alreadyqueued", "auto queue idle: already queued", 6.0)
return
end
if now < (gpPartyAutoQueuePendingUntil or 0) then
local leftPending = math.max(0, math.ceil((gpPartyAutoQueuePendingUntil or 0) - now))
GP_PartyFeatureLog("autoqueue_pending", "auto queue waiting for GC/local queue state: " .. tostring(leftPending) .. "s", 3.0)
return
end
if now < (gpPartyAutoQueueOptionsReadyAt or 0) then
local leftOptions = math.max(0, math.ceil((gpPartyAutoQueueOptionsReadyAt or 0) - now))
GP_PartyFeatureLog("autoqueue_options_wait", "auto queue waiting for PartySetOptions: " .. tostring(leftOptions) .. "s", 2.0)
return
end
if gpPartyAutoQueueWasQueued == true then
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueueCooldownUntil = now + GP_PARTY_AUTO_QUEUE_CANCEL_COOLDOWN
GP_PartyFeatureLog("autoqueue_cancel_cooldown", "queue was cancelled; waiting " .. tostring(math.floor(GP_PARTY_AUTO_QUEUE_CANCEL_COOLDOWN)) .. "s before requeue", 0)
if engine and engine.IsGameUIVisible and engine.IsGameUIVisible() then
GP_PartyAutoQueueWarnParty("Queue was cancelled. Check Tour of Duty tickets / unfinished mission availability if this was not intentional.", 15.0)
end
return
end
if now < (gpPartyAutoQueueCooldownUntil or 0) then
local left = math.max(0, math.ceil((gpPartyAutoQueueCooldownUntil or 0) - now))
GP_PartyFeatureLog("autoqueue_cooldown", "auto queue cooldown after cancel: " .. tostring(left) .. "s", 4.0)
return
end
if party.IsInStandbyQueue then
local okStandby, inStandby = pcall(function() return party.IsInStandbyQueue() end)
if okStandby and inStandby == true then
GP_PartyFeatureLog("autoqueue_standby", "auto queue blocked: standby queue active", 4.0)
return
end
end
local mannUp = nil
local okGroups, allGroups = pcall(function() return party.GetAllMatchGroups() end)
if okGroups and allGroups then mannUp = allGroups["MannUp"] end
local canQueueReasons = nil
if party.CanQueueForMatchGroup then
local okCanQueue, reasons = pcall(function()
if mannUp then return party.CanQueueForMatchGroup(mannUp) end
return false
end)
canQueueReasons = reasons
if (not okCanQueue or reasons ~= true) and mannUp then
GP_PartyFeatureLog("autoqueue_cannot_warn", "CanQueue warning: " .. GP_PartyReasonsToString(reasons), 4.0)
local shouldWarn, reasonText = GP_PartyAutoQueueReasonNeedsPartyWarning(reasons)
if shouldWarn and engine and engine.IsGameUIVisible and engine.IsGameUIVisible() then
GP_PartyAutoQueueWarnParty("Queue warning: " .. tostring(reasonText), 20.0)
end
end
end
if not mannUp then
GP_PartyFeatureLog("autoqueue_nomannup", "auto queue blocked: MannUp match group unavailable", 4.0)
return
end
local learnedSuffix = gpPartyAutoQueueLearnedSuffixByOperation[GP_PartyQueueOperationKey()]
local learnedSetOptions = gpPartyAutoQueueLearnedSetOptionsByOperation[GP_PartyQueueOperationKey()]
local hasLearnedEmbeddedOptions = type(learnedSuffix) == "string" and #learnedSuffix >= 10
local hasLearnedSetOptions = type(learnedSetOptions) == "string" and #learnedSetOptions >= 40
local hasLearnedOptions = hasLearnedEmbeddedOptions or hasLearnedSetOptions
if canQueueReasons ~= true and not hasLearnedOptions then
GP_PartyFeatureLog("autoqueue_requires_options", "auto queue blocked: set Mann Up only-not-completed in the MvM menu once so AutoQueue can learn it (" .. GP_PartyReasonsToString(canQueueReasons) .. ")", 4.0)
if engine and engine.IsGameUIVisible and engine.IsGameUIVisible() then
GP_PartyAutoQueueWarnParty("AutoQueue needs one manual Only missions not yet completed queue first, then it can reuse that option.", 20.0)
end
return
end
if hasLearnedSetOptions and canQueueReasons ~= true and now > (gpPartyAutoQueueSetOptionsForceQueueUntil or 0) then
local okSetOptions = GP_PartyAutoQueueSendLearnedSetOptions()
if okSetOptions then
gpPartyAutoQueueOptionsReadyAt = now + 0.85
gpPartyAutoQueueSetOptionsForceQueueUntil = now + 6.0
gpPartyAutoQueueNextAt = now + 0.85
GP_PartyFeatureLog("autoqueue_setopts_wait", "auto queue sent learned PartySetOptions; queueing MannUp in 1s", 0)
return
end
end
if hasLearnedEmbeddedOptions then
gpPartyAutoQueueGcArmUntil = now + 4.0
else
gpPartyAutoQueueGcArmUntil = 0
end
local okQueue, queueErr = pcall(function() party.QueueUp(mannUp) end)
if okQueue then
gpPartyAutoQueuePendingUntil = now + 10.0
gpPartyAutoQueueNextAt = now + 1.0
else
gpPartyAutoQueueGcArmUntil = 0
end
GP_PartyFeatureLog("autoqueue_queueup_patch", "QueueUp ok=" .. tostring(okQueue) .. " operation=" .. GP_PartyQueueOperationLabel() .. " mode=" .. (hasLearnedEmbeddedOptions and "learned_embedded_only_not_completed" or "manual_or_setoptions_only_not_completed") .. (okQueue and "" or (" err=" .. tostring(queueErr or payloadErr))), 0)
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

function GP_HandleVoteRevealEvent(name, ev)
if not (config and config.partyVoteRevealEnabled == true) then return false end
local lname = string.lower(tostring(name or ""))
if lname == "vote_cast" then
local voteIdx = GP_PartyEventInt(ev, "voteidx") or GP_PartyEventInt(ev, "vote_idx") or GP_PartyEventInt(ev, "voteid") or GP_PartyEventInt(ev, "vote_id")
local entityID = GP_PartyEventInt(ev, "entityid") or GP_PartyEventInt(ev, "entity_id")
local voteOption = GP_PartyEventInt(ev, "vote_option") or GP_PartyEventInt(ev, "option")
if not voteIdx or not entityID or voteOption == nil then return false end
if GP_PartyVoteRevealIsClosed(voteIdx) then return true end
local key = tostring(voteIdx) .. ":" .. tostring(entityID)
if gpVoteRevealSeenCast[key] == true then return true end
gpVoteRevealSeenCast[key] = true
gpVoteRevealPendingCasts[key] = {
voteIdx = voteIdx,
entityID = entityID,
voteOption = voteOption,
at = GP_PartyNow()
}
return true
end
if lname == "vote_ended" or lname == "vote_passed" or lname == "vote_failed" then
local voteIdx = GP_PartyEventInt(ev, "voteidx") or GP_PartyEventInt(ev, "vote_idx") or GP_PartyEventInt(ev, "voteid") or GP_PartyEventInt(ev, "vote_id")
if voteIdx ~= nil then
GP_PartyVoteRevealReportDidntVote(voteIdx)
GP_PartyVoteRevealClose(voteIdx)
else
gpVoteRevealSeenCast = {}
gpVoteRevealStarter = {}
gpVoteRevealTarget = {}
gpVoteRevealTargetName = {}
gpVoteRevealPendingCasts = {}
gpVoteRevealReportedMissing = {}
end
return false
end
if lname == "player_disconnect" then
local nameText = GP_TryGetEventString(ev, "name") or GP_TryGetEventString(ev, "player_name") or ""
if nameText ~= "" then
GP_PartyVoteRevealCloseByTargetName(nameText)
end
return false
end
return false
end

function GP_HandleAutoPartyInviteEvent(_, _)
return false
end

function GP_HandleVoteRevealUserMessage(msg)
if not (config and config.partyVoteRevealEnabled == true) then return end
if not msg or not msg.GetID then return end
local okId, id = pcall(function() return msg:GetID() end)
if not okId then return end
if type(VoteStart) == "number" and id == VoteStart then
msg:ReadByte()
local voteIdx = msg:ReadInt(32)
local entityID = msg:ReadByte()
local dispStr = msg:ReadString(64)
local detailsStr = msg:ReadString(64)
local targetID = msg:ReadByte()
local playerName = nil
pcall(function()
if client and client.GetPlayerInfo then
local info = client.GetPlayerInfo(entityID)
if type(info) == "table" then
playerName = info.Name
end
end
end)
if not playerName or playerName == "" then
pcall(function()
if client and client.GetPlayerNameByIndex then
playerName = client.GetPlayerNameByIndex(entityID)
end
end)
end
playerName = GP_PartyTrim(playerName or ("Player#" .. tostring(entityID)))
local voteKey = tostring(voteIdx or "")
if voteKey ~= "" then
gpVoteRevealClosedUntil[voteKey] = nil
gpVoteRevealReportedMissing[voteKey] = nil
gpVoteRevealStarter[voteKey] = entityID
gpVoteRevealTarget[voteKey] = targetID
end
local issue = GP_PartyVoteRevealLocalize(dispStr, detailsStr)
if issue == "" then
issue = GP_PartyVoteRevealCleanText(dispStr)
end
local targetName = GP_PartyVoteRevealTargetNameFromIssue(issue, detailsStr)
if voteKey ~= "" then
gpVoteRevealTargetName[voteKey] = targetName
end
issue = GP_PartyVoteRevealFormatIssue(issue, detailsStr, targetName)
local voteLine = GP_PARTY_VOTE_REVEAL_GREEN .. playerName .. GP_PARTY_VOTE_REVEAL_ORANGE .. " started vote: " .. issue
GP_PartyVoteRevealChat(voteLine)
return
end
if (type(VotePass) == "number" and id == VotePass) or (type(VoteFailed) == "number" and id == VoteFailed) then
msg:ReadByte()
local voteIdx = msg:ReadInt(32)
GP_PartyVoteRevealReportDidntVote(voteIdx)
GP_PartyVoteRevealClose(voteIdx)
return
end
end

function GP_HandlePartyAutoQueueGcSend(typeID, data)
local okResult = (E_GCResults and E_GCResults.k_EGCResultOK) or 0
local now = ((globals and globals.RealTime and globals.RealTime()) or GP_PartyNow())
local okTraceRaw, traceRaw = pcall(function() return data:Get() end)
local numericTypeID = tonumber(typeID) or 0
local manualTracePossible = okTraceRaw and type(traceRaw) == "string" and not (config and config.partyAutoQueueEnabled == true)
if manualTracePossible and numericTypeID == 6556 then
gpPartyManualQueueTraceUntil = math.max(gpPartyManualQueueTraceUntil or 0, now + 8.0)
GP_PartyFeatureLog("manual_queue_trace_auto_arm", "manual queue trace auto-armed for 8s after PartyQueueForMatch", 1.0)
end
if manualTracePossible then
local shouldTrace = (numericTypeID >= 6550 and numericTypeID <= 6565 and #traceRaw <= 1400)
or (now <= (gpPartyManualQueueTraceUntil or 0) and #traceRaw <= 1400)
or numericTypeID == 6556
or string.find(traceRaw, "mvm_", 1, true) ~= nil
or string.find(traceRaw, "advanced", 1, true) ~= nil
or string.find(traceRaw, "expert", 1, true) ~= nil
if shouldTrace and now >= (gpPartyManualQueueTraceLastAt or 0) then
gpPartyManualQueueTraceLastAt = now + 0.02
GP_PartyFeatureLog("manual_queue_trace_" .. tostring(typeID) .. "_" .. tostring(math.floor(now * 100)), "manual queue trace type=" .. tostring(typeID) .. " len=" .. tostring(#traceRaw) .. " hex=" .. GP_PartyHex(traceRaw, 360), 0)
end
if numericTypeID == 6554 or numericTypeID == 6556 then
local learned = GP_PartyAutoQueueLearnFromRaw(traceRaw, "manual_queue", numericTypeID)
if numericTypeID == 6556 and not learned and #traceRaw <= 32 then
GP_PartyFeatureLog("autoqueue_learn_empty", "manual queue had no embedded MannUp options to learn yet len=" .. tostring(#traceRaw), 2.0)
end
end
end
if numericTypeID ~= 6556 then return okResult end
if not (config and config.partyAutoQueueEnabled == true) then return okResult end
if now > (gpPartyAutoQueueGcArmUntil or 0) then
GP_PartyFeatureLog("autoqueue_gc_observe", "observed PartyQueueForMatch send; hook not armed", 2.0)
return okResult
end
GP_PartyFeatureLog("autoqueue_gc_seen", "GCSendMessage queue payload seen armed=true", 0)
local okRaw, raw = pcall(function() return data:Get() end)
if not okRaw or type(raw) ~= "string" or #raw < 26 then
GP_PartyFeatureLog("autoqueue_gc_badraw", "queue payload ignored: bad data ok=" .. tostring(okRaw) .. " len=" .. tostring(type(raw) == "string" and #raw or "nil"), 2.0)
return okResult
end
local fullPayload = GP_PartyAutoQueueLearnedRawPayload(raw)
local payloadMode = "learned_only_not_completed"
local body = raw
if type(raw) == "string" and #raw > 8 and string.byte(raw, 1) == 0x9C and string.byte(raw, 2) == 0x19 then
body = string.sub(raw, 9)
end
local partyID = GP_PartyGetFixed64Field(body, 1)
if not partyID or partyID <= 0 then
partyID = GP_PartyGetVarintField(body, 1)
end
local scanSummary = ""
if not partyID or partyID <= 0 then
partyID, scanSummary = GP_PartyFindLikelyPartyID(body)
end
if not fullPayload and partyID and partyID > 0 then
fullPayload = GP_PartyAutoQueueRawPayload(raw, partyID)
payloadMode = "tour_only_probe"
end
if not fullPayload then
GP_PartyFeatureLog("autoqueue_gc_noparty", "queue payload ignored: could not parse party id len=" .. tostring(#raw) .. " fields=" .. tostring(scanSummary) .. " hex=" .. GP_PartyHex(raw, 28), 0)
return okResult
end
local okSet = pcall(function() data:Set(fullPayload) end)
gpPartyAutoQueueGcArmUntil = 0
GP_PartyFeatureLog("autoqueue_gc_set", "queue payload replaced ok=" .. tostring(okSet) .. " party=" .. tostring(partyID or "embedded") .. " operation=" .. GP_PartyQueueOperationLabel() .. " mode=" .. tostring(payloadMode) .. " mannup=true rawlen=" .. tostring(type(fullPayload) == "string" and #fullPayload or "nil"), 0)
return okResult
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
if gpAutoCanteenHeld then
GP_PartyRun("-use_action_slot_item")
gpAutoCanteenHeld = false
end
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
client.AllowListener("player_teleported")
client.AllowListener("mvm_begin_wave")
client.AllowListener("mvm_wave_start")
end
end)
callbacks.Register("FireGameEvent", __GM_CALLBACK_IDS.fireGameEvent, function(e)
local ok, name = pcall(function() return e:GetName() end)
if ok and name then
GP_PartyRememberVoteFromEvent(name, e)
GP_HandleSmartVoteEvent(name, e)
GP_SmartVoteObserveVoteCast(name, e)
GP_HandleVoteRevealEvent(name, e)
GP_HandleAutoPartyInviteEvent(name, e)
GP_TP_HandleTeleportEvent(name, e)
local lname = string.lower(tostring(name))
if config and config.forceFixWaveStartEnabled == true and (lname == "mvm_begin_wave" or lname == "mvm_wave_start") then
local now = GP_PartyNow()
if (now - (gpForceFixWaveLastTrigger or 0)) >= 5.0 then
gpForceFixWaveLastTrigger = now
GP_PartyFixStart(now, "wave_start")
end
end
GP_HandlePartyKillFromEvent(name, e)
GP_AutoDisconnectOnEvent(name, e)
GP_RST_OnEvent(name, e)
end
end)
callbacks.Register("DispatchUserMessage", __GM_CALLBACK_IDS.dispatchUserMessage, function(msg)
GP_HandleVoteRevealUserMessage(msg)
end)
callbacks.Register("Draw", __GM_CALLBACK_IDS.draw, GP_Draw)
end
__GM_PART3__()

function __GM_PART4__()
callbacks.Register("CreateMove", __GM_CALLBACK_IDS.createMove, function(cmd)
local currentTime = globals.CurTime()
GP_HandleCurTimeRewind(currentTime)
GP_PartyFixTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_PartyRecTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_PartyVoteRetryTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
GP_SmartVoteTick(((globals and globals.RealTime and globals.RealTime()) or currentTime or 0))
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
GP_TryCaptureHotkey()
local me = entities.GetLocalPlayer()
GP_HandleInstantRespawn(me)
GP_HandleAutoCanteen(me)
GP_HandleAutoFocus(cmd, me)
GP_TP_HandleAimbotSuppression(currentTime)
GP_TP_TickUseVerify(me, currentTime)
GP_TP_TickManualDropAutoKill(me, currentTime)
GP_TP_TickDropAutoKill(me, currentTime)
GP_F4_Sync("tick", false)
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
elseif (config and config.tpWalkEnabled) and (cls == "sniper") then
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
AddNotification("Class switch to Sniper detected - TpWalk re-armed", "success")
end
if cls == "sniper"
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
if GP_TP_IsMoveLockActive() and IsManualMoveInput() then
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
if GP_KeyPressedBind(ALL_OFF_KEY) and (currentTime - lastToggleTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
local canRestore = (allOffRestoreSnapshot ~= nil) and ((allOffRestoreUntil or 0) >= currentTime)
if canRestore then
GP_RestoreActiveToggleSnapshot(allOffRestoreSnapshot, true)
allOffRestoreSnapshot = nil
allOffRestoreUntil = 0
else
allOffRestoreSnapshot = GP_CaptureActiveToggleSnapshot()
local hadAnyBefore = GP_SnapshotHasAnyActive(allOffRestoreSnapshot)
GP_DisableAllActiveToggles(false)
allOffRestoreUntil = currentTime + (ALL_OFF_RESTORE_WINDOW or 60.0)
if hadAnyBefore then
AddNotification("All active toggles disabled (Press again within 60s to restore previous toggles)", "info", 4.5)
else
AddNotification("No active toggles were active", "info", 4.5)
end
end
lastToggleTime = currentTime
end
if GP_KeyPressedBind(WALK_KEY) and (currentTime - lastToggleTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
if GP_SetAutoCreditEnabled((not config.autoWalkEnabled), true) then
lastToggleTime = currentTime
end
end
do
local autoDownNow = input.IsButtonDown(AUTO_KEY)
if autoDownNow and (not sniperHotkeyHoldDown) then
sniperHotkeyHoldDown = true
sniperHotkeyHoldStart = currentTime
sniperHotkeyHoldTriggered = false
sniperBlockShortToggleOnRelease = false
end
if sniperHotkeyHoldDown and autoDownNow and (not sniperHotkeyHoldTriggered) then
if (currentTime - (sniperHotkeyHoldStart or currentTime)) >= (SNIPER_FORCE_HOLD_SECONDS or 2.0)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
sniperHotkeyHoldTriggered = true
if GP_SetForceSniperBuyEnabled((not forceSniperBuyModeEnabled), true) then
sniperBlockShortToggleOnRelease = true
lastToggleTime = currentTime
end
end
end
if (not autoDownNow) and sniperHotkeyHoldDown then
local blockShortToggle = sniperBlockShortToggleOnRelease
or sniperSkipNextShortToggle
or (currentTime < (sniperIgnoreShortToggleUntil or 0))
if sniperBlockShortToggleOnRelease then
sniperBlockShortToggleOnRelease = false
end
if blockShortToggle then
sniperSkipNextShortToggle = false
end
if (not blockShortToggle)
and (not sniperHotkeyHoldTriggered)
and ((currentTime - (sniperHotkeyHoldStart or currentTime)) < (SNIPER_FORCE_HOLD_SECONDS or 2.0))
and (currentTime - lastToggleTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
if forceSniperBuyModeEnabled then
if GP_SetForceSniperBuyEnabled(false, true) then
lastToggleTime = currentTime
end
else
local nextEnabled = (not config.autoBuyEnabled)
config.autoBuyEnabled = nextEnabled
gpStickyAutoBuyEnabled = (config.autoBuyEnabled == true)
if config.autoBuyEnabled then
GP_EnableSniperBuyRuntime(((GP_TP_IsTraversalActive and GP_TP_IsTraversalActive()) and true or false))
AddNotification("SniperBuy Enabled - Reset state (Death/Respawn as Sniper activates it)", "warning", 4.0)
else
GP_DisableSniperBuyRuntime(GP_TP_IsTraversalActive())
AddNotification("SniperBuy Disabled", "info")
end
SaveConfig(GP_CfgPath(), config)
lastToggleTime = currentTime
end
end
sniperHotkeyHoldDown = false
sniperHotkeyHoldStart = 0
sniperHotkeyHoldTriggered = false
end
end
if GP_KeyPressedBind(CLEAN_KEY) and (currentTime - lastCleanupTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
AddNotification("Started cleanup", "info")
ForceCleanup()
lastCleanupTime = currentTime
cleanupFlashUntil = currentTime + 0.25
end
if GP_KeyPressedBind(TP_DROP_AUTOKILL_KEY) and (currentTime - lastToggleTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
config.tpDropAutoKillEnabled = not config.tpDropAutoKillEnabled
if not config.tpDropAutoKillEnabled then
GP_TP_ClearDropAutoKill()
GP_TP_ResetManualDropAutoKill()
end
SaveConfig(GP_CfgPath(), config)
AddNotification(config.tpDropAutoKillEnabled and "Tp Position Lost - Kill Enabled (kills if position is lost after teleport)" or "Tp Position Lost - Kill Disabled", "info")
lastToggleTime = currentTime
end
do
tpDownNow = input.IsButtonDown(TP_KEY)
if tpDownNow and (not tpHotkeyHoldDown) then
tpHotkeyHoldDown = true
tpHotkeyHoldStart = currentTime
tpHotkeyHoldTriggered = false
end
if tpHotkeyHoldDown and tpDownNow and (not tpHotkeyHoldTriggered) then
if (currentTime - (tpHotkeyHoldStart or currentTime)) >= (TP_FORCE_HOLD_SECONDS or 2.0)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
tpHotkeyHoldTriggered = true
if GP_SetTpForceEnabled((not tpForceModeEnabled), true) then
lastToggleTime = currentTime
end
end
end
if (not tpDownNow) and tpHotkeyHoldDown then
local holdDur = (currentTime - (tpHotkeyHoldStart or currentTime))
if tpHotkeyHoldTriggered then
tpSkipNextShortToggle = true
end
if (not tpHotkeyHoldTriggered)
and (holdDur < (TP_FORCE_HOLD_SECONDS or 2.0))
and (currentTime >= (tpIgnoreShortToggleUntil or 0))
and (not tpSkipNextShortToggle)
and (currentTime - lastToggleTime > TOGGLE_COOLDOWN)
and IsGameInputAllowed() and (currentTime >= suppressToggleUntil) and (not misc.waitKey) then
if tpForceModeEnabled then
GP_SetTpForceEnabled(false, true)
else
GP_SetTpWalkEnabled((not config.tpWalkEnabled), true)
end
lastToggleTime = currentTime
end
tpSkipNextShortToggle = false
tpHotkeyHoldDown = false
tpHotkeyHoldStart = 0
tpHotkeyHoldTriggered = false
end
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
if forceSniperBuyModeEnabled and (not sniperReloadAwaitRespawn) and me and me:IsAlive() and GP_IsSniper(me) and (not isExploiting) and (not (GP_RST_IsTransitionLockActive and GP_RST_IsTransitionLockActive())) then
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
AddNotification("SniperBuy run complete (this mission). Toggle SniperBuy OFF/ON to run again", "success")
autobuyDoneAnnounced = true
end
end
end
if config.autoBuyEnabled and (not forceSniperBuyModeEnabled) and (not sniperReloadAwaitRespawn) and (not autobuyRunOnceDone) and me and me:IsAlive() and GP_IsSniper(me) and (not isExploiting) and canAutoMoveNow and (not (GP_RST_IsTransitionLockActive and GP_RST_IsTransitionLockActive())) then
local inZone = me:GetPropInt('m_bInUpgradeZone') == 1
if inZone then
if shouldGuidePlayerBuy then
AddNotification("SniperBuy: reached upgrade station", "success")
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
local walkTimedOut = ((sniperBuyWalkStartTime or 0) > 0) and ((currentTime - (sniperBuyWalkStartTime or currentTime)) >= (SNIPER_BUY_WALK_TIMEOUT or 40.0))
local canKillNow = (currentTime >= (sniperBuyWalkKillCooldownUntil or 0))
if walkTimedOut and canKillNow then
AddNotification("SniperBuy: station not reached in 10s - suiciding reset", "warning")
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
AddNotification("SniperBuy: stopped (left spawn room)", "info")
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
if config.autoWalkEnabled and inZone_now and IsMedic(me) and hasVacc and (not isExploiting) then
TriggerMoneyExploit()
end
if isExploiting or isUpgradingSniper then
ProcessExploitQueue()
end
end
do
local aliveNow = me:IsAlive()
local classNow = GP_GetCurrentClassName(me)
local isSniperNow = (classNow == "sniper")
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
local sniperBuyPending = (curClsName == "sniper")
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
if allowTpWalkNow and GP_TP_IsArmedAndAllowed() and me and me:IsAlive() and canAutoMoveNow and GP_TP_IsToggleSpawnUnlocked(me) then
if GP_TP_IsMoveLockActive() and IsManualMoveInput() then
GP_TP_ApplyMovementLock(cmd)
end
if tpForceModeEnabled or GP_IsSniper(me) then
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
if isExploiting or isUpgradingSniper then
ProcessExploitQueue()
end
end)
callbacks.Register("Unload", __GM_CALLBACK_IDS.unload, function()
GP_TP_AimbotRestoreOnUnload()
if gpAutoCanteenHeld then
client.Command("-use_action_slot_item", true)
gpAutoCanteenHeld = false
end
ForceCleanup()
SaveConfig(GP_CfgPath(), config)
if GhostMoney and GhostMoney.Internal and GhostMoney.Internal.Shutdown then
pcall(GhostMoney.Internal.Shutdown, true)
end
end)
AddNotification("Loaded GhostMoney 1.3 by golden pan", "info")
if gpHadActiveTogglesOnLoad and entities.GetLocalPlayer() ~= nil and ((engine.GetMapName and engine.GetMapName()) or "") ~= "" then
AddNotification("Detected active toggles - some states reset", "warning", 5.0)
end
function GP_ResetUIToCenter()
local screenW, screenH = draw.GetScreenSize()
local width = 260
local height = 44
GP_SetUIPosition(math.floor((screenW - width) / 2), math.floor((screenH - height) / 2), true)
AddNotification("UI reset to center", "success")
end
function GP_ResetCfgToDefaults()
local defaults = {
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
tpDropAutoKillEnabled = false,
firstJoinPickMedic = false,
mvmReadyTpCycleEnabled = false,
instantRespawnEnabled = false,
autoCanteenEnabled = false,
tp_drop_key = KEY_B,
all_off_key = KEY_X,
watermarkX = 10,
watermarkY = 10,
moneyThreshold = 6500,
changeClassEnabled = false,
targetClass = ""
}
for k, _ in pairs(config) do
config[k] = nil
end
for k, v in pairs(defaults) do
config[k] = v
end
WALK_KEY = KEY_L
CLEAN_KEY = KEY_K
AUTO_KEY = KEY_J
TP_KEY = KEY_O
TP_DROP_AUTOKILL_KEY = KEY_B
ALL_OFF_KEY = KEY_X
config.tp_drop_key = KEY_B
config.all_off_key = KEY_X
tpForceModeEnabled = false
forceSniperBuyModeEnabled = false
gpPartyAutoQueueNextAt = 0
gpPartyAutoQueueGcArmUntil = 0
gpPartyAutoQueueWasQueued = false
gpPartyAutoQueueCooldownUntil = 0
gpPartyAutoQueuePendingUntil = 0
gpPartyManualQueueTraceUntil = 0
gpPartyAutoInviteLastAt = 0
gpPartyAutoInviteLastSteam64 = ""
gpPartyAutoInviteProbeReadAt = 0
gpPartyAutoInviteProbeUntil = 0
gpPartyAutoInviteProbeCooldownUntil = 0
gpPartyAutoAcceptStatusAt = 0
gpPartyFeatureLastLog = {}
gpVoteRevealSeenCast = {}
gpVoteRevealStarter = {}
gpVoteRevealTarget = {}
gpVoteRevealTargetName = {}
gpVoteRevealClosedUntil = {}
gpVoteRevealPendingCasts = {}
gpVoteRevealReportedMissing = {}
gpSniperBuyLoadRearmPending = false
gpHadSniperBuyActiveOnLoad = false
gpStickyAutoBuyEnabled = false
gpStickyForceSniperBuyEnabled = false
gpAutoCanteenHeld = false
if GP_SetUIPosition then
GP_SetUIPosition(config.watermarkX, config.watermarkY, false)
end
allOffRestoreSnapshot = nil
allOffRestoreUntil = 0
if HardReset then
pcall(HardReset, "Config reset")
else
if ForceCleanup then pcall(ForceCleanup) end
if ResetRuntimeState then pcall(ResetRuntimeState, "Config reset") end
end
SaveConfig(GP_CfgPath(), config)
GP_F4_OnFeatureToggle(config.mvmReadyTpCycleEnabled == true)
AddNotification("Config reset to defaults", "success")
end
function GP_UIResetCmd(cmd)
local raw = cmd:Get()
if not raw then return end
local args = {}
for w in string.gmatch(raw:lower(), "%S+") do
table.insert(args, w)
end
if args[1] == "gp_gm_ui_reset" then
GP_ResetUIToCenter()
cmd:Set("")
return false
elseif args[1] == "gp_gm_cfg_reset" then
GP_ResetCfgToDefaults()
cmd:Set("")
return false
end
end
callbacks.Register("SendStringCmd", __GM_CALLBACK_IDS.uiResetCommand, GP_UIResetCmd)

do
GhostMoney.Modules = GhostMoney.Modules or {}

function __GM_bind(bucket, alias, gname)
GhostMoney.Modules[bucket] = GhostMoney.Modules[bucket] or {}
local fn = _G[gname]
if type(fn) == "function" then
GhostMoney.Modules[bucket][alias] = fn
end
end

__GM_bind("UI", "AddNotification", "AddNotification")
__GM_bind("Core", "GP_ArmReloadMoveLock", "GP_ArmReloadMoveLock")
__GM_bind("Core", "GP_CaptureActiveToggleSnapshot", "GP_CaptureActiveToggleSnapshot")
__GM_bind("Core", "GP_CheckSniperUpgradeDone", "GP_CheckSniperUpgradeDone")
__GM_bind("Core", "GP_DisableAllActiveToggles", "GP_DisableAllActiveToggles")
__GM_bind("UI", "DrawRightClickMenu", "GP_DrawRightClickMenu")
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
__GM_bind("UI", "MiscCloseMenuState", "GP_MiscCloseMenuState")
__GM_bind("UI", "MiscComputePanels", "GP_MiscComputePanels")
__GM_bind("UI", "MiscIsMouseOver", "GP_MiscIsMouseOver")
__GM_bind("UI", "MiscResetKeyBindState", "GP_MiscResetKeyBindState")
__GM_bind("UI", "MiscSubItemCount", "GP_MiscSubItemCount")
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
__GM_bind("Config", "ResetCfgToDefaults", "GP_ResetCfgToDefaults")
__GM_bind("Config", "ResetUIToCenter", "GP_ResetUIToCenter")
__GM_bind("Core", "GP_RestoreActiveToggleSnapshot", "GP_RestoreActiveToggleSnapshot")
__GM_bind("Core", "GP_SafeCall", "GP_SafeCall")
__GM_bind("Toggles", "SetAutoCreditEnabled", "GP_SetAutoCreditEnabled")
__GM_bind("Toggles", "SetForceSniperBuyEnabled", "GP_SetForceSniperBuyEnabled")
__GM_bind("Toggles", "SetTpForceEnabled", "GP_SetTpForceEnabled")
__GM_bind("Toggles", "SetTpWalkEnabled", "GP_SetTpWalkEnabled")
__GM_bind("Core", "GP_ShouldAllowPostWaveStationSwapWithoutThreshold", "GP_ShouldAllowPostWaveStationSwapWithoutThreshold")
__GM_bind("Core", "GP_SnapshotHasAnyActive", "GP_SnapshotHasAnyActive")
__GM_bind("TP", "ApplyMovementLock", "GP_TP_ApplyMovementLock")
__GM_bind("TP", "ArmSpawnToggleLock", "GP_TP_ArmSpawnToggleLock")
__GM_bind("TP", "BuildTargetId", "GP_TP_BuildTargetId")
__GM_bind("TP", "CheckAndHandleStuck", "GP_TP_CheckAndHandleStuck")
__GM_bind("TP", "CheckAndHandleWaypointStuck", "GP_TP_CheckAndHandleWaypointStuck")
__GM_bind("TP", "HandleWaitingPopups", "GP_TP_HandleWaitingPopups")
__GM_bind("TP", "IsMoveLockActive", "GP_TP_IsMoveLockActive")
__GM_bind("TP", "IsSetupPhase", "GP_TP_IsSetupPhase")
__GM_bind("TP", "IsSpawnContextNow", "GP_TP_IsSpawnContextNow")
__GM_bind("TP", "IsToggleSpawnUnlocked", "GP_TP_IsToggleSpawnUnlocked")
__GM_bind("TP", "ResetPathState", "GP_TP_ResetPathState")
__GM_bind("TP", "ResetStuckTracker", "GP_TP_ResetStuckTracker")
__GM_bind("TP", "StartUseVerify", "GP_TP_StartUseVerify")
__GM_bind("TP", "StopUseVerify", "GP_TP_StopUseVerify")
__GM_bind("TP", "TickManualDropAutoKill", "GP_TP_TickManualDropAutoKill")
__GM_bind("TP", "TickUseVerify", "GP_TP_TickUseVerify")
__GM_bind("TP", "WalkFallbackPath", "GP_TP_WalkFallbackPath")
__GM_bind("Query", "TryGetEventString", "GP_TryGetEventString")
__GM_bind("Query", "TryPropInt", "GP_TryPropInt")
__GM_bind("UI", "UIResetCmd", "GP_UIResetCmd")
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

do
pcall(function()
if config and config.hideInfoOnLoad == true and tostring(config.infoLoadSeenVersion or "") ~= tostring(GP_INFO_LOAD_VERSION) then
config.hideInfoOnLoad = false
if SaveConfig and GP_CfgPath then SaveConfig(GP_CfgPath(), config) end
end
end)
GP_ShowLoadInfoPopup()
GP_ShowChangelogPopup()
end
