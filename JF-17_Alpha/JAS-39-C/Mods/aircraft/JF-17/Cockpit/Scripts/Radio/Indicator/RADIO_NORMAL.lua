dofile(LockOn_Options.script_path.."Radio/Indicator/Radio_defs.lua")

local pos_x  = (502-254)/256
local pos_y1 = (256-177)/256
local pos_y2 = -(290-256)/256
local edit_bias = -(492-226)/256

text_strpoly              = CreateElement "ceStringPoly"
text_strpoly.name         = "radio_disp_l1"
text_strpoly.material     = RADIO_LCD_FONT
text_strpoly.stringdefs   = RADIO_STRINGDEFS_DEF
text_strpoly.init_pos     = {pos_x, pos_y1, 0}
text_strpoly.alignment    = "RightCenter"
text_strpoly.formats      = {"%s"}
text_strpoly.value        = "C124.000"
text_strpoly.controllers  = {{"radio_disp_line1", edit_bias},}
AddElementObject(text_strpoly)
text_strpoly = nil

text_strpoly              = CreateElement "ceStringPoly"
text_strpoly.name         = "radio_disp_l2"
text_strpoly.material     = RADIO_LCD_FONT
text_strpoly.stringdefs   = RADIO_STRINGDEFS_DEF
text_strpoly.init_pos     = {pos_x, pos_y2, 0}
text_strpoly.alignment    = "RightCenter"
text_strpoly.formats      = {"%s"}
text_strpoly.value        = "S1S2    "
text_strpoly.controllers  = {{"radio_disp_line2"},}
AddElementObject(text_strpoly)
text_strpoly = nil

text_strpoly              = CreateElement "ceStringPoly"
text_strpoly.material     = RADIO_LCD_FONT
text_strpoly.stringdefs   = RADIO_STRINGDEFS_DEF
text_strpoly.init_pos     = {pos_x, pos_y1, 0}
text_strpoly.alignment    = "RightCenter"
text_strpoly.formats      = {"%s"}
text_strpoly.value        = "C       "
text_strpoly.controllers  = {{"radio_disp_line1_edit"},}
AddElementObject(text_strpoly)
text_strpoly = nil

-- 光标
local cur_poly
cur_poly                = CreateElement "ceStringPoly"
cur_poly.material       = RADIO_LCD_FONT
cur_poly.stringdefs     = RADIO_STRINGDEFS_DEF
cur_poly.name           = "radio_cursor"
cur_poly.alignment      = "RightCenter"
cur_poly.parent_element = "radio_disp_l1"
cur_poly.init_pos       = {0, 0, 0}
cur_poly.value          = "\126"
cur_poly.controllers    = {{"radio_cur", 0},}
AddStringObject(cur_poly)
cur_poly = nil


local state_indicator_vert = {{ (396-372)/256,  (372-360)/256},
                              { (396-372)/256, -(372-360)/256},
                              {-(396-372)/256, -(372-360)/256},
                              {-(396-372)/256,  (372-360)/256}}

-- TAKE
local take_poly
take_poly                = CreateElement "ceMeshPoly"
take_poly.material       = RADIO_MATERIAL_Y
take_poly.name           = "radio_take"
take_poly.primitivetype  = "triangles"
take_poly.vertices       = state_indicator_vert
take_poly.indices        = DEF_BOX_INDICES
take_poly.init_pos       = {0, -(370-256)/256, 0}
take_poly.controllers    = {{"radio_state_take"},}
AddStringObject(take_poly)
take_poly = nil

-- SQL
local sql_poly
sql_poly                = CreateElement "ceMeshPoly"
sql_poly.material       = RADIO_MATERIAL_R
sql_poly.name           = "radio_sql"
sql_poly.primitivetype  = "triangles"
sql_poly.vertices       = state_indicator_vert
sql_poly.indices        = DEF_BOX_INDICES
sql_poly.init_pos       = {(46-256)/256, -(370-256)/256, 0}
sql_poly.controllers    = {{"radio_state_sql"},}
AddStringObject(sql_poly)
sql_poly = nil

-- OR
local or_poly
or_poly                = CreateElement "ceMeshPoly"
or_poly.material       = RADIO_MATERIAL_Y
or_poly.name           = "radio_or"
or_poly.primitivetype  = "triangles"
or_poly.vertices       = state_indicator_vert
or_poly.indices        = DEF_BOX_INDICES
or_poly.init_pos       = {(152-256)/256, -(370-256)/256, 0}
or_poly.controllers    = {{"radio_state_or"},}
AddStringObject(or_poly)
or_poly = nil

-- GO
local go_poly
go_poly                = CreateElement "ceMeshPoly"
go_poly.material       = RADIO_MATERIAL_Y
go_poly.name           = "radio_go"
go_poly.primitivetype  = "triangles"
go_poly.vertices       = state_indicator_vert
go_poly.indices        = DEF_BOX_INDICES
go_poly.init_pos       = {(362-256)/256, -(370-256)/256, 0}
go_poly.controllers    = {{"radio_state_go"},}
AddStringObject(go_poly)
go_poly = nil

-- TX
local tx_poly
tx_poly                = CreateElement "ceMeshPoly"
tx_poly.material       = RADIO_MATERIAL_Y
tx_poly.name           = "radio_tx"
tx_poly.primitivetype  = "triangles"
tx_poly.vertices       = state_indicator_vert
tx_poly.indices        = DEF_BOX_INDICES
tx_poly.init_pos       = {(466-256)/256, -(370-256)/256, 0}
tx_poly.controllers    = {{"radio_state_tx"},}
AddStringObject(tx_poly)
tx_poly = nil

