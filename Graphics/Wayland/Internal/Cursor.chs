-- | This is client-side code for loading cursor themes. Provided for convenience only.
module Graphics.Wayland.Internal.Cursor (
  CursorTheme, CursorImage, Cursor,

  cursorThemeLoad, cursorThemeDestroy, cursorThemeGetCursor, cursorImageGetBuffer, cursorFrame
  ) where

import Foreign
import Foreign.C.Types
import Foreign.C.String

import Graphics.Wayland.Internal.SpliceClientTypes (Shm(..), Buffer(..))

#include <wayland-cursor.h>

{#context prefix="wl"#}




-- struct wl_cursor_theme;
{#pointer * cursor_theme as CursorTheme newtype#}


-- struct wl_cursor_image {
-- 	uint32_t width;		/* actual width */
-- 	uint32_t height;	/* actual height */
-- 	uint32_t hotspot_x;	/* hot spot x (must be inside image) */
-- 	uint32_t hotspot_y;	/* hot spot y (must be inside image) */
-- 	uint32_t delay;		/* animation delay to next frame (ms) */
-- };
{#pointer * cursor_image as CursorImage newtype#}
-- TODO make its members accessible


-- struct wl_cursor {
-- 	unsigned int image_count;
-- 	struct wl_cursor_image **images;
-- 	char *name;
-- };
{#pointer * cursor as Cursor newtype#}
-- TODO make its members accessible

-- struct wl_shm;

-- struct wl_cursor_theme *
-- wl_cursor_theme_load(const char *name, int size, struct wl_shm *shm);
{#pointer * shm as Shm nocode#}
{#fun unsafe cursor_theme_load as cursorThemeLoad {`String', `Int', `Shm'} -> `CursorTheme'#}

-- void
-- wl_cursor_theme_destroy(struct wl_cursor_theme *theme);
{#fun unsafe cursor_theme_destroy as cursorThemeDestroy {`CursorTheme'} -> `()' #}

-- struct wl_cursor *
-- wl_cursor_theme_get_cursor(struct wl_cursor_theme *theme,
-- 			   const char *name);
{#fun unsafe cursor_theme_get_cursor as cursorThemeGetCursor {`CursorTheme', `String'} -> `Cursor' #}

-- struct wl_buffer *
-- wl_cursor_image_get_buffer(struct wl_cursor_image *image);
{#fun unsafe cursor_image_get_buffer as cursorImageGetBuffer {`CursorImage'} -> `Buffer' Buffer #}

-- int
-- wl_cursor_frame(struct wl_cursor *cursor, uint32_t time);
{#fun unsafe cursor_frame as cursorFrame {`Cursor', `Int'} -> `Int' #}
