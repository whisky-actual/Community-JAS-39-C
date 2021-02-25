dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "materials.lua")

SetScale(FOV)

--MFCD_HDG_SCALE = 0.7/275
--MFCD_HDG_DISPL = (3448 * MFCD_HDG_SCALE / 480) * GetScale()

MFCD_DEFAULT_LEVEL = 9

PAGE_LEVEL_BASE         = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_OFF          = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_NOAUX        = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_MAIN_MENU    = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_EDIT         = MFCD_DEFAULT_LEVEL

PAGE_LEVEL_BIT          = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_CHKLS        = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_PFL          = MFCD_DEFAULT_LEVEL

PAGE_LEVEL_HSD          = MFCD_DEFAULT_LEVEL + 6
PAGE_LEVEL_EFIS         = MFCD_DEFAULT_LEVEL + 12
PAGE_LEVEL_INS          = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_TACAN        = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_APR          = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_CLINK        = MFCD_DEFAULT_LEVEL

PAGE_LEVEL_SMS          = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_CMBT         = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_RDR          = MFCD_DEFAULT_LEVEL + 18
PAGE_LEVEL_POD          = MFCD_DEFAULT_LEVEL + 24

PAGE_LEVEL_DATA         = MFCD_DEFAULT_LEVEL + 30

PAGE_LEVEL_DOWN_OFF         = MFCD_DEFAULT_LEVEL
PAGE_LEVEL_DOWN_BLANK       = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_MAIN_MENU   = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_EPI1        = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_EPI2        = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_SMS         = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_AFD         = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_CLINK       = PAGE_LEVEL_DOWN_OFF
PAGE_LEVEL_DOWN_AG_PARAM    = PAGE_LEVEL_DOWN_OFF


IndTexture_Path    = IND_TEX_PATH

MFCD_COLOR_DEF     = materials["MFCD_IND_DEF"] --{128,255,0,255}
MFCD_COLOR_RED     = materials["MFCD_IND_RED"]
MFCD_COLOR_GREEN   = materials["MFCD_IND_GREEN"]
MFCD_COLOR_DGREEN  = materials["MFCD_IND_DGREEN"] -- {3,67,40,15}
MFCD_COLOR_BLUE    = materials["MFCD_IND_BLUE"]
MFCD_COLOR_BLUE_L  = materials["MFCD_IND_BLUE_L"]
MFCD_COLOR_BLACK   = materials["MFCD_IND_BLACK"]
MFCD_COLOR_DARK    = materials["MFCD_IND_DARK"]
MFCD_COLOR_WHITE   = materials["MFCD_IND_WHITE"]
MFCD_COLOR_WHITE_Y = materials["MFCD_IND_WHITE_Y"]
MFCD_COLOR_PINK    = materials["MFCD_IND_PINK"]
MFCD_COLOR_YELLOW  = materials["MFCD_IND_YELLOW"]
MFCD_COLOR_SKY     = materials["MFCD_IND_SKY"]
MFCD_COLOR_GRND    = materials["MFCD_IND_GRND"]
MFCD_COLOR_BOXBASE = materials["MFCD_IND_BOXBASE"]
MFCD_COLOR_W_BASE  = materials["MFCD_IND_W_BASE"]

MFCD_LINE_DEF      = "mfcd_line_dashed_def"
MFCD_LINE_RED      = "mfcd_line_dashed_r"
MFCD_LINE_WHITE    = "mfcd_line_dashed_w"
MFCD_LINE_YELLOW   = "mfcd_line_dashed_y"

MFCD_MATERIAL_DEF     = "mfcd_mesh_def"
MFCD_MATERIAL_RED     = "mfcd_mesh_r"
MFCD_MATERIAL_GREEN   = "mfcd_mesh_g"
MFCD_MATERIAL_BLUE    = "mfcd_mesh_b"
MFCD_MATERIAL_BLUE_L  = "mfcd_mesh_bl"
MFCD_MATERIAL_BLACK   = "mfcd_mesh_bk"
MFCD_MATERIAL_DARK    = "mfcd_mesh_d"
MFCD_MATERIAL_WHITE   = "mfcd_mesh_w"
MFCD_MATERIAL_WHITE_Y = "mfcd_mesh_wy"
MFCD_MATERIAL_PINK    = "mfcd_mesh_p"
MFCD_MATERIAL_YELLOW  = "mfcd_mesh_y"
MFCD_MATERIAL_SKY     = "mfcd_mesh_sky"
MFCD_MATERIAL_GRND    = "mfcd_mesh_gnd"
MFCD_MATERIAL_BOXBASE = "mfcd_mesh_boxbase"
MFCD_MATERIAL_W_BASE  = "mfcd_mesh_whitebase"


MFCD_FONT_DEF    = "mfcd_font_def"
MFCD_FONT_R      = "mfcd_font_r"
MFCD_FONT_G      = "mfcd_font_g"
MFCD_FONT_DG     = "mfcd_font_dg"
MFCD_FONT_B      = "mfcd_font_b"
MFCD_FONT_W      = "mfcd_font_w"
MFCD_FONT_WY     = "mfcd_font_wy"
MFCD_FONT_D      = "mfcd_font_d"


MFCD_WPN_FONT_DEF    = "mfcd_wpn_font_def"
MFCD_WPN_FONT_R      = "mfcd_wpn_font_r"
MFCD_WPN_FONT_G      = "mfcd_wpn_font_g"
MFCD_WPN_FONT_DG     = "mfcd_wpn_font_dg"
MFCD_WPN_FONT_B      = "mfcd_wpn_font_b"
MFCD_WPN_FONT_W      = "mfcd_wpn_font_w"
MFCD_WPN_FONT_WY     = "mfcd_wpn_font_wy"
MFCD_WPN_FONT_D      = "mfcd_wpn_font_d"

FONT_SCALE = MFCD_Y_PIXEL/MFCD_X_PIXEL
FONT_SIZE  = 0.005

FONT_W = FONT_SIZE * 144 / 128
FONT_H = FONT_W * FONT_SCALE

H2W_SCALE = GetAspect()

--[[ Caution Start: must sync with ccMFCD.h ]]
UP_CX = 0
UP_CY = 1.0 - 4.1/8

LOW_CX = 0
LOW_CY = H2W_SCALE * (-10/16)
--[[ Caution End ]]

------[[ 标签坐标 ]]------

MFCD_BOX3_L_VERT_X = -943.332/1000
MFCD_BOX3_R_VERT_X =  956.668/1000
MFCD_BOX3_L_HORI_X = -906.665/1000
MFCD_BOX3_R_HORI_X =  920.001/1000
MFCD_BOX4_L_HORI_X = -888.332/1000
MFCD_BOX4_R_HORI_X =  901.668/1000

-- 左右不同标签方向
MFCD_FONT_L_VERT_X = -961.665/1000 -- -0.94 -- 标签竖写 LeftCenter
MFCD_FONT_R_VERT_X =  975.000/1000 -- -MFCD_FONT_L_VERT_X -- 标签竖写 RightCenter
MFCD_FONT_L_HORI_X = -961.665/1000 -- -0.97 -- 标签横写 LeftCenter
MFCD_FONT_R_HORI_X =  975.000/1000 -- -MFCD_FONT_L_HORI_X -- 标签横写 RightCenter

-- 所有标签都是上下中心对称，所以对于左右的Y，给统一的
MFCD_FONT_LR1_Y = 2.0*0.80/2.5
MFCD_FONT_LR2_Y = 1.0*0.80/2.5
MFCD_FONT_LR3_Y = 0
MFCD_FONT_LR4_Y = -1.0*0.80/2.5
MFCD_FONT_LR5_Y = -2.0*0.80/2.5

MFCD_FONT_LR6_Y = 2.0*0.40/2.5
MFCD_FONT_LR7_Y = 0
MFCD_FONT_LR8_Y = -2.0*0.40/2.5

MFCD_FONT_U_Y = 0.8 -- XXXCenter
MFCD_FONT_D_Y = -0.96*H2W_SCALE -- XXXCenter

MFCD_FONT_UD1_X = -0.8
MFCD_FONT_UD2_X = -0.4
MFCD_FONT_UD3_X = 0
MFCD_FONT_UD4_X = 0.4
MFCD_FONT_UD5_X = 0.8

------[[ 标签坐标 ]]------

local t_scale = 1

-- 字体高宽 1:1        {    高,      宽,  字间,  行间,  水平偏,  垂直偏}
MFCD_STRINGDEFS_ORIG = {FONT_W, FONT_W,    0,     0,      0,     0}

MFCD_STRINGDEFS_DEF  = {0.80 * FONT_W, 0.80 * FONT_W, 0, 0}

-- 大号字, 用作标题
MFCD_STRINGDEFS_DEF_X04  = {t_scale*0.40*FONT_W, 0.40*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X05  = {t_scale*0.50*FONT_W, 0.50*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X06  = {t_scale*0.60*FONT_W, 0.60*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X07  = {t_scale*0.70*FONT_W, 0.70*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X075 = {t_scale*0.75*FONT_W, 0.75*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X08  = {t_scale*0.80*FONT_W, 0.80*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X09  = {t_scale*0.90*FONT_W, 0.90*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X1   = {t_scale*1.00*FONT_W, 1.00*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X15  = {t_scale*1.50*FONT_W, 1.50*FONT_W, 0, 0}
MFCD_STRINGDEFS_DEF_X2   = {t_scale*2.00*FONT_W, 2.00*FONT_W, 0, 0}

DEF_BOX_INDICES = { 0,1,2, 0,2,3 }

--------------------------

SA_CONTACT_NUM_SHARED = 40


--------- functions ----------

function AddElementObject(object)
    if (object.name == nil) or (string.len(object.name) < 1) then
        object.name            = create_guid_string()
    end
    if (type(object.stringdefs) ~= "table") or (next(object.stringdefs) == nil) then
        object.stringdefs      = MFCD_STRINGDEFS_DEF
    end
    if (object.h_clip_relation == nil) then
        object.h_clip_relation = h_clip_relations.COMPARE
    end
    
    if (object.level == nil) or (object.level < MFCD_DEFAULT_LEVEL) then
        object.level        = MFCD_DEFAULT_LEVEL
    end
    object.use_mipfilter    = true
    object.additive_alpha   = true
    object.collimated       = false
    Add(object)
end

-- must set level before calling 
function AddElementObject2(object)
    if object.name == nil or string.len(object.name) < 1 then
        object.name        = create_guid_string()
    end
    if type(object.stringdefs) ~= "table" or next(object.stringdefs) == nil then
        object.stringdefs        = MFCD_STRINGDEFS_DEF
    end
    if object.h_clip_relation == nil then
        object.h_clip_relation   = h_clip_relations.COMPARE
    end
    Add(object)
end

function AddStringObject(object, scale)
    if not scale or scale <= 0 then
        scale = 1
    end
    
    object.name              = create_guid_string()
    object.h_clip_relation   = object.h_clip_relation or h_clip_relations.COMPARE
    object.level             = object.level or MFCD_DEFAULT_LEVEL
    if type(object.stringdefs) ~= "table" or next(object.stringdefs) == nil then
        object.stringdefs    = MFCD_STRINGDEFS_DEF
    end
    Add(object)
end

-------------------------------------
local upper_base            = CreateElement "ceSimple"
upper_base.name             = "UPPER_BASE"
upper_base.h_clip_relation  = h_clip_relations.COMPARE
upper_base.level            = MFCD_DEFAULT_LEVEL
upper_base.isdraw           = true
upper_base.isvisible        = false
upper_base.init_pos         = {UP_CX, UP_CY}
upper_base.controllers      = {{"check_display"}, --[[{"apply_contrast"}]]}
Add(upper_base)

local low_base              = CreateElement "ceSimple"
low_base.name               = "LOWER_BASE"
low_base.h_clip_relation    = h_clip_relations.COMPARE
low_base.level              = MFCD_DEFAULT_LEVEL
low_base.isdraw             = true
low_base.isvisible          = false
low_base.init_pos           = {LOW_CX, LOW_CY}
low_base.controllers        = {{"check_display"}, --[[{"apply_contrast"}]]}
Add(low_base)

-- add elem to Upper win
function AddToUpper(elem)
    if (elem.parent_element == nil) or (string.len(elem.parent_element) < 1) then
        elem.parent_element  = "UPPER_BASE"
    end
    
    AddElementObject(elem)
    return elem
end
-- add elem to Lower win
function AddToLOWER(elem)
    if (elem.parent_element == nil) or (string.len(elem.parent_element) < 1) then
        elem.parent_element  = "LOWER_BASE"
    end
    
    AddElementObject(elem)
    return elem
end

-------------------------------------------------
function SetMeshCircle(object, radius, numpts)

    local verts = {}
    local inds = {}

    step = math.rad(360.0/numpts)
    for i = 1, numpts do
        verts[i] = {radius * math.cos(i * step), radius * math.sin(i * step)}
    end
    j = 0
    for i = 0, numpts-3 do
        j = j + 1
        inds[j] = 0
        j = j + 1
        inds[j] = i + 1
        j = j + 1
        inds[j] = i + 2
    end

    object.vertices = verts
    object.indices  = inds

end

function SetLineCircle(object, radius, numpts)

    local verts = {}
    local inds = {}

    step = math.rad(360.0/numpts)
    j=0
    for i = 1, numpts+1 do
        verts[i] = {radius * math.cos((i-1) * step), radius * math.sin((i-1) * step)}

        j = j + 1
        inds[j] = i-1
        j = j + 1
        inds[j] = i
    end
    inds[j] = 0
    
    object.vertices = verts
    object.indices  = inds

end

function SetMeshCircleClippedV(object, radius, numpts)

    local verts = {}
    local inds = {}

    -- 强制 numpts=36，然后从右边第4个点的位置垂直一刀，左边对称
    numpts = 36    
    step = math.rad(360.0/numpts)
    
    for i = 1, numpts do
        k = i
        if i < 3 or i > 33 then
            k = 3
        elseif i > 15 and i < 21 then
            k = 15
        end
        x = radius * math.cos(k * step)
        y = radius * math.sin(i * step)
        
        verts[i] = {x, y}
    end
    j = 0
    for i = 0, numpts-3 do
        j = j + 1
        inds[j] = 0
        j = j + 1
        inds[j] = i + 1
        j = j + 1
        inds[j] = i + 2
    end

    object.vertices = verts
    object.indices  = inds
    
end

function SetLineCircleClippedV(object, radius, numpts)

    local verts = {}
    local inds = {}

    -- 强制 numpts=36，然后从右边第4个点的位置垂直一刀，左边对称
    numpts = 36    
    step = math.rad(360.0/numpts)
    
    j=0
    for i = 1, numpts+1 do
        k = i
        if i < 4 or i > 34 then
            k = 4
        elseif i > 16 and i < 22 then
            k = 16
        end
        verts[i] = {radius * math.cos((k-1) * step), radius * math.sin((i-1) * step)}

        j = j + 1
        inds[j] = i-1
        j = j + 1
        inds[j] = i
    end
    inds[j] = 0

    object.vertices = verts
    object.indices  = inds
end

--function SetFrameCircleClippedV(obj, radius_outer, radius_inner, iarc, iclipped)
function SetCircleMesh(obj, radius_outer, radius_inner, iarc, iclipped)
    local verts    = {}
    local inds     = {}
    local solid    = radius_inner == nil or radius_inner == 0
    local arc      = iarc or 360
    local count    = 36
    local delta    = math.rad(arc/count)
    local clipped  = iclipped or false
    
    if arc > 360 or arc < 0 then
        arc = 360
    end

    local min_i    = 1
    local max_i    = count + 1
    verts[1] = {0,0}
    for i=min_i,max_i do
        k = i
        
        ---- for ADI clipped ball shape
        -- clip nodes are 3 from each side
        if clipped then
            if i < 4 or i > 34 then -- equal to 3, 33
                k = 4
            elseif i > 16 and i < 22 then -- equal to 15, 21
                k = 16
            end
        end
        
        if solid then
            verts[1 + i]      = { radius_outer * math.cos(delta *(k-1)), radius_outer * math.sin(delta *(k-1)), }
            inds[3*(i-1) + 1] = 0
            inds[3*(i-1) + 2] = i - 1 
            inds[3*(i-1) + 3] = i 
        else
            verts[2*(i - 1) + 1] = { radius_outer * math.cos(delta *(k-1)), radius_outer * math.sin(delta *(k-1)), }
            verts[2*(i - 1) + 2] = { radius_inner * math.cos(delta *(k-1)), radius_inner * math.sin(delta *(k-1)), }
            
            if i == max_i  then
              if arc == 360 then  
                inds[6*(i-1) + 1] = 2*(i     - 1)
                inds[6*(i-1) + 2] = 2*(min_i - 1)
                inds[6*(i-1) + 3] = 2*(i     - 1) + 1 
                inds[6*(i-1) + 4] = 2*(i     - 1) + 1
                inds[6*(i-1) + 5] = 2*(min_i - 1)
                inds[6*(i-1) + 6] = 2*(min_i - 1) + 1 
              end        
            else 
                inds[6*(i-1) + 1] = 2*(i - 1)
                inds[6*(i-1) + 2] = 2*(i) 
                inds[6*(i-1) + 3] = 2*(i - 1) + 1 
                inds[6*(i-1) + 4] = 2*(i - 1) + 1
                inds[6*(i-1) + 5] = 2*(i) 
                inds[6*(i-1) + 6] = 2*(i)     + 1  
            end
        end
    end
    obj.vertices = verts              
    obj.indices  = inds
end


function MFCD_tex_coord (UL_X,UL_Y,W,H,SZX,SZY)
    local ux = UL_X / SZX
    local uy = UL_Y / SZY
    local w  = W / SZX
    local h  = H / SZY
    return {{ux + w ,uy},
            {ux + w ,uy + h},
            {ux     ,uy + h},
            {ux     ,uy}}
end

function create_page_root()
    local page_root = CreateElement "ceSimple"
    page_root.name            = create_guid_string()
    page_root.material        = MFCD_MATERIAL_DEF
    page_root.init_pos        = {0, 0, 0}
    page_root.init_rot        = {0, 0, 0}
    page_root.level           = MFCD_DEFAULT_LEVEL
    page_root.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
    page_root.controllers     = {{"check_power"},--[[{"apply_brightness"}]]}
    page_root.use_mipfilter   = true
    page_root.additive_alpha  = true
    --page_root.collimated      = false
    Add(page_root)
    return page_root
end

