---@meta hs.caffeinate
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Control system power states (sleeping, preventing sleep, screen locking, etc)
--
-- **NOTE**: Any sleep preventions will be removed when hs.reload() is called. A future version of the module will save/restore state across reloads.
---@class hs.caffeinate
local M = {}
hs.caffeinate = M

-- Fetches information about processes which are currently asserting display/power sleep restrictions
--
-- Parameters:
--  * None
--
-- Returns:
--  * A table containing information about current power assertions, with process IDs (PID) as the keys, each of which may contain multiple assertions
function M.currentAssertions() end
-- Informs the OS that the user performed some activity
--
-- Parameters:
--  * id - An option number containing the assertion ID returned by a previous call of this function
--
-- Returns:
--  * A number containing the ID of the assertion generated by this function
--
-- Notes:
--  * This is intended to simulate user activity, for example to prevent displays from sleeping, or to wake them up
--  * It is not mandatory to re-use assertion IDs if you are calling this function multiple times, but it is recommended that you do so if the calls are related
function M.declareUserActivity(id) end
-- Show the Fast User Switch screen (ie a login screen without logging out first)
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.fastUserSwitch() end
-- Queries whether a particular sleep type is being prevented
--
-- Parameters:
--  * sleepType - A string containing the type of sleep to inspect (see [hs.caffeinate.set()](#set) for information about the possible values)
--
-- Returns:
--  * True if the specified type of sleep is being prevented, false if not. nil if sleepType was an invalid value
function M.get(sleepType, ...) end
-- Locks the displays
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * This function uses private Apple APIs and could therefore stop working in any given release of macOS without warning.
function M.lockScreen() end
-- Request the system log out the current user
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.logOut() end
-- Request the system reboot
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.restartSystem() end
-- Fetches information from the display server about the current session
--
-- Parameters:
--  * None
--
-- Returns:
--  * A table containing information about the current session, or nil if an error occurred
--
-- Notes:
--  * The keys in this dictionary will vary based on the current state of the system (e.g. local vs VNC login, screen locked vs unlocked).
function M.sessionProperties() end
-- Configures the sleep prevention settings
--
-- Parameters:
--  * sleepType - A string containing the type of sleep to be configured. The value should be one of:
--   * displayIdle - Controls whether the screen will be allowed to sleep (and also the system) if the user is idle.
--   * systemIdle - Controls whether the system will be allowed to sleep if the user is idle (display may still sleep).
--   * system - Controls whether the system will be allowed to sleep for any reason.
--  * aValue - A boolean, true if the specified type of sleep should be prevented, false if it should be allowed
--  * acAndBattery - A boolean, true if the sleep prevention should apply to both AC power and battery power, false if it should only apply to AC power.
--
-- Returns:
--  * None
--
-- Notes:
--  * These calls are not guaranteed to prevent the system sleep behaviours described above. The OS may override them if it feels it must (e.g. if your CPU temperature becomes dangerously high).
--  * The acAndBattery argument only applies to the `system` sleep type.
--  * You can toggle the acAndBattery state by calling `hs.caffeinate.set()` again and altering the acAndBattery value.
--  * The acAndBattery option does not appear to work anymore - it is based on private API that is not allowed in macOS 10.15 when running with the Hardened Runtime (which Hammerspoon now uses).
function M.set(sleepType, aValue, acAndBattery, ...) end
-- Request the system log out and power down
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.shutdownSystem() end
-- Request the system start the screensaver (which may lock the screen if the OS is configured to do so)
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.startScreensaver() end
-- Requests the system to sleep immediately
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.systemSleep() end
-- Toggles the current state of the specified type of sleep
--
-- Parameters:
--  * sleepType - A string containing the type of sleep to toggle (see [hs.caffeinate.set()](#set) for information about the possible values)
--
-- Returns:
--  * True if the specified type of sleep is being prevented, false if not. nil if sleepType was an invalid value
--
-- Notes:
--  * If systemIdle is toggled to on, it will apply to AC only
function M.toggle(sleepType, ...) end


return M
