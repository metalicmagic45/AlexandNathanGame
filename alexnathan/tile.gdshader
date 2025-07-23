shader_type canvas_item;

uniform float outline_size = 1.0;
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);

	bool is_edge = false;

	if (tex_color.a > 0.1) {
		for (float x = -outline_size; x <= outline_size; x++) {
			for (float y = -outline_size; y <= outline_size; y++) {
				if (x == 0.0 && y == 0.0) continue;

				vec2 offset = vec2(x, y) / TEXTURE_PIXEL_SIZE;
				if (texture(TEXTURE, UV + offset).a <= 0.1) {
					is_edge = true;
				}
			}
		}
	}

	if (is_edge) {
		COLOR = outline_color;
	} else {
		COLOR = tex_color;
	}
}
