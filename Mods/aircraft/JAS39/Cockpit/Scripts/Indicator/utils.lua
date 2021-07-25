Viewport_Align = {
    left   = -1,
    hcenter = 0,
    right  = 1,
    top = 2, 
    vcenter = 3,
    bottom = 4,
  }
  
  MFCD_aspect = 3/4
  UFCP_aspect = 4.52405
  RADIO_aspect = 1.76
  
  -- best_fit_rect(left_top_coord_X, left_top_coord_Y, rect_width, rect_height, align_horizen, align_vertical)
  function best_fit_rect(x, y, w, h, left_center_right, top_or_bottem, orig_aspect)
      local aspect = orig_aspect or 1
      local dx = x
      local dy = y
      local dw = w
      local dh = h
      local _halign = left_center_right or Viewport_Align.hcenter
      local _valign = top_or_bottem or Viewport_Align.vcenter
  
      if (w / h) > aspect then -- adjust wideth for keeping w/h aspect 
          dw = dh * aspect
          dx = x + w/2 - dw/2 -- default align.hcenter
          
          if _halign == Viewport_Align.left then
              dx = x
          else
              if _halign == Viewport_Align.right then
                  dx = x + w - dw
              end
          end
      else -- adjust height for keeping w/h aspect 
          if (w / h) < aspect then
              dh = dw / aspect
              dy = y + h/2 - dh/2 -- default Viewport_Align.vcenter
  
              if _align == Viewport_Align.top then
                  dy = y
              else
                  if _align == Viewport_Align.bottom then
                      dy = y + h - dh
                  end
              end
          end
      end
  
      -- return {x = dx, y = dy, width = dw, height = dh}
      return {dx, dy, dw, dh}
  end
  