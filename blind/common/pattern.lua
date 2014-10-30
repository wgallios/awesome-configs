--- A collection of reusable Cairo patterns
local color      = require( "gears.color"    )
local surface    = require( "gears.surface"  )
local cairo      = require( "lgi"            ).cairo

local blind_pat = {sur={},mask={}}

--- Convert a surface to a pattern
function blind_pat.to_pattern(img)
    local pat = cairo.Pattern.create_for_surface(img)
    pat:set_extend(cairo.Extend.REPEAT)
    return pat
end

--- Create a 45 degree stipped pattern
-- @arg col1 the first color
-- @arg col2 the second color (option, will be autogenerated)
-- @arg the pattern height (in pixel)
-- @arg horizontal_repetition number of pixels between lines (default = 4)
-- @arg right to left (default = false)
function blind_pat.sur.flat_grad(col1,col2,height,horizontal_repetition,rtl)
    local pat3,pat4 = color(col1),col2 and color(col2) or nil
    -- If there is only one color, then build the second one
    if not col2 then
        local s,r,g,b,a = pat3:get_rgba()
        pat3 = cairo.Pattern.create_rgb((r-0.1)/3,(g-0.1)/3,(b-0.1)/3)
        pat4 = cairo.Pattern.create_rgb((r-0.1)*1.2,(g-0.1)*1.2,(b-0.1)*1.2)
    end
    local w = horizontal_repetition or 4
    -- The lines need to be aligned by muliples of their horizontal repetition
    local rep = math.floor(height/w)
    local multiple = w*( rep + 1)

    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, w, multiple)
    local cr  = cairo.Context(img)
    cr:set_source(pat3)
    cr:paint()
    cr:set_source(pat4)
    cr:set_antialias(cairo.ANTIALIAS_NONE)
    cr:set_line_width(1)
    for i=0,rep do
        cr:move_to(0,i*4)
        cr:line_to(4,(i+1)*4)
        cr:stroke()
    end
    return img,cr
end

function blind_pat.sur.plain(col,height)
    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 1, height)
    local cr  = cairo.Context(img)
    cr:set_source(color(col))
    cr:paint()
    return img,cr
end

--- Add a 3D effect to a surface
function blind_pat.mask.ThreeD(img,cr)
    local c1,c2 = "#ffffff","#77777755"
    local mixgrad = { type = "linear", from = { 0, 0 }, to = { 0, img:get_height() }, stops = { { 0.2, c1 }, { 1, c2 }}}
    local grabpat = color(mixgrad)
    cr:set_source(grabpat)
    cr:set_operator(cairo.Operator.OVERLAY)
    cr:paint_with_alpha(1)
    return img,cr
end

--- Create thick 45 degree stripes
function blind_pat.sur.thick_stripe(col1,col2,width,height,rtl)
    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, width*2, height)
    local cr  = cairo.Context(img)
    local multiple = math.ceil(height/(width*2))
    cr:set_source(color(col2))
    cr:rectangle(0,0,width*2,height)
    cr:fill()
    cr:set_source(color(col1))
    for i=0,multiple do
        cr:move_to(0,i*width*2)
        cr:line_to(width*2,(i+1)*width*2)
        cr:line_to(2*width+width,(i+1)*width*2)
        cr:line_to(width,(i)*width*2)
        cr:fill()
    end
    return img,cr
end

function blind_pat.mask.triangle()
    --TODO
    --/\/\/\/\/\
    --\/\/\/\/\/
    --/\/\/\/\/\
end

function blind_pat.mask.honeycomb()
    --TODO draw random sized triangles
end

function blind_pat.mask.circles()
    --TODO draw random sized cicles based on the img size
    -- make sure corner cases (literally!) do as expected
end

return blind_pat