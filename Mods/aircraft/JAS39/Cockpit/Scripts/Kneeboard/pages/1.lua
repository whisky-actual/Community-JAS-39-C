dofile(LockOn_Options.common_script_path.."Kneeboard/indicator/definitions.lua")
SetScale(FOV)

-- Insert new pages as needed.
-- Prioritize experienced users who want to get information they need quickly.

-- Catalogue other page information and numeration here and assign your page an integer filename.
-- Use integers 2-9 sparingly, as they will cause file namesort issues.

-- ================================
-- 0x - INTRODUCTION
-- ================================
-- 1 - Cover / Credits (this file)

-- ================================
-- 1x - MISSION INFORMATION
-- ================================
-- 11 - Navigation Log
-- 12 - Radio Presets
-- 12 - ILS Data

-- ================================
-- 2x - WEAPONS
-- ================================
-- 21 - A/A
-- 22 - A/G

-- ================================
-- 3x - FLIGHT CREW CHECKLISTS
-- ================================
-- 31 - Before Engine Start
-- 32 - Engine Starting - Before Taxiing - Before Take-Off
-- 33 - Take-Off - Landing
-- 34 - On Ramp

-- add background image for kneeboard
add_picture(LockOn_Options.script_path.."../Textures/Kneeboard/cover.png")
