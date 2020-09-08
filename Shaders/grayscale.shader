shader_type canvas_item;

uniform bool grayscale = false;


void fragment() {
	if (grayscale) {
		COLOR = texture(TEXTURE, UV);
		float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR.rgb = vec3(avg);
	}
	else {
		COLOR = texture(TEXTURE, UV);
	}

}