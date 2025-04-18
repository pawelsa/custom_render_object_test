# Testing writing custom RenderObject

This custom RenderObject should show text, but there are some constraints:
- When it takes at maximum two lines, display normally
- When it takes more than two lines and it has a trailing widget, show widget at right side, and:
  - if shouldExpand is false, show only two lines
  - if shouldExpand is true, show all the text


## Recordings

https://github.com/pawelsa/custom_render_object_test/blob/a63a88dc9dc67f4e03ce630039f6fc58ad9c8d87/recordings/custom_render_object.mov

### Recording with layout borders

https://github.com/pawelsa/custom_render_object_test/blob/a63a88dc9dc67f4e03ce630039f6fc58ad9c8d87/recordings/custom_render_object_with_layout_borders.mov